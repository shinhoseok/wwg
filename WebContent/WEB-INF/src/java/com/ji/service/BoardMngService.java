package com.ji.service;

import java.util.List;

import com.ji.vo.BoardVO;
import com.ji.vo.FileVO;

public interface BoardMngService {
	//공통게시판 등록
	public void insertBoardProc(BoardVO boardVO, List<FileVO> fileList) throws Exception;
	//게시판 수정
	public void updateBoardProc(BoardVO boardVO, List<FileVO> fileList) throws Exception;
	//게시판 댓글 리스트
	public List<BoardVO> selectBoardReviewList(BoardVO boardVO) throws Exception;
	//댓글등록
	public void insertBoardReviewProc(BoardVO boardVO) throws Exception;
	//댓글 수정
	public void updateBoardReviewProc(BoardVO boardVO) throws Exception;
	//댓글 삭제
	public void deleteBoardReviewProc(BoardVO boardVO) throws Exception;
}
