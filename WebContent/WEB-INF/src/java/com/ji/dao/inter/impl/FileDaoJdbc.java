package com.ji.dao.inter.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.inter.FileDao;
import com.ji.vo.FileVO;

@Repository("fileDao")
public class FileDaoJdbc implements FileDao {
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//파일상세
	public FileVO selectFileDetail(FileVO fileVO) throws Exception {
		return (FileVO) sql.queryForObject("JiFile.selectFileDetail", fileVO);
	}
	
	//파일상세
	public FileVO selectFileDetail2(FileVO fileVO) throws Exception {
		return (FileVO) sql.queryForObject("JiFile.selectFileDetail2", fileVO);
	}
	//파일 등록
	public void insertFileProc(FileVO fileVO) throws Exception {
		sql.insert("JiFile.insertFileProc", fileVO);
	}
	//파일맥스시퀀스
	public Integer selectFileMaxOrderNum(FileVO fileVO) throws Exception {
		return (Integer) sql.queryForObject("JiFile.selectFileMaxOrderNum", fileVO);
	}
	
	//파일삭제
	public void deleteFileProc(FileVO fileVO) throws Exception {
		sql.delete("JiFile.deleteFileProc", fileVO);
	}
	
	//파일리스트
	@SuppressWarnings("unchecked")
	public List<FileVO> selectFileList(FileVO fileVO) throws Exception {
		return sql.queryForList("JiFile.selectFileList", fileVO);
	}
}
