<%--/*=================================================================================*//* 시스템            : 시스템 통계 / 통계 / 홈페이지 운영실적/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/sta/jicm_sta_010_m1.jsp/* 프로그램 이름     : jista_020_m1/* 소스파일 이름     : jista_020_m1.jsp/* 설명              : 분석보고서/* 버전              : 1.0.0/* 최초 작성자       : 윤성종/* 최초 작성일자     : 2018-03-12/* 최근 수정자       : 윤성종/* 최근 수정일시     : 2018-03-12/* 최종 수정내용     : 최초작성/*=================================================================================*/--%><%@page pageEncoding="utf-8"%><%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일--><%String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");%>										<!--내용시작  -->					<%					// 페이지 설정변수에 따라서 동적으로 리스트, 등록, 수정, 삭제, 답변페이지를 불러온다					if(pstate.equals("L")){										%>						  <%@include file="/WEB-INF/jsp/ji/cm/sta/jicm_sta_020_s1.jsp"%><!-- 리스트 jsp 파일-->					<%	 					   }					%>					<!--내용끝-->