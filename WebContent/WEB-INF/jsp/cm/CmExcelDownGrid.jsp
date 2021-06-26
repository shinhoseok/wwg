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


<!-- //시작 -->
<table border="1" width="100%" height="100%" >
	<%-- <colgroup>
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="20%" />
	</colgroup> --%>
	<!-- 엑셀 타이틀 추가 mrkim (2015-07-03) -->
	<tr style="height: 50px;">
		<td  colspan="${fn:length(fn:split(colNames, ','))}" align="center"  style="text-align: left;"><strong>${excelFileName}</strong></td>
	</tr>
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
				<td style="mso-number-format:'\@'">${ (col eq 'rn') ? (((_page-1)*_rows)+rowItem.index+1) : row[col] }</td>
			</c:forEach>
		</tr>
	</c:forEach>
    
</table>
<!-- //종료 -->

