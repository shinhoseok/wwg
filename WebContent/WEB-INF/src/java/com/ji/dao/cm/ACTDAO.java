package com.ji.dao.cm;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;




import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.Param;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;

/**  
 * @Class Name : ACTDAO.java
 * @Description : ACTDAO DAO Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.10.26           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2016.10.26
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */



@Repository("actDAO")
public class ACTDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(ACTDAO.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	

    /**
	 * 컨트롤 메소드
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
				result_map = getListACT(param);
			// 등록
			}else if(pstate.equals("C")){
				result_map = insertACT(param);
			// 삭제
			}else if(pstate.equals("D")){
				result_map = deleteACT(param);
			}

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
	* <p> ctlACT(메인Dao컨트롤클래스)에서 컨텐츠관리관련 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  컨텐츠관리관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getListACT (Map param) throws Exception {
		//	TODO getListACT
		log.debug("==== getListACT Start ====");
		Map result_map = new HashMap();
		String pcode = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("pcode"),""));//메뉴코드
	
		String sql = "JiCmAct.getContents";	
		List res_list = new ArrayList();
		Map query_param = new HashMap();
		try{
			query_param.put("pcode", pcode);
			res_list = list(sql, query_param);
			result_map.put("ListACT", res_list);	

			result_map.put("TRS_MSG","");


		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		
				

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}

    	log.debug("==== getListACT End ====");
		return result_map;
	}	
	

	/**
	 * @throws IOException 
	 * @throws SQLException 
	* <p> ctlACT(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	//	TODO insertACT 
	public Map insertACT(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		
		log.debug("==== insertACT : START ====");
		Map result_map = new HashMap();
	
		String[] rtn_form_obj_in = {"scode","pcode"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();

		String M_CONTENTS = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("smarteditor"),""));//컨텐츠내용
		
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));

		long max_seq = 0;
		
		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JIT9505","IDX","");
	
		String sql = "JiCmAct.insertContents";	
		try{
			// 결과값을 처리할 form객체를 생성한다

			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);

			rtn_form_obj = Param.getListToArr(form_list);

			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")

							,Param.getFormObjectIn(param, rtn_form_obj,null,null));

			param.put("max_seq", max_seq);
			param.put("USER_ID", USER_ID);
			param.put("M_CONTENTS", M_CONTENTS);
			insert(sql, param);


			result_map.put("TRS_MSG","등록되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");

			
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		
				

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
		
		}

		log.debug("==== insertACT : END ====");

		return result_map;	

	}

	

	/**
	* <p> ctlACT(메인Dao컨트롤클래스)에서 해당데이터를 삭제하는 메소드</p>
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
	//	TODO deleteACT 
	public Map deleteACT(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{

		log.debug("==== deleteACT : START ====");
		Map result_map = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		//log.debug(message)

	    String sql = "JiCmAct.deleteContents";	

		try{
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY") ,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			delete(sql, param);				

			result_map.put("TRS_MSG","삭제되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");

		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		
				

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
			
		}

		log.debug("==== deleteACT : END ====");

		return result_map;	

	}    


}

