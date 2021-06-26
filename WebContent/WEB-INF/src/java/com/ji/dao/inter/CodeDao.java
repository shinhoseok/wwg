package com.ji.dao.inter;

import java.util.List;

import com.ji.vo.CodeVO;

public interface CodeDao {
	//공통코드 리스트
	public List<CodeVO> selectCodeList(String stdinfoDtlNm) throws Exception;
	//파일맥스시퀀스
	public Integer selectSequence(String tableName) throws Exception;
}
