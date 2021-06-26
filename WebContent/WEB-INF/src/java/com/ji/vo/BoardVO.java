package com.ji.vo;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class BoardVO extends CommDefaultVO implements Serializable {
	//시퀀스
	private int dataSeqno;
	private String menuCd;
	private String dataTitle;
	private String dataDesc;
	private int inqCnt;
	private String dataOriginNo;
	private int dataDepth;
	private int dataSortNo;
	private String openYn;
	private String topDataYn;
	private String dataSpaStDt;
	private String dataSpaEndDt;
	private String photoImageAlt;
	private String dataSpaCol0;
	private String dataSpaCol1;
	private String dataSpaCol2;
	private String dataSpaCol3;
	private String dataSpaCol4;
	private String dataSpaCol5;
	private String dataSpaCol6;
	private String dataSpaCol7;
	private String dataSpaCol8;
	private String dataSpaCol9;
	private String dataIpns;
	private String rqesterPassword;
	private String authType;
	private String ipinNo;
	private String duplInfo;
	private String cnvDesc;
	/** 삭제파일리스트 */
	private String[] delFileSeqList;
	private List<FileVO> fileList;
	
	public int getDataSeqno() {
		return dataSeqno;
	}
	public void setDataSeqno(int dataSeqno) {
		this.dataSeqno = dataSeqno;
	}
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getDataTitle() {
		return dataTitle;
	}
	public void setDataTitle(String dataTitle) {
		this.dataTitle = dataTitle;
	}
	public String getDataDesc() {
		return dataDesc;
	}
	public void setDataDesc(String dataDesc) {
		this.dataDesc = dataDesc;
	}
	public int getInqCnt() {
		return inqCnt;
	}
	public void setInqCnt(int inqCnt) {
		this.inqCnt = inqCnt;
	}
	public String getDataOriginNo() {
		return dataOriginNo;
	}
	public void setDataOriginNo(String dataOriginNo) {
		this.dataOriginNo = dataOriginNo;
	}
	public int getDataDepth() {
		return dataDepth;
	}
	public void setDataDepth(int dataDepth) {
		this.dataDepth = dataDepth;
	}
	public int getDataSortNo() {
		return dataSortNo;
	}
	public void setDataSortNo(int dataSortNo) {
		this.dataSortNo = dataSortNo;
	}
	public String getOpenYn() {
		return openYn;
	}
	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}
	public String getTopDataYn() {
		return topDataYn;
	}
	public void setTopDataYn(String topDataYn) {
		this.topDataYn = topDataYn;
	}
	public String getDataSpaStDt() {
		return dataSpaStDt;
	}
	public void setDataSpaStDt(String dataSpaStDt) {
		this.dataSpaStDt = dataSpaStDt;
	}
	public String getDataSpaEndDt() {
		return dataSpaEndDt;
	}
	public void setDataSpaEndDt(String dataSpaEndDt) {
		this.dataSpaEndDt = dataSpaEndDt;
	}
	public String getPhotoImageAlt() {
		return photoImageAlt;
	}
	public void setPhotoImageAlt(String photoImageAlt) {
		this.photoImageAlt = photoImageAlt;
	}
	public String getDataSpaCol0() {
		return dataSpaCol0;
	}
	public void setDataSpaCol0(String dataSpaCol0) {
		this.dataSpaCol0 = dataSpaCol0;
	}
	public String getDataSpaCol1() {
		return dataSpaCol1;
	}
	public void setDataSpaCol1(String dataSpaCol1) {
		this.dataSpaCol1 = dataSpaCol1;
	}
	public String getDataSpaCol2() {
		return dataSpaCol2;
	}
	public void setDataSpaCol2(String dataSpaCol2) {
		this.dataSpaCol2 = dataSpaCol2;
	}
	public String getDataSpaCol3() {
		return dataSpaCol3;
	}
	public void setDataSpaCol3(String dataSpaCol3) {
		this.dataSpaCol3 = dataSpaCol3;
	}
	public String getDataSpaCol4() {
		return dataSpaCol4;
	}
	public void setDataSpaCol4(String dataSpaCol4) {
		this.dataSpaCol4 = dataSpaCol4;
	}
	public String getDataSpaCol5() {
		return dataSpaCol5;
	}
	public void setDataSpaCol5(String dataSpaCol5) {
		this.dataSpaCol5 = dataSpaCol5;
	}
	public String getDataSpaCol6() {
		return dataSpaCol6;
	}
	public void setDataSpaCol6(String dataSpaCol6) {
		this.dataSpaCol6 = dataSpaCol6;
	}
	public String getDataSpaCol7() {
		return dataSpaCol7;
	}
	public void setDataSpaCol7(String dataSpaCol7) {
		this.dataSpaCol7 = dataSpaCol7;
	}
	public String getDataSpaCol8() {
		return dataSpaCol8;
	}
	public void setDataSpaCol8(String dataSpaCol8) {
		this.dataSpaCol8 = dataSpaCol8;
	}
	public String getDataSpaCol9() {
		return dataSpaCol9;
	}
	public void setDataSpaCol9(String dataSpaCol9) {
		this.dataSpaCol9 = dataSpaCol9;
	}
	public String getDataIpns() {
		return dataIpns;
	}
	public void setDataIpns(String dataIpns) {
		this.dataIpns = dataIpns;
	}
	public String getRqesterPassword() {
		return rqesterPassword;
	}
	public void setRqesterPassword(String rqesterPassword) {
		this.rqesterPassword = rqesterPassword;
	}
	public String getAuthType() {
		return authType;
	}
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	public String getIpinNo() {
		return ipinNo;
	}
	public void setIpinNo(String ipinNo) {
		this.ipinNo = ipinNo;
	}
	public String getDuplInfo() {
		return duplInfo;
	}
	public void setDuplInfo(String duplInfo) {
		this.duplInfo = duplInfo;
	}
	public String getCnvDesc() {
		return cnvDesc;
	}
	public void setCnvDesc(String cnvDesc) {
		this.cnvDesc = cnvDesc;
	}
	public String[] getDelFileSeqList() {
		return delFileSeqList;
	}
	public void setDelFileSeqList(String[] delFileSeqList) {
		this.delFileSeqList = delFileSeqList;
	}
	public List<FileVO> getFileList() {
		return fileList;
	}
	public void setFileList(List<FileVO> fileList) {
		this.fileList = fileList;
	}
}
