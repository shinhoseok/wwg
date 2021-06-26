<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/*
/* 프로그램 이름     : Cmheader    
/* 소스파일 이름     : Cmheader.jsp
/* 설명              : SYSTEM 시스템 관리자 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-15
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
String jsessionid = request.getSession().getId();
response.setHeader("SET-COOKIE","JSESSIONID="+jsessionid+";HttpOnly");
response.setHeader("cache-control", "no-cache, no-store, must-revalidate");
response.setHeader("expires", "0");
response.setHeader("pragma", "no-cache");
response.setHeader("x-frame-options", "SAMEORIGIN");		//교차 프레임 스크립팅 방어
response.setHeader("x-content-type-options", "nosniff");	//Missing "X-Content-Type-Options" header
response.setHeader("x-xss-protection", "1; mode=block");	//Missing "X-XSS-Protection" header
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"><!--호환성-->
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0" />
	<meta name="format-detection" content="telephone=no"/><!-- 전화번호 자동링크 없애기 -->
	<meta name="keywords" content=""><!-- 키워드 제공 -->
	<meta name="description" content=""><!-- 요약정보 -->
	<meta name="robots" content="all"><!-- 검색로봇 -->    
    <link rel="stylesheet" type="text/css" href="<%=con_root %>/style/project_css/slick.css" />
    <%if(pcode.equals("main")){ %>
    <link rel="stylesheet" type="text/css" href="<%=con_root %>/style/project_css/main.css" />
    <%}else{ %>
    <link rel="stylesheet" type="text/css" href="<%=con_root %>/style/project_css/sub.css" />
    <%} %>    
    <link rel="stylesheet" type="text/css" href="<%=con_root %>/style/project_css/rwd.css" />
    
    <link type="text/css" rel="stylesheet" href="<%=con_root%>/js/jquery-ui.css">
    <script type="text/javascript" src="<%=con_root%>/js/jquery-1.12.4.min.js"></script>
    <script src="<%=con_root %>/js/project_js/slick.js"></script>
	<script src="<%=con_root %>/js/project_js/common.js"></script>
	<%if(pcode.equals("main")){ %>
	<script src="<%=con_root %>/js/project_js/main.js"></script>
    <%}else{ %>
    <script src="<%=con_root %>/js/project_js/sub.js"></script>
    <%} %>	
	<script type="text/javascript" src="<%=con_root%>/js/CmCommon.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery-ui.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery.ui.datepicker-ko.js"></script>
	<%@ include file="/WEB-INF/jsp/cm/CmCommonMsg.jsp" %>
		
	<!-- com -->
	<script src="<%=con_root%>/js/com.js" type="text/javascript" charset="utf-8"></script>
	<script src="<%=con_root%>/js/com-jquery-fn.js" type="text/javascript" charset="utf-8"></script>
			
	<title><%=_system_name %></title>
</head>


