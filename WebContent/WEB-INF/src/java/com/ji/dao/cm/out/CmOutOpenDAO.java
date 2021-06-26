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
package com.ji.dao.cm.out;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.common.DateUtility;
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.Param;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : CmCmMnmDAO.java
 * @Description : CmMnmDAO DAO Class
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

@Repository("CmOutOpenDAO")
public class CmOutOpenDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmOutOpenDAO.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	

    /**
	 * 메뉴트리를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
    public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO ctlCMS
		log.debug("==== ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		try{
			
			if(pstate.equals("L")){
				
			// 등록
			}
			// 권한그룹리스트
			else if(pstate.equals("XL1")){ //ajax jqGrid data관련
				result_map = selectListAuthGrpGrid(param);
			 
			}else if(pstate.equals("C")){
				// 등록처리
				result_map = insertOutOpenData(param);	//insertCMOAM
				
			// 등록화면
			//}else if(pstate.equals("CF")){
				
			// 수정처리
			}else if(pstate.equals("U")){
				result_map = updateOutOpenData(param);	
					
			// 상세화면
			}else if(pstate.equals("UF")){
				log.debug(">>>> "+ param);
				result_map = cmDAO.getformData(param, "JiOpenDataMng.selectOutOpenOne");
				
				Map ViewMap = (Map)result_map.get("ViewMap");
				
				log.debug("ViewMap [ "+ ViewMap);
				
				// result_map.put("mail_cd_opts",cmDAO.bizMakeOptionListText("M00004", ""));
			
			// 수정화면
			}else if(pstate.equals("UFS")){
				log.debug(">>>> "+ param);
				result_map = cmDAO.getformData(param, "JiOpenDataMng.selectOutOpenOne");
				
				Map ViewMap = (Map)result_map.get("ViewMap");
				
				log.debug("ViewMap [ "+ ViewMap);
				
				// result_map.put("mail_cd_opts",cmDAO.bizMakeOptionListText("M00004", ""));
			}
			// 삭제처리
			/*
			else if(pstate.equals("D")){
				result_map = deleteAuthGrp(param);	
					
			// 메뉴트리를 불러온다	
			}else if(pstate.equals("XL2")){
				log.debug("==== XL2 Start ====:");
				result_map = cmMnmDAO01.selectListMenuTree(param); 
				log.debug("==== XL2 End ====");
				
			// 권한그룹 메뉴리스트
			}else if(pstate.equals("XL3")){ //ajax jqGrid data관련
				result_map = selectListAuthGrpMenuGrid(param);
				
			// 권한그룹 사용자리스트
			}else if(pstate.equals("XL4")){ //ajax jqGrid data관련
				result_map = selectListAuthGrpUserGrid(param);				
			*/
			
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }

    
	/**
	* <p> ctlMNM(메인Dao컨트롤클래스)에서 메뉴관리관련 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  메뉴관리관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map selectListAuthGrpGrid (Map param) throws Exception {
		
		log.debug("==== selectListAuthGrpGrid Start ====");
		Map result_map = new HashMap();

		
		try{
	  		List rtn_list = new ArrayList();
	  		rtn_list = list("JiOpenDataMng.selectOutOpnList", param);
	  		
	  		List gridList = cmsService.getGridListScroll(rtn_list);
	  		result_map.put("rows",gridList);
			
	  		log.debug("result_map >>>> "+ result_map);	  		
	  		
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
    	log.debug("==== selectListAuthGrpGrid End ====");
		return result_map;
	} 
	
	
	/**
	* <p> ctlAB(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	// TODO : insertCMOAM
	public Map insertOutOpenData(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== insertCmOutOpenDAO : START ====");
		
		Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
		 
		String USER_ID ="";
		if(SITE_ADM_SESSION!=null){
		    	USER_ID	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		    	param.put("reg_id", USER_ID);
		}
		
		
		String requst_subject = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("requst_subject"),""));
		String cn = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cn"),""));
		String menue_cd = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("menue_cd"),""));
		String menu_data_key_datas = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("menu_data_key_datas"),""));
		
		
		Map result_map = new HashMap();
		
		
	    List seq_list = new ArrayList();
	    int p_regist_sn;
	    
	    String sql_id="";
	    
		try{
			
			//일련번호 추출
			seq_list = list("JiOpenDataMng.selectOutOpenDataRegistSeq", param);
			p_regist_sn = ((Integer)(seq_list.get(0))).intValue();
			
			param.put("regist_sn", p_regist_sn);
			param.put("requst_subject", requst_subject);
			param.put("cn", cn);
			param.put("menu_cd", menue_cd);
			param.put("menu_data_key_datas", menu_data_key_datas);
			param.put("del_yn", "N");
			
			sql_id="JiOpenDataMng.insertOutOpenData";
			
			insert(sql_id, param);
			
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				
			log.debug("result_map >>> "+  result_map);
			
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertCmOutOpenDAO : END ====");
		return result_map;	
	}
	
	
	/**
	* <p> ctlAB(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/
	public Map updateOutOpenData(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== updateCmOutOpenDAO : START ====");
		
		Map result_map = new HashMap();
		
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
	    
	    String regist_sn = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("p_regist_sn"),""));
		String requst_subject = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("requst_subject"),""));
		String cn = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cn"),""));
		String menue_cd = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("menue_cd"),""));
		String menu_data_key_datas = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("menu_data_key_datas"),""));
		
		String sql_id="JiOpenDataMng.updateOutOpneData";
	    
		
		try{
			
			/*	
			if(sorg_cd.equals("") || sorg_cd.length() > 10){
				throw new JSysException("필수입력값이 조건에 맞지 않습니다.");
			}	
			
			if(suser_seq.equals("") || suser_seq.length() > 10){
				throw new JSysException("필수입력값이 조건에 맞지 않습니다.");
			}			
			*/
			
			param.put("regist_sn", regist_sn);
			param.put("requst_subject", requst_subject);
			param.put("cn", cn);
			param.put("menu_cd", menue_cd);
			param.put("menu_data_key_datas", menu_data_key_datas);
			param.put("del_yn", "N");
			
			
			// 등록자 id 셋팅
			param.put("mod_id", USER_ID);
			
			
			//사용자기본정보 저장
			update(sql_id, param);
			
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		
			
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== updateCmOutOpenDAO : END ====");
		return result_map;	
	}
}
