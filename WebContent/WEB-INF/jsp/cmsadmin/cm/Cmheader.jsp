<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta name="format-detection" content="telephone=no"/><!-- 전화번호 자동링크 없애기 -->
	<meta name="keywords" content=""><!-- 키워드 제공 -->
	<meta name="description" content=""><!-- 요약정보 -->
	<meta name="robots" content="all"><!-- 검색로봇 -->
	<title><%=_system_name %> 관리자</title>
	<link href="<%=con_root%>/style/cmsadmin/setting.css" rel="stylesheet" type="text/css">
	<link href="<%=con_root%>/style/cmsadmin/cmsdefault.css" rel="stylesheet" type="text/css">
	<link href="<%=con_root%>/style/cmsadmin/board.css" rel="stylesheet" type="text/css">
	<link href="<%=con_root%>/style/print-preview.css" rel="stylesheet" type="text/css" />
	
	<!-- jqGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="<%=con_root%>/js/jqGrid.4.6/css/jquery-ui-custom.1.8.23.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="<%=con_root%>/js/jqGrid.4.6/css/ui.jqgrid.css" />

	<!-- jqGrid -->
	<script type="text/javascript" src="<%=con_root%>/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/CmCommon.js"></script>
	<%@ include file="/WEB-INF/jsp/cm/CmCommonMsg.jsp" %>
	<!-- jqGrid -->
	<script src="<%=con_root%>/js/jqGrid.4.6/i18n/grid.locale-kr.js" type="text/javascript"></script>
	<script type="text/javascript">
		$.jgrid.no_legacy_api = true;
		$.jgrid.useJSON = true;
	</script>
	<script src="<%=con_root%>/js/jqGrid.4.6/jquery-ui-custom.1.9.2.min.js" type="text/javascript"></script>
	<script src="<%=con_root%>/js/jqGrid.4.6/ui.multiselect.js" type="text/javascript"></script>
	<script src="<%=con_root%>/js/jqGrid.4.6/jquery.jqGrid.min.js" type="text/javascript"></script>
	<!-- jqGrid -->
	
	<!-- com -->
	<script src="<%=con_root%>/js/com.js" type="text/javascript" charset="utf-8"></script>
	<script src="<%=con_root%>/js/com-jquery-fn.js" type="text/javascript" charset="utf-8"></script>
	<script src="<%=con_root%>/js/jquery.print-preview.js" type="text/javascript"></script>	
	
	<!-- jqplot -->
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/jquery.jqplot.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/excanvas.js"></script>
	
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.json2.min.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.cursor.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.barRenderer.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.pieRenderer.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.donutRenderer.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.pointLabels.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.highlighter.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.canvasAxisTickRenderer.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
	<!-- jqplot -->
	
	<!-- jQuery UI 라이브러리 js파일  -->
	<script src="<%=con_root%>/js/jquery-ui-1.10.4.js"></script>
	
	<!-- jQuery UI css 파일  -->
	<link rel="stylesheet" href="<%=con_root%>/js/jquery-ui-1.10.4.css" type="text/css" />
	
	<!-- jQuery colorpicker 파일  -->
	<script type="text/javascript" src="<%=con_root%>/js/colorpicker.js"></script>
	<link rel="stylesheet" media="screen" type="text/css" href="<%=con_root%>/style/cmsadmin/colorpicker.css" />
	<script language="javascript" src="<%=con_root%>/js/calendar.js"></script>
	
	<!-- jqgrid multiselect & multiselectfilter -->
	<script type="text/javascript" src="<%=con_root%>/js/multselect/jquery.multiselect.js" ></script>
	<script type="text/javascript" src="<%=con_root%>/js/multselect/jquery.multiselectfilter.js" ></script>
	<link type="text/css" rel="stylesheet" href="<%=con_root%>/js/multselect/jquery.multiselect.css" />
	
	<!-- jqgrid autoselect -->
	<script type="text/javascript" src="<%=con_root%>/js/autoselect/singleSelect.js"></script>	
	<link type="text/css" rel="stylesheet" href="<%=con_root%>/js/autoselect/singleSelect.css" />
	
	<!-- jstree -->
	<link rel="stylesheet" type="text/css" href="<%=con_root%>/js/jstree/themes/default/style.min.css" />
	<script src="<%=con_root%>/js/jstree/jstree.min.js"></script>
</head>
