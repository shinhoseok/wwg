﻿<%@page pageEncoding="utf-8"%><%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일--><%// jiop_opn_050_m1.jspString curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");String adm_rpcode = "000554"; // 코로나19 중소기업 피해지원센터// 화면 권한을 셋팅한다// 시스템관리자의 경우 무조건 관리권한을 가진다boolean isMenuMng = true;%><!--내용시작  --><%   if(pstate.equals("L")){%>	<!-- 리스트 jsp 파일-->	<%@include file="/WEB-INF/jsp/ji/op/opn/jiop_opn_020_s1.jsp"%><%   }else if(pstate.equals("DF")){%><%   }%><!--내용끝-->