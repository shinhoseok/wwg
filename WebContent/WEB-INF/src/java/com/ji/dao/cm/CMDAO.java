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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
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

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.ji.cm.CM_Util;
import com.ji.cm.MailMgr;
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.StringUtil;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.util.Page;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : CMDAO.java
 * @Description : CMDAO DAO Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */

@Repository("cmDAO")
public class CMDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(CMDAO.class); //현재 클래스 이름을 Logger에 등록

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;
    
    @Resource(name="txManagerds")
    private PlatformTransactionManager transactionManager;  
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;    
    
    /**
 	 * 컨트롤 메소드
 	 * @param Map
 	 * @return 메뉴트리
 	 * @exception Exception
 	 */
     public Map ctlCMS(Map param, String classMethod) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
 		//	TODO ctlCMS
 		log.debug("==== ctlCMS Start ====");
 		Map result_map = new HashMap();

 		try{
 			
 			if(classMethod.equals("getFileInfo")){
 				result_map = getFileInfo(param);
 			// 등록
 			}else if(classMethod.equals("ctlEDT")){
 				result_map = ctlEDT(param);
 				
 	 		// 사원선택
 	 		}else if(classMethod.equals("getSawon")){
 	 				result_map = getSawon(param); 
 	 				
 	 	 	// 발전출력
 	 	 	}else if(classMethod.equals("getBalzunPrint")){
 	 	 	 		
 	 	 	// 메인행사일정
 	 	 	}

 		}catch(IOException q){
			log.debug("ctlCMS IOException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
 				result_map.put("TRS_MSG",q);
 			}		
		}catch(SQLException q){
			log.debug("ctlCMS SQLException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
 				result_map.put("TRS_MSG",q);
 			}		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
 				result_map.put("TRS_MSG",q);
 			}		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
 				result_map.put("TRS_MSG",q);
 			}		
		}catch(Exception q){
 			log.debug("ctlCMS Exception:");
 			if(((String)result_map.get("TRS_MSG")).equals("")){
 				result_map.put("TRS_MSG",q);
 			}
 		}
 		
     	log.debug("==== ctlCMS End ====");
 		return result_map;
     }
     
    /**
	 * 메뉴트리를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
	// TODO : getMenuTree
    public Map getMenuTree(HashMap param) throws Exception {
    	Map result_map = new HashMap();
    	String sql = "JiCmMnm.getMENU";
    	result_map.put("ListTreeCM", list(sql, param));
        return result_map;
    }

 
    
    /**
	 * Mymenu를 조회하는 메소드
	 * @param Map
	 * @return MyMenu 
	 * @exception Exception
	 */
	// TODO : getMyMenu
    public Map getMyMenu(HashMap param) throws Exception {
    	Map result_map = new HashMap();
    	String sql = "cmDAO.getselectMymenu";
    	result_map.put("ListMyMenu", list(sql, param));
        return result_map;
    }
    
    
    
    //public void updateApiViewCount(ApiListVO listVO) throws Exception {
    //	update("apilistDAO.updateCount_S", listVO);
    //}
    
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

	public Map getSiteLogin (Map param) throws Exception {
		//	TODO getSiteLogin
		log.debug("==== getSiteLogin Start ====");
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();

		String sql = "cmDAO.getSiteLogin";
		
			result_map.put("UserLogin", list(sql, param));
			
			if(((List)result_map.get("UserLogin")).size() > 0){
				//
				tmp_map = (Map)((List)result_map.get("UserLogin")).get(0);
				log.debug("getSiteLogin :1:"+tmp_map);
				result_map.put("UserLogin", tmp_map);
				result_map.put("TRS_MSG","");
				log.debug("getSiteLogin :1:"+tmp_map.get("userNm"));
			}else{
				result_map.put("UserLogin", null);
				result_map.put("TRS_MSG","SSO 로그인정보가 정확하지 않습니다.");
				log.debug("getSiteLogin :2:"+"SSO 로그인정보가 정확하지 않습니다.");
			}


    	
    	log.debug("==== getSiteLogin End ====");
		return result_map;
	}
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 메뉴 환경설정을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  메뉴 환경설정의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getMenuCfg (String s_code, String m_code) throws Exception {
		//	TODO getMenuCfg
		log.debug("==== getMenuCfg Start ====");
		log.debug("==== s_code ===="+s_code);
		log.debug("==== m_code ===="+m_code);
		Map result_map = new HashMap();
		Map param = new HashMap();
		List restul_list = new ArrayList();
		m_code = HtmlTag.returnString(m_code,"");
		
		param.put("s_code", s_code);
		param.put("m_code", m_code);

		String sql = "JiCmMnm.getMenuCfg";

		try{
			log.debug("getMenuCfg :111:"+m_code);
			restul_list = list(sql, param);
			
			if(restul_list.size() > 0){
				result_map.put("MENUCFG", (Map)restul_list.get(0));
				//log.debug("getMenuCfg :1");
			}else{
				result_map.put("MENUCFG", null);
				//log.debug("getMenuCfg :2");
			}
			
			result_map.put("TRS_MSG","");
		}catch(NullPointerException q){
			log.debug("Exception:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("Exception:");		
		}catch(Exception q){
			log.debug("==== getMenuCfg Exception ====");
		}
		

    	
    	log.debug("==== getMenuCfg End ====");
		return result_map;
	}
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서  left메뉴 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  left메뉴관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getAdmSubAuth (String adm_id) throws Exception {
		//	TODO getAdmSubAuth
		log.debug("==== getAdmSubAuth Start ====");
		Map result_map = new HashMap();
		List res_list = new ArrayList();

		String sql = "JiCmCms.getMENUAdmSubAuth";	
		HashMap codeparam = new HashMap();
		codeparam.put("admin_id", adm_id);

		try{
			res_list = list(sql, codeparam);
			result_map.put("AdmSubAuth", res_list);				
	
	
			result_map.put("TRS_MSG","");
		}catch(NullPointerException q){
			log.debug("Exception:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("Exception:");		
		}catch(Exception q){
			log.debug("==== getAdmSubAuth Exception ====");
		}
    	
    	log.debug("==== getAdmSubAuth End ====");
		return result_map;
	}
	
	/**
	* <p> 해당테이블의 순서 키값 생성 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* Postcondition: 조회 결과를 리턴한다 
	*
	* @param   sTable_Nm		String		대상테이블명
	* @param   sColumn_Nm		String 		대상테이블의 키컬럼명
	* @param   WhereParam		String 		WHERE 조건 
	*
	* @return  
	 * @throws ISPException 
	* @throws  
	*/
	public int getTableMaxSeq(String sTable_Nm, String sColumn_Nm, String WhereParam) throws Exception {
		//	TODO getTableMaxSeq		
		log.debug("============== getTableMaxSeq : START ==============");
		
		String sql = "";
		// 배너관리
		if(sTable_Nm.equals("JRCMS_BANNER")) {
			sql = "abDAO.getTableMaxSeq";
		// 게시판
		}else if(sTable_Nm.equals("JIT9150")) {
			sql = "JiCmAbd.getTableMaxSeq";
		// 게시판 댓글
		}else if(sTable_Nm.equals("JRCMS_BOARD_RE")) {
			sql = "JiCmAbd.getTableMaxSeq2";
		// 관리자 아이피
		}else if(sTable_Nm.equals("JIT9501")) {
			sql = "JiCmAcs.getTableMaxSeq";
		// 코드 관리
		}else if(sTable_Nm.equals("JIT9101")) {
			sql = "JiCmCms.getTableMaxSeq";
		// 컨텐츠 관리
		}else if(sTable_Nm.equals("JIT9505")) {
			sql = "JiCmAct.getTableMaxSeq";
		// 팝업 관리
		}else if(sTable_Nm.equals("JIT9601")) {
			sql = "JiCmCms.getTableMaxSeqJIT9601";
		// 설문조사 관리
		}else if(sTable_Nm.equals("JIT9701")) {
			sql = "JiCmSur.getTableMaxSeqJIT9701";
		// 메뉴관리 테이블
		}else if(sTable_Nm.equals("JIT9160")) {
			sql = "JiCmMnm.getTableMaxSeq";
		// 시스템연계 테이블
		}else if(sTable_Nm.equals("JIT9170")) {
			sql = "JiCmRsm.getTableMaxSeq";
		// 팝업
		}else if(sTable_Nm.equals("JRCMS_POPUP_ZONE")) {
			sql = "apDAO.getTableMaxSeq";
		// 접속로그
		}else if(sTable_Nm.equals("JIT8100")) {
			sql = "JiCmSti.getTableMaxSeq";
		// 조직관리
		}else if(sTable_Nm.equals("JIT9110")) {
			sql = "JiCmOam.getTableMaxSeq";
		// 사용자관리
		}else if(sTable_Nm.equals("JIT9111")){ 			
			sql = "JiCmOam.getTableMaxSeq2";
		// 관리자관리
		}else if(sTable_Nm.equals("JIT9120")){ 			
			sql = "JiCmOam.getTableMaxSeq3";
		// 권한그룹
		}else if(sTable_Nm.equals("JIT9130")){ 			
			sql = "JiCmOam.getTableMaxSeqJIT9130";
		// 권한그룹 메뉴
		}else if(sTable_Nm.equals("JIT9131")){ 			
			sql = "JiCmOam.getTableMaxSeqJIT9131";
		// 권한그룹 사용자
		}else if(sTable_Nm.equals("JIT9132")){ 			
			sql = "JiCmOam.getTableMaxSeqJIT9132";		
		// 첨부파일
		}else if(sTable_Nm.equals("JIT9132")){			
			sql = "JiCmMtm.getSequence";
		// 판매실적
		}else if (sTable_Nm.equals("JIT9704")){
			sql = "JiCmOam.getTableMaxSeqJIT9704";
		}else {
			sql = "cmDAO.getTableMaxSeq";	
		}
		Map param = new HashMap();
		param.put("sTable_Nm", sTable_Nm);
		param.put("sColumn_Nm", sColumn_Nm);
		param.put("WhereParam", WhereParam);
		
		
		try{
			
	    	List list =  list(sql, param);

	    	if (list==null || list.size()==0 || ((Integer)(list.get(0))).intValue() == 0) return 0;
	    	else return ((Integer)(list.get(0))).intValue();
	    	
	    	//((Integer)(list.get(0))).intValue()
			
		/*}catch(Exception e){
			return 0;*/
		}finally{
			log.debug("============== getTableMaxSeq : END ==============");
		}
	}
	
	/**
	* <p> 해당코드의 등록 코드값 생성 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* Postcondition: 조회 결과를 리턴한다 
	*
	* @param   TabName		String		테이블명
	* @param   ColName		String		컬럼명
	* @param   WhereStr		String		where조건
	* @param   ColLen		int			컬럼길이
	* 
	* @return  
	 * @throws ISPException 
	* @throws  
	*/
	public Map getMaxCode(String TabName,String ColName,int ColLen,String WhereStr, String UpCode) throws Exception {
		//	TODO getMaxCode		
		log.debug("============== getMaxCode : START ==============");
		
		String sql = "";	
		if(TabName.equals("JRCMS_CODE")) {
			sql = "acdDAO.getMaxCode";
			log.debug("============== acdDAO.getMaxCode BUNKI");
			
		// 메뉴관리
		}else if(TabName.equals("JIT9160")){
			sql = "JiCmMnm.getMaxCode";
			log.debug("============== JiCmMnm.getMaxCode BUNKI");
			
		// 코드관리
		}else if(TabName.equals("JIT9101")){
			sql = "JiCmCms.getMaxCode";
			log.debug("============== JiCmCms.getMaxCode BUNKI");	
			
		// 권한그룹관리
		}else if(TabName.equals("JIT9130")){
				sql = "JiCmOam.getMaxCode";
				log.debug("============== JiCmOam.getMaxCode BUNKI");			
			
		// 메뉴관리
		}else{
			sql = "JiCmMnm.getMaxCode";
			log.debug("============== JiCmMnm.getMaxCode BUNKI");
		}
		
		Map param = new HashMap();
		List list = new ArrayList();
		param.put("ColLen", ColLen);
		param.put("ColName", ColName);
		param.put("TabName", TabName);
		param.put("UpCode", UpCode);

		log.debug("============== getMaxCode : WhereStr :"+WhereStr);
		param.put("WhereStr", WhereStr);
		param.put("se_text", WhereStr);
		
		Map tmp_map = new HashMap();

		try{
			list = list(sql, param);
			
			if(list.size() > 0){
				tmp_map = (Map)list.get(0);
				String rtn_str = (String)tmp_map.get("maxCode");
			}else{
				String rtn_str = "";
				tmp_map = new HashMap();
			}
			

		}finally{
			log.debug("============== getMaxCode : END ==============");

		}
    	return tmp_map;		
		
	}	
	
	/**
	* <p> 해당코드의 등록 코드값 생성 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* Postcondition: 조회 결과를 리턴한다 
	*
	* @param   TabName		String		테이블명
	* @param   ColName		String		컬럼명
	* @param   WhereStr		String		where조건
	* @param   ColLen		int			컬럼길이
	* 
	* @return  
	 * @throws ISPException 
	* @throws  
	*/
	public int getSequence(String tablename) throws Exception {
		String sql = "cmDAO.getSequence";	
		Map param = new HashMap();
		param.put("tablename", tablename);
		List list = new ArrayList();

		list =  list(sql, param);
    	if (list==null || list.size()==0 || ((Integer)(list.get(0))).intValue() == 0) return 0;
    	else return ((Integer)(list.get(0))).intValue();
		
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
	public Map getAdmLogin (Map param) throws Exception {
		//	TODO getAdmLogin
		log.debug("==== getAdmLogin Start ====");
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();
		Map update_map = new HashMap();
		
		String id	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("id"),"") );
		String PassWord	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("PassWord"),"") );
		
		// sso 인증값을 확인한다 (실운영에 반영시 암호화된 쿠키값을 복호화하여 비교해야한다)
		String sso_cookie_val	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sso_cookie_val"),"") );
		/********* sso 인증 복호화 로직추가필요 복호화모듈 설치될경우 수정필요 ***********/
	    Runtime rt = Runtime.getRuntime();

	    if (!sso_cookie_val.equals("")) {
			// 암호화 쿠기 복호화 처리 실행 모듈 경로 및 파일명
	        String Bin_Path = "/app/tmax/seed_decode/seed_decode -d ";      
	        String run_path = Bin_Path + sso_cookie_val;
	        Process ps = rt.exec(run_path+"<BR>");
	        BufferedReader br = null;
	        try{
		        br =
			            new BufferedReader(
			                new InputStreamReader(
			                    new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));

			        sso_cookie_val = br.readLine();
			        param.put("sso_cookie_val", sso_cookie_val);	        	
	        }catch(IOException e){
	        	param.put("sso_cookie_val", "");
	        }catch(Exception e){
	        	param.put("sso_cookie_val", "");	        	
	        }finally{
	        	 if(br!=null)br.close();
	        }

	       

	    }	
	    
		// 관리자 체크모드 OI: 아이디로만 체크 IP:아이디,패스워드체크
		String admin_chkmode = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("admin_chkmode"),"") );

		String admauth ="";
		String login_fail_cnt ="";
		String sql = "amDAO.getAm_Master";
		//log.debug("==== sso_cookie_val ====:"+sso_cookie_val);
		//log.debug("==== id ====:"+id);
		//log.debug("==== PassWord ====:"+PassWord);
		//log.debug("==== admin_chkmode ====:"+admin_chkmode);
		List reslist =  list(sql, param);
		if(reslist != null){
			if(reslist.size() > 0){
				tmp_map = (Map)reslist.get(0);
				login_fail_cnt = (String)tmp_map.get("loginFailCnt");
				
				log.debug("22:"+id+"::"+PassWord+"::"+Integer.parseInt(login_fail_cnt)+"::"+tmp_map.get("admissionCd"));
				
				// 가입승인여부를 확인한다
				if("N".equals((String)tmp_map.get("admissionCd"))){
					result_map.put("AdmLogin", null);
					result_map.put("TRS_MSG","아직 가입승인이 처리되지않았습니다. 관리자에게 문의 하세요.");					
				}else{
						if(Integer.parseInt(login_fail_cnt) <= 3){
							admauth = HtmlTag.returnString((String)tmp_map.get("userGubun"),"");
							if(admauth.indexOf("I") > -1){	//관리자권한
								tmp_map.put("admauth", "Y");
							}
							result_map.put("AdmLogin", tmp_map);
							result_map.put("TRS_MSG","");
							update_map.put("user_id", id);
							update_map.put("user_gubun", admauth);
							update("amDAO.updateLogReset",update_map);						
							// 기존 비밀번호 체크로직은 제거한다 단방향암호화적용으로 쿼리단에서 체크하므로
							
						}else{
							result_map.put("AdmLogin", null);
							result_map.put("TRS_MSG","비밀번호를 3회 이상 틀렸습니다 관리자에게 문의 하세요.");
						}						
				}
			
				//log.debug("getMenuCfg :1");
			}else{
				log.debug("55:"+id+"::"+PassWord+"::");
				//log.debug("33:"+id+"::"+PassWord+"::"+tmp_map.get("AM_PWD"));
				update_map.put("user_id", id);
				update("amDAO.updateLogCnt",update_map);
				result_map.put("AdmLogin", null);
				if (!sso_cookie_val.equals("")) {
					result_map.put("TRS_MSG","현 시스템에 등록된 사용자가 아닙니다.");	
				}else{
					result_map.put("TRS_MSG","아이디 또는 비밀번호가 정확하지 않습니다.");	
				}
				
				//log.debug("getMenuCfg :2");
			}	
		}else{
			log.debug("66:"+id+"::"+PassWord+"::");
			//log.debug("33:"+id+"::"+PassWord+"::"+tmp_map.get("AM_PWD"));
			update_map.put("user_id", id);
			update("amDAO.updateLogCnt",update_map);
			result_map.put("AdmLogin", null);
			if (!sso_cookie_val.equals("")) {
				result_map.put("TRS_MSG","현 시스템에 등록된 사용자가 아닙니다.");	
			}else{
				result_map.put("TRS_MSG","아이디 또는 비밀번호가 정확하지 않습니다.");	
			}		
		}
    	log.debug("==== getAdmLogin End ====");
    	/*transactionManager.commit(txStatus);*/
		return result_map;
	}	
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 메뉴 환경설정을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  메뉴 환경설정의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getIpCfg(String user_ip) throws Exception {
		//	TODO getIpCfg
		log.debug("==== getIpCfg Start ====");
		Map result_map = new HashMap();
		Map tmp_map = new HashMap();
		List res_list = new ArrayList();
		user_ip = HtmlTag.returnString(user_ip,"");
		log.debug("==== user_ip ===="+user_ip);
		String trs_msg = "";
		String [] dec_col = {"acIp"};
		String sql = "JiCmCms.getIpCfg";	
		log.debug("==== user_ip.indexOf() ===="+user_ip.indexOf("."));
		// 개발모드 인경우 아이피를 체크하지않는다
		//if(propertiesService.getString("DEV_MODE").equals("D")){
			result_map.put("IPCFG", "1");
		// 운영모드 인경우 아이피를 체크한다
		//}else{
			if(user_ip.indexOf(".") < 0){
				result_map.put("IPCFG", "9999");
			// localhost인경우는 무조건 접속가능하다
			//}else if(user_ip.equals("127.0.0.1")){
			//	result_map.put("IPCFG", "1");
			}else{
				Map param = new HashMap();
				log.debug("user_ip 1:"+user_ip.substring(0, user_ip.lastIndexOf(".")));
				log.debug("user_ip 2:"+user_ip);
				/*// 암호화해서 비교한다
				param.put("user_ip1",JasyptUtil.JasyptEncode(user_ip.substring(0, user_ip.lastIndexOf("."))));
				param.put("user_ip2", JasyptUtil.JasyptEncode(user_ip));
				//param.put("user_ip1", user_ip.substring(0, user_ip.lastIndexOf(".")));
				//param.put("user_ip2", user_ip);
				
				res_list =  list(sql, param);

		    	if (res_list==null || res_list.size()==0 || ((Integer)(res_list.get(0))).intValue() == 0){
		    		result_map.put("IPCFG", "0");
		    		log.debug("getIpCfg result:000");
		    	}else{
		    		log.debug("getIpCfg result:"+res_list.get(0)+"::"+((Integer)(res_list.get(0))).intValue());
		    		result_map.put("IPCFG", ""+((Integer)(res_list.get(0))).intValue()) ;
		    	}*/
				// 암호화된 값이 계속변하여 데이터베이스에 있는 값을 모두 가져와서 복호화후 비교할수밖에 없다
				sql = "JiCmCms.getIpCfgList";	
				res_list =  list(sql, param);
				//res_list = cmsService.getGridListScrollDec(res_list, dec_col);
				res_list = cmsService.getGridListScroll(res_list);
				for(int i=0;i<res_list.size();i++){
					tmp_map = (Map)res_list.get(i);
					//log.debug("ac_ip::"+tmp_map.get("ac_ip"));
					if(user_ip.substring(0, user_ip.lastIndexOf(".")).equals((String)tmp_map.get("ac_ip"))
							|| user_ip.equals((String)tmp_map.get("ac_ip"))){
						result_map.put("IPCFG", "1");
						break;
					}else{
						result_map.put("IPCFG", "0");
					}
				}
				
				
			}			
		//}


    	
    	log.debug("==== getIpCfg End ====");
		return result_map;
	}	
	
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서  left메뉴 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  left메뉴관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getAdmLeft () throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getAdmLeft
		log.debug("==== getAdmLeft Start ====");
		Map result_map = new HashMap();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();
		
		
		String sql = "JiCmMnm.getMENU";
		List res = null;
		try{
			
			codeparam.put("all_fl", "000000");
			codeparam.put("level", 1);
			codeparam.put("adminmenu", "Y");
			
			res = list(sql, codeparam);
			
			result_map.put("ListFullLeft", res);			
	
	
			result_map.put("TRS_MSG","");
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(Exception q){
			log.debug("getAdmLeft Exception:");

			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");
		
		}
		

    	
    	log.debug("==== getAdmLeft End ====");
		return result_map;
	}
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서  left메뉴 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  left메뉴관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getAdmInfo () throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getAdmInfo
		log.debug("==== getAdmInfo Start ====");
		Map result_map = new HashMap();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();
		
		
		String sql = "JiCmCms.getAdmInfo";
		List res = null;
		try{
			
			codeparam.put("admid", "WwgKomipo");
			res = list(sql, codeparam);
			

				
				if(res.size() > 0){
					result_map.put("ADMININFO", (Map)res.get(0));
					//log.debug("getMenuCfg :1");
				}else{
					result_map.put("ADMININFO", null);
					//log.debug("getMenuCfg :2");
				}
				
				result_map.put("TRS_MSG","");
			
	
	
	
			result_map.put("TRS_MSG","");
		}catch(NullPointerException q){
			log.debug("getAdmInfo NullPointerException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("getAdmInfo ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(Exception q){
			log.debug("getAdmInfo getAdmLeft Exception:");

			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");
		
		}
		

    	
    	log.debug("==== getAdmInfo End ====");
		return result_map;
	}	

    	
	/**
	* <p> InsertFile(등록화면)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 InsertTab_FILE_MGR
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   FILE_ARR		ArrayList		파일정보 배열

	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map InsertFile(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO InsertFile 
		log.debug("==== InsertFile Start ====");
		Map result_map = new HashMap();
		Map mapdf2 = null;

		List file_arr	= (List)param.get("FILE_ARR");
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"000000") );
		String scode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		String RMAXIDX	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("RMAXIDX"),"0") );
		String [] FILE_OBJ_NM = null;
		if(param.get("FILE_OBJ_NM")!= null){
			FILE_OBJ_NM = (String [])param.get("FILE_OBJ_NM");
		}
		String APP_F = "";
		String APP_F_RENAME = "";
		String APP_F_SIZE = "";
		String USER_ID = "";
		log.debug("1===========================================================");
		//LoginInfo logininfo = (LoginInfo)param.get("logininfo");
		
		int max_seq = 0;
		int i = 0;
		int j = 0;
		int k = 0;
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){

	    // 일반사이트프로그램접속인경우
	    }else{
	    	SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));

	    }	    
	    if(SITE_SESSION==null){
	    	USER_ID = "";
	    }else{
	    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));		
	    }
	    

	    String sql = "cmDAO.InsertJRCMS_FILE_MGR";
	    Map file_param = new HashMap();
	    
		try{
			if(FILE_OBJ_NM!=null){
				for(j=0;j< FILE_OBJ_NM.length ;j++){
	
					for(i=0;i<file_arr.size();i++){
						//log.debug("21===========================================================");
						mapdf2 = (Map)file_arr.get(i);
						//log.debug("22==========================================================="+FILE_OBJ_NM.length);
						// 만일 파일form명이 배열일경우 배열에 담긴순서대로 무조건 등록한다
							if(FILE_OBJ_NM[j].equals((String)mapdf2.get("fileformName")) && !"".equals((String)mapdf2.get("fileName"))){
								max_seq = getTableMaxSeq("JRCMS_FILE_MGR","IDX","");
								file_param = new HashMap();
								//log.debug("23===========================================================");
								file_param.put("max_seq",max_seq);
								file_param.put("pcode",pcode);
								file_param.put("RMAXIDX",Integer.parseInt(RMAXIDX));
								file_param.put("fileName",(String)mapdf2.get("fileName"));
								file_param.put("maskName",(String)mapdf2.get("maskName"));

								
								//log.debug("24===========================================================");
								file_param.put("order_no",k);
								file_param.put("USER_ID",USER_ID);
								file_param.put("fileSize",(Long)mapdf2.get("fileSize"));
								
								insert(sql, file_param);
								
								log.debug("InsertFile FILE_OBJ_NM["+j+"]========"+FILE_OBJ_NM[j]);
								log.debug("InsertFile fileformName=============="+mapdf2.get("fileformName"));
								log.debug("InsertFile fileName=================="+mapdf2.get("fileName"));								
								log.debug("InsertFile max_seq=================="+max_seq);
								log.debug("InsertFile pcode=================="+pcode);
								log.debug("InsertFile RMAXIDX=================="+RMAXIDX);

								//log.debug("25===========================================================");
								k++;
							}
						}

	
				}
				//log.debug("InsertFile3===========================================================");
	
			}

			result_map.put("TRS_MSG","");
		}catch(IOException q){
			log.error("IOException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(SQLException q){
			log.error("SQLException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(NullPointerException q){
			log.error("NullPointerException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(Exception q){
			log.error("InsertFile:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");			

		}
		log.debug("==== InsertFile END ====");

		return result_map;	
	}
	
	
	/**
	* <p> UpdateFile(등록화면)에서 해당데이터를 수정하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 InsertTab_FILE_MGR
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   FILE_ARR		List		파일정보 배열

	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map UpdateFile(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO UpdateFile 
		log.debug("==== UpdateFile : START ====");		
		Map result_map = new HashMap();
		Map mapdf2 = null;

		List file_arr	= (List)param.get("FILE_ARR");
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"000000") );
		String scode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		String RMAXIDX	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("RMAXIDX"),"0") );
		String [] FILE_OBJ_NM = (String [])param.get("FILE_OBJ_NM");
		String APP_F = "";
		String APP_F_RENAME = "";
		String APP_F_SIZE = "";
		String USER_ID = "";
		//LoginInfo logininfo = (LoginInfo)param.get("logininfo");
		
		int max_seq = 0;
		int i = 0;
		int j = 0;
		int k = 0;
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    if(SITE_SESSION == null) {
	    	SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    }
	    if(SITE_SESSION==null){
	    	USER_ID = "";
	    }else{
	    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));		
	    }	    
	    	

		// 데이터베이스에 결과를 저장한다.

		int chk_cnt  = 0;
		String rsIDX = "";
		String rsM_CODE = "";
		String rsRIDX = "";
		String rsFILE_NM = "";
		String rsRFILE_NM = "";
		String rsORDER_NO = "";
		String rsREG_DT = "";
		String docsave_root = propertiesService.getString("UPLOADROOTPATH");
		
		String sql = "";
		Map tmp_map  = new HashMap();
		Map file_param = new HashMap();
		
		try{

			for(j=0;j< FILE_OBJ_NM.length ;j++){
				for(i=0;i<file_arr.size();i++){
					mapdf2 = (Map)file_arr.get(i);
				
					chk_cnt  = 0;
					if(FILE_OBJ_NM[j].equals((String)mapdf2.get("fileformName"))){
						// 파일명이 있을경우 해당파일을 데이터 베이스에 저장, 수정해야하는지 확인한다
						sql = "JiCmCms.getFILE_MGR_Chk";
						file_param = new HashMap();
						file_param.put("pcode", pcode);
						file_param.put("RMAXIDX", Integer.parseInt(RMAXIDX));
						file_param.put("order_no", k);

						List chk_list =  list(sql, file_param);
						if (chk_list!=null && chk_list.size()>0 )
							tmp_map = (Map)chk_list.get(0);
							//(Integer)(chk_list.get(0))).intValue()
							rsIDX =  (String)tmp_map.get("idx");
							rsM_CODE = (String)tmp_map.get("mCode");
							rsRIDX = (String)tmp_map.get("ridx");
							rsFILE_NM = (String)tmp_map.get("fileNm");
							rsRFILE_NM = (String)tmp_map.get("rfileNm");
							rsORDER_NO = (String)tmp_map.get("orderNo");
							rsREG_DT = (String)tmp_map.get("regDt");
						}
						
						if(!((String)mapdf2.get("fileName")).equals("")){

							// chk_cnt가 0이면 등록 0보다크면 수정
							// 등록
							if(chk_cnt == 0){
								max_seq = getTableMaxSeq("JRCMS_FILE_MGR","IDX","");
								sql = "JiCmCms.InsertFILE_MGR";
								file_param = new HashMap();
								
								file_param.put("max_seq",max_seq);
								file_param.put("pcode",pcode);
								file_param.put("RMAXIDX",Integer.parseInt(RMAXIDX));
								file_param.put("fileName",(String)mapdf2.get("fileName"));
								file_param.put("maskName",(String)mapdf2.get("maskName"));

								
								//log.debug("24===========================================================");
								file_param.put("order_no",k);
								file_param.put("USER_ID",USER_ID);
								file_param.put("fileSize",(Long)mapdf2.get("fileSize"));
								
								insert(sql, file_param);
								
							// 수정
							}else{
								// 만일 삭제이면
								if(((String)mapdf2.get("chk_file_del")).equals("Y")){
									// 실재 파일도 삭제한다
									FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);
									sql = "cmDAO.DeleteJRCMS_FILE_MGR";
									file_param = new HashMap();
									file_param.put("pcode",pcode);
									file_param.put("RMAXIDX",Integer.parseInt(RMAXIDX));
									file_param.put("order_no",k);
									delete(sql, file_param);
								// 수정이면
								}else{
									// 기존파일을 삭제한다
									// 실재 파일도 삭제한다
									FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);									
									sql = "cmDAO.UpdateJRCMS_FILE_MGR";
									file_param = new HashMap();
									file_param.put("fileName",(String)mapdf2.get("fileName"));
									file_param.put("maskName",(String)mapdf2.get("maskName"));
									file_param.put("fileSize",(Long)mapdf2.get("fileSize"));
									file_param.put("USER_ID",USER_ID);
									file_param.put("pcode",pcode);
									file_param.put("RMAXIDX",Integer.parseInt(RMAXIDX));
									file_param.put("order_no",k);									
									update(sql, file_param);
									
								}
							}							
						// 파일명이 없을경우는 현상태를 유지한다
						}else{
							// 만일 삭제이면 
							if(((String)mapdf2.get("chk_file_del")).equals("Y")){
								// 실재 파일도 삭제한다
								FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);
								sql = "cmDAO.DeleteJRCMS_FILE_MGR";
								file_param = new HashMap();
								file_param.put("pcode",pcode);
								file_param.put("RMAXIDX",Integer.parseInt(RMAXIDX));
								file_param.put("order_no",k);
								delete(sql, file_param);
							}							
						}
						

						k++;
					}
				}
		

			result_map.put("TRS_MSG","");
		}catch(IOException q){
			log.error("IOException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");			
		}catch(SQLException q){
			log.error("SQLException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");			
		}catch(NullPointerException q){
			log.error("NullPointerException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");			
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(Exception q){
			log.error("UpdateFile:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");			

		}
		log.debug("==== UpdateFile : END ====");

		return result_map;	
	}	
	
	/**
	* <p> 코드트리를 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  메뉴 환경설정의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getCode_Select (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getCode_Select
		log.debug("==== getCode_Select Start ====");
		Map result_map = new HashMap();
		String all_fl	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("all_fl"),"") );
		String del_yn	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("del_yn"),"") );
		String notinstr = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("notinstr"),"") );
		String inout_fl = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("inout_fl"),"") );
		String lim_lv = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("lim_lv"),"") );
		String trs_msg = "";


		List res = new ArrayList();
		String sql = "";
		Map query_param = new HashMap();
		try{
			// 전체 코드리스트를 가져온다
			sql = "JiCmCms.getCODESelect";

			query_param.put("all_fl",all_fl);
			query_param.put("lim_lv",lim_lv);
			query_param.put("del_yn",del_yn);
			query_param.put("notinstr",notinstr);
			query_param.put("inout_fl",inout_fl);
	
			
			res = list(sql,query_param);
			result_map.put("ListTreeACD", res);	
		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(Exception q){	
			log.debug("Exception:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");
			throw new Exception("getCode_Select 조회중 에러가 발생했습니다");				
		
		}
		

    	result_map.put("TRS_MSG","");
    	log.debug("==== getCode_Select End ====");
		return result_map;
	}
	
	
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 에디터 이미지 업로드관리관련 DAO를 제어하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  에디터 이미지 업로드관련 결과값을 리턴한다
	* @throws  
	*/
	public Map ctlEDT (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO ctlEDT
		log.debug("==== ctlEDT Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		try{
			// 목록조회
			/*log.debug("==== ctlAC pstate:"+pstate+" ====");
			Iterator ir  = param.keySet().iterator();
			String mkey = "";
			while(ir.hasNext()){
				mkey = (String)ir.next();
				log.debug("ctlAC PARAMETER--"+mkey+":"+param.get(mkey));
				
			}*/
			
			if(pstate.equals("L")){
			// 에디터 이미지 업로드 정보를 리턴한다.
			}else if(pstate.equals("C")){
				result_map.put("EDIT_IMG_INFO",(List)param.get("FILE_ARR"));
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			// 에디터 이미지 다운로드 인경우
			}else if(pstate.equals("DO")){
				
			}

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
			
		}catch(Exception q){			
			log.debug("ctlEDT Exception:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}	
		}
		
    	log.debug("==== ctlEDT End ====");
		return result_map;
	}
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 파일다운로드정보를 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  파일다운로드정보의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getFileInfo (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getFileInfo
		log.debug("==== getFileInfo Start ====");
		Map result_map = new HashMap();
		String fpcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("fpcode"),"000000") );
		String sidx	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0") );
		String fidx	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("fidx"),"0") );

		String trs_msg = "";

		
		String sql = "";
		Map query_param = new HashMap();
		List sres = new ArrayList();
		try{
			sql = "cmDAO.getJRCMS_FILE_MGR_Chk";

			query_param.put("pcode",fpcode);
			query_param.put("RMAXIDX",sidx);
			query_param.put("order_no",fidx);

	
			
			sres = list(sql,query_param);
			
				if(sres.size() > 0){
					result_map.put("getFileInfo", (Map)sres.get(0));
					//log.debug("getMenuCfg :1");
				}else{
					result_map.put("getFileInfo", null);
					//log.debug("getMenuCfg :2");
				}
		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");
		}catch(Exception q){
			log.debug("getFileInfo Exception:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");			
		}
		

    	result_map.put("TRS_MSG","");
    	log.debug("==== getFileInfo End ====");
		return result_map;
	}
	
	/**
	* <p> DeleteFile(등록화면)에서 해당데이터를 수정하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 InsertTab_FILE_MGR
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   FILE_ARR		List		파일정보 배열

	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map DeleteFile(String pcode, String [] file_del_arr, String USER_ID) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO DeleteFile 
		log.debug("==== DeleteFile : START ====");		
		Map result_map = new HashMap();


		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		List sres = new ArrayList();
		Map tmp_map = new HashMap();
		int chk_cnt  = 0;
		int rsIDX = 0;
		String rsM_CODE = "";
		int rsRIDX = 0;
		String rsFILE_NM = "";
		String rsRFILE_NM = "";
		int rsORDER_NO = 0;
		String rsREG_DT = "";
		String docsave_root = propertiesService.getString("UPLOADROOTPATH");
		
		int j=0;
		
		try{
			//DbHelper.setAutoCommit(false);
			if(file_del_arr!=null){
				for(j=0;j< file_del_arr.length ;j++){
					if(!file_del_arr[j].equals("")){
							// 삭제할 파일의 idx가 있으면 파일정보를  확인한다
							sql = "cmDAO.getJRCMS_FILE_MGR_Chk2";
							query_param = new HashMap();
							query_param.put("pcode", pcode);
							query_param.put("sidx", Integer.parseInt(file_del_arr[j]));
							sres = list(sql, query_param);

							chk_cnt = sres.size();
							// 삭제할 파일정보를 불러온경우
							if(sres.size() > 0){
								tmp_map = (Map)sres.get(0);
								//(Integer)(chk_list.get(0))).intValue()
								rsIDX =  Integer.parseInt(String.valueOf(tmp_map.get("idx")));
								rsM_CODE = (String)tmp_map.get("mCode");
								rsRIDX = Integer.parseInt(String.valueOf(tmp_map.get("ridx")));
								rsFILE_NM = (String)tmp_map.get("fileNm");
								rsRFILE_NM = (String)tmp_map.get("rfileNm");
								rsORDER_NO = Integer.parseInt(String.valueOf(tmp_map.get("orderNo")));
								rsREG_DT = (String)tmp_map.get("regDt");

								//log.debug("DeleteFile :"+rsIDX+"::"+rsRIDX+"::"+pcode+"::"+rsORDER_NO);
								
								// 실재 파일도 삭제한다
								FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);
								
								sql = "cmDAO.DeleteJRCMS_FILE_MGR";
								query_param = new HashMap();
								query_param.put("pcode", pcode);
								query_param.put("RMAXIDX", rsRIDX);
								query_param.put("order_no", rsORDER_NO);
								
								delete(sql, query_param);	
								
								// 해당 파일의 빠진순번만큼 순번을 재조정한다
								sql = "cmDAO.updateDelFILE_MGR";
								query_param = new HashMap();
								query_param.put("pcode", pcode);
								query_param.put("RMAXIDX", rsRIDX);
								query_param.put("order_no", rsORDER_NO);
								
								update(sql, query_param);	

								
							// 삭제할 파일 정보를 못불러올경우
							}else{
								result_map.put("TRS_MSG","파일 삭제중 삭제할 파일정보를 불러오지 못했습니다..");
							}
						}

					}				
			}



			//DbHelper.commitTrans();
			//DbHelper.setAutoCommit(true);				

			result_map.put("TRS_MSG","");
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","파일 삭제중 에러가 발생했습니다.");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일 삭제중 에러가 발생했습니다.");		
		}catch(Exception q){
			log.error("DeleteFile:");
			result_map.put("TRS_MSG","파일 삭제중 에러가 발생했습니다.");			

		}
		log.debug("==== DeleteFile : END ====");

		return result_map;	
	}
	
	
	/**
	* <p> InsertFile(등록화면)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 InsertTab_FILE_MGR
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   FILE_ARR		ArrayList		파일정보 배열

	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map InsertFile2(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO InsertFile 
		log.debug("==== InsertFile2 Start ====");
		Map result_map = new HashMap();
		Map mapdf2 = null;

		List file_arr	= (List)param.get("FILE_ARR");
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		String RMAXIDX	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("RMAXIDX"),"0") );
		//log.debug("RMAXIDX:" + RMAXIDX);
		String [] FILE_OBJ_NM = null;
		if(param.get("FILE_OBJ_NM")!= null){
			FILE_OBJ_NM = (String [])param.get("FILE_OBJ_NM");
		}
		String APP_F = "";
		String APP_F_RENAME = "";
		String APP_F_SIZE = "";
		String USER_ID = "";
		//log.debug("1===========================================================");
		//LoginInfo logininfo = (LoginInfo)param.get("logininfo");
		
		int max_seq = 0;
		//int max_ord = 0;
		int i = 0;
		int j = 0;
		int k = 0;
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){

	    // 일반사이트프로그램접속인경우
	    }else{
	    	SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));

	    }	
	    if(SITE_SESSION==null){
	    	USER_ID = "";
	    }else{
	    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));		
	    }	    
	
	    //log.debug("2===========================================================");
		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		List sres = new ArrayList();
		Map tmp_map = new HashMap();
		int forder_no = 0;
		
		try{
			if(FILE_OBJ_NM!=null){
				for(j=0;j< FILE_OBJ_NM.length ;j++){
	
					//log.debug("21==========FILE_OBJ_NM["+j+"]========"+FILE_OBJ_NM[j]);
					for(i=0;i<file_arr.size();i++){
						//log.debug("21===========================================================");
						mapdf2 = (Map)file_arr.get(i);
						//log.debug("21==========fileformName========"+mapdf2.get("fileformName"));
						//log.debug("21==========fileName========"+mapdf2.get("fileName"));
						// 만일 파일form명이 배열일경우 배열에 담긴순서대로 무조건 등록한다
							if(FILE_OBJ_NM[j].equals((String)mapdf2.get("fileformName")) && !"".equals((String)mapdf2.get("fileName"))){
								max_seq = getTableMaxSeq("JRCMS_FILE_MGR","IDX","");
								//max_ord = DbCommon.getTableMaxSeq(Tab_JRCMS_FILE_MGR,"ORDER_NO"," WHERE M_CODE='"+pcode+"' AND RIDX="+RMAXIDX+" ");
								// IF(ISNULL(MAX(ORDER_NO)),0,IFNULL(MAX(ORDER_NO),0)+1)
								sql = "cmDAO.getJRCMS_FILE_MGR2_ORDER";
								query_param = new HashMap();
								query_param.put("pcode", pcode);
								query_param.put("RMAXIDX", Integer.parseInt(RMAXIDX));
//								forder_no = (Integer)getSqlMapClientTemplate().queryForObject(sql, query_param);
								forder_no = getInt(sql, query_param);
								
								list(sql ,query_param).get(0);
								sql = "cmDAO.InsertJRCMS_FILE_MGR2";
								query_param = new HashMap();
								query_param.put("max_seq", max_seq);
								query_param.put("pcode", pcode);
								query_param.put("forder_no", forder_no);
								query_param.put("RMAXIDX", Integer.parseInt(RMAXIDX));
								query_param.put("fileName", (String)mapdf2.get("fileName"));
								query_param.put("maskName", (String)mapdf2.get("maskName"));
								query_param.put("USER_ID", USER_ID);
								query_param.put("fileSize", (Long)mapdf2.get("fileSize"));
								
								insert(sql, query_param);
								//log.debug("25===========================================================");
								k++;
							}
						}

	
				}
				//log.debug("InsertFile3===========================================================");
	
			}

			result_map.put("TRS_MSG","");
		}catch(IOException q){
			log.error("IOException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(SQLException q){
			log.error("SQLException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(NullPointerException q){
			log.error("NullPointerException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");		
		}catch(Exception q){
			log.error("Exception:");
			result_map.put("TRS_MSG","파일 저장중 에러가 발생했습니다.");
		}
		log.debug("==== InsertFile2 END ====");

		return result_map;	
	}	
		
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 파일다운로드정보를 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  파일다운로드정보의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getSawon (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getSawon
		log.debug("==== getSawon Start ====");
		Map result_map = new HashMap();
		String se_field	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_field"),"") );
		String se_text = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_text"),"") );
		int curr_page		= Integer.parseInt(HtmlTag.returnString((String)param.get("curr_page"),"1"),10);		
		int show_rows		= Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"10"),10);		

    	Map tmp_page_map = new HashMap();
    	String sql = "";
    	int totalPages = 0;
    	int totalCount = 0;
	
	    int firstRow =1;
	    int endRow = 1; 

		

		List res_list = new ArrayList();
		Map query_param = new HashMap();
		try{
			sql = "cmDAO.getSawonInfo_Cnt";	
			query_param.put("se_field", se_field);
			query_param.put("se_text", se_text);
			query_param.put("curr_page", curr_page);
			query_param.put("show_rows", show_rows);
			
//			totalCount = (Integer)getSqlMapClientTemplate().queryForObject(sql, query_param);
			totalCount = getInt(sql, query_param);
	    	tmp_page_map.put("setTotalCount", totalCount);
	    	
	    	log.debug("cmDAO.getSawonInfo_Cnt:PageListSawon:totalCount:"+totalCount);
	    	
	    	
		    totalPages = (int) Math.ceil( (double) totalCount / ( (double) show_rows));    	
		    tmp_page_map.put("setPageSize",Integer.toString(show_rows));
		    tmp_page_map.put("setTotalPageCount",Integer.toString(totalPages));
		    firstRow = (curr_page * show_rows) - show_rows;
		    endRow = curr_page * show_rows; 
		    
		    log.debug("cmDAO.getSawonInfo_Cnt:PageListSawon:firstRow:"+firstRow+":endRow:"+endRow);
		    
		    query_param.put("firstRow", firstRow);
		    query_param.put("endRow", endRow);
		    
		    sql = "cmDAO.getSawonInfo";
		    
		    tmp_page_map.put("setList",list(sql, query_param));
		    tmp_page_map.put("setCurrentPage",Integer.toString(curr_page));    	
	    	
	    	result_map.put("PageListSawon",tmp_page_map);
	    	
	
			result_map.put("TRS_MSG","");
			

		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");
		}catch(Exception q){
			log.debug("getFileInfo Exception:");
			result_map.put("TRS_MSG","파일정보조회중 에러가 발생했습니다");			
		}
		

    	result_map.put("TRS_MSG","");
    	log.debug("==== getSawon End ====");
		return result_map;
	}	
	
	
	
	
	   /**
		 * 그리드 데이터 저장
		 * @param param - 그리드 저장 정보가 담김 값 , sql_id  - 저장을 실행할 쿼리 id , param_grid - jsp 에서 지정한 그리드 데이터의 param key
		 * @return result_map - 결과값 리턴
		 * @exception Exception
		 */
		public Map insertGridData(Map param, String sql_id,String param_grid) throws SQLException, JSysException, NullPointerException, ArrayIndexOutOfBoundsException, Exception  {
			log.debug("==== insertGridData : START ====");
			Map result_map = new HashMap();
			try{
				JSONArray jsonArray = JSONArray.fromObject(((String) param.get(param_grid)).replaceAll("&amp;amp;quot;", "\""));
				Map  jsonObjmap = new HashMap();
				for(int i=0;i<jsonArray.size();i++){
					jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
					Iterator iterator = jsonObjmap.entrySet().iterator();
					  while (iterator.hasNext()) {
					   Entry entry = (Entry)iterator.next();
					   param.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
					  }
				  insert(sql_id, param);
				}
				result_map.put("result", true);
				result_map.put("TRS_MSG",super.getMessage("ji.cm.common.msg.success.save"));	//저장되었습니다.
			}catch(JSysException q){	
				log.debug("throw JSysException >>>>> :  ");	
				throw q;		
				//TODO 추후 DB메시지 추출하여 예외처리별 메시지처리 예정	
//				}catch(SQLException q){				
//					log.debug("insertResultData Exception:");	
//					String errMsg = getTberoErrMsg();
//					throw new JSysException(result_map, errMsg,q);		
//					throw new JSysException(super.getMessage("ji.sm.common.msg.error.save"),q);							
			}catch(NullPointerException q){
				log.debug("NullPointerException:");
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.
			}catch(ArrayIndexOutOfBoundsException q){
				log.debug("ArrayIndexOutOfBoundsException:");
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.
			}catch(Exception q){				
				log.debug("JSysException Exception >>>>> :  ");	
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.
			}	
			log.debug("==== insertGridData : END ====");
			return result_map;	
		}
		
		/**
		 * 데이터 저장
		 * @param param -저장정보가 담김 값 , sql_id  - 저장을 실행할 쿼리 id
		 * @return result_map - 결과값 리턴
		 * @exception Exception
		 */
		public Map insertData(Map param, String sql_id) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
			log.debug("==== insertData : START ====");
			Map result_map = new HashMap();
			try{
				insert(sql_id, param);
				result_map.put("result", true);
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		
			}catch(NullPointerException q){
				log.debug("NullPointerException:");
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertData Exception:");	
				throw q;
			}catch(ArrayIndexOutOfBoundsException q){
				log.debug("ArrayIndexOutOfBoundsException:");
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertData Exception:");		
				throw q;
			}catch(Exception q){
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertData Exception:");			
				throw q;
			}finally{
				result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
			}
			log.debug("==== insertData : END ====");
			return result_map;	
		}		
		/**
		 * 데이터 저장
		 * @param param -결재정보가 담김 값
		 * @return result_map - result_map.get("appr_key") 값에 결재 번호 값 리턴
		 * @exception Exception
		 */
		public Map insertApprData(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
			log.debug("==== insertData : START ====");
			long getApprNumber =0;
			Map result_map = new HashMap();
			String tablename = "JIT9141";
			try{
				
				getApprNumber = getSequence(tablename);
				
				param.put("real_stat_no",  Long.toString(getApprNumber));
				
				log.debug("JSONDataList   "+param.get("JSONDataList"));
				log.debug("ApprJSONDataList   "+param.get("ApprJSONDataList"));
				result_map = insertData(param,"cmApmDAO.insertJIT9142"); //결재 상태 마스터 저장
				
				result_map = insertGridData(param,"cmApmDAO.insertJIT9143","ApprJSONDataList"); //결재상태 detail 저장 (실 결재선 저장)
				result_map.put("appr_key",Long.toString(getApprNumber));
				result_map.put("result", true);
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		
			}catch(NullPointerException q){
				log.debug("NullPointerException:");
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertApprData Exception:");	
				throw q;
			}catch(ArrayIndexOutOfBoundsException q){
				log.debug("ArrayIndexOutOfBoundsException:");
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertApprData Exception:");		
				throw q;
			}catch(Exception q){
				result_map.put("result","등록중에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
				log.debug("insertApprData Exception:");			
				throw q;
			}finally{
				result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
			}
			log.debug("==== insertData : END ====");
			return result_map;	
		}				
		/**
		 * Method Name  : getGridList
		 * Description  : 
		* Comment      : 
		* Parameter    : param - 정보가 담긴 Map ,sql_id 조회 할 sqlid
		* form History : 2015/02/16 : 박창현:  최초작성
		*/
		public Map selectListGrid (Map param,String sql_id) throws Exception {
			//	TODO getListACD
			log.debug("==== getGridList Start ====");
			Map result_map = new HashMap();
			int curr_page = Integer.parseInt(HtmlTag.returnString((String)param.get("curr_page"),"1"),10);		
			int show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"10"),10);
			log.debug("==== getGridList show_rows===="+show_rows);
			if(param.get("jqGrid.page")!=null){
				curr_page = Integer.parseInt(HtmlTag.returnString((String)param.get("jqGrid.page"),"1"),10);		//com.js를 사용하는 jqgrid는 그리드변수를 이와 같이 변경필요	-mrkim (2015/06/18))
				show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("jqGrid.rows"),"15"),10);	    //com.js를 사용하는 jqgrid는 그리드변수를 이와 같이 변경필요	-mrkim (2015/06/18))
			}
			log.debug("==== getGridList show_rows===="+show_rows);
			log.debug("==== getGridList 1111111111111111====");
			int totalCount = 0;
			Page page = new Page();
			
			try{
				
				//오라클, TIBERO
				//if(propertiesService.getString("CMS_DB_TYPE").equals("ORACLE")
				//		|| propertiesService.getString("CMS_DB_TYPE").equals("TIBERO")){
					page = getPageGridPaging(sql_id, param, curr_page, show_rows);
				//MSSQL
				//}else if(propertiesService.getString("CMS_DB_TYPE").equals("MSSQL")){
				//	page = getPageGridPagingMsSql(sql_id, param, curr_page, show_rows);
				//}				
					log.debug("==== getGridList 222222222222222====");
				totalCount = page.getTotalCount();
				List gridList = new ArrayList();
				if(page!=null){
					gridList = cmsService.getGridList(page); //그리드 데이터 반화
					//ajax jqGrid data관련
					result_map.put("page", page.getCurrentPage()); //현재 page번호
					result_map.put("total", page.getMaxPage()); //전체 page번호
					result_map.put("records", page.getTotalCount()); //전체 record수
					result_map.put("rows",gridList);
				}else{
					result_map.put("page", page.getCurrentPage()); //현재 page번호
					result_map.put("total", page.getMaxPage()); //전체 page번호
					result_map.put("records", page.getTotalCount()); //전체 record수
					result_map.put("rows",gridList);					
				}
			}finally{
				log.debug("==== getGridList 33333333333333333====");
			}
	    	log.debug("==== getGridList End ====");
			return result_map;
		}		

		/**
		 * Method Name  : getBarPieChartList
		 * Description  : 
		* Comment      : 
		* Parameter    : param - 정보가 담긴 Map ,sql_id 조회 할 sqlid
		* form History : 2015/02/16 : 박창현:  최초작성
		*/
		public Map selectListBarPieChart (Map param,String sql_id) throws Exception {
			//	TODO getBarChartList
			log.debug("==== getBarChartList Start ====");
			Map result_map = new HashMap();
			Map BarPieChartMap = new HashMap();
			List rtn_list = new ArrayList();
			List s1 = new ArrayList();
			List s2 = new ArrayList();
			List s3 = new ArrayList();
			List s4 = new ArrayList();
			List s5 = new ArrayList();			
			List dt = new ArrayList();
			List name = new ArrayList();
			List line1 = new ArrayList();
			List line2 = new ArrayList();
			List line3 = new ArrayList();
			List line4 = new ArrayList();
			List line5 = new ArrayList();
			List line6 = new ArrayList();
			List line7 = new ArrayList();
			List line8 = new ArrayList();
			List line9 = new ArrayList();
			List line10 = new ArrayList();
			List line11 = new ArrayList();
			List data = new ArrayList();
			List data1 = new ArrayList();
			List data2 = new ArrayList();
			List data3 = new ArrayList();
			List data4 = new ArrayList();
			
			try{
					rtn_list = list(sql_id, param);
					if(rtn_list.size() < 1){
						result_map.put("TRS_MSG","차트데이터가 없습니다.");
						result_map.put("result",false);
						return result_map;	
					}else{
						for(int i=0; i<rtn_list.size(); i++){
							result_map = (Map)rtn_list.get(i);
							s1 = new ArrayList();
							s2 = new ArrayList();
							s3 = new ArrayList();
							s4 = new ArrayList();
							s5 = new ArrayList();
							
							
							if(result_map.get("name") != null){
								s1.add(StringUtil.strCut((String)result_map.get("name"),50));
							}else{
								s1.add(result_map.get("name"));
							}
							s1.add(result_map.get("line1"));
							
							s2.add(result_map.get("line1"));
							if(result_map.get("name") != null){
								s2.add(StringUtil.strCut((String)result_map.get("name"),50));
							}else{
								s2.add(result_map.get("name"));
							}					
							s3.add(result_map.get("line2"));
							if(result_map.get("name") != null){
								s3.add(StringUtil.strCut((String)result_map.get("name"),50));
							}else{
								s3.add(result_map.get("name"));
							}
							s4.add(result_map.get("line3"));
							if(result_map.get("name") != null){
								s4.add(StringUtil.strCut((String)result_map.get("name"),50));
							}else{
								s4.add(result_map.get("name"));
							}
							s5.add(result_map.get("line4"));
							if(result_map.get("name") != null){
								s5.add(StringUtil.strCut((String)result_map.get("name"),50));
							}else{
								s5.add(result_map.get("name"));
							}
							
		
							name.add(result_map.get("name"));
							line1.add(result_map.get("line1"));
							line2.add(result_map.get("line2"));
							line3.add(result_map.get("line3"));
							line4.add(result_map.get("line4"));
							line5.add(result_map.get("line5"));
							line6.add(result_map.get("line6"));
							line7.add(result_map.get("line7"));
							line8.add(result_map.get("line8"));
							line9.add(result_map.get("line9"));
							line10.add(result_map.get("line10"));
							line11.add(result_map.get("line11"));
							dt.add(result_map.get("dt"));
							data.add(s1);
							data1.add(s2);
							data2.add(s3);
							data3.add(s4);
							data4.add(s5);
						
						}
					
						BarPieChartMap.put("dt", dt);
						BarPieChartMap.put("name", name);
						BarPieChartMap.put("line1", line1);
						BarPieChartMap.put("line2", line2);
						BarPieChartMap.put("line3", line3);
						BarPieChartMap.put("line4", line4);
						BarPieChartMap.put("line5", line5);
						BarPieChartMap.put("line6", line6);
						BarPieChartMap.put("line7", line7);
						BarPieChartMap.put("line8", line8);
						BarPieChartMap.put("line9", line9);
						BarPieChartMap.put("line10", line10);
						BarPieChartMap.put("line11", line11);
						BarPieChartMap.put("barchart", data);
						BarPieChartMap.put("horizonbarchart", data1);
						BarPieChartMap.put("data1", data1);
						BarPieChartMap.put("data2", data2);
						BarPieChartMap.put("data3", data3);
						BarPieChartMap.put("data4", data4);
						BarPieChartMap.put("result", true);
						log.debug("==== getBarChartList End ===="+BarPieChartMap);			
						return BarPieChartMap;
					}
			}catch(JSysException q){	
				log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
				throw q;		
			}catch(NullPointerException q){
				log.debug("ctlCMS NullPointerException:"+q);
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
			}catch(ArrayIndexOutOfBoundsException q){
				log.debug("ctlCMS ArrayIndexOutOfBoundsException:"+q);
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
			}catch(Exception q){
				log.debug("ctlCMS Exception >>>>> :  "+q);	
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		
			}					
		}	
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionList(String code_id, String selValue) throws Exception {
			log.debug("======== bizMakeOptionList 11 ============");
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();

	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		String 		 hide = "";
	  		List rtn_list = new ArrayList();
	  		
			param.put("all_fl", code_id);
			param.put("del_yn", "N"); // DEL_YN
			param.put("notinstr", "");
			param.put("inout_fl", "");
			
	  		rtn_list = list("JiCmCms.getCODESelect", param);
	  		
	  		log.debug("======== bizMakeOptionList 22 ============");
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
			  			temp = (Map)rtn_list.get(i);
			  			code = (String)temp.get("stdinfoDtlCd");
			  			name = (String)temp.get("stdinfoDtlNm");
			  			sel  = (selValue.trim().equals(code.trim()) ) ? "selected" : "";
			  			id   = (String) temp.get("stdinfoDtlSeq");
			  			hide = HtmlTag.returnString((String) temp.get("hideyn"),"N");
		  			
			  			if(!hide.equals("Y")){
			  				/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
			  				sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
			  			}
		  			}
	  	return sb.toString();
	}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionListText(String code_id, String selValue) throws Exception {
			log.debug("======== bizMakeOptionListText 11 ============");
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();

	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		String 		 hide = "";
	  		List rtn_list = new ArrayList();
	  		
			param.put("all_fl", code_id);
			param.put("del_yn", "N"); // DEL_YN
			param.put("notinstr", "");
			param.put("inout_fl", "");
			
	  		rtn_list = list("JiCmCms.getCODESelect", param);
	  		
	  		log.debug("======== bizMakeOptionListText 22 ============");
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
			  			temp = (Map)rtn_list.get(i);
			  			code = (String)temp.get("stdinfoDtlCd");
			  			name = (String)temp.get("stdinfoDtlNm");
			  			sel  = (selValue.trim().equals(name.trim()) ) ? "selected" : "";
			  			id   = (String) temp.get("stdinfoDtlSeq");
			  			hide = HtmlTag.returnString((String) temp.get("hideyn"),"N");
		  			
			  			if(!hide.equals("Y")){
			  				/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
			  				sb.append("<option value='" + name + "' id='" + id + "'" + sel + ">" + name + "</option>");
			  			}
		  			}
	  	return sb.toString();
	}		
		
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionListLabel(String code_id, String selValue) throws Exception {
			log.debug("======== bizMakeOptionList 11 ============");
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();

	  		String       code = "";
	  		String		 name = "";
	  		String       label = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		String 		 hide = "";
	  		List rtn_list = new ArrayList();
	  		
			param.put("all_fl", code_id);
			param.put("del_yn", "N"); // DEL_YN
			param.put("notinstr", "");
			param.put("inout_fl", "");
			
	  		rtn_list = list("JiCmCms.getCODESelect", param);
	  		
	  		log.debug("======== bizMakeOptionList 22 ============");
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
			  			temp = (Map)rtn_list.get(i);
			  			code = (String)temp.get("stdinfoDtlCd");
			  			name = (String)temp.get("stdinfoDtlNm");
			  			label = (String)temp.get("stdinfoDtlLabel");
			  			sel  = (selValue.trim().equals(code.trim()) ) ? "selected" : "";
			  			id   = (String) temp.get("stdinfoDtlSeq");
			  			hide = HtmlTag.returnString((String) temp.get("hideyn"),"N");
		  			
			  			if(!hide.equals("Y")){
			  				/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
			  				sb.append("<option value='" + name + "' id='" + id + "'" + sel + ">" + label + "</option>");
			  			}
		  			}
	  	return sb.toString();
	}
		
		public String bizMakeOptionListExcepHideCol(String code_id, String selValue) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();
	  		param.put("code",code_id);
	  		param.put("hide_yn","N");
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		String 		 hide = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list("cmBoiDAO.getoptionList", param);
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			id   = (String) temp.get("id1");
		  			hide = HtmlTag.returnString((String) temp.get("hideyn"),"");
		  			
			  			if(!hide.equals("Y")){
			  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
			  				sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
			  			}
		  			}
	  	return sb.toString();
	}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/		
		public String bizMakeOptionList(String code_id, String selValue, String sql_id) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();
	  		param.put("code",code_id);
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list(sql_id, param);
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			id   = (String) temp.get("id1");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
		  			}
	  	return sb.toString();
	}
		
		/**
		 * <p> name 값을 바탕으로 option list 를 만들어주는 메서드</p>
		 * Precondition : sql_id에 해당쿼리가 정의되어야한다  
		 * Postcondition: 조회한 결과 map에 담아서 리턴
		 *
		 * @param   param  cod_id , selected value 선택값 없을경우 ""
		 *
		 * @return option select 값을 리턴한다
		 * @throws  
		 */		
		public String bizMakeOptionListText(String code_id, String selValue, String sql_id) throws Exception {
			StringBuffer sb   = new StringBuffer();
			Map param =  new HashMap();
			param.put("code",code_id);
			String       code = "";
			String       name = "";
			String       sel  = "";
			String       id   = "";
			List rtn_list = new ArrayList();
			rtn_list = list(sql_id, param);
			
			Map        temp = new HashMap();
			selValue = CM_Util.nullToEmpty(selValue);
			for(int i=0; i<rtn_list.size(); i++){
				temp = (Map)rtn_list.get(i);
				code = (String)temp.get("code");
				name = (String)temp.get("name");
				sel  = ( selValue.trim().equals(name.trim()) ) ? "selected" : "";
				id   = (String) temp.get("id1");
				/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
				sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
			}
			return sb.toString();
		}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/		
		public String bizMakeOptionList(ArrayList<String> code_id, String selValue, String sql_id) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();
	  		param.put("code",code_id);
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list(sql_id, param);
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			id   = (String) temp.get("id1");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
		  			}
	  	return sb.toString();
	}
		
		/**
		 * 토건설비 레벨별 셀렉트리스트생성 
		 * Method Name  : bizMakeOptionFacList
		 * Description      :    
		 * Comment        :  
		 * Parameter       : 
		 * form History    : 2015. 8. 12. : mrkim:  최초작성
		 * @param code_id
		 * @param level
		 * @param sql_id
		 * @return
		 * @throws Exception
		 */
		public String bizMakeOptionFacList(String code_id, String level, String sql_id) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();
	  		param.put("code",code_id);
	  		param.put("level",level);
	  		String       code = "";
	  		String       name = "";
	  		String       id   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list(sql_id, param);
	  		
	  		Map        temp = new HashMap();
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			id   = (String) temp.get("id1");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "'" + ">" + name + "</option>");
		  			}
	  	return sb.toString();
	}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select Label값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionGroupList(String code_id, String uppo_code, String selValue) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		Map param =  new HashMap();
	  		param.put("code",code_id);
	  		param.put("uppo_code",uppo_code);
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list("cmBoiDAO.getoptionGroupList", param);
	  		
	  		Map        temp = new HashMap();
	  		selValue = CM_Util.nullToEmpty(selValue);
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			id   = (String) temp.get("id1");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
		  			}
	  	return sb.toString();
	}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param  cod_id , selected value 선택값 없을경우 ""
		*
		* @return option select Label값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionGroupList(Map param, String sql_id) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list(sql_id, param);
	  		
	  		Map        temp = new HashMap();
	  		String       selValue  = CM_Util.nullToEmpty((String)param.get("sel"));
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			id   = (String) temp.get("id1");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "'" + sel + ">" + name + "</option>");
		  			}
	  	return sb.toString();
	}		
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param MAp param , String sql_id 
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/
		
		public String bizMakeOptionList(Map param, String sql_id) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		String       code = "";
	  		String       name = "";
	  		String       sel  = "";
	  		String       id   = "";
	  		String       id1   = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list(sql_id, param);
	  		Map        temp = new HashMap();
	  		String       selValue  = CM_Util.nullToEmpty((String)param.get("sel"));
	  		
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			log.debug("code : " +code);
		  			log.debug("code : " + code);
		  			name = (String)temp.get("name");
		  			sel  = ( selValue.trim().equals(code.trim()) ) ? "selected" : "";
		  			
		  			id   = (String) temp.get("id1");
		  			id1   = (String) temp.get("id2");
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "' id1='" + id1 + "'" + sel + ">" + name + "</option>");*/
		  			sb.append("<option value='" + code + "' id='" + id + "' id1='" + id1 + "'" + sel + ">" + name + "</option>");
		  			
		  			}
	  	return sb.toString();
	}
		
		/**
		* <p> code 값을 바탕으로 option list 를 만들어주는 메서드</p>
		* Precondition : param에 해당 파라메터가 들어 있어야한다 
		* 				 쿼리가 정의되어야한다
		* Postcondition: 조회한 결과 map에 담아서 리턴
		*
		* @param   param , select 선택값 없을경우 ""
		*
		* @return option select 값을 리턴한다
		* @throws  
		*/
		
		public String makeOptionLevList(Map param) throws Exception {
	  		StringBuffer sb   = new StringBuffer();
	  		String       code = "";
	  		String       name = "";
	  		String       id   = "";
	  		String 		 hide = "";
	  		List rtn_list = new ArrayList();
	  		rtn_list = list("cmBoiDAO.getoptionList", param);
	  		
	  		Map temp = new HashMap();
		  			for(int i=0; i<rtn_list.size(); i++){
		  			temp = (Map)rtn_list.get(i);
		  			code = (String)temp.get("code");
		  			name = (String)temp.get("name");
		  			id   = (String) temp.get("id1");
		  			hide = HtmlTag.returnString((String) temp.get("hideyn"),"");
		  			if(!hide.equals("Y")){
		  			/*sb.append("<option title='"+name+"' value='" + code + "' id='" + id + "'>" + name + "</option>");*/
		  				sb.append("<option value='" + code + "' id='" + id + "'>" + name + "</option>");
		  			}
		  			}
	  	return sb.toString();
	}		
		   /**
				* <p> form 데이터를 가져오는 공통  조회하는 메소드</p>
				* Precondition : param에 해당 파라메터가 들어 있어야한다 
				* 				 쿼리가 정의되어야한다
				* Postcondition: 조회한 결과 map에 담아서 리턴
				*
				* @param   param		Map		파라메터
				*
				* @return 그리드  조회결과값을 리턴한다
				* @throws  
				*/
				public Map getformData (Map param,String sql_id) throws Exception {
					log.debug("==== getformData Start ====");
					Map result_map = new HashMap();
					Map ViewMap = new HashMap();
					List rtn_list = new ArrayList();
						rtn_list = list(sql_id, param);
						if(rtn_list.size() < 1){
							log.debug("게시물정보를 가져오지 못했습니다!!");
							result_map.put("TRS_MSG","게시물정보를 가져오지 못했습니다!!");
							result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
							result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
							return result_map;	
						}else{
							//List gridList = cmsService.getGridListScroll(rtn_list);
							
							result_map = (Map)rtn_list.get(0);
							Object keyVal = new Object(); 
							Map _m = new HashMap<String,Object>(); //가공된 data
							Iterator iterator = result_map.entrySet().iterator();
							  while (iterator.hasNext()) {
								  
							   Entry entry = (Entry)iterator.next();
							   log.debug("================>"+entry.getKey().toString());
							   keyVal = result_map.get(entry.getKey())!=null ? result_map.get(entry.getKey()) : "";  //key에 해당하는 value의 null체크
							   _m.put(StringUtil.egovmapToGrid(entry.getKey().toString()) , keyVal); //map 데이터를 그리드 데이터에 맞게 입력
						}
						ViewMap.put("ViewMap", _m);
						}
						return ViewMap;
			}
				
				/**
				 * Method Name  : getAuthButton
				 * Description  : 
				* Comment      : 
				* Parameter    : param - 정보가 담긴 Map ,sql_id 조회 할 sqlid
				* form History : 2015/05/15 : 박창현:  최초작성
				*/
				public Map selectMenuAuthButton (Map param,String sql_id) throws Exception {
					log.debug("==== getAuth Button Start ====");
					Map result_map = new HashMap();
					Map AuthMap = new HashMap();
					List rtn_list = new ArrayList();
						rtn_list = list(sql_id, param);
						if(rtn_list.size() < 1){
							log.debug("메뉴 권한 정보를 가져오지 못했습니다.!");
							return null;	
						}else{
							result_map = (Map)rtn_list.get(0);
						
						}
						log.debug("==== getAuth Button END ====");
						return result_map;
				}
				
				/**
				 * Method Name  : getListSqlOnly
				 * Description  : 
				* Comment      : 
				* Parameter    : param - 정보가 담긴 Map ,sql_id 조회 할 sqlid
				* form History : 2015/05/15 : 박창현:  최초작성
				*/
				public List getListSqlOnly (Map param,String sql_id) throws Exception {
					log.debug("==== getListSqlOnly Start ====");

					List rtn_list = new ArrayList();
						rtn_list = list(sql_id, param);
					if(rtn_list!=null){
						if(rtn_list.size() < 1){
							log.debug(sql_id+"의 결과정보가 0건입니다!");
							return null;	
						}else{
							rtn_list = cmsService.getGridListScroll(rtn_list);
						}
					}else{
						return null;
					}
					log.debug("==== getListSqlOnly END ====");
						return rtn_list;
				}
				
				/**
				 * Method Name  : getListSqlOnlyView
				 * Description  : 
				* Comment      : 
				* Parameter    : param - 정보가 담긴 Map ,sql_id 조회 할 sqlid
				* form History : 2015/05/15 : 박창현:  최초작성
				*/
				public Map getListSqlOnlyView (Map param,String sql_id) throws Exception {
					log.debug("==== getListSqlOnlyView Start ====");

					List rtn_list = new ArrayList();
					Map rtn_map = new HashMap();
						rtn_list = list(sql_id, param);
					if(rtn_list!=null){
						if(rtn_list.size() < 1){
							log.debug(sql_id+"의 결과정보가 0건입니다!");
							return null;	
						}else{
							rtn_list = cmsService.getGridListScroll(rtn_list);
							rtn_map= (Map)rtn_list.get(0);
						}
					}else{
						return null;
					}
					log.debug("==== getListSqlOnlyView END ====");
						return rtn_map;
				}				
				
				/**
				 * 주어진 연도에 따라 연도셀렉트박스를 생성. 
				 * Method Name  : getYearOptionList
				 * Description      :  인자 차이만큼의 과거년으로부터 현재년까지의 셀렉트 박스  
				 * Comment        :  
				 * form History    : 2015. 6. 4. : mrkim:  최초작성
				 * @param year
				 * @return
				 * @throws Exception
				 */
				public String getYearOptionList(int year) throws Exception {
			  		StringBuffer sb   = new StringBuffer();
			  		String       code = "";
			  		String       name = "";
			  		String       id   = "";
			  		
			  		Calendar cal = Calendar.getInstance();
			  		int Year = cal.get(Calendar.YEAR);
				  	int startYear = cal.get(Calendar.YEAR) - year;				  				  		
			  		
			  		Map temp = new HashMap();
		  			for(int i=Year; i>=startYear; i--){			  			
			  			sb.append("<option  value='" + i+ "' >" + i + "</option>");
		  			}
		  			return sb.toString();
				}
				
				/**
				 * 셀렉트 리스트형의 데이타에서 필요한 항목만 배열로 반환
				 * Method Name  : bizArrayList
				 * Description      :    
				 * Comment        :  
				 * Parameter       : 
				 * form History    : 2015. 7. 9. : mrkim:  최초작성
				 * @param code_id
				 * @param selValue
				 * @param sql_id
				 * @param colNm
				 * @return
				 * @throws Exception
				 */
				public List<String> bizArrayList(ArrayList<String> code_id, String selValue, String sql_id, String colNm) throws Exception {
			  		
			  		Map param =  new HashMap();
			  		param.put("code",code_id);
			  		String       code = "";
			  		List rtn_list = new ArrayList();
			  		rtn_list = list(sql_id, param);
			  		int listSize = rtn_list.size();
			  		
			  		Map        temp = new HashMap();
			  		selValue = CM_Util.nullToEmpty(selValue);
			  		
			  		List<String> arr   = new ArrayList();
		  			for(int i=0; i<rtn_list.size(); i++){
			  			temp = (Map)rtn_list.get(i); 
			  			arr.add((String)temp.get(colNm));
		  			
		  			}
				  	return arr;
				}
				
				/**
				 * 셀렉트 리스트형의 데이타에서 필요한 항목만 배열로 반환
				 * Method Name  : bizArrayList
				 * Description      :    
				 * Comment        :  
				 * Parameter       : 
				 * form History    : 2015. 7. 9. : mrkim:  최초작성
				 * @param code_id
				 * @param selValue
				 * @param colNm
				 * @return
				 * @throws Exception
				 */
				public List<String> bizArrayList(String code_id, String colNm) throws Exception {
			  		StringBuffer sb   = new StringBuffer();
			  		Map param =  new HashMap();
			  		param.put("code",code_id);
			  		
			  		List rtn_list = new ArrayList();
			  		rtn_list = list("cmBoiDAO.getoptionList", param);
			  		
			  		Map        temp = new HashMap();
			  		
			  		List<String> arr   = new ArrayList();
		  			for(int i=0; i<rtn_list.size(); i++){
			  			temp = (Map)rtn_list.get(i);
			  			arr.add((String)temp.get(colNm));  			
		  			}
		  			return arr;
				}
}
