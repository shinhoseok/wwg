
package com.ji.dao.cm.apm;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.util.Page;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : CmApmDAO03.java
 * @Description : CmApmDAO03 DAO Class 
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

@Repository("cmApmDAO03")
public class CmApmDAO03 extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmApmDAO03.class); //현재 클래스 이름을 Logger에 등록

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
		List rtn_list = new ArrayList();
		List gridList = new ArrayList();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		log.debug("==== CmApmDAO03 ctlCMS pstate ===="+param);
		try{
			
			if(pstate.equals("L")){
				
				//결재상태
				result_map.put("staprv_stat_cd",cmDAO.bizMakeOptionListLabel("M00013", ""));
			
			// 결재현황리스트(관리자)
			}else if(pstate.equals("X")){ //ajax jqGrid data관련
				result_map = selectListAprvGrid(param);

			// 결재선지정 기본 본인조회
			}else if(pstate.equals("X2")){ //ajax jqGrid data관련
				log.debug("==== ctlCMS X2 Start ====");
				
				rtn_list = list("cmApmDAO.getselectAprvLine", param);
				gridList = cmsService.getGridListScroll(rtn_list);
				result_map.put("rows", gridList);
				result_map.put("result",true);
				
				log.debug("==== ctlCMS X2 end ====");
				
			// 결재선지정 팝업 저장된 결재선조회
			}else if(pstate.equals("X3")){ //ajax jqGrid data관련	
				log.debug("==== ctlCMS X3 Start ====");
				Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
				String USER_ID ="";

				if(SITE_ADM_SESSION!=null){
					USER_ID	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					param.put("user_id", USER_ID);
				}
				
				result_map = cmDAO.selectListGrid(param, "cmApmDAO.getselectAprvDefault"); 
				list("cmApmDAO.getselectAprvDefault", param);

					
/*				if(Integer.parseInt(result_map.get("records").toString())==0){
					//기본결재선 없을경우
					rtn_list = list("cmApmDAO.getselectAprvLine", param);
					gridList = cmsService.getGridListScroll(rtn_list);
					result_map.put("rows",gridList);
				}*/
				
				log.debug("==== ctlCMS X3 end ====");

			// 결재선지정 팝업 결재선 목록
			}else if(pstate.equals("X4")){ //ajax jqGrid data관련
				Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
				String USER_ID ="";
				if(SITE_ADM_SESSION!=null){
					USER_ID	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					param.put("user_id", USER_ID);
				}
				result_map = cmDAO.selectListGrid(param, "cmApmDAO.selectListBaseAprvLineGridX");
				
				
			// 결재상태, 결재선정보를 가져온다
			}else if(pstate.equals("AX1")){ //ajax jqGrid data관련
				result_map = selectListAprv(param);
				//업무구분
				result_map.put("staprv_job_cl_cd",cmDAO.bizMakeOptionList("M00013", "")); 	
				result_map.put("absence",cmDAO.bizMakeOptionList("M00030", "")); //부재 구분코드
				
			// 개인 결재상태, 결재선정보를 가져온다
			}else if(pstate.equals("AX2")){ //ajax jqGrid data관련
				result_map = selectListAprvPs(param);
 			
			// 등록처리
			}else if(pstate.equals("C")){
				
			// 결재상태조회팝업창 호출
			}else if(pstate.equals("PF1")){	
			
			
			}else if(pstate.equals("PX1")){
				// 검색어가 있는경우만 조회한다
				if(!HtmlTag.returnString((String)param.get("real_stat_seqno"),"").equals("")){					
					result_map = selectListAprvStat(param);	
				}
			
			// 결재선 선택 팝업창 호출
			}else if(pstate.equals("PF2")){	
				log.debug("==== ctlCMS PF2 start ====");
				
				int i = 0;
			    JSONArray jsonArray;
			    Map jsonObjmap = new HashMap();
			    Map tmp_map = new HashMap();
			    Iterator iterator;
			    rtn_list = new ArrayList();
			    
			    if(param.get("JSONDataListAprv")!=null){
					// 결재업무 목록을 저장한다
					jsonArray = JSONArray.fromObject(((String) param.get("JSONDataListAprv")).replaceAll("&amp;amp;quot;", "\""));
					
					for(i=0;i<jsonArray.size();i++){
						jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
						iterator = jsonObjmap.entrySet().iterator();
						tmp_map = new HashMap();
						  while (iterator.hasNext()) {
							   Entry entry = (Entry)iterator.next();
							   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
						  }
						  
						rtn_list.add(tmp_map);
					}
			    }

				result_map.put("aprv_line_json",rtn_list);
				
				log.debug("==== ctlCMS PF2 end ====");
				
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
	 * Method Name  : selectListAprvGrid
	 * Description  : 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2015/05/08 : 이금용:  최초작성
	*/
	//	TODO selectListAprvGrid
	public Map selectListAprvGrid (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		
		log.debug("==== selectListAprvGrid Start ====");
		Map result_map = new HashMap();
		
		String s_menu_cd = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("s_menu_cd"),""));
		String [] s_menu_cd_sp = new String[0];
		try{
			 Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			 String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
			 param.put("sess_id", USER_ID);
			if(SITE_ADM_SESSION!=null){
				// 시스템 관리자 일경우
				if(((String)SITE_ADM_SESSION.get("ADMAUTH")).equals("Y")){
					param.put("admauth", "Y");

				}
			
			}
			
			
			s_menu_cd_sp = s_menu_cd.split(",");
			param.put("s_menu_cd_sp", s_menu_cd_sp);
			
/*			Page page = getPageGridPaging("cmApmDAO.selectListAprvGrid", param, curr_page, show_rows);
			totalCount = page.getTotalCount();
			List gridList = cmsService.getGridList(page); //그리드 데이터 반화
			//ajax jqGrid data관련
			result_map.put("page", page.getCurrentPage());  //현재 page번호
			result_map.put("total", page.getMaxPage()); 	//전체 page번호
			result_map.put("records", page.getTotalCount()); //전체 record수
			result_map.put("rows",gridList);*/
			
			//result_map = cmDAO.selectListGrid(param, "cmApmDAO.selectListAprvGrid"); 
			//list("cmApmDAO.selectListAprvGrid", param);

			List rtn_list = new ArrayList();
			rtn_list = list("cmApmDAO.selectListAprvGrid", param);

			List gridList = cmsService.getGridListScroll(rtn_list);
			result_map.put("rows",gridList);
		}catch(NullPointerException q){
			log.debug("Exception:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("Exception:");			
		}catch(Exception q){
			log.debug("==== selectListAprvGrid Exception ====");
		}
		
    	log.debug("==== selectListAprvGrid End ====");
		return result_map;
	} 
	
	
	/**
	 * Method Name  : selectListAprv
	 * Description  : 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2015/05/04 : 이금용:  최초작성
	*/
	//	TODO selectListAprv
	public Map selectListAprv (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		log.debug("============= selectListAprv Start ==============");
		
		Map result_map = new HashMap();
		Map rtn_map = new HashMap();

		String aprv_key = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_key"),""));
		String sql = "";
		List rtn_list = new ArrayList();
		List gridList = new ArrayList();
		try{
			Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			param.put("sess_id", (String)SITE_ADM_SESSION.get("USER_ID"));
			
	  		// 키값이 있으면 결재요청중인지 확인한다 요청중이 아니면 개인 기본결재선을 불러온다
	  		if(aprv_key.equals("")){
	  		log.debug("======= 1111 =======");
	  			rtn_list = list("cmApmDAO.selectListAprvB", param);	//기본결재선조회
		  		gridList = cmsService.getGridListScroll(rtn_list);
		  		result_map.put("aprv_line",gridList);
		  		
	  			result_map.put("aprv_reqchk",false);
	  			result_map.put("aprv_stat_cd","");
	  			result_map.put("aprv_req_nm","");
	  			
				sql = "cmApmDAO.getAprvReqChkNokey";
				rtn_map = cmDAO.getformData (param ,sql);
				result_map.put("aprv_job_cl_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_job_cl_cd"));
	  			
	  		}else{
	  			
				sql = "cmApmDAO.getAprvReqChk";
				rtn_map = cmDAO.getformData (param ,sql);
				
				// 결재 연결 키값으로 실결재선이 등록되어 있는지확인한다
				// 실결재선이 있으면
				if(rtn_map.get("ViewMap")!=null){
				log.debug("======= 2222 =======");
					  rtn_list = list("cmApmDAO.selectListAprvR", param);
				  	  gridList = cmsService.getGridListScroll(rtn_list);
				  	  result_map.put("aprv_line",gridList);
				  	  
					  if(Integer.parseInt((String)((Map)rtn_map.get("ViewMap")).get("chkcnt")) > 0){
						  result_map.put("aprv_reqchk",true);
						  result_map.put("aprv_job_cl_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_job_cl_cd"));
						  result_map.put("aprv_stat_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_stat_cd"));
						  result_map.put("aprv_req_nm",(String)((Map)rtn_map.get("ViewMap")).get("aprv_req_nm"));
						  
					  }else{
						  result_map.put("aprv_reqchk",false);
						  result_map.put("aprv_job_cl_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_job_cl_cd"));	
						  result_map.put("aprv_stat_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_stat_cd"));
						  result_map.put("aprv_req_nm",(String)((Map)rtn_map.get("ViewMap")).get("aprv_req_nm"));
					  }
					  
				// 실결재선이 없으면 개인기본 결재선을 불러온다
				}else{
				log.debug("======= 3333 =======");
			  			rtn_list = list("cmApmDAO.selectListAprvB", param);
				  		gridList = cmsService.getGridListScroll(rtn_list);
				  		result_map.put("aprv_line",gridList);
						
						result_map.put("aprv_reqchk",false);
						result_map.put("aprv_stat_cd","");
						result_map.put("aprv_req_nm","");
					
						sql = "cmApmDAO.getAprvReqChkNokey";
						rtn_map = cmDAO.getformData (param ,sql);
						result_map.put("aprv_job_cl_cd",(String)((Map)rtn_map.get("ViewMap")).get("aprv_job_cl_cd"));
				}
	  		}
	  		
	  		// 결재연결키값이 있으면 현재 결재상태와 현재 결재자와 다음 결재자정보를 불러온다.
	  		result_map.put("result",true);
			
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprv Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprv Exception:");		
		}catch(Exception q){
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprv Exception:");			

		}
		

    	log.debug("==== selectListAprv End ====");
		return result_map;
	} 
	
	/**
	 * Method Name  : selectListAprvPs
	 * Description  : 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2015/06/09 : 이금용:  최초작성
	*/
	//	TODO selectListAprvPs
	public Map selectListAprvPs (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		
		log.debug("==== selectListAprvPs Start ====");
		Map result_map = new HashMap();

		try{
			Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			param.put("sess_id", (String)SITE_ADM_SESSION.get("USER_ID"));
	  		// 키값이 있으면 개인 기본결재선을 불러온다
/*	  		if(!aprv_key.equals("")){
	  			rtn_list = list("cmApmDAO.selectListAprvB", param);
		  		gridList = cmsService.getGridListScroll(rtn_list);
		  		result_map.put("aprv_ps_line",gridList);
		  		
	  			result_map.put("aprv_ps_reqchk",false);
	  			
	  		}*/
	  		
	  		// 결재연결키값이 있으면 현재 결재상태와 현재 결재자와 다음 결재자정보를 불러온다.
	  		//result_map.put("result",true);
			
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvPs Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvPs Exception:");		
		}catch(Exception q){
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvPs Exception:");			

		}
		
    	log.debug("==== selectListAprvPs End ====");
		return result_map;
	}	
	
	
	/**
	* 결재상태조회 팝업
	* Method Name  : selectListAprvStat
	* Description  : 
	* Comment      : 
	* Parameter    : param - 정보가 담긴 Map 
	* form History : 2015/05/06 : 이금용:  최초작성
	*/
	//	TODO selectListAprvStat
	public Map selectListAprvStat (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		
		log.debug("==== selectListAprvStat Start ====");
		Map result_map = new HashMap();
		Map rtn_map = new HashMap();
		Map ViewMap = new HashMap();

		String real_stat_seqno = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("real_stat_seqno"),""));
		String sql = "";
		
		try{
			Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			
			//result_map = cmDAO.selectListGrid(param, "cmApmDAO.selectListAprvStat");
  			//list("cmApmDAO.selectListAprvStat", param);

	  		List rtn_list = new ArrayList();
  			rtn_list = list("cmApmDAO.selectListAprvStat", param);
	  		
	  		List gridList = cmsService.getGridListScroll(rtn_list);
	  		result_map.put("rows",gridList);
	  		
	  		// 일반사용자일경우 해당결재선의 다음결재선의 수신자를 가져온다
/*	  		if(((String)param.get("admauth")).equals("N")){
	  			ViewMap = cmDAO.getListSqlOnlyView(param, "cmApmDAO.getselectRecvInfo");
	  			result_map.put("recv_info",ViewMap);
	  		}else{
	  			result_map.put("recv_info",ViewMap);
	  		}*/
	  		
	  		// 결재연결키값이 있으면 현재 결재상태와 현재 결재자와 다음 결재자정보를 불러온다.
	  		result_map.put("result",true);
		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStat Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStat Exception:");		
		}catch(Exception q){
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStat Exception:");			

		}
		

    	log.debug("==== selectListAprvStat End ====");
		return result_map;
	}	
	
	/**
	 * 조직에 상관없이 모든 결재선리스트 조회
	 * Method Name  : selectListAprvStatAll
	 * Description      :  한글보고서 결재선 표시에서 사용 
	 * Comment        :  
	 * Parameter       : 
	 * form History    : 2015. 9. 6. : mrkim:  최초작성
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map selectListAprvStatAll (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		
		log.debug("==== selectListAprvStatAll Start ====");
		Map result_map = new HashMap();
		Map rtn_map = new HashMap();

		String real_stat_seqno = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("real_stat_seqno"),""));
		String sql = "";
		try{
			Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			
			if(SITE_ADM_SESSION!=null){
				param.put("admauth", "Y");
				// 시스템 관리자가 아닐경우
				if(!((String)SITE_ADM_SESSION.get("ADMAUTH")).equals("Y")){
					param.put("root_org_cd", (String)SITE_ADM_SESSION.get("ROOT_ORG_CD"));
				}				
			}
			
	  		List rtn_list = new ArrayList();
  			rtn_list = list("cmApmDAO.selectListAprvStat", param);
	  		
	  		List gridList = cmsService.getGridListScroll(rtn_list);
	  		result_map.put("rows",gridList);
			
			//result_map = cmDAO.selectListGrid(param, "cmApmDAO.selectListAprvStat");
  			//list("cmApmDAO.selectListAprvStat", param);

	  		
	  		// 일반사용자일경우 해당결재선의 다음결재선의 수신자를 가져온다
	  		if(((String)param.get("admauth")).equals("N")){
	  			//Map ViewMap = cmDAO.getListSqlOnlyView(param, "cmApmDAO.getselectRecvInfo");
	  			//result_map.put("recv_info",ViewMap);
	  		}else{
	  			result_map.put("recv_info",null);
	  		}
	  		
	  		// 결재연결키값이 있으면 현재 결재상태와 현재 결재자와 다음 결재자정보를 불러온다.
	  		result_map.put("result",true);
			
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStatAll Exception:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStatAll Exception:");		
		}catch(Exception q){
			result_map.put("result",false);
			result_map.put("TRS_MSG","결재선 조회중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("selectListAprvStatAll Exception:");			

		}
		

    	log.debug("==== selectListAprvStatAll End ====");
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
	// 관리자페이지 결재업무등록
	public Map insertAprvJob(Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== insertAprvJob : START ====");
		Map result_map = new HashMap();
		
	    Map SITE_ADM_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID = HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
	    
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
			jsonArray = JSONArray.fromObject(((String) param.get("JSONDataList")).replaceAll("&amp;amp;quot;", "\""));
			
			for(i=0;i<jsonArray.size();i++){
				jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
				iterator = jsonObjmap.entrySet().iterator();
			
				  while (iterator.hasNext()) {
					   Entry entry = (Entry)iterator.next();
					   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
				  }

				  
				  if(HtmlTag.returnString((String)tmp_map.get("aprv_job_cl_cd"),"").equals("")){
					  // 등록전에 메뉴코드와 메뉴상태코드가 중복이면 에러 처리한다
					  sql = "cmApmDAO.getAprvJobChk";
					  rtn_map = cmDAO.getformData (tmp_map ,sql);
					  if(Integer.parseInt((String)((Map)rtn_map.get("ViewMap")).get("chkcnt")) > 0){
					
						  throw new JSysException("동일한 메뉴에 같은 메뉴상태로 결재업무를 등록할수 없습니다.");	
					  }
					  
					  sql = "cmApmDAO.insertAprvJob";
					  //sequence 추출
					  JIT9140_SQ = cmDAO.getSequence("JIT9140");
					  tmp_map.put("aprv_job_cl_cd", JIT9140_SQ);
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
  
 
	/**
	* <p> InsertAprvReq(등록화면)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   

	* @return  등록 결과값을 리턴한다
	* @throws JSysException 
	* @throws  
	*/
    //	TODO InsertAprvReq
	public Map InsertAprvReq(Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		 
		log.debug("==== InsertAprvReq Start ====");

		Map result_map = new HashMap();
		Map tmp_map = new HashMap();
		Map tmp_aprvjob_map = new HashMap();
		Map tmp_aprvgroup_map = new HashMap();
		Map tmp_absence_map = new HashMap();
		Map tmp_next_map = new HashMap();
		Map tmp_ep = new HashMap();

		//log.debug("1===========================================================SITE_ADM_SESSION_FN:"+propertiesService.getString("SITE_ADM_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    //log.debug("1===========================================================USER_ID:"+(String)SITE_ADM_SESSION.get("USER_ID"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
	    String USER_NM			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
	    String ORG_CD			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_CD"),""));
	    String ORG_NM			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_NM"),""));
	    
	    String pcode			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("pcode"),""));
	    
	    String aprv_key			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_key"),""));
	    String aprv_pcode		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_pcode"),""));
	    String JSONDataListAprv	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("JSONDataListAprv"),""));
	    String aprv_stat_cd		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_stat_cd"),""));
	    String ikey_datas 		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("ikey_datas"),""));			// 결재요청업무번호
	    String iaprv_req_nm		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("iaprv_req_nm"),""));		// 결재제목
	    String iappr_stat_desc  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("iappr_stat_desc"),""));		// 비고
	    String aprv_job_cl_cd   = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_job_cl_cd"),""));		// 결재업무구분코드
	    String aprv_req_job_no	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_req_job_no"),""));
	    
	    // 호출될 업무화면 파라메터명
	    String aprv_param_nm  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_param_nm"),""));
	    
	    // 호출될 업무화면 화면상태값
	    String aprv_reqpstate  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_reqpstate"),""));
	    
	    // 결재선 수정여부
	    String aprv_line_modify_yn = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("aprv_line_modify_yn"),"N"));
	    
	    // 현 결재 정보
	    String cur_real_stat_seqno  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cur_real_stat_seqno"),""));
	    String cur_aprv_seqno  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cur_aprv_seqno"),""));
	    String cur_aprv_lastyn  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cur_aprv_lastyn"),""));
	    
	    //현결재자아이디
	    String cur_aprv_emp_id  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cur_aprv_emp_id"),""));
	    
	    // 현결재상태
	    String cur_aprv_stat_cd  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("cur_aprv_stat_cd"),""));
	    
	    //결재요청업무번호
	    //String max_notice_no 	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("max_notice_no"),""));
	    
	    
	    String sql = "cmApmDAO.InsertAprvReq";
	    Map file_param = new HashMap();
	    int JIT9144_SQ = 0;
	    int JIT9142_SQ = 0;
	    int i = 0;
	    JSONArray jsonArray = null;
	    Map jsonObjmap = new HashMap();
	    Iterator iterator;	 
	    
	    
	    //결재관련
	    int j = 1;
/*	    boolean aprvFlag = true;	// 결재flag
	    String curtime = "";		// 현재시간
	    String kind = "";			// 결재구분	S:결재요청 / E:결재
	    String system_id = "";		// 결재자사번
	    String system_key = "";		// 연계시스템아이디
	    String doc_type = "";		// 결재문서고유번호
	    String date = "";			// 결재타입
	    String agree_empno = "";	// 결재문서도착/결재일시
	    String sender_empno = "";	// 문서최초 작성자 이름
	    String sender_name = "";	// 문서최초 작성자 사번
	    String url_temp = "";		// 주소
	    String title = "";			// 문서제목
	    String url = "";			// 결재시행할URL
	    String temp_url = "";		// 임시 주소
	    String status = "";			// 결재진행상태	0:진행중 / 1:완료 / 9:삭제
	    String data = "";			// 전체데이터
	    
	    String pstate = "";			// 상태코드
	    if(pcode.equals("000479")){
	    	pstate="UF";
	    }else if(pcode.equals("000515")){
	    	pstate="UF2";
	    }*/
	    
	    String regst_emp_id = "";	// EP연동 등록자 사번
	    String regst_emp_nm = "";	// EP연동 등록자 성명
	    String regst_emp_email = "";	// 최초등록자 이메일
	    String rtn_stat_cd = "";		// 결재마스터 상태코드(50:결재완료)
	    
	    String aprv_emp_id = "";		// 다음결재자 아이디
	    String next_emp_nm = "";		// 다음결재자 성명
	    String next_emp_email = "";		// 다음결재자 이메일
	    
		try{
			
			// 결재업무 일련번호가 있는지 확인한다 없으면 처리하지 않는다
			if(!ikey_datas.equals("") && !aprv_job_cl_cd.equals("")){
				
				//결재 업무 연결 키값이 있으면 결재 상태정보가 등록된 상태인지 확인한다(결재상태마스터)
				sql = "cmApmDAO.getAprvReq";
				tmp_map = new HashMap();
				tmp_map.put("aprv_job_cl_cd", aprv_job_cl_cd);
				tmp_map.put("ikey_datas", ikey_datas);
				tmp_aprvjob_map = cmDAO.getformData(tmp_map ,sql);
				
				//log.debug(" ===== InsertAprvReq tmp_aprvjob_map ===== "+tmp_aprvjob_map);
				
				// 결재 상태정보가 등록되지않았으면 기안등록이고
				if(tmp_aprvjob_map.get("ViewMap")==null){
					
					// 결재 상태 정보값이 있으면
					if(!aprv_stat_cd.equals("") && aprv_stat_cd.equals("20")){
						// 결재상태 마스터를 등록한다
						tmp_map = new HashMap();
						sql = "cmApmDAO.InsertAprvReq";
						//sequence 추출
						JIT9142_SQ = cmDAO.getSequence("JIT9142");
						tmp_map.put("ireal_stat_seqno", JIT9142_SQ+"");
						tmp_map.put("iaprv_job_cl_cd", aprv_job_cl_cd);
						tmp_map.put("aprv_reqpstate", aprv_reqpstate);
						tmp_map.put("aprv_param_nm", aprv_param_nm);
						
						tmp_map.put("iaprv_req_nm", iaprv_req_nm);	//결재요청제목
						
						tmp_map.put("ikey_datas", ikey_datas);
						tmp_map.put("iaprv_stat_cd", aprv_stat_cd);
						tmp_map.put("iappr_stat_desc", iappr_stat_desc);
						
						// 등록자 id 셋팅
						tmp_map.put("user_id", USER_ID);
						
						// 결재상태관리 마스터를 먼저저장한다
						insert(sql, tmp_map);
						
						
						// 실결재선 정보를 셋팅한다.
						// 최초 결재 요청일경우 현등록자가 요청자로 등록된다
						sql = "cmApmDAO.InsertAprvReqDetail";
						tmp_map = new HashMap();
						tmp_map.put("ireal_stat_seqno", JIT9142_SQ+"");
						
						tmp_map.put("iaprv_seqno", "1");
						tmp_map.put("aprv_emp_id", USER_ID);
						tmp_map.put("iaprv_req_nm", iaprv_req_nm);
						
						tmp_map.put("iaprv_stat_cd", "40");		//승인상태로 저장한다
						tmp_map.put("iaprv_req_ymd", "Y");
						tmp_map.put("iaprv_exe_ymd", "Y");
						tmp_map.put("user_id", USER_ID);
						tmp_map.put("aprv_org_nm", ORG_NM);		//기안자 부서는 세션값에서 저장
						insert(sql, tmp_map);
						
						// 실결재선으로 셋팅된 데이터를 셋팅한다
						jsonArray = JSONArray.fromObject(JSONDataListAprv.replaceAll("&amp;amp;quot;", "\"").replaceAll("&quot;", "\""));
						
						for(i=1;i<jsonArray.size();i++){
							sql = "cmApmDAO.InsertAprvReqDetail";
							tmp_map = new HashMap();
							jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
							iterator = jsonObjmap.entrySet().iterator();
							
							  while (iterator.hasNext()) {
								   Entry entry = (Entry)iterator.next();
								   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
							  }
							  
							  log.debug(" ===== InsertAprvReq tmp_map ===== "+tmp_map);
							  
							  tmp_map.put("ireal_stat_seqno", JIT9142_SQ+"");
							  tmp_map.put("iaprv_seqno", (i+1)+"");		// 요청자가 등록되므로 2번부터 순번이 등록된다
							  tmp_map.put("iaprv_stat_cd", "");			// 요청자가 아닌경우는 결재상태가 null로 저장된다
							  tmp_map.put("iaprv_exe_ymd", "");			// 결재처리일자는 요청자 외에는 모두 null로 저장한다
							  

							  //요청자 다음 결재자가 부재중일경우
							  if(i==1 && !tmp_map.get("absence").equals("")){
								  //log.debug(i+" ===== absence ===== "+(String)tmp_map.get("absence"));
								  tmp_map.put("iaprv_stat_cd", "40");	//승인상태로 저장
								  tmp_map.put("iaprv_exe_ymd", "Y");	//처리일자저장
								  j++;									//요청일자 저장
							  }
							  
							  //최초결재요청시 다음결재자 정보 저장
							  if(i==1){
								  next_emp_nm = (String)tmp_map.get("aprv_emp_nm");
								  next_emp_email = (String)tmp_map.get("next_emp_email");
							  }
							  
							  
							  if(i <= j){
								  tmp_map.put("iaprv_req_ymd", "Y"); //요청자가 아닌경우는 결재요청일자가 첫번째만 저장된다 
							  }else{
								  tmp_map.put("iaprv_req_ymd", "");
							  }
							  
							  tmp_map.put("user_id", USER_ID); 
							  insert(sql, tmp_map);	
							  
							  
							  //부재중이 아닌 첫번째 결재자에게 EP로 결재요청
/*							  if(tmp_map.get("absence").equals("") && aprvFlag==true){
								
								curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
								
								kind = StringUtil.rpad("S", 1+1,"\0");											//결재구분
								agree_empno = StringUtil.rpad((String)tmp_map.get("aprv_emp_id"), 8+1, "\0");	//결재자사번
								system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
								system_key = StringUtil.rpad(JIT9142_SQ+"", 15+1, "\0");						//결재문서고유번호
								doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입
								
								date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착,결재일시
								sender_name = StringUtil.rpad(USER_NM, 20+1, "\0");								//문서최초 작성자 이름
								sender_empno = StringUtil.rpad(USER_ID, 8+1, "\0");								//문서최초 작성자 사번
								
								url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
								title = StringUtil.rpad("["+ikey_datas+"]"+iaprv_req_nm, 255+1, "\0");			//문서제목
								url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
								status = StringUtil.rpad("0", 1+1, "\0");										//결재진행상태
								data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
								
								log.debug("Start == 결재data:== "+data);
								
								log.debug("==kind data:== "+kind.length());
								log.debug("==agree_empno data:== "+agree_empno.length());
								log.debug("==system_id data:== "+system_id.length());
								log.debug("==system_key data:== "+system_key.length());
								log.debug("==doc_type data:== "+doc_type.length());
								log.debug("==date data:== "+date.length());
								log.debug("==sender_name data:== "+sender_name.length());
								log.debug("==sender_empno data:== "+sender_empno.length());
								log.debug("==title data:== "+title.length());
								log.debug("==url data:== "+url.length());
								log.debug("==status data:== "+status.length());
								
								log.debug("==status data 가나다 euc-kr:== "+"가나다".getBytes("euc-kr").length);
								log.debug("==status data 가나다 utf-8:== "+"가나다".getBytes("utf-8").length);
								
								aprvFlag = false;
								
								//결재정보 EP연동
								aprv_socket(data);
								
							  }
*/
						
						} // for문종료
						
						result_map.put("AprvKey", JIT9142_SQ+"");
						result_map.put("suc_bid_apar_seq", i);		//결재선 최종순번
						
						}
					

					///////////////////////////////////////////////////////////////////////////////////////////////////////////	
					// 결재 상태정보가 등록되었으면 상태변경이다
					}else{
						
					
						tmp_ep = (Map)tmp_aprvjob_map.get("ViewMap");
						regst_emp_id = HtmlTag.StripStrInXss(HtmlTag.returnString((String)tmp_ep.get("regst_emp_id"),""));	//EP 최초작성자 사번
						regst_emp_nm = HtmlTag.StripStrInXss(HtmlTag.returnString((String)tmp_ep.get("regst_emp_nm"),""));	//EP 최초작성자 성명
						regst_emp_email = HtmlTag.StripStrInXss(HtmlTag.returnString((String)tmp_ep.get("regst_emp_email"),""));	//최초등록자 이메일

						
						if(!aprv_stat_cd.equals("") && !aprv_stat_cd.equals("20")){
							
							//결재 승인일경우
							if(aprv_stat_cd.equals("40")){
								if(!JSONDataListAprv.equals("")){
									jsonArray = JSONArray.fromObject(JSONDataListAprv.replaceAll("&amp;amp;quot;", "\"").replaceAll("&quot;", "\""));
								}
								log.debug("1111111111111111111111111111");
								// 만일 현 결재상태가 반송상태인경우 결재를 다시 진행시킨다
								if(cur_aprv_stat_cd.equals("30")){
									
								}else{
									
									//현결재자가 해당결재그룹의 마지막결재자인지 여부를 확인한다
									tmp_map = new HashMap();
									sql = "cmApmDAO.chkAprvReqGroupEnd";
									tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
									tmp_map.put("cur_aprv_seqno", cur_aprv_seqno);
									tmp_map.put("user_id", USER_ID);
									
									//해당결재선의 해당결재그룹의 마지막 결재자인경우이고 다음 결재자가 있는경우 승인상태로 변경한다
									tmp_aprvgroup_map = cmDAO.getformData (tmp_map ,sql);
									int next_yn = Integer.parseInt((String)((Map)tmp_aprvgroup_map.get("ViewMap")).get("next_yn"));
									
									//결재상태마스터
									if(((String)((Map)tmp_aprvgroup_map.get("ViewMap")).get("aprv_emp_id")).equals(USER_ID) && next_yn > 0 ){
										sql = "cmApmDAO.updateAprvReq";
										tmp_map = new HashMap();
										tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
										tmp_map.put("iaprv_stat_cd", "40");
										tmp_map.put("user_id", USER_ID);
										update(sql, tmp_map);
									}
									
									// 결재상태상세 수정처리한다
									tmp_map = new HashMap();
									sql = "cmApmDAO.updateAprvReqDetail";
									tmp_map.put("iaprv_stat_cd", aprv_stat_cd);	//승인상태로 저장한다
									tmp_map.put("iappr_stat_desc", iappr_stat_desc);
									tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
									tmp_map.put("cur_aprv_seqno", cur_aprv_seqno);
									tmp_map.put("user_id", USER_ID);
									update(sql, tmp_map);
									
									
									// 현결재자 EP에 결재완료처리
/*									curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
									
									kind = StringUtil.rpad("E", 1+1, "\0");											//결재구분
									agree_empno = StringUtil.rpad(USER_ID, 8+1, "\0");								//결재자사번
									system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
									system_key = StringUtil.rpad(cur_real_stat_seqno, 15+1, "\0");					//결재문서고유번호
									doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입(시스템이름)
									
									date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착//결재일시
									sender_name = StringUtil.rpad(regst_emp_nm, 20+1, "\0");						//문서최초 작성자 이름
									sender_empno = StringUtil.rpad(regst_emp_id, 8+1, "\0");						//문서최초 작성자 사번
									
									url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
									title = StringUtil.rpad(iaprv_req_nm, 255+1, "\0");								//문서제목
									url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
									
									status = StringUtil.rpad("0", 1+1, "\0");										//결재진행상태
									if(cur_aprv_lastyn.equals("Y")){	//최종결재자일 경우 결재종결
										status = StringUtil.rpad("1", 1+1, "\0");
									}
									
									data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
									log.debug("Start ==결재data:== "+data);
									aprvFlag = false;
									
									//결재정보 EP연동
									aprv_socket(data);
*/
									
									
								// 최종결재자 승인일경우 마스터도 결재완료로 수정해준다(추가결재라인이 없을경우만 결재완료처리된다)
								//log.debug("Start ============== 결재 cur_aprv_lastyn:== "+cur_aprv_lastyn);
								//log.debug("Start ============== 결재 jsonArray:== "+jsonArray);
								if(cur_aprv_lastyn.equals("Y")){
	
									sql = "cmApmDAO.updateAprvReq";
									tmp_map = new HashMap();
									tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
									tmp_map.put("iaprv_stat_cd", "50");
									tmp_map.put("user_id", USER_ID);
									update(sql, tmp_map);

									
								// 최종결재자가 아닐경우 다음 결재자의 결재 요청일도 수정해준다
								}else{
									
									tmp_map = new HashMap();
									sql = "cmApmDAO.updateNextAprvReqDetail";
									tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
									tmp_map.put("cur_aprv_seqno", Integer.parseInt(cur_aprv_seqno)+1);
									tmp_map.put("user_id", USER_ID);
									update(sql, tmp_map);
									
									
								//다음 결재자 부재중인지 체크
								i=Integer.parseInt(cur_aprv_seqno)+1;	//다음결재자 결재순번

								tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);			//결재상태 일련번호
								tmp_map.put("cur_aprv_seqno", i);	//결재 순번
								tmp_absence_map = cmDAO.getformData (tmp_map, "cmApmDAO.chkAprvNextAbsense");
								
								if(!((String)((Map)tmp_absence_map.get("ViewMap")).get("absence")).equals("")){	//부재중이면
									
									//상세 승인처리
									tmp_map.put("iaprv_stat_cd", "40");
									update("cmApmDAO.updateAprvReqDetail", tmp_map);
									
									//최종결재자일경우 마스터 업데이트
									if(next_yn == i){
										tmp_map.put("iaprv_stat_cd", "50");
										update("cmApmDAO.updateAprvReq", tmp_map);
										rtn_stat_cd = "50";
										
										//최종결재자일 경우 결재종결
/*										curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
										
										kind = StringUtil.rpad("E", 1+1, "\0");											//결재구분
										agree_empno = StringUtil.rpad(USER_ID, 8+1, "\0");								//결재자사번
										system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
										system_key = StringUtil.rpad(cur_real_stat_seqno, 15+1, "\0");					//결재문서고유번호
										doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입(시스템이름)
										
										date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착//결재일시
										sender_name = StringUtil.rpad(regst_emp_nm, 20+1, "\0");						//문서최초 작성자 이름
										sender_empno = StringUtil.rpad(regst_emp_id, 8+1, "\0");						//문서최초 작성자 사번
										url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
										title = StringUtil.rpad(iaprv_req_nm, 255+1, "\0");								//문서제목
										url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
										status = StringUtil.rpad("1", 1+1, "\0");										//결재진행상태

										data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
										log.debug("Start ==결재data:== "+data);
										aprvFlag = false;
										
										//결재정보 EP연동
										aprv_socket(data);
*/
										
										
									//최종결재자가 아닐경우 다음결재자 요청일 업데이트 및 EP에 결재요청
									}else{
										tmp_map = new HashMap();
										sql = "cmApmDAO.updateNextAprvReqDetail";
										tmp_map.put("cur_aprv_seqno", i+1);
										tmp_map.put("user_id", USER_ID);
										update(sql, tmp_map);
										
										//다음결재자 사번조회
										tmp_next_map = cmDAO.getformData (tmp_map, "cmApmDAO.chkAprvNextId");
										aprv_emp_id = (String)((Map) tmp_next_map.get("ViewMap")).get("aprv_emp_id");
										next_emp_nm = (String)((Map) tmp_next_map.get("ViewMap")).get("next_emp_nm");
										next_emp_email = (String)((Map) tmp_next_map.get("ViewMap")).get("next_emp_email");
										
										// 다음결재자 EP에 결재요청
/*										curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
										  
										kind = StringUtil.rpad("S", 1+1, "\0");											//결재구분
										agree_empno = StringUtil.rpad(((String)((Map)tmp_next_id.get("ViewMap")).get("aprv_emp_id")), 8+1, "\0");	//결재자사번
										system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
										system_key = StringUtil.rpad(cur_real_stat_seqno, 15+1, "\0");					//결재문서고유번호
										doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입(시스템이름)

										date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착//결재일시
										sender_name = StringUtil.rpad(regst_emp_nm, 20+1, "\0");						//문서최초 작성자 이름
										sender_empno = StringUtil.rpad(regst_emp_id, 8+1, "\0");						//문서최초 작성자 사번
										
										url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
										title = StringUtil.rpad(iaprv_req_nm, 255+1, "\0");								//문서제목
										url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
										status = StringUtil.rpad("0", 1+1, "\0");										//결재진행상태
										
										data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
										log.debug("Start ==결재data:== "+data);
										aprvFlag = false;
										
										//결재정보 EP연동
										aprv_socket(data);
*/
										
									}
									
								}else{	//부재중이 아닐경우
									
									
									//다음결재자 사번조회
									tmp_next_map = cmDAO.getformData (tmp_map, "cmApmDAO.chkAprvNextId");
									aprv_emp_id = (String)((Map) tmp_next_map.get("ViewMap")).get("aprv_emp_id");
									next_emp_nm = (String)((Map) tmp_next_map.get("ViewMap")).get("next_emp_nm");
									next_emp_email = (String)((Map) tmp_next_map.get("ViewMap")).get("next_emp_email");
									
									// 다음결재자 EP에 결재요청
/*									curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
									
									kind = StringUtil.rpad("S", 1+1, "\0");											//결재구분
									agree_empno = StringUtil.rpad(((String)((Map)tmp_absence_map.get("ViewMap")).get("aprv_emp_id")), 8+1, "\0");	//결재자사번
									system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
									system_key = StringUtil.rpad(cur_real_stat_seqno, 15+1, "\0");					//결재문서고유번호
									doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입(시스템이름)
									
									date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착//결재일시
									sender_name = StringUtil.rpad(regst_emp_nm, 20+1, "\0");						//문서최초 작성자 이름
									sender_empno = StringUtil.rpad(regst_emp_id, 8+1, "\0");						//문서최초 작성자 사번
									
									url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
									title = StringUtil.rpad(iaprv_req_nm, 255+1, "\0");		//문서제목
									url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
									status = StringUtil.rpad("0", 1+1, "\0");										//결재진행상태
									
									data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
									log.debug("Start ==결재data:== "+data);
									aprvFlag = false;
									
									//결재정보 EP연동
									aprv_socket(data);
*/
									}
								
								}
								
							}
							// 결재 반송일경우
							}else if(aprv_stat_cd.equals("30")){
							
								// 결재 상태 detail 정보를 수정처리한다
								tmp_map = new HashMap();
								sql = "cmApmDAO.updateAprvReqDetail";
								tmp_map.put("iaprv_stat_cd", aprv_stat_cd);//승인상태로 저장한다
								tmp_map.put("iappr_stat_desc", iappr_stat_desc);
								tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
								tmp_map.put("cur_aprv_seqno", cur_aprv_seqno);
								tmp_map.put("user_id", USER_ID);
								update(sql, tmp_map);
								
								// 해당 결재 순번 이후의 결재자를 삭제처리한다
								tmp_map = new HashMap();
								sql = "cmApmDAO.updateAR30AprvReqDetail";
								tmp_map.put("iaprv_stat_cd", aprv_stat_cd);//승인상태로 저장한다
								tmp_map.put("iappr_stat_desc", iappr_stat_desc);
								tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
								tmp_map.put("cur_aprv_seqno", cur_aprv_seqno);
								tmp_map.put("user_id", USER_ID);
								update(sql, tmp_map);							
								
								// 결재 상태 마스터를 반송상태로 바꾼다(반송시 DEL_YN=Y 로 바꾼다)
								sql = "cmApmDAO.updateAprvReq";
								tmp_map = new HashMap();
								tmp_map.put("cur_real_stat_seqno", cur_real_stat_seqno);
								tmp_map.put("iaprv_stat_cd", aprv_stat_cd);
								tmp_map.put("user_id", USER_ID);
								update(sql, tmp_map);
								
								
								//최초 결재요청자에게 메일발송하여 반송을 알린다

								// 현결재자 EP에 결재완료처리
/*								curtime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());			//현재날짜시간
								  
								kind = StringUtil.rpad("E", 1+1, "\0");											//결재구분
								agree_empno = StringUtil.rpad(USER_ID, 8+1, "\0");								//결재자사번
								system_id = StringUtil.rpad("10100", 5+1, "\0");								//연계시스템아이디
								system_key = StringUtil.rpad(cur_real_stat_seqno, 15+1, "\0");					//결재문서고유번호
								doc_type = StringUtil.rpad("cfms", 20+1, "\0");									//결재타입(시스템이름)
								
								date = StringUtil.rpad(curtime, 14+1, "\0");									//결재문서도착//결재일시
								sender_name = StringUtil.rpad(regst_emp_nm, 20+1, "\0");						//문서최초 작성자 이름
								sender_empno = StringUtil.rpad(regst_emp_id, 8+1, "\0");						//문서최초 작성자 사번
								
								url_temp = "https://home.kepco.co.kr/devcfms/ep-apm.jsp?pcode="+pcode+"&pstate="+pstate+"&ikey_datas="+max_notice_no;
								title = StringUtil.rpad(iaprv_req_nm, 255+1, "\0");		//문서제목
								url = StringUtil.rpad(url_temp, 255+1, "\0");									//문서보기주소
								status = StringUtil.rpad("9", 1+1, "\0");										//결재진행상태
								
								data = kind+agree_empno+system_id+system_key+doc_type+date+sender_name+sender_empno+title+url+status;
								log.debug("Start ==결재data:== "+data);
								aprvFlag = false;
								
								//결재정보 EP연동
								aprv_socket(data);
*/
								
							}
						}
					}
			}else{
				log.debug("========== InsertAprvReq ikey_datas or aprv_job_cl_cd 없음==========");
			}
			
			log.debug("========== InsertAprvReq 222222 next_emp_nm =========="+next_emp_nm);
			log.debug("========== InsertAprvReq 222222 next_emp_email=========="+next_emp_email);
			
			result_map.put("rtn_stat_cd", rtn_stat_cd);			//결재마스터 상태코드(50:결재완료)
			result_map.put("regst_emp_nm", regst_emp_nm);		//최초등록자 성명
			result_map.put("regst_emp_email", regst_emp_email);	//최초등록자 이메일
			
			result_map.put("next_emp_nm", next_emp_nm);			//다음결재자 성명
			result_map.put("next_emp_email", next_emp_email);	//다음결재자 이메일
			
			result_map.put("result", true);
			result_map.put("TRS_MSG","");
			
		}catch(NullPointerException q){
			log.error("InsertAprvReq NullPointerException:");
			result_map.put("TRS_MSG","결재처리중 에러가 발생했습니다.");	
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("InsertAprvReq ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","결재처리중 에러가 발생했습니다.");		
		}catch(Exception q){
			log.error("InsertAprvReq:");
			result_map.put("TRS_MSG","결재처리중 에러가 발생했습니다.");			
			throw q;
		}
		log.debug("==== InsertAprvReq END ===="+result_map);

		return result_map;	
	}
	
    
    //결재정보 EP연동 메소드
	/*public Map aprv_socket(String data)  throws ConnectException, IOException, Exception {
		log.debug("==== aprv_socket Start ====");
		
		Map result_map = new HashMap();
		
		Socket socket = null;
		OutputStream os = null;
		OutputStreamWriter osw = null;
		BufferedWriter bw = null;
		
		InputStream is = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		
		boolean result = false;
		
	
		try{
			
		
		//소켓생성
		socket = new Socket("168.78.206.156", 7781);
		log.debug("==== socket  ==== "+socket);
		
		result = socket.isConnected();
		if(result) log.debug("==== connected true ==== ");
		else log.debug("==== connected false ==== ");
		
		//스트림을 얻어옴
		os = socket.getOutputStream();
		osw = new OutputStreamWriter(os, "euc-kr");
		bw = new BufferedWriter(osw);

		is = socket.getInputStream();
		isr = new InputStreamReader(is, "euc-kr");
		br = new BufferedReader(isr);
		
		bw.write(data);
		bw.flush();
		
		String message;
		
		
		//결과를 읽음(서버로부터 온 메세지 수신)
		if(br != null){
			message = br.readLine().replace("\0", "");
		}

			log.debug("==== file.encoding==== "+System.getProperty("file.encoding"));
			
			result_map.put("aprvResult", true);

			
		}catch(ConnectException q){
			log.debug("ConnectException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
		}catch(IOException q){
			log.debug("IOException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
		}catch(Exception q){
			log.debug("Exception:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
		
		}finally{
			
			//소켓닫음
			try {
				if(bw != null){
					bw.close();
				}
				if(osw != null){
					osw.close();
				}
				if(os != null){
					os.close();
				}
				if(br != null){
					br.close();
				}
				if(isr != null){
					isr.close();
				}
				if(is != null){
					is.close();
				}
				if(socket!=null)socket.close();
				
				log.debug("==== socket.getLocalPort()  ==== "+socket.getLocalPort());
				log.debug("==== getPort()  ==== "+socket.getPort());
				log.debug("==== socket.getKeepAlive()  ==== "+socket.getKeepAlive());
				log.debug("==== socket.getInetAddress()  ==== "+socket.getInetAddress());
				
				
			} catch (IOException e) {
				log.debug("==== IOException occurred ====");
			}
			
		}

		log.debug("==== aprv_socket End ====");
		return result_map;
	}
	*/
    
	
}
