
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% response.setStatus(HttpServletResponse.SC_OK); %>
<%-- <jsp:directive.include file="/WEB-INF/jsp/cmmn/incTagLib.jsp"/> --%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>-  오류페이지 -</title>
<!-- <link rel="stylesheet" type="text/css" href="/common/css/cm.import.css"> -->
<link rel="stylesheet" type="text/css" href="./css/cm.layout.css">
<link rel="stylesheet" type="text/css" href="./css/cm.reset.css">

<!-- <script type="text/javascript" src="/publish/com/js/jquery-1.11.1.min.js"></script> -->
<!-- <script type="text/javascript" src="/publish/com/js/cm.jQuery.design.js"></script> -->
<!-- <script type="text/javascript" src="/publish/com/js/cm.jQuery.ui.js"></script> -->
<!--[if lt IE 9]>
<script src="/publish/com/js/html5shiv.min.js">
<script src="/publish/com/js/html5shiv-printshiv.min.js">
</script>
<![endif]-->
</head>

<body>
	<div id="error_wrap">
		<div id="container">
			<div class="cont">
				<strong>서비스 이용에 불편을 드려 죄송합니다.<br>요청하신 페이지를 찾을 수 없습니다.</strong>
				<p>찾으시는 페이지의 주소가 잘못되었거나, 페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다. <br>
				입력하신 페이지의 주소가 정확한 지 다시 한번 확인해 주시기 바랍니다.</p>
				<div class="btnWrap">
					<a href="#" onclick="javascript:history.back();" class="btn deny"><span>이전페이지로 가기</span></a>
					<a href="/KomipoWwg/cmsmain.do" class="btn default"><span>홈으로 가기</span></a>
				</div>
			</div>
		</div><!--// container div e -->
		<!--// 본문영역 e -->
	</div><!-- //wrap -->
</body>
</html>
