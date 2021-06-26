package com.ji.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.net.InetAddress;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ji.cm.CM_Util;
import com.ji.common.DateUtility;
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.HtmlText;
import com.ji.common.JSysException;
import com.ji.common.Param;
import com.ji.common.StringUtil;
import com.ji.dao.PrivacyMngDao;
import com.ji.service.CMService;
import com.ji.service.MAService;
import com.ji.service.MenuService;
import com.ji.service.SiStiService;
import com.ji.vo.MenuVO;
import com.ji.vo.PrivacyMngVO;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * cms MaController 호출 전 처리 부가기능 
 * @author Administrator
 */
public class CmsCheckInterceptor extends HandlerInterceptorAdapter {

	/** 사이트코드 - 공통 */
	private static final String SCODE_COMMON = "000008";

	/** 사이트 - 메인 */
	private static final String SCODE_DEFAULT = "S01";
	
	/** 페이지 - 메인 */
	private static final String PCODE_MAIN = "main";
	/** 페이지 - 에디터 이미지 업로드 */
	private static final String PCODE_EDITOR_IMG_UPLOAD = "000047";
	
	/** 페이지 - 공통파일 업로드 */
	private static final String PCODE_CMFILE_UPLOAD = "000316";	

	/** 가공한 request data 매핑 키 */
	public static final String PARAM_KEY = "_param";
	private final Log log = LogFactory.getLog(getClass());

	/** MAService */
    @Resource(name = "maService")
    private MAService maService;
    
    
	/** CMService */
    @Resource(name = "cmService")
    private CMService cmService; 
    
    /** ASService */
    @Resource(name = "siStiService")
    private SiStiService siStiService;    
    
    
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "privacyMngDao")
    private PrivacyMngDao privacyMngDao;
    
    @Resource(name = "menuService")
    private MenuService menuService; 

    
    /** controller 작업이 끝난 이후 뷰 쪽으로 forward 직전에 실행 */
    // TODO : postHandle
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView model) throws Exception {
//		log.debug("========================== CmsCheckInterceptor postHandle start ==========================");
		if(model!=null){
			setModelDefault(model.getModelMap());
		}
		
//		log.debug("========================== CmsCheckInterceptor postHandle end ==========================");
	}
	/** 뷰 쪽으로 forward 이후에 실행 */
	// TODO : afterCompletion
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object obj, Exception e) throws Exception {
		//do nothing...
	}

/** controller 수행 전 실행 */
// TODO : preHandle
@Override
public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		log.debug("========================== CmsCheckInterceptor preHandle start ==========================");
		String _msg = "";
		String UPLOADROOTPATH = "";
		if(propertiesService.getString("UPLOADROOTPATH","")!=null){
			UPLOADROOTPATH = propertiesService.getString("UPLOADROOTPATH","");
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CONTEXTROOT_REALPATH = "";
		if(propertiesService.getString("CONTEXTROOT_REALPATH","")!=null){
			CONTEXTROOT_REALPATH = propertiesService.getString("CONTEXTROOT_REALPATH","");
		}
		String SYS_ADMIN_CD = "";
		if(propertiesService.getString("SYS_ADMIN_CD","")!=null){
			SYS_ADMIN_CD = propertiesService.getString("SYS_ADMIN_CD","");
		}else{
			SYS_ADMIN_CD = "sysadm";
		}
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SITE_SESSION_FN = "";
		if(propertiesService.getString("SITE_SESSION_FN","")!=null){
			SITE_SESSION_FN = propertiesService.getString("SITE_SESSION_FN","");
		}		
		String SITE_AUTH_SESSION_FN = "";
		if(propertiesService.getString("SITE_AUTH_SESSION_FN","")!=null){
			SITE_AUTH_SESSION_FN = propertiesService.getString("SITE_AUTH_SESSION_FN","");
		}		
		

		
		//취약점보안 header설정 2018.10.10
		String jsessionid = req.getSession().getId();
		res.setHeader("SET-COOKIE","JSESSIONID="+jsessionid+";HttpOnly");
		res.setHeader("cache-control", "no-cache, must-revalidate");
		res.setHeader("expires", "0");
		res.setHeader("pragma", "no-cache");		
		res.setHeader("x-frame-options", "SAMEORIGIN");		//교차 프레임 스크립팅 방어
		res.setHeader("x-content-type-options", "nosniff");	//Missing "X-Content-Type-Options" header
		res.setHeader("x-xss-protection", "1; mode=block");	//Missing "X-XSS-Protection" header
		
		
		/*if(HtmlTag.returnString(req.getHeader("referer"),"").equals("")){
			log.debug("정상적인 접근이 아닙니다 : ");
			_msg = "정상적인 접근이 아닙니다.";
			returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, "top", propertiesService.getString("CON_ROOT","")+"/");	
			
		}*/
		//Map param = (new Param()).setParameter(req);
		Map param = (new Param()).setParameters(req);		
	//try{
		
		
		log.debug("preHandle param============" + param);
		Cookie[] cook_arr = req.getCookies();
		
		//해당 페이지의 번호값 확인
		if(StringUtils.isEmpty((String) param.get("sIdxCheck"))){
			param.put("idxCheck", req.getSession().getAttribute("sIdxCheck")); 
		}

		//제안 페이지의 개인정보 세션저장 
		if(StringUtils.isEmpty((String) param.get("mRegNm"))){ //이름
			param.put("mRegNm", req.getSession().getAttribute("mRegNm")); 
		}
		if(StringUtils.isEmpty((String) param.get("mRegHpNo"))){ //핸드폰번호
			param.put("mRegHpNo", req.getSession().getAttribute("mRegHpNo")); 
		}
		if(StringUtils.isEmpty((String) param.get("mRegEmail"))){ //이메일
			param.put("mRegEmail", req.getSession().getAttribute("mRegEmail")); 
		}
		if(StringUtils.isEmpty((String) param.get("mScretNo"))){ //비밀번호
//			param.put("mScretNo", req.getSession().getAttribute("mScretNo")); 
		}
		
		req.removeAttribute("mScretNo");
		String contentType = req.getContentType();
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		final String uploadtmppath = UPLOADROOTPATH+"/tmpup";
		
		
		String curdate = DateUtility.getToday();
		String curtime = DateUtility.getCurrentTime();	
		Map tmp_map = new HashMap();
		String nextUrl = "";
		String refUrl = null;
		if (refUrl == null){
			refUrl = RESULT_PAGE;
		}
		
		String IP = req.getRemoteAddr()+"";

		
		param.put("REQ_AC_IP", IP);
		param.put("REQ_URL", req.getRequestURL());
		
			//1.파일을 임시 업로드 디렉토리에 저장

			fileSaveTemp(req, res, param, contentType, isMultipart, uploadtmppath, curdate, curtime);
			
			//1.param 기본값 설정
			setParamDefault(req, param, curdate, curtime);
			
			//2.접근 필수 코드(사이트,페이지) 체크
			checkValidAccessCode(req, res, param); 
			
			//log.debug("===================================================");
			//log.debug("getRealPath===>"+req.getSession().getServletContext().getRealPath("/"));request.getServletContext();
			//log.debug("===================================================");
			//param.put("contextRootRealPath",req.getServletContext().getRealPath("/"));
			param.put("contextRootRealPath",CONTEXTROOT_REALPATH);
			
			// 시스템 운영자 정보를 불러온다

			tmp_map = (Map)cmService.getAdmInfo().get("ADMININFO");
			param.put("ADMININFO", tmp_map); //메뉴정보 param에 설정
			req.setAttribute("ADMININFO", param.get("ADMININFO"));			
			
			//4.로그인,로그아웃,세션,권한 관련 처리
			if(((String)param.get("scode")).equals(SYS_ADMIN_CD)){ // 관리자 페이지일 경우
				
				Map SITE_ADM_SESSION = (Map)req.getSession().getAttribute(SITE_ADM_SESSION_FN);
				param.put(SITE_ADM_SESSION_FN,SITE_ADM_SESSION);
				
				//LOG.debug("MAController scode--sysadm:"+param.get("scode")+":"+param.get("pcode"));
				// 관리자페이지 접근일경우 아이피 체크를 넣는다
				//IP체크
				Map rtn_ip_cfg = cmService.getIpCfg(IP);
				
				// 잠시 주석처리
				// 허용된 아이피이면
				InetAddress inet = InetAddress.getLocalHost();
				log.debug("inet.getHostAddress()==>"+inet.getHostAddress());
				
				//CmsCheckinterceptor 실운영 적용시 아래 주석 해제 후 적용 필요 -박현래 20190919
				if(rtn_ip_cfg.get("IPCFG").equals("0")){
					_msg = "접근이 허용된 IP가 아닙니다.";
					returnViewMsgUrlT(RESULT_PAGE, _msg, "top", CON_ROOT+"/");	
				}
				
				// 로그인처리일경우
				if(((String)param.get("pcode")).equals("login")){
					adminLoginAct(req, param);
				// 로그아웃 처리일경우
				}else if(((String)param.get("pcode")).equals("logoff")){
					adminLogoutAct(req, param, cook_arr);
				// 로그인화면이동일경우 기존 로그인 세션을 초기화시킨다.
				}else if(((String)param.get("pcode")).equals("loginF")){
					adminLoginPageMove(req, param, cook_arr);
					
				// 비밀번호 변경
				}else if(((String)param.get("pcode")).equals("login_pin_chg")){
					loginPinChg(req, param);
				// 비밀번호 찾기
				}else if(((String)param.get("pcode")).equals("login_pin_search")){
					//loginPinSearch(req, param);	
					
				// 로그인 인증번호 발송
				}else if(((String)param.get("pcode")).equals("login_pin_authsend")){					

				//그외 페이지
				}else{
					adminAuthCheck(req, param, cook_arr, nextUrl, SITE_ADM_SESSION);
					Map rtn_menu_cfg = cmService.getMenuCfg((String)param.get("scode"), (String)param.get("pcode"));
					tmp_map = (Map)rtn_menu_cfg.get("MENUCFG");
					param.put("MENUCFG", tmp_map); //메뉴정보 param에 설정
					req.setAttribute("MENUCFG", param.get("MENUCFG"));
					
					cmsAccLogInsert(req, param,SITE_ADM_SESSION);
				}
				MenuVO menuVO = new MenuVO();
				menuVO.setMenuCd("sysadm");
				List<MenuVO> siteMap = menuService.selectAdminMenuList(menuVO);
				req.setAttribute("siteMap", siteMap);
			}else{ //일반페이지일경우
				Map SITE_SESSION = (Map)req.getSession().getAttribute(SITE_SESSION_FN);
				param.put(SITE_SESSION_FN,SITE_SESSION);
				Map SITE_ADM_SESSION = (Map)req.getSession().getAttribute(SITE_ADM_SESSION_FN);
				param.put(SITE_ADM_SESSION_FN,SITE_ADM_SESSION);	
				Map SITE_AUTH_SESSION = (Map)req.getSession().getAttribute(SITE_AUTH_SESSION_FN);
				param.put(SITE_AUTH_SESSION_FN,SITE_AUTH_SESSION);					
				// 사용자화면 세션이 있을경우 파라메터에 넣는다
				//param.put(propertiesService.getString("SITE_SESSION_FN",""),SITE_ADM_SESSION);
				
				log.debug("normal page pcode:"+param.get("pcode"));
				
				//로그아웃
				if(((String)param.get("pcode")).equals("logoff")){
					cmsLogoutAct(req, param, cook_arr);
					log.debug("normal page 111111111");
				// 메인 페이지 호출일경우 세션을 체크해서 세션이 없으면 로그인 처리 프로세스를 강제로 태운다
				}else if(((String)param.get("pcode")).equals(PCODE_MAIN)){
					cmsMainPage(req, param, cook_arr);
					//cmsAuthCheck(req,res, param, cook_arr, SITE_SESSION);
					log.debug("normal page 22222222222");
					cmsAccLogInsert(req, param, SITE_SESSION);
				// 로그인처리일경우
				}else if(((String)param.get("pcode")).equals("loginF")){
					LoginPageMove(req, param, cook_arr);
					log.debug("normal page 33333333333");
				}else if(((String)param.get("pcode")).equals("login")){

					cmsLoginAct(req, param, cook_arr);
					log.debug("normal page 4444444444");
				// 비밀번호 변경
				}else if(((String)param.get("pcode")).equals("login_pin_chg")){
					loginPinChg(req, param);
				// 비밀번호 찾기
				}else if(((String)param.get("pcode")).equals("login_pin_search")){
					//loginPinSearch(req, param);				
				
					// 회원가입에서 조직선택 사용 구너한 제외시키기 위해
				//}else if(((String)param.get("pcode")).equals("000246")){
					
					// 그외의 페이지	
				}else{
					cmsAuthCheck(req,res, param, cook_arr, SITE_SESSION);
					Map rtn_menu_cfg = cmService.getMenuCfg((String)param.get("scode"), (String)param.get("pcode"));
					tmp_map = (Map)rtn_menu_cfg.get("MENUCFG");
					log.debug("MENUCFG===>"+tmp_map);
					// 일반페이지의 경우 사이트 코드가 포함되지않은 메뉴일경우 접근을 거부한다
					if(((String)tmp_map.get("mCodes")).indexOf((String)param.get("scode")) < 0){

						//log.debug("request.getRequestURI():"+req.getRequestURI());
						//returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
						// ajax호출의 경우 메시지를 담아서 넘긴다
						if(req.getRequestURI().indexOf("cmsajax.do") > -1){
							log.debug("cmsajax.do from Call");
							Map ajax_rtn_map = new HashMap();
							ajax_rtn_map.put("result", false);
							ajax_rtn_map.put("ajaxSystemCode", "903"); // 로그인에러
							ajax_rtn_map.put("TRS_MSG", "비정상적인 접근입니다."); 
							req.setAttribute("ajaxSystemMap", ajax_rtn_map);

						}else{
							log.debug("cmsajax.do else Call");
							if(HtmlTag.returnString((String)param.get("scode"),"").equals(SCODE_COMMON)){
								returnViewMsgUrlTForce(res, RESULT_PAGE, "비정상적인 접근입니다.", "", "");
							}else{
								returnViewMsgUrlT(RESULT_PAGE, "비정상적인 접근입니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
							}
						}						
					}
					param.put("MENUCFG", tmp_map); //메뉴정보 param에 설정	
					cmsAuthCheck2(req, res, param, cook_arr);
					
					cmsAccLogInsert(req, param, SITE_SESSION);

					req.setAttribute("MENUCFG", param.get("MENUCFG"));
					log.debug("normal page 66666666666");
				}
				
				MenuVO menuVO = new MenuVO();
				menuVO.setMenuCd("S01");
				List<MenuVO> siteMap = menuService.selectMenuList(menuVO);
				req.setAttribute("siteMap", siteMap);
			}
	req.setAttribute(PARAM_KEY, param);
	log.debug("========================== CmsCheckInterceptor preHandle end ==========================");
 	return true;
}
	
	/**
	 * 메뉴설정의 로그인사용여부에 따른 세션체크
	 * @param req
	 * @param res
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsAuthCheck2
	private void cmsAuthCheck2(HttpServletRequest req, HttpServletResponse res, Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException {
		String refUrl;
		String M_OPT = HtmlTag.returnString((String)((Map)param.get("MENUCFG")).get("mOpt"),"");// 메뉴옵션
		String [] M_OPT_ARR	= new String[3];
		M_OPT_ARR		= HtmlText.split2(M_OPT,"::");
		String SITE_SESSION_FN = "";
		if(propertiesService.getString("SITE_SESSION_FN","")!=null){
			SITE_SESSION_FN = propertiesService.getString("SITE_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}		
		
		// 세션이 없을경우 통합인증에서 로그인을 처리할수 있도록한다 공통프로그램은 제외한다
		if ((req.getSession(false) == null || req.getSession().getAttribute(SITE_SESSION_FN) == null ) 
				&& !((String)param.get("scode")).equals(SYS_COMMON_CD)) {
			
			// 회원정보수정 
			if( "000404".equals(param.get("pcode")) ) {
				returnViewMsgUrlT(RESULT_PAGE, "회원전용입니다. 로그인 후 이용해주세요.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253");
			}
			
			// 개발모드인경우
			//if(propertiesService.getString("DEV_MODE","").equals("D")){	
			//if(DEV_MODE.equals("R")){	
			/*	log.debug("개발서브페이지로그인이동:");
				refUrl = propertiesService.getString("JSP_DIR","")+"/cm/" + "CmLogin";
				//new CM_Util().FunctionOut(res, "" , "top.location.href='"+propertiesService.getString("CON_ROOT","")+"/servlet/cmsmain?scode="+param.get("scode")+"&pcode=login&pstate=L&rpcode="+param.get("pcode")+"&rpstate="+param.get("pstate")+"';");
//				return refUrl;
				if(req.getRequestURI().indexOf("cmsajax.do") > -1){
					log.debug("cmsAuthCheck2 cmsajax.do from Call ");
				}else{
					log.debug("cmsajax.do else Call");
					returnView(refUrl);
				}				
				
			// 실운영모드인경우 메인화면으로 넘긴다 현재사용하지않음
			}else if(propertiesService.getString("DEV_MODE","").equals("R")){
			//}else if(DEV_MODE.equals("C")){
				log.debug("실운영모드로그인이동:");
				// 로그인사용 페이지일경우
				if(M_OPT_ARR[0].equals("Y")){
					// 실운영모드에서는 SSO쿠키값이 존재하는지 확인해서 처리한다
					
					// 통합인증이 안되어있으면
					if(HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")).equals("")){
//						model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "통합인증로그인이 필요한 페이지 입니다.");
//						model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//						model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");									
//						return propertiesService.getString("RESULT_PAGE","");
						returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "통합인증로그인이 필요한 페이지 입니다.", "top", propertiesService.getString("CON_ROOT","")+"/");
					// 통합인증이 되어있으면
					}else{
//						model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//						model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//						model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L&rpcode="+param.get("pcode")+"&rpstate="+param.get("pstate")+"&id="+HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")));										
//						return propertiesService.getString("RESULT_PAGE","");										
						returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "통합인증로그인이 필요한 페이지 입니다.", "top", propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L&rpcode="+param.get("pcode")+"&rpstate="+param.get("pstate")+"&id="+HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")));
					}

				// 로그인 없이 가능한 페이지 일경우
				}else{
					
				}
			}*/
		}
	}
	/**
	 * 세션체크
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsAuthCheck
	private void cmsAuthCheck(HttpServletRequest req,HttpServletResponse res, Map param, Cookie[] cook_arr,Map SITE_ADM_SESSION) throws ModelAndViewDefiningException {
		log.debug("cmsAuthCheck      :::::::start");
		
		String nextUrl;
		Map result_map = new HashMap();
		Map paramma = new HashMap();
		Map AuthMap = new HashMap();
		String authC ="N";
		String authU ="N";
		String authD ="N";
		String authA ="N";
		String _msg = "";
		String _url_t = "";
		String _url = "";
		boolean auth = false;
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String scode = HtmlTag.returnString((String)param.get("scode"),"S01");
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}		
		// 세션체크
		// 세션이 없을경우 통합인증에서 로그인을 처리할수 있도록한다
		if(scode.equals("S02")){
			if (req.getSession(false) == null || req.getSession().getAttribute(SITE_ADM_SESSION_FN) == null) {
			 	_msg = "회원사전용 입니다. 로그인이 필요합니다";
				_url_t = "top";
				_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";
				//log.debug("request.getRequestURI():"+req.getRequestURI());
				//returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				// ajax호출의 경우 메시지를 담아서 넘긴다
				if(req.getRequestURI().indexOf("cmsajax.do") > -1){
					log.debug("cmsajax.do from Call");
					result_map.put("result", false);
					result_map.put("ajaxSystemCode", "903"); // 로그인에러
					result_map.put("TRS_MSG", _msg); 
					req.setAttribute("ajaxSystemMap", result_map);

				}else{
					log.debug("cmsajax.do else Call");
					if(HtmlTag.returnString((String)param.get("scode"),"").equals(SCODE_COMMON)){
						returnViewMsgUrlTForce(res, RESULT_PAGE, _msg, "", "");
					}else{
						returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
					}
				}				
			}else{
				if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("SYS_SITE_CD"),"").equals("S02")){
				 	_msg = "회원사전용 입니다. 로그인이 필요합니다";
					_url_t = "top";
					_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";	
					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
						log.debug("cmsajax.do from Call");
						result_map.put("result", false);
						result_map.put("ajaxSystemCode", "903"); // 로그인에러
						result_map.put("TRS_MSG", _msg); 
						req.setAttribute("ajaxSystemMap", result_map);

					}else{
						log.debug("cmsajax.do else Call");
						if(HtmlTag.returnString((String)param.get("scode"),"").equals(SCODE_COMMON)){
							returnViewMsgUrlTForce(res, RESULT_PAGE, _msg, "", "");
						}else{
							returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
						}
					}					
				}else{
					
				}
				
			}
			
		}
		/*
		if (req.getSession(false) == null || req.getSession().getAttribute(propertiesService.getString("SITE_ADM_SESSION_FN","")) == null) {
			 	_msg = "접근이 허용되지 않습니다.";
				_url_t = "top";
				_url = propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";
				//log.debug("request.getRequestURI():"+req.getRequestURI());
				//returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				// ajax호출의 경우 메시지를 담아서 넘긴다
				if(req.getRequestURI().indexOf("cmsajax.do") > -1){
					log.debug("cmsajax.do from Call");
					result_map.put("result", false);
					result_map.put("ajaxSystemCode", "903"); // 로그인에러
					result_map.put("TRS_MSG", _msg); 
					req.setAttribute("ajaxSystemMap", result_map);

				}else{
					log.debug("cmsajax.do else Call");
					if(HtmlTag.returnString((String)param.get("scode"),"").equals(SCODE_COMMON)){
						returnViewMsgUrlTForce(res, propertiesService.getString("RESULT_PAGE",""), _msg, "", "");
					}else{
						returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
					}
				}

		}else{
			String scode = (String)param.get("scode");
			String menu_Cd = (String)param.get("pcode");

				log.debug("SITE_ADM_SESSION >>>>> :  "+SITE_ADM_SESSION);	
				
				if(Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),""),10) > 90){
					_msg = "비밀번호를 변경한지 3개월이 지났습니다. 변경하시고 재로그인해주세요";
					_url_t = "top";
					_url = propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";	
					returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				}
				
				if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"").equals("Y")){
					_msg = "초기비밀번호가 변경되지않았습니다. 변경하시고 재로그인해주세요";
					_url_t = "top";
					_url = propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";	
					returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				}					

		}*/
	log.debug("cmsAuthCheck      :::::::end");
}
	
	/**
	 * 세션체크
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsAuthCheckForce
	private void cmsAuthCheckForce(HttpServletRequest req,HttpServletResponse res, Map param, Cookie[] cook_arr,Map SITE_ADM_SESSION) throws ModelAndViewDefiningException {
		String nextUrl;
		Map result_map = new HashMap();
		Map paramma = new HashMap();
		Map AuthMap = new HashMap();
		String authC ="";
		String authU ="";
		String authD ="";
		String authA ="";
		String _msg = "";
		String _url_t = "";
		String _url = "";
		boolean auth = false;
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}		
		// 세션체크
			// 세션이 없을경우 통합인증에서 로그인을 처리할수 있도록한다
//			if (req.getSession(false) == null || req.getSession().getAttribute(SITE_ADM_SESSION_FN) == null) {
//				 	_msg = "접근이 허용되지 않습니다.";
//					_url_t = "top";
//					_url = CON_ROOT+"/";
//					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
//						result_map.put("result", false);
//						result_map.put("ajaxSystemCode", "901"); // 로그인에러
//						result_map.put("TRS_MSG", _msg); 
//						req.setAttribute("ajaxSystemMap", result_map);
//					}else{					
//						returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
//					}
//			}else{
//
//			}
	}	

	/**
	 * 로그인처리
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws Exception
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsLoginAct
	private void cmsLoginAct(HttpServletRequest req, Map param, Cookie[] cook_arr) throws Exception, ModelAndViewDefiningException {
		Map tmp_map;
		String nextUrl;
		String refUrl;
		Map SITE_SESSION;
		HttpSession session = req.getSession(true);
		String rpcode = HtmlTag.returnString((String)param.get("rpcode"),"");
		String rpstate = HtmlTag.returnString((String)param.get("rpstate"),"");
		String rpidx = HtmlTag.returnString((String)param.get("rpidx"),"");		
		
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SITE_SESSION_FN = "";
		if(propertiesService.getString("SITE_SESSION_FN","")!=null){
			SITE_SESSION_FN = propertiesService.getString("SITE_SESSION_FN","");
		}		
		

		// sso 세션값이 있을경우
		if(session!=null){
			if(session.getAttribute("SSO_ID")!=null){
				param.put("sso_session_val",HtmlTag.returnString((String)session.getAttribute("SSO_ID"),""));
				log.error("sso_session_val::===>"+param.get("sso_session_val"));
			}else{
				log.error("normal login22222===>");
			}
			
		}else{
			log.error("normal login11111===>");
		}
		
		Map rtn_login = maService.getSiteLogin(param);

		// 로그인시 에러가 발생하면 로그인화면으로 보낸다
		if(!((String)rtn_login.get("TRS_MSG")).equals("")){
			
			log.error("login error:"+param.get("pcode"));
			//refUrl = propertiesService.getString("RESULT_PAGE","");			
			//returnViewMsgUrlT("cm/"+param.get("scode")+"/" + "CmMain", "", null, null); //개발,운영동일 로직
			returnViewMsgUrlT(RESULT_PAGE, (String)rtn_login.get("TRS_MSG"), "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253"+"&rpcode="+rpcode+"&rpstate="+rpstate+"&rpidx="+rpidx);
			//returnViewMsgUrlT(RESULT_PAGE, (String)rtn_login.get("TRS_MSG"), "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");			
		// 로그인성공시 사이트세션을 생성후 메인페이지로 이동시킨다
		}else{
			SITE_SESSION = new HashMap();
			
			tmp_map = (Map)rtn_login.get("UserLogin");

			
		    // 사용기간 체크
		    if(Integer.parseInt((String)param.get("curdate")) >= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("useStDt"),"0"))
		    		&& Integer.parseInt((String)param.get("curdate")) <= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("useEndDt"),"99991231"))){
		    }else{
		    	log.error("login chk 1:curdate:"+param.get("curdate")+":useStDt:"+tmp_map.get("useStDt")+":useEndDt:"+tmp_map.get("useEndDt"));
		    	returnViewMsgUrlT(RESULT_PAGE, "사용기간이 만료된 사용자입니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253");			
		    }
		    //log.debug("로그인 : 000000222222222");
		    
		    //log.debug("로그인 : 000000444444444");
		    //log.debug("로그인실패 횟수 체크:chgDtCnt:"+tmp_map.get("loginFailCnt"));
		    
		    // 로그인실패 횟수 체크
		    if(Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("loginFailCnt"),"0")) >= 5){
		    	log.error("login chk 2:loginFailCnt:"+tmp_map.get("loginFailCnt"));
		    	returnViewMsgUrlT(RESULT_PAGE, "로그인을 5번실패하셨습니다. 관리자에게 문의해주세요", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253");			
		    }
		    log.debug("로그인 : 1111111111111111");			
			//LOG.debug("MAController AM_ID--AM_NM--AM_LEVEL:"+rtn_adm_login.get("AM_ID")+":"+rtn_adm_login.get("AM_NM")+":"+rtn_adm_login.get("AM_LEVEL"));
			SITE_SESSION.put("USER_ID",tmp_map.get("userId")); // 아이디
			SITE_SESSION.put("USER_NM",tmp_map.get("userNm")); // 성명

			SITE_SESSION.put("ADMAUTH","N");
			SITE_SESSION.put("ADMIN_LEVEL",tmp_map.get("adminLevel"));//admin_level = 1(전체관리자), 5(부분관리자)
			SITE_SESSION.put("LASTLOGIN",""+DateUtility.getCurrentDateTime("yyyy-MM-dd, HH:mm:ss"));
			SITE_SESSION.put("CHGDTCNT",tmp_map.get("chgDtCnt"));
			SITE_SESSION.put("PASSWDINITYN",tmp_map.get("ipnsInitYn"));	
			SITE_SESSION.put("SYS_SITE_CD",param.get("scode"));// 시스템 코드
			
			
			//session.setAttribute(propertiesService.getString("SITE_SESSION_FN","")+"_"+param.get("scode"), SITE_SESSION);
			if(SITE_SESSION!=null){
				if(propertiesService!=null){
					
					if(SITE_SESSION_FN!=null){
						if(session!=null){
							session.setAttribute(SITE_SESSION_FN, SITE_SESSION);
						}
					}else{
						if(session!=null){
							session.setAttribute("SITE_SESS", SITE_SESSION);
						}
					}					
				}else{
					if(session!=null){
						session.setAttribute("SITE_SESS", SITE_SESSION);
					}
				}
				
			}
			
			
			log.error("login success:SITE_SESSION= "+SITE_SESSION);
			
		    // 초기비밀번호 수정 여부 체크
			String ipnsInitYn = HtmlTag.returnString((String)tmp_map.get("ipnsInitYn"),"N");
		    if(!ipnsInitYn.equals("Y")){
		    	//log.error("login chk 3:ipnsInitYn:"+tmp_map.get("ipnsInitYn"));
		    	returnViewMsgUrlT(RESULT_PAGE, "초기비밀번호가 변경되지않았습니다. 변경하시고 재로그인해주세요", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253"+"&rpcode="+rpcode+"&rpstate="+rpstate+"&rpidx="+rpidx);			
		    }	
		    //log.debug("로그인 : 000000333333333");	
		    /*log.debug("비밀번호 변경일수 체크:chgDtCnt:"+tmp_map.get("chgDtCnt"));
		    log.debug("비밀번호 변경일수 체크:chgDtCnt:"+HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0"));
		    log.debug("비밀번호 변경일수 체크:chgDtCnt:"+Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0")));*/
		    // 비밀번호 변경일수 체크 담당자요청에 의해 주석처리
		    //if((Integer)tmp_map.get("chgDtCnt") > 90){
		    String chgDtCnt = HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0");
		    if(chgDtCnt==null){
		    	chgDtCnt = "0";
		    }else{
			    if(Integer.parseInt(chgDtCnt) > 90){
			    	//log.debug("비밀번호 변경일수 체크:chgDtCnt:"+tmp_map.get("chgDtCnt"));
			    	returnViewMsgUrlT(RESULT_PAGE, "비밀번호를 변경한지 3개월이 지났습니다. 변경하시고 재로그인해주세요", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253"+"&rpcode="+rpcode+"&rpstate="+rpstate+"&rpidx="+rpidx);			
			    }		    	
		    }


		    //pcode가 0으로 시작하는경우만 로그인후 referer로 연결한다.
		    //if( HtmlTag.returnString((String)param.get("refererURL"),"").indexOf("pcode=0") > 0){
		    //	log.error("login success 1:referer");
		    //	returnViewMsgUrlT(RESULT_PAGE, "", "top", HtmlTag.returnString((String)param.get("refererURL"),"").replaceAll("&amp;", "&"));
			//}else 
			if(param.get("rpcode")==null){
				//log.error("login success 2:main");
//				model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//				model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
				returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
			}else{
				if(!HtmlTag.returnString((String)param.get("rpcode"),"").equals("")
						&& !HtmlTag.returnString((String)param.get("rpcode"),"").equals("")){
					//log.error("login success 3:"+param.get("rpcode")+":"+param.get("rpstate")+":"+param.get("rpstate"));
//					model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//					model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode="+param.get("rpcode")+"&pstate="+param.get("rpstate"));
					returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode="+rpcode+"&pstate="+rpstate+"&rpidx="+rpidx);
					
				}else{
					//log.error("login success 4:main");
//					model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//					model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
					returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
					
				}
			}
//			nextUrl = RESULT_PAGE;
			//nextUrl = JSP_ADM_DIR+"/cm/" + "CmMain";
		}
		//LOG.debug("MAController 로그인 nextUrl:"+nextUrl);
	}
	/**
	 * 메인 페이지 호출
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsMainPage
	private void cmsMainPage(HttpServletRequest req, Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException {
		//log.debug("cmsMainPage "+ req.getSession().getAttribute(propertiesService.getString("SITE_ADM_SESSION_FN","")));
		
		//returnView("/cm/"+param.get("scode")+ "/CmMain");
		// 20160519 세션체크 주석
		/*
		// 세션이 없을경우 통합인증에서 로그인을 처리할수 있도록한다
		if (req.getSession(false) == null || req.getSession().getAttribute(propertiesService.getString("SITE_ADM_SESSION_FN","")) == null) {
			log.debug("세션없음:");
			// 개발모드인경우
			if(propertiesService.getString("DEV_MODE","").equals("D")){
			//if(DEV_MODE.equals("R")){
				log.debug("개발모드메인:"+param.get("pcode"));
//				model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//				model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//				model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L");
				returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L");

				//refUrl = "cm/" + "CmLogin";
				//new CM_Util().FunctionOut(res, ""
				//		, "top.location.href='"+CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L';");

			// 실운영모드인경우 SSO로그인처리로 넘긴다
			}else if(propertiesService.getString("DEV_MODE","").equals("R")){
			//}else if(DEV_MODE.equals("C")){
				log.debug("실운영모드메인:"+param.get("pcode"));
				//refUrl = "cm/" + "CmLogin";
				// 실운영모드에서는 SSO쿠키값이 존재하는지 확인해서 처리한다
				
//				model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//				model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
				// 만약 통합인증쿠기값이 없을경우
				if(HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")).equals("")){
//					model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");
					returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/");
				}else{
//					model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L");
					returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&pstate=L");
				}
											
				//new CM_Util().FunctionOut(res, ""
				//		, "top.location.href='"+CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login&id="+HtmlTag.returnCookie(cook_arr,SSO_COOKIE_NM)+"';");							
			}
//			nextUrl = propertiesService.getString("RESULT_PAGE","");
			//throw new JSysException("로그인이 필요합니다.");
		// 세션이 존재하는경우
		}else{	
			//do nothing...
//			log.debug("세션존재:"+param.get("pcode"));
//			model.addAttribute(propertiesService.getString("RESULT_DTO_KEY",""), maService.getListMD(param));
//			model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//			nextUrl = "cm/"+param.get("scode")+"/" + "CmMain";
		}
		*/
	}
	/**
	 * 로그아웃
	 * @param req
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : cmsLogoutAct
	private void cmsLogoutAct(HttpServletRequest req,Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException {
//		String refUrl;
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}		
		// 중부발전 아이피 쿠키값 InitechEamUIP
		// 없으면 
/*		if(HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")).equals("")){
//			model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//			model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//			model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");						
//			return propertiesService.getString("RESULT_PAGE","");
			returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/");
		// 중부 통합인증이 된상태이면 통합인증 아이디로 관리자 권한을 확인해서전체관리자만 접근할수있도록한다.
		}else{*/
			HttpSession session = req.getSession(true);
			session.invalidate();

//			refUrl = propertiesService.getString("RESULT_PAGE","");
			log.debug("logoff 로그아웃  사용자 페이지222");
//			model.addAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//			model.addAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//			model.addAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");
//			return propertiesService.getString("RESULT_PAGE","");
			returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253");
	//	}
	}
	
	
	/**
	 * 관리자 권한 체크
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @param nextUrl
	 * @param SITE_ADM_SESSION
	 * @throws Exception
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : adminAuthCheck
	private void adminAuthCheck(HttpServletRequest req, Map param, Cookie[] cook_arr, String nextUrl, Map SITE_ADM_SESSION) throws Exception, ModelAndViewDefiningException {
		
		log.debug("===== adminAuthCheck start =====");
		
		Map tmp_map = new HashMap();
		Map result_map = new HashMap();
		String refUrl;
		String _msg = "";
		String _url_t = "";
		String _url = "";
		String auth_yn ="";
		String authlog ="";
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SSO_COOKIE_NM = "";
		if(propertiesService.getString("SSO_COOKIE_NM","")!=null){
			SSO_COOKIE_NM = propertiesService.getString("SSO_COOKIE_NM","");
		}	
		String SYS_SITE_CD = "";
		if(propertiesService.getString("SYS_SITE_CD","")!=null){
			SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
		}else{
			SYS_SITE_CD = "sysadm";
		}		
		
		
		// 세션이 없을경우 통합인증에서 로그인을 처리할수 있도록한다
		//log.debug("req.getSession(false)= "+req.getSession(false));
		//log.debug("propertiesService.getString(SITE_ADM_SESSION_FN)= "+propertiesService.getString("SITE_ADM_SESSION_FN",""));
		//log.debug("req.getSession().getAttribute(propertiesService.getString(SITE_ADM_SESSION_FN)= "+req.getSession().getAttribute(propertiesService.getString("SITE_ADM_SESSION_FN","")));
		if (req.getSession(false) == null || req.getSession().getAttribute(SITE_ADM_SESSION_FN) == null) {
			 	_msg = "관리자 전용입니다. 로그인이 필요합니다.";
				_url_t = "top";
				_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";
				//log.debug("request.getRequestURI():"+req.getRequestURI());
				//returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				// ajax호출의 경우 메시지를 담아서 넘긴다
				if(req.getRequestURI().indexOf("cmsajax.do") > -1){
					log.debug("cmsajax.do from Call");
					
					result_map.put("result", false);
					result_map.put("ajaxSystemCode", "903"); // 로그인에러
					result_map.put("TRS_MSG", _msg);
					result_map.put("TRS_URL", _url);
					req.setAttribute("ajaxSystemMap", result_map);
					
				}else{
					log.debug("cmsajax.do else Call");
					// sso 쿠키값이 존재 하는지 확인해서 있으면 로그인처리로 이동시킨다
					Cookie[] cookie_arr = req.getCookies();
					// sso 쿠키값이 없으면 로그인페이지로 이동
					if(HtmlTag.returnCookie(cookie_arr, SSO_COOKIE_NM).equals("")){
					 	_msg = "관리자 전용입니다. 로그인이 필요합니다.";
						_url_t = "top";
						_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";
					// sso 쿠키값이 존재하면 로그인처리 페이지로 이동
					}else{
					 	_msg = "";
						_url_t = "top";
						_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=login";						
					}
					returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
					
				}
				
		}else{
			
			log.debug("adminAuthCheck 관리자 일반 : 세션존재==>"+SITE_ADM_SESSION);
			
			auth_yn = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ADMAUTH"),""); 
			//SITE_ADM_SESSION.put("CHGDTCNT",tmp_map.get("chgDtCnt"));
			//SITE_ADM_SESSION.put("PASSWDINITYN",tmp_map.get("passwdInitYn"));
			
			if(Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("ADMIN_LEVEL"),""),10) > 5){
				log.debug("111111111111111");
				_msg = "관리자 권한이 없는 사용자 입니다. 접근하실수 없습니다";
				_url_t = "top";
				_url = CON_ROOT+"/cmsmain.do?scode="+SYS_SITE_CD+"&pcode=loginF";
				returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
			}
			
			/* 2019.01.14 이성구 수정 비밀번호 변경부분 삭제요청
			 if(Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),""),10) > 90){
				_msg = "비밀번호를 변경한지 3개월이 지났습니다. 변경하시고 재로그인해주세요";
				_url_t = "top";
				_url = propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+propertiesService.getString("SYS_SITE_CD")+"&pcode=loginF";
				returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
			}*/
			
			if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"").equals("Y")){
				_msg = "초기비밀번호가 변경되지않았습니다. 변경하시고 재로그인해주세요";
				_url_t = "top";
				_url = CON_ROOT+"/cmsmain.do?scode="+SYS_SITE_CD+"&pcode=loginF";
				returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
			}			
			
			if(!auth_yn.equals("Y")){
			 	_msg = "접근이 허용되지 않습니다.";
				_url_t = "top";
				_url = CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF";
				returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
			}
			
			
			// 부분관리자권한을 셋팅한다
			if(Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("ADMIN_LEVEL"),"0")) ==5){
				log.debug("AdmSubAuth::===>userId::"+SITE_ADM_SESSION.get("USER_ID"));
				Map adm_sub_auth = cmService.getAdmSubAuth((String)SITE_ADM_SESSION.get("USER_ID"));
				
				req.setAttribute("AdmSubAuth", (List)adm_sub_auth.get("AdmSubAuth"));
				log.debug("AdmSubAuth::===>"+adm_sub_auth.get("AdmSubAuth"));
				
			}else{
				req.setAttribute("AdmSubAuth", null);
				log.debug("AdmSubAuth::===>null");
			}
			
			
			if(!_msg.equals("")){
				//log.debug("request.getRequestURI():"+req.getRequestURI());
				//returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), _msg, _url_t, _url);
				// ajax호출의 경우 메시지를 담아서 넘긴다
				if(req.getRequestURI().indexOf("cmsajax.do") > -1){
					log.debug("cmsajax.do from Call");
					
					result_map.put("result", false);
					result_map.put("ajaxSystemCode", "901"); // 로그인에러
					result_map.put("TRS_MSG", _msg);
					req.setAttribute("ajaxSystemMap", result_map);
				}else{
					log.debug("cmsajax.do else Call");
					returnViewMsgUrlT(RESULT_PAGE, _msg, _url_t, _url);
				}
			}
			
		}
	}
	
	
	
	/**
	 * 관리자 로그인화면 이동
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 * @throws Exception
	 */
	// TODO : adminLoginPageMove
	private void adminLoginPageMove(HttpServletRequest req, Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException, Exception {
		Map tmp_map;
		String refUrl;
		String _msg = "";
		String _url_t = "";
		String _url = "";
		String auth_yn = "";
		String ADMLOG = "";
		
		HttpSession session = req.getSession(true);
		//Map SITE_ADM_SESSION = (Map)session.getAttribute(propertiesService.getString("SITE_ADM_SESSION_FN",""));
		//log.info("SITE_ADM_SESSION     ------->"+SITE_ADM_SESSION);

				
				InetAddress inet = InetAddress.getLocalHost();
				//String IP = inet.getHostAddress();
				String IP = req.getRemoteAddr()+"";
				//IP체크
				// 관리자 페이지 아이피 체크를 해야할 경우 로직
				// 관리자로그인 페이지 이동
				returnView("/cmsadmin/cm/" + "CmLogin");
	}
	
	
	/**
	 * 사용자 로그인화면 이동
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 * @throws Exception
	 */
	// TODO : LoginPageMove
	private void LoginPageMove(HttpServletRequest req, Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException, Exception {
		Map tmp_map;
		String refUrl;
		HttpSession session = req.getSession(true);
		//session.invalidate();
		returnView("/cm/" +param.get("scode")+ "/CmLogin");
	}	
	
	
	/**
	 * 관리자 로그아웃처리
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 * @throws Exception
	 */
	// TODO : adminLogoutAct
	private void adminLogoutAct(HttpServletRequest req, Map param, Cookie[] cook_arr) throws ModelAndViewDefiningException, Exception {
		Map tmp_map;
		String refUrl;
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SSO_COOKIE_NM = "";
		if(propertiesService.getString("SSO_COOKIE_NM","")!=null){
			SSO_COOKIE_NM = propertiesService.getString("SSO_COOKIE_NM","");
		}	
		String SYS_SITE_CD = "";
		if(propertiesService.getString("SYS_SITE_CD","")!=null){
			SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
		}else{
			SYS_SITE_CD = "sysadm";
		}
		String RESULT_MSG_KEY = "";
		if(propertiesService.getString("RESULT_MSG_KEY","")!=null){
			RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY","");
		}		
		
		//  아이피 쿠키값 InitechEamUIP
		// 없으면
		HttpSession session = req.getSession(true);
		if(HtmlTag.returnCookie(cook_arr,SSO_COOKIE_NM).equals("")){
//			req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//			req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//			req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");						
//			return propertiesService.getString("RESULT_PAGE","");
			
			session.invalidate();
			returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");
		// 통합인증이 된상태이면 통합인증 아이디로 관리자 권한을 확인해서전체관리자만 접근할수있도록한다.
		}else{
			session.invalidate();
			returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");
			//param.put("id", HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_NM","")));
			//param.put("admin_chkmode", "OI");// 관리자 체크모드 OI: 아이디로만 체크 IP:아이디,패스워드체크
			//Map rtn_adm_login = cmService.getAdmLogin(param);
			// 에러가 발생한경우
/*			if(!((String)rtn_adm_login.get("TRS_MSG")).equals("")){
				log.debug("logoff 관리자 아님");
				//req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
				//req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
				//req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");
				returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/");
			}else{
				tmp_map = (Map)rtn_adm_login.get("AdmLogin");
				// 전체 관리자인경우 로그인화면을 보여준다
				if(Integer.parseInt(String.valueOf(tmp_map.get("amLevel"))) == 99){
					// 아이피 체크는 실운영에 적용할경우 주석을 해제시킨다
					// 전체 관리자인경우 ip체크를 넣는다
					Map rtn_ip_cfg = cmService.getIpCfg(HtmlTag.returnCookie(cook_arr,propertiesService.getString("SSO_COOKIE_IPNM","")));
					if (Integer.parseInt((String)rtn_ip_cfg.get("IPCFG")) == 0 ) {
						refUrl = propertiesService.getString("RESULT_PAGE","");
						log.debug("logoff 로그아웃 전체관리자 이고 아이피 허용 안됨");
//						req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//						req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//						req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");									
//						return propertiesService.getString("RESULT_PAGE","");
						returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/");
					}else{
						log.debug("logoff 로그아웃  전체관리자 이고 아이피 허용");
//						nextUrl = propertiesService.getString("JSP_ADM_DIR","")+"/cm/" + "CmLogin";
						returnView(propertiesService.getString("JSP_ADM_DIR","")+"/cm/" + "CmLogin");
					}
					
				}else{
					log.debug("logoff 로그아웃 부분관리자임 ");
//					req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "");
//					req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""), "top");
//					req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/");	
//					return propertiesService.getString("RESULT_PAGE","");		
					returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "", "top", propertiesService.getString("CON_ROOT","")+"/");
				}
						
			}*/
			
		}
		req.setAttribute(RESULT_MSG_KEY, "");
	}
	
	
	/**
	 * 관리자 로그인처리
	 * @param req
	 * @param param
	 * @throws Exception
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : adminLoginAct
	private void adminLoginAct(HttpServletRequest req, Map param) throws Exception, ModelAndViewDefiningException {
		log.debug("========== adminLoginAct start ===========");
		
		Map tmp_map;
		Map SITE_ADM_SESSION;
		log.debug("MAController 로그인처리 시작:");
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SSO_COOKIE_NM = "";
		if(propertiesService.getString("SSO_COOKIE_NM","")!=null){
			SSO_COOKIE_NM = propertiesService.getString("SSO_COOKIE_NM","");
		}	
		String SYS_SITE_CD = "";
		if(propertiesService.getString("SYS_SITE_CD","")!=null){
			SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
		}else{
			SYS_SITE_CD = "sysadm";
		}
		String RESULT_MSG_KEY = "";
		if(propertiesService.getString("RESULT_MSG_KEY","")!=null){
			RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY","");
		}		
		
		// sso 쿠키값이 존재 하는지 확인해서 있으면 로그인처리로 이동시킨다
		Cookie[] cookie_arr = req.getCookies();
		// sso 쿠키값이 없으면 로그인페이지로 이동
		if(HtmlTag.returnCookie(cookie_arr, SSO_COOKIE_NM).equals("")){

		// sso 쿠키값이 존재하면 로그인처리 페이지로 이동
		}else{
			Runtime rt = Runtime.getRuntime();
			String sso_cookie_val = HtmlTag.returnCookie(cookie_arr, SSO_COOKIE_NM);
			String sso_cookie_val_decode = "";
		    if (!sso_cookie_val.equals("")) {
		        String Bin_Path = "/Appl/EDportal/seed_decode_aix/seed_decode -d ";      // 암호화 쿠기 복호화 처리 실행 모듈 경로 및 파일명
		        String run_path = Bin_Path + sso_cookie_val;
		        Process ps = rt.exec(run_path+"<BR>");

		        BufferedReader br =
		            new BufferedReader(
		                new InputStreamReader(
		                    new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));

		        sso_cookie_val_decode = br.readLine();

		        br.close();

		        log.error("Result : [" + sso_cookie_val + "][" + sso_cookie_val_decode + "]<br>");
		    }			
		 	param.put("sso_cookie_val", sso_cookie_val_decode);						
		}
		
		Map rtn_login = maService.getSiteLogin(param);
		
		// 로그인시 에러가 발생하면 로그인화면으로 보낸다
		if(!((String)rtn_login.get("TRS_MSG")).equals("")){
			
			log.debug("admin 로그인에러:"+param.get("pcode"));
			//refUrl = propertiesService.getString("RESULT_PAGE","");
			//returnViewMsgUrlT("cm/"+param.get("scode")+"/" + "CmMain", "", null, null); //개발,운영동일 로직
			returnViewMsgUrlT(RESULT_PAGE, (String)rtn_login.get("TRS_MSG"), "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");			
		
		// 로그인성공시 사이트세션을 생성후 메인페이지로 이동시킨다
		}else{
			SITE_ADM_SESSION = new HashMap();
			tmp_map = (Map)rtn_login.get("UserLogin");
			
		    // 사용기간 체크
		    if(Integer.parseInt((String)param.get("curdate")) >= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("useStDt"),"0"))
		    		&& Integer.parseInt((String)param.get("curdate")) <= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("useEndDt"),"99991231"))
		    		){
		    }else{
		    	log.debug("사용기간 체크:curdate:"+param.get("curdate")+":useStDt:"+tmp_map.get("useStDt")+":useEndDt:"+tmp_map.get("useEndDt"));
		    	returnViewMsgUrlT(RESULT_PAGE, "사용기간이 만료된 사용자입니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");			
		    }
		    //log.debug("로그인 : 000000222222222");
		    
		    log.debug("로그인 : 00000000000000000");
		    log.debug("로그인실패 횟수 체크:chgDtCnt:"+tmp_map.get("loginFailCnt"));
	
		    if(Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("loginFailCnt"),"0")) >= 5){
		    	returnViewMsgUrlT(RESULT_PAGE, "로그인을 5번실패하셨습니다. 관리자에게 문의해주세요", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");	
		    }
		    log.debug("로그인 : 1111111111111111");
		    
		    
		    if(Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("adminLevel"),"0")) > 5){
		    	log.debug("관리자권한체크:"+tmp_map.get("adminLevel"));
		    	returnViewMsgUrlT(RESULT_PAGE, "관리자 권한이 없는 사용자 입니다. 접근하실수 없습니다", "top", CON_ROOT+"/cmsmain.do?scode="+propertiesService.getString("SYS_ADMIN_CD")+"&pcode=loginF");			
		    }
		    
		    
			//LOG.debug("MAController AM_ID--AM_NM--AM_LEVEL:"+rtn_adm_login.get("AM_ID")+":"+rtn_adm_login.get("AM_NM")+":"+rtn_adm_login.get("AM_LEVEL"));
			SITE_ADM_SESSION.put("USER_ID",tmp_map.get("userId")); // 아이디
			SITE_ADM_SESSION.put("USER_NM",tmp_map.get("userNm"));// 성명
			SITE_ADM_SESSION.put("ORG_CD",tmp_map.get("orgCd"));// 조직코드
			SITE_ADM_SESSION.put("ORG_NM",tmp_map.get("orgNm"));// 조직코드

			SITE_ADM_SESSION.put("ADMAUTH","Y");
			SITE_ADM_SESSION.put("ADMIN_LEVEL",tmp_map.get("adminLevel"));//admin_level = 1(전체관리자), 5(부분관리자)
			SITE_ADM_SESSION.put("LASTLOGIN",""+DateUtility.getCurrentDateTime("yyyy-MM-dd, HH:mm:ss"));
			
			SITE_ADM_SESSION.put("CHGDTCNT",tmp_map.get("chgDtCnt"));
			SITE_ADM_SESSION.put("PASSWDINITYN",tmp_map.get("ipnsInitYn"));
			SITE_ADM_SESSION.put("SYS_SITE_CD",propertiesService.getString("SYS_ADMIN_CD","sysadm"));// 관리자시스템 코드
			
			
			HttpSession session = req.getSession(true);
			session.setAttribute(SITE_ADM_SESSION_FN, SITE_ADM_SESSION);
			
			log.debug("로그인성공:SITE_ADM_SESSION= "+SITE_ADM_SESSION);
			
		    // 초기비밀번호 수정 여부 체크
		    if(!HtmlTag.returnString((String)tmp_map.get("ipnsInitYn"),"N").equals("Y")){
		    	log.debug("초기비밀번호 수정 여부 체크:ipnsInitYn:"+tmp_map.get("ipnsInitYn"));
		    	returnViewMsgUrlT(RESULT_PAGE, "초기비밀번호가 변경되지않았습니다. 변경하시고 재로그인해주세요", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");			
		    }	
		    log.debug("로그인 : 000000333333333");	
		    log.debug("비밀번호 변경일수 체크:chgDtCnt:"+tmp_map.get("chgDtCnt"));
		    /*log.debug("비밀번호 변경일수 체크:chgDtCnt:"+HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0"));
		    log.debug("비밀번호 변경일수 체크:chgDtCnt:"+Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0")));*/
		    // 비밀번호 변경일수 체크
		    //if((Integer)tmp_map.get("chgDtCnt") > 90){
		    /* 2019.01.14 이성구 수정 비밀번호 변경부분 삭제요청
		    if(Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("chgDtCnt"),"0")) > 90){
		    	log.debug("비밀번호 변경일수 체크:chgDtCnt:"+tmp_map.get("chgDtCnt"));
		    	returnViewMsgUrlT(propertiesService.getString("RESULT_PAGE",""), "비밀번호를 변경한지 3개월이 지났습니다. 변경하시고 재로그인해주세요", "top", propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");			
		    }	*/		

			if(param.get("rpcode")==null){
				log.debug("로그인성공:메인");
				returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
			
			}else{
				log.debug("로그인성공:"+param.get("rpcode")+":"+param.get("rpstate"));
				returnViewMsgUrlT(RESULT_PAGE, "", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode="+param.get("rpcode")+"&pstate="+param.get("rpstate"));
			
			}
			log.debug("로그인 : 33333333333333333");
//			nextUrl = propertiesService.getString("RESULT_PAGE","");
			//nextUrl = JSP_ADM_DIR+"/cm/" + "CmMain";
		}
		

	}
	
	
	/**
	 * 로그인 비밀번호 수정
	 * @param req
	 * @param param
	 * @throws Exception
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : loginPinChg
	private void loginPinChg(HttpServletRequest req, Map param) throws Exception, ModelAndViewDefiningException {
		Map tmp_map;
		log.debug("loginPinChg 처리 시작:");
		String SITE_ADM_SESSION_FN = "";
		if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
			SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
		}
		String SITE_SESSION_FN = "";
		if(propertiesService.getString("SITE_SESSION_FN","")!=null){
			SITE_SESSION_FN = propertiesService.getString("SITE_SESSION_FN","");
		}		
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD = SCODE_COMMON;
		}
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		String SSO_COOKIE_NM = "";
		if(propertiesService.getString("SSO_COOKIE_NM","")!=null){
			SSO_COOKIE_NM = propertiesService.getString("SSO_COOKIE_NM","");
		}	
		String SYS_SITE_CD = "";
		if(propertiesService.getString("SYS_SITE_CD","")!=null){
			SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
		}else{
			SYS_SITE_CD = "sysadm";
		}
		String RESULT_MSG_KEY = "";
		if(propertiesService.getString("RESULT_MSG_KEY","")!=null){
			RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY","");
		}
		
		Map SITE_SESSION = (Map)req.getSession().getAttribute(SITE_SESSION_FN);
		Map SITE_ADM_SESSION = (Map)req.getSession().getAttribute(SITE_ADM_SESSION_FN);
		
		String scode = HtmlTag.returnString((String)param.get("scode"),"");
		
		if(!scode.equals("sysadm") && SITE_SESSION != null){
			if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_SESSION.get("CHGDTCNT"),"0")) > 90 
	    			|| !HtmlTag.returnString((String)SITE_SESSION.get("PASSWDINITYN"),"N").equals("Y") || HtmlTag.returnString((String)param.get("pcode"),"").equals("login_pin_chg") ) ){
				param.put("SITE_SESSION", SITE_SESSION);
				Map rtn_login = maService.loginPinChg(param);
				//log.debug("loginPinChg rtn_login::==>"+rtn_login);
				if(((String)rtn_login.get("TRS_MSG")).equals("")){
					SITE_SESSION.put("CHGDTCNT","0");
					SITE_SESSION.put("PASSWDINITYN","Y");
					HttpSession session = req.getSession(true);
					session.setAttribute(SITE_SESSION_FN, SITE_SESSION);				
					log.debug("loginPinChg 정상변경");
					returnViewMsgUrlT(RESULT_PAGE, "비밀번호가 변경되었습니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
				}else{
					log.debug("loginPinChg 실패"+(String)rtn_login.get("TRS_MSG"));
					returnViewMsgUrlT(RESULT_PAGE, ""+(String)rtn_login.get("TRS_MSG"), "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=000253");
				}
			}
		}
		
		if(scode.equals("sysadm") && SITE_ADM_SESSION != null){
			int CHGDTCNT = 0;
			if(SITE_ADM_SESSION.get("CHGDTCNT")!=null){
				CHGDTCNT = Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),"0"));
			}else{
				CHGDTCNT = 0;
			}
			
			if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"").equals("") && (CHGDTCNT > 90 
	    			|| !HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"N").equals("Y") || HtmlTag.returnString((String)param.get("pcode"),"").equals("login_pin_chg") ) ){
				param.put("SITE_ADM_SESSION", SITE_ADM_SESSION);
				Map rtn_login = maService.loginPinChg(param);
				//log.debug("loginPinChg rtn_login::==>"+rtn_login);
				if(((String)rtn_login.get("TRS_MSG")).equals("")){
					SITE_ADM_SESSION.put("CHGDTCNT","0");
					SITE_ADM_SESSION.put("PASSWDINITYN","Y");
					HttpSession session = req.getSession(true);
					session.setAttribute(SITE_ADM_SESSION_FN, SITE_ADM_SESSION);				
					log.debug("loginPinChg 정상변경");
					returnViewMsgUrlT(RESULT_PAGE, "비밀번호가 변경되었습니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main");
				}else{
					log.debug("loginPinChg 실패"+(String)rtn_login.get("TRS_MSG"));
					returnViewMsgUrlT(RESULT_PAGE, ""+(String)rtn_login.get("TRS_MSG"), "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");
				}
				
			// 비밀번호 변경조건이 안되면 메시지를 처리한다
			}else{
				log.debug("loginPinChg 비정상적접근:");
				returnViewMsgUrlT(RESULT_PAGE, "비정상적인 접근입니다.", "top", CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=loginF");
			}
		}

	}
	
	
	/**
	 * 로그인 비밀번호 찾기
	 * @param req
	 * @param param
	 * @throws Exception
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : loginPinSearch
	private void loginPinSearch(HttpServletRequest req, Map param) throws Exception, ModelAndViewDefiningException {
		Map tmp_map;
		log.debug("loginPinSearch 처리 시작:");
		
			Map rtn_login = maService.loginPinSearch(param);
		
	}
	

	
	
	/**
	 * model에 기본설정값 셋팅 (CmCommon.jsp에서 해당 attribute값들을 사용 --> 추후 상수클래스 이용 개선시 셋팅 불필요)
	 * @param model
	 */
	// TODO : setModelDefault
	private void setModelDefault(ModelMap model) {
		// 환경설정값을 셋팅한다
		String CON_ROOT = "";
		String CON_ROOT_SVL = "";
		String IMG_DIR = "";
		String IMG_ADM_DIR = "";
		String JSP_ADM_DIR = "";
		
		String JSP_DIR = "";
		String RESULT_PAGE = "";
		String SYS_ENCODING = "";
		String CAL_POP_W = "";
		String CAL_POP_H = "";
		
		String CONTEXTROOT_REALPATH = "";
		String UPLOADROOTPATH = "";
		String MAXUPLOAD = "";
		String UPLOADCNT = "";
		
		String DEV_MODE = "";
		String SITE_ADM_SESSION_FN = "";
		String SITE_SESSION_FN = "";
		
    	String RESULT_DTO_KEY = "";
    	String RESULT_MSG_KEY = "";
    	String RESULT_URL_KEY = "";
    	String RESULT_URL_T_KEY = "";
    	String RESULT_URL_R_KEY = "";  
    	String RESULT_URL_F_KEY = ""; 
    	String RESULT_STA_KEY = "";
    	String SSO_COOKIE_NM = "";
    	String SSO_COOKIE_IPNM = "";
    	
    	String SYS_ADMIN_CD = "";
    	String SYS_COMMON_CD = "";
    	String SYS_SITE_CD = "";  	
    	
    	String FORWARD_SUCCESS = "";
    	String FORWARD_FAILURE = "";
    	String FORWARD_CONFIRM = ""; 
    	String FORWARD_SYS_FAILURE = "";  
    	
    	String MSIS_ITEM_IMG_PATH = "";  
    	String MSIS_REPR_IMG_PATH = "";     	
		
		if(propertiesService!=null){
			if(propertiesService.getString("CON_ROOT","")!=null){
				CON_ROOT = propertiesService.getString("CON_ROOT","");
			}		
			if(propertiesService.getString("CON_ROOT_SVL","")!=null){
				CON_ROOT_SVL = propertiesService.getString("CON_ROOT_SVL","");
			}			
			if(propertiesService.getString("IMG_DIR","")!=null){
				IMG_DIR = propertiesService.getString("IMG_DIR","");
			}
			if(propertiesService.getString("IMG_ADM_DIR","")!=null){
				IMG_ADM_DIR = propertiesService.getString("IMG_ADM_DIR","");
			}			
			if(propertiesService.getString("JSP_ADM_DIR","")!=null){
				JSP_ADM_DIR = propertiesService.getString("JSP_ADM_DIR","");
			}	
			
			if(propertiesService.getString("JSP_DIR","")!=null){
				JSP_DIR = propertiesService.getString("JSP_DIR","");
			}				
			if(propertiesService.getString("RESULT_PAGE","")!=null){
				RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
			}			
			if(propertiesService.getString("SYS_ENCODING","")!=null){
				SYS_ENCODING = propertiesService.getString("SYS_ENCODING","");
			}			
			if(propertiesService.getString("CAL_POP_W","")!=null){
				CAL_POP_W = propertiesService.getString("CAL_POP_W","");
			}			
			if(propertiesService.getString("CAL_POP_H","")!=null){
				CAL_POP_H = propertiesService.getString("CAL_POP_H","");
			}
			
			if(propertiesService.getString("CONTEXTROOT_REALPATH","")!=null){
				CONTEXTROOT_REALPATH = propertiesService.getString("CONTEXTROOT_REALPATH","");
			}				
			if(propertiesService.getString("UPLOADROOTPATH","")!=null){
				UPLOADROOTPATH = propertiesService.getString("UPLOADROOTPATH","");
			}			
			if(propertiesService.getString("MAXUPLOAD","")!=null){
				MAXUPLOAD = propertiesService.getString("MAXUPLOAD","");
			}			
			if(propertiesService.getString("UPLOADCNT","")!=null){
				UPLOADCNT = propertiesService.getString("UPLOADCNT","");
			}
			
			if(propertiesService.getString("DEV_MODE","")!=null){
				DEV_MODE = propertiesService.getString("DEV_MODE","");
			}				
			if(propertiesService.getString("SITE_ADM_SESSION_FN","")!=null){
				SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN","");
			}			
			if(propertiesService.getString("SITE_SESSION_FN","")!=null){
				SITE_SESSION_FN = propertiesService.getString("SITE_SESSION_FN","");
			}

			if(propertiesService.getString("RESULT_DTO_KEY","")!=null){
				RESULT_DTO_KEY = propertiesService.getString("RESULT_DTO_KEY","");
			}				
			if(propertiesService.getString("RESULT_MSG_KEY","")!=null){
				RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY","");
			}			
			if(propertiesService.getString("RESULT_URL_KEY","")!=null){
				RESULT_URL_KEY = propertiesService.getString("RESULT_URL_KEY","");
			}			
			if(propertiesService.getString("RESULT_URL_T_KEY","")!=null){
				RESULT_URL_T_KEY = propertiesService.getString("RESULT_URL_T_KEY","");
			}			
			if(propertiesService.getString("RESULT_URL_R_KEY","")!=null){
				RESULT_URL_R_KEY = propertiesService.getString("RESULT_URL_R_KEY","");
			}
			if(propertiesService.getString("RESULT_URL_F_KEY","")!=null){
				RESULT_URL_F_KEY = propertiesService.getString("RESULT_URL_F_KEY","");
			}				
			if(propertiesService.getString("RESULT_STA_KEY","")!=null){
				RESULT_STA_KEY = propertiesService.getString("RESULT_STA_KEY","");
			}			
			if(propertiesService.getString("SSO_COOKIE_NM","")!=null){
				SSO_COOKIE_NM = propertiesService.getString("SSO_COOKIE_NM","");
			}			
			if(propertiesService.getString("SSO_COOKIE_IPNM","")!=null){
				SSO_COOKIE_IPNM = propertiesService.getString("SSO_COOKIE_IPNM","");
			}			

			if(propertiesService.getString("SYS_ADMIN_CD","")!=null){
				SYS_ADMIN_CD = propertiesService.getString("SYS_ADMIN_CD","");
			}else{
				SYS_ADMIN_CD = "sysadm";
			}
			if(propertiesService.getString("SYS_COMMON_CD","")!=null){
				SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
			}else{
				SYS_COMMON_CD =SCODE_COMMON;
			}			
			if(propertiesService.getString("SSO_COOKIE_IPNM","")!=null){
				SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
			}else{
				SYS_SITE_CD =SCODE_DEFAULT;
			}	 

			if(propertiesService.getString("FORWARD_SUCCESS","")!=null){
				FORWARD_SUCCESS = propertiesService.getString("FORWARD_SUCCESS","");
			}				
			if(propertiesService.getString("FORWARD_FAILURE","")!=null){
				FORWARD_FAILURE = propertiesService.getString("FORWARD_FAILURE","");
			}			
			if(propertiesService.getString("FORWARD_CONFIRM","")!=null){
				FORWARD_CONFIRM = propertiesService.getString("FORWARD_CONFIRM","");
			}			
			if(propertiesService.getString("FORWARD_SYS_FAILURE","")!=null){
				FORWARD_SYS_FAILURE = propertiesService.getString("FORWARD_SYS_FAILURE","");
			}	
		
			if(propertiesService.getString("MSIS_ITEM_IMG_PATH","")!=null){
				MSIS_ITEM_IMG_PATH = propertiesService.getString("MSIS_ITEM_IMG_PATH","");
			}			
			if(propertiesService.getString("MSIS_REPR_IMG_PATH","")!=null){
				MSIS_REPR_IMG_PATH = propertiesService.getString("MSIS_REPR_IMG_PATH","");
			}			
		}
		
    	model.addAttribute("CON_ROOT", CON_ROOT);
    	model.addAttribute("CON_ROOT_SVL", CON_ROOT_SVL);
    	model.addAttribute("IMG_URL", CON_ROOT+IMG_DIR); // /images
    	model.addAttribute("IMG_ADM_URL", CON_ROOT+IMG_ADM_DIR); // /images/cmsadmin
    	model.addAttribute("JSP_ADM_DIR", JSP_ADM_DIR);
    	
    	model.addAttribute("JSP_DIR", JSP_DIR);
    	model.addAttribute("RESULT_PAGE", RESULT_PAGE);
    	model.addAttribute("SYS_ENCODING", SYS_ENCODING); // utf-8
    	model.addAttribute("CAL_POP_W", CAL_POP_W); // 200
    	model.addAttribute("CAL_POP_H", CAL_POP_H); // 185
    	
    	model.addAttribute("CONTEXTROOT_REALPATH",CONTEXTROOT_REALPATH);
    	model.addAttribute("DOCSAVE_ROOT", UPLOADROOTPATH);
    	model.addAttribute("MAXUPLOAD", MAXUPLOAD);
    	model.addAttribute("UPLOADCNT", UPLOADCNT);
    	
    	model.addAttribute("DEV_MODE", DEV_MODE); // 개발환경여부 D:개발 R:실운영
    	model.addAttribute("SITE_ADM_SESSION_FN", SITE_ADM_SESSION_FN);
    	model.addAttribute("SITE_SESSION_FN", SITE_SESSION_FN); 
    	
    	model.addAttribute("RESULT_DTO_KEY", RESULT_DTO_KEY);
    	model.addAttribute("RESULT_MSG_KEY", RESULT_MSG_KEY);
    	model.addAttribute("RESULT_URL_KEY", RESULT_URL_KEY);
    	model.addAttribute("RESULT_URL_T_KEY", RESULT_URL_T_KEY);
    	model.addAttribute("RESULT_URL_R_KEY", RESULT_URL_R_KEY);  
    	model.addAttribute("RESULT_URL_F_KEY", RESULT_URL_F_KEY); 
    	model.addAttribute("RESULT_STA_KEY", RESULT_STA_KEY); 
    	model.addAttribute("SSO_COOKIE_NM", SSO_COOKIE_NM); 
    	model.addAttribute("SSO_COOKIE_IPNM", SSO_COOKIE_IPNM); 
    	
    	model.addAttribute("SYS_ADMIN_CD", SYS_ADMIN_CD); // 시스템 관리자 코드
    	model.addAttribute("SYS_COMMON_CD", SYS_COMMON_CD); // 시스템 공통 코드
    	model.addAttribute("SYS_SITE_CD", SYS_SITE_CD); // 시스템 기본 사이트코드
    	
    	model.addAttribute("FORWARD_SUCCESS", FORWARD_SUCCESS); 
    	model.addAttribute("FORWARD_FAILURE", FORWARD_FAILURE); 
    	model.addAttribute("FORWARD_CONFIRM", FORWARD_CONFIRM); 
    	model.addAttribute("FORWARD_SYS_FAILURE", FORWARD_SYS_FAILURE); 
    	
    	model.addAttribute("MSIS_ITEM_IMG_PATH", MSIS_ITEM_IMG_PATH); 
    	model.addAttribute("MSIS_REPR_IMG_PATH", MSIS_REPR_IMG_PATH); 
	}
	
	
	/**
	 * 접근 필수 코드(사이트,페이지) 체크
	 * @param req
	 * @param res
	 * @param param
	 * @throws IOException
	 * @throws ModelAndViewDefiningException 
	 */
	// TODO : checkValidAccessCode
	private void checkValidAccessCode(HttpServletRequest req, HttpServletResponse res, Map param) throws Exception, ModelAndViewDefiningException {
		// 넘어온 파라메터를 기준으로 메뉴 환경설정을 불러온다
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}	
		String SYS_SITE_CD = "";
		if(propertiesService.getString("SYS_SITE_CD","")!=null){
			SYS_SITE_CD = propertiesService.getString("SYS_SITE_CD","");
		}else{
			SYS_SITE_CD =SCODE_DEFAULT;
		}		
		// scode : 사이트코드, pcode : 페이지코드
		if(((String)param.get("scode")).equals("") || ((String)param.get("pcode")).equals("")){
//				refUrl = propertiesService.getString("RESULT_PAGE","");
				log.debug("checkValidAccessCode111 [scode:"+param.get("scode")+":pcode:"+param.get("pcode")+"]");
				//new CM_Util().FunctionOut(res, "정상적인 접근이 아닙니다2"
				//		, "top.location.href='"+CON_ROOT+"/servlet/cmsmain?scode="+sys_site_cd+"&pcode=main&pstate=L';");
//				req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "정상적인 접근이 아닙니다");
//				req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""),"top");
//				req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), propertiesService.getString("CON_ROOT","")+"/cmsmain.do?scode="+propertiesService.getString("SYS_SITE_CD","S01")+"&pcode=main");					
				//res.sendRedirect(propertiesService.getString("RESULT_PAGE",""));
				returnViewMsgUrlT(RESULT_PAGE,"정상적인 접근이 아닙니다","top",CON_ROOT+"/cmsmain.do?scode="+SYS_SITE_CD+"&pcode=main"); //필수코드 누락
				
				//LOG.debug("MAController JSysException:scode:"+param.get("scode")+":pcode:"+param.get("pcode"));
				//throw new JSysException("정상적인 접근이 아닙니다2");
		}else{
			log.debug("checkValidAccessCode222 [scode:"+param.get("scode")+":pcode:"+param.get("pcode")+"]");
		}
	}
	
	
	/**
	 * param 기본값 설정
	 * @param req
	 * @param param
	 * @param curdate
	 * @param curtime
	 */
	// TODO : setParamDefault
	private void setParamDefault(HttpServletRequest req, Map param, String curdate, String curtime) {
		// 현재 일자를 파라메터에 추가한다
		String SYS_ADMIN_CD = "";
		if(propertiesService.getString("SYS_ADMIN_CD","")!=null){
			SYS_ADMIN_CD = propertiesService.getString("SYS_ADMIN_CD","");
		}else{
			SYS_ADMIN_CD = "sysadm";
		}
		String SYS_COMMON_CD = "";
		if(propertiesService.getString("SYS_COMMON_CD","")!=null){
			SYS_COMMON_CD = propertiesService.getString("SYS_COMMON_CD","");
		}else{
			SYS_COMMON_CD =SCODE_COMMON;
		}		
		param.put("curdate", curdate);
		param.put("curtime", curtime);
		param.put("SYS_ADMIN_CD", SYS_ADMIN_CD);
		param.put("SYS_COMMON_CD", SYS_COMMON_CD);
					
		
		// 파라메터에 담긴 내용을 HttpServletRequest에 다시 담는다 - ???
		Iterator ir  = param.keySet().iterator();
		String mkey = "";
		while(ir.hasNext()){
			mkey = (String)ir.next();
			//log.debug("MAController PARAMETER--"+mkey+":"+param.get(mkey));
			req.setAttribute(mkey, param.get(mkey));
		}
		
		// 초기 파라메터가 없을경우 기본사이트 메인으로 파라메터를 강제 셋팅한다
		if(param.get("scode")==null){
			param.put("scode", SCODE_DEFAULT);
			req.setAttribute("scode", param.get("scode"));
		}
		
		if(param.get("pcode")==null){
			param.put("pcode", PCODE_MAIN);
			req.setAttribute("pcode", param.get("pcode"));
		}
	}
	
	/**
	 * 접근로그 저장
	 * @param req
	 * @param param
	 * @param cook_arr
	 * @throws ModelAndViewDefiningException
	 */
	private void cmsAccLogInsert(HttpServletRequest req, Map param,Map SITE_ADM_SESSION) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		/*DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = transactionManager.getTransaction(txcDefinition);*/
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String SS_orgNm = "";
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}
		Map result_map = new HashMap();
		try{
					log.debug("cmsAccLogInsert 0000000000000000");
					if(SITE_ADM_SESSION!=null){
						param.put("cms_emp_id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
						param.put("cms_org_id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_CD"),""));
						SS_orgNm = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_NM"),"");						
					}else{
						param.put("cms_emp_id", "guest");
						param.put("cms_org_id", "");
						SS_orgNm = "";							
					}

					String pcode = HtmlTag.returnString((String)param.get("pcode"),"");
					String jqGrid_oper = HtmlTag.returnString((String)param.get("jqGrid.oper"),"");

					log.debug("cmsAccLogInsert 111111111111111");
					param.put("cms_state", "L");
					param.put("cms_pstate", pstate);
					if(jqGrid_oper.indexOf("excel") > -1){
						param.put("aces_log_desc", "excel");
					}else{
						param.put("aces_log_desc", "");
					}
					
					
					param.put("cms_stdinfo_cd", "1");
					log.debug("cmsAccLogInsert 222222222222222");
					if(pstate.length() <= 3){
						//등록 폼 검사
						if(pstate.indexOf("F") > -1 || pstate.indexOf("X") > -1){
							if(pstate.indexOf("X2") > -1) { //상세보기일 때 shin
								 //지원사업 아이디어 제안관리, JIT_BOARD_PROPOSAL,, menuCd = 000525
								 //연구개발 아이디어 제안관리, JIT_BOARD_PROPOSAL,, menuCd = 000191
								 //중소기업제품관관리  상세보기 일때 <글번호, 글제목 넣어야함>  JIT_MSC_PROD  menuCd = 000522
								 //여기있는 제목 번호  JIT8100 여기에 인서트해야함.
								 Map menuMap = (Map) param.get("MENUCFG");
								 String menuCd = (String) menuMap.get("menuCd");
								 
								 //지원사업, 연구개발
								 if(menuCd.indexOf("000525") > -1 || menuCd.indexOf("000191") > -1) {
									 String dataSeq = (String) param.get("seldata_seqno"); //461
									 log.debug(dataSeq);
									 PrivacyMngVO privacyMngVO = new PrivacyMngVO();
									 privacyMngVO.setDataSeq(dataSeq);
									 PrivacyMngVO resultVO = privacyMngDao.selectBoardDetail(privacyMngVO);
									 param.put("privacy_data_title", resultVO.getDataTitle());
									 param.put("privacy_data_seq", resultVO.getDataSeq());
									 param.put("privacy_data_regNm", resultVO.getRegNm());
								 //중소기업제품관관리
								 } else if(menuCd.indexOf("000522") > -1) {
									 String dataSeq = (String) param.get("selprod_seq1"); //1791
									 log.debug(dataSeq);
									 PrivacyMngVO privacyMngVO = new PrivacyMngVO();
									 privacyMngVO.setDataSeq(dataSeq);
									 PrivacyMngVO resultVO = privacyMngDao.selectProductBoardDetail(privacyMngVO);
									 param.put("privacy_data_title", resultVO.getDataTitle());
									 param.put("privacy_data_seq", resultVO.getDataSeq());
									 param.put("privacy_data_regNm", resultVO.getRegNm());
								 }
							 }
						}else{
							if(pstate.indexOf("C")  > -1){
								 param.put("cms_state", "C");

							 }else if(pstate.indexOf("U")  > -1){
								 param.put("cms_state", "U");

							 }else if(pstate.indexOf("D")  > -1){
								 param.put("cms_state", "D");

							 }else if(pstate.indexOf("R")  > -1){
								 param.put("cms_state", "R");

							 }
						}
				    }
					log.debug("cmsAccLogInsert 333333333333333");

					

					// 접근불가
					/*result_map = cmDAO.getformData(param,"cmDAO.selectSmMenuCd"); 	
					if(!HtmlTag.isNull(result_map.get("ViewMap")) ){
						Map temp_map = (HashMap)result_map.get("ViewMap");
						String[] menu_cd_arr = ((String)temp_map.get("menu_cd")).split(",");
						if(!"N".equals(SS_doseoNm) && CM_Util.isTargetValInArray(pcode, menu_cd_arr)){							
							throw new JSysException("접근이 허용되지 않습니다.");															
						}
					}*/

			/*		if(pstate.indexOf("CF") != 0 &&  pstate.length() <= 3){
						 if(pstate.indexOf("C")  > -1){
							 param.put("state", "C");
						 }
					//수정검사
					}else if(pstate.indexOf("UF") != 0  &&  pstate.length() <= 3){
						if(pstate.indexOf("U")  > -1){
							param.put("state", "U");
						}
					}else if(pstate.length() <= 3){
						if(pstate.indexOf("D")  > -1){
							param.put("state", "D");
						}
					}*/
					

					siStiService.insertAS(param);

				}catch(JSysException q){				
					String errMsg = CM_Util.nullToDefault("접근이 허용되지 않습니다.","접근이 허용되지 않습니다.");
					String beforeURL = (String)req.getHeader("Referer");	//바로 이전 URL

					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
						result_map.put("result", false);
						result_map.put("ajaxSystemCode", "901"); // 로그인에러
						result_map.put("TRS_MSG", errMsg); 
						req.setAttribute("ajaxSystemMap", result_map);
						log.debug("cmsAccLogInsert "+errMsg);
					}else{					
						log.debug("cmsAccLogInsert "+errMsg);
						returnViewMsgUrlT(RESULT_PAGE, errMsg, "top", beforeURL);
					}	
				}catch(NullPointerException q){
					String errMsg = CM_Util.nullToDefault("접근이 허용되지 않습니다.","접근이 허용되지 않습니다.");
			
					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
						result_map.put("result", false);
						result_map.put("ajaxSystemCode", "901"); // 로그인에러
						result_map.put("TRS_MSG", errMsg); 
						req.setAttribute("ajaxSystemMap", result_map);
						log.debug("cmsAccLogInsert "+errMsg);

					}else{					
						log.debug("cmsAccLogInsert "+errMsg);
						returnViewMsgUrlT(RESULT_PAGE, errMsg, "top", CON_ROOT+"/");

					}					
				
				}catch(ArrayIndexOutOfBoundsException q){
					String errMsg = CM_Util.nullToDefault("접근이 허용되지 않습니다.","접근이 허용되지 않습니다.");
					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
						result_map.put("result", false);
						result_map.put("ajaxSystemCode", "901"); // 로그인에러
						result_map.put("TRS_MSG", errMsg); 
						req.setAttribute("ajaxSystemMap", result_map);
						log.debug("cmsAccLogInsert "+errMsg);
					}else{					
						log.debug("cmsAccLogInsert "+errMsg);
						returnViewMsgUrlT(RESULT_PAGE, errMsg, "top", CON_ROOT+"/");
					}						
			
				}catch(Exception q){
					log.debug("cmsAccLogInsert 메뉴 권한 조회에러3");
					String errMsg = CM_Util.nullToDefault("접근이 허용되지 않습니다.","접근이 허용되지 않습니다.");
					if(req.getRequestURI().indexOf("cmsajax.do") > -1){
						result_map.put("result", false);
						result_map.put("ajaxSystemCode", "901"); // 로그인에러
						result_map.put("TRS_MSG", errMsg); 
						req.setAttribute("ajaxSystemMap", result_map);
						log.debug("cmsAccLogInsert "+errMsg);

					}else{					
						log.debug("cmsAccLogInsert "+errMsg);
						returnViewMsgUrlT(RESULT_PAGE, errMsg, "top", CON_ROOT+"/");

					}
		
				}

  }	

	/**
	 * 파일을 임시 업로드 디렉토리에 저장
	 * @param req
	 * @param res
	 * @param param
	 * @param contentType
	 * @param isMultipart
	 * @param uploadtmppath
	 * @param curdate
	 * @param curtime
	 * @throws IOException
	 */
	private void fileSaveTemp(HttpServletRequest req, HttpServletResponse res, Map param, String contentType, boolean isMultipart, final String uploadtmppath, String curdate, String curtime) throws Exception, ModelAndViewDefiningException {
		String uploadrealpath;
		List arrdf = new ArrayList();
		String [] CMFILE_GROUP_arr = new String[0];
		String [] CMFILE_GROUP_IDX_arr  = new String[0];
		Map upload_param = new HashMap();
		String file_pcode = "";
		String UPLOADROOTPATH = "";
		StringBuffer sb = new StringBuffer();
		if(propertiesService.getString("UPLOADROOTPATH","")!=null){
			UPLOADROOTPATH = propertiesService.getString("UPLOADROOTPATH","");
		}	
		String RESULT_PAGE = "";
		if(propertiesService.getString("RESULT_PAGE","")!=null){
			RESULT_PAGE = propertiesService.getString("RESULT_PAGE","");
		}	
		String CON_ROOT = "";
		if(propertiesService.getString("CON_ROOT","")!=null){
			CON_ROOT = propertiesService.getString("CON_ROOT","");
		}		
		String MAXUPLOAD = "";
		if(propertiesService.getString("MAXUPLOAD","")!=null){
			MAXUPLOAD = propertiesService.getString("MAXUPLOAD","");
		}		
		
		log.debug("fileSaveTemp contentType["+contentType+"]");
		// contentType 타입이 multipart/form-data일경우 해당 파일을 임시 업로드 디렉토리에 저장한다

		if ((contentType != null) && contentType.startsWith("multipart/form-data") && isMultipart==true) {
			// 임시업로드 디렉토리에서 실제 업로드디렉토리로 복사전에  디렉토리생성
			try{		
			    //파일업로드
		         MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest)req;
		         log.debug("fileSaveTemp mptRequest["+mptRequest.getFileNames()+"]");
//		         Iterator fileIter = mptRequest.getFileNames();
//		         HashMap fileMap = new HashMap();//db에 넣을해쉬맵
//		         ArrayList result = new ArrayList();
		         
				if(((String)param.get("pcode")).equals(PCODE_EDITOR_IMG_UPLOAD)){ //에디터 이미지 업로드
					file_pcode = (String)param.get("inpcode");
					
					uploadrealpath = UPLOADROOTPATH+"/"+param.get("pcode")+"/"+param.get("inpcode")+"/"+curdate;
					

				}else if(((String)param.get("pcode")).equals(PCODE_CMFILE_UPLOAD)){ //공통파일 업로드	
					file_pcode = (String)param.get("rpcode");
					
					uploadrealpath = UPLOADROOTPATH+"/"+param.get("rpcode")+"/"+curdate;
					
					
				}else{
					if(HtmlTag.returnString((String)param.get("rpcode"),"").equals("")){
						file_pcode = (String)param.get("pcode");

						uploadrealpath = UPLOADROOTPATH+"/"+param.get("pcode")+"/"+curdate;
	
					}else{
						file_pcode = (String)param.get("rpcode");

						uploadrealpath = UPLOADROOTPATH+"/"+param.get("rpcode")+"/"+curdate;
						
						
					}
				
				}
				
				Object CMFILE_GROUP = param.get("CMFILE_GROUP");
				String ifilegroup = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("ifilegroup"),""));
			
				if(!ifilegroup.equals("")){
					
					//log.debug("org_option:0================="+ifilegroup);
					
					CMFILE_GROUP_arr = new String[1];
					CMFILE_GROUP_arr[0] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CMFILE_GROUP"),""));

					CMFILE_GROUP_IDX_arr = new String[1];
					CMFILE_GROUP_IDX_arr[0] = ifilegroup;					
				}else{
					if (CMFILE_GROUP instanceof String){
						//log.debug("org_option:1================="+CMFILE_GROUP);
						CMFILE_GROUP_arr = new String[1];
						CMFILE_GROUP_arr[0] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CMFILE_GROUP"),""));
					
						CMFILE_GROUP_IDX_arr = new String[1];
						CMFILE_GROUP_IDX_arr[0] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CMFILE_GROUP_IDX"),""));
						//iorg_option[0] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("org_option"),""));
						//log.debug("org_option:1 CMFILE_GROUP_arr================="+CMFILE_GROUP_arr);
						//log.debug("org_option:1 CMFILE_GROUP_IDX_arr================="+CMFILE_GROUP_IDX_arr);
					}else if(CMFILE_GROUP instanceof String []){
						//log.debug("org_option:2=================");
						CMFILE_GROUP_arr = (String [])param.get("CMFILE_GROUP");
						CMFILE_GROUP_IDX_arr = (String [])param.get("CMFILE_GROUP_IDX");
					}
				}
				log.debug("mkdir start ");
				FileUtility.makeDir(uploadrealpath);
				log.debug("mkdir end ");
				//공통파일 업로드	
				log.debug("upload start ");
				if(((String)param.get("pcode")).equals(PCODE_CMFILE_UPLOAD)){
					arrdf = FileUtility.UploadInfo2(mptRequest, curdate+curtime,uploadtmppath, uploadrealpath, (String)param.get("rpcode"), CMFILE_GROUP_arr, CMFILE_GROUP_IDX_arr);
				}else{
					if(HtmlTag.returnString((String)param.get("rpcode"),"").equals("")){
						arrdf = FileUtility.UploadInfo2(mptRequest, curdate+curtime,uploadtmppath, uploadrealpath, (String)param.get("pcode"), CMFILE_GROUP_arr, CMFILE_GROUP_IDX_arr);

					}else{
						arrdf = FileUtility.UploadInfo2(mptRequest, curdate+curtime,uploadtmppath, uploadrealpath, (String)param.get("rpcode"), CMFILE_GROUP_arr, CMFILE_GROUP_IDX_arr);

					}
				}
				log.debug("upload end ");
				log.debug("파일 필터링 start ***************************** " + arrdf.size());
//		 		개인정보 보유 파일 검증 2019-09-26
				if(arrdf.size() > 1) {
					log.debug("파일 필터링 start ");
					for(int i=0; i<arrdf.size();i++) {
						log.debug("파일 필터링 start 1111111111");
						HashMap<String, String> FilenmMap = (HashMap<String, String>) arrdf.get(i);
						String maskName = FilenmMap.get("maskName");
						log.debug("파일 필터링 start 2222222222");
//						List<HashMap<String, String>> filterList = (List<HashMap<String,String>>) StringUtil.getAtchFilePersonalData("http://124.136.8.13:9500/GET?List=", uploadrealpath+"/"+maskName);

//						log.debug("uploadrealpath ::::::::::::::::::: " + uploadrealpath+"/"+maskName);
//				 		log.debug("filterList.size() :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: " + filterList.size());
//		 				if(filterList.size() > 0) {
//		 					for(int f=0; f<filterList.size(); f++) {
//		 						HashMap<String, String> filterMap = (HashMap<String, String>) filterList.get(f); 
//		 						
//		 						String resultTyp = filterMap.get("resultTyp"); 
//		 						String resultStr = filterMap.get("resultStr");
//		 						String resultCnt = filterMap.get("resultCnt");
//
//		 						if(!resultCnt.equals("0")) {
//		 							if(f==0) {
//		 								sb.append("첨부파일 내 개인정보 보유현황 \n");	
//		 							}
//
//		 							sb.append(resultTyp  + "에서" + resultCnt + "건이 검출되었습니다.<br>");	
//		 							sb.append("===============================================<br>");
//		 							sb.append(resultStr + "<br>"); 	
//		 							sb.append("===============================================<br>");
//		 						}
//		 					}
//		 				}
				 				 		
//				 		파일 검증 종료 
					}
				}
				
//				컨텐츠 필터링 
				if(param.get("B_CONTENTS") != null && !param.get("B_CONTENTS").equals("")) {
					List<HashMap<String,String>> filterList = (List<HashMap<String,String>>) StringUtil.chkRegExpFile(param.get("B_CONTENTS").toString());
					log.debug("필터링 시작 ##################################### " + filterList.size());
					if(filterList.size() > 0) {
						for(int i =0; i < filterList.size(); i++) {
							HashMap<String, String> filterMap = (HashMap<String,String>) filterList.get(i); 
							
							String resultTyp = filterMap.get("resultTyp"); 
							String resultStr = filterMap.get("resultStr");
							String resultCnt = filterMap.get("resultCnt");

							log.debug("resultCnt ::::::::::::::::::::::::::::::::::::::::::::::::::::::::: " + resultCnt);
							if(!resultCnt.equals("0")) {
								if(i==0) {
									sb.append("게시판 내용 중  개인정보 보유현황 \n");
								}
								sb.append(resultTyp  + "에서" + resultCnt + "건이 검출되었습니다.<br>");	
								sb.append("===============================================<br>");
								sb.append(resultStr+"<br>");
								sb.append("===============================================<br>");
							}
						}
					}
				}
				
				if(!sb.toString().equals("")){
					sb.append("의도치 않게 정보가 포함된 경우, 게시물을 수정 해주세요.");
				}
				
				log.debug("sb content text  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: " + sb.toString());
				param.put("FILE_MSG",sb.toString());
							
				param.put("FILE_ARR",arrdf);
				param.put("CMFILE_GROUP_arr",CMFILE_GROUP_arr);
				param.put("CMFILE_GROUP_IDX_arr",CMFILE_GROUP_IDX_arr);
				//공통파일 업로드	
				if(((String)param.get("pcode")).equals(PCODE_CMFILE_UPLOAD)){
				
				}
				//log.debug("JRCMS MAController:fileSaveTemp : "+param);

			}catch(NullPointerException q){
				log.debug("fileSaveTemp NullPointerException["+"]"+q);

			}catch(ArrayIndexOutOfBoundsException q){
				log.debug("fileSaveTemp ArrayIndexOutOfBoundsException["+"]"+q);

			}catch(Exception q){
				log.debug("fileSaveTemp 업로드 에러 ["+"]"+q);
				q.printStackTrace();
//				req.setAttribute(propertiesService.getString("RESULT_MSG_KEY",""), "업로드 용량이 최대업로드"+propertiesService.getString("MAXUPLOAD","")+"(MB)를 초과하여 업로드중 에러가 발생했습니다");
//				req.setAttribute(propertiesService.getString("RESULT_URL_T_KEY",""),"");
//				req.setAttribute(propertiesService.getString("RESULT_URL_KEY",""), "");					
				//return propertiesService.getString("RESULT_PAGE","");
				//res.sendRedirect(propertiesService.getString("RESULT_PAGE",""));
				returnViewMsgUrlT(RESULT_PAGE,"업로드 용량이 최대업로드"+MAXUPLOAD+"(MB)를 초과하여 업로드중 에러가 발생했습니다",null,null); //업로드에러
			
				//req.setAttribute(ConfigMgr.getProperty("RESULT_MSG_KEY"), "업로드중 에러가 발생했습니다");
				//LOG.debug("JRCMS MAController:업로드중 에러가 발생했습니다:"+uploadrealpath);
			}
		}
	}

	/**
	 * view페이지 리턴
	 * @param view name
	 * @throws ModelAndViewDefiningException
	 */
	// TODO : returnView
	private void returnView(String view) throws ModelAndViewDefiningException {
		returnViewMsgUrlT(view, null, null, null);
//		res.sendRedirect(propertiesService.getString("RESULT_PAGE",""));
	}
	// TODO : returnViewMsgUrlT
	private void returnViewMsgUrlT(String view, String msg, String url_t, String url) throws ModelAndViewDefiningException {
		
		log.debug("===== returnViewMsgUrlT Start =====");
		
		if(view==null){
			view="";
		}
		String RESULT_MSG_KEY = "";
		String RESULT_URL_T_KEY = "";
		String RESULT_URL_KEY = "";
		
		if(propertiesService!=null){
			if(propertiesService.getString("RESULT_MSG_KEY","")!=null){
				RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY","");
			}
			
			if(propertiesService.getString("RESULT_URL_T_KEY","")!=null){
				RESULT_URL_T_KEY = propertiesService.getString("RESULT_URL_T_KEY","");
			}
			
			if(propertiesService.getString("RESULT_URL_KEY","")!=null){
				RESULT_URL_KEY = propertiesService.getString("RESULT_URL_KEY","");
			}			
			
		}
		ModelAndView mav = new ModelAndView(view);
		ModelMap model = mav.getModelMap();
		
		setModelDefault(model); //기본설정값 셋팅
		
		if(!StringUtils.isEmpty(msg)){ model.addAttribute(RESULT_MSG_KEY, msg); }
		if(!StringUtils.isEmpty(url_t)){ model.addAttribute(RESULT_URL_T_KEY, url_t); }
		if(!StringUtils.isEmpty(url)){ model.addAttribute(RESULT_URL_KEY, url); }
		
		log.debug("returnViewMsgUrlT view["+view+"] msg["+msg+"] url_t["+url_t+"] url["+url+"]");
		throw new ModelAndViewDefiningException(mav);
//		res.sendRedirect(propertiesService.getString("RESULT_PAGE",""));
	}
	
	
	// TODO : returnViewMsgUrlTForce
	private void returnViewMsgUrlTForce(HttpServletResponse res,String view, String msg, String url_t, String url) {

		
		log.debug("returnViewMsgUrlTForce view["+view+"] msg["+msg+"] url_t["+url_t+"] url["+url+"]");
		
		
		String script = "<script type='text/javascript'>";
		script = script + "\n //<![CDATA[ ";
		script = script + "\n alert('"+msg+"');";
		if(!url.equals("")){
			script = script + "\n top.location.href='"+url+"'";
		}
		
		script = script + "\n //]]> ";
		script = script + "\n </script>";

		res.setHeader("cache-control","no-cache, must-revalidate");
		res.setHeader("expires","0");
		res.setHeader("pragma","no-cache");
		res.setCharacterEncoding("UTF-8"); 
		res.setContentType("text/html;charset=UTF-8");
		try {
			res.getWriter().println(script);
			res.reset();
		} catch (IOException e) {
			log.debug("returnViewMsgUrlTForce ERROR:");
		}	
	}
		

	
}
