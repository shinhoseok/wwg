package com.ji.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CommDefaultVO implements Serializable {
	/** 현재 페이지 */
	private int pageIndex = 1;
	/** 검색조건 */
	private String searchGubun = "";
	/** 검색키워드 */
	private String searchValue = "";
	/** 검색시작일시 */
	private String startDate = "";
	/** 검색종료일시 */
	private String endDate = "";
	/** 페이지 갯수 */
	private int pageUnit;
	/** 페이지 사이즈 */
	private int pageSize;
	/** 시작 인덱스 */
	private int firstIndex = 1;
	/** 끝 인덱스 */
	private int lastIndex = 1;
	/**페이지 별 레코드 갯수  */
	private int recordCountPerPage = 10;
	/** 등록자 아이디 */
	private String regId;
	/** 등록자 이름 */
	private String regNm;
	/** 등록일 */
	private String regDt;
	/** 수정자 아이디 */
	private String modId;
	/** 수정자 이름 */
	private String modNm;
	/** 사번,사용자 아이디 */
	private String usrId;
	/** 사용자명 */
	private String usrNm;
	/** 사용자아이피 */
	private String usrIp;
	/** 삭제여부 */
	private String delYn;
	/** 페이지번호 */
	private String rNum;
	/** 수정일자 */
	private String modDt;
	/** 삭제일자 */
	private String delDt;
	/** 삭제자아이디 */
	private String delId;
	/** 메뉴코드 */
	private String menuCd;
	/** 관리자 lv*/
	private String adminLevel;
	/** 담당자 조직코드*/
	private String orgCd;
	/** EAI 연계성공여부 내부*/
	private String cnntRfltYn;
	/** EAI 연계일자  내부*/
	private String cnntRfltDt;
	/** EAI 연계성공여부 외부 */
	private String cnntRfltYn2;
	/** EAI 연계일자 외부*/
	private String cnntRfltDt2;
	
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public String getSearchGubun() {
		return searchGubun;
	}
	public void setSearchGubun(String searchGubun) {
		this.searchGubun = searchGubun;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModNm() {
		return modNm;
	}
	public void setModNm(String modNm) {
		this.modNm = modNm;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getUsrNm() {
		return usrNm;
	}
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	public String getUsrIp() {
		return usrIp;
	}
	public void setUsrIp(String usrIp) {
		this.usrIp = usrIp;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getrNum() {
		return rNum;
	}
	public void setrNum(String rNum) {
		this.rNum = rNum;
	}
	public String getModDt() {
		return modDt;
	}
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	public String getDelDt() {
		return delDt;
	}
	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}
	public String getDelId() {
		return delId;
	}
	public void setDelId(String delId) {
		this.delId = delId;
	}
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getAdminLevel() {
		return adminLevel;
	}
	public void setAdminLevel(String adminLevel) {
		this.adminLevel = adminLevel;
	}
	public String getOrgCd() {
		return orgCd;
	}
	public void setOrgCd(String orgCd) {
		this.orgCd = orgCd;
	}
	public String getCnntRfltYn() {
		return cnntRfltYn;
	}
	public void setCnntRfltYn(String cnntRfltYn) {
		this.cnntRfltYn = cnntRfltYn;
	}
	public String getCnntRfltDt() {
		return cnntRfltDt;
	}
	public void setCnntRfltDt(String cnntRfltDt) {
		this.cnntRfltDt = cnntRfltDt;
	}
	public String getCnntRfltYn2() {
		return cnntRfltYn2;
	}
	public void setCnntRfltYn2(String cnntRfltYn2) {
		this.cnntRfltYn2 = cnntRfltYn2;
	}
	public String getCnntRfltDt2() {
		return cnntRfltDt2;
	}
	public void setCnntRfltDt2(String cnntRfltDt2) {
		this.cnntRfltDt2 = cnntRfltDt2;
	}
}
