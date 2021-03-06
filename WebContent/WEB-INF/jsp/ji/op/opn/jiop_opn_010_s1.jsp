<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_010_s1.jsp
%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode" 				name="scode" 	value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 	value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 	value="<%=pstate %>" />
<input type="hidden" 	id="page" 				name="page" 	value="${R_MAP.param.page}"/>
<input type="hidden" 	id="othbc_yn" 			name="othbc_yn" />

<c:if test="${R_MAP.param.pcode == '000470'}">
                <div class="cts_mid">
                    <h4 class="titleB">연구개발(R&amp;D) 아이디어 제안센터를 찾아 주셔서 감사합니다.</h4>
                    <div class="prg firstPrg">
                        <p>한국중부발전은 연구개발기업의 기발한 아이디어 및 개선사항 청취를 위한 외부이해관계자 제안센터인 아이디어 제안센터를 운영하고 있습니다.</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">제안분야</h4>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere01.png" alt="제안">
                                <div>
                                    <p>신규 연구개발 과제(아이디어) 제안</p>
                                </div>
                            </div>
                        </div>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere02.png" alt="건의">
                                <div>
                                    <p>연구개발 지원 관련 개선을 위한 건의사항</p>
                                </div>
                            </div>
                        </div>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere03.png" alt="Q&A">
                                <div>
                                    <p>중부발전 연구개발사업 관련 Q & A</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">절차</h4>
                        <div class="stepList">
                            <ul>
                                <li><p>제안제출</p></li>
                                <li><p>접수</p></li>
                                <li><p>부서할당</p></li>
                                <li><p>부서검토</p></li>
                                <li><p>채택 및 실행</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">절차</h4>
                        <div class="receiptList">
                            <div>
                                <div class="textArea">
                                    <p>제안 접수</p>
                                    <span>연구개발에 대한 중소기업의 제안을 받고 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_reg_gologin" onclick='return false;' style="padding:5px 10px;">로그인후제안하기</a>
										<a href="#" class="btnB" id="btn_reg_goagree" onclick='return false;' style="padding:5px 10px;">본인인증후제안하기</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_reg_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>

                                </div>
                            </div>
                            <div>
                                <div class="textArea">
                                    <p>제안 접수 확인</p>
                                    <span>입력하신 접수 내용을 확인 하실 수 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_list_gologin" onclick='return false;' style="padding:5px 10px;">로그인후확인</a>
										<a href="#" class="btnB" id="btn_list_goagree" onclick='return false;' style="padding:5px 10px;">입력정보로확인</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_list_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>                                    

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleAlert">알림내용</h4>
                        <div class="numList">
                            <ul>
                                <li>
                                    <span>연구개발사업에 대하여 중소기업의 제안을 받고 있습니다.</span>
                                    <span>I-PIN 인증 후 제안센터를 이용하실 수 있습니다.</span>
                                    <span>성격에 맞지 않거나 악의적인 제목, 비방글, 욕설 등은 관리자에 의해 숨김 처리될 수 있습니다.</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
</c:if> 

<c:if test="${R_MAP.param.pcode == '000523'}">
                <div class="cts_mid">
                    <h4 class="titleB">지원사업 아이디어 제안센터 소개</h4>
                    <div class="prg firstPrg">
                        <p>한국중부발전은 중소기업과 함께 상생하기 위하여 항상 귀 기울이며 노력하고 있습니다.</p>
                        <p>이에 중소기업의 아이디어 및 제안을 적극 반영하여 중소기업 지원하기 좋은 환경 조성을 위한 공간을 운영하고 있습니다.</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적 및 추진방향</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li><p>지원사업 아이디어 제안센터는 중소기업 여러분의 아이디어 및 제안을 받고 있습니다.</p></li>
                                    <li><p>접수된 중소기업 여러분의 아이디어 및 제안을 신속하게 해결해 드릴것입니다.</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>                    
                    <!-- <div class="prg">
                        <h4 class="titleM">제안분야</h4>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere01.png" alt="">
                                <span class="none">제안</span>
                                <div>
                                    <p>신규 지원사업(아이디어) 제안</p>
                                </div>
                            </div>
                        </div>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere02.png" alt="">
                                <span class="none">건의</span>
                                <div>
                                    <p>지원사업 관련 개선을 위한 건의사항</p>
                                </div>
                            </div>
                        </div>
                        <div class="listImg">
                            <div class="inner">
                                <img src="<%=con_root%>/images/project_img/sub/sphere03.png" alt="">
                                <span class="none">Q & A</span>
                                <div>
                                    <p>중부발전 지원사업 관련 Q & A</p>
                                </div>
                            </div>
                        </div>
                    </div>
                     -->
                    <div class="prg">
                        <h4 class="titleM">지원사업 아이디어 및 제안 처리 절차</h4>
                        <div class="border_p">
                            <div class="squareList">
                                <ul>
                                    <li class="f_left">
                                        <em>01</em>
                                        <div class="inner">
                                            <p>중소기업의 아이디어 <br />
                                            	및 제안 사항 접수
                                            </p>
                                            
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <em>02</em>
                                        <div class="inner">
                                            <p>사전검토<br />&nbsp;</p>
                                           
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <em>03</em>
                                        <div class="inner">
                                            <p>아이디어 및  <br />
                                            	제안 심의회</p>
                                            
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <em>04</em>
                                        <div class="inner">
                                            <p>아이디어 및 제안 반영<br />
                                            	지원사업 시행
                                            </p>
                                            
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>     
                    <div class="prg">
                        <h4 class="titleM">지원사업 아이디어 및 제안 유형</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li><p>경영혁신 지원사업 분야</p></li>
                                    <li><p>해외 판로확대 분야</p></li>
                                    <li><p>인력·금융·교육·복지 분야</p></li>
                                    <li><p>육성사업 분야</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>                    
                    <!--              
                    <div class="prg">
                        <h4 class="titleM">지원사업 아이디어 및 제안 처리 절차</h4>
                        <div class="stepList">
                            <ul>
                                <li><p>제안제출</p></li>
                                <li><p>접수</p></li>
                                <li><p>부서할당</p></li>
                                <li><p>부서검토</p></li>
                                <li><p>채택 및 실행</p></li>
                            </ul>
                        </div>
                    </div> -->   
                    <div class="prg">
                        <h4 class="titleM">온라인 아이디어 및 제안접수 절차</h4>
                        <div class="receiptList">
                            <div>
                                <div class="textArea">
                                    <p>제안 접수</p>
                                    <span>지원사업에 대한 중소기업의 제안을 받고 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_reg_gologin" onclick='return false;' style="padding:5px 10px;">로그인후제안하기</a>
										<a href="#" class="btnB" id="btn_reg_goagree" onclick='return false;' style="padding:5px 10px;">본인인증후제안하기</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_reg_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>
                                </div>
                            </div>
                            <div>
                                <div class="textArea">
                                    <p>제안 접수 확인</p>
                                    <span>입력하신 접수 내용을 확인 하실 수 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_list_gologin" onclick='return false;' style="padding:5px 10px;">로그인후확인</a>
										<a href="#" class="btnB" id="btn_list_goagree" onclick='return false;' style="padding:5px 10px;">입력정보로확인</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_list_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleAlert">지원사업 아이디어 제안사항 신청안내</h4>
                        <div class="numList">
                            <ul>
                                <li>
                                    <span>지원사업 아이디어 및 제안사항 직접방문 신청.</span>
                                    <span>동반성장 오픈플랫폼 시스템을 통한 온라인신청.</span>
                                    <span>지원사업 아이디어 및 제안사항 상담원과 직접통화.
                                    	<br />- 한국중부발전(주) 동반성장부 전화 070-7511-1741
                                    </span>
                                    <span>지원사업 아이디어 및 제안사항을 구체적으로 기술하여 팩스 신청.
                                    	<br />- 한국중부발전(주) 동반성장부 FAX 070-7511-1193
                                    </span> 
                                    <span>지원사업 아이디어 및 제안사항을 구체적으로 기술하여 우편 신청.
                                    	<br />- 한국중부발전(주) 동반성장부 지원사업 아이디어 및 제안센터
                                    	<br /> (우편번호 33439)
                                    	<br /> 충남 보령시 보령북로 160 한국중부발전(주) 사회가치혁신실 동반성장부
                                    </span>                                                                       
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
</c:if>

<c:if test="${R_MAP.param.pcode == '000552'}">
                <div class="cts_mid">
                    <h4 class="titleB">수출규제 중소기업 피해지원센터입니다.</h4>
                    <div class="prg firstPrg">
                        <p>한국중부발전은 수출규제 중소기업 피해지원센터를 운영하고 있습니다.</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적 및 추진방향</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li><p>수출규제에 따라 해외 소재부품 수급 등 어려움을 겪고 있는 협력 중소기업의 애로사항 및 피해사항을 접수 합니다.</p></li>
                                    <li><p>접수 사항에 대해서는 저리 경영안전자금 및 기업지원사업을 우선 지원뿐만 아니라 민·관 합동 조직인 「소재부품 수급 대응 지원센터」와 협조하여 신속한 지원이 되도록 하겠습니다.</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">절차</h4>
                        <div class="receiptList">
                            <div>
                                <div class="textArea">
                                    <p>피해 접수</p>
                                    <span>수출규제 중소기업 피해접수를 받고 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_reg_gologin" onclick='return false;' style="padding:5px 10px;">로그인후접수하기</a>
										<a href="#" class="btnB" id="btn_reg_goagree" onclick='return false;' style="padding:5px 10px;">본인인증후접수하기</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_reg_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>

                                </div>
                            </div>
                            <div>
                                <div class="textArea">
                                    <p>피해 접수 확인</p>
                                    <span>입력하신 접수 내용을 확인 하실 수 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_list_gologin" onclick='return false;' style="padding:5px 10px;">로그인후확인</a>
										<a href="#" class="btnB" id="btn_list_goagree" onclick='return false;' style="padding:5px 10px;">입력정보로확인</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_list_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>                                    

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleAlert">알림내용</h4>
                        <div class="numList">
                            <ul>
                                <li>
                                    <span>수출규제 중소기업 피해접수를 받고 있습니다.</span>
                                    <span>I-PIN 인증 후 제안센터를 이용하실 수 있습니다.</span>
                                    <span>성격에 맞지 않거나 악의적인 제목, 비방글, 욕설 등은 관리자에 의해 숨김 처리될 수 있습니다.</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
</c:if>

<c:if test="${R_MAP.param.pcode == '000554'}">
                <div class="cts_mid">
                    <h4 class="titleB">코로나 19 중소기업 피해지원센터입니다.</h4>
                    <div class="prg firstPrg">
                        <p>한국중부발전은 신종 코로나19 감염증 확산에 따른 중소기업 피해지원센터를 운영하고 있습니다.</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li><p>신종 코로나바이러스 감염증 확산으로 협력 중소기업 애로사항 및 피해사항을 접수합니다.</p></li>
                                    <li><p>접수사항에 대해서는 긴급 경영안정자금 대출 및 기업지원사업을 우선 지원뿐만 아니라, 협력 중소기업 임직원 마스크, 손세정제 등<br/> 예방용품을 중소기업유통센터와 협의하여 신속한 지원이 되도록 노력하겠습니다.</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">절차</h4>
                        <div class="receiptList">
                            <div>
                                <div class="textArea">
                                    <p>피해 접수</p>
                                    <span>코로나 19 중소기업 피해접수를 받고 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_reg_gologin" onclick='return false;' style="padding:5px 10px;">로그인후접수하기</a>
										<a href="#" class="btnB" id="btn_reg_goagree" onclick='return false;' style="padding:5px 10px;">본인인증후접수하기</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_reg_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>

                                </div>
                            </div>
                            <div>
                                <div class="textArea">
                                    <p>피해 접수 확인</p>
                                    <span>입력하신 접수 내용을 확인 하실 수 있습니다.</span>
									<c:if test="${nUser == 'N'}">
										<a href="#" class="btnB" id="btn_list_gologin" onclick='return false;' style="padding:5px 10px;">로그인후확인</a>
										<a href="#" class="btnB" id="btn_list_goagree" onclick='return false;' style="padding:5px 10px;">입력정보로확인</a>
									</c:if>
									<c:if test="${nUser != 'N' && nUser != ''}">
										<a href="#" class="btnB" id="btn_list_login" onclick='return false;' style="padding:5px 10px;">바로가기</a>
									</c:if>                                    

                                </div>
                            </div>
                        </div>
                    </div>
<!--                     <div class="prg">
                        <h4 class="titleAlert">알림내용</h4>
                        <div class="numList">
                            <ul>
                                <li>
                                    <span>수출규제 중소기업 피해접수를 받고 있습니다.</span>
                                    <span>I-PIN 인증 후 제안센터를 이용하실 수 있습니다.</span>
                                    <span>성격에 맞지 않거나 악의적인 제목, 비방글, 욕설 등은 관리자에 의해 숨김 처리될 수 있습니다.</span>
                                </li>
                            </ul>
                        </div>
                    </div> -->
                </div>
</c:if> 

 
</form>

	

<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('#contents').parent('div').addClass('manager');
		
		
		$("#btn_reg").click( function() {
			//alert("임시오픈중에는 등록이 안됩니다.");
			//return;			
			if("N" == "<c:out value='${nUser}'/>"){
				// 회원로그인 확인
				if(confirm('로그인 또는 본인인증 후 사용가능합니다.\n확인을 선택하시면 로그인화면으로 취소를 누르시면 본인인증화면으로 이동합니다.')){
					//document.location.href="<c:url value='/cmsmain.do'/>?scode=S01&pcode=000253";
					Go_LoginPageView("<%=pcode %>", "CF","");
					
				// 본인인증 페이지로 이동
				}else{
					$("#dataForm").find("#pstate").val("CF1");
					$("#dataForm").submit();					
				}
			}else{
				$("#dataForm").find("#pstate").val("CF");
				$("#dataForm").submit();
			}
		});
		
		$("#btn_reg_login").click( function() {
			$("#dataForm").find("#pstate").val("CF");
			//$("#dataForm").submit();
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();			
		});	

		$("#btn_reg_gologin").click( function() {
			Go_LoginPageView("<%=pcode %>", "CF","");		
		});	

		$("#btn_reg_goagree").click( function() {
			$("#dataForm").find("#pstate").val("CF1");
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();		
		});			
		
		$("#btn_list").click( function() {
			//alert("임시오픈중에는 등록이 안됩니다.");
			//return;			
			if("N" == "<c:out value='${nUser}'/>"){
				// 회원로그인 확인
				if(confirm('로그인 또는 등록시 등록한정보입력 후 사용가능합니다.\n확인을 선택하시면 로그인화면으로 취소를 누르시면 등록정보 확인화면으로 이동합니다.')){
					//document.location.href="<c:url value='/cmsmain.do'/>?scode=S01&pcode=000253";
					Go_LoginPageView("<%=pcode %>", "L2","");
				// 등록정보 확인화면 페이지로 이동
				}else{
					$("#dataForm").find("#pstate").val("L1");
					$("#dataForm").submit();					
				}
			}else{
				$("#dataForm").find("#pstate").val("L2");
				$("#dataForm").submit();
			}
		});
		
		$("#btn_list_login").click( function() {
			$("#dataForm").find("#pstate").val("L2");
			//$("#dataForm").submit();
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();			
		});	

		$("#btn_list_gologin").click( function() {
			Go_LoginPageView("<%=pcode %>", "L2","");		
		});	

		$("#btn_list_goagree").click( function() {
			$("#dataForm").find("#pstate").val("L1");
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();		
		});		
		
		
	
	});
		
	

//]]>
</script>
