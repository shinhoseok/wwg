<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_010_a11.jsp
%>
<style type="text/css">
.squareList ul li{width: 27%;margin-right:4%;box-sizing:border-box;border-radius: 9px;position: relative;padding:14px 20px;}
.squareList ul li:nth-child(3):after{background:none;}
.squareList ul li:nth-child(3){width: 34%;}
.textArea{border:1px solid #ccc;height: 250px;overflow-x:hidden;overflow-y: scroll;font-size:15px;line-height: 24px;padding:20px;box-sizing: border-box;}
.btnArea a{width:210px;height: 50px;line-height: 48px;font-size:16px;display: inline-block;}
.btnArea{text-align: center;}
</style>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode" 				name="scode" 	value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 	value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 	value="<%=pstate %>" />
<input type="hidden" 	id="page" 				name="page" 	value="${R_MAP.param.page}"/>
<input type="hidden" 	id="othbc_yn" 			name="othbc_yn" />


                <div class="cts_mid">
                    <div class="prg">
                        <h4 class="titleM">제안절차</h4>
                        <div class="border_p">
                            <div class="squareList">
                                <ul>
                                    <li class="f_left">
                                        <em>01</em>
                                        <div class="inner">
                                            <p style="font-weight:600;">개인정보수집 및 이용동의</p>
                                            <span></span>
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <em>02</em>
                                        <div class="inner">
                                            <p>본인인증</p>
                                            <span></span>
                                        </div>
                                    </li>
                                    <li class="f_left" >
                                        <em>03</em>
                                        <div class="inner">
                                            <p><c:out value="${gb_page_str}" /> 작성</p>
                                            <span></span>
                                        </div>
                                    </li>
                                 </ul>
                            </div>
                        </div>
                    </div>
                
                    <div class="prg">
                    	<!-- 지원사업 아이디어 제안센터 -->
                        <h4 class="titleM">개인정보이용자 동의사항</h4>
                         <div  class="textArea">
							<p style="padding-left: 15px; text-indent:-15px; font-size:16px; font-family: 맑은 고딕, 돋음, dotnum, sans-serif, Tahoma; color :#4d4d4d; line-height : 1.6; letter-spacing: -1px; -webkit-text-size-adjust : none;  ">
								개인정보보호를 위한 이용자 동의사항(자세한 내용은 개인정보처리방침을 확인하시기 바랍니다.)
							</p><br />
							<ul class="numList">
								<li style="padding-left: 15px; text-indent:-15px; font-size:16px; font-family: 맑은 고딕, 돋음, dotnum, sans-serif, Tahoma; color :#4d4d4d; line-height : 1.6; letter-spacing: -1px; -webkit-text-size-adjust : none;  ">
									1. 개인정보의 수집 · 이용목적<br />
									<span style="color: rgb(0, 121, 191); font-size: 20px; font-weight: bold;">
										- 정보주체 확인 및 요청처리
									</span>
								</li><br />
								<li style="padding-left: 15px; text-indent:-15px; font-size:16px; font-family: 맑은 고딕, 돋음, dotnum, sans-serif, Tahoma; color :#4d4d4d; line-height : 1.6; letter-spacing: -1px; -webkit-text-size-adjust : none;  ">
									2. 수집하는 개인정보의 항목<br />
									<span style="color: rgb(0, 121, 191); font-size: 20px; font-weight: bold;">
										- 성명, 휴대번호, 이메일, 비밀번호, 소속
									</span>
								</li><br />
								<li style="padding-left: 15px; text-indent:-15px; font-size:16px; font-family: 맑은 고딕, 돋음, dotnum, sans-serif, Tahoma; color :#4d4d4d; line-height : 1.6; letter-spacing: -1px; -webkit-text-size-adjust : none;  ">
									3. 개인정보의 보유 및 이용기간<br />
									<span style="color: rgb(0, 121, 191); font-size: 20px; font-weight: bold;">
										- 보유기간:1년 <br />
										- 관련근거:정보주체의 동의
									</span>
								</li><br />
								<li style="padding-left: 15px; text-indent:-15px; font-size:16px; font-family: 맑은 고딕, 돋음, dotnum, sans-serif, Tahoma; color :#4d4d4d; line-height : 1.6; letter-spacing: -1px; -webkit-text-size-adjust : none;  ">
									4. 동의를 거부할 권리 및 동의 거부에 따른 안내 <br/>
                               		- 귀하는 본 안내에 따른 개인정보 수집에 대하여 거부하실 수 있는 권리가 있습니다.<br />
                               		- 본 개인정보 수집에 대하여 거부하시는 경우, 당사의 <%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replace("amp;","")%> 서비스를 이용하실 수 없습니다.
								</li>
							</ul>
						</div>
                        <div class="agree">
                            <p>위 내용에 동의하십니까 ?</p>
                            <div class="radioBox">
                                <input type="radio" name="agree_1" id="agree_1" value="Y" class="radioInput"><label for="agree_1">동의함</label>
                                <input type="radio" name="agree_1" id="agree_11" value="N" checked="checked" class="radioInput" ><label for="agree_11">동의하지 않음</label>
                            </div>
                        </div>
                    </div>

                    <div class="btnArea">
                    	<!-- <a href="#" class="btnR" id="btn_next">취소</a>
                    	<a href="#" class="btnG" id="btn_next">취소</a>
                    	<a href="#" class="btnO" id="btn_next">취소</a> -->
                    	<a href="#" class="btnBK" id="btn_cancel" onclick="return false;">취소</a>
                        <a href="#" class="btnB" id="btn_next" onclick="return false;">다음</a>
                    </div>

  
</form>

	

<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('#contents').parent('div').addClass('manager');
		
		$("#btn_cancel").click( function() {
			$("#dataForm").find("#pstate").val("L");
			$("#dataForm").submit();					
		});
		
		$("#btn_next").click( function() {
			if($("input:radio[name=agree_1]:checked").val() == "N"){
				alert("개인정보 이용동의자 동의사항에 동의하지 않았습니다.");
				$("#agree_1").focus();
				return false;
			}
			$("#dataForm").find("#pstate").val("CF2");
			$("#dataForm").submit();					
		});
	
	});
	
	// 상세보기
	var fnRequstInfo = function(reqRceptNo, regId){
		/*if("<c:out value='${nUser}'/>" == 'N'){
			if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
				document.location.href="/cmsmain.do?scode=S01&pcode=000253";
				return;
			}else{
				return;
			}
			
		}*/

		$("input[name=pstate]").val("DF");
		//$("#dataForm").find("#ifrm_rcept_no").val(ifrmRceptNo);
		$("#dataForm").find("input[name=reqRceptNo]").val(reqRceptNo);
		$("#dataForm").find("#reg_id").val(regId);
		
		var params = jQuery("#dataForm").serialize();
		
		/*if(regId == "<c:out value='${nUser}'/>"){
			fnOpenPwLayer(reqRceptNo, "SC");
		}else{
			alert("신청한 본인만 내용을 확인할수 있습니다.");
			return;
		}*/
		$("#dataForm").submit();
		

	};	
	
	/*
	
	//목록보기
	var reset_list = function(){

		$('#sDate').val('');
		$('#eDate').val('');
		$('#sRequstSttusCd').val('');
		$('#sGbOption').val();
		$('#sKeyWord').val('');
		$("#dataForm").find("#pstate").val("L");
		$("#dataForm").submit();

	}
	

	
	// page
	var goPage = function(pageNo){
		$("#dataForm").find("#page").val(pageNo);
		$("#dataForm").find("#pstate").val("L");
		$("#dataForm").submit();
	};
	
	var fnCallBack = function(){
		$("#dataForm").find("#pstate").val("DF");
		$("#dataForm").submit();
	};
	
	// 다운로드
	var goDownfile = function(file_seqno){
		$.fn.cmfile.fileDownLoad("", file_seqno);
	};
	*/
//]]>
</script>
