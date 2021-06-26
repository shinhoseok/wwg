<%@page pageEncoding="utf-8"%><script language="javascript" src="<%=con_root%>/js/com-file.js"></script><script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script><form action="<%=RequestURL%>" method="post" enctype="multipart/form-data" id="dataForm" name="dataForm"><input type="hidden" id="scode"		name="scode" 	value="<%=scode %>" /><input type="hidden" id="pcode"		name="pcode" 	value="<%=pcode %>" /><input type="hidden" id="pstate"	name="pstate" 	value="<%=pstate %>" /><input type="hidden" id="moblphon"	name="moblphon" value="<c:out value='${R_MAP.myMypDtl.moblphon}'/>" /><input type="hidden" id="telno"		name="telno" 	value="<c:out value='${R_MAP.myMypDtl.telno}'/>" /><input type="hidden" id="email"		name="email" 	value="<c:out value='${R_MAP.myMypDtl.email}'/>" /><input type="hidden" id="user_id"	name="user_id"	value="<c:out value='${R_MAP.myMypDtl.userId}'/>" /><input type="hidden" id="user_seqno"	name="user_seqno"	value="<c:out value='${R_MAP.myMypDtl.userSeqno}'/>" /><input type="hidden" id="indvdl_grp_se" name="indvdl_grp_se" value="<c:out value='${R_MAP.myMypDtl.indvdlGrpSe}'/>" /><input type="hidden" id="rpcode"		name="rpcode" 	value="000138" />                    <div class="prg top">                        <h4 class="titleM">회사정보</h4>                        <span style="float:right;"><font color=red>*</font> 는 필수항목입니다.</span>                        <div class="tableArea">                            <table class="tableC">                                <caption>회사정보입력-사업자등록번호(아이디),성명,생년월일,현재비밀번호,비밀번호,비밀번호확인,회사명,대표자명,회사대표전화번호,회사대표휴대전화,회사주소,회사대표이메일,사업자등록증(중소기업확인서)</caption>                                <colgroup>                                    <col width="15%">                                    <col width="35%">                                    <col width="15%">                                    <col width="35%">                                </colgroup>                                <tbody>                                    <tr>                                        <th><span>사업자등록번호(아이디) <font color=red>*</font></span></th>                                        <td colspan="3"><c:out value="${R_MAP.myMypDtl.userId}"/></td>                                    </tr>                                    <tr style="display:none;">                                        <th><span>성명 <font color=red>*</font></span></th>                                        <td><c:out value="${R_MAP.myMypDtl.userNm}"/></td>                                        <th><span>생년월일 <font color=red>*</font></span></th>                                        <td>                                            ${fn:substring(R_MAP.myMypDtl.brthdy,0,4)}-${fn:substring(R_MAP.myMypDtl.brthdy,4,6)}-${fn:substring(R_MAP.myMypDtl.brthdy,6,8)}                                        </td>                                    </tr>                                    <tr>                                        <th><span>현재 비밀번호 <font color=red>*</font></span></th>                                        <td colspan="3">                                            <div class="inputBox">                                                <input type="password" class="inputtxt" id="currentPwd" alt="현재 비밀번호" title="현재 비밀번호" value="" >                                            </div>                                        </td>                                    </tr>                                    <tr>                                        <th><span>비밀번호 <font color=red>*</font></span></th>                                        <td colspan="3">                                        	<em class="pointR">비밀번호 변경(변경시만 입력)<b>*</b>는 필수항목입니다.</em>                                            <div class="inputBox">                                                <input type="password" class="inputtxt" name="password" id="password" maxlength="20" alt="비밀번호" title="비밀번호" value="" >                                                <span id="pwComment"></span>                                            </div>                                            <span>ㆍ 비밀번호는 <em class="pointR">9~12자의 영문 대문자, 소문자, 숫자, 특수문자를 혼합</em>해서 사용하실수 있습니다.</span>                                            <span>ㆍ 해당 특수문자는 사용하실 수 없습니다.<em class="pointR">(  < ,  > ,  / ,  \\ ,  & ,  | ,  ^ ,  % ,  + ,  .  )</em></span>                                            <span>ㆍ 비밀번호 변경 시 우측 <em class="pointR">보안등급을 참고</em>하셔서 안전한 비밀번호로 변경하시기 바랍니다.</span>                                        </td>                                    </tr>                                    <tr>                                        <th><span>비밀번호 확인 <font color=red>*</font></span></th>                                        <td colspan="3">                                            <div class="inputBox">                                                <input type="password" class="inputtxt" name="confirmPassword" id="confirmPassword" alt="비밀번호확인" title="비밀번호확인" value="" >                                            </div>                                        </td>                                    </tr>									<tr>										<th><span>회사명 <font color=red>*</font></span></th>                                        <td >											<input type="text" class="inputtxt" name="grp_nm" id="grp_nm" maxlength="20" title="회사명"  value="<c:out value='${R_MAP.myMypDtl.grpNm}'/>" />										</td>										<th><span>대표자명 <font color=red>*</font></span></th>										<td >											<input type="text" class="inputtxt" name="rprsntv" id="rprsntv" maxlength="20" title="대표자명" value="<c:out value='${R_MAP.myMypDtl.rprsntv}'/>" />										</td>									</tr>                                                                        <tr>                                        <th><span>회사 대표 전화번호 <font color=red>*</font></span></th>                                        <td colspan="3">                                        	<c:set var="telno" value="${fn:split(R_MAP.myMypDtl.telno,'-')}" />                                      											<select id="telno1" name="telno1" title="회사 대표 전화번호 앞자리">												<c:forEach var="list" items="${R_MAP.m00008List}" varStatus="status">													<option value="<c:out value='${list.stdinfoDtlNm}'/>" <c:if test="${list.stdinfoDtlNm == telno[0]}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>												</c:forEach>																							</select>											 - 											<input type="text" class="inputtxt" style="width:110px;" name="telno2" id="telno2" value="<c:out value="${telno[1]}"/>" alt="전화번호" title="회사 대표 전화번호 가온데자리" maxlength="4" />											 - 											<input type="text" class="inputtxt" style="width:110px;" name="telno3" id="telno3" value="<c:out value="${telno[2]}"/>" alt="전화번호" title="회사 대표 전화번호 끝자리" maxlength="4" />                                          </td>                                    </tr>                                    <tr>                                        <th><span>회사 대표 휴대전화 <font color=red>*</font></span></th>                                        <td colspan="3">                                        											<c:set var="moblphon" value="${fn:split(R_MAP.myMypDtl.moblphon,'-')}" />											<select id="moblphon1" name="moblphon1" title="회사 대표 휴대전화 앞자리">												<c:forEach var="list" items="${R_MAP.m00009List}" varStatus="status">													<option value="<c:out value='${list.stdinfoDtlNm}'/>" <c:if test="${list.stdinfoDtlNm == moblphon[0]}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>												</c:forEach>											</select>											 - 											<input type="text" class="inputtxt" style="width:110px;" name="moblphon2" id="moblphon2" value="<c:out value='${moblphon[1]}'/>" alt="휴대전화" title="회사 대표 휴대전화 가온데자리" maxlength="4" />											 - 											<input type="text" class="inputtxt" style="width:110px;" name="moblphon3" id="moblphon3" value="<c:out value='${moblphon[2]}'/>" alt="휴대전화" title="회사 대표 휴대전화 끝자리" maxlength="4" /> 						                                        </td>                                    </tr>                                    <tr>                                        <th><span>회사 주소 <font color=red>*</font></span></th>                                        <td colspan="3">		                                            <div class="inputBox">                                                <input type="text" class="inputtxt" name="zip" id="zip" alt="우편번호" title="우편번호" value="<c:out value='${R_MAP.myMypDtl.zip}'/>" readonly>                                                <button class="btnBL" id="juso" onclick="return false;" title="새창">도로명 검색</button>                                            </div>                                            <input type="text" class="inputtxt" style="width:100%;margin-top:5px;" name="adres" id="adres" alt="주소" title="주소"  value="<c:out value='${R_MAP.myMypDtl.adres}'/>" readonly>                                            <input type="text" class="inputtxt" style="width:100%;margin-top:5px;" name="bunji" id="bunji" alt="주소" title="번지"  value="<c:out value='${R_MAP.myMypDtl.bunji}'/>"  >                                            											<input type="hidden" name="addr_sido" id="addr_sido" title="" value="<c:out value='${R_MAP.myMypDtl.addrSido}'/>" />											<input type="hidden" name="addr_sigungu" id="addr_sigungu" title=""  value="<c:out value='${R_MAP.myMypDtl.addrSigungu}'/>" />											<input type="hidden" name="addr_dong" id="addr_dong" title="" title="" value="<c:out value='${R_MAP.myMypDtl.addrDong}'/>" />											<input type="hidden" name="addr_road" id="addr_road" title="" value="<c:out value='${R_MAP.myMypDtl.addrRoad}'/>" />											<input type="hidden" name="addr_bunji" id="addr_bunji" title="" value="<c:out value='${R_MAP.myMypDtl.addrBunji}'/>" />											<input type="hidden" name="addr_raad_num" id="addr_raad_num" title="" value="<c:out value='${R_MAP.myMypDtl.addrRaadNum}'/>" />                                                                                    </td>                                    </tr>                                    <tr>                                        <th><span>회사 대표 이메일 <font color=red>*</font></span></th>                                        <td colspan="3">        											<c:set var="email" value="${fn:split(R_MAP.myMypDtl.email,'@')}" />                                                                            											<input type="text" class="inputtxt" style="width:260px;" name="email1" id="email1" maxlength="30" alt="이메일" title="이메일" value="<c:out value='${email[0]}'/>"  />											@											<input type="text" class="inputtxt" style="width:260px;" name="email2" id="email2" maxlength="20" alt="이메일" title="이메일(도메인)"  value="<c:out value='${email[1]}'/>" readonly="readonly" />											<select id="email3" name="email3" title="이메일 도메인 선택">												<c:forEach var="list" items="${R_MAP.m00004List}" varStatus="status">													<option value="<c:out value='${list.stdinfoDtlNm}'/>" <c:if test="${list.stdinfoDtlNm == email[1]}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlLabel}"/></option>												</c:forEach>																							</select>							                                                                                    </td>                                    </tr>									<tr>										<th><span>사업자등록증<br />											,중소기업확인서 <font color=red>*</font></span></th>										<td colspan="3">											<div id="cmfile1"></div>										</td>									</tr>                                                                    </tbody>                            </table>                        </div>                    </div>                    					<c:if test="${R_MAP.myMypDtl.indvdlGrpSe == 'G'}"><!-- 기관회원인 경우만 노출 -->					<div class="prg" style="display:none;">                        <h4 class="titleM">기관정보입력</h4>						<span style="float:right;"><font color=red>*</font> 는 필수항목입니다.</span>                        <div class="tableArea">                            <table class="tableC">                                <caption>기관정보입력-담당부서,담당자명,연락처</caption>                                <colgroup>                                    <col width="15%">                                    <col width="35%">                                    <col width="15%">                                    <col width="35%">                                </colgroup>                                <tbody>	                                									<tr>										<th scope="row">담당부서</th>										<td >											<input type="text" class="inputtxt" name="use_dept" id="use_dept" maxlength="20" title="담당부서" value="<c:out value='${R_MAP.myMypDtl.useDept}'/>" />										</td>										<th scope="row">담당자명</th>										<td >											<input type="text" class="inputtxt" name="charger" id="charger" value="" maxlength="10" title="담당자명" value="<c:out value='${R_MAP.myMypDtl.charger}'/>" />										</td>									</tr>									<tr>										<th>연락처 <font color=red>*</font></th>										<td colspan="3">											<input type="text" class="inputtxt" name="contact" id="contact" maxlength="13" title="연락처" value="<c:out value='${R_MAP.myMypDtl.contact}'/>" maxlength="13" title="연락처" onkeyup="maskTel(this)" />										</td>									</tr>								</tbody>	                        </table>                    	</div>                    </div>					</c:if>					                                        <div class="prg lastPrg">                        <h4 class="titleM">뉴스 · 정보수신여부 설정</h4>                        <span style="float:right;"><font color=red>*</font> 는 필수항목입니다.</span>                        <div class="tableArea">                            <table class="tableC">                                <caption>뉴스 · 정보수신여부 설정-메일수신여부,SMS수신여부,뉴스레터</caption>                                <colgroup>                                    <col width="15%">                                    <col width="35%">                                    <col width="15%">                                    <col width="35%">                                </colgroup>                                <tbody>                                    <tr>                                        <th><span>메일 수신여부 <font color=red>*</font></span></th>                                        <td>                                            <div class="radioBox">                                                <input type="radio" class="radioInput" id="email_recptn_at1"  name="email_recptn_at"  value="Y" <c:if test="${R_MAP.myMypDtl.emailRecptnAt == 'Y'}">checked="checked"</c:if>><label for="email_recptn_at1">예</label>                                                <input type="radio" class="radioInput" id="email_recptn_at2"  name="email_recptn_at" value="N" <c:if test="${R_MAP.myMypDtl.emailRecptnAt == 'N'}">checked="checked"</c:if> ><label for="email_recptn_at2">아니오</label>                                            </div>                                                                                                                               </td>                                        <th><span>SMS 수신여부 <font color=red>*</font></span></th>                                        <td>                                            <div class="radioBox">                                                <input type="radio" class="radioInput" id="sms_recptn_at1" name="sms_recptn_at" value="Y" <c:if test="${R_MAP.myMypDtl.smsRecptnAt == 'Y'}">checked="checked"</c:if>><label for="sms_recptn_at1">예</label>                                                <input type="radio" class="radioInput" id="sms_recptn_at2" name="sms_recptn_at" value="N" <c:if test="${R_MAP.myMypDtl.smsRecptnAt == 'N'}">checked="checked"</c:if>><label for="sms_recptn_at2">아니오</label>                                                                                            </div>                                        </td>                                    </tr>                                                                        <tr style="display:none;">                                        <th><span>뉴스레터 <font color=red>*</font></span></th>                                        <td colspan="3">                                            <div class="radioBox">                                                <input type="radio" class="radioInput" id="new_recptn_at1"  name="new_recptn_at"  value="Y" <c:if test="${R_MAP.myMypDtl.newRecptnAt == 'Y'}">checked="checked"</c:if>><label for="new_recptn_at1">예</label>                                                <input type="radio" class="radioInput" id="new_recptn_at2"  name="new_recptn_at" value="N" <c:if test="${R_MAP.myMypDtl.newRecptnAt == 'N'}">checked="checked"</c:if> ><label for="new_recptn_at2">아니오</label>                                            </div>                                                                                                                               </td>                                    </tr>                                                                                                                                           </tbody>                            </table>                        </div>                        <span class="txtNotice">* 해당 항목을 수신동의하시면 다양한 정보를 받아보실 수 있습니다. 단, 해당항목을 제공하지 않으셔도 홈페이지의 기본 서비스 이용에 제한은 없습니다.</span>                    </div>                    <div class="btnArea">                        <a href="#" class="btnB" id="btn_join">확인</a>                        <a href="#" class="btnBL" id="btn_cancel">취소</a>                        <a href="#" class="btnRM" id="btn_withdraw">회원탈퇴</a>                    </div>                </div>                </form>		<script type="text/javascript">//<![CDATA[		var alertMsg = "";	$('#contents').parent('div').addClass('join join03');	$(function(){				$("#password").keyup(function(){			if($("#password").val() != ""){				fnCheckPwd(this.value);			}else{				alertMsg = "";			}		});				// 도로명검색		$("#juso").click( function() {			fnJusoPopup();		});				// email		$('#email3').change(function(){			if($('#email3 option:selected').val()=='직접입력'){				$("#email2").val('');				$("#email2").prop('readonly', false);			}else{				$("#email2").val($('#email3 option:selected').val());				$("#email2").prop('readonly', true);			}		});				$("#zip").click( function() {			fnJusoPopup();		});				//기관일경우 첨부파일 추가		var file1 = $.fn.cmfile.init({			 id				: 'cmfile1'			 ,onClickNamefn	: "fileNameClick1"			 ,img_url 		: "<%=img_url%>"			 ,uploadcnt		: <%=uploadcnt%>			 ,extchk		: ['GIF','JPG','BMP','PNG','HWP','XLS','XLSX','ZIP','PDF','DOC','DOCX','PPT','PPTX','TXT']			 		});				<% if(!(HtmlTag.returnString((String)rtn_Map.get("file_group_htmlarray"),"")).equals("")){ %>			//첨부파일 세팅			var file_group1 = <%=(String)rtn_Map.get("file_group_htmlarray")%>;			$.fn.cmfile.setfileList("cmfile1", file_group1);		<% } %>				$('.addfileInfo').after('<p class="addfileInfo">파일명 더블클릭시 다운로드 받으실수 있습니다.</p>');						<c:if test="${indvdl_grp_se == 'G'}">		</c:if>						// 확인		$("#btn_join").click( function() {						//if (!validation("dataForm")) return false; //필수 체크						var stringRegx;						if(alertMsg != ""){				alert(alertMsg);				return false;			}						// 비밀번호가 입력되어있을경우 비밀번호를 체크한다			if(!isEmpty($('input[name=password]').val()) ){				var currentPwd = $("#currentPwd").val();				if(currentPwd == null || currentPwd == "") {					alert("현재 비밀번호를 입력해주세요.");					$("#currentPwd").focus();					return;				}				if(!$('input[name=password]').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");					$("input[name=Password]").focus();					return;				}				if($("input[name=confirmPassword]").val() == ""){					alert("패스워드 확인을 입력해주세요.");					$("input[name=confirmPassword]").focus();					return false;				}				if($("input[name=password]").val() != $("input[name=confirmPassword]").val()){					alert("입력하신 비밀번호가 맞지않습니다.");					$("input[name=confirmPassword]").focus();					return false;				}							}						if($("#grp_nm").val() == ""){				alert("회사명을 입력해주세요.");				$("#grp_nm").focus();				return false;			}			if($("#rprsntv").val() == ""){				alert("대표자명을 입력해주세요.");				$("#rprsntv").focus();				return false;			}									if($("#contact").val() == ""){				//alert("연락처를 입력해주세요.");				//$("#contact").focus();				//return false;			}						if($('#telno1 option:selected').val() == ""){				alert("회사 대표 전화번호 첫자리를 입력해주세요.");				$('#telno1').focus();				return false;			}			if($("#telno2").val() == ""){				alert("회사 대표 전화번호 중간자리를 입력해주세요.");				$("#telno2").focus();				return false;			}			if($("#telno3").val() == ""){				alert("회사 대표 전화번호 끝자리를 입력해주세요.");				$("#telno3").focus();				return false;			}												if($('#moblphon1 option:selected').val() == ""){				alert("휴대폰 번호 첫자리를 입력해주세요.");				$('#moblphon1').focus();				return false;			}			if($("#moblphon2").val() == ""){				alert("휴대폰 번호 중간자리를 입력해주세요.");				$("#moblphon2").focus();				return false;			}			if($("#moblphon3").val() == ""){				alert("휴대폰 번호 끝자리를 입력해주세요.");				$("#moblphon3").focus();				return false;			}						if($('#moblphon1 option:selected').val() == ""){				alert("회사 대표 휴대폰 번호 첫자리를 입력해주세요.");				$('#moblphon1').focus();				return false;			}			if($("#moblphon2").val() == ""){				alert("회사 대표 휴대폰 번호 중간자리를 입력해주세요.");				$("#moblphon2").focus();				return false;			}			if($("#moblphon3").val() == ""){				alert("회사 대표 휴대폰 번호 끝자리를 입력해주세요.");				$("#moblphon3").focus();				return false;			}						if($('#zip').val() == ""){				alert("회사 주소 우편번호를 입력해주세요.");				$('#juso').focus();				return false;			}			if($("#adres").val() == ""){				alert("회사 주소를 입력해주세요.");				$("#juso").focus();				return false;			}			if($("#bunji").val() == ""){				alert("회사 주소 상세주소를 입력해주세요.");				$("#bunji").focus();				return false;			}									if($("input[name=email1]").val() == ""){				alert("회사 대표 이메일 아이디를 입력해주세요.");				return false;			}						if($("input[name=email2]").val() == ""){				alert("회사 대표 이메일 도메인을 입력해주세요.");				return false;			}						// 첨부파일이 입력되어 있는지 확인한다			if($.fn.cmfile.getfilelistcnt("cmfile1") < 2){				alert("사업자등록증과 중소기업확인서가 모두 등록되어야 합니다");				return;			}						if(confirm("수정하시겠습니까?")){								// 전화번호				$("input[name=telno]").val($('#telno1 option:selected').val() + "-" + $("input[name=telno2]").val() + "-" + $("input[name=telno3]").val());				// 휴대전화				$("input[name=moblphon]").val($('#moblphon1 option:selected').val() + "-" + $("input[name=moblphon2]").val() + "-" + $("input[name=moblphon3]").val());				// email				$("input[name=email]").val($("input[name=email1]").val() + "@" + $("input[name=email2]").val());								$("form[name=dataForm]").find("input[name=pstate]").val("U");				document.dataForm.target = "";								var isValid = false;				$.ajax({					  url : "<c:url value='/mypage/selectCurrentPwdChk.do' />"					, type : "post"					, dataType : "json"					, async    : false					, data : {"userPwd" : $("#currentPwd").val() }					, success : function(r) {						if(r.result == 0) {							alert("현재 비밀번호가 올바르지 않습니다. 다시 확인해주세요.");							$("#currentPwd").focus();							return;						} else {							isValid = true;						}					}					, error : function(xhr, status, error) {						alert("현재 정보변경 서비스가 원활하지 않습니다.\n잠시후 다시 이용해 주십시요.");					}				});								if(isValid) {					var params = jQuery("#dataForm").serialize();										jQuery("#dataForm").ajaxSubmit({								 type      : "post"								, url      : "<c:url value='/cmsajax.do' />"								, data     : params								, async    : false								, dataType :"json"								, timeout  : 3000								, error    : function (jqXHR, textStatus, errorThrown) {										// 통신에 에러가 있을경우 처리할 내용(생략가능)										alert("네트웍장애가 발생했습니다. 다시시도해주세요");			               }			               , success  : function(data) {			            	   			            	   alert(data.TRS_MSG);			            	   			            	   if(data.result){			            		   $("form[name=dataForm]").find("input[name=pstate]").val("L");			            		   document.dataForm.submit();			            	   }			               }					});				}							}		});				// 취소		$("#btn_cancel").click( function() {			$("form[name=dataForm]").find("input[name=pcode]").val("main");			document.dataForm.target = "";			document.dataForm.submit();		});				// 회원탈퇴		$("#btn_withdraw").click( function() {			if(confirm("탈퇴하시겠습니까?\r\n탈퇴하시면 즉시 회원정보가 삭제됩니다.")){								// 전화번호				$("input[name=telno]").val($('#telno1 option:selected').val() + "-" + $("input[name=telno2]").val() + "-" + $("input[name=telno3]").val());				// 휴대전화				$("input[name=moblphon]").val($('#moblphon1 option:selected').val() + "-" + $("input[name=moblphon2]").val() + "-" + $("input[name=moblphon3]").val());				// email				$("input[name=email]").val($("input[name=email1]").val() + "@" + $("input[name=email2]").val());								$("form[name=dataForm]").find("input[name=pstate]").val("DUSER");				document.dataForm.target = "";								var params = jQuery("#dataForm").serialize();								jQuery("#dataForm").ajaxSubmit({							 type      : "post"							, url      : "<c:url value='/cmsajax.do' />"							, data     : params							, async    : false							, dataType :"json"							, timeout  : 3000							, error    : function (jqXHR, textStatus, errorThrown) {									// 통신에 에러가 있을경우 처리할 내용(생략가능)									alert("네트웍장애가 발생했습니다. 다시시도해주세요");		               }		               , success  : function(data) {		            	   		            	   if(data.TRS_MSG!=null && data.TRS_MSG!=undefined && data.TRS_MSG!=''){		            		   alert(data.TRS_MSG);		            	   }		            	   		            	   		            	   if(data.result){		            		   top.location.href="<c:url value='/cmsmain.do'/>?scode=<%=scode %>&amp;pcode=logoff";		            	   }		               }				});			}		});					});			var fnCheckPwd = function(inputVal){		var user_id = "<c:out value='${R_MAP.myMypDtl.userId}'/>";		var ptrnCnt = 0;		var chk_num = inputVal.search(/[0-9]/g); 		var chk_lowerEng = inputVal.search(/[a-z]/g); 		var chk_upperEng = inputVal.search(/[A-Z]/g); 		var strSpecial = inputVal.search(/[`~!@#$*\'\";:?()\[\]]/gi);		var impossibleChar = inputVal.search(/[<>\/\\&|^%+.]/gi);    		var retVal = checkSpace(inputVal);		if(impossibleChar > -1){			alert("아래 특수문자만 허용됩니다.\n[`, ~, !, @, #, $, *, ', \", ;, :, ?, (, ), [, ] ]");			var temp_pwd = $('#password').val();			$('#password').val(temp_pwd.substring(0, temp_pwd.length-1));			return false;		}		if(chk_num > -1){ ++ptrnCnt; }		if(chk_upperEng > -1){ ++ptrnCnt; }		if(chk_lowerEng > -1){ ++ptrnCnt; }		if(strSpecial > -1){ ++ptrnCnt; }				if(inputVal.indexOf(user_id) > -1) {			alertMsg = "비밀번호에 ID를 포함할수 없습니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (ID 포함 불가)");			return false;		}else if(retVal){			alertMsg = "비밀번호는 공백없이 입력해 주세요.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (공백 불가)");			return false;		}else if(inputVal.length < 9){			alertMsg = "9자 이상의 비밀번호만 입력 가능 합니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (8자리 이하 불가)");			return false;		}else if(ptrnCnt < 3){			alertMsg = "비밀번호는 대문자, 소문자, 숫자, 특수문자 중 세 가지 이상 조합되어야 합니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (비밀번호 패턴 조합 미준수)");			return false;		}else{			alertMsg = "";			$("#pwComment").text("사용 가능한 비밀번호입니다.");						if((inputVal.length == 9 || inputVal.length == 10) && ptrnCnt == 3){				$("#pwComment").html("※ 보안등급 : 보통 ");			}else if((inputVal.length == 9 || inputVal.length == 10) && ptrnCnt == 4){				$("#pwComment").html("※ 보안등급 : <span style='color: blue;'>안전</span> ");			}else if(inputVal.length > 10 && ptrnCnt == 2){				$("#pwComment").html("※ 보안등급 : 보통 ");			}else if(inputVal.length > 10 && ptrnCnt > 2){				$("#pwComment").html("※ 보안등급 : <span style='color: blue;'>안전</span> ");			}			return true;		}	};		var checkSpace = function(str){		  if(str.search(/\s/) != -1){				return true;			}else{				return false;			}		};			// 도로명주소	var fnJusoPopup = function(){		popWin("<%=con_root%>/doroApi/jusoPopup.jsp", 'popup_window', 600, 400);	};		// CallBack	var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr			,jibunAddr,zipNo, admCd, rnMgtSn, bdMgtSn			, detBdNmList, bdNm, bdKdcd, siNm, sggNm			, emdNm, liNm, rn, udrtYn, buldMnnm			, buldSlno, mtYn, lnbrMnnm, lnbrSlno){		// 우편번호		$("input[name=zip]").val(zipNo);		// 주소		$("input[name=adres]").val(roadAddrPart1);		// 주소상세		$("input[name=bunji]").val(addrDetail);				// 시도		$("input[name=addr_sido]").val(siNm);		// 시군구		$("input[name=addr_sigungu]").val(sggNm);		// 읍면동		$("input[name=addr_dong]").val(emdNm);		// 도로명		$("input[name=addr_road]").val(rn);				// 번지		$("input[name=addr_bunji]").val(lnbrMnnm);					// 도로번호		$("input[name=addr_raad_num]").val(buldMnnm);			};	//이메일	var email3 = $('#email3').html();	//$("#email1").val("${email[0]}");	//$("#email2").val("${email[1]}");	if(email3.indexOf("${email[1]}")>-1){		$("#email3").val("${email[1]}");	}else{		$("#email3").val("직접입력");	}				// 다운로드	var goDownfile = function(file_seqno){		$.fn.cmfile.fileDownLoad("", file_seqno);	};	//]]></script>