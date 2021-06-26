package com.ji.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ReservationVO extends CommDefaultVO implements Serializable {
	
	/** 시퀀스번호 */
	private int applySeq;
	
	/** 신청자명 */
	private String applyNm;
	
	/** 예약시간(사업소별) */
	private int reservSeq;
	
	/** 예약일자 */
	private String applyDate;
	
	/** 예약인원 */
	private int applyPeople;
	
	/** 예약신청제목 */
	private String applyTitle;
	
	/** 예약신청내용 */
	private String applyCont;
	
	/** 승인여부 */
	private String ansTypeCd;
	
	/** 승인,반려사유 */
	private String ansCont;
	
	/** 승인자ID */
	private String ansId;
	
	/** 답변일자 */
	private String ansDate;
	
	/** 삭제여부 */
	private String delYn;
	
	/** 예약신청서 작성일자 */
	private String regDate;
	
	/** 승인자ID */
	private String applyNm2;
		
	/** EAI전송여부 */
	private String connRfltYn;
	
	/** 첨부파일ID */
	private String fileGroupSeqno;
	
	/** 신청사업소코드 */
	private String branchCd;
		
	/** 수정일(답변일) */
	private String modDate;
	
	/** 취소자 */
	private String applyCancelNm;
	
	/**  취소일*/
	private String applyCancelDate;
		
	/**  예약시간*/
	private String reservTitle;
	
	/**  예약사업소 코드 */
	private String reservBranchCd;
		
	/**  예약사업소코드*/
	private String BranchNm;
		
	/**  게시판구분*/
	private String boardCd;
	
	/**  휴대폰1*/
	private String telNo1;
	/**  휴대폰2*/
	private String telNo2;
	/**  휴대폰3*/
	private String telNo3;
	
	/** 검색*/
	private String searchName;
	private String searchAns;
	private String startDateU;
	private String endDateU;
	private String startDateR;
	private String endDateR;
	private String searchDept;
	
	
	public String getReservTitle() {
		return reservTitle;
	}

	public void setReservTitle(String reservTitle) {
		this.reservTitle = reservTitle;
	}
	
	public String getReservBranchCd() {
		return reservBranchCd;
	}

	public void setReservBranchCd(String reservBranchCd) {
		this.reservBranchCd = reservBranchCd;
	}
		
	public String getBranchNm() {
		return BranchNm;
	}

	public void setBranchNm(String BranchNm) {
		this.BranchNm = BranchNm;
	}
	
	public String getBoardCd() {
		return boardCd;
	}

	public void setBoardCd(String boardCd) {
		this.boardCd = boardCd;
	}

	public int getApplySeq() {
		return applySeq;
	}

	public void setApplySeq(int applySeq) {
		this.applySeq = applySeq;
	}

	public int getReservSeq() {
		return reservSeq;
	}

	public void setReservSeq(int reservSeq) {
		this.reservSeq = reservSeq;
	}

	public int getApplyPeople() {
		return applyPeople;
	}

	public void setApplyPeople(int applyPeople) {
		this.applyPeople = applyPeople;
	}
	
	public String getApplyNm() {
		return applyNm;
	}

	public void setApplyNm(String applyNm) {
		this.applyNm = applyNm;
	}
	
	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	
	public String getApplyTitle() {
		return applyTitle;
	}

	public void setApplyTitle(String applyTitle) {
		this.applyTitle = applyTitle;
	}
	
	public String getApplyCont() {
		return applyCont;
	}

	public void setApplyCont(String applyCont) {
		this.applyCont = applyCont;
	}
	
	public String getAnsTypeCd() {
		return ansTypeCd;
	}

	public void setAnsTypeCd(String ansTypeCd) {
		this.ansTypeCd = ansTypeCd;
	}
	
	public String getAnsCont() {
		return ansCont;
	}

	public void setAnsCont(String ansCont) {
		this.ansCont = ansCont;
	}
	
	public String getAnsId() {
		return ansId;
	}

	public void setAnsId(String ansId) {
		this.ansId = ansId;
	}
	
	public String getAnsDate() {
		return ansDate;
	}

	public void setAnsDate(String ansDate) {
		this.ansDate = ansDate;
	}
	
	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getApplyNm2() {
		return applyNm2;
	}

	public void setApplyNm2(String applyNm2) {
		this.applyNm2 = applyNm2;
	}
		
	public String getConnRfltYn() {
		return connRfltYn;
	}

	public void setConnRfltYn(String connRfltYn) {
		this.connRfltYn = connRfltYn;
	}
	
	public String getFileGroupSeqno() {
		return fileGroupSeqno;
	}

	public void setFileGroupSeqno(String fileGroupSeqno) {
		this.fileGroupSeqno = fileGroupSeqno;
	}
	
	public String getBranchCd() {
		return branchCd;
	}

	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getApplyCancelNm() {
		return applyCancelNm;
	}

	public void setApplyCancelNm(String applyCancelNm) {
		this.applyCancelNm = applyCancelNm;
	}

	public String getApplyCancelDate() {
		return applyCancelDate;
	}

	public void setApplyCancelDate(String applyCancelDate) {
		this.applyCancelDate = applyCancelDate;
	}
	
	public String getTelNo1() {
		return telNo1;
	}

	public void setTelNo1(String telNo1) {
		this.telNo1 = telNo1;
	}
	
	public String getTelNo2() {
		return telNo2;
	}

	public void setTelNo2(String telNo2) {
		this.telNo2 = telNo2;
	}
	
	public String getTelNo3() {
		return telNo3;
	}

	public void setTelNo3(String telNo3) {
		this.telNo3 = telNo3;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public String getSearchAns() {
		return searchAns;
	}

	public void setSearchAns(String searchAns) {
		this.searchAns = searchAns;
	}

		public String getStartDateU() {
		return startDateU;
	}

	public void setStartDateU(String startDateU) {
		this.startDateU = startDateU;
	}

	public String getEndDateU() {
		return endDateU;
	}

	public void setEndDateU(String endDateU) {
		this.endDateU = endDateU;
	}

	public String getStartDateR() {
		return startDateR;
	}

	public void setStartDateR(String startDateR) {
		this.startDateR = startDateR;
	}

	public String getEndDateR() {
		return endDateR;
	}

	public void setEndDateR(String endDateR) {
		this.endDateR = endDateR;
	}

	public String getSearchDept() {
		return searchDept;
	}

	public void setSearchDept(String searchDept) {
		this.searchDept = searchDept;
	}
	
}
