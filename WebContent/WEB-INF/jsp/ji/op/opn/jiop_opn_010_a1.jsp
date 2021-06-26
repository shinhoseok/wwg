<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jiop_opn_010_a1.jsp
%>

<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<script type="text/javascript" src="<%=con_root%>/smarteditor/js/HuskyEZCreator.js"></script>
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate var="nDate" value="${now}" pattern="yyyyMMdd" />

<form name="dataForm" 	id="dataForm" method="post" enctype="multipart/form-data" onSubmit='return false;' >
<input type="hidden" 		id="scode" 					name="scode"  		value="<%=scode%>" title="사이트코드" />
<input type="hidden" 		id="pcode" 					name="pcode"  		value="<%=pcode%>" title="페이지코드"  />
<input type="hidden" 		id="pstate" 				name="pstate"  		value="<%=pstate%>" title="페이지상태"  />
<input type="hidden" 		id="searchGubun" 				name="searchGubun" 			value="${R_MAP.param.searchGubun}" />
<input type="hidden" 		id="searchValue" 				name="searchValue" 			value="${R_MAP.param.searchValue}" />
	<input type="hidden" 	id="data_seqno" 				name="data_seqno" 			value="${R_MAP.param.data_seqno}"/>
	<input type="hidden" 	id="REG_NM" 					name="REG_NM" 				value="<c:if test="${R_MAP.param.orgREG_NM != null && R_MAP.param.orgREG_NM != ''}">${R_MAP.param.orgREG_NM}</c:if><c:if test="${R_MAP.param.orgREG_NM == '' || R_MAP.param.orgREG_NM == null}">${R_MAP.param.REG_NM}</c:if>"/>
	<input type="hidden" 	id="orgREG_NM" 					name="orgREG_NM" 			value="<c:if test="${R_MAP.param.orgREG_NM != null && R_MAP.param.orgREG_NM != ''}">${R_MAP.param.orgREG_NM}</c:if><c:if test="${R_MAP.param.orgREG_NM == '' || R_MAP.param.orgREG_NM == null}">${R_MAP.param.REG_NM}</c:if>"/>
	<input type="hidden" 	id="orgREG_HP_NO" 				name="orgREG_HP_NO" 		value="${R_MAP.param.REG_HP_NO}"/>
	<input type="hidden" 	id="orgREG_EMAIL" 				name="orgREG_EMAIL" 		value="${R_MAP.param.REG_EMAIL}"/>
 	<input type="hidden" 	id="orgSECRET_NO" 				name="orgSECRET_NO" 		value="${R_MAP.param.SECRET_NO}"/> 
 

                <div class="cts_mid">
                    
                    <div class="board_caution">
                    	<div>
                                <div class="listbg">
                                    <p>자료등록 시 본문 또는 첨부파일에 <em class="red1">개인정보(주민등록번호, 휴대전화번호, 주소 등 개인을 식별할수 있는 정보)</em>가 포함되지 않도록 유의하시기 바라며, 일방적인 주장, 비방, 욕설 등이 포함된
                                       	경우나 본 게시판의 성격에 맞지 않는 글, 개인정보가 포함된 글은 안내문 없이 부분 또는 전체 삭제될 수 있습니다. 개인정보가 포함된 글은 불특정 다수에게 개인정보가 노출되어 악용될 수
                                       	있으며 특히 타인의 <em class="red1">개인정보를 노출한 경우에는 개인정보보호법에 따라 처벌 받을 수 있음</em>을 알려드립니다.
                                    </p>
                                </div>                    	
                    	</div>
					</div>
					
                    <div class="writeArea" >
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 등록-작성자,제목,휴대번호,이메일,소속,내용,첨부파일,비밀번호</caption>
                            <colgroup>
                                <col width="12%">
                                <col width="35%">
                                <col width="15%">
                                <col width="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><label for="REG_NM_STR">작성자</label> <span style="color:red;">*</span></th>
                                    <td colspan="3" id="REG_NM_STR">

                                    </td>
                                </tr>                       
                                                                
                                <tr>
                                    <th><label for="DATA_TITLE">제목</label> <span style="color:red;">*</span></th>
                                    <td colspan="3"><input type="text" id="DATA_TITLE" name="DATA_TITLE" value="" maxlength="300" title="제목" /></td>
                                </tr> 
                                
                                <tr>
                                    <th><label for="REG_HP_NO1">휴대번호</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
											<select id="REG_HP_NO1" name="REG_HP_NO1" style="width:15%;" title="휴대번호 앞자리">
												<c:forEach var="list" items="${R_MAP.m00009List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>
											                                    
                                    		- <input type="text" id="REG_HP_NO2" name="REG_HP_NO2" value="" maxlength="4" title="휴대번호 가온데자리" style="width:10%;IME-MODE:disabled;" onkeyup="inputNum(this);" />
                                    		- <input type="text" id="REG_HP_NO3" name="REG_HP_NO3" value="" maxlength="4" title="휴대번호 끝자리" style="width:10%;IME-MODE:disabled;" onkeyup="inputNum(this);" />
                                    		<input type="hidden" name="REG_HP_NO" id="REG_HP_NO" alt="휴대번호" title="휴대번호" />
                                    </td>
                                </tr>   
                                
                                <tr>
                                    <th><label for="email1">이메일</label> <span style="color:red;">*</span></th>                                
									<td colspan="3">
											<input type="text" name="email1" id="email1" maxlength="30" alt="이메일" title="이메일 아이디 입력" />
											@
											<input type="text" name="email2" id="email2" maxlength="20" alt="이메일" title="이메일 도메인 입력" />
											<select id="email3" name="email3" title="이메일 도메인 선택">
												<c:forEach var="list" items="${R_MAP.m00004List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>
											<input type="hidden" name="REG_EMAIL" id="REG_EMAIL" alt="이메일" title="이메일" />
									</td>
                                </tr> 
                                
                                <tr>
                                    <th><label for="REG_SOSOK">소속</label> <span style="color:red;">*</span></th>
                                    <td colspan="3"><input type="text" id="REG_SOSOK" name="REG_SOSOK" value="" maxlength="150" title="소속" /></td>
                                </tr>                                                                                               
                                                               
                                <tr>
                                    <th><label for="DATA_DESC">내용</label> <span style="color:red;">*</span></th>
                                    <td colspan="3"><textarea style="width:100%;" name="DATA_DESC" id="DATA_DESC" rows="5"></textarea></td>
                                </tr>                                        
                                
                                <tr>
                                    <th ><label for="">첨부파일</label></th>
                                    <td colspan="3">
                                    	<div id="cmfile1"></div>                         
                                    </td>
                                </tr>  
 
		
								<tr id="pwDisplay">
									<th title="비밀번호">비밀번호 <span style="color:red;">*</span></th>
									<td colspan="3">
										<input type="password" name="SECRET_NO" id="SECRET_NO" autocomplete="new-password" maxlength="20" />
										(비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용)
									</td>
								</tr>											                                                                                                                                                                            
                            </tbody>
                        </table>
                                          	
                    </div>
                    
                                                              					
                </div>



				<div class="btnArea">
					<!-- <a href="#" class="btnBL2" id="btn_del" onclick='return false;'>삭제</a>
					<a href="#" class="btnBL2" id="btn_mod" onclick='return false;'>수정</a> -->
					<a href="#" class="btnBK" id="btn_cancel" onclick='return false;'>취소</a>
					<a href="#" class="btnBL2" id="btn_reg" onclick='return false;'>확인</a>
					
				</div>	

</form>

<script type="text/javascript">

var form = document.dataForm;
// TODO : $(function()
$(function(){

	$('#contents').parent('div').addClass('market');

	// email
	$('#email3').val('직접입력');
	$('#email3').change(function(){
		if($('#email3 option:selected').val()=='직접입력'){
			$("#email2").val('');
			$("#email2").prop('readonly', false);
		}else{
			$("#email2").val($('#email3 option:selected').val());
			$("#email2").prop('readonly', true);
		}
	});    

	
		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
		});
		


		
		// 취소
		$("#btn_cancel").click(function(e){
			$("#dataForm").attr("enctype","");
			form.method='post';
			<c:if test="${R_MAP.proposalDtl != null && R_MAP.param.pstate == 'UF'}">
				$("#SECRET_NO").val(nullToDefault($("#orgSECRET_NO").val(), ""));
				form.pstate.value='L2';
			</c:if>
			<c:if test="${R_MAP.proposalDtl == null && R_MAP.param.pstate == 'CF'}">
				form.pstate.value='L';
			</c:if>			
			
			form.action='<c:url value='/cmsmain.do'/>';
			form.submit();
			form.target = "";
		});
		

		// 저장
		$("#btn_reg").click(function(e){
			
			// 입력값 체크
			if(!fn_validation()){ return false; } //validation check
			
						
			if(confirm("저장하시겠습니까?")){
				CmopenpageDisable();
				
				//////////////////////////// 데이터 정리
				
				// 휴대번호
				if(!isEmpty($("#REG_HP_NO1").val()) && !isEmpty($("#REG_HP_NO2").val()) && !isEmpty($("#REG_HP_NO3").val())){
					$("input[name=REG_HP_NO]").val( $("#REG_HP_NO1").val()+"-"+$("#REG_HP_NO2").val()+"-"+$("#REG_HP_NO3").val() );
				}else{
					$("input[name=REG_HP_NO]").val("");
				}
				
	
				
				// 이메일
				if(!isEmpty($("#email1").val()) && !isEmpty($("#email2").val())){
					$("input[name=REG_EMAIL]").val( $("#email1").val()+"@"+$("#email2").val() );
				}else{
					$("input[name=REG_EMAIL]").val("");
				}				
				
				
				var msg_str = "";
				<c:if test="${R_MAP.proposalDtl != null && R_MAP.param.pstate == 'UF'}">
					$("#pstate").val("U");
					msg_str = "수정";
				</c:if>
				<c:if test="${R_MAP.proposalDtl == null && R_MAP.param.pstate == 'CF'}">
					$("#pstate").val("C");
					msg_str = "등록";
				</c:if>
				
				////////////////////////////데이터 정리
				var params = jQuery("#dataForm").serialize();
				
				jQuery("#dataForm").ajaxSubmit({
			    		type: "post",
			            url: "<c:url value='/cmsajax.do'/>",
			            data: params,
			            async: false,
			            dataType:"json",
			            success: function(data){
			            	if(data.result==true){
			                	alert('<c:out value="${gb_page_str}" escapeXml="false" />에 '+msg_str+' 되었습니다.');
			    				<c:if test="${R_MAP.proposalDtl != null && R_MAP.param.pstate == 'UF'}">
			    					pageReload();
								</c:if>
								<c:if test="${R_MAP.proposalDtl == null && R_MAP.param.pstate == 'CF'}">
									$("#btn_cancel").trigger("click");
								</c:if>			                	
			                	
			               	}else{
								if(data.TRS_MSG!=""){
									alert(''+data.TRS_MSG);
								}else{
									alert('<c:out value="${gb_page_str}" escapeXml="false" />에 '+msg_str+'중 오류가 발생했습니다.1');
								}
			            	   CmcloseLoading();
			                }
			             },
					     error:function(request, status, error) {
					    	 CmcloseLoading();
					    	 alert('<c:out value="${gb_page_str}" escapeXml="false" />에 '+msg_str+'중 오류가 발생했습니다.2');
			             }
			    });				

			}
		});
		
		// 수정모드인경우 값을 셋팅한다

		<c:if test="${R_MAP.proposalDtl != null && R_MAP.param.pstate == 'UF'}">
			var di = 0;
			/////////////////////////////////////////////////////////////////////////////////////// 
			//alert("<c:out value='${R_MAP.proposalDtl.reg_nm}'  escapeXml="false"/>");
			$("#REG_NM_STR").html(htmlTextAreaGridBr("<c:out value='${R_MAP.proposalDtl.reg_nm}'  escapeXml="false"/>"));
			
			$("#DATA_TITLE").val(htmlTextAreaGridBr("<c:out value='${R_MAP.proposalDtl.data_title}'  escapeXml="false"/>"));
			
			var REG_HP_NO_str = "<c:out value='${R_MAP.proposalDtl.reg_hp_no}'  escapeXml="false"/>";
			var REG_HP_NO_str_arr = REG_HP_NO_str.split("-");	
			if(REG_HP_NO_str!=""){
				$("#REG_HP_NO1").val(nullToDefault(REG_HP_NO_str_arr[0], ""));
				$("#REG_HP_NO2").val(nullToDefault(REG_HP_NO_str_arr[1], ""));
				$("#REG_HP_NO3").val(nullToDefault(REG_HP_NO_str_arr[2], ""));
				$("#REG_HP_NO").val(nullToDefault(REG_HP_NO_str, ""));
			}
			
			var REG_EMAIL_str = "<c:out value='${R_MAP.proposalDtl.reg_email}'  escapeXml="false"/>";
			var REG_EMAIL_str_arr = REG_EMAIL_str.split("@");
			var email_str_yn = false;
			if(REG_EMAIL_str_arr[0]!=null && REG_EMAIL_str_arr[0]!=undefined && REG_EMAIL_str_arr[0]!=''){
				$("form[name=dataForm]").find("select[name=email3] option").each(function(idx){
					if(this.value==REG_EMAIL_str_arr[1]){
						email_str_yn = true;
					}
				});
				if(email_str_yn==true){
					$("#email1").val(REG_EMAIL_str_arr[0]);
					$("#email2").val(REG_EMAIL_str_arr[1]);
					$("#email3").val(REG_EMAIL_str_arr[1]);
				}else{
					$("#email1").val(REG_EMAIL_str_arr[0]);
					$("#email2").val(REG_EMAIL_str_arr[1]);					
					$("#email3").val("직접입력");
				}
				$("#REG_EMAIL").val(nullToDefault(REG_EMAIL_str, ""));
			}			
			
			$("#REG_SOSOK").val(htmlTextAreaGridBr("<c:out value='${R_MAP.proposalDtl.reg_sosok}'  escapeXml="false"/>"));
			
			$("#DATA_DESC").val(htmlTextAreaGridBr("<c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.proposalDtl.data_desc, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/>"));

			var fileList1_seq = "<c:out value='${R_MAP.proposalDtl.file1_seq}'  escapeXml="false"/>";
			var fileList1_nm = "<c:out value='${R_MAP.proposalDtl.file1_nms}'  escapeXml="false"/>";
			fileList1_seq = fileList1_seq.replace(/::/gi,",");
			fileList1_nm = fileList1_nm.replace(/::/gi,",");	
			
			var file_group1 = getFileHtmlArray(fileList1_seq, fileList1_nm);
			$.fn.cmfile.setfileList("cmfile1", file_group1);				

			
			///////////////////////////////////////////////////////////////////////////////////////						
		</c:if>		
		
		<c:if test="${R_MAP.proposalDtl == null && R_MAP.param.pstate == 'CF'}">
	    	<%
	    	if(SITE_SESSION!=null){
	    		if(!userNm.equals("N")){
	    	%>
	    		$("#REG_NM_STR").html("<c:out value='${R_MAP.userDtl.user_nm}'  escapeXml="false"/>");
	    		
				var REG_HP_NO_str = "<c:out value='${R_MAP.userDtl.user_moblphon}'  escapeXml="false"/>";
				var REG_HP_NO_str_arr = REG_HP_NO_str.split("-");	
				if(REG_HP_NO_str!=""){
					$("#REG_HP_NO1").val(nullToDefault(REG_HP_NO_str_arr[0], ""));
					$("#REG_HP_NO2").val(nullToDefault(REG_HP_NO_str_arr[1], ""));
					$("#REG_HP_NO3").val(nullToDefault(REG_HP_NO_str_arr[2], ""));
					$("#REG_HP_NO").val(nullToDefault(REG_HP_NO_str, ""));
				}
				
				var REG_EMAIL_str = "<c:out value='${R_MAP.userDtl.user_email}'  escapeXml="false"/>";
				var REG_EMAIL_str_arr = REG_EMAIL_str.split("@");
				var email_str_yn = false;
				if(REG_EMAIL_str_arr[0]!=null && REG_EMAIL_str_arr[0]!=undefined && REG_EMAIL_str_arr[0]!=''){
					$("form[name=dataForm]").find("select[name=email3] option").each(function(idx){
						if(this.value==REG_EMAIL_str_arr[1]){
							email_str_yn = true;
						}
					});
					if(email_str_yn==true){
						$("#email1").val(REG_EMAIL_str_arr[0]);
						$("#email2").val(REG_EMAIL_str_arr[1]);
						$("#email3").val(REG_EMAIL_str_arr[1]);
					}else{
						$("#email1").val(REG_EMAIL_str_arr[0]);
						$("#email2").val(REG_EMAIL_str_arr[1]);					
						$("#email3").val("직접입력");
					}
					
				}				
	    	<%
	    		}else{
	    	%>
	    		<c:if test="${R_MAP.param.SITE_AUTH_SESSION == null}">
					alert("본인인증이 해제 되었습니다.");
					$("#btn_cancel").trigger("click");
				</c:if>
				<c:if test="${R_MAP.param.SITE_AUTH_SESSION != null}">
					<c:if test="${R_MAP.param.SITE_AUTH_SESSION.sName != null}">
					
						$("#REG_NM_STR").html("<c:out value="${R_MAP.param.SITE_AUTH_SESSION.sName}" />");
						var REG_HP_NO_str = "<c:out value="${R_MAP.param.SITE_AUTH_SESSION.sMobileNo}" />";
						var REG_HP_NO_str_arr = new Array();
						if(REG_HP_NO_str.length==11){
							REG_HP_NO_str_arr[0] = REG_HP_NO_str.substring(0,3);
							REG_HP_NO_str_arr[1] = REG_HP_NO_str.substring(3,7);
							REG_HP_NO_str_arr[2] = REG_HP_NO_str.substring(7,11);
						}else if(REG_HP_NO_str.length()==10){
							REG_HP_NO_str_arr[0] = REG_HP_NO_str.substring(0,3);
							REG_HP_NO_str_arr[1] = REG_HP_NO_str.substring(3,6);
							REG_HP_NO_str_arr[2] = REG_HP_NO_str.substring(6,10);
						}else{
							REG_HP_NO_str_arr[0] = "010";
							REG_HP_NO_str_arr[1] = "";
							REG_HP_NO_str_arr[2] = "";
						}
						if(REG_HP_NO_str!=""){
							$("#REG_HP_NO1").val(nullToDefault(REG_HP_NO_str_arr[0], ""));
							$("#REG_HP_NO2").val(nullToDefault(REG_HP_NO_str_arr[1], ""));
							$("#REG_HP_NO3").val(nullToDefault(REG_HP_NO_str_arr[2], ""));
							$("#REG_HP_NO").val(nullToDefault(REG_HP_NO_str, ""));
						}
						
					
					</c:if>
					<c:if test="${R_MAP.param.SITE_AUTH_SESSION.sName == null}">
	    				alert("본인인증이 해제 되었습니다.");
	    				$("#btn_cancel").trigger("click");
					</c:if>
				</c:if>	    	
	    	<%
	    		}
	    	}else{
	    	%>
	    		<c:if test="${R_MAP.param.SITE_AUTH_SESSION == null}">
	    			alert("본인인증이 해제 되었습니다.");
	    			$("#btn_cancel").trigger("click");
	    		</c:if>
	    		<c:if test="${R_MAP.param.SITE_AUTH_SESSION != null}">
	    			<c:if test="${R_MAP.param.SITE_AUTH_SESSION.sName != null}">
	    			
	    				$("#REG_NM_STR").html("<c:out value="${R_MAP.param.SITE_AUTH_SESSION.sName}" />");
						$("#REG_NM_STR").html("<c:out value="${R_MAP.param.SITE_AUTH_SESSION.sName}" />");
						var REG_HP_NO_str = "<c:out value="${R_MAP.param.SITE_AUTH_SESSION.sMobileNo}" />";
						var REG_HP_NO_str_arr = REG_HP_NO_str.split("-");	
						if(REG_HP_NO_str!=""){
							$("#REG_HP_NO1").val(nullToDefault(REG_HP_NO_str_arr[0], ""));
							$("#REG_HP_NO2").val(nullToDefault(REG_HP_NO_str_arr[1], ""));
							$("#REG_HP_NO3").val(nullToDefault(REG_HP_NO_str_arr[2], ""));
							$("#REG_HP_NO").val(nullToDefault(REG_HP_NO_str, ""));
						}	    				
	    			</c:if>
	    			<c:if test="${R_MAP.param.SITE_AUTH_SESSION.sName == null}">
		    			alert("본인인증이 해제 되었습니다.");
		    			$("#btn_cancel").trigger("click");
	    			</c:if>
	    		</c:if>
		    <%
    		}
    		%>	    				
		</c:if>	
});

	
	function fn_validation(){
		/////////////////////////////////////////////////////////////////////////////////////// 기업소개  
		if(isEmpty($("#DATA_TITLE").val())){
			alert("제목을 입력해주세요.");
			$('#DATA_TITLE').focus();
			return false;
		}else{
			if(getLength($('#DATA_TITLE').val()) > 300) {
				alert("제목은 300 Byte 이하이어야 합니다.");
				$("#DATA_TITLE").focus();
				return false;
			}					
		}		
		
		if(isEmpty($("#REG_HP_NO1").val())){
			alert("휴대번호 첫자리를 입력해주세요.");
			$('#REG_HP_NO1').focus();
			return false;
		}else if(isEmpty($("#REG_HP_NO2").val())){
			alert("휴대번호 중간자리를 입력해주세요.");
			$('#REG_HP_NO2').focus();
			return false;
		}else if(isEmpty($("#REG_HP_NO3").val())){
			alert("휴대번호 끝자리를 입력해주세요.");
			$('#REG_HP_NO3').focus();
			return false;
		}else{
			if(getLength($("#REG_HP_NO1").val()+"-"+$("#REG_HP_NO2").val()+"-"+$("#REG_HP_NO3").val()) > 50) {
				alert("휴대번호는 50 Byte 이하이어야 합니다.");
				$("#REG_HP_NO1").focus();
				return false;
			}
			
			
		}
		
		if(isEmpty($("#email1").val())){
			alert("이메일 아이디를 입력해주세요.");
			$('#email1').focus();
			return false;
		}else if(isEmpty($("#email2").val())){
			alert("이메일 도메인을 입력해주세요.");
			$('#email2').focus();
			return false;
		}else{
			if(getLength($('#email1').val()+"@"+$('#email2').val()) > 120) {
				alert("이메일은 120 Byte 이하이어야 합니다.");
				$("#email1").focus();
				return false;
			}
			
			if(isMail($('#email1').val()+"@"+$('#email2').val())){
				alert("이메일주소가 유효하지 않습니다.");
				$("#email1").focus();
				return false;				
			}
		}	
		
		if(isEmpty($("#REG_SOSOK").val())){
			alert("소속을 입력해주세요.");
			$('#REG_SOSOK').focus();
			return false;
		}else{
			if(getLength($('#REG_SOSOK').val()) > 150) {
				alert("소속은 150 Byte 이하이어야 합니다.");
				$("#REG_SOSOK").focus();
				return false;
			}					
		}
		
		if(isEmpty($("#DATA_DESC").val())){
			alert("내용을 입력해주세요.");
			$('#DATA_DESC').focus();
			return false;
		}else{
			if(getLength($('#DATA_DESC').val()) > 10000) {
				alert("소속은 10000 Byte 이하이어야 합니다.");
				$("#DATA_DESC").focus();
				return false;
			}					
		}
		
		// 첨부파일은 필수아님
		/*
		if($.fn.cmfile.getfilelistcnt("cmfile1")==0){
			alert("상품이미지 파일이 1개이상 등록되어야 합니다");
			
			return false;
		}
		*/
		
		if(isEmpty($("input[name=SECRET_NO]").val())){
			alert("패스워드을 입력해주세요.");
			$("input[name=SECRET_NO]").focus();
			return false;
		}else{
			// 비밀번호가 입력되어있을경우 비밀번호를 체크한다
			if(!isEmpty($('input[name=SECRET_NO]').val()) ){
				if($('input[name=SECRET_NO]').val().length < 9 || $('input[name=SECRET_NO]').val().length > 20){
					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
					$('input[name=SECRET_NO]').focus();
					return;
				}
				
				if(!$('input[name=SECRET_NO]').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
					$('input[name=SECRET_NO]').focus();
					return;
				}				
			}			
			/*if($("input[name=SECRET_NO]").val().length != 4 ){
				alert('비밀번호는 숫자4자리로 입력해주세요.');
				$("input[name=SECRET_NO]").focus();
				return false;
			}*/
		}		
		
/////////////////////////////////////////////////////////////////////////////////////// 

		return true;
	}
	

	// 파일정보를 가지고 파일객체 셋팅하는 문자열생성
	function getFileHtmlArray(file_seqno, file_nm) {
		 var rtn_str = "";
			var file_seqno_sp = new Array();
			var file_nm_sp = new Array();
			var tmp_arr = {};
			var rtn_arr = new Array();
			var fi = 0;
			if(file_seqno!=""){
				rtn_str = "[";
				file_seqno_sp = file_seqno.split(",");
				file_nm_sp = file_nm.split(",");
				for(fi=0;fi<file_seqno_sp.length;fi++){
					rtn_str += "{";
					rtn_str += "file_seqno";
					rtn_str += ":";
					rtn_str += "\""+file_seqno_sp[fi]+"\"";
					rtn_str += ",";
					rtn_str += "file_nm";
					rtn_str += ":";
					rtn_str += "\""+file_nm_sp[fi]+"\"";
					rtn_str += "}";
					
					tmp_arr = {};
					tmp_arr['file_seqno'] = file_seqno_sp[fi];
					tmp_arr['file_nm'] = file_nm_sp[fi];
					
					rtn_arr.push(tmp_arr); 
					if(fi< file_seqno_sp.length-1){
						rtn_str += ",";
					}
				}
				rtn_str += "]";
			}
		

		 //return rtn_str;
		 return rtn_arr;
	}
	
	// 파일다운로드
	function pageReload(){
		$("#dataForm").attr("enctype","");
		form.method='post';
		form.pstate.value='UF';
		form.action='<c:url value='/cmsmain.do'/>';
		form.submit();
		form.target = "";
	}	
	
</script>

