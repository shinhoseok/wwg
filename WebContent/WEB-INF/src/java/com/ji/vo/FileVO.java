package com.ji.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class FileVO extends CommDefaultVO implements Serializable {
	private int fileSeqNo;
	private String fileSeqno;
	private String menuDataKeyDatas;
	private String fileGroup;
	private String menuDataTitle;
	private String fileNm;
	private String updateFileNm;
	private int fileOrderNo;
	private String fileSize;
	private String fileDesc;
	private int fileCnt;
	private String fileScrtyAt;
	private String secretYn;
	
	public int getFileSeqNo() {
		return fileSeqNo;
	}
	public void setFileSeqNo(int fileSeqNo) {
		this.fileSeqNo = fileSeqNo;
	}
	public String getFileSeqno() {
		return fileSeqno;
	}
	public void setFileSeqno(String fileSeqno) {
		this.fileSeqno = fileSeqno;
	}
	public String getMenuDataKeyDatas() {
		return menuDataKeyDatas;
	}
	public void setMenuDataKeyDatas(String menuDataKeyDatas) {
		this.menuDataKeyDatas = menuDataKeyDatas;
	}
	public String getFileGroup() {
		return fileGroup;
	}
	public void setFileGroup(String fileGroup) {
		this.fileGroup = fileGroup;
	}
	public String getMenuDataTitle() {
		return menuDataTitle;
	}
	public void setMenuDataTitle(String menuDataTitle) {
		this.menuDataTitle = menuDataTitle;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getUpdateFileNm() {
		return updateFileNm;
	}
	public void setUpdateFileNm(String updateFileNm) {
		this.updateFileNm = updateFileNm;
	}
	public int getFileOrderNo() {
		return fileOrderNo;
	}
	public void setFileOrderNo(int fileOrderNo) {
		this.fileOrderNo = fileOrderNo;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileDesc() {
		return fileDesc;
	}
	public void setFileDesc(String fileDesc) {
		this.fileDesc = fileDesc;
	}
	public int getFileCnt() {
		return fileCnt;
	}
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}
	public String getFileScrtyAt() {
		return fileScrtyAt;
	}
	public void setFileScrtyAt(String fileScrtyAt) {
		this.fileScrtyAt = fileScrtyAt;
	}
	public String getSecretYn() {
		return secretYn;
	}
	public void setSecretYn(String secretYn) {
		this.secretYn = secretYn;
	}
}
