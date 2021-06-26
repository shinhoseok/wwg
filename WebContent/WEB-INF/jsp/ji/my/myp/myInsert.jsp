<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동반성장오픈플랫폼</title>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="rootPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<c:set var="basePath" value="${rootPath}${path}"/>
<script type="text/javascript" src="${basePath}/js/jquery-1.12.4.min.js"></script>
</head>
<body>
<form id="insertForm" name="insertForm" action="${basePath}/mypage/insertBiz.do" enctype="multipart/form-data" method="post" >
파일업로드 : <input type="file" name="molFile" id="molFile">
<br/><br/>
<button type="button" onclick="javascript:fn_insertCareerApplyProc();">영문파일명으로 전송</button>
</form>
<script type="text/javascript">
$(function() {
	var result = "${result}";
	if(result == 'Y') {
		alert("완료");
	} else {
	}
});
var fn_insertCareerApplyProc = function() {
	var frm = document.insertForm;
	frm.submit();
};

</script>
</body>
</html>