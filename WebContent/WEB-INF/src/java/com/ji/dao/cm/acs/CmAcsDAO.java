
package com.ji.dao.cm.acs;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.common.HtmlTag;
import com.ji.common.JasyptUtil;
import com.ji.common.JSysException;
import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.vo.ReservationVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**  
 * @Class Name : CmAcsDAO.java
 * @Description : CmAcsDAO DAO Class
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
 */

@Repository("cmAcsDAO")
public class CmAcsDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmAcsDAO.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;    
    
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;

    /**
	 * 컨트롤 메소드
	 * @param Map
	 * @return 
	 * @exception Exception
	 */
    //	TODO ctlCMS
    @SuppressWarnings("unchecked")
	public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		
		log.debug("==== ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
		try{
			
			if(SITE_SESSION==null){
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
			}
			
			if(pstate.equals("L")){
				int pageIndex = 0;
				if(null == param.get("pageIndex")) {
					pageIndex = 1;
				} else {
					pageIndex = Integer.parseInt((String) param.get("pageIndex")) ;
				}
				param.put("pageIndex", pageIndex);
				param.put("pageSize", propertiesService.getInt("PAGE_SIZE"));
				
				log.info("all param value ::::: " + param);
				log.info("param value ::::: pageIndex :: " + param.get("pageIndex"));
				log.info("param value ::::: pageSize :: " + param.get("pageSize"));
				
				PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo(pageIndex);
				paginationInfo.setRecordCountPerPage(propertiesService.getInt("PAGE_UNIT")); //페이지 갯수
				paginationInfo.setPageSize(propertiesService.getInt("PAGE_SIZE")); //페이지 사이즈
				
				param.put("firstIndex", paginationInfo.getFirstRecordIndex()+1);
				param.put("lastIndex", paginationInfo.getLastRecordIndex());
				List<ReservationVO> selectList = null;
				List<Map<String, String>> deptList = new ArrayList();
				
				int selectListCnt = (Integer) sql.queryForObject("JiCmAcs.selectListCnt", param);
				
				paginationInfo.setTotalRecordCount(selectListCnt);
				
				if(selectListCnt > 0) {
					selectList = cmDAO.getListSqlOnly(param, "JiCmAcs.getAc_Ip");
				}
				double lastPageDouble = selectListCnt / (double) paginationInfo.getRecordCountPerPage();
				int lastPageNum = 1;
				if(lastPageDouble > 1) {
					lastPageNum = (int) Math.ceil(lastPageDouble);
				} else {
					if((int) lastPageDouble > 0) {
						lastPageNum = (int) lastPageDouble;
					}
				}
				
				result_map.put("chargerList", cmDAO.getListSqlOnly (param, "JiCmAcs.selectChargerList")); // 담당자목록
				
				result_map.put("lastPageNum", lastPageNum);
				result_map.put("selectList", selectList);
				result_map.put("selectListCnt", selectListCnt);
				
			// 등록
			}else if(pstate.equals("C")){
				result_map = insertAC(param);
				
			// 수정
			}else if(pstate.equals("U")){
				result_map = updateAC(param);
			// 삭제
			}else if(pstate.equals("D")){
				result_map = deleteAC(param);
			}

			result_map.put("param", param);
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
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }

    
	/**
	* <p> ctlAC(메인Dao컨트롤클래스)에서 접근아이피관련 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  접근아이피관련 조회결과값을 리턴한다
	* @throws  
	*/
    //	TODO getListAC
	public Map getListAC (Map param) throws Exception {
		
		log.debug("==== getListAC Start ====");
		Map result_map = new HashMap();
		String pcode = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("pcode"),""));//메뉴코드
		log.debug("==== getListAC 1111111111 ====");
		String sql = "JiCmAcs.getAc_Ip";	
		List res_list = new ArrayList();
		Map query_param = new HashMap();
		String [] dec_col = {"acIp"};
		try{
			log.debug("==== getListAC 222222222 ====");
			query_param.put("pcode", pcode);
			res_list = list(sql, query_param);
			
			log.debug("==== getListAC 3333333333 ====");
			//result_map.put("ListAC", cmsService.getGridListScrollDec(res_list, dec_col));
			result_map.put("ListAC", cmsService.getGridListScroll(res_list));
			log.debug("==== getListAC 44444444444 ====");

			result_map.put("chargerList", cmDAO.getListSqlOnly (param, "JiCmAcs.selectChargerList")); // 담당자목록			
			
		
		}finally{
			result_map.put("TRS_MSG","");
		}
    	
    	log.debug("==== getListAC End ====");
		return result_map;
	}	
	
	
	/**
	* <p> ctlAC(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	//	TODO insertAC 
	public Map insertAC(Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		
		log.debug("==== insertAC : START ====");
		Map result_map = new HashMap();
		

		//log.debug(message)

		String AC_IP			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("AC_IP"),""));
		String USE_YN			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("USE_YN"),"N"));
		
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		
		long max_seq = 0;
		int i = 0;
		
		

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JIT9501","IDX","");
		
		String sql = "JiCmAcs.insertAc_Ip";	
		try{

			
			param.put("max_seq", max_seq);
			//param.put("AC_IP", JasyptUtil.JasyptEncode(AC_IP));
			param.put("AC_IP", AC_IP);
			param.put("USER_ID", USER_ID);
			param.put("AC_ID", USER_ID);
			param.put("USE_YN", USE_YN);
			param.put("USE_ID", HtmlTag.returnString((String)param.get("USE_ID"),""));
			
			
			insert(sql, param);
			
			
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
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertAC : END ====");
		return result_map;	
	}
	

	/**
	* <p> ctlAC(메인Dao컨트롤클래스)에서 해당데이터를 수정하는 메소드</p>
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
	//	TODO updateAC 
	public Map updateAC(Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		
		log.debug("==== updateAC : START ====");
		Map result_map = new HashMap();
		//log.debug(message)
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		log.debug("==== updateAC : sidx ====::"+sidx);
		String AC_IP			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("AC_IP"+sidx),""));
		log.debug("==== updateAC : AC_IP ====::"+AC_IP);
		String USE_YN			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("USE_YN"+sidx),"N"));
		String AC_BIGO			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("AC_BIGO"+sidx),""));
		String USE_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("USE_ID"+sidx),""));
		
		
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		
		
	    
	    String sql = "JiCmAcs.updateAc_Ip";	
		try{
			
			//param.put("AC_IP", JasyptUtil.JasyptEncode(AC_IP));
			param.put("AC_IP", AC_IP);
			param.put("USE_YN", USE_YN);
			param.put("AC_BIGO", AC_BIGO);
			param.put("USER_ID", USER_ID);
			param.put("USE_ID", USE_ID);
			
			update(sql, param);
			
			
			result_map.put("TRS_MSG","수정되었습니다");
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
		log.debug("==== updateAC : END ====");
		return result_map;	
	}	
	
	
	
	/**
	* <p> ctlAC(메인Dao컨트롤클래스)에서 해당데이터를 삭제하는 메소드</p>
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
	//	TODO deleteAC
	public Map deleteAC(Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		 
		log.debug("==== deleteAC : START ====");
		Map result_map = new HashMap();
	
	    String sql = "JiCmAcs.deleteAc_Ip";	
	
		try{

			delete(sql, param);				

			result_map.put("TRS_MSG","삭제되었습니다");
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
		log.debug("==== deleteAC : END ====");
		return result_map;	
	}    
 

}
