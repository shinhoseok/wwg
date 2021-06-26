/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ji.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ji.service.CMSService;
import com.ji.service.CMService;
import com.ji.service.MAService;
import com.ji.service.ACTService;
import com.ji.service.ABDService;
import com.ji.util.CmsCheckInterceptor;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;



/**  
 * @Class Name : MAController.java
 * @Description : MAController Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2014.06.01           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2014.06.01
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class MAController {

	/** 사이트코드 - 공통 */
	private static final String SCODE_COMMON = "000008";
	
	/** 프로그램상태 - 폼구분 접미사 */
	private static final String PSTATE_POSTFIX_FORM = "F";
	/** 프로그램상태 - 등록폼 */
	private static final String PSTATE_CREATE = "C"+PSTATE_POSTFIX_FORM;
	/** 프로그램상태 - 수정폼 */
	private static final String PSTATE_UPDATE = "U"+PSTATE_POSTFIX_FORM;
	/** 프로그램상태 - 상세조회 */
	private static final String PSTATE_READ = "R";
	/** 프로그램상태 - 목록조회 */
	private static final String PSTATE_LIST = "L";
	/** 프로그램상태 - 팝업조회 */
	private static final String PSTATE_POPUP = "P";
	
	/** 연결종류 - 프로그램 */
	private static final String LINKTY_PROGRAM = "000009";
	/** 연결종류 - 게시판 */
	private static final String LINKTY_BOARD = "000008";
	/** 연결종류 - 링크 */
	private static final String LINKTY_LINK = "000007";
	/** 연결종류 - 컨텐츠 */
	private static final String LINKTY_CONTENT = "000006";
	/** 연결종류 - 없음 */
	private static final String LINKTY_NULL = "000005";
	
	private static final MessageSource messageSource;				// 프로퍼티 메시지
	
	static {
		messageSource = (MessageSource)new ClassPathXmlApplicationContext("egovframework/spring/context-common.xml");
	}	

	/** MAService */
    @Resource(name = "maService")
    private MAService maService;
    
	/** CMService */
    @Resource(name = "cmService")
    private CMService cmService; 
    
	/** CMSService */
    @Resource(name = "cmsService")
    private CMSService cmsService; 
    
	/** ACTService */
    @Resource(name = "actService")
    private ACTService actService;     
    
	/** ABDService */
    @Resource(name = "abdService")
    private ABDService abdService;     
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	

    protected Logger log = Logger.getLogger(MAController.class); //현재 클래스 이름을 Logger에 등록
    
  
    
    /**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "*"
	 * @exception Exception
	 */
    // TODO : CmsMain
    @RequestMapping("/cmsmain.do")
    public String CmsMain( Model model, HttpServletRequest req, HttpServletResponse res) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
    	log.debug("========================== cmsmain start ==========================");
    	// 환경설정값을 셋팅한다
    	final String CON_ROOT = propertiesService.getString("CON_ROOT");
    	final String JSP_ADM_DIR = propertiesService.getString("JSP_ADM_DIR");
    	final String JSP_DIR = propertiesService.getString("JSP_DIR");
    	final String RESULT_PAGE = propertiesService.getString("RESULT_PAGE");
    	final String SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN");
    	final String SITE_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN");
    	final String RESULT_DTO_KEY = propertiesService.getString("RESULT_DTO_KEY");
    	final String RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY");
    	final String RESULT_URL_KEY = propertiesService.getString("RESULT_URL_KEY");
    	final String RESULT_URL_T_KEY = propertiesService.getString("RESULT_URL_T_KEY");
    	
    	// 시스템 관리자 코드
    	final String sys_admin_cd = propertiesService.getString("SYS_ADMIN_CD","sysadm");
    	// 시스템 공통 코드
    	final String sys_common_cd = propertiesService.getString("SYS_COMMON_CD",SCODE_COMMON);
    	// 시스템 기본 사이트코드
    	final String sys_site_cd = propertiesService.getString("SYS_SITE_CD","S01");  		
    	
		Map tmp_map = new HashMap();
		List tmp_list = new ArrayList();
		String nextUrl = "";
    		
		String refUrl = null;
		if (refUrl == null){
			refUrl = RESULT_PAGE;
		}

		Map param = new HashMap();
		String pstate = "";
		String scode = "";
		String pcode = "";
		
		try {
			
			param = (HashMap)req.getAttribute(CmsCheckInterceptor.PARAM_KEY); //인터셉터 전달 값 추출

//			if(param.get("idxCheck") == null){
//				param.put("idxCheck", req.getSession().getAttribute("idxCheck"));
//			}
			System.out.println("MAcont:::::::::::::::::::::::"+param.toString());
			
			if(param.get("scode")==null){
				scode = "S01";
			}else{
				scode = HtmlTag.returnString((String)param.get("scode"),"S01");
			}
			
			if(param.get("pcode")==null){
				pcode = "main";
			}else{
				pcode = HtmlTag.returnString((String)param.get("pcode"),"main");
			}			
			if(param.get("pstate")==null){
				pstate = "L";
			}else{
				pstate =  HtmlTag.returnString((String)param.get("pstate"),PSTATE_LIST);
			}			
			
			//	 로그인 전용페이지일 경우 Controller에서 일괄 처리
			/*if (req.getSession(false) == null
					|| req.getSession().getAttribute(ConfigMgr.getProperty("SITE_SESSION_FN")) == null) {
				refUrl = ConfigMgr.getProperty("LOGIN_URL","/WEB-INF/jsp/login/login.jsp");
				throw new JSysException("로그인을 해주세요.");
			}*/
			//LOG.debug("MAController scode--"+param.get("scode")+":"+param.get("pcode"));
			//  TODO : 관리자페이지일경우
			if(scode.equals(sys_admin_cd)){
				
				Map SITE_ADM_SESSION = (Map)req.getSession().getAttribute(SITE_ADM_SESSION_FN);

				model.addAttribute("pstate", pstate);
				
				log.debug("MAController admin  pcode:"+param.get("pcode"));
				
				// left메뉴를 셋팅한다.
				//Map adm_left_menu = cmService.getAdmLeft();
				//tmp_list = (List)adm_left_menu.get("ListFullLeft");
				//model.addAttribute("ListFullLeft", tmp_list);	
				
				// 메인 페이지 호출일경우
				if(pcode.equals("main")){
					log.debug("admin main 호출");
					model.addAttribute(RESULT_DTO_KEY, maService.getListMD(param));
					model.addAttribute(RESULT_MSG_KEY, "");
					nextUrl = JSP_ADM_DIR+"/cm/" + "CmMain";
				// 서브페이지 호출일경우
				}else{

					//LOG.debug("JRCMS Dynamic method Call:1");
					//메뉴 환경설정을 로드
					if(param.get("MENUCFG")==null){
						tmp_map = new HashMap();
					}else{
						tmp_map = (Map)param.get("MENUCFG");
					}
					
					if(tmp_map == null){
						model.addAttribute(RESULT_MSG_KEY, "메뉴 환경설정을 로드하지 못했습니다.");
						model.addAttribute(RESULT_URL_T_KEY, "top");
						model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode=main&pstate=L");											
						return RESULT_PAGE;								
						//throw new JSysException("메뉴 환경설정을 로드하지 못했습니다.");
					}else{
						// 연결종류가 없음이면
						if(((String)tmp_map.get("linkTy")).equals(LINKTY_NULL)){
							model.addAttribute(RESULT_MSG_KEY, "");
							nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain.jsp";								

						// 연결종류가 컨텐츠이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_CONTENT)){
							// LINK_PATH가 있으면 인클루드 아니면 데이터베이스에서 관리되는 내용을 출력
							if((HtmlTag.returnString((String)tmp_map.get("linkPath"),"")).equals("")){
								model.addAttribute(RESULT_DTO_KEY, actService.ctlACT(param));
							}
							model.addAttribute(RESULT_MSG_KEY, "");
							// 공통인경우
							if(((String)param.get("scode")).equals(SCODE_COMMON)){
								nextUrl = (String)tmp_map.get("linkPath");
							}else{
								if((pstate.indexOf(PSTATE_LIST) > -1) ){
									nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";	
								}else{
									nextUrl = "cm/" + "CmSuccess";	
								}
							}
							if((pstate.indexOf(PSTATE_LIST) > -1) ){
								nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain";		
							}else{
								nextUrl = JSP_ADM_DIR+"/cm/" + "CmSuccess";	
							}
							model.addAttribute("linkTy", tmp_map.get("linkTy"));
						// 연결종류가 LINK이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_LINK)){
							model.addAttribute(RESULT_MSG_KEY, "");
							nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain";
						// 연결종류가 게시판이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_BOARD)){
							model.addAttribute(RESULT_DTO_KEY, abdService.ctlABD(param));
							model.addAttribute(RESULT_MSG_KEY, "");
							model.addAttribute("linkTy", tmp_map.get("linkTy"));
							if((pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
								nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain";
							}else if(pstate.equals("D")) { //삭제결과
								String message="삭제되었습니다.";
								String redirectUrl="/cmsmain.do?scode="+param.get("scode")+"&pcode="+param.get("pcode")+"&pstate=L";
								model.addAttribute("message", message);
								model.addAttribute("redirectUrl", redirectUrl);
								nextUrl = "/common/temp_action_message";
							}else{
								nextUrl = JSP_ADM_DIR+"/cm/abd/" + "success";
							}
						// 연결종류가 프로그램이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_PROGRAM)){
							WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getSession().getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action" );
							CMSService clsTs = (CMSService)context.getBean("cmsService");
							model.addAttribute(RESULT_DTO_KEY, clsTs.ctlCMS(param, tmp_map));
							// 결과JSP가 INCLUDE이면
							if(((String)tmp_map.get("jspIncludeYn")).equals("1")){								
								// 목록조회(L), 상세조회(R), 등록폼(CF), 수정폼(UF)일경우
								if((pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
									nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain";	
									log.debug("JRCMS Dynamic method Call11:nextUrl:"+nextUrl);	
								
								// 등록결과,수정결과, 삭제결과, 다른결과
								}else{
									nextUrl = ((String)tmp_map.get("classPathJsp")).substring(0,((String)tmp_map.get("classPathJsp")).lastIndexOf("/")).replaceAll("/WEB-INF/jsp/", "")+"/success";
									model.addAttribute(RESULT_URL_KEY , CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&pcode="+param.get("pcode")+"&pstate=L");
									log.debug("JRCMS Dynamic method Call22:nextUrl:"+nextUrl);
									
								}
								// 결과JSP가 결과페이지이면
							}else{
								if((pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
									nextUrl = (String)tmp_map.get("classPathJsp");
								}else{
									nextUrl = ((String)tmp_map.get("classPathJsp")).substring(0,((String)tmp_map.get("classPathJsp")).lastIndexOf("/"))+"/success";
								}
							}									
						}else{
							nextUrl = JSP_ADM_DIR+"/cm/" + "CmSubMain";
						}
					}
				}
			// TODO : 일반페이지일경우
			}else{
				//조직도 팝업 다이렉트 접근 취약점 조치 2021.05.04
				if(scode.equals("000008") && pcode.equals("000038")) {
					Map SITE_SESS = (Map) param.get("SITE_SESS");
					if(SITE_SESS != null) {
						String ADMIN_LEVEL = (String) SITE_SESS.get("ADMIN_LEVEL");
						if(ADMIN_LEVEL != null && ADMIN_LEVEL.equals("1")) {
							log.debug("true");
						} else if(ADMIN_LEVEL != null && ADMIN_LEVEL.equals("5")) {
							log.debug("true");
						} else {
							model.addAttribute("message", "비정상적인 접근입니다.");
							model.addAttribute("redirectUrl", "/cmsmain.do");
							return "/common/temp_action_message";
						}
					} else {
						model.addAttribute("message", "비정상적인 접근입니다.");
						model.addAttribute("redirectUrl", "/cmsmain.do");
						return "/common/temp_action_message";
					}
				}
				
				log.debug("MAController normal pcode 1111111111111:"+pcode);
				Map SITE_ADM_SESSION = (Map)req.getSession().getAttribute(SITE_ADM_SESSION_FN);
				// 페이지 상태를 셋팅한다
				pstate = HtmlTag.returnString((String)param.get("pstate"),PSTATE_LIST);
				
				model.addAttribute("pstate", pstate);
				
				log.debug("MAController normal pcode 2222222222222:"+pcode);
				String USER_ID	= "";
				String SYS_SITE_CD = "";
				if(SITE_ADM_SESSION!=null){
					USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					SYS_SITE_CD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("SYS_SITE_CD"),""));
				}
				//관리자페이지에서 로그인 했을경우 로그아웃한다(세션을 초기화한다)
				if(SYS_SITE_CD.equals("sysadm")){
					//HttpSession session = req.getSession(true);
					//session.invalidate();
					log.debug("========== session invalidate! ==========");
				}
				log.debug("MAController normal pcode 33333333333333: "+SYS_SITE_CD);
				//메인
				if(((String)param.get("pcode")).equals("main")){
					log.debug("MAController normal  pcode 4444444444444: "+param.get("pcode"));
					log.debug("세션존재 일반:"+param.get("pcode"));
					model.addAttribute(propertiesService.getString("RESULT_DTO_KEY"), maService.getListMD(param));
					model.addAttribute(propertiesService.getString("RESULT_MSG_KEY"), "");
					nextUrl = "cm/"+param.get("scode")+"/" + "CmMain";
		    		
				//그외
				}else{
					log.debug("MAController normal  pcode 555555555555:"+param.get("pcode"));
					if(param.get("MENUCFG")==null){
						tmp_map = new HashMap();
					}else{
						tmp_map = (Map)param.get("MENUCFG");
					}
					
					model.addAttribute("MENUCFG", tmp_map);
					// 부분관리자권한을 셋팅한다 공통페이지는 제외한다
					if(!((String)param.get("scode")).equals(sys_common_cd)){
						log.debug("관리");
						// 일반사용자모드에서 권한체크가 필요할시에
						//if(((String)SITE_SESSION.get("USER_LEVEL")).equals("1")){
						//	Map adm_sub_auth = cmService.getAdmSubAuth((String)SITE_ADM_SESSION.get("USER_ID"));
						//	tmp_list = (List)adm_sub_auth.get("AdmSubAuth");
						//	model.addAttribute("AdmSubAuth", tmp_list);
						//}
					}
					if(tmp_map == null){
						log.debug("메뉴 로드못함");
						model.addAttribute(RESULT_MSG_KEY, "메뉴 환경설정을 로드하지 못했습니다.");
						model.addAttribute(RESULT_URL_T_KEY, "top");
						model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/");									
						return RESULT_PAGE;							
					}else{
						log.debug("----------------linkTy--:"+tmp_map.get("linkTy"));
						// 연결종류가 없음이면
						if(((String)tmp_map.get("linkTy")).equals(LINKTY_NULL)){
							model.addAttribute(RESULT_MSG_KEY, "");
							nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";								
						// 연결종류가 컨텐츠이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_CONTENT)){
							model.addAttribute(RESULT_MSG_KEY, "");
							// LINK_PATH가 있으면 인클루드 아니면 데이터베이스에서 관리되는 내용을 출력
							if((HtmlTag.returnString((String)tmp_map.get("linkPath"),"")).equals("")){
								model.addAttribute(RESULT_DTO_KEY, actService.ctlACT(param));
							}
							model.addAttribute(RESULT_MSG_KEY, "");
							log.debug("----------------contents--:"+tmp_map.get("linkPath"));
							// 공통인경우
							if(((String)param.get("scode")).equals(SCODE_COMMON)){
								nextUrl = (String)tmp_map.get("linkPath");
							}else{
								if((pstate.indexOf(PSTATE_LIST) > -1) ){
									nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";	
								}else{
									nextUrl = "cm/" + "CmSuccess";	
								}
							}
						// 연결종류가 LINK이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_LINK)){
							model.addAttribute(RESULT_MSG_KEY, "");
							nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";
						// 연결종류가 게시판이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_BOARD)){
							model.addAttribute(RESULT_DTO_KEY, abdService.ctlABD(param));
							model.addAttribute(RESULT_MSG_KEY, "");
							if((pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
								nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";
							}else{
								nextUrl = "ji/cm/abd/"+ "success";
							}
							
						// 연결종류가 프로그램이면
						}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_PROGRAM)){
							WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getSession().getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action" );
							CMSService clsTs = (CMSService)context.getBean("cmsService");
							model.addAttribute(RESULT_DTO_KEY, clsTs.ctlCMS(param, tmp_map));
							// 결과JSP가 INCLUDE이면
							if(((String)tmp_map.get("jspIncludeYn")).equals("1")){
								// 팝업조회(P), 목록조회(L), 상세조회(R), 등록폼(CF), 수정폼(UF)일경우
								if((pstate.indexOf(PSTATE_POPUP) > -1) || (pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
									nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";	
								// 등록결과,수정결과, 삭제결과, 다른결과
								}else{
									nextUrl = ((String)tmp_map.get("classPathJsp")).substring(0,((String)tmp_map.get("classPathJsp")).lastIndexOf("/")).replaceAll("/WEB-INF/jsp/", "")+"/success";
									//LOG.debug("JRCMS Dynamic method Call NORMAL 2:CLASS_PATH_JSP:"+tmp_map.get("CLASS_PATH_JSP"));
									model.addAttribute(RESULT_URL_KEY , CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&amp;pcode="+param.get("pcode")+"&amp;pstate=L");
									//LOG.debug("JRCMS Dynamic method Call NORMAL 2:nextUrl:"+nextUrl);
								}
							// 결과JSP가 결과페이지이면
							}else{
								if((pstate.indexOf(PSTATE_LIST) > -1) || pstate.equals(PSTATE_READ) || pstate.equals(PSTATE_CREATE) || pstate.equals(PSTATE_UPDATE) || (pstate.length()>1 && pstate.indexOf(PSTATE_POSTFIX_FORM) > -1)){
									log.debug("결과JSP가 결과페이지이면1:"+tmp_map.get("classPathJsp"));
									nextUrl = (String)tmp_map.get("classPathJsp");
								}else{
									log.debug("결과JSP가 결과페이지이면2:"+((String)tmp_map.get("classPathJsp")).substring(0,((String)tmp_map.get("classPathJsp")).lastIndexOf("/"))+"/success");
									nextUrl = ((String)tmp_map.get("classPathJsp")).substring(0,((String)tmp_map.get("classPathJsp")).lastIndexOf("/"))+"/success";
								}

							}	
						
						}else{
							nextUrl = "cm/"+param.get("scode")+"/" + "CmSubMain";	
						}
					}
					
				}
			}
			
			
			//jqGrid exceldown
			if(HtmlTag.returnString((String)param.get("jqGrid.oper"),"").equals("excel")){ //그리드 엑셀다운
				//model.addAttribute("excelDownUrl", "/WEB-INF/jsp/cm/CmExcelDownGrid2.jsp");
				nextUrl = "cm/CmExcelDown";
				
			//엑셀업로드 샘플다운로드시 사용(poi)
			}else if(HtmlTag.returnString((String)param.get("jqGrid.oper"),"").equals("excel3")){
				nextUrl = "cm/CmExcelDown3";			
			//엑셀업로드 샘플다운로드시 사용(poi)
			}else if(HtmlTag.returnString((String)param.get("jqGrid.oper"),"").equals("excel2")){
				model.addAttribute("excelParam", param);
				nextUrl = (String)param.get("excelFileUrl");

			}else if(HtmlTag.returnString((String)param.get("jqGrid.oper"),"").equals("excel4")){
				nextUrl = "cm/CmExcelDown4";

			}	
			
			
			// 최종적으로 접속카운트를 증가 시킨다
			// 인시주석
			//asService.insertAS(param);

			/***************************************************************************************************/		
			} catch (JSysException es) {
				log.debug("JRCMS JSysException:");
				model.addAttribute(RESULT_MSG_KEY, ""+es.getMessage());
				model.addAttribute(RESULT_URL_T_KEY,"top");
				//if(req.getAttribute(RESULT_URL_KEY)!=null){
				//	model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&amp;pcode=main");
				//}else{
				//	model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&amp;pcode=main");
					//req.setAttribute(ConfigMgr.getProperty("RESULT_URL_KEY"), CON_ROOT+"/servlet/cmsmain?scode=S01&amp;pcode=main");
				//}
				model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+param.get("scode")+"&amp;pcode="+param.get("pcode"));
				nextUrl = refUrl;
				log.debug("JRCMS JSysException:nextUrl:"+nextUrl);
				
			} catch (SecurityException e) {
				log.debug("JRCMS SecurityException:");
				//LOG.debug("JRCMS Exception:"+ConfigMgr.getProperty("RESULT_MSG_KEY"));
				model.addAttribute(RESULT_MSG_KEY, "");
				model.addAttribute(RESULT_URL_T_KEY,"top");
				model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+sys_site_cd+"&pcode=main");
				nextUrl = refUrl;
				//req.setAttribute(ConfigMgr.getProperty("RESULT_DTO_KEY"), 
				log.debug("JRCMS SecurityException:"+nextUrl);			
				
			} catch (IllegalArgumentException e) {
				log.debug("JRCMS IllegalArgumentException:");
				//LOG.debug("JRCMS Exception:"+ConfigMgr.getProperty("RESULT_MSG_KEY"));
				model.addAttribute(RESULT_MSG_KEY, "");
				model.addAttribute(RESULT_URL_T_KEY,"top");
				model.addAttribute(RESULT_URL_KEY, CON_ROOT+"/cmsmain.do?scode="+sys_site_cd+"&pcode=main");
				nextUrl = refUrl;
				//req.setAttribute(ConfigMgr.getProperty("RESULT_DTO_KEY"), 
				log.debug("JRCMS IllegalArgumentException:"+nextUrl);			
				
			} finally {
				log.debug("JRCMS MAController:nextUrl:"+nextUrl);
				log.debug("MAController end---------------------------------------------------");
				if(!nextUrl.equals("")){
					/*RequestDispatcher rd = getServletContext().getRequestDispatcher(nextUrl);
					try {
						rd.forward(req, res);
					} catch (ServletException e) {
						log.debug("JRCMS ServletException:");
					} catch (IOException e) {
						log.debug("JRCMS IOException:");
					}*/
				}
			}    		
    	log.debug("========================== cmsmain end ==========================");
		if(nextUrl.equals("")){
			return RESULT_PAGE;	
		}else{
			return nextUrl;		
		}
    	//return "cm/CmSuccess";
    	//return "cm/S01/CmMain";
    }
    
    // TODO : CmsAjax
    @SuppressWarnings("unchecked")
	@ResponseBody
    @RequestMapping("/cmsajax.do")
    public Map<String, Object> CmsAjax(Model model, HttpServletRequest req, HttpServletResponse res) throws JSysException, Exception {
    	log.debug("========================== cmsajax start ==========================");
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	Map param = new HashMap();
    	Map tmp_map = new HashMap();
    	String tmp_str = "";
		String pstate = "";
		String scode = "";
		String pcode = "";    	
		
		// 환경설정값을 셋팅한다
		final String CON_ROOT = propertiesService.getString("CON_ROOT");
		final String JSP_ADM_DIR = propertiesService.getString("JSP_ADM_DIR");
		final String JSP_DIR = propertiesService.getString("JSP_DIR");
		final String RESULT_PAGE = propertiesService.getString("RESULT_PAGE");
		final String SITE_ADM_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN");
		final String SITE_SESSION_FN = propertiesService.getString("SITE_ADM_SESSION_FN");
		final String RESULT_DTO_KEY = propertiesService.getString("RESULT_DTO_KEY");
		final String RESULT_MSG_KEY = propertiesService.getString("RESULT_MSG_KEY");
		final String RESULT_URL_KEY = propertiesService.getString("RESULT_URL_KEY");
		final String RESULT_URL_T_KEY = propertiesService.getString("RESULT_URL_T_KEY");
		
		// 시스템 관리자 코드
		final String sys_admin_cd = propertiesService.getString("SYS_ADMIN_CD","sysadm");
		// 시스템 공통 코드
		final String sys_common_cd = propertiesService.getString("SYS_COMMON_CD",SCODE_COMMON);
		// 시스템 기본 사이트코드
		final String sys_site_cd = propertiesService.getString("SYS_SITE_CD","S01");  		
//    	Param Param_Obj = new Param();
    	
    	try {
//    		param = Param_Obj.setParameter(req);
    		param = (HashMap)req.getAttribute(CmsCheckInterceptor.PARAM_KEY); //인터셉터 전달 값 추출

    		if(param.get("scode")==null){
				scode = "S01";
			}else{
				scode = HtmlTag.returnString((String)param.get("scode"),"S01");
			}
			
			if(param.get("pcode")==null){
				pcode = "main";
			}else{
				pcode = HtmlTag.returnString((String)param.get("pcode"),"main");
			}			
			if(param.get("pstate")==null){
				pstate = "L";
			}else{
				pstate =  HtmlTag.returnString((String)param.get("pstate"),PSTATE_LIST);
			}
			
    		tmp_map = (HashMap)req.getAttribute("ajaxSystemMap"); 
    		if(tmp_map!=null){

    			log.debug("result:"+tmp_map.get("result"));
    			tmp_str = (String)tmp_map.get("ajaxSystemCode");
    			log.debug("ajaxSystemCode:"+tmp_str);
    			return tmp_map;
    		}
    		
			if(param.get("MENUCFG")==null){
				tmp_map = new HashMap();
			}else{
				tmp_map = (Map)param.get("MENUCFG");
			}
			
			if(tmp_map == null){

	    		Map rtn_menu_cfg = cmService.getMenuCfg(scode, pcode);
				if(rtn_menu_cfg.get("MENUCFG")==null){
					tmp_map = new HashMap();
				}else{
					tmp_map = (Map)rtn_menu_cfg.get("MENUCFG");
				}
	    		param.put("MENUCFG", tmp_map);
			}    		
    		
    		if(param.get("jqGrid.page")!=null){ //jqGrid 페이지번호 파라미터 
    			param.put("curr_page",param.get("jqGrid.page"));
    		}

    		if(param.get("jqGrid.rows")!=null){ //jqGrid 페이지번호 파라미터 
    			param.put("show_rows",param.get("jqGrid.rows"));
    		}

    		if(param.get("jqGrid.sidx")!=null){ //jqGrid 페이지번호 파라미터 
    			param.put("sort_field",param.get("jqGrid.sidx"));
    		}

    		if(param.get("jqGrid.sord")!=null){ //jqGrid 페이지번호 파라미터 
    			param.put("sort",param.get("jqGrid.sord"));
    		}    	
    		
    		// 메인페이지 호출 ajax일경우
    		if(((String)param.get("pcode")).equals("main")){
    			map = maService.ctlCMS(param);
    		// 비밀번호 찾기페이지 일경우
    		}else if(((String)param.get("pcode")).equals("login_pin_search")){
    			map = maService.loginPinSearch(param);
 			
        	// 로그인 인증번호 발송
        	}else if(((String)param.get("pcode")).equals("login_pin_authsend")){    			
        		map = maService.loginPinAuthSend(param);
        		
    		}else{
    			if(((String)tmp_map.get("linkTy")).equals(LINKTY_BOARD)){ //연결종류가 게시판이면

    				map = abdService.ctlABD(param);

    			}else if(((String)tmp_map.get("linkTy")).equals(LINKTY_PROGRAM)){ // 연결종류가 프로그램이면

    				WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getSession().getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action" );

    				CMSService clsTs = (CMSService)context.getBean("cmsService");

    				map = clsTs.ctlCMS(param, tmp_map);
            		
    			}
    		}
    		
   		

			if(map.isEmpty()== true){
				log.debug("CmxAjax throw JSysException >>>>> :  map :::"+map);	
				throw new JSysException("프로그램이 정상작동하지 않습니다.");
			}else{
				if(map.get("result")==null){
					map.put("result", true);
					map.put("TRS_MSG", "");
				}
				
			}
			//log.debug("CmxAjax map >>>>> :  "+map.get("rows"));	

    	}catch(JSysException e){	
    		log.debug("CmxAjax throw JSysException >>>>> :  ");	
    		map.put("result", false);
    		map.put("ajaxSystemCode", "901"); // 로그인에러
    		map.put("TRS_MSG", e.getMessage()); 
    		map.put("TRS_URL", CON_ROOT); 
			req.setAttribute("ajaxSystemMap", map);    		

    		
	    	
		} catch (Exception e) {
			log.error("CmxAjax error >>>>> : ");
    		map.put("result", false);
    		map.put("ajaxSystemCode", "903"); // 로그인에러
    		map.put("TRS_MSG", ""+messageSource.getMessage("ji.cm.common.msg.error.unknown", new Object[0], null));	
    		map.put("TRS_URL", CON_ROOT); 
    		req.setAttribute("ajaxSystemMap", map);
			
		}
    	
    	log.debug("========================== cmsajax end ==========================");
    	
    	return map;
    }
    
    
    
}
