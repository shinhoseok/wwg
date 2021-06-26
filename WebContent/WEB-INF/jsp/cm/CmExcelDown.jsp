<%--
/*=================================================================================*/
/* 시스템            : 
/* 프로그램 아이디   : 
/* 프로그램 이름     : 
/* 소스파일 이름     : 
/* 설명              : 
/* 버전              : 1.0.0
/* 최초 작성자       : jhlee
/* 최초 작성일자     : 2014-10-00
/* 최근 수정자       : 
/* 최근 수정일시     : 2014-10-00
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@ page import="com.ji.common.HtmlTag"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> --%>
<%
	//String excelFileName = java.net.URLDecoder.decode(request.getParameter("excelFileName"),"utf-8");
	String excelFileName ="";
	String paramFileName =HtmlTag.returnString((String)request.getParameter("excelFileName"));
	
	if(paramFileName.equals(null) || paramFileName.equals("")){
		excelFileName ="excelList";
	}else{
		excelFileName = paramFileName;
	}
	
	String userAgent = request.getHeader("User-Agent");
	
	// MS IE 5.5 이하
	if (userAgent.indexOf("MSIE 5.5") > -1) { 
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// MS IE (보통은 6.x 이상 가정)
	else if (userAgent.indexOf("MSIE") > -1) { 
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// IE 11.0
	else if(userAgent.contains("11.0")){
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// 안드로이드 크롬브라우저 대응
	else if(userAgent.indexOf("Android") > -1){
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// 모질라나 오페라
	else { 
		excelFileName = new String(excelFileName.getBytes("UTF-8"), "ISO-8859-1"); 
	}
	
	response.setContentType("application/vnd.ms-excel;");
	//response.setHeader("Content-Disposition","attachment; filename="+ (new String((excelFileName).getBytes("utf-8"),"8859_1")) +".xls"); //KSC5601
	//response.setHeader("Content-Disposition","attachment; filename="+ excelFileName +".xls"); //KSC5601
	response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName.replace("+", " ") + ".xls" );	//띄워쓰기(+생성됨) 관련해서 추가함
	response.setHeader("Content-Description", "JSP Generated Data");
	
	response.setHeader("cache-control","no-cache, no-store, must-revalidate");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
	
%>

<html>
<head>
	<style> .excel_header {background-color:#efefef;} </style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>


<c:import url="${ (empty excelDownUrl)? '/WEB-INF/jsp/cm/CmExcelDownGrid.jsp' : excelDownUrl }"></c:import>


</body>
</html>