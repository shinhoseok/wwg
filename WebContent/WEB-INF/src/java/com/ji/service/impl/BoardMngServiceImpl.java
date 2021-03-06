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
	
	//????????? ??????
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
			
			
			//???????????? ??????
			if(boardVO.getDelFileSeqList() != null) {
				maxOrder = fileDao.selectFileMaxOrderNum(fileVO);
				for(String fileSeqNo : boardVO.getDelFileSeqList()) {
					fileVO.setFileSeqNo(Integer.parseInt(fileSeqNo));
					fileVO.setDelId(boardVO.getModId());
					fileDao.deleteFileProc(fileVO);
				}
			}
			boardMngDao.updateBoardProc(boardVO);
			
			//???????????? ?????????
			int idx = 0;
			for(FileVO fileVO1 : fileList) {
				//??????????????? 0???????????? ?????? ????????? order??? ?????????????????? 
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
	
	//????????? ?????? ?????????
	public List<BoardVO> selectBoardReviewList(BoardVO boardVO) throws Exception {
		List<BoardVO> resultList = boardMngDao.selectBoardReviewList(boardVO);
		for(int i=0; i<resultList.size(); i++) {
			if(!StringUtil.isEmpty(resultList.get(i).getDataDesc())) { //???????????? ???????????? ??????
				resultList.get(i).setDataSpaCol9(resultList.get(i).getDataDesc()); //??????9?????? ?????? ??????
				String dataDesc = resultList.get(i).getDataDesc().replaceAll("(\r\n|\n)", "<br />");
				dataDesc = dataDesc.replaceAll("&amp;lt;", "<");
				dataDesc = dataDesc.replaceAll("&amp;gt;", ">");
				resultList.get(i).setDataDesc(dataDesc);
			}
			if(boardVO.getMenuCd().equals("000091")) { //????????????????????? ????????? ????????? ??????????????? ?????????
				//???????????????
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
	
	//????????????
	public void insertBoardReviewProc(BoardVO boardVO) throws Exception {
		boardVO.setDataSeqno(cmDAO.getSequence("JIT9150"));
		boardVO.setDataDepth(2);
		boardVO.setRegDt(DateUtility.getCurrentDateTime("yyyy-MM-dd"));
		boardMngDao.insertBoardProc(boardVO);
	}
	
	//?????? ??????
	public void updateBoardReviewProc(BoardVO boardVO) throws Exception {
		boardMngDao.updateBoardReviewProc(boardVO);
	}
	
	//?????? ??????
	public void deleteBoardReviewProc(BoardVO boardVO) throws Exception {
		boardMngDao.deleteBoardReviewProc(boardVO);
	}
}
