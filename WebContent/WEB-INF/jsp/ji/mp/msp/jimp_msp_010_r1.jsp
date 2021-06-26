<%@ page language="java" contentType="text/html; charset=utf-8" %>
<c:set var="nUser" value="<%=userId%>"/>
<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<form id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode"  					name="scode" 				value="<%=scode%>" title="사이트코드" />
<input type="hidden" 	id="pcode"  					name="pcode" 				value="<%=pcode%>" title="페이지코드" />
<input type="hidden" 	id="pstate"  					name="pstate" 				value="<%=pstate%>" title="페이지상태" />
<input type="hidden" 	id="page" 						name="page" 				value="${R_MAP.param.page}"/>
<input type="hidden" 	id="searchTab" 					name="searchTab" 			value="${R_MAP.param.searchTab}" />
<input type="hidden" 	id="searchGubun" 				name="searchGubun" 			value="${R_MAP.param.searchGubun}" />
<input type="hidden" 	id="searchValue" 				name="searchValue" 			value="${R_MAP.param.searchValue}" />
 <input type="hidden" 	id="prod_seq" 					name="prod_seq" 			value="${R_MAP.param.prod_seq}"/>
 <input type="hidden" 	id="ichk_secret_no" 			name="ichk_secret_no" 		value=""/>

				<div class="cts_mid">
                    <div class="prg">
                        <div class="imgArea">
							<c:forEach var="list" items="${R_MAP.fileList1}" varStatus="i">
								<c:if test="${i.count == 1}">
		                            <div class="imgInner"><!-- 대표이미지 -->
		                            	<img id="main_img_id" src="<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN&fpcode=<c:out value="${R_MAP.param.pcode}" />&sidx=<c:out value="${R_MAP.prodDtl.prod_seq}" />&fidx=<c:out value="${i.count}" />&img_type=aaa"  alt="<c:out value="${R_MAP.prodDtl.prod_nm}"/>"  />
		                            </div>	
		                           <div class="product_img mobileImg">
										<ul>
								</c:if>
																
								<c:if test="${i.count == 1}">
									<li class="pic">
								</c:if>
								
								<c:if test="${i.count != 1}">
									<li>
								</c:if>	
								
									<a href="#" onclick="return false;">
										<img src="<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN&fpcode=<c:out value="${R_MAP.param.pcode}" />&sidx=<c:out value="${R_MAP.prodDtl.prod_seq}" />&fidx=<c:out value="${i.count}" />&img_type=thumnail_file"  alt="<c:out value="${list.fileNm}"/>" />
									</a>
									</li>							
								
								<c:if test="${i.count == fn:length(R_MAP.fileList1)}">
		                                </ul>
		                            </div>								
								</c:if>
							</c:forEach>                        

                        </div>
                        <div class="productInfo">
                            <h5><c:out value="${R_MAP.prodDtl.prod_nm}" escapeXml="false"/></h5>
                            <div class="tableArea">
                                <table class="tableB">
                                    <caption>회사명, 홈페이지, 대표번호, 이메일</caption>
                                    <colgroup>
                                        <col width="32%">
                                        <col width="*">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>회사명</th>
                                            <td><c:out value="${R_MAP.prodDtl.corp_nm}"  escapeXml="false"/></td>
                                        </tr>
                                        <tr>
                                            <th>홈페이지</th>
                                            <td>
                                            <c:choose>
	                                            <c:when test="${fn:indexOf(R_MAP.prodDtl.corp_link, 'http://' ) != -1}">
	                                            	<a href="${R_MAP.prodDtl.corp_link}" target="_blank"><c:out value="${R_MAP.prodDtl.corp_link}"  escapeXml="false"/></a>
	                                            </c:when>
	                                            <c:otherwise>
	                                            	<a href="http://${R_MAP.prodDtl.corp_link}" target="_blank"><c:out value="${R_MAP.prodDtl.corp_link}"  escapeXml="false"/></a>
	                                            </c:otherwise>
                                            </c:choose>
                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>대표번호</th>
                                            <td><c:out value="${R_MAP.prodDtl.corp_tel_no_1}"  escapeXml="false"/></td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td><c:out value="${R_MAP.prodDtl.corp_email}"  escapeXml="false"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
		                    <div class="product_img">
								<ul>                            
							<c:forEach var="list" items="${R_MAP.fileList1}" varStatus="i">
								<c:if test="${i.count == 1}">

								</c:if>
																
								<c:if test="${i.count == 1}">
									<li class="pic">
								</c:if>
								
								<c:if test="${i.count != 1}">
									<li>
								</c:if>	
								
									<a href="#" onclick="return false;">
										<img src="<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN&fpcode=<c:out value="${R_MAP.param.pcode}" />&sidx=<c:out value="${R_MAP.prodDtl.prod_seq}" />&fidx=<c:out value="${i.count}" />&img_type=thumnail_file"  alt="<c:out value="${list.fileNm}"/>" onclick="main_image_chg(this.src,this.alt,'N')" />
									</a>
									</li>							
								
								<c:if test="${i.count == fn:length(R_MAP.fileList1)}">
								
								</c:if>
							</c:forEach> 
		                         </ul>
		                      </div>							                           
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">기업소개</h4>
                        <div class="tableArea">
                            <table class="tableC colTable">
                                <caption>기업소개-회사명,대표자명,설립일,종업원수,기업구분,회원구분,설비분야,제품유형,회사연혁,주요생산품,사업자번호,팩스번호,</caption>
                                <colgroup>
                                    <col width="15%">
                                    <col width="35%">
                                    <col width="15%">
                                    <col width="35%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>회사명</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_nm}"  escapeXml="false"/></td>
                                        <th>대표자명</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_repe_nm}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>설립일</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_est_dt}"  escapeXml="false"/></td>
                                        <th>종업원수</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_ttl_cnt}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>기업구분</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_divn_cd_nm}"  escapeXml="false"/></td>
                                        <th>회원구분</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_mem_divn_nm}"  escapeXml="false"/></td>
                                    </tr> 
                                    <tr>
                                        <th>설비분야</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_fac_divn_cd_nm}"  escapeXml="false"/></td>
                                        <th>제품유형</th>
                                        <td><c:out value="${R_MAP.prodDtl.prod_ty_nm}"  escapeXml="false"/></td>                                        
                                    </tr>                                                                       
                                    <tr>
                                        <th>회사연혁</th>
                                        <td colspan="3"><c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.prodDtl.corp_hist, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>주요생산품</th>
                                        <td colspan="3"><c:out value="${R_MAP.prodDtl.corp_main_prod}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>사업자번호</th>
                                        <td ><c:out value="${R_MAP.prodDtl.corp_no}"  escapeXml="false"/></td>
                                        <th>팩스번호</th>
                                        <td><c:out value="${R_MAP.prodDtl.corp_fax_no}"  escapeXml="false"/></td>                                        
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">제품설명</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>제품설명-제품구분,제품특징,기술규격,동작원리,납품실적</caption>
                                <colgroup>
                                    <col width="15%">
                                    <col width="*">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>제품구분</th>
                                        <td><c:out value="${R_MAP.prodDtl.prod_divn_nm}"  escapeXml="false"/></td>
                                    </tr>                                
                                    <tr>
                                        <th>제품특징</th>
                                        <td><c:out value="${R_MAP.prodDtl.prod_funt}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>기술규격</th>
                                        <td><c:out value="${R_MAP.prodDtl.tech_stnd}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>동작원리</th>
                                        <td><c:out value="${R_MAP.prodDtl.oprt_prcp}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>납품실적</th>
                                        <td><c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.prodDtl.dlvry_rcd, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/>
                                        
                                        <%
                                        /*
                                        <---c:set var="dlvry_rcd" value="$----{R_MAP.prodDtl.dlvry_rcd}"/--->
                                        String aaa = (String)pageContext.getAttribute("dlvry_rcd");
                                        aaa.replaceAll("&amp;","&").replaceAll("&amp;","&").replaceAll("\"","'").replaceAll("\r\n", "<br />").replaceAll("\n", "<br />")
                                        */
                                        %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">인증현황</h4>
                        <div class="tableArea">
                            <table class="tableC colTable">
                                <caption>인증현황-인증품목,인증구분,인증번호,인증일,인증만료일</caption>
                                <colgroup>
                                    <col width="15%">
                                    <col width="35%">
                                    <col width="15%">
                                    <col width="35%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>인증품목</th>
                                        <td colspan="3"><c:out value="${R_MAP.prodDtl.cert_prod}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>인증구분</th>
                                        <td><c:out value="${R_MAP.prodDtl.cert_divn_nm}"  escapeXml="false"/></td>
                                        <th>인증번호</th>
                                        <td><c:out value="${R_MAP.prodDtl.cert_no}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>인증일</th>
                                        <td><c:out value="${R_MAP.prodDtl.cert_dt}"  escapeXml="false"/></td>
                                        <th>인증만료일</th>
                                        <td><c:out value="${R_MAP.prodDtl.cert_expr_dt}"  escapeXml="false"/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">E-카탈로그</h4>
                        <div class="attach_list">
                            <span>첨부파일</span>
                            <div>
								<c:forEach var="list" items="${R_MAP.fileList2}" varStatus="i">
									<a href="#" onclick="GoDownfile('<c:out value="${R_MAP.param.pcode}" />','<c:out value="${list.ridx}" />','<c:out value="${list.orderNo}" />','<c:out value="${list.fileGroup}" />');return false;" class="attachFile">
										<c:out value="${list.fileNm}"/>					
									</a>
										
								</c:forEach>                             
                               
                            </div>
                        </div>
                    </div>
                    
                    <div class="viewList">
                        <div class="prevList">
                            <c:if test="${R_MAP.prodDtlPrNe.prevSeq != '0'}">
                            	<a href="#" onclick="fnRequstInfo('<c:out value="${R_MAP.prodDtlPrNe.prevSeq}"  escapeXml="false"/>');return false;">
                            </c:if>
                            <c:if test="${R_MAP.prodDtlPrNe.prevSeq == '0'}">
                            	<a href="#" onclick="return false;">
                            </c:if>                        
                            
                                <span>이전글</span>
                                <p class="ellipsis">
                                	<c:if test="${R_MAP.prodDtlPrNe.prevSeq != '0'}">
                                		<c:out value="${R_MAP.prodDtlPrNe.prevTitle}"  escapeXml="false"/>
                                	</c:if>
                                	<c:if test="${R_MAP.prodDtlPrNe.prevSeq == '0'}">
                                		이전글이 존재하지 않습니다.
                                	</c:if>                                	
                                </p>
                            </a>
                        </div>
                        <div class="nextList">
                        
                            <c:if test="${R_MAP.prodDtlPrNe.nextSeq != '0'}">
                            	<a href="#" onclick="fnRequstInfo('<c:out value="${R_MAP.prodDtlPrNe.nextSeq}"  escapeXml="false"/>');return false;">
                            </c:if>
                            <c:if test="${R_MAP.prodDtlPrNe.nextSeq == '0'}">
                            	<a href="#" onclick="return false;">
                            </c:if>                        
                            
                                <span>다음글</span>
                                <p class="ellipsis">
                                	<c:if test="${R_MAP.prodDtlPrNe.nextSeq != '0'}">
                                		<c:out value="${R_MAP.prodDtlPrNe.nextTitle}"  escapeXml="false"/>
                                	</c:if>
                                	<c:if test="${R_MAP.prodDtlPrNe.nextSeq == '0'}">
                                		다음글이 존재하지 않습니다.
                                	</c:if>                                	
                                </p>
                            </a>
                        </div>
                    </div>
                    <div class="btnArea">
                        <div class="leftBtn">
                            <button class="btnBK" id="btn_del" onclick="return false;">삭제</button>
                            <button class="btnBL" id="btn_mod" onclick="return false;">수정</button>
                        </div>
                        <a href="#" class="btnB" id="btn_list" onclick="return false;">목록</a>
                    </div>
                 </div>




</form>



<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<script type="text/javascript">
//<![CDATA[
	//TODO : $(function()
	var form = document.dataForm;
	
	$(function(){
		$('#content').addClass('market');
		$('#contents').parent('div').addClass('view');

		$("#main_img_id").bind("load",function(){
			//alert("aaadd");
			
			if(this.complete){
				var img_inner_width = $('.imgInner').width();
				var img_inner_height = $('.imgInner').height();
			
				var img_rtow = 0;
				var img_rtoh = 0;
				
				//console.log("111111:::::"+img_inner_width+'////'+$('#main_img_id').width());
				//console.log("111111:::::"+img_inner_height+'////'+$('#main_img_id').height());
				
				//if($('#main_img_id').width() <= $('#main_img_id').height()){
					img_rtow = (($('.imgInner').width()) / $('#main_img_id').width());
					img_rtoh = (($('.imgInner').height()) / $('#main_img_id').height());
					//console.log("2222222222:::::"+(img_rtow.toFixed(2))+'////'+(img_rtoh.toFixed(2)));
					//console.log("2222222222:::::"+($('#main_img_id').width()*img_rtow.toFixed(2))+'////');
					if(img_rtow < img_rtoh){
						$('#main_img_id').css({"width":($('#main_img_id').width()*img_rtow.toFixed(2))+"px"});
					}else{
						$('#main_img_id').css({"width":($('#main_img_id').width()*img_rtoh.toFixed(2))+"px"});
					}
					
					
				/*}else{
					if(img_inner_width < $('#main_img_id').width() ){
						$('#main_img_id').width($('.imgInner').width());
						console.log("111111:::::"+img_inner_height+'////'+$('#main_img_id').height());
						if(img_inner_height < $('#main_img_id').height() ){
							//img_rto = img_inner_height / $('#main_img_id').height()*100;
							img_rtow = img_inner_height / $('#main_img_id').height();
							console.log("111111:::::"+img_rtow+'////img_rto');
							console.log("111111:::::"+$('#main_img_id').width()+'////'+($('#main_img_id').width()-$('#main_img_id').width()*img_rtow));
							$('#main_img_id').width($('#main_img_id').width() - ($('#main_img_id').width()-$('#main_img_id').width()*img_rtow)-5 );
						}else{
							
						}
						
					}else{
						//$('#main_img_id').width($('.imgInner').width());
						
					}			
				}*/				
			}else{
				console.log("333333333333333333");
			}
			
		});
		//main_image_chg("","","Y");
		
		// 목록
		$("#btn_list").click(function(e){
			form.method='post';
			form.pstate.value='L';
			form.action='<c:url value='/cmsmain.do'/>';
			form.submit();
			form.target = "";
		});
		
		// 수정
		$("#btn_mod").click(function(e){
			// 로그인상태이면 수정화면으로 이동시킨다
			if("N" == "<c:out value='${nUser}'/>"){
				<c:if test="${R_MAP.prodDtl.auth_type == 'LOGIN'}">
					// 로그인 상태에서 등록한 데이터 이면
					// 회원로그인 확인
					if(confirm('로그인 후 수정가능한정보입니다.\n확인을 선택하시면 로그인화면으로 이동합니다.')){
						//document.location.href="<c:url value='/cmsmain.do'/>?scode=S01&pcode=000253";
						//alert($("#prod_seq").val());
						//return;
						Go_LoginPageView("<%=pcode %>", "UF", $("#prod_seq").val());
					// 
					}else{
						return false;					
					}				
				</c:if>
				<c:if test="${R_MAP.prodDtl.auth_type == 'NONE'}">
					// 비로그인상태에서 등록한 데이터 이면
					fnOpenPwLayer($("#prod_seq").val(), "UF");	
				</c:if>
				
			}else{
				<c:if test="${R_MAP.prodDtl.auth_type == 'LOGIN'}">
					form.method='post';
					form.pstate.value='UF';
					form.action='<c:url value='/cmsmain.do'/>';
					form.submit();
					form.target = "";
				</c:if>
				<c:if test="${R_MAP.prodDtl.auth_type == 'NONE'}">
					// 비로그인상태에서 등록한 데이터 이면
					fnOpenPwLayer($("#prod_seq").val(), "UF");	
				</c:if>				
			}
			

		});	
		
		// 삭제
		$("#btn_del").click(function(e){
			// 로그인상태이면 수정화면으로 이동시킨다
			if("N" == "<c:out value='${nUser}'/>"){
				<c:if test="${R_MAP.prodDtl.auth_type == 'LOGIN'}">
					// 로그인 상태에서 등록한 데이터 이면
					// 회원로그인 확인
					if(confirm('로그인 후 삭제가능한정보입니다.\n확인을 선택하시면 로그인화면으로 이동합니다.')){
						//document.location.href="<c:url value='/cmsmain.do'/>?scode=S01&pcode=000253";
						//alert($("#prod_seq").val());
						//return;
						Go_LoginPageView("<%=pcode %>", "R", $("#prod_seq").val());
					// 
					}else{
						return false;					
					}				
				</c:if>
				<c:if test="${R_MAP.prodDtl.auth_type == 'NONE'}">
					// 비로그인상태에서 등록한 데이터 이면
					fnOpenPwLayer($("#prod_seq").val(), "D");	
				</c:if>
				
			}else{
				<c:if test="${R_MAP.prodDtl.auth_type == 'LOGIN'}">
					fnOpenPwLayer($("#prod_seq").val(), "D");	
				</c:if>
				<c:if test="${R_MAP.prodDtl.auth_type == 'NONE'}">
					// 비로그인상태에서 등록한 데이터 이면
					fnOpenPwLayer($("#prod_seq").val(), "D");	
				</c:if>				
			}			
				

		});		
		
	});
	
	function main_image_chg(chgsrc,chgalt,inityn){
		if(inityn=="N"){
			$("#main_img_id").attr("src",chgsrc.replace("&img_type=thumnail_file",""));
			$("#main_img_id").attr("alt",chgalt);			
		}
		
	}	
	
	// 파일다운로드
	function GoDownfile(fpcode,sidx,fidx,groupidx){
		url = "<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN"+"&fpcode="+fpcode+"&sidx="+sidx+"&fidx="+fidx+"&groupidx="+groupidx;
		document.getElementById("successIframe").src = url;
		
	}	
	
	// 상세보기
	var fnRequstInfo = function(prod_seq){

		$("input[name=pstate]").val("R");
		$("#dataForm").find("input[name=prod_seq]").val(prod_seq);
		

		form.submit();

	};
	
	var fnPwcCallBack = function(data){
		if(data.pageStatus=="D"){
			var params = jQuery("#dataForm").serialize();
			var msg_str = "삭제"
			$("#pstate").val(data.pageStatus);
			$("#prod_seq").val(data.ikey_data);
			$("#ichk_secret_no").val(data.chk_secret_no);
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
		}else{
			form.method='post';
			form.pstate.value=data.pageStatus;
			form.prod_seq.value=data.ikey_data;
			form.ichk_secret_no.value=data.chk_secret_no;
			form.action='<c:url value='/cmsmain.do'/>';
			form.submit();
			form.target = "";			
		}

		
	
	};	
	
	//]]>
	
</script>