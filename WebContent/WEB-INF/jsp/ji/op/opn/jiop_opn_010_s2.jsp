<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_010_s2.jsp
%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode" 				name="scode" 	value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 	value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 	value="<%=pstate %>" />
<input type="hidden" 	id="page" 				name="page" 	value="${R_MAP.param.page}"/>


                <div class="cts_mid">
                    <div class="prg">
                        <h4 class="titleM"><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replaceAll("&amp;amp;","&")%> 접수 확인</h4>
                    	<div class="prg firstPrg">
                       		<p>입력하신 접수 내용을 확인 하실 수 있습니다.작성자의 이름, 연락처, 비밀번호를 정확히 입력해 주시기 바랍니다.</p>
                    	</div>
                    </div>
                    <div class="writeArea" >
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replaceAll("&amp;amp;","&")%> 접수 확인 - 이름, 휴대폰번호, 이메일, 비밀번호로 구성</caption>
                            <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><label for="REG_NM">이름</label> <span style="color:red;">*</span></th>
                                    <td colspan="3" ><input type="text" id="REG_NM" name="REG_NM" value="" maxlength="30" title="제목 *" />

                                    </td>
                                </tr>                       
                                
                                <tr>
                                    <th><label for="REG_HP_NO1">휴대번호</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
											<select id="REG_HP_NO1" name="REG_HP_NO1" style="width:15%;" title="휴대번호 앞자리 *">
												<c:forEach var="list" items="${R_MAP.m00009List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>
											                                    
                                    		- <input type="text" id="REG_HP_NO2" name="REG_HP_NO2" value="" maxlength="4" title="휴대번호 가온데자리 *" style="width:10%;IME-MODE:disabled;" onkeyup="inputNum(this);" />
                                    		- <input type="text" id="REG_HP_NO3" name="REG_HP_NO3" value="" maxlength="4" title="휴대번호 끝자리 *" style="width:10%;IME-MODE:disabled;" onkeyup="inputNum(this);" />
                                    		<input type="hidden" name="REG_HP_NO" id="REG_HP_NO" alt="휴대번호" title="휴대번호" />
                                    </td>
                                </tr>   
                                
                                <tr>
                                    <th><label for="email1">이메일</label> <span style="color:red;">*</span></th>                                
									<td colspan="3">
											<input type="text" name="email1" id="email1" maxlength="30" alt="이메일 *" title="이메일 아이디 입력 *" />
											@
											<input type="text" name="email2" id="email2" maxlength="20" alt="이메일 *" title="이메일 도메인 입력 *" />
											<select id="email3" name="email3" title="이메일 도메인 선택">
												<c:forEach var="list" items="${R_MAP.m00004List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>
											<input type="hidden" name="REG_EMAIL" id="REG_EMAIL" alt="이메일 *" title="이메일 *" />
									</td>
                                </tr> 
                                		
								<tr id="pwDisplay">
									<th title="비밀번호">비밀번호 <span style="color:red;">*</span></th>
									<td colspan="3">
										<input type="password" name="SECRET_NO" id="SECRET_NO" autocomplete="new-password" maxlength="20" />
									</td>
								</tr>											                                                                                                                                                                            
                            </tbody>
                        </table>
                                          	
                    </div>
                    
					<div class="btnArea">
						<!-- <a href="#" class="btnBL2" id="btn_del" onclick='return false;'>삭제</a>
						<a href="#" class="btnBL2" id="btn_mod" onclick='return false;'>수정</a> -->
						<a href="#" class="btnBK" id="btn_cancel" onclick='return false;'>취소</a>
						<a href="#" class="btnBL2" id="btn_reg" onclick='return false;'>확인</a>
						
					</div>                    

                </div>


</form>

	

<script type="text/javascript">
//<![CDATA[
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
		
		// 취소
		$("#btn_cancel").click(function(e){

			document.dataForm.method='post';
			document.dataForm.pstate.value='L';
		
			
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();
			document.dataForm.target = "";
		});		
		
		$("#btn_reg").click( function() {
			//alert("임시오픈중에는 등록이 안됩니다.");
			//return;			
			// 입력값 체크
			if(!fn_validation()){ return false; } //validation check
			
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
			
			$("#pstate").val("XL1");
			msg_str = "접수 확인";			
			
		
			////////////////////////////데이터 정리
			var params = jQuery("#dataForm").serialize();
			
				$.ajax({
			        type: "post",
			        url: "<c:url value='/cmsajax.do'/>",
			        data: params,
			        async: false,
			        dataType:"json",
		            success: function(data){
		            	if(data.result==true){
		                	//console.log(data.chkDtl);
		                	//return;
		                	if(data.chkDtl.chk_cnt <= 0){
		                		alert("입력하신 정보와 일치하는 접수내역이 없습니다. 입력항목을 확인해주세요");
		                		CmcloseLoading();
		                		return false;
		                	}else{
		                		fnChkList();
		                	}
		                	
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

		});
			
	
	});
		
	
	function fn_validation(){
		/////////////////////////////////////////////////////////////////////////////////////// 기업소개  
		if(isEmpty($("#REG_NM").val())){
			alert("이름을 입력해주세요.");
			$('#REG_NM').focus();
			return false;
		}else{
			if(getLength($('#REG_NM').val()) > 300) {
				alert("이름은 30 Byte 이하이어야 합니다.");
				$("#REG_NM").focus();
				return false;
			}					
		}		
		
		if(isEmpty($("#REG_HP_NO1").val())){
			alert("휴대번호 앞자리를 입력해주세요.");
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
		
		return true;
	}
	
	// 접수 확인 리스트 화면
	var fnChkList = function(){
		
		su_form = document.dataForm;
		
		$("#pstate").val("L2");
		
		//alert(displayView+"------"+mng_sttus_cd+"------"+su_form.pstate.value);
		su_form.method = 'post';
		su_form.action = '<%=RequestURL%>';
		su_form.submit();
		su_form.target = "";
	};	
//]]>
</script>
