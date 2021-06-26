<%--
/*=================================================================================*/
/* 시스템            : 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_030_m2.jsp 
/* 프로그램 이름     : jicm_apm_030_m2    
/* 소스파일 이름     : jicm_apm_030_m2.jsp
/* 설명              : 결재함
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-06-11
/* 최근 수정자       : 최유성
/* 최근 수정일시     : 2016-11-30
/* 최종 수정내용     : 자금운용시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
%>
				<!--내용시작  -->
					<%
						// 페이지 설정변수에 따라서 동적으로 리스트, 등록, 수정, 삭제, 답변페이지를 불러온다
					   if(pstate.equals("L")){

					%>
						<%@include file="/WEB-INF/jsp/ji/cm/apm/jicm_apm_030_s3.jsp"%><!-- 리스트 jsp 파일-->

					<%
					   }
					%>
					<!--내용끝-->