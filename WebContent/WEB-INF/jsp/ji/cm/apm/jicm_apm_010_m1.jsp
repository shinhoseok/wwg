<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_010_m1.jsp 
/* 프로그램 이름     : jicm_apm_010_m1  
/* 소스파일 이름     : jicm_apm_010_m1.jsp
/* 설명              : 공통 결재관리 관리 리스트
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-27
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-14
/* 최종 수정내용     : 전력데이터제공포털에 맞게 수정
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
ArrayList se_code_arr =  new ArrayList();

if(!sel_num.equals("")){
	for(int r=0;r<=Integer.parseInt(sel_num,10);r++){
		se_code_arr.add(HtmlTag.returnString((String)request.getAttribute("dto_SELMENU_"+r),""));
	}
}
%>
				<!--내용시작  -->
					<%
						// 페이지 설정변수에 따라서 동적으로 리스트, 등록, 수정, 삭제, 답변페이지를 불러온다
					   if(pstate.equals("L")){

					%>
						<%@include file="/WEB-INF/jsp/ji/cm/apm/jicm_apm_010_a1.jsp"%><!-- 리스트 jsp 파일-->
					<%
					   }
					%>
					<!--내용끝-->