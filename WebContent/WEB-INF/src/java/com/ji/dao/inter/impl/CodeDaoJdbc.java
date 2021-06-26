package com.ji.dao.inter.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.inter.CodeDao;
import com.ji.vo.CodeVO;

@Repository("codeDao")
public class CodeDaoJdbc implements CodeDao {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//공통코드
	@SuppressWarnings("unchecked")
	public List<CodeVO> selectCodeList(String stdinfoDtlNm) throws Exception {
		return sql.queryForList("JiCode.selectCodeList", stdinfoDtlNm);
	}
	
	//파일맥스시퀀스
	public Integer selectSequence(String tableName) throws Exception {
		return (Integer) sql.queryForObject("cmDAO.selectSequence", tableName);
	}
}
