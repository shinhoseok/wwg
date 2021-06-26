<%--
/*=================================================================================*/
/* 시스템            : 
/* 프로그램 아이디   : 
/* 프로그램 이름     : 
/* 소스파일 이름     : 
/* 설명              : 
/* 버전              : 1.0.0
/* 최초 작성자       : jhlee
/* 최초 작성일자     : 2014-10-00
/* 최근 수정자       : 
/* 최근 수정일시     : 2014-10-00
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<table border="1" width="100%" height="100%" >
	<tr>
		<td colspan="${fn:length(fn:split(colNames, ','))}">엑셀다운 jsp 별도지정 테스트</td>
	</tr>
</table>

<!-- //시작 -->
<table border="1" width="100%" height="100%" >
	<%-- <colgroup>
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="20%" />
	</colgroup> --%>
	
	<tr>
		<c:forEach var="col" items="${fn:split(colNames, ',')}" begin="0" varStatus="item">	
			<td align="center" style="background-color:#efefef">${col}</td>
		</c:forEach>
	</tr>
	
	<fmt:parseNumber var="_page" integerOnly="true" type="number" value="${param['jqGrid.page']}" />
	<fmt:parseNumber var="_rows" integerOnly="true" type="number" value="${param['jqGrid.rows']}" />
              
	<c:forEach var="row" items="${R_MAP.rows}" begin="0" varStatus="rowItem">
		<tr>
			<c:forEach var="col" items="${fn:split(colId, ',')}" begin="0" varStatus="colItem">
				<td>${ (col eq 'rn') ? (((_page-1)*_rows)+rowItem.index+1) : row[col] }</td>
			</c:forEach>
		</tr>
	</c:forEach>
    
</table>
<!-- //종료 -->

