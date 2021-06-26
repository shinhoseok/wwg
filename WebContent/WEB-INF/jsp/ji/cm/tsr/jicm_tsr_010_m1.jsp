<%--
/*=================================================================================*/
/* 시스템            : 포탈시스템
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/tsr/jicm_tsr_010_m1.jsp
/* 프로그램 이름     : jicm_tsr_010_m1
/* 소스파일 이름     : jicm_tsr_010_m1.jsp
/* 설명              : 통합검색
/* 버전              : 1.0.0
/* 최초 작성자       : shkim
/* 최초 작성일자     : 2018-05-03
/* 최근 수정자       : shkim
/* 최근 수정일시     : 2018-05-03
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");
%>
<!--내용시작  -->
<%
   if (pstate.equals("L")) {
%>
      <%@include file="/WEB-INF/jsp/ji/cm/tsr/jicm_tsr_010_s1.jsp"%><!-- 리스트 jsp 파일-->
<%
   }
%>


<!--내용끝-->
