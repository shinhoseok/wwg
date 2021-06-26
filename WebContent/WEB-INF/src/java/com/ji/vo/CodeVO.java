package com.ji.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CodeVO extends CommDefaultVO implements Serializable {
	//코드시퀀스
	private int stdinfoDtlSeq;
	//부모코드
	private String stdinfoDtlUppoCd;
	//코드명
	private String stdinfoDtlNm;
	//코드값
	private String stdinfoDtlCd;
	
	private String authGrpCd;
	//코드라벨
	private String stdinfoDtlLabel;
	
	public int getStdinfoDtlSeq() {
		return stdinfoDtlSeq;
	}
	public void setStdinfoDtlSeq(int stdinfoDtlSeq) {
		this.stdinfoDtlSeq = stdinfoDtlSeq;
	}
	public String getStdinfoDtlUppoCd() {
		return stdinfoDtlUppoCd;
	}
	public void setStdinfoDtlUppoCd(String stdinfoDtlUppoCd) {
		this.stdinfoDtlUppoCd = stdinfoDtlUppoCd;
	}
	public String getStdinfoDtlNm() {
		return stdinfoDtlNm;
	}
	public void setStdinfoDtlNm(String stdinfoDtlNm) {
		this.stdinfoDtlNm = stdinfoDtlNm;
	}
	public String getStdinfoDtlCd() {
		return stdinfoDtlCd;
	}
	public void setStdinfoDtlCd(String stdinfoDtlCd) {
		this.stdinfoDtlCd = stdinfoDtlCd;
	}
	public String getAuthGrpCd() {
		return authGrpCd;
	}
	public void setAuthGrpCd(String authGrpCd) {
		this.authGrpCd = authGrpCd;
	}
	public String getStdinfoDtlLabel() {
		return stdinfoDtlLabel;
	}
	public void setStdinfoDtlLabel(String stdinfoDtlLabel) {
		this.stdinfoDtlLabel = stdinfoDtlLabel;
	}
}
