<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/cm/include.jsp"%>
<div class="sectionBlue">
	<table class="tbl_type">
		<caption>컨텐츠 관리 목록</caption>
		<colgroup>
			<col width="10%">
			<col width="*">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr id="list_th_obj">
				<th scope="col" style="text-align: center;">번호</th>
				<th scope="col" style="text-align: center;">제목</th>
				<th scope="col" style="text-align: center;">작성자</th>
				<th scope="col" style="text-align: center;">작성일</th>
			</tr>
		</thead>
		<tbody id="list_data_obj">
			<c:choose>
				<c:when test="${fn:length(gongGoList) > 0}">
					<c:forEach items="${gongGoList}" var="gglist" varStatus="i">
						<tr style="cursor: pointer;" onclick="javascript:fn_selectGongGoDetail(<c:out value="${i.index}"/>);">
							<td><c:out value="${i.count}"/></td>
							<td style="text-align: left;"><c:out value="${gglist.dataTitle }"/></td>
							<td><c:out value="${gglist.regNm }"/></td>
							<td><c:out value="${gglist.regDt }"/></td>
						</tr>
						<tr style="display: none;" id="gongGoDetailTarget_<c:out value="${i.index}"/>">
							<td colspan="4" style="padding:0; background:#f7f7f7;">
								<div style="padding:0.5rem; text-align:right;">
									<c:choose>
										<c:when test="${fn:length(gglist.fileList) != 0}">
											<c:forEach var="list" items="${gglist.fileList}" varStatus="status">
												<c:forTokens var="tokens" items="${list.fileNm}" delims="." varStatus="status2">
													<c:if test="${status2.last}">
														<c:set var="fileExt" value="${fn:toLowerCase(tokens)}" />
														<c:choose>
															<c:when test="${fileExt eq 'xls' || fileExt eq 'xlsx'}">
																<c:set var="fileCss" value="excel_file" />
															</c:when>
															<c:when test="${fileExt eq 'pdf'}">
																<c:set var="fileCss" value="pdf" />
															</c:when>
															<c:when test="${fileExt eq 'doc' || fileExt eq 'docs'}">
																<c:set var="fileCss" value="doc" />
															</c:when>
															<c:when test="${fileExt eq 'ppt' || fileExt eq 'ppts' || fileExt eq 'pptx'}">
																<c:set var="fileCss" value="ppt" />
															</c:when>
															<c:when test="${fileExt eq 'hwp'}">
																<c:set var="fileCss" value="hwp" />
															</c:when>	
															<c:when test="${fileExt eq 'gif'}">
																<c:set var="fileCss" value="gif" />
															</c:when>	
															<c:when test="${fileExt eq 'png'}">
																<c:set var="fileCss" value="png" />
															</c:when>	
															<c:when test="${fileExt eq 'jpg'}">
																<c:set var="fileCss" value="jpg" />
															</c:when>
															<c:when test="${fileExt eq 'jpeg'}">
																<c:set var="fileCss" value="jpeg" />
															</c:when>
															<c:when test="${fileExt eq 'txt'}">
																<c:set var="fileCss" value="txt" />
															</c:when>	
															<c:when test="${fileExt eq 'word'}">
																<c:set var="fileCss" value="word" />
															</c:when>	
															<c:when test="${fileExt eq 'zip'}">
																<c:set var="fileCss" value="zip" />
															</c:when>	
															<c:otherwise>
																<c:set var="fileCss" value="none" />
															</c:otherwise>																																																																
														</c:choose>
													</c:if>
												</c:forTokens>
												<a href="javascript:void(0);" class="attachFile <c:out value='${fileCss}'/>" onclick="javascript:fn_fileDownload('<c:out value="${list.fileSeqNo}"/>');" class="attachFile hwp ellipsis" ><c:out value="${list.fileNm}"/></a>
											</c:forEach>
										</c:when>
										<c:otherwise>
											등록된 첨부파일이 없습니다.
										</c:otherwise>
									</c:choose>
								</div>
								<div style="padding:2rem 3rem; margin-bottom:1rem">
									<c:if test="${empty gglist.dataDesc}">-</c:if><span class="title"><c:out escapeXml="false" value="${gglist.dataDesc}" /></span>
								</div>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr><td colspan="4">조회된 데이터가 없습니다.</td></tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<script type="text/javascript">
$(function() {
});

//공고 상세보기
var fn_selectGongGoDetail = function(idx) {
	$("tr[id^='gongGoDetailTarget_']").hide();
	$("#gongGoDetailTarget_"+idx).show();
};
</script>