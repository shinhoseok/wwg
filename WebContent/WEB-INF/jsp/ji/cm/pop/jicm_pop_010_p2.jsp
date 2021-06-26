<%@page pageEncoding="utf-8"%>
<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.net.URLDecoder" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cm/S01/Cmheader.jsp"%><!-- 공통 jsp 파일-->

<div id="popupDiv" style="padding:20px; width:500px;">
<form name="dataForm" id="dataForm" method="post" onSubmit='return false;'>
	<input type="hidden" id="scode"  name="scode" value="<c:out value='${R_MAP.param.scode}'/>" />
	<input type="hidden" id="pcode"	 name="pcode" value="<c:out value='${R_MAP.param.pcode}'/>" />
	<input type="hidden" id="pstate" name="pstate" />
	<!-- 화면명 -->
	<input type="hidden" id="pageStatus" name="pageStatus" value="<c:out value='${R_MAP.param.pageStatus}'/>" />
	<!-- 게시글 Key -->
	<input type="hidden" id="paramSn"        name="paramSn"	value="<c:out value='${R_MAP.param.paramSn}'/>" />
	<input type="hidden" id="ifrm_requst_sn" name="ifrm_requst_sn" /><!-- 맞춤데이터키값 -->
	<input type="hidden" id="ifrn_scrty_passwd"	name="ifrn_scrty_passwd" />
	<input type="hidden" id="anals_infr_sn"  name="anals_infr_sn" value="<c:out value='${R_MAP.param.anals_infr_sn}'/>" /><!-- 분석인프라키값 -->
	<input type="hidden" id="idea_propse_sn" name="idea_propse_sn" value="<c:out value='${R_MAP.param.idea_propse_sn}'/>" /><!-- 오픈포탈키값 -->
	
	<h5 class="main_title">비밀번호 입력</h5>
	
    <!--board_A0_list-->
    <div class="board_A0_L">
		<table summary="비밀번호 입력 팝업 창입니다.">
			<caption>비밀번호 - 비밀번호로 구성</caption>
			<tbody>
				<tr>
					<th scope="col">비밀번호</th>
				</tr>
				<tr>
					<td scope="col">
						<input type="password" class="input_type01 w_100" name="password" id="password" maxlength="100" />
					</td>
				</tr>
            </tbody>
        </table>
    </div>
    <!--//board_A0_list-->
    
	<!--button-->
	<div class="button a_c mat_30">
	    <a href="#none" id="btn_confirm" class="btn_1 size_s">확인</a>
	</div>
    <!--//button-->
</form>
</div>
<!-- 사용테이블 팝업 END -->

<script type="text/javascript">

	$(function(){
		
		$("#btn_confirm").click(function(e){
		
			if ($("#password").val()=="") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			$("input[name=scode]").val($(opener.document).find("#scode").val());
			
			// 맞춤데이터제공
			if ($("input[name=pageStatus]").val() == 'out') {
				
				$("input[name=pcode]").val("000071");
				$("input[name=pstate]").val("PW");
				$("input[name=ifrn_scrty_passwd]").val($("input[name=password]").val());
				$("input[name=ifrm_requst_sn]").val($("input[name=paramSn]").val());
				
			}
			// 분석인프라신청
			else if ($("input[name=pageStatus]").val() == 'inf') {
				$("input[name=pcode]").val("000117");
				$("input[name=pstate]").val("passwdVdChkL");
			}
			// 오픈포탈
			else if ($("input[name=pageStatus]").val() == 'open') {
				$("input[name=pcode]").val("000401");
				$("input[name=pstate]").val("PASSCHK");
				$("input[name=idea_propse_sn]").val($("input[name=paramSn]").val());
			}
			
			var params = jQuery("#dataForm").serialize();
			CmopenLoading();
			
			$.ajax({ type     : "post"
				   , url      : "/cmsajax.do"
				   , data     : params
				   , async    : false
				   , dataType :"json"
				   , timeout  : 3000
				   , error    : function (jqXHR, textStatus, errorThrown) {
							        // 통신에 에러가 있을경우 처리할 내용(생략가능)
								    alert("네트웍장애가 발생했습니다. 다시시도해주세요");
								    CmcloseLoading();            
				   }			             
				   , success  : function(data){
							        if (data.result) {
							      	    $(opener.location).attr("href", "javascript:${R_MAP.param.callbackFnc}(" + $("input[name=paramSn]").val() + ");");
							      	    window.close();
							        } else {
							      	    alert(data.TRS_MSG);
							        }
				   }
			});
		});
	});
	
</script>