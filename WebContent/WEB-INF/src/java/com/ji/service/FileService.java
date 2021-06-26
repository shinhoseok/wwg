package com.ji.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ji.vo.FileVO;

public interface FileService {
	
	public List<FileVO> commonFileUpload(List<MultipartFile> multiFileList, FileVO paramVO) throws Exception;
	//파일 상세보기
	public FileVO selectFileDetail(FileVO fileVO) throws Exception;
	//파일 상세보기2
	public FileVO selectFileDetail2(FileVO fileVO) throws Exception;
}
