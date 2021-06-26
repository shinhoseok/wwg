package com.ji.vo;

public class PrivacyMngVO {
	//게시글 제목
	private String dataTitle;
	//게시글 시퀀스
	private String dataSeq;
	//등록자명
	private String regNm;
	
	public String getDataTitle() {
		return dataTitle;
	}
	public void setDataTitle(String dataTitle) {
		this.dataTitle = dataTitle;
	}
	public String getDataSeq() {
		return dataSeq;
	}
	public void setDataSeq(String dataSeq) {
		this.dataSeq = dataSeq;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
}
