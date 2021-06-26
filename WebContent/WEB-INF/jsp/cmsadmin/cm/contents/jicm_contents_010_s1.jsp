<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/acs/jicm_acs_010_s1.jsp
/* 프로그램 이름     : jicm_acs_010_s1  
/* 소스파일 이름     : jicm_acs_010_s1.jsp
/* 설명              : SYSTEM 접근아이피관리 목록페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-03
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-03
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/cm/include.jsp"%>
<script language="javascript" src="${basePath}/js/com-file.js"></script>
<%@ taglib prefix="comTag" uri="/WEB-INF/tld/comTag.xml"%>
<script type="text/javascript" src="${basePath}/js/jquery.form.min.js" charset="utf-8"></script>
<script src="${basePath}/js/jquery-ui.js" type="text/javascript"></script>
<style>
.paging {
	text-align: center;
	margin-top: 40px;
}

.paging a {
	display: inline-block;
	padding: 0 9px;
}

.paging a.page_on {
	color: #fff;
	background: #1e8dde;
	padding: 2px 7.5px 3px 7.5px;
	margin-right: 3px;
}

.paging button {
	font-size: 0;
	line-height: 0;
	width: 11px;
	height: 18px;
	display: inline-block;
	vertical-align: top;
}

.paging button.first {
	background: url(/images/common/common_bg.png) -551px -183px no-repeat;
}

.paging button.prev {
	background: url(/images/common/common_bg.png) -453px -245px no-repeat;
	width: 7px;
	margin-left: 15px;
	margin-right: 20px;
}

.paging button.next {
	background: url(/images/common/common_bg.png) -453px -252px no-repeat;
	transform: rotate(180deg);
	width: 7px;
	margin-left: 20px;
}

.paging button.last {
	background: url(/images/common/common_bg.png) -551px -190px no-repeat;
	transform: rotate(180deg);
	margin-left: 15px;
}
</style>

<div class="cts_mid">
	<div class="searchArea">
		<form action="<c:out value='${basePath}'/>/cmsmain.do" id="listfrm" name="listfrm" method="post">
			<input type="hidden"	id="scode"		name="scode"		value="<c:out value="${scode}"/>" />
			<input type="hidden"	id="pcode"		name="pcode"		value="<c:out value="${pcode}"/>" />
			<input type="hidden"	id="pstate"		name="pstate"		value="<c:out value="${pstate}"/>" />
			<input type="hidden" 	id="pageIndex"  name="pageIndex"	value="<c:out value="${R_MAP.param.pageIndex}"/>" title="현재페이지번호"  />
			<div class="formInner" style="text-align: right;">
				메뉴명 검색&nbsp;&nbsp;
				<input type="text" name="searchValue" id="searchValue" value="" title="검색어 입력" onkeydown="if(event.keyCode==13){javascript:fn_searchList(1);}">
				<span class="btn_pack large" style="margin-top: 2px;"><a href="#" onclick="javascript:fn_searchList(1);">검색</a></span>
			</div>
		</form>
	</div>

	<div class="sectionBlue">
		<table class="tbl_type">
			<caption>컨텐츠 관리 목록</caption>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="*">
				<col width="15%">
			</colgroup>
			<thead>
				<tr id="list_th_obj">
					<th scope="col" style="text-align: center;">번호</th>
					<th scope="col" style="text-align: center;">메뉴코드</th>
					<th scope="col" style="text-align: center;">메뉴명</th>
					<th scope="col" style="text-align: center;">등록일</th>
				</tr>
			</thead>
			<tbody id="list_data_obj">
				<c:choose>
					<c:when test="${R_MAP.selectListCnt > 0}">
						<c:forEach items="${R_MAP.selectList}" varStatus="i" var="list">
							<tr style="cursor: pointer;" onclick="javascript:fn_selectContentsMngDetail('<c:out value="${list.menuCd }"/>');">
								<td><c:out value="${list.rNum }"/></td>
								<td><c:out value="${list.menuCd }"/></td>
								<td style="text-align: left;"><c:out value="${list.menuNm }"/></td>
								<td><c:out value="${list.regDt }"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr><td colspan="4">등록된 컨텐츠가 없습니다.</td></tr>
					</c:otherwise>
				</c:choose>
				
			</tbody>
		</table>
	</div>
	<div class="paging">
		<c:if test="${R_MAP.selectListCnt > 0}">
			<comTag:paging totalCount="${fn:escapeXml(R_MAP.selectListCnt)}" pageNo="${fn:escapeXml(R_MAP.param.pageIndex)}" pageSize="${fn:escapeXml(R_MAP.param.pageSize)}" clickPage="fn_searchList"/>
		</c:if>
	</div>
</div>

<script>
fn_selectContentsMngDetail = function(menuCd) {
	location.href = "${basePath}/cmsmain.do?scode=sysadm&pcode="+menuCd;
};

//글등록처리페이지이동
var fn_searchList = function(pageNo) {
	var frm = document.listfrm;
	frm.pageIndex.value=pageNo;
	frm.submit();
};
</script>