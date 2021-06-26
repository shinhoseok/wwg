<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jiop_opn_010_s3.jsp
%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post" onsubmit="return false;srchCheck(event);">
 <input type="hidden" 	id="scode" 				name="scode" 		value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 		value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 		value="<%=pstate %>" />
 <input type="hidden" 	id="curr_page"  		name="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
 <input type="hidden" 	id="show_rows"  		name="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
 <input type="hidden" 	id="page" 				name="page" 		value="${R_MAP.param.page}"/>
 <input type="hidden" 	id="data_seqno" 		name="data_seqno" />
 <input type="hidden" 	id="REG_NM" 			name="REG_NM" 		value="${R_MAP.param.REG_NM}"/>
 <input type="hidden" 	id="REG_HP_NO" 			name="REG_HP_NO" 	value="${R_MAP.param.REG_HP_NO}"/>
 <input type="hidden" 	id="REG_EMAIL" 			name="REG_EMAIL" 	value="${R_MAP.param.REG_EMAIL}"/>
 <input type="hidden" 	id="SECRET_NO" 			name="SECRET_NO" 	value="${R_MAP.param.SECRET_NO}"/> 


                <div class="cts_mid">

                    <div class="inputArea">
                        <div class="areaInner">
                            <legend><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 검색</legend>
                            <select name="searchGubun" id="searchGubun" title="검색 구분 선택">
                            	<option value="" id="sg_sel" <c:if test="${R_MAP.param.searchGubun == ''}">selected="selected"</c:if>>선택</option>
                                <option value="data_title" id="sg_data_title" <c:if test="${R_MAP.param.searchGubun == 'data_title'}">selected="selected"</c:if>>제목</option>
                                 <option value="data_desc" id="sg_data_desc" <c:if test="${R_MAP.param.searchGubun == 'data_desc'}">selected="selected"</c:if>>내용</option>
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
					<div class="tableArea info_list">
                        <table class="tableA">
                           <caption><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 목록-번호,제목,첨부파일,작성자,작성일,조회수</caption>
                           <colgroup>
                            	<col width="9%" />
                            	<col width="*" />
                            	<col width="12%" />
                            	<col width="15%" />
                            	<col width="15%" />
                            	<col width="15%" />
                           </colgroup>
                           <thead>
								<tr id="list_th_obj">
									<th scope="col" class="resp">번호</th>
									<th scope="col">제목</th>
									<th scope="col" class="resp">첨부파일</th>
									<th scope="col" class="resp_1000">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col" class="resp_1000">조회수</th>
								</tr>

						   </thead>
						   <tbody id="list_data_obj">
								<tr>
									<td	class='no_text' colspan="6">조회된 데이터가 없습니다.</td>
								</tr>						   
						   </tbody>
						</table>
					</div>
                                                
                    <div class="pagingArea">

                    </div>
					<div class="btnArea">
						<a href="#" class="btnBK" id="btn_cancel" onclick='return false;'>취소</a>
					</div>
				</div>
</form>

	

<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('#contents').parent('div').addClass('notice');	
		
		$("#search_btn").click( function() {
			
			/*if(!isEmpty($("#sDate").val()) && !isEmpty($("#eDate").val())){
				if(parseInt(StrreplaceAll($("#sDate").val(), "-",""),10) > parseInt(StrreplaceAll($("#eDate").val(), "-",""),10)){
					alert("조회시작일자가 조회종료일자보다 큽니다.");
					$("#sDate").focus();
					return false;
				}
			}*/
			
			$("#curr_page").val("1");
			refreshCon();
		});		
		
		// 취소
		$("#btn_cancel").click(function(e){

			document.dataForm.method='post';
			document.dataForm.pstate.value='L';
		
			
			document.dataForm.action='<c:url value='/cmsmain.do'/>';
			document.dataForm.submit();
			document.dataForm.target = "";
		});			
		

		var submitGuard = function(e){
			e.preventDefault();
	        e.stopPropagation();
		};
		$("form[name=dataForm]").bind("submit",submitGuard);
		//$("#search_btn").trigger("click");
		refreshCon();
	});
	
	// 상세보기
	var fnRequstInfo = function(data_seqno, regId){
		/*if("<c:out value='${nUser}'/>" == 'N'){
			if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
				document.location.href="/cmsmain.do?scode=S01&pcode=000253";
				return;
			}else{
				return;
			}
			
		}*/

		$("input[name=pstate]").val("R");
		$("#dataForm").find("input[name=data_seqno]").val(data_seqno);
		
		var params = jQuery("#dataForm").serialize();
		
		/*if(regId == "<c:out value='${nUser}'/>"){
			fnOpenPwLayer(reqRceptNo, "SC");
		}else{
			alert("신청한 본인만 내용을 확인할수 있습니다.");
			return;
		}*/
		document.dataForm.submit();
		

	};	
	

	
	//TODO : refreshCon
	function refreshCon(){


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
						$("#list_data_obj").append("<tr><td	class='no_text' colspan='6'>조회된 데이터가 없습니다.</td></tr>");
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
		var arti_No = 0;
		var rows = res_data.rows;

		for(hi=0;hi<rows.length;hi++){
			arti_No=  parseInt(res_data.records,10) - parseInt($("#show_rows").val(),10)*(parseInt(res_data.page,10)-1)-hi;
			
			list_html = "<tr>";
			//번호
			list_html = list_html+"<td class=\"resp\">"+(arti_No)+"</td>";
			//제목
			list_html = list_html+"<td class=\"subject\" id=\"b_title_dot\" >";
		      if(parseInt(rows[hi].r_depth,10) > 1 ){

		    	  for(k=1;k<parseInt(rows[hi].r_depth,10);k++){
		    		  list_html = list_html+"&nbsp;&nbsp;";
		    	  }

		    	  list_html = list_html+"<img src=\"<%=img_url %>/cm/icon_reply.gif\" alt=\"답변\" />";
		      
		      }
		    list_html = list_html+"<a href=\"#\" onclick=\"Go_View('"+rows[hi].menu_cd+"',"+rows[hi].data_seqno+");return false;\">";
		    list_html = list_html+""+cutStr(rows[hi].data_title.replace(/&amp;amp;/gi,"&"),67);
		    list_html = list_html+"</a>";
     		  // 현재일자와 등록일자 차이가 14일 이내이면 new이미지를 보여준다
	      	  if(parseInt(StrreplaceAll("<%=curDate%>","-",""),10) < parseInt(getadddate(StrreplaceAll(rows[hi].reg_dt,"-",""),"+", 7),10)){
	    	  	  list_html = list_html+"<span class='icon_new'>새글</span>";	
	      	  }
		    list_html = list_html+"</td>";	    
		    
		    //첨부
			list_html = list_html+"<td class=\"resp add\">";

		      	if(rows[hi].file1_nms!="" && rows[hi].file1_nms!=null){
			      var file1_nms_arr = rows[hi].file1_nms.split("::");
			      var file1_seq_arr = rows[hi].file1_seq.split("::");
			      var fext = "";  // 파일 확장자

			      if(file1_nms_arr != null){
			    	  for(j=0;j<file1_nms_arr.length;j++){	
			    		  if(file1_nms_arr[j]!=""){
			    			  fext = file1_nms_arr[j].substring(file1_nms_arr[j].lastIndexOf(".")+1).toLowerCase();
			    			  list_html = list_html+"<span class=\"attach\" 파일다운로드>";
			    			  list_html = list_html+"첨부파일</span>";
			    		  }
			    	  }// for 문 종료
			      }
		      	}
		      	list_html = list_html+"</td>";	
		    // 작성자
		    list_html = list_html+"<td class=\"resp_1000\">"+rows[hi].reg_nm+"</td>";
		    
		    // 작성일
		    list_html = list_html+"<td class=\"resp_1000\">"+rows[hi].reg_dt+"</td>";
		    // 조회수
		    list_html = list_html+"<td class=\"resp_1000\">"+rows[hi].inq_cnt+"</td>";
		    list_html = list_html+"</tr>";
			    			  

				//desc_html = rows[hi].data_desc.replace(/&lt;/gi,"<")
				//desc_html = desc_html.replace(/&gt;/gi,">");
				//desc_html = desc_html.replace(/&amp;/gi,"&");
				
				$("#list_data_obj").append(list_html);
				
			

		}// FOR 종료
		
			// 페이징을 생성한다
			//console.log("res_data.record:"+res_data.records+":res_data.page:"+res_data.page+":$(#show_rows).val():"+$("#show_rows").val()+":hi:"+hi);
			$(".pagingArea").html(PageindexS(res_data.records,$("#show_rows").val(),res_data.total,$("#curr_page").val(),"document.dataForm","<%=RequestURL%>","curr_page","<%=img_url%>/cmsadmin"));


	}	
	
	function getadddate(datestr,flag, num){
		var iyyyy = parseInt(datestr.substring(0,4),10);
		var imm	  = parseInt(datestr.substring(4,6),10);
		var idd	  = parseInt(datestr.substring(6,8),10);	
		var ret_date = new Date();
		//console.log(iyyyy+"::"+imm+"::"+idd);
		if(flag=="+"){
			ret_date = new Date(iyyyy,imm,idd+num);
			//console.log("ret_date+::"+ret_date);
		}else{
			ret_date = new Date(iyyyy,imm,idd-num);
			//console.log("ret_date-::"+ret_date);
		}
		//console.log("ret_date  ::"+ret_date.getYear()+"::"+(ret_date.getMonth()+1)+"::"+ret_date.getDate());
		return ret_date.getFullYear()+""+(ret_date.getMonth()>9?ret_date.getMonth():"0"+ret_date.getMonth())+""+(ret_date.getDate()>9?ret_date.getDate():"0"+ret_date.getDate());

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

	      
	      pagestr = pagestr +"<button class=\"first_btn\" onclick=\"goPagination2('"+formname+"','"+action+"','1','"+formele+"');return false;\">"
	    		  + "첫페이지 보기</button>";
	      
	      if(!prevDisabled){
	    	  pagestr = pagestr +"<button class=\"prev_btn\" onclick=\"goPagination2('"+formname+"','"+action+"','"+prevPage+"','"+formele+"');return false;\">"
		    		+ "이전페이지 보기</button>";
	      }else{
	    	  pagestr = pagestr +"<button class=\"prev_btn\" onclick=\"return false;\">이전페이지 보기</button>";
	      }
	      
	      for(var k=fromPage;k<=toPage;k++){ 
	    	  var index = k;
	    	  var isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr = pagestr +"\n<a href=\"#\" class=\"now\" style=\"margin-right:10px;\"onclick=\"goPagination2('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\">"+index+"</a>";
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr = pagestr +"\n<a href=\"#\" onclick=\"goPagination2('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\" >"+index+"</a>";
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
	    	  pagestr = pagestr +"<button class=\"next_btn\" onclick=\"goPagination2('"+formname+"','"+action+"','"+nextPage+"','"+formele+"');return false;\">"
			    		+ "다음페이지 보기</button>";
	    	  
	      }else{
		      pagestr = pagestr +"<button class=\"next_btn\" onclick=\"return false;\">다음페이지 보기</button>"; 
	      }
	      
	      pagestr = pagestr +"<button class=\"last_btn\" onclick=\"goPagination2('"+formname+"','"+action+"','"+TotalPageCount+"','"+formele+"');return false;\">"
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
	

	function goPagination2(form,URL,pageIndex,formele){
		$("form[name=dataForm]").find("#curr_page").val(pageIndex);
		refreshCon();		
	}	
	
	// 파일다운로드
	function GoDownfile(file_seqno){
		$.fn.cmfile.fileDownLoad("",file_seqno);
	}		
	
	function Go_View(pcode,pidx){
		
		  su_form=document.dataForm;
		  su_form.method='post';

		  su_form.data_seqno.value=pidx;
		  su_form.pstate.value='R';
		  su_form.action='<c:url value='/cmsmain.do'/>';
		  
		  su_form.submit();
		  su_form.target = "";	

	}	
	
//]]>
</script>
