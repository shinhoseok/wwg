package com.ji.dao.cm.contents;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.util.CmsDsDao;
import com.ji.vo.MenuVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("contentsMngDAO")
public class ContentsMngDAO extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
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
				
				PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo(pageIndex);
				paginationInfo.setRecordCountPerPage(propertiesService.getInt("PAGE_UNIT")); //페이지 갯수
				paginationInfo.setPageSize(propertiesService.getInt("PAGE_SIZE")); //페이지 사이즈
				
				MenuVO menuVO = new MenuVO();
				menuVO.setLinkTy("000006"); //컨텐츠만
				menuVO.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);
				menuVO.setLastIndex(paginationInfo.getLastRecordIndex());
				if(null != param.get("searchValue")) {
					menuVO.setSearchValue(String.valueOf(param.get("searchValue")));
				}
				
				List<MenuVO> selectList = null;
				int selectListCnt = (Integer) sql.queryForObject("JiCmMnm.selectMenuKindListCnt", menuVO);
				paginationInfo.setTotalRecordCount(selectListCnt);
				if(selectListCnt > 0) {
					selectList = sql.queryForList("JiCmMnm.selectMenuKindList", menuVO);
				}
				
				result_map.put("selectListCnt", selectListCnt);
				result_map.put("selectList", selectList);
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
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
	}
}
