
package com.ji.dao.cm.apm;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

import com.ji.cm.CM_Util;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.util.Page;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : CmApmDAO01.java
 * @Description : CmApmDAO01 DAO Class 
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2015.03.20           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2015.03.20
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */

@Repository("cmApmDAO01")
public class CmApmDAO01 extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmApmDAO01.class); //현재 클래스 이름을 Logger에 등록

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
	 * 결재업무관리 메소드
	 * @param Map
	 * @return Map
	 * @exception Exception
	 */
    // TODO : ctlCMS
    @SuppressWarnings("unchecked")
	public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO ctlCMS
		log.debug("==== ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		
		try{
			
			if(pstate.equals("L")){
				//업무구분
				result_map.put("staprv_job_cl_cd",cmDAO.bizMakeOptionList("M00012", "")); 
				
			// 결재업무리스트
			}else if(pstate.equals("X")){ //ajax jqGrid data관련
				result_map = selectListAprvJobGrid(param); 
				
			// 등록처리
			}else if(pstate.equals("C")){
				result_map = insertAprvJob(param);	
				
			// 결재업무선택팝업
			}else if(pstate.equals("PF1")){
				//업무구분
				result_map.put("staprv_job_cl_cd",cmDAO.bizMakeOptionList("M00012", "")); 
			// 결재업무선택팝업
			}else if(pstate.equals("PX1")){
				// 검색어가 있는경우만 조회한다
				if(!HtmlTag.returnString((String)param.get("stext"),"").equals("") || !HtmlTag.returnString((String)param.get("saprv_job_cl_cd"),"").equals("")){					
					result_map = selectListAprvJobGrid(param);	
				}

			}

		}catch(IOException q){
			log.debug("IOException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}		
		}catch(SQLException q){
			log.debug("SQLException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
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
		}catch(JSysException q){
			log.debug("ctlCMS JSysException Exception:");
			throw q;
		}catch(Exception q){
			log.debug("ctlCMS Exception:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
			throw q;
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }

    
	
 
	
	/**
	 * Method Name  : selectListAprvJobGrid
	 * Description  : 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2015/03/23 : 이금용:  최초작성
	*/
	//	TODO selectListAprvJobGrid
	public Map selectListAprvJobGrid (Map param) throws Exception {
		
		log.debug("==== selectListAprvJobGrid Start ====");
		Map result_map = new HashMap();
		//int curr_page = Integer.parseInt(HtmlTag.returnString((String)param.get("curr_page"),"1"),10);		
		//int show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"10"),10);
		int curr_page = Integer.parseInt(HtmlTag.returnString((String)param.get("jqGrid.page"),"1"));	//com.js를 사용하는 jqgrid는 그리드변수를 이와 같이 변경필요	-mrkim (2015/06/18))
		int show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("jqGrid.rows"),"10"));	//com.js를 사용하는 jqgrid는 그리드변수를 이와 같이 변경필요	-mrkim (2015/06/18))


		String s_menu_cd = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("s_menu_cd"),""));
		String [] s_menu_cd_sp = new String[0];
		try{
			s_menu_cd_sp = s_menu_cd.split(",");
			param.put("s_menu_cd_sp", s_menu_cd_sp);
			Page page = getPageGridPaging("cmApmDAO.selectListAprvJob", param, curr_page, show_rows);
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

			
		}catch(NullPointerException q){
			log.debug("Exception:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("Exception:");
			
		}catch(Exception q){
			log.debug("Exception:");
		}
    	log.debug("==== selectListAprvJobGrid End ====");
		return result_map;
	} 	
	
	/**
	* <p> ctlCMS(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	// TODO : insertAprvJob
	public Map insertAprvJob(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== insertAprvJob : START ====");
		Map result_map = new HashMap();
		
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
	    // 그리드 삭제정보
	    String delkey		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("delkey"),""));
	    String [] delkey_sp = new String[0];
	    int i = 0;
	    JSONArray jsonArray;
	    Map jsonObjmap = new HashMap();
	    Map tmp_map = new HashMap();
	    Map rtn_map = new HashMap();
	    Iterator iterator;

		String sql = "cmApmDAO.insertAprvJob";	

		int JIT9140_SQ = 0;

		try{
			// 등록자 id 셋팅
			param.put("user_id", USER_ID);

			
			if(!delkey.equals("")){
				delkey_sp = delkey.split(",");
				sql = "cmApmDAO.deleteAprvJob"; 
				param.put("delkey", delkey);
				param.put("delkey_sp", delkey_sp);
				param.put("user_id", USER_ID);
				update(sql, param);
			}
			
			// 결재업무 목록을 저장한다
			jsonArray = JSONArray.fromObject(((String) param.get("JSONDataList")).replaceAll("&amp;quot;", "\""));
			
			for(i=0;i<jsonArray.size();i++){
				jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
				iterator = jsonObjmap.entrySet().iterator();
			
				  while (iterator.hasNext()) {
					   Entry entry = (Entry)iterator.next();

					   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
				  }

				  
				  if(HtmlTag.returnString((String)tmp_map.get("aprv_job_seqno"),"").equals("")){
					  // 등록전에 메뉴코드와 메뉴상태코드가 중복이면 에러 처리한다
					  sql = "cmApmDAO.getAprvJobChk";
					  rtn_map = cmDAO.getformData (tmp_map ,sql);
					  if(Integer.parseInt((String)((Map)rtn_map.get("ViewMap")).get("chkcnt")) > 0){
					
						  throw new JSysException("동일한 메뉴에 같은 메뉴상태로 결재업무를 등록할수 없습니다.");	
					  }
					  
					   sql = "cmApmDAO.insertAprvJob"; 
					  //sequence 추출
					  JIT9140_SQ = cmDAO.getSequence("JIT9140");
					  tmp_map.put("aprv_job_seqno", JIT9140_SQ);
					  tmp_map.put("user_id", USER_ID); 
					  insert(sql, tmp_map);					  
				  }else{
					  sql = "cmApmDAO.updateAprvJob"; 
					  tmp_map.put("user_id", USER_ID); 
					  insert(sql, tmp_map);
				  }

			}

			
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertAprvJob Exception:");	
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertAprvJob Exception:");	
			throw q;
		}catch(JSysException q){			
			log.debug("JSysException:");	
			throw q;
		}catch(Exception q){
			result_map.put("result","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertAprvJob Exception:");			
			throw new JSysException("등록중에러가 발생했습니다");
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertAprvJob : END ====");
		return result_map;	
	}	
  
 

}
