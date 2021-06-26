package com.ji.dao.inter.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.inter.BoardMngDao;
import com.ji.vo.BoardVO;

@Repository("boardMngDao")
public class BoardMngDaoJdbc implements BoardMngDao {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//게시판 등록
	public void insertBoardProc(BoardVO boardVO) throws Exception {
		sql.insert("JiCmsBoard.insertBoardProc", boardVO);
	}
	
	//게시판 수정
	public void updateBoardProc(BoardVO boardVO) throws Exception {
		sql.update("JiCmsBoard.updateBoardProc", boardVO);
	}
	
	//게시판 댓글 리스트
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectBoardReviewList(BoardVO boardVO) throws Exception {
		return sql.queryForList("JiCmsBoard.selectBoardReviewList", boardVO);
	}
	
	//게시판 수정
	public void updateBoardReviewProc(BoardVO boardVO) throws Exception {
		sql.update("JiCmsBoard.updateBoardReviewProc", boardVO);
	}

	//게시판 삭제
	public void deleteBoardReviewProc(BoardVO boardVO) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("delId", boardVO.getDelId());
		param.put("dataSeqno", boardVO.getDataSeqno());
		sql.update("JiCmsBoard.deleteBoardProc", param);
	}
}
