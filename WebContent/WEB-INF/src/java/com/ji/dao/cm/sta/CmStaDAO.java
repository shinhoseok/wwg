
package com.ji.dao.cm.sta;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import com.ji.cm.CM_Util;
import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**  
 * @Class Name : cmOamDAO03.java
 * @Description : cmOamDAO03 DAO Class 
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.11.08          최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2016.11.08
 * @version 1.0
 * @see
 * 
 */

@Repository("cmStaDAO") // StaDAO001.java
public class CmStaDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmStaDAO.class); //현재 클래스 이름을 Logger에 등록

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
	 * 권한관리 메소드
	 * @param Map
	 * @return Map
	 * @exception Exception
	 */
    // TODO : ctlCMS
    @SuppressWarnings("unchecked")
	public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		log.debug("==== ctlCMS Start ====");
		Map result_map = new HashMap();
		Map temp_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String pcode = HtmlTag.returnString((String)param.get("pcode"),"");
		
		try{
			
			if(pstate.equals("L")){
				if(pcode.equals("000363") || pcode.equals("000364")){
					result_map.put("privMenuList", cmDAO.getListSqlOnly (param, "JiCmSta.selectprivMenuList")); // 담당자목록
				}
				
			}else if(pstate.equals("X")){ //ajax data관련
				param.put("show_rows", "100");	//100개씩 조회	
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectVisitGraph"); //홈페이지 운영실적 > 홈페이지 방문
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectVisitGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);
				
			}else if(pstate.equals("X2")){ //ajax data관련
				
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectInfrGraph"); //홈페이지 운영실적 > 분석보고서 통계
			}else if(pstate.equals("X3")){ //ajax data관련
				
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectTenListGraph");	//홈페이지 운영실적 > 10대 통계
				
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectTenListGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);
				
			}else if(pstate.equals("X4")){ //ajax data관련
				
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectDownloadGraph"); //홈페이지 운영실적 > 다운로드
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectDownloadGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);
								
			}else if(pstate.equals("X5")){ //ajax data관련
				
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectReqDevGraph");	//데이터 제공 요청 > 요청분류별
				list("JiCmSta.selectReqDevGraph",param);
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectReqDevGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);
				//log.debug(":::::::::temp_map::::::::::::"+temp_map);
				//log.debug(":::::::::totalCnt::::::::::::"+totalCnt);
				//log.debug(":::::::::::result_map::::::::::"+result_map.get("cumulativeCount"));
				
			}else if(pstate.equals("X6")){ //ajax data관련
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectDataTypeGraph");	//데이터 제공 요청 > 데이터유형별
				list("JiCmSta.selectDataTypeGraph",param);
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectDataTypeGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);
				
			}else if(pstate.equals("X7")){ //ajax data관련
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiCmSta.selectDataKindGraph");	//데이터 제공 요청 > 데이터종류별
				list("JiCmSta.selectDataKindGraph",param);
				
				int totalCnt = 0;
				temp_map = (Map) select("JiCmSta.selectDataKindGraphCount", param);
				totalCnt = Integer.parseInt(temp_map.get("cnt").toString());
				result_map.put("cumulativeCount", totalCnt);
				result_map.put("param", param);

			}else if(pstate.equals("X8")) {
				param.put("show_rows", "100");
				result_map = cmDAO.selectListGrid(param,"JiCmSta.selectExcelList");			//홈페이지 방문 일별 엑셀 다운로드 추가
			}else if(pstate.equals("X9")) {

				result_map = cmDAO.selectListGrid(param,"JiCmSta.selectPrivateLogList");			//개인정보 접근이력
				
				
				
			}else if(pstate.equals("X10")) {
				
				result_map = cmDAO.selectListGrid(param,"JiCmSta.selectPrivateDownLogList");			//개인정보 다운로드 이력
				
			}else if(pstate.equals("X11")) {
				param.put("show_rows", "100");
				result_map = cmDAO.selectListGrid(param,"JiCmSta.selectDataKindGraphExcelList");			//데이터 제공 요청 -> 데이터종류별 일별 엑셀 다운로드 추가
				
			// 접속이력 6개월 이전 데이터 삭제
			}else if(pstate.equals("DELLOG")){
				result_map = deleteAccessLogJob(param);				
			}
			
		}catch(JSysException q){	
			log.error("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.error("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.error("SQLException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.error("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }
    
	/**
	* <p> ctlCms(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	// TODO : deleteAccessLogJob
	public Map deleteAccessLogJob(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.error("==== CmStaDAO deleteAccessLogJob : START ====");
		

		    
		Map result_map = new HashMap();
		Map query_param = new HashMap();
		Map rtn_map = new HashMap();
		List rtn_list = new ArrayList();
		
		int i = 0;
	    String sql_id="";
	    String initipns = "";
		try{
			sql_id="JiCmSta.deleteAccessLogJob";
			getSqlMapClientTemplate().queryForObject(sql_id, param);
				
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");				


		}catch(JSysException q){	
			log.error("deleteAccessLogJob throw JSysException >>>>> :  "+q);	
			throw q;		

		}catch(NullPointerException q){
			log.error("deleteAccessLogJob NullPointerException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.error("deleteAccessLogJob ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.error("deleteAccessLogJob JSysException Exception >>>>> :  "+q);	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.error("==== CmStaDAO deleteAccessLogJob : END ====");
		return result_map;	
	}    
}
