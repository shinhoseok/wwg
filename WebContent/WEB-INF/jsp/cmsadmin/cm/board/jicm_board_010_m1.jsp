<%@page pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/cm/include.jsp"%>

<c:choose>
	<c:when test="${pstate eq 'L'}">
		<%@include file="/WEB-INF/jsp/cmsadmin/cm/board/jicm_board_010_s1.jsp"%>
	</c:when>
</c:choose>