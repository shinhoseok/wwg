package com.ji.vo;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class MenuVO extends CommDefaultVO implements Serializable {
	//메뉴명
	private String menuNm;
	//부모 메뉴코드
	private String menuUppoCd;
	
	private List<MenuVO> menuList;
	
	private String menuDepth1Cd;
	
	private String menuDepth1Nm;
	
	private String menuDepth1UppoCd;
	
	private String menuDepth2Cd;
	
	private String menuDepth2Nm;
	
	private String menuDepth2UppoCd;
	
	private String menuDepth3Cd;
	
	private String menuDepth3Nm;
	
	private String menuDepth3UppoCd;
	
	private String menuDepth4Cd;
	
	private String menuDepth4Nm;
	
	private String menuDepth4UppoCd;
	//메뉴 일련번호
	private int menuSeqno;
	//메뉴 순번
	private int orderNo;
	//메뉴 깊이
	private int depthNo;
	//연결 종류 코드
	private String linkTy;
	private String linkTyNm;
	//메뉴 클래스 경로
	private String classPath;
	//메뉴링크 경로(또는 컨텐츠경로)
	private String linkPath;
	//게시판 종류코드(000005 없음, 000006 컨텐츠, 000007 링크, 000008 게시판, 000009 프로그램)
	private String boardTy;
	private String boardTyNm;
	//게시판 구분
	private String boardGbn;
	//연결 목표 코드
	private String linkTarget;
	//메뉴이미지 on -사용안함
	private String mImgOn;
	//메뉴이미지 off -사용안함
	private String mImgOff;
	//메뉴이미지 설명 -사용안함
	private String mImgAlt;
	//JSP 경로
	private String classPathJsp;
	//메뉴컨트롤 메소드명
	private String classMethod;
	//메뉴사용 시작일
	private String mSdate;
	//메뉴사용 종료일
	private String mEdate;
	//게시판 예비 항목들 종류(left메뉴 or 탭메뉴)
	private String mSStyle;
	//JSP 연결종류 코드
	private String jspIncludeYn;
	//게시판 리스트 항목들(B_TITLE::REG_NAME...)
	private String boardLiItem;
	//게시판 리스트 항목명들(제목::작성자...)
	private String boardLiItemNm;
	//게시판 임시컬럼 사용여부(Y::N...)
	private String boardEtcItem;
	//게시판 임시컬럼 데이터타입(V::N::D::...)
	private String boardEtcItemTy;
	//게시판 임시컬럼 출력항목명(시작일::종료일..)
	private String boardEtcItemNm;
	//게시판 선택사항들
	private String boardOpt;
	//메뉴 제목 HTML
	private String mTitleHtml;
	//게시판 예비 항목들 코드
	private String boardEtcItemCode;
	//게시판 통합 메뉴 코드들2
	private String boardIntMCodes;
	//메뉴 옵션
	private String mOpt;
	//ALIVE 체크시간
	private String aliveTime;
	//ALIVE 여부
	private String aliveYn;
	
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuUppoCd() {
		return menuUppoCd;
	}
	public void setMenuUppoCd(String menuUppoCd) {
		this.menuUppoCd = menuUppoCd;
	}
	public List<MenuVO> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<MenuVO> menuList) {
		this.menuList = menuList;
	}
	public String getMenuDepth1Cd() {
		return menuDepth1Cd;
	}
	public void setMenuDepth1Cd(String menuDepth1Cd) {
		this.menuDepth1Cd = menuDepth1Cd;
	}
	public String getMenuDepth1Nm() {
		return menuDepth1Nm;
	}
	public void setMenuDepth1Nm(String menuDepth1Nm) {
		this.menuDepth1Nm = menuDepth1Nm;
	}
	public String getMenuDepth1UppoCd() {
		return menuDepth1UppoCd;
	}
	public void setMenuDepth1UppoCd(String menuDepth1UppoCd) {
		this.menuDepth1UppoCd = menuDepth1UppoCd;
	}
	public String getMenuDepth2Cd() {
		return menuDepth2Cd;
	}
	public void setMenuDepth2Cd(String menuDepth2Cd) {
		this.menuDepth2Cd = menuDepth2Cd;
	}
	public String getMenuDepth2Nm() {
		return menuDepth2Nm;
	}
	public void setMenuDepth2Nm(String menuDepth2Nm) {
		this.menuDepth2Nm = menuDepth2Nm;
	}
	public String getMenuDepth2UppoCd() {
		return menuDepth2UppoCd;
	}
	public void setMenuDepth2UppoCd(String menuDepth2UppoCd) {
		this.menuDepth2UppoCd = menuDepth2UppoCd;
	}
	public String getMenuDepth3Cd() {
		return menuDepth3Cd;
	}
	public void setMenuDepth3Cd(String menuDepth3Cd) {
		this.menuDepth3Cd = menuDepth3Cd;
	}
	public String getMenuDepth3Nm() {
		return menuDepth3Nm;
	}
	public void setMenuDepth3Nm(String menuDepth3Nm) {
		this.menuDepth3Nm = menuDepth3Nm;
	}
	public String getMenuDepth3UppoCd() {
		return menuDepth3UppoCd;
	}
	public void setMenuDepth3UppoCd(String menuDepth3UppoCd) {
		this.menuDepth3UppoCd = menuDepth3UppoCd;
	}
	public String getMenuDepth4Cd() {
		return menuDepth4Cd;
	}
	public void setMenuDepth4Cd(String menuDepth4Cd) {
		this.menuDepth4Cd = menuDepth4Cd;
	}
	public String getMenuDepth4Nm() {
		return menuDepth4Nm;
	}
	public void setMenuDepth4Nm(String menuDepth4Nm) {
		this.menuDepth4Nm = menuDepth4Nm;
	}
	public String getMenuDepth4UppoCd() {
		return menuDepth4UppoCd;
	}
	public void setMenuDepth4UppoCd(String menuDepth4UppoCd) {
		this.menuDepth4UppoCd = menuDepth4UppoCd;
	}
	public int getMenuSeqno() {
		return menuSeqno;
	}
	public void setMenuSeqno(int menuSeqno) {
		this.menuSeqno = menuSeqno;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getDepthNo() {
		return depthNo;
	}
	public void setDepthNo(int depthNo) {
		this.depthNo = depthNo;
	}
	public String getLinkTy() {
		return linkTy;
	}
	public void setLinkTy(String linkTy) {
		this.linkTy = linkTy;
	}
	public String getLinkTyNm() {
		return linkTyNm;
	}
	public void setLinkTyNm(String linkTyNm) {
		this.linkTyNm = linkTyNm;
	}
	public String getClassPath() {
		return classPath;
	}
	public void setClassPath(String classPath) {
		this.classPath = classPath;
	}
	public String getLinkPath() {
		return linkPath;
	}
	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}
	public String getBoardTy() {
		return boardTy;
	}
	public void setBoardTy(String boardTy) {
		this.boardTy = boardTy;
	}
	public String getBoardTyNm() {
		return boardTyNm;
	}
	public void setBoardTyNm(String boardTyNm) {
		this.boardTyNm = boardTyNm;
	}
	public String getBoardGbn() {
		return boardGbn;
	}
	public void setBoardGbn(String boardGbn) {
		this.boardGbn = boardGbn;
	}
	public String getLinkTarget() {
		return linkTarget;
	}
	public void setLinkTarget(String linkTarget) {
		this.linkTarget = linkTarget;
	}
	public String getmImgOn() {
		return mImgOn;
	}
	public void setmImgOn(String mImgOn) {
		this.mImgOn = mImgOn;
	}
	public String getmImgOff() {
		return mImgOff;
	}
	public void setmImgOff(String mImgOff) {
		this.mImgOff = mImgOff;
	}
	public String getmImgAlt() {
		return mImgAlt;
	}
	public void setmImgAlt(String mImgAlt) {
		this.mImgAlt = mImgAlt;
	}
	public String getClassPathJsp() {
		return classPathJsp;
	}
	public void setClassPathJsp(String classPathJsp) {
		this.classPathJsp = classPathJsp;
	}
	public String getClassMethod() {
		return classMethod;
	}
	public void setClassMethod(String classMethod) {
		this.classMethod = classMethod;
	}
	public String getmSdate() {
		return mSdate;
	}
	public void setmSdate(String mSdate) {
		this.mSdate = mSdate;
	}
	public String getmEdate() {
		return mEdate;
	}
	public void setmEdate(String mEdate) {
		this.mEdate = mEdate;
	}
	public String getmSStyle() {
		return mSStyle;
	}
	public void setmSStyle(String mSStyle) {
		this.mSStyle = mSStyle;
	}
	public String getJspIncludeYn() {
		return jspIncludeYn;
	}
	public void setJspIncludeYn(String jspIncludeYn) {
		this.jspIncludeYn = jspIncludeYn;
	}
	public String getBoardLiItem() {
		return boardLiItem;
	}
	public void setBoardLiItem(String boardLiItem) {
		this.boardLiItem = boardLiItem;
	}
	public String getBoardLiItemNm() {
		return boardLiItemNm;
	}
	public void setBoardLiItemNm(String boardLiItemNm) {
		this.boardLiItemNm = boardLiItemNm;
	}
	public String getBoardEtcItem() {
		return boardEtcItem;
	}
	public void setBoardEtcItem(String boardEtcItem) {
		this.boardEtcItem = boardEtcItem;
	}
	public String getBoardEtcItemTy() {
		return boardEtcItemTy;
	}
	public void setBoardEtcItemTy(String boardEtcItemTy) {
		this.boardEtcItemTy = boardEtcItemTy;
	}
	public String getBoardEtcItemNm() {
		return boardEtcItemNm;
	}
	public void setBoardEtcItemNm(String boardEtcItemNm) {
		this.boardEtcItemNm = boardEtcItemNm;
	}
	public String getBoardOpt() {
		return boardOpt;
	}
	public void setBoardOpt(String boardOpt) {
		this.boardOpt = boardOpt;
	}
	public String getmTitleHtml() {
		return mTitleHtml;
	}
	public void setmTitleHtml(String mTitleHtml) {
		this.mTitleHtml = mTitleHtml;
	}
	public String getBoardEtcItemCode() {
		return boardEtcItemCode;
	}
	public void setBoardEtcItemCode(String boardEtcItemCode) {
		this.boardEtcItemCode = boardEtcItemCode;
	}
	public String getBoardIntMCodes() {
		return boardIntMCodes;
	}
	public void setBoardIntMCodes(String boardIntMCodes) {
		this.boardIntMCodes = boardIntMCodes;
	}
	public String getmOpt() {
		return mOpt;
	}
	public void setmOpt(String mOpt) {
		this.mOpt = mOpt;
	}
	public String getAliveTime() {
		return aliveTime;
	}
	public void setAliveTime(String aliveTime) {
		this.aliveTime = aliveTime;
	}
	public String getAliveYn() {
		return aliveYn;
	}
	public void setAliveYn(String aliveYn) {
		this.aliveYn = aliveYn;
	}
}
