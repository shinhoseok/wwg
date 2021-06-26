package com.ji.dao.cm.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.common.DateUtility;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.StringUtil;
import com.ji.dao.cm.CMDAO;
import com.ji.util.CmsDsDao;
import com.ji.vo.BoardVO;
import com.ji.vo.FileVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("commonBoardDAO")
public class CommonBoardDAO extends CmsDsDao {
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	@Resource(name="cmDAO")
	private CMDAO cmDAO;
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map ctlCMS(Map param) throws Exception {
		log.debug("==== CommonBoardDAO ctlCMS Start ====");
		Map rsltMap		= new HashMap();
		Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String scode = HtmlTag.returnString((String)param.get("scode"),"S01");
		Map MENUCFG = (Map) param.get("MENUCFG");
		String menuCd = (String) MENUCFG.get("menuCd");
		param.put("menuCd", menuCd);
//		String boardCd = (String) MENUCFG.get("boardCd");
		/*
		 * 000010      	: 공지형
		 * 000011      	: 선택형
		 * 000012		: 답변형
		 * 000052		: FAQ형
		 * 000223		: 중소기업지원
		 * 000417		: 비로그인형
		 */
		String boardTy = (String) MENUCFG.get("boardTy");
		log.debug("boardTy >>>>>>"+boardTy);
		try {
			log.debug("CommonBoardDAO pstate==>"+pstate);
			// 관리자 접근일경우 관리자 세션을 확인한다
			if(scode.equals(propertiesService.getString("SYS_ADMIN_CD", ""))){
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			}else {
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
			}
			/*
			 * L      	:  인트로(리스트)
			 * L2      	:  접수확인 화면
			 * CF		: 등록화면
			 * C		: 등록
			 * UF		: 수정화면
			 * UFR		: 답글수정화면
			 * U		: 수정
			 * R		: 상세화면
			 * D		: 삭제
			 * UCL		: 요청취소
			 * **********************************************
			 * U2		: 관리자 접수저장
			 */
			// TODO : 일반게시판 목록
			if(pstate.equals("L")){
				int pageIndex = 0;
				if(StringUtil.isEmpty((String) param.get("pageIndex"))) {
					pageIndex = 1;
				} else {
					pageIndex = Integer.parseInt((String) param.get("pageIndex")) ;
				}
				param.put("pageIndex", pageIndex);
				PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo(pageIndex);
				param.put("pageSize", propertiesService.getInt("PAGE_SIZE"));
				paginationInfo.setPageSize(propertiesService.getInt("PAGE_SIZE")); //페이지 사이즈
				paginationInfo.setRecordCountPerPage(propertiesService.getInt("PAGE_UNIT")); //페이지 갯수
				param.put("firstIndex", paginationInfo.getFirstRecordIndex()+1);
				param.put("lastIndex", paginationInfo.getLastRecordIndex());
				
				List<BoardVO> selectList = null;
				
				int selectListCnt = (Integer) sql.queryForObject("JiCmsBoard.selectBoardListCnt", param);
				paginationInfo.setTotalRecordCount(selectListCnt);
				
				if(selectListCnt > 0) {
					selectList = sql.queryForList("JiCmsBoard.selectBoardList", param);
				}
				
				rsltMap.put("selectList", selectList);
				rsltMap.put("selectListCnt", selectListCnt);
				
			} else if(pstate.equals("CF")) { //등록화면
				rsltMap.put("today", DateUtility.getCurrentDateTime("yyyy-MM-dd"));
				
			} else if(pstate.equals("R")) { //상세화면
				
				BoardVO resultVO = (BoardVO) sql.queryForObject("JiCmsBoard.selectBoardDetail", param); //상세쿼리
				if(resultVO != null) {
					String dataDesc = resultVO.getDataDesc();
					if(!StringUtil.isEmpty(dataDesc)) {
						dataDesc = HtmlTag.StripStrOutXss(dataDesc);
					}
					String dataSpaCol0 = resultVO.getDataSpaCol0();
					String dataSpaCol1 = resultVO.getDataSpaCol1();
					String dataSpaCol2 = resultVO.getDataSpaCol2();
					if(!StringUtil.isEmpty(dataDesc)) { //화면에서 띄어쓰기 표시
						dataDesc = dataDesc.replaceAll("(\r\n|\n)", "<br />");
						resultVO.setDataDesc(dataDesc);
					}
					if(!StringUtil.isEmpty(dataSpaCol0)) { //화면에서 띄어쓰기 표시
						dataSpaCol0 = dataSpaCol0.replaceAll("(\r\n|\n)", "<br />");
						resultVO.setDataSpaCol0(dataSpaCol0);
					}
					if(!StringUtil.isEmpty(dataSpaCol1)) { //화면에서 띄어쓰기 표시
						dataSpaCol1 = dataSpaCol1.replaceAll("(\r\n|\n)", "<br />");
						resultVO.setDataSpaCol1(dataSpaCol1);
					}
					if(!StringUtil.isEmpty(dataSpaCol2)) { //화면에서 띄어쓰기 표시
						dataSpaCol2 = dataSpaCol2.replaceAll("(\r\n|\n)", "<br />");
						resultVO.setDataSpaCol2(dataSpaCol2);
					}
				}
				
				//파일리스트
				FileVO paramVO = new FileVO();
				paramVO.setMenuDataKeyDatas(String.valueOf(param.get("dataSeqno")));
				paramVO.setMenuCd((String) param.get("menuCd"));
				paramVO.setFileGroup("1");
				List<FileVO> fileList = sql.queryForList("JiFile.selectFileList", paramVO);
				
				rsltMap.put("resultVO", resultVO);
				rsltMap.put("fileList", fileList);
				
			} else if(pstate.equals("D")) { //삭제
				FileVO fileVO1 = new FileVO();
				fileVO1.setMenuCd(String.valueOf(param.get("pcode")));
				fileVO1.setMenuDataKeyDatas(String.valueOf(param.get("dataSeqno")));
				if(SITE_SESSION != null){
					param.put("delId", (String) SITE_SESSION.get("USER_ID"));
					fileVO1.setDelId((String) SITE_SESSION.get("USER_ID"));
				}
				sql.update("JiCmsBoard.deleteBoardProc", param);
				//파일상세 삭제
				if(!StringUtil.isEmpty(fileVO1.getMenuDataKeyDatas())) {
					sql.update("JiFile.deleteAllFileProc", fileVO1);
				}
				param.put("pstate", "L");
				
			} else if(pstate.equals("UF")) { //수정화면
				BoardVO resultVO = (BoardVO) sql.queryForObject("JiCmsBoard.selectBoardDetail", param); //상세쿼리
				if(resultVO != null) {
					String dataDesc = resultVO.getDataDesc();
					if(!StringUtil.isEmpty(dataDesc)) {
						dataDesc = HtmlTag.StripStrOutXss(dataDesc);
						resultVO.setDataDesc(dataDesc);
					}
				}
				//파일리스트
				FileVO paramVO = new FileVO();
				paramVO.setMenuDataKeyDatas((String) param.get("dataSeqno"));
				paramVO.setMenuCd((String) param.get("menuCd"));
				paramVO.setFileGroup("1");
				List<FileVO> fileList = sql.queryForList("JiFile.selectFileList", paramVO);
				
				rsltMap.put("resultVO", resultVO);
				rsltMap.put("fileList", fileList);
			}
			rsltMap.put("param", param);
		}catch(JSysException q){
			log.debug("CommonBoardDAO ctlCMS throw JSysException >>>>> :  " + q);	
			rsltMap.put("result",false);
			throw q;		
		}catch(NullPointerException q){
			log.debug("CommonBoardDAO ctlCMS NullPointerException:" + q);
			rsltMap.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("CommonBoardDAO ctlCMS ArrayIndexOutOfBoundsException:" + q);
			rsltMap.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(Exception q){
			log.debug("CommonBoardDAO ctlCMS Exception >>>>> : " + q);	
			rsltMap.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}
		log.debug("==== CommonBoardDAO ctlCMS End ====");
		return rsltMap;
	}
}
