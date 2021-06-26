<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>동반성장 오픈플랫폼</title>
</head>
<body>
<%
	String message = (String) request.getAttribute("message");
	String redirectUrl = (String) request.getAttribute("redirectUrl");
%>
<script>
	alert("<%=message%>");
	window.location.href = "${basePath}<%=redirectUrl%>";
</script>
</body>
</html>