<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : main    
/* 소스파일 이름     : main.jsp
/* 설명              : SYSTEM 코드관리 메인페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-05
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-05
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");

String se_code	= HtmlTag.returnString((String)request.getAttribute("se_code"),"000000");
String se_lv	= HtmlTag.returnString((String)request.getAttribute("se_lv"),"1");
String sel_num	= HtmlTag.returnString((String)request.getAttribute("sel_num"),"");
String se_code_up_c	= HtmlTag.returnString((String)request.getAttribute("se_code_up_c"),"000000");

%>
					<!--내용시작  -->
					<%
						// 페이지 설정변수에 따라서 동적으로 리스트, 등록, 수정, 삭제, 답변페이지를 불러온다
					   if(pstate.equals("L")){

					%>
						  <%@include file="/WEB-INF/jsp/ji/cm/sti/jisi_sti_010_s3.jsp"%><!-- 리스트 jsp 파일-->
					<%	 
					   }else{
					%>

					<%
					   }
					%>
					<!--내용끝-->