<%@page pageEncoding="utf-8"%>	                    <div class="prg lastPrg">                    	<div style="text-align:center;">                         <!--                         <div class="certify">                            <div class="inner">                                <img src="<%=con_root%>/images/project_img/common/certify01.png" alt="" />                                <div>                                    <p>개인회원 (만14세 이상의 고객)</p>                                    <div class="btnArea">                                        <a href="#" class="btnB" id="L3-1">인증하기</a>                                    </div>                                </div>                            </div>                        </div>                        <div class="certify">                            <div class="inner">                                <img src="<%=con_root%>/images/project_img/common/certify02.png" alt="" />                                <div>                                    <p>개인회원 (만14세 미만의 고객)</p>                                    <div class="btnArea">                                        <a href="#" class="btnG" id="L3-2">인증하기</a>                                    </div>                                </div>                            </div>                        </div>                         -->                                                <div class="certify" style="float:none;width:100%;">                            <div class="inner">                                <img src="<%=con_root%>/images/project_img/common/certify03.png" alt="" />                                <div>                                    <p>기관회원</p>                                    <div class="btnArea">                                        <a href="#" class="btnO" id="L3-0">인증하기</a>                                    </div>                                </div>                            </div>                        </div>                        </div>                    </div>                    <span class="txtNotice">* 본인 인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며, 인증 이외의 용도로 이용 또는 저장하지 않습니다.</span><form action="<%=RequestURL%>" method="post" name="my_form" onSubmit="return false;"> <input type="hidden" name="scode" value="<%=scode %>" /> <input type="hidden" name="pcode" value="<%=pcode %>" /> <input type="hidden" name="pstate" value="<%=pstate %>" /> <input type="hidden" name="agree_1" value="${agree_1}" /> <input type="hidden" name="agree_2" value="${agree_2}" /> <input type="hidden" name="agree_3" value="${agree_3}" /> <input type="hidden" name="agree_4" value="${agree_4}" /></form>					<script type="text/javascript">//<![CDATA[	$(function(){		$('#contents').parent('div').addClass('join join02');		$(".lastPrg").find("a").click( function() {			$("form[name=my_form]").find("input[name=pstate]").val(this.id);			document.my_form.submit();		});			});//]]></script>