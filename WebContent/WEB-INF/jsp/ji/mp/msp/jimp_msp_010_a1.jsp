<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jisc_srm_010_a1.jsp
String max_seat_cnt = "8";
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

<input type="hidden" 	id="page" 						name="page" 				value="${R_MAP.param.page}"/>
<input type="hidden" 	id="searchTab" 					name="searchTab" 			value="${R_MAP.param.searchTab}" />
<input type="hidden" 	id="searchGubun" 				name="searchGubun" 			value="${R_MAP.param.searchGubun}" />
<input type="hidden" 	id="searchValue" 				name="searchValue" 			value="${R_MAP.param.searchValue}" />
 <input type="hidden" 	id="prod_seq" 					name="prod_seq" 			value="${R_MAP.param.prod_seq}"/>
 <input type="hidden" name="agree_1" id="agree_1" value="${R_MAP.param.agree_1}" />

                <div class="cts_mid">
                    <div class="tabmenu2">
                        <div class="tab_prev"></div>
                        <div class="tabinner">
                            <ul>
                                <li class="tab-link current" data-tab="tab-1"><a href="#" onclick="return false;">기업소개</a></li>
                                <li class="tab-link" data-tab="tab-2"><a href="#" onclick="return false;">제품설명</a></li>
                                <li class="tab-link" data-tab="tab-3"><a href="#" onclick="return false;">인증현황 </a></li>
                                <li class="tab-link" data-tab="tab-4"><a href="#" onclick="return false;">e-카탈로그</a></li>
                            </ul>
                        </div>
                        <div class="tab_next"></div>
                    </div>
                    
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
					
                    <div class="writeArea" id="tab-1-view">
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 기업소개-회사명,기업구분,회원구분,설비분야,제품유형,대표자명,설립일,종업원수,회사연혁,주요생산품,사업자번호,이메일,홈페이지,대표번호,팩스번호,비밀번호</caption>
                            <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><label for="CORP_NM">회사명</label> <span style="color:red;">*</span></th>
                                    <td colspan="3"><input type="text" style="width:100%;" id="CORP_NM" name="CORP_NM" value="" maxlength="100" title="회사명" /></td>
                                </tr>
                                
                                <tr>
                                    <th><label for="CORP_DIVN">기업구분</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
									<c:forEach var="list" items="${R_MAP.m00100List}" varStatus="i">
											<input type="checkbox" id="std${list.stdinfoDtlCd}" name="CORP_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
											<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
									</c:forEach>    
									<input type="hidden" name="CORP_DIVN_cds" id="CORP_DIVN_cds" value="" />                               
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th><label for="CORP_MEM_DIVN">회원구분</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
									<c:forEach var="list" items="${R_MAP.m00103List}" varStatus="i">
											<input type="radio" id="std${list.stdinfoDtlCd}" name="CORP_MEM_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
											<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
									</c:forEach> 
									<input type="hidden" name="CORP_MEM_DIVN_cds" id="CORP_MEM_DIVN_cds" value="" />                                    
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <th><label for="CORP_FAC_DIVN">설비분야</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
									<c:forEach var="list" items="${R_MAP.m00101List}" varStatus="i">
											<input type="checkbox" id="std${list.stdinfoDtlCd}" name="CORP_FAC_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
											<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
									</c:forEach>  
									<input type="hidden" name="CORP_FAC_DIVN_cds" id="CORP_FAC_DIVN_cds" value="" />                                     
                                    </td>
                                </tr>     
                                
                                <tr>
                                    <th><label for="PROD_TY">제품유형</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
									<c:forEach var="list" items="${R_MAP.m00106List}" varStatus="i">
											<input type="checkbox" id="std${list.stdinfoDtlCd}" name="PROD_TY" value="<c:out value='${list.stdinfoDtlCd}'/>" />
											<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
									</c:forEach>  
									<input type="hidden" name="PROD_TY_cds" id="PROD_TY_cds" value="" />                                     
                                    </td>
                                </tr>
                                                                
                                <tr>
                                    <th ><label for="CORP_REPE_NM">대표자명</label></th>
                                    <td colspan="3"><input type="text" id="CORP_REPE_NM" name="CORP_REPE_NM" value="" maxlength="32" title="대표자명" /></td>
                                </tr>  
                                
                                <tr>
                                    <th ><label for="CORP_EST_DT">설립일</label></th>
                                    <td colspan="3"><input type="text" id="CORP_EST_DT" name="CORP_EST_DT" value="" maxlength="10" title="설립일" readonly="readonly" /></td>
                                </tr> 
                                
                                <tr>
                                    <th ><label for="CORP_TTL_CNT">종업원수</label></th>
                                    <td colspan="3"><input type="text" id="CORP_TTL_CNT" name="CORP_TTL_CNT" value="" maxlength="10" title="종업원수" onkeyup="inputNum(this);" style="IME-MODE:disabled" /></td>
                                </tr> 
                                
                                <tr>
                                    <th ><label for="CORP_HIST">회사연혁</label></th>
                                    <td colspan="3"><textarea style="width:100%;" name="CORP_HIST" id="CORP_HIST" rows="5"></textarea></td>
                                </tr>                                        
                                
                                <tr>
                                    <th ><label for="CORP_MAIN_PROD">주요생산품</label></th>
                                    <td colspan="3"><input style="width:100%;" type="text" id="CORP_MAIN_PROD" name="CORP_MAIN_PROD" value="" maxlength="500" title="주요생산품" /></td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="CORP_NO">사업자번호</label></th>
                                    <td colspan="3"><input type="text" id="CORP_NO" name="CORP_NO" value="" maxlength="50" title="사업자번호" /></td>
                                </tr>   
                                
                                <tr>
                                    <th ><label for="email1">이메일</label> <span style="color:red;">*</span></th>                                
									<td colspan="3">
											<input type="text" name="email1" id="email1" maxlength="30" alt="이메일" title="이메일" />
											@
											<input type="text" name="email2" id="email2" maxlength="20" alt="이메일" title="이메일 도메인" />
											<select id="email3" name="email3" title="이메일 도메인 선택">
												<c:forEach var="list" items="${R_MAP.m00004List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>
											<input type="hidden" name="CORP_EMAIL" id="CORP_EMAIL" alt="이메일" title="이메일" />
									</td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="CORP_LINK">홈페이지</label></th>
                                    <td colspan="3"><input type="text" id="CORP_LINK" name="CORP_LINK" value="" maxlength="500" title="홈페이지" /></td>
                                </tr>  
                                
                                <tr>
                                    <th><label for="CORP_TEL_NO_11">대표번호</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
											<select id="CORP_TEL_NO_11" name="CORP_TEL_NO_11" style="width:15%;" title="대표번호 앞자리">
												<c:forEach var="list" items="${R_MAP.m00008List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/>(<c:out value="${list.stdinfoDtlLabel}"/>)</option>
												</c:forEach>
											</select>
											                                    
                                    		- <input type="text" id="CORP_TEL_NO_12" name="CORP_TEL_NO_12" value="" maxlength="4" title="대표번호 중간자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
                                    		- <input type="text" id="CORP_TEL_NO_13" name="CORP_TEL_NO_13" value="" maxlength="4" title="대표번호 끝자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
                                    		<input type="hidden" name="CORP_TEL_NO_1" id="CORP_TEL_NO_1" alt="대표번호" title="대표번호" />
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <th ><label for="CORP_FAX_NO1">팩스번호</label></th>
                                    <td colspan="3">
											<select id="CORP_FAX_NO1" name="CORP_FAX_NO1" style="width:15%;" title="팩스번호 앞자리">
												<c:forEach var="list" items="${R_MAP.m00008List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/>(<c:out value="${list.stdinfoDtlLabel}"/>)</option>
												</c:forEach>
											</select>
											                                    
                                    		- <input type="text" id="CORP_FAX_NO2" name="CORP_FAX_NO2" value="" maxlength="4" title="팩스번호 중간자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
                                    		- <input type="text" id="CORP_FAX_NO3" name="CORP_FAX_NO3" value="" maxlength="4" title="팩스번호 끝자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />                                    
		                                    <input type="hidden" name="CORP_FAX_NO" id="CORP_FAX_NO" alt="팩스번호" title="팩스번호" />
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
                    
                    <div class="writeArea" id="tab-2-view" style="display:none;">
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 제품설명-제품명,제품구분,제품특징,기술규격,동작원리,납품실적,상품이미지</caption>
                            <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><label for="PROD_NM">제품명</label> <span style="color:red;">*</span></th>
                                    <td colspan="3"><input type="text" style="width:100%;" id="PROD_NM" name="PROD_NM" value="" maxlength="100" title="제품명" /></td>
                                </tr>
                                
                                <tr>
                                    <th><label for="PROD_DIVN">제품구분</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
											<select id="PROD_DIVN" name="PROD_DIVN" title="제품구분 선택">
												<c:forEach var="list" items="${R_MAP.m00102List}" varStatus="i">
													<option value="<c:out value='${list.stdinfoDtlCd}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
												</c:forEach>
											</select>                                    
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="PROD_FUNT">제품특징</label></th>
                                    <td colspan="3">
									    <input type="text" style="width:100%;" id="PROD_FUNT" name="PROD_FUNT" value="" maxlength="1000" title="제품특징" />                            
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <th ><label for="TECH_STND">기술규격</label></th>
                                    <td colspan="3">
									    <input type="text" style="width:100%;" id="TECH_STND" name="TECH_STND" value="" maxlength="1000" title="기술규격" />                            
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="TECH_STND">동작원리</label></th>
                                    <td colspan="3">
									    <input type="text" style="width:100%;" id="OPRT_PRCP" name="OPRT_PRCP" value="" maxlength="1000" title="동작원리" />                            
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <th ><label for="DLVRY_RCD">납품실적</label></th>
                                    <td colspan="3">
                                    	<textarea style="width:100%;" name="DLVRY_RCD" id="DLVRY_RCD" rows="5" title="납품실적"></textarea>                           
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <th><label for="PROD_IMG">상품이미지</label> <span style="color:red;">*</span></th>
                                    <td colspan="3">
                                    	<div id="cmfile1"></div>                         
                                    </td>
                                </tr>                                                                                              											                                                                                                                                                                            
                            </tbody>
                        </table>
                                          	
                    </div>
                    
                    <div class="writeArea" id="tab-3-view" style="display:none;">
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 인증현황-인증품목,인증구분,인증일,인증만료일,</caption>
                            <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th ><label for="CERT_PROD">인증품목</label></th>
                                    <td colspan="3"><input type="text" style="width:100%;" id="CERT_PROD" name="CERT_PROD" value="" maxlength="100" title="인증품목" /></td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="CERT_DIVN">인증구분</label></th>
                                    <td colspan="3">
											<select id="CERT_DIVN" name="CERT_DIVN" onfocus="fixCERT_DIVN();return false;" title="인증구분 선택">
												<c:forEach var="list" items="${R_MAP.m00104List}" varStatus="i">
													<c:if test="${list.stdinfoDtlCd == '000428'}">
														<option value="<c:out value='${list.stdinfoDtlCd}'/>" selected="selected"><c:out value="${list.stdinfoDtlNm}"/></option>
													</c:if>
													<c:if test="${list.stdinfoDtlCd != '000428'}">
														<option value="<c:out value='${list.stdinfoDtlCd}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
													</c:if>
												</c:forEach>
											</select>                                    
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th ><label for="CERT_DT">인증일</label></th>
                                    <td colspan="3"><input type="text" id="CERT_DT" name="CERT_DT" value="" maxlength="10" title="인증일" /></td>
                                </tr>  
 
                                <tr>
                                    <th ><label for="CERT_EXPR_DT">인증만료일</label></th>
                                    <td colspan="3"><input type="text" id="CERT_EXPR_DT" name="CERT_EXPR_DT" value="" maxlength="10" title="인증만료일" /></td>
                                </tr>                                
                                                                                             											                                                                                                                                                                            
                            </tbody>
                        </table>
                                          	
                    </div>
                    
                    <div class="writeArea" id="tab-4-view" style="display:none;">
                        <table class="tableC">
                            <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> e-카탈로그-카탈로그</caption>
                            <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th ><label for="CT_ATCH_FILE_ID">카탈로그</label></th>
                                    <td colspan="3">
                                    	<div id="cmfile2"></div>                         
                                    </td>
                                </tr>                               
                                                                                             											                                                                                                                                                                            
                            </tbody>
                        </table>
                                          	
                    </div>                                                              					
                </div>



				<div class="btnArea">
					<!-- <a href="#" class="btnBL2" id="btn_del" onclick='return false;'>삭제</a>
					<a href="#" class="btnBL2" id="btn_mod" onclick='return false;'>수정</a> -->
					<a href="#" class="btnBL2" id="btn_reg" onclick='return false;'>저장</a>
					<a href="#" class="blueBtn" id="btn_list" onclick='return false;'>목록</a>
				</div>	

</form>


<script type="text/javascript">

// TODO : $(function()
$(function(){

	$('#contents').parent('div').addClass('market');
	
    //tab 메뉴 스타일
    $('.tabmenu2 ul li').click(function(){
		var tab_id = $(this).attr('data-tab');
		var tab_id_num = tab_id.substring(tab_id.lastIndexOf("-")+1,tab_id.length);
		//alert(tab_id_num);
		$('.tabmenu2 ul li').removeClass('current');
		$('.tab-content2').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		for(var i=1;i<=4;i++){
			if(i!=tab_id_num){
				$("#tab-"+i+"-view").hide();
			}
		}
		$("#"+tab_id+"-view").show();
	});	

    
    $("input[name ='CORP_EST_DT']").datepicker({
        changeMonth: true, 
        changeYear: true,
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        showOn:'both',
        yearRange : 'c-100:c', // 100년전부터 현재년도까지
        buttonImage:'<%=con_root%>/images/contents/cal.png',
        onClose:function(selectedDate){
        	
        }
	});	
    
    $("input[name ='CERT_DT']").datepicker({
        changeMonth: true, 
        changeYear: true,
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        showOn:'both',
        yearRange : 'c-100:c', // 100년전부터 현재년도까지
        buttonImage:'<%=con_root%>/images/contents/cal.png',
        onClose:function(selectedDate){
        	
        }
	});    
    
    $("input[name ='CERT_EXPR_DT']").datepicker({
        changeMonth: true, 
        changeYear: true,
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        showOn:'both',
        yearRange : 'c-50:c+10', // 50년전부터 10년후까지
        buttonImage:'<%=con_root%>/images/contents/cal.png',
        onClose:function(selectedDate){
        	
        }
	});    
    
    
    
    $(".ui-datepicker-trigger").css({verticalAlign:"middle",marginLeft:"3px"}); 
    
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

				
		
		var form = document.dataForm;
		
		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
		});
		

		var file2 = $.fn.cmfile.init({
			 id				: 'cmfile2' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['JPG','PNG','HWP','XLS','XLSX','ZIP','PDF','DOC','DOCX']
		});
		
		$("#CERT_DIVN option").not(":selected").attr("disabled","disabled");

		
		// 목록
		$("#btn_list").click(function(e){
			$("#dataForm").attr("enctype","");
			form.method='post';
			form.pstate.value='L';
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

				
				// 설립일, 인증일, 인증만료일
				//$("input[name=CORP_EST_DT]").val($("#CORP_EST_DT").val().replace(/-/gi, ''));
				$("input[name=CERT_DT]").val($("#CERT_DT").val().replace(/-/gi, ''));
				$("input[name=CERT_EXPR_DT]").val($("#CERT_EXPR_DT").val().replace(/-/gi, ''));
				
				// 대표번호
				if(!isEmpty($("#CORP_TEL_NO_11").val()) && !isEmpty($("#CORP_TEL_NO_12").val()) && !isEmpty($("#CORP_TEL_NO_13").val())){
					$("input[name=CORP_TEL_NO_1]").val( $("#CORP_TEL_NO_11").val()+"-"+$("#CORP_TEL_NO_12").val()+"-"+$("#CORP_TEL_NO_13").val() );
				}else{
					$("input[name=CORP_TEL_NO_1]").val("");
				}
				
				// fax번호
				if(!isEmpty($("#CORP_FAX_NO1").val()) && !isEmpty($("#CORP_FAX_NO2").val()) && !isEmpty($("#CORP_FAX_NO3").val())){
					$("input[name=CORP_FAX_NO]").val( $("#CORP_FAX_NO1").val()+"-"+$("#CORP_FAX_NO2").val()+"-"+$("#CORP_FAX_NO3").val() );
				}else{
					$("input[name=CORP_FAX_NO]").val("");
				}				
				
				var CORP_DIVN_arr = new Array();
				var CORP_DIVN_cds = "";				
				// 기업구분
				$("input:checkbox[name=CORP_DIVN]").each(function(){
					if(this.checked){
						CORP_DIVN_arr.push(this.value);
					}
				});
				
				CORP_DIVN_cds = CORP_DIVN_arr.join(",");
				$("input[name=CORP_DIVN_cds]").val(CORP_DIVN_cds);
				
				
				// 회원구분
				var CORP_MEM_DIVN_arr = new Array();
				var CORP_MEM_DIVN_cds = "";

				$("input:radio[name=CORP_MEM_DIVN]").each(function(){
					if(this.checked){
						CORP_MEM_DIVN_arr.push(this.value);
					}
				});
				
				CORP_MEM_DIVN_cds = CORP_MEM_DIVN_arr.join(",");
				$("input[name=CORP_MEM_DIVN_cds]").val(CORP_MEM_DIVN_cds);				
				
				
				// 설비분야
				var CORP_FAC_DIVN_arr = new Array();
				var CORP_FAC_DIVN_cds = "";

				$("input:checkbox[name=CORP_FAC_DIVN]").each(function(){
					if(this.checked){
						CORP_FAC_DIVN_arr.push(this.value);
					}
				});
				
				CORP_FAC_DIVN_cds = CORP_FAC_DIVN_arr.join(",");
				$("input[name=CORP_FAC_DIVN_cds]").val(CORP_FAC_DIVN_cds);	
				
				// 제품유형
				var PROD_TY_arr = new Array();
				var PROD_TY_cds = "";

				$("input:checkbox[name=PROD_TY]").each(function(){
					if(this.checked){
						PROD_TY_arr.push(this.value);
					}
				});
				
				PROD_TY_cds = PROD_TY_arr.join(",");
				$("input[name=PROD_TY_cds]").val(PROD_TY_cds);				
				
				//return;
				// 이메일
				if(!isEmpty($("#email1").val()) && !isEmpty($("#email2").val())){
					$("input[name=CORP_EMAIL]").val( $("#email1").val()+"@"+$("#email2").val() );
				}else{
					$("input[name=CORP_EMAIL]").val("");
				}				
				
				
				var msg_str = "";
				<c:if test="${R_MAP.prodDtl != null && R_MAP.param.pstate == 'UF'}">
					$("#pstate").val("U");
					msg_str = "수정";
				</c:if>
				<c:if test="${R_MAP.prodDtl == null && R_MAP.param.pstate == 'CF'}">
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
			                	alert('중소기업 제품관에 '+msg_str+' 되었습니다.');
			                	$("#btn_list").trigger("click");
			               	}else{
								if(data.TRS_MSG!=""){
									alert(''+data.TRS_MSG);
								}else{
									alert('중소기업 제품관에 '+msg_str+'중 오류가 발생했습니다.1');
								}
			            	   CmcloseLoading();
			                }
			             },
					     error:function(request, status, error) {
					    	 CmcloseLoading();
					    	 alert('중소기업 제품관에 '+msg_str+'중 오류가 발생했습니다.2');
			             }
			    });				

			}
		});
		
		// 등록모드이고 로그인한경우 값을 셋팅한다
		<c:if test="${R_MAP.userDtl != null && R_MAP.param.pstate == 'CF'}">
			$("#CORP_NM").val(htmlTextAreaGridBr("<c:out value='${R_MAP.userDtl.grp_nm}'  escapeXml="false"/>"));
			
			$("#CORP_REPE_NM").val(htmlTextAreaGridBr("<c:out value='${R_MAP.userDtl.rprsntv}'  escapeXml="false"/>"));
			$("#CORP_NO").val("<c:out value='${R_MAP.userDtl.user_id}'  escapeXml="false"/>");
			
			var CORP_TEL_NO_1_str = "<c:out value='${R_MAP.userDtl.contact}'  escapeXml="false"/>";
			var CORP_TEL_NO_1_str_arr = CORP_TEL_NO_1_str.split("-");	
			if(CORP_TEL_NO_1_str!="" && CORP_TEL_NO_1_str_arr.length==3){
				$("#CORP_TEL_NO_11").val(nullToDefault(CORP_TEL_NO_1_str_arr[0], ""));
				$("#CORP_TEL_NO_12").val(nullToDefault(CORP_TEL_NO_1_str_arr[1], ""));
				$("#CORP_TEL_NO_13").val(nullToDefault(CORP_TEL_NO_1_str_arr[2], ""));
				$("#CORP_TEL_NO_1").val(nullToDefault(CORP_TEL_NO_1_str, ""));
			}			
			
		</c:if>
		
		// 수정모드인경우 값을 셋팅한다

		<c:if test="${R_MAP.prodDtl != null && R_MAP.param.pstate == 'UF'}">
			var di = 0;
			/////////////////////////////////////////////////////////////////////////////////////// 기업소개  	
			$("#CORP_NM").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.corp_nm}'  escapeXml="false"/>"));
			
			var CORP_DIVN_str = "<c:out value='${R_MAP.prodDtl.corp_divn}'  escapeXml="false"/>";
			var CORP_DIVN_str_arr = CORP_DIVN_str.split(",");
			//$("form[name=dataForm]").find("input:checkbox[name=CORP_DIVN]").each(function(idx){
				for(di=0;di<CORP_DIVN_str_arr.length;di++){
					$("form[name=dataForm]").find("input:checkbox[name=CORP_DIVN][value='"+CORP_DIVN_str_arr[di]+"']").attr("checked",true);
					//if(this.value==CORP_DIVN_str_arr[di]){
					//	$(this).attr("checked", true);
					//}	
					
				}

			//});
			var CORP_MEM_DIVN_str = "<c:out value='${R_MAP.prodDtl.corp_mem_divn}'  escapeXml="false"/>";
			var CORP_MEM_DIVN_str_arr = CORP_MEM_DIVN_str.split(",");	
				for(di=0;di<CORP_MEM_DIVN_str_arr.length;di++){
					$("form[name=dataForm]").find("input:radio[name=CORP_MEM_DIVN][value='"+CORP_MEM_DIVN_str_arr[di]+"']").attr("checked",true);
				}	
				
			var CORP_FAC_DIVN_str = "<c:out value='${R_MAP.prodDtl.corp_fac_divn}'  escapeXml="false"/>";
			var CORP_FAC_DIVN_str_arr = CORP_FAC_DIVN_str.split(",");	
				for(di=0;di<CORP_FAC_DIVN_str_arr.length;di++){
					$("form[name=dataForm]").find("input:checkbox[name=CORP_FAC_DIVN][value='"+CORP_FAC_DIVN_str_arr[di]+"']").attr("checked",true);
				}
				
			var PROD_TY_str = "<c:out value='${R_MAP.prodDtl.prod_ty}'  escapeXml="false"/>";
			var PROD_TY_str_arr = PROD_TY_str.split(",");	
				for(di=0;di<PROD_TY_str_arr.length;di++){
					$("form[name=dataForm]").find("input:checkbox[name=PROD_TY][value='"+PROD_TY_str_arr[di]+"']").attr("checked",true);
				}					
				
			$("#CORP_REPE_NM").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.corp_repe_nm}'  escapeXml="false"/>"));
			$("#CORP_EST_DT").val("<c:out value='${R_MAP.prodDtl.corp_est_dt}'  escapeXml="false"/>");
			$("#CORP_TTL_CNT").val("<c:out value='${R_MAP.prodDtl.corp_ttl_cnt}'  escapeXml="false"/>");
			$("#CORP_HIST").val(htmlTextAreaGridBr("<c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.prodDtl.corp_hist, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/>"));
			$("#CORP_MAIN_PROD").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.corp_main_prod}'  escapeXml="false"/>"));
			$("#CORP_NO").val("<c:out value='${R_MAP.prodDtl.corp_no}'  escapeXml="false"/>");
			
			var CORP_EMAIL_str = "<c:out value='${R_MAP.prodDtl.corp_email}'  escapeXml="false"/>";
			var CORP_EMAIL_str_arr = CORP_EMAIL_str.split("@");
			var email_str_yn = false;
			if(CORP_EMAIL_str_arr[0]!=null && CORP_EMAIL_str_arr[0]!=undefined && CORP_EMAIL_str_arr[0]!=''){
				$("form[name=dataForm]").find("select[name=email3] option").each(function(idx){
					if(this.value==CORP_EMAIL_str_arr[1]){
						email_str_yn = true;
					}
				});
				if(email_str_yn==true){
					$("#email1").val(CORP_EMAIL_str_arr[0]);
					$("#email2").val(CORP_EMAIL_str_arr[1]);
					$("#email3").val(CORP_EMAIL_str_arr[1]);
				}else{
					$("#email1").val(CORP_EMAIL_str_arr[0]);
					$("#email2").val(CORP_EMAIL_str_arr[1]);					
					$("#email3").val("직접입력");
				}
				
			}
			
			$("#CORP_LINK").val("<c:out value='${R_MAP.prodDtl.corp_link}'  escapeXml="false"/>");
			var CORP_TEL_NO_1_str = "<c:out value='${R_MAP.prodDtl.corp_tel_no_1}'  escapeXml="false"/>";
			var CORP_TEL_NO_1_str_arr = CORP_TEL_NO_1_str.split("-");	
			if(CORP_TEL_NO_1_str!=""){
				$("#CORP_TEL_NO_11").val(nullToDefault(CORP_TEL_NO_1_str_arr[0], ""));
				$("#CORP_TEL_NO_12").val(nullToDefault(CORP_TEL_NO_1_str_arr[1], ""));
				$("#CORP_TEL_NO_13").val(nullToDefault(CORP_TEL_NO_1_str_arr[2], ""));
				$("#CORP_TEL_NO_1").val(nullToDefault(CORP_TEL_NO_1_str, ""));
			}
			
			var CORP_FAX_NO_str = "<c:out value='${R_MAP.prodDtl.corp_fax_no}'  escapeXml="false"/>";
			var CORP_FAX_NO_str_arr = CORP_FAX_NO_str.split("-");	
			if(CORP_FAX_NO_str!=""){
				$("#CORP_FAX_NO1").val(nullToDefault(CORP_FAX_NO_str_arr[0], ""));
				$("#CORP_FAX_NO2").val(nullToDefault(CORP_FAX_NO_str_arr[1], ""));
				$("#CORP_FAX_NO3").val(nullToDefault(CORP_FAX_NO_str_arr[2], ""));
				$("#CORP_FAX_NO").val(nullToDefault(CORP_FAX_NO_str, ""));
			}			
			
			/////////////////////////////////////////////////////////////////////////////////////// 기업소개  	
			
			/////////////////////////////////////////////////////////////////////////////////////// 제품설명
			$("#PROD_NM").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.prod_nm}'  escapeXml="false"/>"));
			$("#PROD_DIVN").val("<c:out value='${R_MAP.prodDtl.prod_divn}'  escapeXml="false"/>");
			$("#PROD_FUNT").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.prod_funt}'  escapeXml="false"/>"));
			$("#TECH_STND").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.tech_stnd}'  escapeXml="false"/>"));
			$("#OPRT_PRCP").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.oprt_prcp}'  escapeXml="false"/>"));
			$("#DLVRY_RCD").val(htmlTextAreaGridBr("<c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.prodDtl.dlvry_rcd, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/>"));
			
			var fileList1_seq = "";
			var fileList1_nm = "";
			<c:forEach var="list" items="${R_MAP.fileList1}" varStatus="i">
				<c:if test="${i.count == 1}">
					fileList1_seq = "";
					fileList1_nm = "";
				</c:if>
												
					fileList1_seq = fileList1_seq+"<c:out value='${list.idx}'/>";
					fileList1_nm = fileList1_nm+"<c:out value='${list.fileNm}'/>";
	
				
				<c:if test="${i.count < fn:length(R_MAP.fileList1)}">
					fileList1_seq = fileList1_seq+",";
					fileList1_nm = fileList1_nm+",";								
				</c:if>
			</c:forEach>			
			
			
			var file_group1 = getFileHtmlArray(fileList1_seq, fileList1_nm);
			$.fn.cmfile.setfileList("cmfile1", file_group1);			
			/////////////////////////////////////////////////////////////////////////////////////// 제품설명
			
			/////////////////////////////////////////////////////////////////////////////////////// 인증현황
			$("#CERT_PROD").val(htmlTextAreaGridBr("<c:out value='${R_MAP.prodDtl.cert_prod}'  escapeXml="false"/>"));
			$("#CERT_DIVN").val("<c:out value='${R_MAP.prodDtl.cert_divn}'  escapeXml="false"/>");
			$("#CERT_DT").val("<c:out value='${R_MAP.prodDtl.cert_dt}'  escapeXml="false"/>");
			$("#CERT_EXPR_DT").val("<c:out value='${R_MAP.prodDtl.cert_expr_dt}'  escapeXml="false"/>");
			/////////////////////////////////////////////////////////////////////////////////////// 인증현황
			
			/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그
			var fileList2_seq = "";
			var fileList2_nm = "";
			<c:forEach var="list" items="${R_MAP.fileList2}" varStatus="i">
				<c:if test="${i.count == 1}">
					fileList2_seq = "";
					fileList2_nm = "";
				</c:if>
												
					fileList2_seq = fileList2_seq+"<c:out value='${list.idx}'/>";
					fileList2_nm = fileList2_nm+"<c:out value='${list.fileNm}'/>";
	
				
				<c:if test="${i.count < fn:length(R_MAP.fileList2)}">
					fileList2_seq = fileList2_seq+",";
					fileList2_nm = fileList2_nm+",";								
				</c:if>
			</c:forEach>			
			
			
			var file_group2 = getFileHtmlArray(fileList2_seq, fileList2_nm);
			$.fn.cmfile.setfileList("cmfile2", file_group2);
			/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그
			
		</c:if>		
		
		<c:if test="${R_MAP.prodDtl == null && R_MAP.param.pstate == 'CF'}">
			
		</c:if>	
});
	
	function fixCERT_DIVN(){
		
	}

	
	function fn_validation(){
		/////////////////////////////////////////////////////////////////////////////////////// 기업소개  
		if(isEmpty($("#CORP_NM").val())){
			alert("회사명을 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#CORP_NM').focus();
			return false;
		}else{
			if(getLength($('#CORP_NM').val()) > 100) {
				alert("회사명은 100 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_NM").focus();
				return false;
			}					
		}		
		

		if(!$('input:checkbox[name=CORP_DIVN]').is(':checked')){
			alert("기업구분을 선택해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('input:checkbox[name=CORP_DIVN]').eq(0).focus();
			return false;
		}else{
			/*$("input:checkbox[name=CORP_DIVN]").each(function(){
				if(this.checked && this.value=="000449"){
					if(isEmpty($("#CORP_DIVN").val())){
						alert("분석툴 기타를 입력해주세요.");
						$('.tabmenu2 ul li').eq(0).trigger("click");
						$('#CORP_DIVN_ETC').focus();
						return false;
					}else{
						if(getLength($('#CORP_DIVN_ETC').val()) > 4000) {
							alert("분석툴 기타는 4000 Byte 이하이어야 합니다.");
							$('.tabmenu2 ul li').eq(0).trigger("click");
							$("#CORP_DIVN_ETC").focus();
							return false;
						}					
					}					
				}
			});
			*/
		}
		
		if(!$('input:radio[name=CORP_MEM_DIVN]').is(':checked')){
			alert("회원구분을 선택해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('input:radio[name=CORP_MEM_DIVN]').eq(0).focus();
			return false;
		}else{
			/*$("input:radio[name=CORP_MEM_DIVN]").each(function(){
				if(this.checked && this.value=="000102"){
					if(isEmpty($("#CORP_MEM_DIVN_CD1").val())){
						alert("회원구분 기타를 입력해주세요.");
						$('.tabmenu2 ul li').eq(0).trigger("click");
						$('#CORP_MEM_DIVN_CD1').focus();
						return false;
					}else{
						if(getLength($('#req_purps_cd1').val()) > 200) {
							alert("회원구분 기타는 200 Byte 이하이어야 합니다.");
							$('.tabmenu2 ul li').eq(0).trigger("click");
							$("#CORP_MEM_DIVN_CD1").focus();
							return false;
						}					
					}					
				}
			});	
			*/
		}	
		
		if(!$('input:checkbox[name=CORP_FAC_DIVN]').is(':checked')){
			alert("설비분야를 선택해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('input:checkbox[name=CORP_FAC_DIVN]').eq(0).focus();
			return false;
		}else{
			/*$("input:checkbox[name=CORP_DIVN]").each(function(){
				if(this.checked && this.value=="000449"){
					if(isEmpty($("#CORP_DIVN").val())){
						alert("분석툴 기타를 입력해주세요.");
						$('.tabmenu2 ul li').eq(0).trigger("click");
						$('#CORP_DIVN_ETC').focus();
						return false;
					}else{
						if(getLength($('#CORP_DIVN_ETC').val()) > 4000) {
							alert("분석툴 기타는 4000 Byte 이하이어야 합니다.");
							$('.tabmenu2 ul li').eq(0).trigger("click");
							$("#CORP_DIVN_ETC").focus();
							return false;
						}					
					}					
				}
			});
			*/
		}	
		
		if(!$('input:checkbox[name=PROD_TY]').is(':checked')){
			alert("제품유형을 선택해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('input:checkbox[name=PROD_TY]').eq(0).focus();
			return false;
		}else{
			/*$("input:checkbox[name=CORP_DIVN]").each(function(){
				if(this.checked && this.value=="000449"){
					if(isEmpty($("#CORP_DIVN").val())){
						alert("분석툴 기타를 입력해주세요.");
						$('.tabmenu2 ul li').eq(0).trigger("click");
						$('#CORP_DIVN_ETC').focus();
						return false;
					}else{
						if(getLength($('#CORP_DIVN_ETC').val()) > 4000) {
							alert("분석툴 기타는 4000 Byte 이하이어야 합니다.");
							$('.tabmenu2 ul li').eq(0).trigger("click");
							$("#CORP_DIVN_ETC").focus();
							return false;
						}					
					}					
				}
			});
			*/
		}		
		
		if(isEmpty($("#CORP_REPE_NM").val())){
				//alert("대표자명을 입력해주세요.");
				//$('.tabmenu2 ul li').eq(0).trigger("click");
				//$('#CORP_REPE_NM').focus();
				//return false;
		}else{
				if(getLength($('#CORP_REPE_NM').val()) > 50) {
					alert("대표자명은 15 Byte 이하이어야 합니다.");
					$('.tabmenu2 ul li').eq(0).trigger("click");
					$("#CORP_REPE_NM").focus();
					return false;
				}					
		}	
		
		if(isEmpty($("#CORP_EST_DT").val())){
			//alert("설립일을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_EST_DT').focus();
			//return false;
		}else{
			if (!isValidDate($('#CORP_EST_DT').val().replace(/-/gi,""))) {
				alert("설립일이 유효한 날짜가 아닙니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_EST_DT").focus();
				return false;
			}
				
		}	
		
		if(isEmpty($("#CORP_TTL_CNT").val())){
			//alert("종업원수를 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_TTL_CNT').focus();
			//return false;
		}else{
			if(getLength($('#CORP_TTL_CNT').val()) > 7) {
				alert("종업원수는 7 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_TTL_CNT").focus();
				return false;
			}					
		}
		
		if(isEmpty($("#CORP_HIST").val())){
			//alert("회사연혁을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_HIST').focus();
			//return false;
		}else{
			if(getLength($('#CORP_HIST').val()) > 10000) {
				alert("회사연혁은 10000 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_HIST").focus();
				return false;
			}					
		}
		
		if(isEmpty($("#CORP_MAIN_PROD").val())){
			//alert("주요생산품을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_MAIN_PROD').focus();
			//return false;
		}else{
			if(getLength($('#CORP_MAIN_PROD').val()) > 500) {
				alert("주요생산품은 500 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_MAIN_PROD").focus();
				return false;
			}					
		}		
		
		if(isEmpty($("#CORP_NO").val())){
			//alert("사업자번호을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_NO').focus();
			//return false;
		}else{
			if(getLength($('#CORP_NO').val()) > 50) {
				alert("사업자번호는 50 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_NO").focus();
				return false;
			}
			
			if(!ischeckCompNmbr($('#CORP_NO').val())){
				alert("유효한 사업자번호가 아닙니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_NO").focus();
				return false;						
			}			
		}
		
		if(isEmpty($("#email1").val())){
			alert("이메일 아이디를 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#email1').focus();
			return false;
		}else if(isEmpty($("#email2").val())){
			alert("이메일 도메인을 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#email2').focus();
			return false;
		}else{
			if(getLength($('#email1').val()+"@"+$('#email2').val()) > 100) {
				alert("이메일은 100 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#email1").focus();
				return false;
			}
			
			if(isMail($('#email1').val()+"@"+$('#email2').val())){
				alert("이메일주소가 유효하지 않습니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#email1").focus();
				return false;				
			}
		}	
		
		if(isEmpty($("#CORP_LINK").val())){
			//alert("홈페이지를 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_LINK').focus();
			//return false;
		}else{
			if(getLength($('#CORP_LINK').val()) > 500) {
				alert("홈페이지는 500 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_LINK").focus();
				return false;
			}
			
			if(!isUrl($('#CORP_LINK').val())){
				alert("유효한 홈페이지 주소가 아닙니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_LINK").focus();
				return false;						
			}			
		}	
		
		if(isEmpty($("#CORP_TEL_NO_11").val())){ 
			alert("대표번호를 첫자리를 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#CORP_TEL_NO_11').focus();
			return false;
		}else if(isEmpty($("#CORP_TEL_NO_12").val())){
			alert("대표번호를 중간자리를 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#CORP_TEL_NO_12').focus();
			return false;
		}else if(isEmpty($("#CORP_TEL_NO_13").val())){
			alert("대표번호를 끝자리를 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
			$('#CORP_TEL_NO_13').focus();
			return false;
		}else{
			if(getLength($("#CORP_TEL_NO_11").val()+"-"+$("#CORP_TEL_NO_12").val()+"-"+$("#CORP_TEL_NO_13").val()) > 50) {
				alert("대표번호는 50 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_TEL_NO_11").focus();
				return false;
			}
			
			
		}	
		
		if(isEmpty($("#CORP_FAX_NO1").val()) || isEmpty($("#CORP_FAX_NO2").val()) || isEmpty($("#CORP_FAX_NO3").val())){
			//alert("팩스번호를 입력해주세요.");
			//$('.tabmenu2 ul li').eq(0).trigger("click");
			//$('#CORP_FAX_NO1').focus();
			//return false;
		}else{
			if(getLength($("#CORP_FAX_NO1").val()+"-"+$("#CORP_FAX_NO2").val()+"-"+$("#CORP_FAX_NO3").val()) > 50) {
				alert("팩스번호는 50 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("#CORP_FAX_NO1").focus();
				return false;
			}
			
			
		}	
		
		if(isEmpty($("input[name=SECRET_NO]").val())){
			alert("패스워드을 입력해주세요.");
			$('.tabmenu2 ul li').eq(0).trigger("click");
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
				$('.tabmenu2 ul li').eq(0).trigger("click");
				$("input[name=SECRET_NO]").focus();
				return false;
			}*/
		}		
		
/////////////////////////////////////////////////////////////////////////////////////// 기업소개  	

/////////////////////////////////////////////////////////////////////////////////////// 제품설명	
		
		if(isEmpty($("input[name=PROD_NM]").val())){
			alert("제품명을 입력해주세요.");
			$('.tabmenu2 ul li').eq(1).trigger("click");
			$("input[name=PROD_NM]").focus();
			return false;
		}else{
			
			if($("input[name=PROD_NM]").val().length > 100 ){
				alert('제품명은 100 Byte 이하이어야 합니다.');
				$('.tabmenu2 ul li').eq(1).trigger("click");
				$("input[name=PROD_NM]").focus();
				return false;
			}
		}
		
		if(isEmpty($("input[name=PROD_FUNT]").val())){
			//alert("제품특징을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(1).trigger("click");
			//$("input[name=PROD_FUNT]").focus();
			//return false;
		}else{
			
			if($("input[name=PROD_FUNT]").val().length > 1000 ){
				alert('제품특징은 1000 Byte 이하이어야 합니다.');
				$('.tabmenu2 ul li').eq(1).trigger("click");
				$("input[name=PROD_FUNT]").focus();
				return false;
			}
		}	
		
		if(isEmpty($("input[name=TECH_STND]").val())){
			//alert("기술규격을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(1).trigger("click");
			//$("input[name=PROD_FUNT]").focus();
			//return false;
		}else{
			
			if($("input[name=TECH_STND]").val().length > 1000 ){
				alert('기술규격은 1000 Byte 이하이어야 합니다.');
				$('.tabmenu2 ul li').eq(1).trigger("click");
				$("input[name=TECH_STND]").focus();
				return false;
			}
		}	
		
		if(isEmpty($("input[name=OPRT_PRCP]").val())){
			//alert("동작원리를 입력해주세요.");
			//$('.tabmenu2 ul li').eq(1).trigger("click");
			//$("input[name=OPRT_PRCP]").focus();
			//return false;
		}else{
			
			if($("input[name=OPRT_PRCP]").val().length > 1000 ){
				alert('동작원리는 1000 Byte 이하이어야 합니다.');
				$('.tabmenu2 ul li').eq(1).trigger("click");
				$("input[name=OPRT_PRCP]").focus();
				return false;
			}
		}	
		
		if(isEmpty($("#DLVRY_RCD").val())){
			//alert("납품실적을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(1).trigger("click");
			//$('#DLVRY_RCD').focus();
			//return false;
		}else{
			if(getLength($('#DLVRY_RCD').val()) > 10000) {
				alert("납품실적은 10000 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(1).trigger("click");
				$("#DLVRY_RCD").focus();
				return false;
			}					
		}		

		// 상품이미지 첨부파일이 입력되어 있는지 확인한다
		if($.fn.cmfile.getfilelistcnt("cmfile1")==0){
			alert("상품이미지 파일이 1개이상 등록되어야 합니다");
			$('.tabmenu2 ul li').eq(1).trigger("click");
			return false;
		}
		
	
/////////////////////////////////////////////////////////////////////////////////////// 제품설명			
	
		
/////////////////////////////////////////////////////////////////////////////////////// 인증현황		
		if(isEmpty($("#CERT_PROD").val())){
			//alert("인증품목을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(2).trigger("click");
			//$('#CERT_PROD').focus();
			//return false;
		}else{
			if(getLength($('#CERT_PROD').val()) > 100) {
				alert("인증품목은 100 Byte 이하이어야 합니다.");
				$('.tabmenu2 ul li').eq(2).trigger("click");
				$("#CERT_PROD").focus();
				return false;
			}					
		}
		
		if(isEmpty($("#CERT_DIVN").val())){
			//alert("인증품목을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(2).trigger("click");
			//$('#CERT_DIVN').focus();
			//return false;
		}else{
					
		}	
		
		if(isEmpty($("#CERT_DT").val())){
			//alert("인증일을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(2).trigger("click");
			//$('#CERT_DT').focus();
			//return false;
		}else{
			if (!isValidDate($('#CERT_DT').val().replace(/-/gi,""))) {
				alert("인증일이 유효한 날짜가 아닙니다.");
				$('.tabmenu2 ul li').eq(2).trigger("click");
				$("#CERT_DT").focus();
				return false;
			}
				
		}	

		if(isEmpty($("#CERT_EXPR_DT").val())){
			//alert("인증만료일을 입력해주세요.");
			//$('.tabmenu2 ul li').eq(2).trigger("click");
			//$('#CERT_EXPR_DT').focus();
			//return false;
		}else{
			if (!isValidDate($('#CERT_EXPR_DT').val().replace(/-/gi,""))) {
				alert("인증만료일이 유효한 날짜가 아닙니다.");
				$('.tabmenu2 ul li').eq(2).trigger("click");
				$("#CERT_EXPR_DT").focus();
				return false;
			}
				
		}		

		
/////////////////////////////////////////////////////////////////////////////////////// 인증현황	

/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그
		// 카탈로그 첨부파일이 입력되어 있는지 확인한다
		if($.fn.cmfile.getfilelistcnt("cmfile2")==0){
			//alert("카탈로그 파일이 1개이상 등록되어야 합니다");
			//$('.tabmenu2 ul li').eq(3).trigger("click");
			//return false;
		}
/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그

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
	
</script>

