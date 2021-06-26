package com.ji.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ji.common.DateUtility;
import com.ji.common.JSysException;
import com.ji.common.StringUtil;
import com.ji.dao.cm.CMDAO;
import com.ji.dao.inter.BoardMngDao;
import com.ji.dao.inter.FileDao;
import com.ji.service.BoardMngService;
import com.ji.vo.BoardVO;
import com.ji.vo.FileVO;

@Service("boardMngService")
public class BoardMngServiceImpl implements BoardMngService {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="boardMngDao")
	private BoardMngDao boardMngDao;
	
	@Resource(name="fileDao")
	private FileDao fileDao;
	
	@Resource(name="txManagerds")
	private DataSourceTransactionManager txManager;
	
	@Resource(name="cmDAO")
	private CMDAO cmDAO;
	
	public void insertBoardProc(BoardVO boardVO ,List<FileVO> fileList) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		try {
			boardVO.setDataSeqno(cmDAO.getSequence("JIT9150"));
			boardVO.setDataOriginNo(String.valueOf(boardVO.getDataSeqno()));
			boardVO.setDataDepth(1);
			boardMngDao.insertBoardProc(boardVO);
			
			if(fileList.size() > 0) {
				for(FileVO fileVO : fileList) {
					fileVO.setMenuDataKeyDatas(String.valueOf(boardVO.getDataSeqno()));
					fileVO.setFileSeqNo(cmDAO.getSequence("JIT9151"));
					fileVO.setMenuDataTitle(boardVO.getDataTitle());
					fileDao.insertFileProc(fileVO);
				}
			}
		}catch(JSysException e){
			txManager.rollback(status);
			log.error("insertBoardFileProc throw Exception >>>>> :  "+e);	
			throw e;		
		}catch(NullPointerException e){
			txManager.rollback(status);
			log.error("insertBoardFileProc throw Exception >>>>> :  "+e);
			throw e;
		} catch (Exception e) {
			txManager.rollback(status);
			log.error("insertBoardFileProc throw Exception >>>>> :  "+e);
			throw e;
 		} finally {
			txManager.commit(status);
		}
	}
	
	//게시판 수정
	public void updateBoardProc(BoardVO boardVO, List<FileVO> fileList) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		try {
			int maxOrder = 0;
			FileVO fileVO = new FileVO();
			fileVO.setMenuDataKeyDatas(String.valueOf(boardVO.getDataSeqno()));
			fileVO.setMenuCd(boardVO.getMenuCd());
			fileVO.setFileGroup("1");
			
			
			//기존파일 삭제
			if(boardVO.getDelFileSeqList() != null) {
				maxOrder = fileDao.selectFileMaxOrderNum(fileVO);
				for(String fileSeqNo : boardVO.getDelFileSeqList()) {
					fileVO.setFileSeqNo(Integer.parseInt(fileSeqNo));
					fileVO.setDelId(boardVO.getModId());
					fileDao.deleteFileProc(fileVO);
				}
			}
			boardMngDao.updateBoardProc(boardVO);
			
			//공통파일 인서트
			int idx = 0;
			for(FileVO fileVO1 : fileList) {
				//파일등록시 0번부터가 아닌 마지막 order의 다음숫자부터 
				idx = maxOrder+idx;
				if(maxOrder > 0) {
					fileVO1.setFileOrderNo(idx);	
				}
				fileVO1.setFileSeqNo(cmDAO.getSequence("JIT9151"));
				fileVO1.setMenuDataKeyDatas(String.valueOf(boardVO.getDataSeqno()));
				fileVO1.setMenuDataTitle(boardVO.getDataTitle());
				fileVO1.setRegId(boardVO.getModId());
				fileDao.insertFileProc(fileVO1);
				idx++;
			}
			
		}catch(JSysException e){
			txManager.rollback(status);
			log.error("updateBoardFileProc throw Exception >>>>> :  "+e);	
			throw e;		
		}catch(NullPointerException e){
			txManager.rollback(status);
			log.error("updateBoardFileProc throw Exception >>>>> :  "+e);
			throw e;
		} catch (Exception e) {
			txManager.rollback(status);
			log.error("updateBoardFileProc throw Exception >>>>> :  "+e);
			throw e;
 		} finally {
			txManager.commit(status);
		}
	}
	
	//게시판 댓글 리스트
	public List<BoardVO> selectBoardReviewList(BoardVO boardVO) throws Exception {
		List<BoardVO> resultList = boardMngDao.selectBoardReviewList(boardVO);
		for(int i=0; i<resultList.size(); i++) {
			if(!StringUtil.isEmpty(resultList.get(i).getDataDesc())) { //화면에서 띄어쓰기 표시
				resultList.get(i).setDataSpaCol9(resultList.get(i).getDataDesc()); //예비9번에 원글 저장
				String dataDesc = resultList.get(i).getDataDesc().replaceAll("(\r\n|\n)", "<br />");
				dataDesc = dataDesc.replaceAll("&amp;lt;", "<");
				dataDesc = dataDesc.replaceAll("&amp;gt;", ">");
				resultList.get(i).setDataDesc(dataDesc);
			}
			if(boardVO.getMenuCd().equals("000091")) { //지원사업공고에 각각의 개인이 등록한파일 리스트
				//파일리스트
				FileVO fileVO = new FileVO();
				fileVO.setMenuDataKeyDatas(String.valueOf(resultList.get(i).getDataSeqno()));
				fileVO.setMenuCd(resultList.get(i).getMenuCd());
				fileVO.setFileGroup("1");
				List<FileVO> fileList = fileDao.selectFileList(fileVO);
				resultList.get(i).setFileList(fileList);
			}
		}
		return resultList;
	}
	
	//댓글등록
	public void insertBoardReviewProc(BoardVO boardVO) throws Exception {
		boardVO.setDataSeqno(cmDAO.getSequence("JIT9150"));
		boardVO.setDataDepth(2);
		boardVO.setRegDt(DateUtility.getCurrentDateTime("yyyy-MM-dd"));
		boardMngDao.insertBoardProc(boardVO);
	}
	
	//댓글 수정
	public void updateBoardReviewProc(BoardVO boardVO) throws Exception {
		boardMngDao.updateBoardReviewProc(boardVO);
	}
	
	//댓글 삭제
	public void deleteBoardReviewProc(BoardVO boardVO) throws Exception {
		boardMngDao.deleteBoardReviewProc(boardVO);
	}
}
