<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
Map mapGet = (Map) request.getAttribute("R_MAP");
Map dataGet = (Map) mapGet.get("proposalDtl");

session.setAttribute("sIdxCheck", dataGet.get("data_seqno"));
session.setAttribute("mCodeCheck", dataGet.get("menu_cd"));
%>

<style type="text/css">
.btnArea a{width:100px;height: 50px;line-height: 48px;font-size:16px;display: inline-block;}
.btnArea{text-align: right;}
</style>
<c:set var="nUser" value="<%=userId%>"/>
<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<form id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode"  					name="scode" 				value="<%=scode%>" title="사이트코드" />
<input type="hidden" 	id="pcode"  					name="pcode" 				value="<%=pcode%>" title="페이지코드" />
<input type="hidden" 	id="pstate"  					name="pstate" 				value="<%=pstate%>" title="페이지상태" />
<input type="hidden" 	id="page" 						name="page" 				value="${R_MAP.param.page}"/>
<input type="hidden" 	id="searchGubun" 				name="searchGubun" 			value="${R_MAP.param.searchGubun}" />
<input type="hidden" 	id="searchValue" 				name="searchValue" 			value="${R_MAP.param.searchValue}" />
	<input type="hidden" 	id="data_seqno" 				name="data_seqno" 			value="${R_MAP.param.data_seqno}"/>
	<input type="hidden" 	id="REG_NM" 					name="REG_NM" 				value="${R_MAP.param.REG_NM}"/>
	<input type="hidden" 	id="REG_HP_NO" 					name="REG_HP_NO" 			value="${R_MAP.param.REG_HP_NO}"/>
	<input type="hidden" 	id="REG_EMAIL" 					name="REG_EMAIL" 			value="${R_MAP.param.REG_EMAIL}"/>
	<input type="hidden" 	id="SECRET_NO" 					name="SECRET_NO" 			value="${R_MAP.param.SECRET_NO}"/>  
	<input type="hidden" 	id="TEST" 					name="TEST" 			value="${R_MAP.param.data_seqno}"/>  

				<div class="cts_mid">
                    <div class="prg">
                        <h4 class="titleM">제안 내용</h4>
                        <div class="tableArea">
                            <table class="tableC colTable">
                                <caption>제안 내용-작성자,소속,제목,휴대번호,이메일,내용,첨부파일</caption>
                                <colgroup>
                                    <col width="15%">
                                    <col width="35%">
                                    <col width="15%">
                                    <col width="35%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>작성자</th>
                                        <td><c:out value="${R_MAP.proposalDtl.reg_nm}"  escapeXml="false"/></td>
                                        <th>소속</th>
                                        <td><c:out value="${R_MAP.proposalDtl.reg_sosok}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>제목</th>
                                        <td colspan="3"><c:out value="${R_MAP.proposalDtl.data_title}"  escapeXml="false"/></td>
                                    </tr>
                                    <tr>
                                        <th>휴대번호</th>
                                        <td><c:out value="${R_MAP.proposalDtl.reg_hp_no}"  escapeXml="false"/></td>
                                        <th>이메일</th>
                                        <td><c:out value="${R_MAP.proposalDtl.reg_email}"  escapeXml="false"/></td>
                                    </tr> 
                                                                      
                                    <tr>
                                        <th>내용</th>
                                        <td colspan="3"><c:out value="${fn:replace(fn:replace(fn:replace(R_MAP.proposalDtl.data_desc, sp2x, nbsp), crcn, br), cr, br)}" escapeXml="false"/></td>
                                    </tr>
                                    
                                    <tr>
                                        <th>첨부파일</th>
                                        <td colspan="3">
											<c:forEach var="list" items="${R_MAP.fileList1}" varStatus="i">
												<a href="#" onclick="GoDownfile('<c:out value="${R_MAP.param.pcode}" />','<c:out value="${list.ridx}" />','<c:out value="${list.orderNo}" />','<c:out value="${list.fileGroup}" />');return false;" class="attachFile">
													<c:out value="${list.fileNm}"/>					
												</a>
													
											</c:forEach>                                         
                                        </td>
                                    </tr>                                    

                                </tbody>
                            </table>
                        </div>
                    </div>
 

                    <div class="btnArea">
                    	<a href="#" class="btnBK" id="btn_del" onclick="return false;">삭제</a>
                        <a href="#" class="btnBL" id="btn_mod" onclick="return false;">수정</a>

                        <a href="#" class="btnB" id="btn_list" onclick="return false;">목록</a>
                    </div>
                 </div>




</form>



<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<script type="text/javascript">
//<![CDATA[
	//TODO : $(function()
	$(function(){
		$('#contents').parent('div').addClass('noticeView');
		
		var form = document.dataForm;
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
			form.method='post';
			form.pstate.value='UF';
			form.action='<c:url value='/cmsmain.do'/>';
			form.submit();
			form.target = "";
		});	
		
		// 삭제
		$("#btn_del").click(function(e){
			var params = jQuery("#dataForm").serialize();
			var msg_str = "삭제"
			$("#pstate").val("D");
			jQuery("#dataForm").ajaxSubmit({
		    		type: "post",
		            url: "<c:url value='/cmsajax.do'/>",
		            data: params,
		            async: false,
		            dataType:"json",
		            success: function(data){
		            	if(data.result==true){
		                	alert('<c:out value="${gb_page_str}" escapeXml="false" />에 '+msg_str+' 되었습니다.');
		                	$("#btn_list").trigger("click");
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
	
	
	// 파일다운로드
	function GoDownfile(fpcode,sidx,fidx,groupidx){
		url = "<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN"+"&fpcode="+fpcode+"&sidx="+sidx+"&fidx="+fidx+"&groupidx="+groupidx;
		document.getElementById("successIframe").src = url;
		
	}	
	

	//]]>
	
</script>