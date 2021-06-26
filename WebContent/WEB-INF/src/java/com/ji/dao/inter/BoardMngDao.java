package com.ji.dao.inter;

import java.util.List;

import com.ji.vo.BoardVO;

public interface BoardMngDao {
	//게시판 등록
	public void insertBoardProc(BoardVO boardVO) throws Exception;
	//게시판 수정
	public void updateBoardProc(BoardVO boardVO) throws Exception;
	//게시판 댓글 리스트
	public List<BoardVO> selectBoardReviewList(BoardVO boardVO) throws Exception;
	//게시판 수정
	public void updateBoardReviewProc(BoardVO boardVO) throws Exception;
	//게시판 삭제
	public void deleteBoardReviewProc(BoardVO boardVO) throws Exception;
}
