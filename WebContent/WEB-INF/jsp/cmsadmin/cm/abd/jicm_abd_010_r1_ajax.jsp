<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/cm/include.jsp"%>
<c:choose>
	<c:when test="${fn:length(commentList) > 0}">
		<c:forEach items="${commentList}" var="list" varStatus="i">
			<li>
				<p class="name"><c:out value="${list.regNm }"/></p>
				<p class="date"><c:out value="${list.regDt }"/></p>
				<p class="cts" id="commentView_<c:out value="${i.index}"/>">
					<c:out value="${list.dataDesc }" escapeXml="false"/>
					<span class="fade-in-box" style="cursor: pointer;"> 
						<img src="<c:out value="${imagePath}"/>/common/btn_modify.png" id="repModifyBtn" onclick="javascript:fn_updateBoardReview('<c:out value="${i.index}"/>');">
						<img src="<c:out value="${imagePath}"/>/common/btn_delete.png" id="repModifyBtn" onclick="javascript:fn_deleteBoardReviewProc('<c:out value="${list.dataSeqno}"/>', '<c:out value="${list.dataOriginNo}"/>');">
					</span>
				</p>
				<div id="commentEdit_<c:out value="${i.index}"/>" style="width: 100%; display: none;">
					<div class="comment_input">
						<label for="comment_input"></label>
						<textarea id="cmtSjUpdate_<c:out value="${i.index}"/>" onfocus="checker(this, 200, 'nbytes_update_cmtSj');" onblur="stopchecker();"><c:out value="${list.dataSpaCol9 }" escapeXml="false"/></textarea>
						<span class="max_leng"><em class="count" id="nbytes_update_cmtSj">5</em>/200</span>
						<a href="javascript:void(0);" onclick="javascript:fn_updateBoardReviewCancel('<c:out value="${i.index}"/>');" class="btnBk delRepBtn">취소</a>
						<a href="javascript:void(0);" onclick="javascript:fn_updateBoardReviewProc('<c:out value="${list.dataSeqno}"/>', '<c:out value="${i.index}"/>', '<c:out value="${list.dataOriginNo}"/>');" class="btnBk editRepBtn">수정</a>
					</div>
				</div>
			</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>작성된 답글이 없습니다.</li>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
$(function() {
	$("#commentCntTarget").text('<c:out value="${fn:length(commentList) }"/>');
});

//댓글수정
var fn_updateBoardReview = function(idx) {
	$("#commentView_"+idx).hide();
	$("#commentEdit_"+idx).show();
};

//댓글수정 취소
var fn_updateBoardReviewCancel = function(idx) {
	$("#commentView_"+idx).show();
	$("#commentEdit_"+idx).hide();
};

//댓글수정
var fn_updateBoardReviewProc = function(cmtIdx, idx, dataOriginNo) {
	if (!TypeChecker.required($("#cmtSjUpdate_"+idx).val())) {
		alert("'댓글'은  "+ TypeChecker.requiredText);
		$("#cmtSjUpdate_"+idx).focus();
		return;
	}
	var params = {};
	params.dataSeqno = cmtIdx;
	params.dataDesc = $("#cmtSjUpdate_"+idx).val();
	$.ajax({ 	
		url: "<c:out value='${basePath}'/>/admin/board/updateBoardReviewProc.do",
		type: 'POST',
		dataType : "json",
		data : params,
		error: function(){
			 alert("현재 수정 서비스가 원활하지 않습니다.\n관리자에게 문의주시기 바랍니다.");
			 return;
		},
		success: function(r) {
			alert("수정되었습니다.");
			fn_selectBoardReviewList(dataOriginNo);
		}
	});
};

//댓글 삭제
var fn_deleteBoardReviewProc = function(cmtIdx, dataOriginNo) {
	var params = {};
	params.dataSeqno = cmtIdx;
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({ 	
			url: "<c:out value='${basePath}'/>/admin/board/deleteBoardReviewProc.do",
			type: 'POST',
			dataType : "json",
			data : params,
			error: function(){
				 alert("현재 삭제 서비스가 원활하지 않습니다.\n관리자에게 문의주시기 바랍니다.");
				 return;
			},
			success: function(r) {
				alert("삭제되었습니다.");
				fn_selectBoardReviewList(dataOriginNo);
			}
		});
	}
};
</script>