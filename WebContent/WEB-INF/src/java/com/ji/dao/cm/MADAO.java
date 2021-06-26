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
package com.ji.dao.cm;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.transaction.PlatformTransactionManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;








import com.ji.cm.SendSms;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.StringUtil;
import com.ji.service.CMSService;
import com.ji.service.MAService;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;



/**  
 * @Class Name : MADAO.java
 * @Description : MADAO DAO Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.03.15           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2016.03.15 
 * @version 1.0
 * @see
 * 
 */

@Repository("maDAO")
public class MADAO extends CmsDsDao {

    protected Logger log = Logger.getLogger(MADAO.class); //현재 클래스 이름을 Logger에 등록
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;    
    
	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;     
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** sendSms */
    @Resource(name="sendSms")
    private SendSms sendSms;		//문자발송     
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;    
    /**
	 * 관리 메소드
	 * @param Map
	 * @return Map
	 * @exception Exception
	 */
    // TODO : ctlCMS
    @SuppressWarnings("unchecked")
	public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO ctlCMS
		log.debug("==== MADAO ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		
		try{
			
	
			// 재난재해 속보
			if(pstate.equals("XL1")){ //ajax data관련
				result_map = selectListXL1(param); 
				//log.debug("ctlCMS:"+result_map.get("rows"));

			// 
			/*}else if(pstate.equals("X2")){ //ajax data관련
				result_map = selectListX2(param); 	
					
			// 
			}else if(pstate.equals("X3")){ //ajax  data관련
				result_map = selectListX3(param); 
			// 
			}else if(pstate.equals("X4")){ //ajax  data관련	
				result_map = selectListX4(param); 
			// 환경설정
			}else if(pstate.equals("XCONF")){ //ajax  data관련	
					result_map = selectListXCONF(param);
			*/ 
					
			}


		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.debug("SQLException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== MADAO ctlCMS End ====");
		return result_map;
    }    
    
	/**
	 * Method Name  : selectListX1
	 * Description  : 발전출력 리스트 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2016/03/15 : 이금용:  최초작성
	*/
	//	TODO selectListXL1
	public Map selectListXL1 (Map param) throws Exception {

		//log.debug("==== selectListX1 Start ====");
		Map result_map = new HashMap();

		
		try{

			List rtn_list = new ArrayList();
	  		rtn_list = list("JiCmAbd.getBOARDMain", param);
	  		
	  		result_map.put("rows",rtn_list);
			result_map.put("result",true);
			
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
    	//log.debug("==== selectListX1 End ====");
		return result_map;
	}  
	
    
    /**
	 * 메뉴트리를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
    public Map getListMD(Map param) throws Exception {
    	
    	//Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    //String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
    	String scode			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("scode"),""));
	    
    	Map result_map = new HashMap();
    	
    	int curr_page = 1;
    	int show_rows = 4;   	    	
    	// 홈페이지 메인정보를 불러온다
    	try{
    	   	if(scode.equals("S01")){
        		
        		//공지사항 정보를 불러온다. 4건
    	   		param.put("main_bbs_cd", "000115");
        		param.put("curr_page", curr_page+"");
        		param.put("show_rows", show_rows+"");
        		result_map.put("getMainNotice1", cmDAO.selectListGrid(param, "JiCmCms.selectMainNotice"));
        		
        		//NEWS를 불러온다. 4건
        		param.put("main_bbs_cd", "000524");
        		param.put("show_rows", show_rows+"");
        		result_map.put("getMainNotice2", cmDAO.selectListGrid(param, "JiCmCms.selectMainNotice"));
        		
        		//지원사업공고를 불러온다. 4건
        		param.put("main_bbs_cd", "000091");
        		param.put("show_rows", show_rows+"");
        		result_map.put("getMainNotice3", cmDAO.selectListGrid(param, "JiCmCms.selectMainNotice"));
        		
        		
        		// 팝업창 정보를 불러온다
        		//show_rows = 10; 
        		//param.put("show_rows", show_rows+"");
        		//result_map.put("getMainPop", cmDAO.selectListGrid(param, "JiCmCms.selectMainPop"));
        		
        		
        		log.debug("getMainPopList =========================================================================================================");
        		// 사이트별 팝업창
        		List site_popList = new ArrayList();
        		site_popList = list("JiCmCms.selectMainPop", param);
        		result_map.put("getMainPopList", site_popList);
        		log.debug("getMainPopList ========================================================================================================="); 
        		
        		
        	// 관리자 메인정보를 불러온다
        	}else if(scode.equals("sysadm")){
        		
        	}    		
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
			//throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:"+q);
			//throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:"+q);
			//throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.debug("SQLException:"+q);
			//throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  "+q);	
			//throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
 
 
    	//result_map.put("getOraList", cmOraService.getOraList(param));

        return result_map;
    }
    
    /**
	 * 관리자 메인정보를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
    public Map getListAdminMD(Map param) throws Exception {
    	
    	//Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    //String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
	    
    	Map result_map = new HashMap();
    	// 관리자 메인정보를 불러온다
 
    	//result_map.put("getOraList", cmOraService.getOraList(param));

        return result_map;
    }    

	/**
	* <p> MAController.java(메인컨트롤클래스)에서 로그인을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  로그인의 조회 결과값을 리턴하고, 최종로그인 날짜를 업데이트 한다.
	* @throws  
	*/

	public Map getSiteLogin (Map param) throws IOException, SQLException, NullPointerException, Exception {
		//	TODO getSiteLogin
		log.debug("==== getSiteLogin Start ===="+param);
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();
		
		String sql = "";
		String sql_last = "";
		
		String scode = HtmlTag.returnString((String)param.get("scode"),"");
		if(scode.equals("sysadm")){
			sql = "JiCmCms.getAdminLogin";	//관리자로그인
		}else{
			sql = "JiCmCms.getSiteLogin";	//사용자로그인
		}
		
		
		try{
			String dec_pass = HtmlTag.returnString((String)param.get("PassWord"),"");
			//log.debug("encSHA256 :1:"+JasyptUtil.encSHA256(dec_pass));
			param.put("devMode", propertiesService.getString("DEV_MODE"));
			if(scode.equals("sysadm")){
				// db암호화적용
				//param.put("PassWord", JasyptUtil.encSHA256(dec_pass));	//관리자로그인
				param.put("PassWord", dec_pass);
			}else{
				// db암호화적용
				param.put("PassWord", dec_pass);	//사용자로그인
			}			
			
			result_map.put("UserLogin", list(sql, param));
			
			if(((List)result_map.get("UserLogin")).size() > 0){
				
				tmp_map = (Map)((List)result_map.get("UserLogin")).get(0);
				log.error("getSiteLogin :1:"+tmp_map);
				result_map.put("UserLogin", tmp_map);
				result_map.put("TRS_MSG","");
				log.debug("getSiteLogin :1:"+tmp_map.get("userNm"));
				log.debug("getSiteLogin :1:"+tmp_map.get("userId"));
				param.put("suser_id", HtmlTag.returnString((String)param.get("id"),""));
				param.put("userId", tmp_map.get("userId"));
				
				if(scode.equals("sysadm")){
					sql = "JiCmOam.initAdminLogCnt";		//관리자로그인
					sql_last = "JiCmCms.adminLoginLast";	//관리자 최종로그인
				}else{
					sql = "JiCmOam.initLogCnt";				//사용자로그인
					sql_last = "JiCmCms.siteLoginLast";		//사용자 최종로그인
				}

				update(sql, param);			//로그인 실패횟수 초기화
				update(sql_last, param);	//최종로그인 업데이트
				
				log.debug("실패횟수초기화");
				
			}else{
				result_map.put("UserLogin", null);
				result_map.put("TRS_MSG","해당 로그인 정보가 없습니다\\n다시한번 확인해주세요");
				log.debug("getSiteLogin :2:"+"해당 로그인 정보가 없습니다 다시한번 확인해주세요");
				param.put("USER_ID", HtmlTag.returnString((String)param.get("id"),""));

				if(scode.equals("sysadm")){
					sql = "JiCmOam.updateAdminloginFail";	//관리자로그인
				}else{
					sql = "JiCmOam.updateloginFail";	//사용자로그인
				}

				update(sql, param);
				log.debug("실패횟수증가");
				
			}

		}catch(NullPointerException q){
			log.error("getSiteLogin: NullPointerException:====>"+q);
			result_map.put("TRS_MSG","시스템 에러발생");
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("getSiteLogin: ArrayIndexOutOfBoundsException:====>"+q);
			result_map.put("TRS_MSG","시스템 에러발생");
		}catch(Exception q){
			log.error("getSiteLogin: Exception:====>"+q);
			result_map.put("TRS_MSG","시스템 에러발생");
			
		}
    	
    	log.debug("==== getSiteLogin End ====");
		return result_map;
	}  
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 로그인을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  로그인의 조회 결과값을 리턴한다
	* @throws  
	*/

	public Map loginPinChg (Map param) throws IOException, SQLException, NullPointerException, Exception {
		//	TODO loginPinChg
		log.debug("==== loginPinChg Start ====");
		Map result_map = new HashMap();

		String sql = "";
		
		String scode = HtmlTag.returnString((String)param.get("scode"),"");
		if(scode.equals("sysadm")){
			sql = "JiCmCms.getAdminLogin";	//관리자로그인
		}else{
			sql = "JiCmCms.getSiteLogin";	//사용자로그인
		}
		
		try{
			
			Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
			Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			
			// 사용자화면
			if(!scode.equals("sysadm") && SITE_SESSION != null){
				if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_SESSION.get("CHGDTCNT"),"0")) > 90 
		    			|| !HtmlTag.returnString((String)SITE_SESSION.get("PASSWDINITYN"),"N").equals("Y") || HtmlTag.returnString((String)param.get("pcode"),"").equals("login_pin_chg")) ){
					// 기존 비밀번호 암호화하여 기존비밀번호를 확인한다
					String dec_pass = HtmlTag.returnString((String)param.get("iprev_pin_str"),"");
					// db암호화 적용
					//param.put("PassWord", JasyptUtil.encSHA256(dec_pass));
					param.put("PassWord", dec_pass);
					param.put("id", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
					param.put("devMode", propertiesService.getString("DEV_MODE"));
					result_map.put("UserLogin", list(sql, param));
					
					// 기존 비밀번호가 일치하면 수정처리후 세션값을 변경해준다
					if(((List)result_map.get("UserLogin")).size() > 0){
						String dec_pass_chg = HtmlTag.returnString((String)param.get("inext_pin_str"),"");
						// db암호화로 변경
						//dec_pass_chg = JasyptUtil.encSHA256(dec_pass_chg);
						
						sql = "JiCmCms.loginPinChg";	//사용자
						
						param.put("dec_pass_chg", dec_pass_chg);
						param.put("suser_id", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
						update(sql, param);
						log.debug("loginPinChg : 비밀번호 변경");
						result_map.put("TRS_MSG","");
					}else{
						
						result_map.put("TRS_MSG","기존 비밀번호가 일치하지 않습니다.");
						log.debug("loginPinChg : 기존 비밀번호가 일치하지 않습니다.");
					}	
				}else{
					result_map.put("TRS_MSG","비정상적인 접근입니다.");
					log.debug("loginPinChg : 세션항목이 유효하지않은 비정상접근입니다.");	
					
				}
				
			}else if(scode.equals("sysadm") && SITE_ADM_SESSION != null){
				
				if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),"0")) > 90 
		    			|| !HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"N").equals("Y") || HtmlTag.returnString((String)param.get("pcode"),"").equals("login_pin_chg")) ){
					// 기존 비밀번호 암호화하여 기존비밀번호를 확인한다
					String dec_pass = HtmlTag.returnString((String)param.get("iprev_pin_str"),"");
					//log.debug("encSHA256 :1:"+JasyptUtil.encSHA256(dec_pass));
					// db암호화적용
					//param.put("PassWord", JasyptUtil.encSHA256(dec_pass));
					param.put("PassWord", dec_pass);
					//param.put("id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					// 세션에 담긴값은 10자리 아이디이므로 8자리만으로 2010200148 ==> 10200148 값으로 셋팅되어야한다
					if(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),"").equals("")){
						param.put("id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					}else{
						param.put("id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),"").substring(2));
					}
					
					
					result_map.put("UserLogin", list(sql, param));
					
					// 기존 비밀번호가 일치하면 수정처리후 세션값을 변경해준다
					if(((List)result_map.get("UserLogin")).size() > 0){
						String dec_pass_chg = HtmlTag.returnString((String)param.get("inext_pin_str"),"");
						// db암호화적용
						//dec_pass_chg = JasyptUtil.encSHA256(dec_pass_chg);
						dec_pass_chg = dec_pass_chg;
						sql = "JiCmCms.loginAdminPinChg";	//관리자
						
						param.put("dec_pass_chg", dec_pass_chg);
						param.put("suser_id", HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
						update(sql, param);
						log.debug("loginPinChg : 비밀번호 변경");
						result_map.put("TRS_MSG","");
					}else{
						
						result_map.put("TRS_MSG","기존 비밀번호가 일치하지 않습니다.");
						log.debug("loginPinChg : 기존 비밀번호가 일치하지 않습니다.");
					}	
				}else{
					result_map.put("TRS_MSG","비정상적인 접근입니다.");
					log.debug("loginPinChg : 세션항목이 유효하지않은 비정상접근입니다.");	
					
				}
				
			}else{
				result_map.put("TRS_MSG","비정상적인 접근입니다.");
				log.debug("loginPinChg : 세션값이 없는 비정상접근입니다.");				
			}
			
			
			
		}catch(NullPointerException q){
			result_map.put("TRS_MSG","시스템  에러발생");
		}catch(ArrayIndexOutOfBoundsException q){
			result_map.put("TRS_MSG","시스템 에러발생");
		}catch(Exception q){
			result_map.put("TRS_MSG","시스템 에러발생");
			
		}


    	
    	log.debug("==== loginPinChg End ====");
		return result_map;
	} 	

	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 로그인을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  로그인의 조회 결과값을 리턴한다
	* @throws  
	*/

	public Map loginPinSearch (Map param) throws IOException, SQLException, NullPointerException, Exception {
		//	TODO loginPinSearch
		log.debug("==== loginPinSearch Start ====");
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();
		List tmp_list = new ArrayList();

		String sql = "JiCmCms.getIpinSearch";
		String dec_pass_chg_org = "";
		String dec_pass_chg = "";
		//MailMgr mailMgr = new MailMgr();
		
		try{

					//log.debug("encSHA256 :1:"+JasyptUtil.encSHA256(dec_pass));
					//param.put("iipin_id", HtmlTag.returnString((String)param.get("iipin_id"),""));
					//param.put("iipin_email", HtmlTag.returnString((String)param.get("iipin_email"),""));
					//param.put("iipin_hp", HtmlTag.returnString((String)param.get("iipin_hp"),""));
					
			tmp_list = list(sql, param);
					//log.debug("param===>"+param);
					
					// 입력내용이 일치할경우 비밀번호를 생성해서 메일로 전송한다
					if(tmp_list.size() > 0){
						tmp_map = (Map)tmp_list.get(0);
						//log.debug("tmp_map===>"+tmp_map);
						
						if(HtmlTag.returnString((String)tmp_map.get("userEmail"),"").equals("")){
							result_map.put("result", false);
							result_map.put("TRS_MSG","사원정보에 이메일이 등록되지 않았습니다. 관리자에게 문의해 주세요");
							log.debug("loginPinSearch : 사원정보에 이메일이 등록되지 않았습니다. 관리자에게 문의해 주세요");							
						}else{
							// 핸드폰번호와 이메일이 모두 입력된경우
							if(!HtmlTag.returnString((String)param.get("iipin_email"),"").equals("")
									&& !HtmlTag.returnString((String)param.get("iipin_hp"),"").equals("")){
								// 입력된 이메일이  @kepco.co.kr을 포함하고 있으면
								if(HtmlTag.returnString((String)param.get("iipin_email"),"").indexOf("@kepco.co.kr") > -1){
									if( HtmlTag.returnString((String)param.get("iipin_email"),"").replaceAll("@kepco.co.kr","").equals(HtmlTag.returnString((String)tmp_map.get("userEmail"),""))){
										result_map.put("result", true);
										result_map.put("TRS_MSG","");											
									}else{
										result_map.put("result", false);
										result_map.put("TRS_MSG","입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요");
										log.debug("loginPinSearch : 사입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요11");										
									}
								}else{
									if( HtmlTag.returnString((String)param.get("iipin_email"),"").equals(HtmlTag.returnString((String)tmp_map.get("userEmail"),"")) ){
										result_map.put("result", true);
										result_map.put("TRS_MSG","");											
									}else{
										result_map.put("result", false);
										result_map.put("TRS_MSG","입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요");
										log.debug("loginPinSearch : 입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요22");										
									}									
								}
								
								if( HtmlTag.returnString((String)param.get("iipin_hp"),"").replaceAll("-", "").equals( HtmlTag.returnString((String)tmp_map.get("cntacPhoneno2"),"").replaceAll("-", ""))){
									result_map.put("result", true);
									result_map.put("TRS_MSG","");											
								}else{
									result_map.put("result", false);
									result_map.put("TRS_MSG","입력한 핸드폰번호가 일치하지 않습니다. 관리자에게 문의해 주세요");
									log.debug("loginPinSearch : 입력한 핸드폰번호가 일치하지 않습니다. 관리자에게 문의해 주세요");										
								}								
								
								if(Boolean.valueOf((String)result_map.get("result")) == true){
									dec_pass_chg_org = HtmlTag.returnString((String)param.get("curdate"),"")+"^%$"+StringUtil.javaRandom(10000, 99999);
									log.debug("loginPinSearch::==>"+dec_pass_chg_org);
									// db암호화 적용
									//dec_pass_chg = JasyptUtil.encSHA256(dec_pass_chg_org);
									dec_pass_chg = dec_pass_chg_org;
									
									sql = "JiCmOam.loginPinChg";
									param.put("dec_pass_chg", dec_pass_chg);
									param.put("suser_id", HtmlTag.returnString((String)param.get("iipin_id"),""));
									update(sql, param);									
								}

							
							// 이메일만 입력된경우
							}else if(!HtmlTag.returnString((String)tmp_map.get("userEmail"),"").equals("")
									&& HtmlTag.returnString((String)tmp_map.get("cntacPhoneno2"),"").equals("")){
								// 입력된 이메일이  @ewp.co.kr을 포함하고 있으면
								if(HtmlTag.returnString((String)param.get("iipin_email"),"").indexOf("@kepco.co.kr") > -1){
									if( HtmlTag.returnString((String)param.get("iipin_email"),"").replaceAll("@kepco.co.kr","").equals(HtmlTag.returnString((String)tmp_map.get("userEmail"),""))){
										result_map.put("result", true);
										result_map.put("TRS_MSG","");											
									}else{
										result_map.put("result", false);
										result_map.put("TRS_MSG","입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요");
										log.debug("loginPinSearch : 사입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요1");										
									}
								}else{
									if( HtmlTag.returnString((String)param.get("iipin_email"),"").equals(HtmlTag.returnString((String)tmp_map.get("userEmail"),""))){
										result_map.put("result", true);
										result_map.put("TRS_MSG","");											
									}else{
										result_map.put("result", false);
										result_map.put("TRS_MSG","입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요");
										log.debug("loginPinSearch : 입력한 이메일정보가 일치하지 않습니다. 관리자에게 문의해 주세요2");										
									}									
								}
								
								if(Boolean.valueOf((String)result_map.get("result")) == true){
									dec_pass_chg_org = HtmlTag.returnString((String)param.get("curdate"),"")+"^%$"+StringUtil.javaRandom(10000, 99999);
									log.debug("loginPinSearch::==>"+dec_pass_chg_org);
									// db암호화적용
									//dec_pass_chg = JasyptUtil.encSHA256(dec_pass_chg_org);
									dec_pass_chg = dec_pass_chg_org;
									
									sql = "JiCmOam.loginPinChg";
									param.put("dec_pass_chg", dec_pass_chg);

									param.put("suser_id", HtmlTag.returnString((String)param.get("iipin_id"),""));
									update(sql, param);	
									// 실운영인경우 메일을 보낸다
									Map mailsend_map = new HashMap();
									log.debug("loginPinSearch::111==>"+HtmlTag.returnString((String)param.get("iipin_email"),""));
									
				        			mailsend_map.put("mailTo", HtmlTag.returnString((String)param.get("iipin_email"),""));
				        			log.debug("loginPinSearch::222==>"+(String)tmp_map.get("userNm"));
				        			mailsend_map.put("mailToName", (String)tmp_map.get("userNm"));
										
				        			mailsend_map.put("mailTitle", "비밀번호 찾기 메일입니다.");
				        			log.debug("loginPinSearch::333==>"+"현재 "+(String)tmp_map.get("userNm")+"님의 임시 비밀번호는 ["+dec_pass_chg_org+"]입니다.");
				        			mailsend_map.put("mailContents", "현재 "+(String)tmp_map.get("userNm")+"님의 임시 비밀번호는 ["+dec_pass_chg_org+"]입니다.");
				        			mailsend_map.put("mailFrom", "admin@ewp.co.kr");
				        			mailsend_map.put("mailFromName", "관리자");
				        			
				        			//mailMgr.sendMail(mailsend_map);
				        			// 실운영모드에서 테스트 필요
/*				        			if(propertiesService.getString("DEV_MODE").equals("R")){
				            			if(mailMgr.sendJavaMail(mailsend_map)){
				    	        			log.debug("실운영 메일====::"+mailsend_map);
				    	        		}else{
				            				log.debug("실운영 메일====::전송실패");
				            			} 				        				
				        			}else{
				            			if(mailMgr.sendJavaMail(mailsend_map)){
				    	        			log.debug("개발 메일====::"+mailsend_map);
				    	        		}else{
				            				log.debug("개발 메일====::전송실패");
				            			}				        				
				        			}*/
				        			
								}								
								
							// 핸드폰만 입력되거나 모두다 입력되지 않은경우
							}else{
								result_map.put("result", false);
								result_map.put("TRS_MSG","아이디와 이메일입력은 필수사항입니다");
								log.debug("loginPinSearch : 아이디와 이메일입력은 필수사항입니다");								
							}
							
						}
						

					}else{
						result_map.put("result", false);
						result_map.put("TRS_MSG","일치하는 정보가 없습니다.");
						log.debug("loginPinSearch : 일치하는 정보가 없습니다.");
					}	


			

		}catch(NullPointerException q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템  에러발생");
			log.debug("loginPinSearch : 시스템  에러발생");
		}catch(ArrayIndexOutOfBoundsException q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템 에러발생");
			log.debug("loginPinSearch : 시스템  에러발생");
		}catch(Exception q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템 에러발생");
			log.debug("loginPinSearch : 시스템  에러발생");
			
		}


    	
    	log.debug("==== loginPinSearch End ====");
		return result_map;
	}

	public Map loginLastUpdate(Map param) throws IOException, SQLException, NullPointerException, Exception{
		// TODO Auto-generated method stub
		log.debug("==== loginLastUpdate Start ===="+param);
		
		Map result_map = new HashMap();
		String scode = HtmlTag.returnString((String)param.get("scode"),"");
		String sql = "";
		
		if(scode.equals("sysadm")){
			sql = "JiCmCms.adminLoginLast";	//관리자 최종로그인 업데이트 
		}else{
			sql = "JiCmCms.siteLoginLast";	//사용자 최종로그인 업데이트
		}
		
		update(sql, param);
		
		log.debug("loginLastUpdate : 최종로그인 업데이트");
		result_map.put("TRS_MSG","");
		log.debug("==== loginLastUpdate end ====");
		return result_map;
	} 	
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 로그인을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  로그인의 조회 결과값을 리턴한다
	* @throws  
	*/

	public Map loginPinAuthSend (Map param) throws IOException, SQLException, NullPointerException, Exception {
		//	TODO loginPinAuthSend
		log.debug("==== loginPinAuthSend Start ====");
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();
		List tmp_list = new ArrayList();

		String sql = "JiCmCms.getAdmInfo";
		String dec_pass_chg_org = "";
		String dec_pass_chg = "";
		//MailMgr mailMgr = new MailMgr();
		
		try{
			param.put("admid", HtmlTag.returnString((String)param.get("id"),""));
			tmp_map =  (Map) select(sql, param);
			String system_name = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("SYSTEM_NAME","")));//전력데이터 개방 포털시스템
			String gubun = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("GUBUN","")));	//전력데이터 개방 포털
			
			if(tmp_map != null){
				
				//인증번호 랜덤생성
				String authCode = StringUtil.rpad(StringUtil.javaRandom(100000, 999999)+"", 6, "0");
				
				//휴대폰번호로 인증번호 발송
				Map param_sms = new HashMap();
				String tran_phone = HtmlTag.returnString((String)tmp_map.get("moblphon"),"").replaceAll("-", "");
				String tran_msg = "["+system_name+"] 관리자 페이지 로그인 인증번호는["+authCode+"]입니다.";
				String tran_etc1 = gubun;
				String tran_etc2 = "관리자";
				String tran_etc3 = "02-6445-5367";
				
				param_sms.put("tran_phone", tran_phone);	//수신번호(숫자만)
				param_sms.put("tran_callback", tran_etc3);	//발송번호
				param_sms.put("tran_msg", tran_msg);		//내용
				param_sms.put("tran_etc1", tran_etc1);		//발송시스템명
				param_sms.put("tran_etc2", tran_etc2);		//담당자명
				param_sms.put("tran_etc3", tran_etc3.replaceAll("-", ""));		//담당자연락처(숫자만)
				if(!HtmlTag.returnString((String)param_sms.get("tran_phone"),"").equals("")){ 
					sendSms.start(param_sms);
				}
				
				
				//인증번호 업데이트
				param.put("authcode", authCode);
				update("JiCmCms.updateAdminAuthCode", param);
				
				result_map.put("result", true);
				result_map.put("TRS_MSG", "");
				
			}else{
				result_map.put("result", false);
				result_map.put("TRS_MSG", "일치하는 정보가 존재하지 않습니다.");
				
			}

			

		}catch(NullPointerException q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템  에러발생");
			log.debug("loginPinAuthSend : 시스템  에러발생");
		}catch(ArrayIndexOutOfBoundsException q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템 에러발생");
			log.debug("loginPinAuthSend : 시스템  에러발생");
		}catch(Exception q){
			result_map.put("result", false);
			result_map.put("TRS_MSG","시스템 에러발생");
			log.debug("loginPinAuthSend : 시스템  에러발생");
			
		}


    	
    	log.debug("==== loginPinAuthSend End ====");
		return result_map;
	}	
}
