<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_020_s1.jsp
%>
<style>

	.ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column { white-space: normal; }
	.ui-jqgrid-htable th{ text-align: center; }
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr {border-left : 1px solid; border-left-color: #dcdcdc; }
	.ui-th-rtl, .ui-jqgrid .ui-jqgrid-htable th.ui-th-rtl {border-right : 1px solid; border-right-color: #dcdcdc; }	

</style>

<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<form name="listfrm" id="listfrm" method="post" onSubmit="return false;srchCheck(event);" >        
<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
 <input type="hidden" 	id="prod_seq" 			name="prod_seq" />


<div class="supply_box">
<!--search-->
	<div class="searchArea mT10">
	  <table class="tbl_search">
	    <colgroup>
	    <col width="100">
	    <col width="150">
	    <col width="100">
	    <col width="150">
	    <col width="550">
	    <col width="*">
	    </colgroup>
		    <tbody>
		    	<tr>
		    		<th scope="row">기업구분</th>
		        	<td>
						<select name="sCORP_DIVN" id="sCORP_DIVN" title="기업구분 선택">
							<option value="" <c:if test="'' == R_MAP.param.sCORP_DIVN}">selected="selected"</c:if>>전체</option>
							<c:forEach var="list" items="${R_MAP.m00100List}" varStatus="status">
								<option value="<c:out value='${list.stdinfoDtlCd}'/>" <c:if test="${list.stdinfoDtlCd == R_MAP.param.sCORP_DIVN}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>
							</c:forEach>											
						</select>
		        	</td>
		        	<th scope="row">회원구분</th>
		        	<td>
						<select name="sCORP_MEM_DIVN" id="sCORP_MEM_DIVN" title="회원구분 선택">
							<option value="" <c:if test="'' == R_MAP.param.sCORP_MEM_DIVN}">selected="selected"</c:if>>전체</option>
							<c:forEach var="list" items="${R_MAP.m00103List}" varStatus="status">
								<option value="<c:out value='${list.stdinfoDtlCd}'/>" <c:if test="${list.stdinfoDtlCd == R_MAP.param.sCORP_MEM_DIVN}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>
							</c:forEach>													
						</select>
		        	</td>
		        	<td>등록기간:
		    		<input type="text" name="sp_sdate" id="sp_sdate" title="검색시작일" />
		    		~
		    		<input type="text" name="sp_edate" id="sp_edate" title="검색종료일" />		        		
		        	</td>
		        	<td style="text-align:right;">
		        		<span class="btn_pack large vM" id="btn_search"><a href="#"  onclick="return false;">검색</a></span>
		        	</td>
				</tr>
				
		    	<tr>
		    		<th scope="row">설비분야</th>
		        	<td>
						<select name="sCORP_FAC_DIVN" id="sCORP_FAC_DIVN" title="설비분야 선택">
							<option value="" <c:if test="'' == R_MAP.param.sCORP_FAC_DIVN}">selected="selected"</c:if>>전체</option>
							<c:forEach var="list" items="${R_MAP.m00101List}" varStatus="status">
								<option value="<c:out value='${list.stdinfoDtlCd}'/>" <c:if test="${list.stdinfoDtlCd == R_MAP.param.sCORP_FAC_DIVN}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>
							</c:forEach>											
						</select>
		        	</td>
		        	<th scope="row">제품구분</th>
		        	<td>
						<select name="sPROD_DIVN" id="sPROD_DIVN" title="제품구분 선택">
							<option value="" <c:if test="'' == R_MAP.param.sPROD_DIVN}">selected="selected"</c:if>>전체</option>
							<c:forEach var="list" items="${R_MAP.m00102List}" varStatus="status">
								<option value="<c:out value='${list.stdinfoDtlCd}'/>" <c:if test="${list.stdinfoDtlCd == R_MAP.param.sPROD_DIVN}">selected="selected"</c:if>><c:out value="${list.stdinfoDtlNm}"/></option>
							</c:forEach>													
						</select>
		        	</td>
		        	<td colspan="2">
		        		<select name="searchGubun" id="searchGubun" title="회사,제품명 선택">
		        			<option value="" <c:if test="'' == R_MAP.param.searchGubun}">selected="selected"</c:if>>전체</option>
		        			<option value="CORP_NM">회사명</option>
		        			<option value="PROD_NM">제품명</option>
		        		</select>
		        	
						<input type="text" name="searchValue" id="searchValue" value="<c:out value="${R_MAP.param.searchValue}"/>" title="검색어 입력" onKeyDown="srchCheck(event);" onKeyUp="sechnotin();" />
                        <input type="text" name="submitguard" id="submitguard" style="display:none;" />
		        	</td>
				</tr>				
		  	</tbody>
	  </table>
	</div> 
	<!--//search-->
	<div class="section mB5">
         <p class="fR">
<!--            <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="#" >화면출력</a></span> -->
<!--            <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="#" >전체출력</a></span> -->
		</p>
	</div>
	<!-- 그리드 영역 -->
	<div class="section" id="jqGridDiv">
		<table id='jqGrid' fixwidth="N" minuswh="16"></table>
	</div>
	
	
</div>
</form>

<!-- 내용조회 창  -->
<div id="create_form_popup1" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9990;width:1000px;display:none;">
	<h1 id="contents_view_title1"><span >&#8226;</span> 제품조회</h1><span class="close" id="btn_create_form_popup1_close_icon" onclick="create_form_close1()"><a href="#" onclick="return false;" ></a></span>
	<form name="create_formfm1" id="create_formfm1" method="post" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
		<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
		<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />	
		<input type="hidden" name="selprod_seq1" id="selprod_seq1" value="" title="선택된 번호"  />
		<div id="contents_view_area" style="width:100%;overflow:auto;">
			<span style="font-weight:600;margin-top:10px;">&#8226; 기업소개</span> 
	        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
	        	<caption>기업소개-회사명,기업구분,회원구분,설비분야,제품유형,대표자명,설립일,종업원수,회사연혁,주요생산품,사업자번호,이메일,홈페이지,대표번호,팩스번호,</caption>
	            <colgroup>
	                <col width="12%">
	                <col width="35%">
	                <col width="15%">
	                <col width="*">
	            </colgroup>
	            <thead>
	                <tr>
	                    <th scope="row" class="essential"><label for="CORP_NM">회사명</label></th>
	                    <td colspan="3"><input type="text" style="width:100%;" id="CORP_NM" name="CORP_NM" value="" maxlength="100" title="회사명" /></td>
	                </tr>
	                
	                <tr>
	                    <th scope="row" class="essential"><label for="CORP_DIVN">기업구분</label></th>
	                    <td colspan="3">
						<c:forEach var="list" items="${R_MAP.m00100List}" varStatus="i">
								<input type="checkbox" id="std${list.stdinfoDtlCd}" name="CORP_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
								<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
						</c:forEach>    
						<input type="hidden" name="CORP_DIVN_cds" id="CORP_DIVN_cds" value="" />                               
	                    </td>
	                </tr>
	                
	                <tr>
	                    <th scope="row" class="essential"><label for="CORP_MEM_DIVN">회원구분</label></th>
	                    <td colspan="3">
						<c:forEach var="list" items="${R_MAP.m00103List}" varStatus="i">
								<input type="radio" id="std${list.stdinfoDtlCd}" name="CORP_MEM_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
								<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
						</c:forEach> 
						<input type="hidden" name="CORP_MEM_DIVN_cds" id="CORP_MEM_DIVN_cds" value="" />                                    
	                    </td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" class="essential"><label for="CORP_FAC_DIVN">설비분야</label></th>
	                    <td colspan="3">
						<c:forEach var="list" items="${R_MAP.m00101List}" varStatus="i">
								<input type="checkbox" id="std${list.stdinfoDtlCd}" name="CORP_FAC_DIVN" value="<c:out value='${list.stdinfoDtlCd}'/>" />
								<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
						</c:forEach>  
						<input type="hidden" name="CORP_FAC_DIVN_cds" id="CORP_FAC_DIVN_cds" value="" />                                     
	                    </td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" class="essential"><label for="PROD_TY">제품유형</label></th>
	                    <td colspan="3">
						<c:forEach var="list" items="${R_MAP.m00106List}" varStatus="i">
								<input type="checkbox" id="std${list.stdinfoDtlCd}" name="PROD_TY" value="<c:out value='${list.stdinfoDtlCd}'/>" />
								<label for="std${list.stdinfoDtlCd}"><c:out value="${list.stdinfoDtlNm}"/></label>
						</c:forEach>  
						<input type="hidden" name="PROD_TY_cds" id="PROD_TY_cds" value="" />                                     
	                    </td>
	                </tr>	                                                                              
	                                                
	                <tr>
	                    <th scope="row" ><label for="CORP_REPE_NM">대표자명</label></th>
	                    <td colspan="3"><input type="text" id="CORP_REPE_NM" name="CORP_REPE_NM" value="" maxlength="32" title="대표자명" /></td>
	                </tr>  
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_EST_DT">설립일</label></th>
	                    <td colspan="3"><input type="text" id="CORP_EST_DT" name="CORP_EST_DT" value="" maxlength="10" title="설립일" readonly="readonly" /></td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_TTL_CNT">종업원수</label></th>
	                    <td colspan="3"><input type="text" id="CORP_TTL_CNT" name="CORP_TTL_CNT" value="" maxlength="10" title="종업원수" onkeyup="inputNum(this);" style="IME-MODE:disabled" /></td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_HIST">회사연혁</label></th>
	                    <td colspan="3"><textarea style="width:100%;" name="CORP_HIST" id="CORP_HIST" rows="5"></textarea></td>
	                </tr>                                        
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_MAIN_PROD">주요생산품</label></th>
	                    <td colspan="3"><input style="width:100%;" type="text" id="CORP_MAIN_PROD" name="CORP_MAIN_PROD" value="" maxlength="500" title="주요생산품" /></td>
	                </tr>
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_NO">사업자번호</label></th>
	                    <td colspan="3"><input type="text" id="CORP_NO" name="CORP_NO" value="" maxlength="50" title="사업자번호" /></td>
	                </tr>   
	                
	                <tr>
	                    <th scope="row" ><label for="email1">이메일</label></th>                                
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
	                    <th scope="row" ><label for="CORP_LINK">홈페이지</label></th>
	                    <td colspan="3"><input type="text" id="CORP_LINK" name="CORP_LINK" value="" maxlength="500" title="홈페이지" /></td>
	                </tr>  
	                
	                <tr>
	                    <th scope="row" class="essential"><label for="CORP_TEL_NO_11">대표번호</label></th>
	                    <td colspan="3">
								<select id="CORP_TEL_NO_11" name="CORP_TEL_NO_11" style="width:15%;" title="대표번호 앞자리">
									<c:forEach var="list" items="${R_MAP.m00008List}" varStatus="i">
										<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/>(<c:out value="${list.stdinfoDtlLabel}"/>)</option>
									</c:forEach>
								</select>
								                                    
	                    		- <input type="text" id="CORP_TEL_NO_12" name="CORP_TEL_NO_12" value="" maxlength="4" title="대표번호 가온데자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
	                    		- <input type="text" id="CORP_TEL_NO_13" name="CORP_TEL_NO_13" value="" maxlength="4" title="대표번호 끝자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
	                    		<input type="hidden" name="CORP_TEL_NO_1" id="CORP_TEL_NO_1" alt="대표번호" title="대표번호" />
	                    </td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" ><label for="CORP_FAX_NO1">팩스번호</label></th>
	                    <td colspan="3">
								<select id="CORP_FAX_NO1" name="CORP_FAX_NO1" style="width:15%;" title="팩스번호 앞자리">
									<c:forEach var="list" items="${R_MAP.m00008List}" varStatus="i">
										<option value="<c:out value='${list.stdinfoDtlNm}'/>"><c:out value="${list.stdinfoDtlNm}"/>(<c:out value="${list.stdinfoDtlLabel}"/>)</option>
									</c:forEach>
								</select>
								                                    
	                    		- <input type="text" id="CORP_FAX_NO2" name="CORP_FAX_NO2" value="" maxlength="4" title="팩스번호 가온데자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />
	                    		- <input type="text" id="CORP_FAX_NO3" name="CORP_FAX_NO3" value="" maxlength="4" title="팩스번호 끝자리" style="width:10%;" onkeyup="inputNum(this);" style="IME-MODE:disabled" />                                    
			                    <input type="hidden" name="CORP_FAX_NO" id="CORP_FAX_NO" alt="팩스번호" title="팩스번호" />
	                    </td>
	                </tr>                                                                                                                             
								                                                                                                                                                                            
	            </thead>
	
	         </table>
	         
			<span style="font-weight:600;margin-top:10px;">&#8226; 제품설명</span> 
	        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
	        	<caption>제품설명-제품명,제품구분,제품특징,기술규격,동작원리,납품실적,상품이미지</caption>
	            <colgroup>
	                <col width="12%">
	                <col width="35%">
	                <col width="15%">
	                <col width="*">
	            </colgroup>
	            <thead>
                    <tr>
                        <th scope="row"  class="essential"><label for="PROD_NM">제품명</label></th>
                        <td colspan="3"><input type="text" style="width:100%;" id="PROD_NM" name="PROD_NM" value="" maxlength="100" title="제품명" /></td>
                    </tr>
                    
                    <tr>
                        <th scope="row"  class="essential"><label for="PROD_DIVN">제품구분</label></th>
                        <td colspan="3">
								<select id="PROD_DIVN" name="PROD_DIVN" title="제품구분 선택">
									<c:forEach var="list" items="${R_MAP.m00102List}" varStatus="i">
										<option value="<c:out value='${list.stdinfoDtlCd}'/>"><c:out value="${list.stdinfoDtlNm}"/></option>
									</c:forEach>
								</select>                                    
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"  ><label for="PROD_FUNT">제품특징</label></th>
                        <td colspan="3">
						    <input type="text" style="width:100%;" id="PROD_FUNT" name="PROD_FUNT" value="" maxlength="1000" title="제품특징" />                            
                        </td>
                    </tr> 
                    
                    <tr>
                        <th scope="row"  ><label for="TECH_STND">기술규격</label></th>
                        <td colspan="3">
						    <input type="text" style="width:100%;" id="TECH_STND" name="TECH_STND" value="" maxlength="1000" title="기술규격" />                            
                        </td>
                    </tr>
                    
                    <tr>
                        <th scope="row"  ><label for="TECH_STND">동작원리</label></th>
                        <td colspan="3">
						    <input type="text" style="width:100%;" id="OPRT_PRCP" name="OPRT_PRCP" value="" maxlength="1000" title="동작원리" />                            
                        </td>
                    </tr> 
                    
                    <tr>
                        <th scope="row"  ><label for="DLVRY_RCD">납품실적</label></th>
                        <td colspan="3">
                        	<textarea style="width:100%;" name="DLVRY_RCD" id="DLVRY_RCD" rows="5" title="납품실적"></textarea>                           
                        </td>
                    </tr> 
                    
                    <tr>
                        <th scope="row"  class="essential"><label for="PROD_IMG">상품이미지</label></th>
                        <td colspan="3">
                        	<div id="cmfile1"></div>                         
                        </td>
                    </tr>                                                                                                                              
					                                                                                                                                                                            
	            </thead>
	
	         </table>	
	         
			<span style="font-weight:600;margin-top:10px;">&#8226; 인증현황</span> 
	        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
	        	<caption>기업소개-인증품목,인증구분,인증일,인증만료일,카탈로그</caption>
	            <colgroup>
	                <col width="12%">
	                <col width="35%">
	                <col width="15%">
	                <col width="*">
	            </colgroup>
	            <thead>
                   <tr>
                       <th scope="row"  ><label for="CERT_PROD">인증품목</label></th>
                       <td colspan="3"><input type="text" style="width:100%;" id="CERT_PROD" name="CERT_PROD" value="" maxlength="100" title="인증품목" /></td>
                   </tr>
                   
                   <tr>
                       <th scope="row"  ><label for="CERT_DIVN">인증구분</label></th>
                       <td colspan="3">
							<select id="CERT_DIVN" name="CERT_DIVN" onfocus="fixCERT_DIVN();" title="인증구분 선택">
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
                       <th scope="row"  ><label for="CERT_DT">인증일</label></th>
                       <td colspan="3"><input type="text" id="CERT_DT" name="CERT_DT" value="" maxlength="10" title="인증일" /></td>
                   </tr>  
 
                   <tr>
                       <th scope="row"  ><label for="CERT_EXPR_DT">인증만료일</label></th>
                       <td colspan="3"><input type="text" id="CERT_EXPR_DT" name="CERT_EXPR_DT" value="" maxlength="10" title="인증만료일" /></td>
                   </tr>                                                                                                                              
				                                                                                                                                                                            
	            </thead>
	
	         </table>
	         
			<span style="font-weight:600;margin-top:10px;">&#8226; 카탈로그</span> 
	        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
	        	<caption>기업소개-카탈로그</caption>
	            <colgroup>
	                <col width="12%">
	                <col width="35%">
	                <col width="15%">
	                <col width="*">
	            </colgroup>
	            <thead>
                   <tr>
                       <th scope="row"><label for="CT_ATCH_FILE_ID">카탈로그</label></th>
                       <td colspan="3">
                       	<div id="cmfile2"></div>                         
                       </td>
                   </tr>                                                                                                                             
				                                                                                                                                                                            
	            </thead>
	
	         </table>	         	                  
        </div>
		<div class="section aC mT5 mB5">
			<span class="btn_pack large" id="btn_create_form_close1"><a href="#" onclick="create_form_close1();return false;">닫기</a></span>
		</div>                    

	</form>
</div>
<!-- 내용조회 창  -->

<!-- 메일전송이력조회 창  -->
<div id="create_form_popup2" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9991;width:1000px;display:none;">
	<h1 id="mail_loglist_title"><span >&#8226;</span> 승인이력</h1><span class="close" id="btn_mail_loglist_close_icon" onclick="create_form_close2()"><a href="#" onclick="return false;" ></a></span>
	<form name="create_formfm2" id="create_formfm2" method="post" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
		<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
		<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />	
		<input type="hidden" name="selprod_seq2" id="selprod_seq2" value="" title="선택된 번호"  />

        
		<div class="searchArea mT0" style="height:2px;margin:0px;padding:0px 0px !important;">
		  <table class="tbl_search">
		    <colgroup>
		    <col width="50" />
		    <col width="350" />
		    <col width="60" />
		    <col width="90" />
		    <col width="*" />
		    </colgroup>
		    <tr>
		    	<td colspan="5">
		    	</td>
		    </tr>
		  </table>
	  	  
		</div> 
		      
	 	<div class="section" id="jqGridDiv2">
			<table id='jqGrid2' fixwidth="Y"></table>
		</div>
	
		<div class="section aC mT5 mB5">
			<span class="btn_pack large" id="btn_create_form_close2"><a href="#" onclick="create_form_close2();return false;">닫기</a></span>
		</div>                    

	</form>
</div>
<!-- 메일전송이력조회 창  -->
<!-- 메일내용조회 창  -->
<div id="create_form_mcontents2" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9992;width:780px;display:none;">
	<h1 id="mcontents2_title"><span >&#8226;</span> </h1><span class="close" id="btn_mcontents2_close_icon" onclick="create_form_mailview_close2()"><a href="#" onclick="return false;" ></a></span>
		<div class="searchArea mT0" style="height:2px;margin:0px;padding:0px 0px !important;">
		  <table class="tbl_search">
		    <colgroup>
		    <col width="50" />
		    <col width="350" />
		    <col width="60" />
		    <col width="90" />
		    <col width="*" />
		    </colgroup>
		    <tr>
		    	<td colspan="5">
		    	</td>
		    </tr>
		  </table>
	  	  
		</div> 
		      
	 	<div class="section" id="jqGridDiv_mcontents2">
			<iframe id="mcontents2" name="mcontents2" ></iframe>
		</div>
	
		<div class="section aC mT5 mB5">
			<span class="btn_pack large" id="btn_create_form_close2"><a href="#" onclick="create_form_mailview_close2();return false;">닫기</a></span>
		</div>                    

</div>
<!-- 메일전송이력조회 창  -->

<script type="text/javascript">

var searchYn = false;

// TODO : $(function()
		$(function(){
					
		    $("input[name ='sp_sdate']").datepicker({
		        changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달', 
		        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
		        dayNamesMin: ['일','월', '화', '수', '목', '금', '토' ], 
		        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,
		        showOn:'both',
		        dateFormat: "yy-mm-dd",
		        yearRange : 'c-3:c', // 100년전부터 현재년도까지
		        buttonImage:'<%=con_root%>/images/contents/cal.png',
		        onClose:function(selectedDate){
		        	//$("#sp_edate").datepicker("option","minDate",selectedDate);
		        }
			});	
		    
		    $("input[name ='sp_sdate']").datepicker("setDate","-3Y");
		    
		    $("input[name ='sp_edate']").datepicker({
		        changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달', 
		        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
		        dayNamesMin: ['일','월', '화', '수', '목', '금', '토' ], 
		        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,
		        showOn:'both',
		        dateFormat: "yy-mm-dd",
		        yearRange : 'c-3:c', // 100년전부터 현재년도까지
		        buttonImage:'<%=con_root%>/images/contents/cal.png',
		        onClose:function(selectedDate){
		        	//$("#sp_sdate").datepicker("option","maxDate",selectedDate);
		        }
			});	 
		    $("input[name ='sp_edate']").datepicker("setDate","today");
		    
		    $(".ui-datepicker-trigger").css({verticalAlign:"middle",marginLeft:"3px"}); 
		    
			var cols =[{label:'번호'				,name:'rnum'					,index:'rnum'					,align:'center'		,width:'100'		,hidden:false		,sortable:false	}
						,{label:'기업구분'			,name:'corp_divn_cd_nm'			,index:'corp_divn_cd_nm'		,align:'center'		,width:'200'	,hidden:false		,sortable:false }
						,{label:'회원구분'			,name:'corp_mem_divn_nm'		,index:'corp_mem_divn_nm'		,align:'center'		,width:'150'	,hidden:false		,sortable:false }
						,{label:'설비분야'			,name:'corp_fac_divn_cd_nm'		,index:'corp_fac_divn_cd_nm'	,align:'center'		,width:'200'	,hidden:false		,sortable:false }
						,{label:'제품구분'			,name:'prod_divn_nm'			,index:'prod_divn_nm'			,align:'left'		,width:'120'	,hidden:false		,sortable:false 	}						
				   		,{label:'회사명'			,name:'corp_nm'					,index:'corp_nm'				,align:'center'		,width:'120'	,hidden:false		,sortable:false 	}
				   		,{label:'제품명'			,name:'prod_nm'					,index:'prod_nm'				,align:'left'		,width:'120'	,hidden:false		,sortable:false 	}
				   		,{label:'대표자명'			,name:'corp_repe_nm'		,index:'corp_repe_nm'		,align:'left'		,width:'150'	,hidden:false		,sortable:false 	}
				   		,{label:'대표번호'			,name:'corp_tel_no_1'			,index:'corp_tel_no_1'			,align:'left'		,width:'150'	,hidden:false		,sortable:false 	}
				   		,{label:'메일전송확인'		,name:'mail_send_log'			,index:'mail_send_log'			,align:'left'		,width:'150'	,hidden:false		,sortable:false ,formatter : fmmail_send_log	}
				   		,{label:'인증종류'			,name:'auth_type_nm'			,index:'auth_type_nm'			,align:'center'		,width:'100'	,hidden:false		,sortable:false 	}
				   		
				   		,{label:'메일전송건수'		,name:'mail_send_cnt'			,index:'mail_send_cnt'		,align:'left'		,width:'0'		,hidden:true		,sortable:false }
				   		,{label:'등록자아이디'		,name:'reg_id'					,index:'reg_id'				,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'등록일자'			,name:'reg_date'				,index:'reg_date'			,align:'center'  	,width:'100'  	,hidden:false  		,sortable:false	}
				   		,{label:'등록자명'			,name:'user_nm'					,index:'user_nm'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'등록자구분'		,name:'auth_type'				,index:'auth_type'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'기업구분코드'		,name:'corp_divn'				,index:'corp_divn'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'회원구분코드'		,name:'corp_mem_divn'			,index:'corp_mem_divn'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'설비분야코드'		,name:'corp_fac_divn'			,index:'corp_fac_divn'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'제품구분코드'		,name:'prod_divn'				,index:'prod_divn'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'key'			,name:'prod_seq'				,index:'prod_seq'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			 
			];
		
			//init grid
			var grid = com.grid.init({
				 id			: '#jqGrid' 
				,viewrecords: true
				,height		: 480
				,autowidth : true
				,shrinkToFit: false
				,rowNum		: 15
				,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }
				,gridComplete: function(){
					mergeCellcomplet($(this));
				}
				,custom : { //custom
					 cols : cols //컬럼정보 - 필수!
					,navButton : {
						excel : {
							exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
						}
					}
				}
				,loadComplete: function(data){
					if(searchYn){
						isLoadData(data);
					}
				}	
				,onSelectRow: function(id) {
					var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다
					create_form_view1(ret.prod_seq);
				}
			});
			
		    /*$("#jqGrid").jqGrid('setGroupHeaders',{
				useColSpanStyle: true,    // 셀병합 여부(Group 대상 제외)
		    	groupHeaders:[             // 명명한 컬럼으로 부터 n개까지 병합(Group 대상)
		    					
								 {startColumnName: 'provd_charger_nm', numberOfColumns: 3, titleText: '가공'}
								,{startColumnName: 'non_idntfc_sttus_cd_nm', numberOfColumns: 4, titleText: '비식별'}
								
						]
			});	*/		
			

			// 메일전송이력 조회
			var cols2 =[{label:'번호'	,name:'row_seqno'				,index:'row_seqno'			,align:'center'		,width:'60'		,hidden:true		,sortable:false	}
			,{label:'발송자'			,name:'fr_mail'					,index:'fr_mail'			,align:'center'		,width:'180'		,hidden:false		,sortable:false ,formatter : fmfr_mail}
			,{label:'수신자'			,name:'to_mail'					,index:'to_mail'			,align:'left'		,width:'150'		,hidden:false		,sortable:false ,formatter : fmto_mail}
			,{label:'메일제목'			,name:'mail_subject'			,index:'mail_subject'		,align:'center'		,width:'200'		,hidden:false		,sortable:false		}
			,{label:'메일내용'			,name:'mail_contents_view'		,index:'mail_contents_view'		,align:'center'		,width:'100'		,hidden:false	,sortable:false ,formatter : fmmail_contents_view	}
			,{label:'발송일'			,name:'reg_dt'					,index:'reg_dt'				,align:'center'		,width:'100'		,hidden:false		,sortable:false 	}
			,{label:'수신일시'			,name:'recv_dt'					,index:'recv_dt'			,align:'center'		,width:'200'		,hidden:false		,sortable:false 	}
			
			,{label:'메일내용'				,name:'mail_contents'			,index:'mail_contents'	,align:'center'		,width:'0'		,hidden:true		,sortable:false 	}
			,{label:'key'				,name:'to_user_ty'				,index:'to_user_ty'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'to_user_nm'				,index:'to_user_nm'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'to_user_id'				,index:'to_user_id'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'reg_id'					,index:'reg_id'			,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'order_no'				,index:'order_no'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'menu_data_key'			,index:'menu_data_key'	,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'menu_cd'					,index:'menu_cd'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			,{label:'key'				,name:'mail_seq'				,index:'mail_seq'		,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			
				
			];

			//init grid2
			var grid2 = com.grid.init({
				id			: '#jqGrid2' 
				,viewrecords: true
				,height		: 380
				,autowidth : true
				,shrinkToFit: true
				,multiselect	: false
				,rowNum		: 1000
				,scroll		: -1
				,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }
				,gridComplete: function(){
				mergeCellcomplet($(this));
				}
				,custom : { //custom
				 cols : cols2 //컬럼정보 - 필수!
				,navButton : {
					excel : {
						exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
					}
				}
				}
				,loadComplete: function(data){
					if(searchYn){
						//isLoadData(data);
					}
				}
				,onSelectRow: function(id) { // row를 선택했을때 액션.
					
					var ret = $("#jqGrid2").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
		
					
				}
			});			
			
		// 검색버튼
		$("#btn_search").click( function() {
			refreshGrid();
		});
			
	
		
		// 검색어
		$("#sKeyWord").keydown(function(e){
			if(e.keyCode == 13){
				refreshGrid();
			}
		});
		
		$("#btn_excel").click(function(e){
			$("#pstate").val("X");
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:""],엑셀명)
			excelDownload3("jqGrid","","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 화면리스트", "<c:url value='/cmsmain.do'/>");
		});	
		
		$("#btn_excelAll").click(function(e){
			$("#pstate").val("X");
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
			excelDownload3("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 전체리스트", "<c:url value='/cmsmain.do'/>");
		});
		
		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
			 ,updatemode	: "R"
		});
		

		var file2 = $.fn.cmfile.init({
			 id				: 'cmfile2' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['JPG','PNG','HWP','XLS','XLSX','ZIP','PDF','DOC','DOCX']
			 ,updatemode	: "R"
		});		
		

		
		refreshGrid(false);
		grid_win_resizeAuto();
		CmcloseLoading();
		
	}).ajaxStart(function() {
		//CmopenLoading();
	}).ajaxStop(function() {
		//CmcloseLoading();
	});
	
	var refreshGrid = function(){
		CmopenLoading();
		$('#jqGrid').jqGrid('clearGridData', true);

		$('#prod_seq').val("");
		
		if(!isEmpty($("#sp_sdate").val()) && !isEmpty($("#sp_edate").val())){
			if(parseInt(StrreplaceAll($("#sp_sdate").val(), "-",""),10) > parseInt(StrreplaceAll($("#sp_edate").val(), "-",""),10)){
				alert("검색시작일이 검색종료일 이전이여야합니다");
				$("#sp_sdate").focus();
				return false;
			}
		}
		
		var _frm = document.listfrm;
		_frm.action='<%=RequestURL%>';
		searchYn = true;
		var params = getGridParamDatas();
		var formarr_params = "";
		
		com.grid.reload('#jqGrid','<c:url value='/cmsajax.do'/>'+formarr_params,params);
		setTimeout(CmcloseLoading,1000);
	};
	
	var getGridParamDatas = function(){
		var _params = com.frm.getParamJSON2(document.listfrm);
		_params.pstate = "X";
		return _params;
	};
	
	var fmmail_send_log = function(cellvalue, options, rowObject){
		
		if(rowObject.mail_send_cnt == null){
			rowObject.mail_send_cnt = 0;
		}
		
		
		var returnCell = "";
		
		if (rowObject.mail_send_cnt > 0) {
			returnCell = "<span class='btn_pack medium'> <a href='#' onclick=create_form_view2('" + rowObject.prod_seq + "') >메일전송확인 ("+rowObject.mail_send_cnt+")</a></span>";
		}else{
			returnCell = "<span class='btn_pack medium'> <a href='#' onclick=alert('메일전송이력이 없습니다.!') >메일전송확인 ("+rowObject.mail_send_cnt+")</a></span>";
		}
		
		return returnCell;
	};
	
	var fmmail_contents_view = function(cellvalue, options, rowObject){
		

		
		var returnCell = "";
		
		returnCell = "<span class='btn_pack medium'> <a href='#' onclick=create_form_mailview2('" + options.rowId + "') >메일내용확인</a></span>";
		
		
		return returnCell;
	};	
	
	
	var fmfr_mail = function(cellvalue, options, rowObject){
		

		
		var returnCell = "";
		
		returnCell = "<span style='font-size:12px;'>"+cellvalue.replace(/</gi,"&lt;").replace(/>/gi,"&gt;")+"</span>";
		
		
		return returnCell;
	};
	
	var fmto_mail = function(cellvalue, options, rowObject){
		

		
		var returnCell = "";
		
		returnCell = "<span style='font-size:12px;'>"+cellvalue.replace(/</gi,"&lt;").replace(/>/gi,"&gt;")+"</span>";
		
		
		return returnCell;
	};	
	

	// 상세정보 화면
	var fnView = function(dec_seqno){
		
		su_form = document.listfrm;
		
		$("#pstate").val("R");
		
		//alert(displayView+"------"+mng_sttus_cd+"------"+su_form.pstate.value);
		su_form.method = 'post';
		su_form.idec_seqno.value = dec_seqno;
		su_form.action = '<%=RequestURL%>';
		su_form.submit();
		su_form.target = "";
	};
	
	// 내용조회팝업 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var refresh1 = function(){
		
		//$("form[name=create_formfm2]").find("#selprod_seq2").val($("form[name=dataForm]").find("#ireq_rcept_no").val())
		
		$("form[name=create_formfm1]").find("#pstate").val("X2");
		var params =  $("form[name=create_formfm1]").serialize();

		 $.ajax({
	        type: "post",
	        url: "<c:url value='/cmsajax.do'/>",
	        data: params,
	        async: false,
	        dataType:"json",
	        timeout: 3000,
	        error: function (jqXHR, textStatus, errorThrown) {
	            // 통신에 에러가 있을경우 처리할 내용(생략가능)
		        	alert("네트웍장애가 발생했습니다. 다시시도해주세요"); 
		        	create_form_close1();
	        },			             
	        success: function(data){
	           if(data.result==true){
					if(data.prodDtl!=""){ 
						
						ConListToHtml(data);
					}else{
						alert("제품정보를 조회하는데 실패했습니다.");
						create_form_close1();
					}
					
	           }else{
		        	alert(data.TRS_MSG);
		        	create_form_close1();
		        	
	           }
				
	           $("form[name=create_formfm1]").find("#pstate").val("L");
	          	
	        }

		});	
	
	};
	
	//TODO : ConListToHtml
	var ConListToHtml = function(res_data){

		var hi=0;
		var hj=0;
		var list_html = "";
		var desc_html = "";
		var file1_nms_arr = "";
		var file1_seq_arr = "";
		var rows = res_data.prodDtl;
		var di = 0;
		
		/////////////////////////////////////////////////////////////////////////////////////// 기업소개  	
		$("form[name=create_formfm1]").find("#CORP_NM").val(htmlTextAreaGridBr(rows.corp_nm));

		//console.log("rows.corp_divn===>"+rows.corp_divn);
		var CORP_DIVN_str = rows.corp_divn;
		var CORP_DIVN_str_arr = CORP_DIVN_str.split(",");

		//$("form[name=dataForm]").find("input:checkbox[name=CORP_DIVN]").each(function(idx){		
			for(di=0;di<CORP_DIVN_str_arr.length;di++){
				$("form[name=create_formfm1]").find("input:checkbox[name=CORP_DIVN][value='"+CORP_DIVN_str_arr[di]+"']").prop("checked",true);
				//if(this.value==CORP_DIVN_str_arr[di]){
				//	$(this).attr("checked", true);
				//}	
				
			}

		//});
		var CORP_MEM_DIVN_str = rows.corp_mem_divn;
		var CORP_MEM_DIVN_str_arr = CORP_MEM_DIVN_str.split(",");	
		//$("form[name=create_formfm1]").find("input:radio[name=CORP_MEM_DIVN]").prop("checked",false);
			for(di=0;di<CORP_MEM_DIVN_str_arr.length;di++){
				$("form[name=create_formfm1]").find("input:radio[name=CORP_MEM_DIVN][value='"+CORP_MEM_DIVN_str_arr[di]+"']").prop("checked",true);
			}	
			
		var CORP_FAC_DIVN_str = rows.corp_fac_divn;
		var CORP_FAC_DIVN_str_arr = CORP_FAC_DIVN_str.split(",");	
		//$("form[name=create_formfm1]").find("input:checkbox[name=CORP_FAC_DIVN]").prop("checked",false);
			for(di=0;di<CORP_FAC_DIVN_str_arr.length;di++){
				$("form[name=create_formfm1]").find("input:checkbox[name=CORP_FAC_DIVN][value='"+CORP_FAC_DIVN_str_arr[di]+"']").prop("checked",true);
			}
			
		var PROD_TY_str = rows.prod_ty;
		var PROD_TY_str_arr = PROD_TY_str.split(",");	
		//$("form[name=create_formfm1]").find("input:checkbox[name=CORP_FAC_DIVN]").prop("checked",false);
			for(di=0;di<PROD_TY_str_arr.length;di++){
				$("form[name=create_formfm1]").find("input:checkbox[name=PROD_TY][value='"+PROD_TY_str_arr[di]+"']").prop("checked",true);
			}			
			
		$("form[name=create_formfm1]").find("#CORP_REPE_NM").val(htmlTextAreaGridBr(rows.corp_repe_nm));
		$("form[name=create_formfm1]").find("#CORP_EST_DT").val(rows.corp_est_dt);
		$("form[name=create_formfm1]").find("#CORP_TTL_CNT").val(rows.corp_ttl_cnt);
		$("form[name=create_formfm1]").find("#CORP_HIST").val(htmlTextAreaGridBr(rows.corp_hist));
		$("form[name=create_formfm1]").find("#CORP_MAIN_PROD").val(htmlTextAreaGridBr(rows.corp_main_prod));
		$("form[name=create_formfm1]").find("#CORP_NO").val(rows.corp_no);
		
		var CORP_EMAIL_str = rows.corp_email;
		var CORP_EMAIL_str_arr = CORP_EMAIL_str.split("@");
		var email_str_yn = false;
		if(CORP_EMAIL_str_arr[0]!=null && CORP_EMAIL_str_arr[0]!=undefined && CORP_EMAIL_str_arr[0]!=''){
			$("form[name=create_formfm1]").find("select[name=email3] option").each(function(idx){
				if(this.value==CORP_EMAIL_str_arr[1]){
					email_str_yn = true;
				}
			});
			if(email_str_yn==true){
				$("form[name=create_formfm1]").find("#email1").val(CORP_EMAIL_str_arr[0]);
				$("form[name=create_formfm1]").find("#email2").val(CORP_EMAIL_str_arr[1]);
				$("form[name=create_formfm1]").find("#email3").val(CORP_EMAIL_str_arr[1]);
			}else{
				$("form[name=create_formfm1]").find("#email1").val(CORP_EMAIL_str_arr[0]);
				$("form[name=create_formfm1]").find("#email2").val(CORP_EMAIL_str_arr[1]);					
				$("form[name=create_formfm1]").find("#email3").val("직접입력");
			}
			
		}
		
		$("form[name=create_formfm1]").find("#CORP_LINK").val(rows.corp_link);
		var CORP_TEL_NO_1_str = rows.corp_tel_no_1;
		var CORP_TEL_NO_1_str_arr = CORP_TEL_NO_1_str.split("-");	
		if(CORP_TEL_NO_1_str!=""){
			$("form[name=create_formfm1]").find("#CORP_TEL_NO_11").val(nullToDefault(CORP_TEL_NO_1_str_arr[0], ""));
			$("form[name=create_formfm1]").find("#CORP_TEL_NO_12").val(nullToDefault(CORP_TEL_NO_1_str_arr[1], ""));
			$("form[name=create_formfm1]").find("#CORP_TEL_NO_13").val(nullToDefault(CORP_TEL_NO_1_str_arr[2], ""));
			$("form[name=create_formfm1]").find("#CORP_TEL_NO_1").val(nullToDefault(CORP_TEL_NO_1_str, ""));
		}
		
		var CORP_FAX_NO_str = rows.corp_fax_no;
		var CORP_FAX_NO_str_arr = CORP_FAX_NO_str.split("-");	
		if(CORP_FAX_NO_str!=""){
			$("form[name=create_formfm1]").find("#CORP_FAX_NO1").val(nullToDefault(CORP_FAX_NO_str_arr[0], ""));
			$("form[name=create_formfm1]").find("#CORP_FAX_NO2").val(nullToDefault(CORP_FAX_NO_str_arr[1], ""));
			$("form[name=create_formfm1]").find("#CORP_FAX_NO3").val(nullToDefault(CORP_FAX_NO_str_arr[2], ""));
			$("form[name=create_formfm1]").find("#CORP_FAX_NO").val(nullToDefault(CORP_FAX_NO_str, ""));
		}			
		
		/////////////////////////////////////////////////////////////////////////////////////// 기업소개  	
		

		
		/////////////////////////////////////////////////////////////////////////////////////// 제품설명
		$("form[name=create_formfm1]").find("#PROD_NM").val(htmlTextAreaGridBr(rows.prod_nm));
		$("form[name=create_formfm1]").find("#PROD_DIVN").val(rows.prod_divn);
		$("form[name=create_formfm1]").find("#PROD_FUNT").val(htmlTextAreaGridBr(rows.prod_funt));
		$("form[name=create_formfm1]").find("#TECH_STND").val(htmlTextAreaGridBr(rows.tech_stnd));
		$("form[name=create_formfm1]").find("#OPRT_PRCP").val(htmlTextAreaGridBr(rows.oprt_prcp));
		$("form[name=create_formfm1]").find("#DLVRY_RCD").val(htmlTextAreaGridBr(rows.dlvry_rcd));
		
		var fileList1_seq = rows.file1_seq;
		var fileList1_nm = rows.file1_nms;
		fileList1_seq = fileList1_seq.replace(/::/gi,",");
		fileList1_nm = fileList1_nm.replace(/::/gi,",");
		
		var file_group1 = getFileHtmlArray(fileList1_seq, fileList1_nm);
		$.fn.cmfile.setfileList("cmfile1", file_group1);			
		/////////////////////////////////////////////////////////////////////////////////////// 제품설명
		
		/////////////////////////////////////////////////////////////////////////////////////// 인증현황
		$("form[name=create_formfm1]").find("#CERT_PROD").val(htmlTextAreaGridBr(rows.cert_prod));
		$("form[name=create_formfm1]").find("#CERT_DIVN").val(rows.cert_divn);
		$("form[name=create_formfm1]").find("#CERT_DT").val(rows.cert_dt);
		$("form[name=create_formfm1]").find("#CERT_EXPR_DT").val(rows.cert_expr_dt);
		/////////////////////////////////////////////////////////////////////////////////////// 인증현황
		
		/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그
		var fileList2_seq = rows.file2_seq;
		var fileList2_nm = rows.file2_nms;
	
		fileList2_seq = fileList2_seq.replace(/::/gi,",");
		fileList2_nm = fileList2_nm.replace(/::/gi,",");
		
		var file_group2 = getFileHtmlArray(fileList2_seq, fileList2_nm);
		$.fn.cmfile.setfileList("cmfile2", file_group2);
		/////////////////////////////////////////////////////////////////////////////////////// e-카탈로그


	};	
	
	//TODO : create_form_close1 
	// 닫기
	function create_form_close1(){
		$("#create_form_popup1").hide();
		create_form_init1();
		CmclospageDisable();
	}

	function create_form_init1(){
		$("form[name=create_formfm1]").find("input:checkbox[name=CORP_DIVN]").each(function(idx){
			$(this).prop("checked",false);
		});
		
		$("form[name=create_formfm1]").find("input:radio[name=CORP_MEM_DIVN]").each(function(idx){
			$(this).prop("checked",false);
		});	
		
		$("form[name=create_formfm1]").find("input:checkbox[name=CORP_FAC_DIVN]").each(function(idx){
			$(this).prop("checked",false);
		});
		
		$("form[name=create_formfm1]").find("input:checkbox[name=PROD_TY]").each(function(idx){
			$(this).prop("checked",false);
		});		
		
		$("#cmfile1").html("");
		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
			 ,updatemode	: "R"
		});
		
		$("#cmfile2").html("");
		var file2 = $.fn.cmfile.init({
			 id				: 'cmfile2' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['JPG','PNG','HWP','XLS','XLSX','ZIP','PDF','DOC','DOCX']
			 ,updatemode	: "R"
		});			
	}	

	//TODO : create_form_view1 
	// 창 오픈
	function create_form_view1(selprod_seq){
		CmopenpageDisable();
		
	    $("#create_form_popup1").draggable({ opacity:"0.3",handle:"#contents_view_title1" }); // 끄는 동안만 불투명도 주기

	    $("body").droppable({

	        accept: "#create_form_popup2",    // 드롭시킬 대상 요소

	        drop: function(event, ui) {

	        	$("#create_form_popup2").css({ opacity:"1.0" });

	        }

	    });
	    
		$("form[name=create_formfm1]").find("#selprod_seq1").val(selprod_seq);
		
		$("#contents_view_title1").html("<span >&#8226; </span>"+" 제품조회");
		
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_popup1").css("left",( (($(document).width() - 1000) / 3) + $(document).scrollLeft()  )+"px");
		$("#create_form_popup1").css("top", ( (($(document).height() - 640) / 2) + $(document).scrollTop() - (($(document).height() - 600) / 5)  )+"px");	

		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);
		$("#contents_view_area").height(560);

		$("#create_form_popup1").show(500);

		refresh1();
	}	
	
	// 내용조회팝업 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	// 메일전송목록확인 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var refreshGrid2 = function(){
		
		//$("form[name=create_formfm2]").find("#selprod_seq2").val($("form[name=dataForm]").find("#ireq_rcept_no").val())
		
		$('#jqGrid2').jqGrid('clearGridData', true);
	
		var _frm = document.create_formfm2;
		_frm.action='<c:url value='/cmsmain.do'/>';
		searchYn = true;
		var params = getGridParamDatas2();
		var formarr_params = "";
		
		com.grid.reload('#jqGrid2','<c:url value='/cmsajax.do'/>'+formarr_params,params);
	
	};
	
	var getGridParamDatas2 = function(){
		var _params = com.frm.getParamJSON2(document.create_formfm2);
		_params.pstate = "XP2";
		return _params;
	};
	
	//TODO : create_form_close2 
	//메일이력목록창 닫기
	function create_form_close2(){
		$("#create_form_popup2").hide();
		create_form_init2();
		create_form_mailview_close2();
		CmclospageDisable();
	}

	function create_form_init2(){

	}	

	//TODO : create_form_view2 
	//메일전송이력목록 창 오픈
	function create_form_view2(selprod_seq){
		CmopenpageDisable();
		
	    $("#create_form_popup2").draggable({ opacity:"0.3",handle:"#mail_loglist_title" }); // 끄는 동안만 불투명도 주기

	    $("body").droppable({

	        accept: "#create_form_popup2",    // 드롭시킬 대상 요소

	        drop: function(event, ui) {

	        	$("#create_form_popup2").css({ opacity:"1.0" });

	        }

	    });
	    
		$("form[name=create_formfm2]").find("#selprod_seq2").val(selprod_seq);
		
		$("#mail_loglist_title").html("<span >&#8226; </span>"+"메일 전송 이력");
		
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_popup2").css("left",( (($(document).width() - 1000) / 3) + $(document).scrollLeft()  )+"px");
		$("#create_form_popup2").css("top", ( (($(document).height() - 640) / 2) + $(document).scrollTop() - (($(document).height() - 600) / 5)  )+"px");	

		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);

		/*$("#gbox_jqGrid3").width(698);
		$("#gview_jqGrid3").width(698);
		$("#jqGrid3Pager").width(698);
		$(".ui-jqgrid-hdiv").width(698);
		$("#jqGrid3").width(698);*/
		jQuery("#jqGrid2").jqGrid("setGridWidth",990);
		$("#jqGrid2").width(690);
		$("#create_form_popup2").show(500);

		refreshGrid2();
	}	
	
	
	function create_form_mailview_close2(){
		$("#create_form_mcontents2").hide();
		$("#mcontents2").contents().find("body").html("");
	}	
	
	function create_form_mailview2(grid_rowId){
	    $("#create_form_mcontents2").draggable({ opacity:"0.3",handle:"#mcontents2_title" }); // 끄는 동안만 불투명도 주기

	    $("body").droppable({

	        accept: "#create_form_mcontents2",    // 드롭시킬 대상 요소

	        drop: function(event, ui) {

	        	$("#create_form_mcontents2").css({ opacity:"1.0" });

	        }

	    });		
	    
	    $("#mcontents2_title").html("<span >&#8226; </span>"+"메일 내용");
	    
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_mcontents2").css("left",( (($(document).width() - 780) / 3) + $(document).scrollLeft()  )+"px");
		$("#create_form_mcontents2").css("top", ( (($(document).height() - 640) / 2) + $(document).scrollTop() - (($(document).height() - 600) / 5)  )+"px");	

		$("#create_form_mcontents2").show(500);	 
		$("#mcontents2").attr("width","100%");
		$("#mcontents2").attr("height","600px");
		var ret = $("#jqGrid2").jqGrid("getRowData",grid_rowId); // ret는 선택한 row 값을 쥐고있는 객체다.
		//console.log(ret.mail_contents);
		$("#mcontents2").contents().find("body").append(ret.mail_contents);
		
	}	
	// 메일전송이력조회 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
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