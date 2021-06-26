package com.ji.cm;

import java.text.MessageFormat;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class PaginationRenderer extends AbstractPaginationRenderer {

    public PaginationRenderer() {
    	firstPageLabel 		= "<a href=\"#\" class=\"boxFirst\" 	onclick=\"{0}({1}); return false;\">처음 페이지 이동<span></span></a>";
    	previousPageLabel 	= "<a href=\"#\" class=\"boxPrev\" 	onclick=\"{0}({1}); return false;\">이전 페이지 이동</a>";
    	currentPageLabel 	= "<a href=\"#\" class=\"boxnow\"> {0}</a>";
    	otherPageLabel 		= "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
    	nextPageLabel 		= "<a href=\"#\" class=\"boxNext\" 	onclick=\"{0}({1}); return false;\">다음 페이지 이동</a>";
    	lastPageLabel 		= "<a href=\"#\" class=\"boxLast\"  	onclick=\"{0}({1}); return false;\">마지막 페이지 이동<span></span></a>";
    }

    @Override
    public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
    	StringBuffer strBuff = new StringBuffer();
    	  
    	  int firstPageNo = paginationInfo.getFirstPageNo();
    	  int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
    	  int totalPageCount = paginationInfo.getTotalPageCount();
    	  int pageSize = paginationInfo.getPageSize();
    	  int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
    	  int currentPageNo = paginationInfo.getCurrentPageNo();
    	  int lastPageNo = paginationInfo.getLastPageNo();
    	  
    	  //if (totalPageCount > pageSize) {
    	    if (firstPageNoOnPageList > pageSize) {
    	      strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
    	      strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList - 1) }));
    	    } else {
    	      strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
    	      strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
    	    }
    	  //}
    	  
    	  for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
    	    if (i == currentPageNo) {
    	      strBuff.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
    	    } else {
    	      strBuff.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
    	    }
    	  }
    	  
    	  //if (totalPageCount > pageSize) {
    	    if (lastPageNoOnPageList < totalPageCount) {
    	      strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList + pageSize) }));
    	      strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
    	    } else {
    	      strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
    	      strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
    	    }
    	  //}
    	  return strBuff.toString();
    }

}