package com.ji.dao;

import com.ji.vo.PrivacyMngVO;

public interface PrivacyMngDao {
	//지원사업, 연구개발 상세
	public PrivacyMngVO selectBoardDetail(PrivacyMngVO privacyMngVO) throws Exception;
	//중소기업제품관관리 상세
	public PrivacyMngVO selectProductBoardDetail(PrivacyMngVO privacyMngVO) throws Exception;
}
