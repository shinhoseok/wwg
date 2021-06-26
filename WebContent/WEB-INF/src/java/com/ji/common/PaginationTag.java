package com.ji.common;

import java.io.IOException;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

public final class PaginationTag extends RequestContextAwareTag {

	private static final long serialVersionUID = 1L;

	/** 총건수 */
	private int totalCount = 0;
	/** 페이지번호 */
	private int pageNo = 1;
	/** 페이지사이즈 */
	private int pageSize = 10;
	/** 총페이지 */
	private int totalPage = 0;
	/** Display 페이지 수 */
	private int displayPageCount = 10;
	private String clickPage = "";
//	private String imgPath = "";
	
	public void setClickPage(String clickPage) {
		this.clickPage = clickPage;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public void setDisplayPageCount(int displayPageCount) {
		this.displayPageCount = displayPageCount;
	}
//	public void setImgPath(String imgPath) {
//		this.imgPath = imgPath;
//	}

	@Override
	protected int doStartTagInternal() throws Exception {
		drawPaging();
		return SKIP_BODY;
	}

	private void drawPaging() throws IOException {
		System.out.println(this.totalCount+">>"+this.pageSize);
		this.totalPage = (this.totalCount / this.pageSize) + ((this.totalCount*1.0) % (this.pageSize*1.0) > 0 ? 1 : 0);
		int curPos = (this.pageNo / this.displayPageCount) + ((this.pageNo*1.0) % (this.displayPageCount*1.0) > 0 ? 1 : 0);
		/*10개씩 앞으로 혹은 뒤로 가기
		int prevPage = curPos > 1 ? (curPos - 1) * this.displayPageCount : 0;
		int nextPage = (curPos * this.displayPageCount +1) <= this.totalPage ? curPos * this.displayPageCount + 1 : 0;
		*/
		//1개씩 앞으로 혹은 뒤로 가기 이금용 실장님 스타일.
		int prevPage = this.pageNo - 1;
		int nextPage = this.pageNo + 1;
		
		int start =((this.pageNo / this.displayPageCount) + ((this.pageNo*1.0) % (this.displayPageCount*1.0) > 0 ? 1 : 0)) * this.displayPageCount - (this.displayPageCount -1);
		int end = ((this.pageNo / this.displayPageCount) + ((this.pageNo*1.0) % (this.displayPageCount*1.0) > 0 ? 1 : 0)) * this.displayPageCount ;
		
		if(end > this.totalPage) {
			end = this.totalPage;
		}
		//이미지 사용시
		/*
		 * HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		 * String contextPath = request.getContextPath(); String strWebDir = contextPath
		 * + "/contents/images/";
		 */
		StringBuffer sb = new StringBuffer();
		
//		if(start > end) {
		if(this.pageNo <= 1) {
			sb.append("<button type='button' class='first'>첫페이지 보기</button>");
		} else {
			sb.append("<button type='button' onclick='javascript:"+ clickPage +"(1)' class='first'>첫페이지 보기</button>");
		}
		
//		if(this.pageNo > this.displayPageCount) { 이금용 실장님 페이징 스타일로 변경
		if(this.pageNo > 1) {
			sb.append("<button type='button' onclick='javascript:"+ clickPage + "(" + prevPage + ")" + "' class='prev'>이전페이지 보기</button>");
		} else {
			sb.append("<button type='button' class='prev'>이전페이지 보기</button>");
		}
		
		if( start > end ){
			sb.append("<a href='#' class='page_on' style='margin-right: 10px;'>1</a>");
		}else{
			for(int i=start ; i<=end ; i++) {
				if(i == this.pageNo) {
					sb.append("<a href='javascript:" + clickPage + "(" + i + ");' class='page_on' style='margin-right: 10px;'>" + i + "</a>");
				} else {
					sb.append("<a href='javascript:" + clickPage + "(" + i + ");' class='page' style='margin-right: 10px;'>" + i + "</a>");
				}
			}
		}
		
//		if(this.totalPage >= nextPage && nextPage != 0) {
		if( totalPage > this.pageNo ) {
			sb.append("<button type='button' onclick='javascript:"+ clickPage + "(" + nextPage + ")" + "' class='next'></button>");
		} else {
			sb.append("<button type='button' class='next'></button>");
		}
		
//		if( start > end ) {
		if( totalPage <= this.pageNo ) {
			sb.append("<button type='button' class='last'></button>");
		} else {
			sb.append("<button type='button' onclick='javascript:"+ clickPage + "(" + totalPage + ")" + "' class='last'></button>");
		}
		
		pageContext.getOut().write(sb.toString());
	}
}
