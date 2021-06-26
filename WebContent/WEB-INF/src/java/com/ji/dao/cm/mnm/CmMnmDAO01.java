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
package com.ji.dao.cm.mnm;

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

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.vo.MenuVO;
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.Param;
import com.ji.common.StringUtil;

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

@Repository("cmMnmDAO01")
public class CmMnmDAO01 extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmMnmDAO01.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
    
    @Resource(name="sqlMapClient")
	private SqlMapClient sqlClient;

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
			}else if(pstate.equals("C")){
				result_map = insertMNM(param);
				
			// 수정
			}else if(pstate.equals("U")){
				result_map = updateMNM(param);
				
			// 삭제
			}else if(pstate.equals("D")){
				result_map = deleteMNM(param);
				
			// 이동
			}else if(pstate.equals("UM")){
				result_map = moveMNM(param);
				
			// 메뉴선택팝업
			}else if(pstate.equals("PF1")){
				
			// 메뉴선택팝업
			}else if(pstate.equals("XL1")){				
				log.debug("==== MENUTREE Start ====:");
				result_map = selectListMenuTree(param); 
				log.debug("==== MENUTREE End ====");
			// 도움말 조회
			}else if(pstate.equals("XP1")){
				param.put("show_rows", "1000");	//100개씩 조회
				
				result_map = cmDAO.selectListGrid(param, "JiCmMnm.getHelpContents"); // 도움말조회		
			// 도움말 등록
			}else if(pstate.equals("C2")){				
				Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
			    // 등록자 id 셋팅
				param.put("user_id", USER_ID);		
				
				int JIT9602_HELP_SEQNO = cmDAO.getSequence("JIT9602_HELP_SEQNO");
				param.put("max_seq", JIT9602_HELP_SEQNO);
				
				
				// 도움말을 등록한다
				String sql = "JiCmMnm.insertHelpContents";

				insert(sql, param);			
				result_map.put("result",true);
				result_map.put("TRS_MSG","등록되었습니다");	
				
				
			// 도움말 수정
			}else if(pstate.equals("U2")){				
					Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
				    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				    // 등록자 id 셋팅
					param.put("user_id", USER_ID);		
					
					
					// 도움말을 수정한다
					String sql = "JiCmMnm.updateHelpContents";

					update(sql, param);			
					result_map.put("result",true);
					result_map.put("TRS_MSG","수정되었습니다");	
					
			// 도움말 삭제
			}else if(pstate.equals("D2")){				
					Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
					String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					// 등록자 id 셋팅
					param.put("user_id", USER_ID);		
							
							
					// 도움말을 수정한다
					String sql = "JiCmMnm.deleteHelpContents";

					delete(sql, param);			
					result_map.put("result",true);
					result_map.put("TRS_MSG","삭제되었습니다");					
				
			}

		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  "+q);	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }
	
	/**
	* <p> ctlMNM(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	// TODO insertMNM 
	public Map insertMNM(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO insertMNM 
		log.debug("==== insertMNM : START ====");
		Map result_map = new HashMap();
		Map tmp_map = new HashMap();
		
		String[] rtn_form_obj_in = {"scode","pcode","se_code","se_lv","sel_num","se_code_up_c","dto_SELMENU_"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		List save_file_list = new ArrayList();

		int i = 0;

		String se_code	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_code"),"000000") );	
		String sel_code	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sel_code"),"") );//입력된 메뉴코드		
		String M_NM			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("M_NM"),""));// 메뉴명
		String LINK_TY		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("dto_SELMENU1_0"),""));//연결종류
		String LINK_PATH    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("LINK_PATH"),""));//LINK경로
		String LINK_TARGET  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("LINK_TARGET"),"_self"));//LINK타겟
		String M_S_STYLE    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_S_STYLE"),"1"));//하위메뉴종류

		//List file_arr	= (List)param.get("FILE_ARR");// 업로드 파일정보
		param.put("FILE_ARR",save_file_list);

		String M_SDATE = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_SDATE"),""));//메뉴기간시작일
		String M_EDATE = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_EDATE"),""));//메뉴기간종료일
		String BOARD_TY = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("dto_SELMENU2_0"),""));//게시판종류
		String CLASS_PATH = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_PATH"),""));//클래스경로입력
		String CLASS_PATH_JSP = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_PATH_JSP"),""));//리턴될 JSP경로입력
		String CLASS_METHOD = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_METHOD"),""));//클래스의 컨트롤 메소드입력
		String JSP_INCLUDE_YN    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("JSP_INCLUDE_YN"),"1"));//JSP연결종류
		
		String BOARD_LI_ITEM = "";//게시판 목록 출력항목
		String BOARD_LI_ITEM_NM = "";//게시판 목록 출력항목명
		String BOARD_ETC_ITEM = "";//게시판 임시컬럼사용여부
		String BOARD_ETC_ITEM_TY = "";//게시판 임시컬럼 사용시데이터 종류
		String BOARD_ETC_ITEM_CODE = "";//게시판임시컬럼코드
		String BOARD_ETC_ITEM_NM = "";//게시판 임시컬럼출력항목명
		String BOARD_OPT = "";//게시판옵션
		String BOARD_INT_M_CODES = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_INT_M_CODES"),""));//통합형게시판(0000000025)일경우 게시판메뉴코드
		
		// 게시판환경설정을 저장한다
		for(i=0;i<14;i++){
			BOARD_LI_ITEM = BOARD_LI_ITEM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_LI_ITEM"+i),""));
			if(i<13){
				BOARD_LI_ITEM = BOARD_LI_ITEM +"::";
			}
		}
		
		for(i=0;i<14;i++){
			BOARD_LI_ITEM_NM = BOARD_LI_ITEM_NM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_LI_ITEM_NM"+i),""));
			if(i<13){
				BOARD_LI_ITEM_NM = BOARD_LI_ITEM_NM +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM = BOARD_ETC_ITEM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM"+i),"N"));
			if(i<9){
				BOARD_ETC_ITEM = BOARD_ETC_ITEM +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_TY = BOARD_ETC_ITEM_TY + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_TY"+i),"V"));
			if(i<9){
				BOARD_ETC_ITEM_TY = BOARD_ETC_ITEM_TY +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_CODE = BOARD_ETC_ITEM_CODE + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_CODE"+i),""));
			if(i<9){
				BOARD_ETC_ITEM_CODE = BOARD_ETC_ITEM_CODE +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_NM = BOARD_ETC_ITEM_NM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_NM"+i),""));
			if(i<9){
				BOARD_ETC_ITEM_NM = BOARD_ETC_ITEM_NM +"::";
			}
		}	
		
		for(i=0;i<7;i++){
			BOARD_OPT = BOARD_OPT + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_OPT"+i),"N"));
			if(i<6){
				BOARD_OPT = BOARD_OPT +"::";
			}
		}
		
		// 등록될 메뉴 깊이
		int DEPTH_NO  = Integer.parseInt(HtmlTag.returnString((String)param.get("DEPTH_NO"),"0"),10);
		// 등록될 메뉴 순번
		int ORDER_NO  = Integer.parseInt(HtmlTag.returnString((String)param.get("ORDER_NO"),"0"),10);		
		//log.debug("insertACD : DEPTH_NO:"+DEPTH_NO);
		//log.debug("insertACD : ORDER_NO:"+ORDER_NO);
		
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		
		long max_seq = 0;
		String max_code = "";

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JIT9160","MENU_SEQNO","");
		
		log.debug("==== insertMNM : 2222222 ====");
		// 0,1DEPTH를 제외하고 코드를 채번한다
		if(sel_code.equals("")){
			//max_code = DbCommon.getMaxCode(Tab_JIT9160, "M_CODE", 10, "WHERE DEPTH_NO NOT IN(0,1)");
			//숫자로된 코드에서만 채번한다
			//오라클, TIBERO
			if(propertiesService.getString("CMS_DB_TYPE").equals("ORACLE")
					|| propertiesService.getString("CMS_DB_TYPE").equals("TIBERO")){
				tmp_map = cmDAO.getMaxCode("JIT9160", "MENU_CD", 6, "^[0-9]", "");
				max_code = (String)tmp_map.get("maxCode");

			//MSSQL
			}else if(propertiesService.getString("CMS_DB_TYPE").equals("MSSQL")){
				tmp_map = cmDAO.getMaxCode("JIT9160", "MENU_CD", 6, "[0-9]%", "");
				max_code = (String)tmp_map.get("maxCode");
			}
			
			
		}else{
			max_code = sel_code;
		}
		
		String sql = "";
		Map query_param = new HashMap();
		try{
			
			// 직접입력한 코드인경우 중복을 체크한다
			if(!sel_code.equals("")){
				sql = "JiCmMnm.getMenuCodeChk";
				query_param = new HashMap();
				query_param.put("max_code",max_code);
				query_param.put("mods","I");
				
//				if((Integer)getSqlMapClientTemplate().queryForObject(sql, query_param) > 0){
				if(getInt(sql, query_param) > 0){
					result_map.put("TRS_MSG","코드가 중복되었습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;
				}
			}
			
			log.debug("==== insertMNM : 333333333 ====");
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY"), Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			sql = "JiCmMnm.insertMenu";
			query_param = new HashMap();
			
			query_param.put("max_seq",max_seq);
			query_param.put("max_code",max_code);
			query_param.put("M_NM",M_NM);
			query_param.put("se_code",se_code);
			
			query_param.put("USER_ID",USER_ID);
			query_param.put("ORDER_NO",ORDER_NO);
			query_param.put("DEPTH_NO",DEPTH_NO);
			
			query_param.put("LINK_TY",LINK_TY);
			query_param.put("CLASS_PATH",CLASS_PATH);
			query_param.put("LINK_PATH",LINK_PATH.trim());
			query_param.put("BOARD_TY",BOARD_TY);
			
			query_param.put("LINK_TARGET",LINK_TARGET);
			query_param.put("CLASS_PATH_JSP",CLASS_PATH_JSP);
			
			query_param.put("CLASS_METHOD",CLASS_METHOD);
			query_param.put("M_S_STYLE",M_S_STYLE);
			query_param.put("JSP_INCLUDE_YN",JSP_INCLUDE_YN);
			
			query_param.put("BOARD_LI_ITEM",BOARD_LI_ITEM);
			query_param.put("BOARD_LI_ITEM_NM",BOARD_LI_ITEM_NM);
			query_param.put("BOARD_ETC_ITEM",BOARD_ETC_ITEM);
			query_param.put("BOARD_ETC_ITEM_TY",BOARD_ETC_ITEM_TY);
			query_param.put("BOARD_ETC_ITEM_NM",BOARD_ETC_ITEM_NM);
			query_param.put("BOARD_OPT",BOARD_OPT);
			
			query_param.put("BOARD_ETC_ITEM_CODE",BOARD_ETC_ITEM_CODE);
			query_param.put("BOARD_INT_M_CODES",BOARD_INT_M_CODES);
			
			query_param.put("M_SDATE",M_SDATE);
			query_param.put("M_EDATE",M_EDATE);
			
			
			param.put("RMAXIDX", Long.toString(max_seq));
			
			// 첨부파일정보를 데이터 베이스에 저장한다
/*			temp_file = cmDAO.InsertFile(param);
			// 파일저장중에러가 발생하면
			if(!"".equals((String)temp_file.get("TRS_MSG"))){
				result_map.put("TRS_MSG","등록중 에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
				//throw new JSysException("CM_Dao InsertFile 등록중 에러가 발생했습니다");
			}*/
					
			insert(sql, query_param);
			// S01 메뉴 js생성
			createMenuTreeJs(param);
			
			result_map.put("TRS_MSG","등록되었습니다");
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
			log.debug("JSysException Exception >>>>> : ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertMNM : END ====");
		return result_map;	
	}
	

	/**
	* <p> ctlMNM(메인Dao컨트롤클래스)에서 해당데이터를 수정하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  수정 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map updateMNM(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO updateMNM 
		log.debug("==== updateMNM : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode","se_code","se_lv","sel_num","se_code_up_c","dto_SELMENU_"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		Param Param_Obj = new Param();
		List file_arr	= (List)param.get("FILE_ARR");// 업로드 파일정보
		String chk_file_del = "N";
		//log.debug(message)

		int i = 0;
		int j = 0;
		
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		
		String sseq  = HtmlTag.returnString((String)param.get("sseq"),"0");
		String sel_code  = HtmlTag.returnString((String)param.get("sel_code"),"");
		String se_codeh  = HtmlTag.returnString((String)param.get("se_codeh"),"");
		String sel_up_code		= HtmlTag.returnString((String)param.get("sel_up_code"),""); //'수정할 코드 상위코드
		String ORDER_NOh	= HtmlTag.returnString((String)param.get("ORDER_NOh"),""); //'수정할 원래순번 
		String DEPTH_NOh	= HtmlTag.returnString((String)param.get("DEPTH_NOh"),""); //'수정할 메뉴의 깊이
		String M_CODES = HtmlTag.returnString((String)param.get("M_CODES"),""); //'수정할 메뉴의 총코드
		String ORDER_NO_M 	= HtmlTag.returnString((String)param.get("ORDER_NO_M"),""); //'수정될순번 
		String M_NM			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("M_NM"),""));// 수정메뉴명
		String LINK_TY		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("dto_SELMENU1_0"),""));//수정연결종류
		String LINK_PATH    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("LINK_PATH"),""));//수정LINK경로
		String LINK_TARGET  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("LINK_TARGET"),"_self"));//수정LINK타겟
		String M_S_STYLE    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_S_STYLE"),"1"));//수정하위메뉴종류
		
		String M_SDATE = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_SDATE"),""));//수정메뉴기간시작일
		String M_EDATE = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("M_EDATE"),""));//수정메뉴기간종료일
		String BOARD_TY = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("dto_SELMENU2_0"),""));//수정게시판종류
		String CLASS_PATH = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_PATH"),""));//수정클래스경로입력
		String CLASS_PATH_JSP = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_PATH_JSP"),""));//수정리턴될 JSP경로입력
		String CLASS_METHOD = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("CLASS_METHOD"),""));//수정클래스의 컨트롤 메소드입력
		String JSP_INCLUDE_YN    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("JSP_INCLUDE_YN"),"1"));//JSP연결종류
		
		String BOARD_LI_ITEM = "";//게시판 목록 출력항목
		String BOARD_LI_ITEM_NM = "";//게시판 목록 출력항목명
		String BOARD_ETC_ITEM = "";//게시판 임시컬럼사용여부
		String BOARD_ETC_ITEM_TY = "";//게시판 임시컬럼 사용시데이터 종류
		String BOARD_ETC_ITEM_CODE = "";//게시판임시컬럼코드
		String BOARD_ETC_ITEM_NM = "";//게시판 임시컬럼출력항목명
		String BOARD_OPT = "";//게시판옵션
		String BOARD_INT_M_CODES = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_INT_M_CODES"),""));//통합형게시판(0000000025)일경우 게시판메뉴코드
		
		// 게시판환경설정을 저장한다
		for(i=0;i<14;i++){
			BOARD_LI_ITEM = BOARD_LI_ITEM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_LI_ITEM"+i),""));
			if(i<13){
				BOARD_LI_ITEM = BOARD_LI_ITEM +"::";
			}
		}
		
		for(i=0;i<14;i++){
			BOARD_LI_ITEM_NM = BOARD_LI_ITEM_NM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_LI_ITEM_NM"+i),""));
			if(i<13){
				BOARD_LI_ITEM_NM = BOARD_LI_ITEM_NM +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM = BOARD_ETC_ITEM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM"+i),"N"));
			if(i<9){
				BOARD_ETC_ITEM = BOARD_ETC_ITEM +"::";
			}
		}
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_TY = BOARD_ETC_ITEM_TY + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_TY"+i),"V"));
			if(i<9){
				BOARD_ETC_ITEM_TY = BOARD_ETC_ITEM_TY +"::";
			}
		}	
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_CODE = BOARD_ETC_ITEM_CODE + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_CODE"+i),""));
			if(i<9){
				BOARD_ETC_ITEM_CODE = BOARD_ETC_ITEM_CODE +"::";
			}
		}			
		
		for(i=0;i<10;i++){
			BOARD_ETC_ITEM_NM = BOARD_ETC_ITEM_NM + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_ETC_ITEM_NM"+i),""));
			if(i<9){
				BOARD_ETC_ITEM_NM = BOARD_ETC_ITEM_NM +"::";
			}
		}	
		
		for(i=0;i<7;i++){
			BOARD_OPT = BOARD_OPT + HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("BOARD_OPT"+i),"N"));
			if(i<6){
				BOARD_OPT = BOARD_OPT +"::";
			}
		}		
		
		
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		
		
	    String sql = "";
	    Map query_param = new HashMap();
		try{
			//log.debug("==== updateMNM : 11111 ====scode"+HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") ));
			//log.debug("==== updateMNM : 11111 ====pcode"+HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") ));			
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			//log.debug("==== updateMNM : 11111 ====scode"+HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") ));
			//log.debug("==== updateMNM : 11111 ====pcode"+HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") ));			
			//log.debug("----------------------rtn_form_obj::"+form_list);
			//log.debug("----------------------getArrToString::"+Param.getArrToString(rtn_form_obj));
			
			//log.debug("----------------------rtn_form_obj::"+Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 직접입력한 코드인경우 중복을 체크한다 사이트구분메뉴인경우
			if(Integer.parseInt(DEPTH_NOh)==1 && !sel_code.equals("")){
				sql = "JiCmMnm.getMenuCodeChk";
				query_param = new HashMap();
				query_param.put("max_code",sel_code);
				query_param.put("mods","U");
				query_param.put("se_codeh",se_codeh);

//				if((Integer)getSqlMapClientTemplate().queryForObject(sql, query_param) > 0){
				if(getInt(sql, query_param) > 0){
					result_map.put("TRS_MSG","코드가 중복되었습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;
				}
			}

			// 만일 정렬 순번을 수정한경우 순번값을 조정해 준다
			if(!ORDER_NOh.equals(ORDER_NO_M)){
				// 원래 순번이 빠지면 원래 순번보다 큰순번의 데이터들은 -1을 해준다
				sql = "JiCmMnm.updateDelMENU";
				query_param = new HashMap();
				query_param.put("sel_up_code",sel_up_code);
				query_param.put("ORDER_NOh",ORDER_NOh);
				
				update(sql, query_param);

				// 수정될순번과 같거나 큰번호는 증가
				sql = "JiCmMnm.updateUpMENU";
				query_param = new HashMap();
				query_param.put("sel_up_code",sel_up_code);
				query_param.put("ORDER_NO_M",ORDER_NO_M);
				
				update(sql, query_param);
				
				// 수정될 순번보다 작은 번호는 변동없음
			}	
			log.debug("5====================================================================");
			sql = "JiCmMnm.updateMenu";
			query_param = new HashMap();


			query_param.put("M_NM",M_NM);
			query_param.put("DEPTH_NOh",DEPTH_NOh);
			query_param.put("sel_code",sel_code);

			query_param.put("USER_ID",USER_ID);
			query_param.put("ORDER_NO_M",ORDER_NO_M);
			query_param.put("LINK_TY",LINK_TY);
			
			query_param.put("CLASS_PATH",CLASS_PATH);
			query_param.put("LINK_PATH",LINK_PATH.trim());
			query_param.put("BOARD_TY",BOARD_TY);
			query_param.put("LINK_TARGET",LINK_TARGET);
			query_param.put("CLASS_PATH_JSP",CLASS_PATH_JSP);
			query_param.put("CLASS_METHOD",CLASS_METHOD);
			query_param.put("M_S_STYLE",M_S_STYLE);
			query_param.put("JSP_INCLUDE_YN",JSP_INCLUDE_YN);
			

			query_param.put("M_SDATE",M_SDATE);
			query_param.put("M_EDATE",M_EDATE);
			
			
			query_param.put("BOARD_LI_ITEM",BOARD_LI_ITEM);
			query_param.put("BOARD_LI_ITEM_NM",BOARD_LI_ITEM_NM);
			query_param.put("BOARD_ETC_ITEM",BOARD_ETC_ITEM);
			query_param.put("BOARD_ETC_ITEM_TY",BOARD_ETC_ITEM_TY);
			query_param.put("BOARD_ETC_ITEM_NM",BOARD_ETC_ITEM_NM);
			query_param.put("BOARD_OPT",BOARD_OPT);
			query_param.put("BOARD_ETC_ITEM_CODE",BOARD_ETC_ITEM_CODE);
			query_param.put("BOARD_INT_M_CODES",BOARD_INT_M_CODES);
			query_param.put("se_codeh",se_codeh);


			update(sql, query_param);

			log.debug("6====================================================================");
			
			
			param.put("RMAXIDX", Long.toString(sidx));
			
			// 첨부파일정보를 데이터 베이스에 저장한다
			//temp_file = cmDAO.UpdateFile(param);
			// 파일저장중에러가 발생하면
/*			if(!"".equals((String)temp_file.get("TRS_MSG"))){
				result_map.put("TRS_MSG","수정중 에러가 발생했습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
				//throw new JSysException("CM_Dao InsertFile 등록중 에러가 발생했습니다");
			}*/
			
			
			// S01 메뉴 js생성
			createMenuTreeJs(param);
			
			result_map.put("TRS_MSG","수정되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"");
			log.debug("updateAC Exception:");		
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"");
			log.debug("updateAC Exception:");		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"");
			log.debug("updateAC Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"");
			log.debug("updateAC Exception:");		
		}catch(Exception q){
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"");
			log.debug("updateAC Exception:");			

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== updateACD : END ====");
		return result_map;	
	}	
	
	
	
	/**
	* <p> ctlMNM(메인Dao컨트롤클래스)에서 해당데이터를 삭제하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  삭제 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map deleteMNM(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO deleteMNM 
		log.debug("==== deleteMNM : START ====");
		Map result_map = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode","se_code","se_lv","sel_num","se_code_up_c","dto_SELMENU_"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		Param Param_Obj = new Param();		
		//log.debug(message)
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String sseq  = HtmlTag.returnString((String)param.get("sseq"),"0");
		String pcode  = HtmlTag.returnString((String)param.get("pcode"),"");
		String sel_code  = HtmlTag.returnString((String)param.get("sel_code"),"");
		String sel_up_code		= HtmlTag.returnString((String)param.get("sel_up_code"),""); //'삭제할 코드 상위코드
		String ORDER_NOh	= HtmlTag.returnString((String)param.get("ORDER_NOh"),""); //'삭제할 원래순번
		String DEPTH_NOh	= HtmlTag.returnString((String)param.get("DEPTH_NOh"),""); //'삭제할 메뉴의 깊이
		String M_CODES = HtmlTag.returnString((String)param.get("M_CODES"),""); //'삭제할 메뉴의 총코드
		
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		
		

		int chk_cnt  = 0;
		int i = 0;
		String rsIDX = "";
		String rsM_CODE = "";
		String rsRIDX = "";
		String rsFILE_NM = "";
		String rsRFILE_NM = "";
		String rsORDER_NO = "";
		String rsREG_DT = "";
		String docsave_root = propertiesService.getString("UPLOADROOTPATH");	
	    String sql = "";	
	    Map query_param = new HashMap();
	    List rtn_list = new ArrayList();
	    Map tmp_map = new HashMap();
		try{
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));	
			// 만일 메뉴가 게시판 메뉴일경우 게시판 데이터도 함께 삭제한다
			sql = "JiCmMnm.deleteMenuBoardRe";
			query_param = new HashMap();
			query_param.put("sel_code",sel_code);
			log.debug("JiCmMnm.deleteMenuBoard : sel_code:"+sel_code);
			delete(sql, query_param);
			
			sql = "JiCmMnm.deleteMenuBoard";
			query_param = new HashMap();
			query_param.put("sel_code",sel_code);
			log.debug("JiCmMnm.deleteMenuBoard : sel_code:"+sel_code);
			delete(sql, query_param);			
			
			// 메뉴에 포함된 첨부파일도 함께 삭제한다
			sql = "JiCmMnm.getdeleteMenuFile";
			query_param = new HashMap();
			query_param.put("sel_code",sel_code);

			rtn_list = list(sql, query_param);


			if(rtn_list.size() > 0){
				for(i=0;i<rtn_list.size();i++){
					tmp_map = (Map)rtn_list.get(i);
					
					if(tmp_map!=null){
						if(tmp_map.get("idx")==null){
							rsIDX = "";
						}else{
							rsIDX = HtmlTag.returnString(tmp_map.get("idx").toString(),"");
						}					

						if(tmp_map.get("mCode")==null){
							rsM_CODE = "";
						}else{
							rsM_CODE = HtmlTag.returnString((String)tmp_map.get("mCode"),"");
						}	
						
						if(tmp_map.get("ridx")==null){
							rsRIDX = "";
						}else{
							rsRIDX = HtmlTag.returnString((String)tmp_map.get("ridx"),"");
						}					

						if(tmp_map.get("fileNm")==null){
							rsFILE_NM = "";
						}else{
							rsFILE_NM = HtmlTag.returnString((String)tmp_map.get("fileNm"),"");
						}

						if(tmp_map.get("rfileNm")==null){
							rsRFILE_NM = "";
						}else{
							rsRFILE_NM = HtmlTag.returnString((String)tmp_map.get("rfileNm"),"");
						}	
						
						if(tmp_map.get("orderNo")==null){
							rsORDER_NO = "";
						}else{
							rsORDER_NO = HtmlTag.returnString(tmp_map.get("orderNo").toString(),"");
						}					

						if(tmp_map.get("regDt")==null){
							rsREG_DT = "";
						}else{
							rsREG_DT = HtmlTag.returnString((String)tmp_map.get("regDt"),"");
						}

						// 실재 파일도 삭제한다
						FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);						
					}

				}
			}	
			
			// 하위코드에 포함된 첨부파일까지 한번에 삭제한다
			sql = "JiCmMnm.deleteMenuFile";
			query_param = new HashMap();
			query_param.put("sel_code",sel_code);
	

			delete(sql, query_param);
			
			
			// 하위메뉴까지 한꺼번에 삭제한다
			sql = "JiCmMnm.deleteMenu";
			query_param = new HashMap();
			query_param.put("sel_code",sel_code);

			delete(sql, query_param);
		
		
	
			// 메뉴관리테이블에서 빠진순번을 조정한다
			sql = "JiCmMnm.updateDelMENU";
			query_param = new HashMap();
			query_param.put("sel_up_code",sel_up_code);
			query_param.put("ORDER_NOh",ORDER_NOh);
			
			update(sql, query_param);
			
			// S01 메뉴 js생성
			createMenuTreeJs(param);			
			
			result_map.put("TRS_MSG","삭제되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteAB IOException Exception:");		
		}catch(SQLException q){
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteAB SQLException Exception:");		
		}catch(NullPointerException q){
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteAB NullPointerException:");		
		}catch(ArrayIndexOutOfBoundsException q){
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteAB ArrayIndexOutOfBoundsException:");		
		}catch(Exception q){
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteAB Exception:");


		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== deleteMNM : END ====");
		return result_map;	
	}    
 
	
	/**
	* <p> ctlMNM(메인Dao컨트롤클래스)에서 해당데이터를 이동하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  이동 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map moveMNM(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO moveMNM 
		log.debug("==== moveMNM : START ====");
		Map result_map = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode","se_code","se_lv","sel_num","se_code_up_c","dto_SELMENU_"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		Param Param_Obj = new Param();		
		//log.debug(message)
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String sseq  = HtmlTag.returnString((String)param.get("sseq"),"0");
		String pcode  = HtmlTag.returnString((String)param.get("pcode"),"");
		String sel_code  = HtmlTag.returnString((String)param.get("sel_code"),"");
		String sel_up_code		= HtmlTag.returnString((String)param.get("sel_up_code"),""); //'이동할 코드 상위코드
		String ORDER_NOh	= HtmlTag.returnString((String)param.get("ORDER_NOh"),""); //'이동할 원래순번 
		String DEPTH_NOh	= HtmlTag.returnString((String)param.get("DEPTH_NOh"),""); //'이동할 메뉴의 깊이
		String M_CODES = HtmlTag.returnString((String)param.get("M_CODES"),""); //'이동할 메뉴의 총코드
		String move_code = HtmlTag.returnString((String)param.get("move_code"),""); //'이동할 상위코드
		
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		

		int chk_cnt  = 0;
		int i = 0;
		int rsIDX = 0;
		String rsM_CODE = "";
		String rsM_UP_CODE = "";
		int rsORDER_NO = 0;
		int rsDEPTH_NO = 0;
		String rsLINK_TY = "";	
		int rsSUB_CNT = 0;
		
		int mrsIDX = 0;	
		String mrsM_CODE = "";	
		String mrsM_NM = "";	
		int mrsLV = 0;	
		int mrsORDER_NO = 0;
		int mrsDEPTH_NO = 0;		
		
		int move_ORDER_NO = 0;
		int move_DEPTH_NO = 0;
		int move_gap = 0;
		
	    String sql = "";	
	    Map query_param = new HashMap();
	    List rtn_list = new ArrayList();
	    Map tmp_map = new HashMap();
	    
		try{
			// 이동할 상위코드가 선택안된상태이면
			if(move_code.equals("")){
				result_map.put("TRS_MSG","이동할수 없는 메뉴입니다.");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;
			}			
			
			log.debug("moveMNM 1===============================================sel_code:"+sel_code);
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 이동될 상위메뉴의 하위 메뉴의 갯수를 확인해서 order번호와 depth를  채번한다
			sql = "JiCmMnm.getMenuMove";
			query_param = new HashMap();
			log.debug("moveMNM 1===============================================move_code:"+move_code);
			query_param.put("move_code",move_code);
			
			
			rtn_list = list(sql, query_param);


			if(rtn_list.size() > 0){

					tmp_map = (Map)rtn_list.get(0);
					if(tmp_map!=null){
						
						if(tmp_map.get("menuSeqno")!=null){
							rsIDX =  Integer.parseInt(String.valueOf(tmp_map.get("menuSeqno")));
						}else{
							rsIDX =  0;
						}
						
						if(tmp_map.get("menuCd")!=null){
							rsM_CODE = (String)tmp_map.get("menuCd");
						}else{
							rsM_CODE =  "";
						}

						if(tmp_map.get("menuUppoCd")!=null){
							rsM_UP_CODE = (String)tmp_map.get("menuUppoCd");
						}else{
							rsM_UP_CODE =  "";
						}						

						if(tmp_map.get("orderNo")!=null){
							rsORDER_NO =  Integer.parseInt(String.valueOf(tmp_map.get("orderNo")));
						}else{
							rsORDER_NO =  0;
						}						

						if(tmp_map.get("depthNo")!=null){
							rsDEPTH_NO =  Integer.parseInt(String.valueOf(tmp_map.get("depthNo")));
						}else{
							rsDEPTH_NO =  0;
						}						

						if(tmp_map.get("linkTy")!=null){
							rsLINK_TY = (String)tmp_map.get("linkTy");
						}else{
							rsLINK_TY =  "";
						}						

						if(tmp_map.get("subCnt")!=null){
							rsSUB_CNT =  Integer.parseInt(String.valueOf(tmp_map.get("subCnt")));
						}else{
							rsSUB_CNT =  0;
						}						
					
					}


			}else{
				
				result_map.put("TRS_MSG","메뉴가 정확하지 않습니다.");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;					
			}
				
				log.debug("moveMNM 2===============================================");	
			// 현재 이동될 메뉴위치와 기존 메뉴위치를 확인해서 menu의 order와 depth의 변경값을 셋팅한다
			move_ORDER_NO = rsSUB_CNT;//하위메뉴의 갯수만큼 순번을 생성한다
			// 옮길 상위메뉴가 같은레벨이거나 상위레벨인경우 2 3
			if(rsDEPTH_NO <= Integer.parseInt(DEPTH_NOh)){
				move_DEPTH_NO = rsDEPTH_NO+1;
				move_gap = move_DEPTH_NO - Integer.parseInt(DEPTH_NOh);
			// 옮길 상위메뉴가 하위레벨인경우 4 3
			}else{
				move_DEPTH_NO = rsDEPTH_NO+1;
				move_gap = move_DEPTH_NO - Integer.parseInt(DEPTH_NOh);
			}
			log.debug("moveMNM 3===============================================move_DEPTH_NO:"+move_DEPTH_NO);
			log.debug("moveMNM 3===============================================move_gap:"+move_gap);


			log.debug("moveMNM 4==============================================="+sel_code);
			//log.debug("moveMNM 5-1==============================================="+sel_code);
					
			// 이동할 메뉴의 상위코드를 이동될 메뉴로 변경하고 정렬순번과 깊이를 수정한다
					sql = "JiCmMnm.moveMenu";
					query_param = new HashMap();
					query_param.put("move_depth_no",rsDEPTH_NO+1);
					query_param.put("move_order_no",rsSUB_CNT);
					query_param.put("move_code",move_code);
					query_param.put("sel_code",sel_code);
					
					update(sql, query_param);	

			// 메뉴관리테이블에서 빠진순번을 조정한다
			sql = "JiCmMnm.updateDelMENU";
			query_param = new HashMap();
			query_param.put("sel_up_code",sel_up_code);
			query_param.put("ORDER_NOh",ORDER_NOh);
			
			update(sql, query_param);
			log.debug("moveMNM : sel_up_code:"+sel_up_code);
			log.debug("moveMNM : ORDER_NOh:"+ORDER_NOh);
			
			// 메뉴 js생성
			createMenuTreeJs(param);		

			result_map.put("TRS_MSG","이동되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");		
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");		
		}catch(Exception q){
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");			
		/*}catch(Exception q){
			result_map.put("TRS_MSG","이동중에러가 발생했습니다");
			result_map.put(ConfigMgr.getProperty("RESULT_URL_R_KEY"),"Y");
			result_map.put(ConfigMgr.getProperty("RESULT_STA_KEY"),ConfigMgr.getProperty("FORWARD_FAILURE"));			
			log.debug("moveMNM Exception:");*/
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== moveMNM : END ====");
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
	public Map selectListMenuTree (Map param) throws Exception {
		//	TODO selectListMenuTree
		log.debug("==== selectListMenuTree Start ====");
		Map result_map = new HashMap();

		int totalCount = 0;
		
		try{
			
			String sql = "JiCmMnm.getMENUTree";	
			Map query_param = new HashMap();
			List rtn_list  = list(sql, query_param);

	  		totalCount = rtn_list.size();
	  		
	  		List gridList = cmsService.getGridListScroll(rtn_list);
	  		result_map.put("treerows",gridList);
	  		result_map.put("treetotal",totalCount);
		}catch(NullPointerException q){
			log.debug("Exception:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("Exception:");				
		
		}catch(Exception q){
			log.debug("==== selectListMenuTree Exception ====");
		}
    	log.debug("==== selectListMenuTree End ====");
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
	public void createMenuTreeJs (Map param) throws Exception {
		//	TODO selectListMenuTree
		log.debug("==== createMenuTreeJs Start ====");
		Map rtn_row_Map = new HashMap();
		Map rtn_tmp_Map = new HashMap();
		String out_file_path = (String)param.get("contextRootRealPath")+"/js/";
		String out_file_orgnm = "Tree.js";
		HashMap codeparam = new HashMap();
		StringBuffer sb = new StringBuffer();
		String [] out_file_nm = new String[0];
		String sql = "JiCmMnm.getMENUCreatCnt";
		int i = 0;
		BufferedWriter fw = null;
		FileOutputStream fos = null;
		OutputStreamWriter osw = null;
		
		List ListTreeCM = new ArrayList();
		
		int depth1_ord = 1;
		int topmenu_cnt  = 0;
		
		
		int trprev_lv = 0;
		int trtmp_lv = 0;
		int trinit_lv = 0;
		int tri = 0;		

		
		try{
			// 생성할 최상위리스트를 불러온다
			sql = "JiCmMnm.getMENUCreatList";
			codeparam = new HashMap();
	    	List list =  list(sql, codeparam);

	    	// 파일을 생성할 StringBuffer배열을 선언한다
	    	/*if (list==null || list.size()==0 || ((Integer)(list.get(0))).intValue() == 0){
		    	 sb = new StringBuffer[0];
		    	 out_file_nm = new String[0];
		    }else{
		    	 sb = new StringBuffer[((Integer)(list.get(0))).intValue()];
		    	 out_file_nm = new String[((Integer)(list.get(0))).intValue()];
		    }*/
			
	    	 
	    	 out_file_nm = new String[list.size()];			
			for(i=0;i<list.size();i++){
				rtn_tmp_Map = (Map)list.get(i);
				log.debug("==== createMenuTreeJs menuCd ====::"+(String)rtn_tmp_Map.get("menuCd"));
				sb = new StringBuffer();
				// 관리자시스템 일경우
				if("sysadm".equals((String)rtn_tmp_Map.get("menuCd"))){
					//log.debug("==== createMenuTreeJs sysadm ====::111111111111:"+(String)rtn_tmp_Map.get("menuCd"));
					sb.append(""+"\n");
					sb.append("var treeleftval = new Array();"+"\n");
					sb.append("var treeleftval_tmp = new Array(); "+"\n");					
					//log.debug("==== createMenuTreeJs sysadm ====::2222222222222222222222:"+(String)rtn_tmp_Map.get("menuCd"));
					out_file_nm[i] = out_file_path+(String)rtn_tmp_Map.get("menuCd")+""+out_file_orgnm;
					//log.debug("Tree menu "+(String)rtn_tmp_Map.get("menuCd")+" Create Js:"+out_file_nm[i]);
					
				    // 전체 코드를 가져온다
					codeparam = new HashMap();
					codeparam.put("all_fl", "000000");
					codeparam.put("level", 1);
					codeparam.put("adminmenu", "N");
					
					ListTreeCM = (List)cmDAO.getMenuTree(codeparam).get("ListTreeCM");
					// 현재선택 메뉴의 1depth번호를 확인한다
					depth1_ord = 1;
					topmenu_cnt  = 0;
					
					
					trprev_lv = 0;
					trtmp_lv = 0;
					trinit_lv = 0;
					tri = 0;
					// 코드배열에 담긴값을 출력한다
					if(ListTreeCM.size() > 0){
						for(tri=0 ;tri<ListTreeCM.size();tri++){
							rtn_row_Map = (Map)ListTreeCM.get(tri);
							
							// 관리자 메뉴 js파일은 무조건 셋팅한다
							//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다
							if (tri==0){
								trinit_lv =  Integer.parseInt(String.valueOf(rtn_row_Map.get("lv")));
							}
							trtmp_lv = Integer.parseInt(String.valueOf(rtn_row_Map.get("lv"))) - trinit_lv;

							if (tri==0){
								sb.append("treeleftval["+trtmp_lv+"] = new Array();"+"\n");
							}else if( trprev_lv < trtmp_lv ){
								sb.append("treeleftval["+trtmp_lv+"] = new Array();"+"\n");
							}

							sb.append("treeleftval_tmp = new Array();"+"\n");
							sb.append("treeleftval_tmp[0] = \""+rtn_row_Map.get("menuCd")+"\";"+"\n");//' M_CODE
							sb.append("treeleftval_tmp[1] = \""+rtn_row_Map.get("menuNm")+"\";"+"\n");//' M_NM
							sb.append("treeleftval_tmp[2] = \""+rtn_row_Map.get("menuUppoCd")+"\";"+"\n");//' M_UP_CODE
							sb.append("treeleftval_tmp[3] = \""+rtn_row_Map.get("depthNo")+"\";"+"\n");//' DEPTH_NO
							sb.append("treeleftval_tmp[4] = \""+rtn_row_Map.get("orderNo")+"\";"+"\n");//' ORDER_NO
							sb.append("treeleftval_tmp[5] = \""+rtn_row_Map.get("linkTy")+"\";"+"\n");//' LINK_TY
							sb.append("treeleftval_tmp[6] = \""+(String)rtn_row_Map.get("mCodes")+"\";"+"\n");//' M_CODES
							sb.append("treeleftval_tmp[7] = \""+rtn_row_Map.get("lv")+"\";"+"\n");//' LV
							sb.append("treeleftval_tmp[8] = \""+rtn_row_Map.get("linkPath")+"\";"+"\n");//' LINK_PATH
							sb.append("treeleftval_tmp[9] = \""+rtn_row_Map.get("linkTarget")+"\";"+"\n");//' LINK_TARGET
							sb.append("treeleftval_tmp[10] = \""+rtn_row_Map.get("treeSubCnt")+"\";"+"\n");//' TREE_SUB_CNT
							sb.append("treeleftval_tmp[11] = \""+rtn_row_Map.get("boardTy")+"\";"+"\n");//' BOARD_TY
							
							sb.append("treeleftval["+trtmp_lv+"].push(treeleftval_tmp);"+"\n");
							
							trprev_lv = trtmp_lv;

						}
						fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(out_file_nm[i]),"UTF-8"));
						fw.write(sb.toString());
						fw.flush();

					}
				// 일반 시스템 일경우
				}else{
					sb.append("");
					sb.append("var listtreeval = new Array();");
					sb.append("var listtreeval_tmp = new Array(); ");
					out_file_nm[i] = out_file_path+(String)rtn_tmp_Map.get("menuCd")+""+out_file_orgnm;	
					//log.debug("Tree menu "+(String)rtn_tmp_Map.get("menuCd")+" Create Js:"+out_file_nm[i]);
				    // 전체 코드를 가져온다
					codeparam = new HashMap();
					codeparam.put("all_fl", (String)rtn_tmp_Map.get("menuCd"));
					codeparam.put("lev", 1);
					codeparam.put("sub_yn", "N");
					codeparam.put("use_yn", "Y");
					
					
					ListTreeCM = (List)cmDAO.getMenuTree(codeparam).get("ListTreeCM");
					// 현재선택 메뉴의 1depth번호를 확인한다
					depth1_ord = 1;
					topmenu_cnt  = 0;
					
					
					trprev_lv = 0;
					trtmp_lv = 0;
					trinit_lv = 0;
					tri = 0;
					// 코드배열에 담긴값을 출력한다
					if(ListTreeCM.size() > 0){
						for(tri=0 ;tri<ListTreeCM.size();tri++){
							rtn_row_Map = (Map)ListTreeCM.get(tri);
							
							// 관리자 메뉴 js파일은 무조건 셋팅한다
							//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다
							if (tri==0){
								trinit_lv =  Integer.parseInt(String.valueOf(rtn_row_Map.get("lv")));
							}
							trtmp_lv = Integer.parseInt(String.valueOf(rtn_row_Map.get("lv"))) - trinit_lv;

							if (tri==0){
								sb.append("listtreeval["+trtmp_lv+"] = new Array();"+"\n");
							}else if( trprev_lv < trtmp_lv ){
								sb.append("listtreeval["+trtmp_lv+"] = new Array();"+"\n");
							}

							sb.append("listtreeval_tmp = new Array();"+"\n");
							sb.append("listtreeval_tmp[0] = \""+rtn_row_Map.get("menuCd")+"\";"+"\n");//' M_CODE
							sb.append("listtreeval_tmp[1] = \""+rtn_row_Map.get("menuNm")+"\";"+"\n");//' M_NM
							sb.append("listtreeval_tmp[2] = \""+rtn_row_Map.get("menuUppoCd")+"\";"+"\n");//' M_UP_CODE
							sb.append("listtreeval_tmp[3] = \""+rtn_row_Map.get("depthNo")+"\";"+"\n");//' DEPTH_NO
							sb.append("listtreeval_tmp[4] = \""+rtn_row_Map.get("orderNo")+"\";"+"\n");//' ORDER_NO
							sb.append("listtreeval_tmp[5] = \""+rtn_row_Map.get("linkTy")+"\";"+"\n");//' LINK_TY
							sb.append("listtreeval_tmp[6] = \""+((String)rtn_row_Map.get("mCodes")).replaceAll("000000::", "")+"\";"+"\n");//' M_CODES
							sb.append("listtreeval_tmp[7] = \""+rtn_row_Map.get("lv")+"\";"+"\n");//' LV
							sb.append("listtreeval_tmp[8] = \""+rtn_row_Map.get("linkPath")+"\";"+"\n");//' LINK_PATH
							sb.append("listtreeval_tmp[9] = \""+rtn_row_Map.get("linkTarget")+"\";"+"\n");//' LINK_TARGET
							sb.append("listtreeval_tmp[10] = \""+rtn_row_Map.get("treeSubCnt")+"\";"+"\n");//' TREE_SUB_CNT
							sb.append("listtreeval_tmp[11] = \""+rtn_row_Map.get("boardTy")+"\";"+"\n");//' BOARD_TY
							
							sb.append("listtreeval["+trtmp_lv+"].push(listtreeval_tmp);"+"\n");
							
							trprev_lv = trtmp_lv;

						}
						fos = new FileOutputStream(out_file_nm[i]);
						if(fos!=null){
							osw = new OutputStreamWriter(fos,"UTF-8");
						}
						if(osw!=null){
							fw = new BufferedWriter(osw);
							fw.write(sb.toString());
							fw.flush();
						}
						
					}
				}
				
			}
			
		}catch(IOException q){
			log.debug("createMenuTreeJs IOException:");
			throw q;
		}catch(SQLException q){
			log.debug("createMenuTreeJs SQLException:");
			throw q;
		}catch(NullPointerException q){
			log.debug("createMenuTreeJs NullPointerException:");
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("createMenuTreeJs ArrayIndexOutOfBoundsException:");
			throw q;
		}catch(Exception q){
			log.debug("createMenuTreeJs Exception:");
			throw q;
		}finally{
			if(fos!=null)fos.close();
			if(osw!=null)osw.close();
			if(fw!=null)fw.close();
		}
		
    	log.debug("==== createMenuTreeJs End ====");
		
	}
}
