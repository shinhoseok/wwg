<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_010_s1.jsp
%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post" onsubmit="return false;srchCheck(event);">
 <input type="hidden" 	id="scode" 				name="scode" 	value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 	value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 	value="<%=pstate %>" />
 <input type="hidden" 	id="curr_page"  		name="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
 <input type="hidden" 	id="show_rows"  		name="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
 <input type="hidden" 	id="page" 				name="page" 	value="${R_MAP.param.page}"/>
 <input type="hidden" 	id="prod_seq" 			name="prod_seq" />
 <input type="hidden" 	id="othbc_yn" 			name="othbc_yn" />
 <input type="hidden" 	id="searchTab" 			name="searchTab" value="<c:out value="${R_MAP.param.searchTab}"/>"/>

<fmt:parseDate var="sDate" pattern="yyyyMMdd" value="${R_MAP.param.sDate}" />
<fmt:parseDate var="eDate" pattern="yyyyMMdd" value="${R_MAP.param.eDate}" />

                <div class="cts_mid">
                    <div class="tabmenu">
                        <div class="tab_prev"></div>
                        <div class="tabinner">
                            <ul>
                                <li class="tab-link<c:if test="${R_MAP.param.searchTab == '1'}"> current</c:if>" data-tab="tab-1"><a href="#" onclick="return false;">전체</a></li>
                                <li class="tab-link<c:if test="${R_MAP.param.searchTab == '2'}"> current</c:if>" data-tab="tab-2"><a href="#" onclick="return false;">설비분야(기계)</a></li>
                                <li class="tab-link<c:if test="${R_MAP.param.searchTab == '3'}"> current</c:if>" data-tab="tab-3"><a href="#" onclick="return false;">설비분야(전기)</a></li>
                                <li class="tab-link<c:if test="${R_MAP.param.searchTab == '4'}"> current</c:if>" data-tab="tab-4"><a href="#" onclick="return false;">설비분야(제어)</a></li>
                                <li class="tab-link<c:if test="${R_MAP.param.searchTab == '5'}"> current</c:if>" data-tab="tab-5"><a href="#" onclick="return false;">여성/사회적 약자기업 등</a></li>
                            </ul>
                        </div>
                        <div class="tab_next"></div>
                    </div>
                    <div class="inputArea">
                        <div class="areaInner">
                            <legend><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 검색</legend>
                            <select name="searchGubun" id="searchGubun" title="검색 구분 선택">
                            	<option value="" id="sg_sel" <c:if test="${R_MAP.param.searchGubun == ''}">selected="selected"</c:if>>선택</option>
                                <option value="prod_nm" id="sg_prod_nm" <c:if test="${R_MAP.param.searchGubun == 'prod_nm'}">selected="selected"</c:if>>제품명</option>
                                <option value="prod_info" id="sg_prod_info" <c:if test="${R_MAP.param.searchGubun == 'prod_info'}">selected="selected"</c:if>>제품정보</option>
                                <option value="corp_nm" id="sg_corp_nm" <c:if test="${R_MAP.param.searchGubun == 'corp_nm'}">selected="selected"</c:if>>업체명</option>
                            </select>
                            <input type="text" name="searchValue" id="searchValue" value="<c:out value="${R_MAP.param.searchValue}"/>" title="검색어 입력" onKeyDown="srchCheck(event);" onKeyUp="sechnotin();" />
                            <input type="text" name="submitguard" id="submitguard" style="display:none;" />
                            <a class="blueBtn" href="#" id="search_btn">검색</a>
                        </div>
                    </div>
                   
                    <div class="total" id="page_info_id">
                        Total:
                        <span>0</span>건
                        (<span>0</span> / 0)
                    </div>
                    <div class="market_list">
                        <div class="inner" id="list_data_obj">
                            <!-- <div class="product">
                                <a href="#" onclick="fnRequstInfo('11', '11');return false;">
                                    <div>
                                        <div class="circle"><img src="<%=con_root%>/images/project_img/sub/product01.png" alt="" /></div>
                                    </div>
                                    <p>랙타입 자동절체 듀얼 온도전송기</p>
                                </a>
                            </div> -->
							<div class="product">
                                    <div>
                                        <p>조회된 제품이 없습니다.</p>
                                    </div>
                            </div>                            
 
                        </div>
                    </div>
                    <div class="pagingArea">

                    </div>
					<div class="btnArea">
						<c:if test="${nUser == 'N'}">
							<a href="#" class="blueBtn" id="btn_reg_gologin" onclick='return false;'>회원 글쓰기</a>
							<a href="#" class="blueBtn" id="btn_reg_goagree" onclick='return false;'>비회원 글쓰기</a>
						</c:if>
						<c:if test="${nUser != 'N' && nUser != ''}">
							<a href="#" class="blueBtn" id="btn_reg_login" onclick='return false;'>글쓰기</a>
						</c:if>
						
					</div>
				</div>
</form>

	

<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('#contents').parent('div').addClass('market');
		
		$("#btn_reg").click( function() {
			//alert("임시오픈중에는 등록이 안됩니다.");
			//return;			
			if("N" == "<c:out value='${nUser}'/>"){
				// 회원로그인 확인
				if(confirm('로그인 또는 개인정보수집 동의 후 사용가능합니다.\n확인을 선택하시면 로그인화면으로 취소를 누르시면 개인정보수집동의 화면으로 이동합니다.')){
					//document.location.href="<c:url value='/cmsmain.do'/>?scode=S01&pcode=000253";
					Go_LoginPageView("<%=pcode %>", "CF","");
				// 개인정보동의 페이지로 이동
				}else{
					$("#dataForm").find("#pstate").val("CF1");
					document.dataForm.submit();					
				}
			}else{
				$("#dataForm").find("#pstate").val("CF");
				//$("#dataForm").submit();
				document.dataForm.submit();
			}

			//}
		});
		
		$("#btn_reg_login").click( function() {
			$("#dataForm").find("#pstate").val("CF");
			//$("#dataForm").submit();
			document.dataForm.submit();			
		});	
		
		$("#btn_reg_gologin").click( function() {
			Go_LoginPageView("<%=pcode %>", "CF","");		
		});	
		
		$("#btn_reg_goagree").click( function() {
			$("#dataForm").find("#pstate").val("CF1");
			document.dataForm.submit();		
		});		
		
		$("#search_btn").click( function() {
			
			$("#curr_page").val("1");
			refreshCon();
		});		
		
		/*$("#sDate").datepicker({
	        changeMonth: true, 
	        changeYear: true,
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        showOn:'both',
	        buttonImage:'/images/contents/cal.png',
	        onClose:function(selectedDate){
	        	$("#eDate").datepicker("option","minDate",selectedDate);
	        }
		});
		$("#eDate").datepicker({
	        changeMonth: true, 
	        changeYear: true,
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        showOn:'both',
	        buttonImage:'/images/contents/cal.png',
	        onClose:function(selectedDate){
	        	$("#sDate").datepicker("option","maxDate",selectedDate);
	        }
		});
		
		
		
		//상태조건 또는 검색어가 있을시 목록보기 버튼을 보여준다 2018.07.24
		if($('#sRequstSttusCd').val()!='' || $('#sKeyWord').val()!=''){
			$('#btn_2').show();
		}else{
			$('#btn_2').hide();
		}


		

		*/
		var submitGuard = function(e){
			e.preventDefault();
	        e.stopPropagation();
		};
		$("form[name=dataForm]").bind("submit",submitGuard);
		//$("#search_btn").trigger("click");
		refreshCon();
	});
	
	// 상세보기
	var fnRequstInfo = function(prod_seq, regId){
		/*if("<c:out value='${nUser}'/>" == 'N'){
			if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
				document.location.href="/cmsmain.do?scode=S01&pcode=000253";
				return;
			}else{
				return;
			}
			
		}*/

		$("input[name=pstate]").val("R");
		$("#dataForm").find("input[name=prod_seq]").val(prod_seq);
		
		var params = jQuery("#dataForm").serialize();
		
		/*if(regId == "<c:out value='${nUser}'/>"){
			fnOpenPwLayer(reqRceptNo, "SC");
		}else{
			alert("신청한 본인만 내용을 확인할수 있습니다.");
			return;
		}*/
		document.dataForm.submit();
		

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
	
	//TODO : refreshCon
	function refreshCon(){

		//검색어가 있을시 목록보기 버튼을 보여준다 2018.07.21
		/*if($('#searchValue').val()==''){
			$('.button>.btn_2').hide();
		}else{
			$('.button>.btn_2').show();
		}*/
		
		//if (getLength($("#searchValue").val()) > 50 || getLength($("#searchValue").val()) < 4) {
		//	alert("\n검색어는 한글 25자 이상과 한글2자미만을 입력할수 없습니다.");
		if (getLength($("#searchValue").val()) > 50) {
			alert("\n검색어는 한글 25자 이상을 입력할수 없습니다.");		
			$("#searchValue").val("");
			$("#searchValue").focus();  
			return false;
		}			
		
		if (char_chk($("#searchValue").val(),"'") == false) {
			alert("\n검색어는 '을 포함할 수 없습니다.");
			$("#searchValue").val("");
			$("#searchValue").focus(); 
			return false;
		}	
		$("#pstate").val("X");
		var params =  $("form[name=dataForm]").serialize();
		$("#list_data_obj").html("");
		CmopenLoading();
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
		        	CmcloseLoading();          
	        },			             
	        success: function(data){
	           if(data.result==true){
					if(data.rows!=""){ 
						$("#page_info_id").html("Total: <span>"+data.records+"</span>건 (<span>"+data.page+"</span> / "+data.total+")");
						ConListToHtml(data);
					}else{
						$(".paging").html(PageindexS("0",$("#show_rows").val(),"0",$("#curr_page").val(),"document.dataForm","<%=RequestURL%>","curr_page","<%=img_url%>/cmsadmin"));
						$("#page_info_id").html("Total: <span>0</span>건 (<span>0</span> / 0");
						$("#list_data_obj").append("<div class='product'><div><p>조회된 제품이 없습니다.</p></div></div>");
					}
					
	           }else{
		        	alert(data.TRS_MSG);
		        	top.location.href="<%=RequestURL%>";
		        	
	           }
				
	          	$("#pstate").val("L");
	          	CmcloseLoading();
	        }

		});	
	}

	//TODO : ConListToHtml
	function ConListToHtml(res_data){
		var hi=0;
		var hj=0;
		var list_html = "";
		var desc_html = "";
		var file1_nms_arr = "";
		var file1_seq_arr = "";
		var rows = res_data.rows;

		for(hi=0;hi<rows.length;hi++){
			list_html = "";
			
			list_html = list_html + "<div class=\"product\">";
			list_html = list_html + "<a href=\"#\" onclick=\"fnRequstInfo('"+rows[hi].prod_seq+"');return false;\">";
			list_html = list_html + "    <div>";
			
			if(rows[hi].file1_nms!=null && rows[hi].file1_nms!="" && rows[hi].file1_nms!=undefined){
				file1_nms_arr = rows[hi].file1_nms.split("::");
				file1_seq_arr = rows[hi].file1_seq.split("::");
				if(file1_nms_arr[0]!=null && file1_nms_arr[0]!="" && file1_nms_arr[0]!=undefined){
					list_html = list_html + "        <div class=\"circle\"><img src=\"<c:url value='/cmsmain.do'/>?scode=000008&pcode=000015&pstate=FILEDOWN&fpcode=<%=pcode %>&sidx="+rows[hi].prod_seq+"&fidx=1&img_type=thumnail_file\"  alt=\""+file1_nms_arr[0]+"\" /></div>";
					
				}else{
					list_html = list_html + "        <div class=\"circle\"><img src=\"<%=img_url%>/<%=scode%>/search/no_img01.gif\" alt=\"noimg\" /></div>";
				}
			}else{
				list_html = list_html + "        <div class=\"circle\"><img src=\"<%=img_url%>/<%=scode%>/search/no_img01.gif\" alt=\"noimg\" /></div>";
			}
			
						
			
			list_html = list_html + "    </div>";
			list_html = list_html + "    <p>"+rows[hi].prod_nm+"</p>";
			list_html = list_html + "</a>";
			list_html = list_html + " </div>";
				//desc_html = rows[hi].data_desc.replace(/&lt;/gi,"<")
				//desc_html = desc_html.replace(/&gt;/gi,">");
				//desc_html = desc_html.replace(/&amp;/gi,"&");
				
				$("#list_data_obj").append(list_html);
				
			

		}// FOR 종료
		
			// 페이징을 생성한다
			//console.log("res_data.record:"+res_data.records+":res_data.page:"+res_data.page+":$(#show_rows).val():"+$("#show_rows").val()+":hi:"+hi);
			$(".pagingArea").html(PageindexS(res_data.records,$("#show_rows").val(),res_data.total,$("#curr_page").val(),"document.dataForm","<%=RequestURL%>","curr_page","<%=img_url%>/cmsadmin"));


	}	
	
	//TODO : PageindexS
	function PageindexS(TotalCount, show_rows,
			TotalPageCount, curr_page, formname, action,
			formele, imgcon_root){

		var pagestr = "";
		var reapAmount= 10;
		var indexSize = 10;		
		var currs_page = parseInt(curr_page,10);

		var fromPage= ((currs_page) - ((currs_page - 1) % indexSize));
	       if(TotalPageCount==0){
	    	   TotalPageCount = 1;
	       }
	       var toPage = TotalPageCount;
	       if (toPage > (fromPage + indexSize - 1)){
	  	       toPage = (fromPage + indexSize - 1);
	  	   }    
	    
	      var prevPage =0;
	      var reapPrevPage =0;
	      var prevDisabled = false; 
	      var reapPrevDisabled = false; 
	      if(0<(currs_page-1)){
	         prevPage = currs_page-1;
	      }else{
	         prevDisabled = true;
	      }
	      if(0<(currs_page-reapAmount)){
	         reapPrevPage = currs_page-reapAmount;
	      }else{
	         reapPrevDisabled = true;
	      }

	      
	      pagestr = pagestr +"<button class=\"first_btn\" onclick=\"goPagination('"+formname+"','"+action+"','1','"+formele+"');return false;\">"
	    		  + "첫페이지 보기</button>";
	      
	      if(!prevDisabled){
	    	  pagestr = pagestr +"<button class=\"prev_btn\" onclick=\"goPagination('"+formname+"','"+action+"','"+prevPage+"','"+formele+"');return false;\">"
		    		+ "이전페이지 보기</button>";
	      }else{
	    	  pagestr = pagestr +"<button class=\"prev_btn\" onclick=\"return false;\">이전페이지 보기</button>";
	      }
	      
	      for(var k=fromPage;k<=toPage;k++){ 
	    	  var index = k;
	    	  var isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr = pagestr +"\n<a href=\"#\" class=\"now\" style=\"margin-right:10px;\"onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\">"+index+"</a>";
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr = pagestr +"\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\" >"+index+"</a>";
	    	  }
	    	  
	    	  if(k!=toPage){
	    		  pagestr = pagestr +" ";
	    	  }
	      }
	      

	      var nextPage =0;
	      var reapNextPage =0;
	      var nextDisabled = false; 
	      var reapNextDisabled = false; 
	      if((currs_page+1)<=TotalPageCount){
	         nextPage = currs_page+1;
	      }else{
	         nextDisabled = true;
	      }
	      if((currs_page+reapAmount)<=TotalPageCount){
	         reapNextPage = currs_page+reapAmount;
	      }else{
	         reapNextDisabled = true;
	      }

	      if(!nextDisabled){  
	    	  pagestr = pagestr +"<button class=\"next_btn\" onclick=\"goPagination('"+formname+"','"+action+"','"+nextPage+"','"+formele+"');return false;\">"
			    		+ "다음페이지 보기</button>";
	    	  
	      }else{
		      pagestr = pagestr +"<button class=\"next_btn\" onclick=\"return false;\">다음페이지 보기</button>"; 
	      }
	      
	      pagestr = pagestr +"<button class=\"last_btn\" onclick=\"goPagination('"+formname+"','"+action+"','"+TotalPageCount+"','"+formele+"');return false;\">"
	    		  + "마지막페이지 보기</button>";	      
		
		return pagestr;
	}	
	
	function char_chk(str,chk){
		for(i = 0; i < str.length; i++){
			c = str.charAt(i);
			if(c == chk){
				return false;
			}
		}
	}
	
	// 탭선택시 호출됨 common.js에서
	function TabEvtCallBak(tab_index){
		$("#searchTab").val(Number(tab_index)+1);
		$("#search_btn").trigger("click");
	}
	
	function srchCheck(event){
		if(event.keyCode==13){
			if(!isEmpty($("#searchValue").val())){
				$("#search_btn").trigger("click");
				//alert("1");
				event.preventDefault();
				event.stopPropagation();
			}else{
				//alert("2");
				event.preventDefault();
				event.stopPropagation();
			}
			
		}
	}
	
	function sechnotin(event){
		   var m_Sp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\<\>]/;
		   //var m_val = document.getElementsByName("searchValue")[0].value;
		   var m_val = $("#searchValue").val();
		   var strLen = m_val.length;
		   var m_char = m_val.charAt((strLen) - 1);
		   if(m_char.search(m_Sp) != -1) {
		      alert("특수문자는 사용할수없습니다.");
		      $("#searchValue").val("");
		      $("#searchValue").focus();
		      //document.getElementsByName("searchValue")[0].value = "";
		      //document.getElementsByName("searchValue")[0].focus();
		      return;
		   }
	}
	

	
	
//]]>
</script>
