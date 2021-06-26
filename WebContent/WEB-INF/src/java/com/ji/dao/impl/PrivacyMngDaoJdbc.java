package com.ji.dao.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.PrivacyMngDao;
import com.ji.vo.PrivacyMngVO;

@Repository("privacyMngDao")
public class PrivacyMngDaoJdbc implements PrivacyMngDao {
	protected Logger log = Logger.getLogger(PrivacyMngDaoJdbc.class);
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//지원사업, 연구개발 상세
	@Override
	public PrivacyMngVO selectBoardDetail(PrivacyMngVO privacyMngVO) throws Exception {
		log.debug(privacyMngVO.getDataSeq());
		return (PrivacyMngVO) sql.queryForObject("JiPrivacyMng.selectBoardDetail", privacyMngVO);
	}
	
	//중소기업제품관관리 상세
	@Override
	public PrivacyMngVO selectProductBoardDetail(PrivacyMngVO privacyMngVO) throws Exception {
		log.debug(privacyMngVO.getDataSeq());
		return (PrivacyMngVO) sql.queryForObject("JiPrivacyMng.selectProductBoardDetail", privacyMngVO);
	}

}
