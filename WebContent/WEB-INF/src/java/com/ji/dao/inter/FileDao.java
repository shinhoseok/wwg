package com.ji.dao.inter;

import java.util.List;

import com.ji.vo.FileVO;

public interface FileDao {
	//파일상세
	public FileVO selectFileDetail(FileVO fileVO) throws Exception;
	//파일상세
	public FileVO selectFileDetail2(FileVO fileVO) throws Exception;
	//파일 등록
	public void insertFileProc(FileVO fileVO) throws Exception;
	//파일맥스시퀀스
	public Integer selectFileMaxOrderNum(FileVO fileVO) throws Exception;
	//파일삭제
	public void deleteFileProc(FileVO fileVO) throws Exception;
	//파일리스트
	public List<FileVO> selectFileList(FileVO fileVO) throws Exception;
}
