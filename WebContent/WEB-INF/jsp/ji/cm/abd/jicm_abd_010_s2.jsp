<%--/*=================================================================================*//* 시스템            : JRCMS 시스템 SYSTEM/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/abd/jicm_abd_010_s2.jsp /* 프로그램 이름     : jicm_abd_010_s2    /* 소스파일 이름     : jicm_abd_010_s2.jsp/* 설명              : SYSTEM 게시판관리 갤러리형 목록페이지/* 버전              : 1.0.0/* 최초 작성자       : 이금용/* 최초 작성일자     : 2016-11-16/* 최근 수정자       : 이금용/* 최근 수정일시     : 2016-11-16/* 최종 수정내용     : 최초작성/*=================================================================================*/--%><%@page pageEncoding="utf-8"%><%//Map rtn_row_Map = new HashMap();Map rtn_page_List = new HashMap();List rtn_tmp_List = new ArrayList();List code_select_List = new ArrayList(); // 셀렉트박스 생성용 코드리스트Map rtn_row_map2 = new HashMap();rtn_page_List = (Map)rtn_Map.get("PageListABD"); // 조회된 페이지 리스트rtn_tmp_List = (List)rtn_page_List.get("setList"); // 조회된 페이지 리스트String ssidx = (String)rtn_Map.get("sidx");String mode = (String)rtn_Map.get("mode");String tail_gbn = "";int arti_No = 0;//가상순번int j = 0;int k = 0;int list_title_cnt =1;int etc_chk_cnt = 0;int TotalCount = Integer.parseInt(String.valueOf(rtn_page_List.get("setTotalCount")),10);int TotalPageCount = Integer.parseInt(String.valueOf(rtn_page_List.get("setTotalPageCount")),10);%><!--목록시작--><script language="javascript" src="<%=con_root%>/js/com-file.js"></script><form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();' ><!-- 조회된등록수: <%=rtn_page_List.get("setTotalCount")%> 건<br />--><input type="hidden" name="scode" value="<%=scode%>" title="사이트코드" /><input type="hidden" name="pcode" value="<%=pcode%>" title="페이지코드"  /><input type="hidden" name="pstate" value="<%=pstate%>" title="페이지상태"  /><input type="hidden" name="curr_page" value="<%=curr_page%>" title="현재페이지번호"  /><input type="hidden" name="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  /><input type="hidden" name="sidx" value="">					<!--//board_top-->					<div class="board_top">						<P class="board_page">전체페이지(<span id="page_info_id"><%=rtn_page_List.get("setCurrentPage") %>/<%=rtn_page_List.get("setTotalPageCount") %>페이지</span>)</p>						<div class="searchArea">							<!-- <div class="search_select"> -->							<div style="position:absolute;left:0px;top:0px;width:100px;overflow:hidden;height:35px;">													        <select name="se_field" id="se_field" title="제목 내용으로 검색">						        	<option value="" <%if(se_field.equals("")){ %>selected="selected"<%} %> id="sc_all">==전체==</option>						    		<option value="B_TITLE" <%if(se_field.equals("B_TITLE")){ %>selected="selected"<%} %> id="sc_title">제목</option>						            <option value="B_CONTENTS" <%if(se_field.equals("B_CONTENTS")){ %>selected="selected"<%} %> id="sc_writer">내용</option>						        </select>														</div> 							<input type="text" id="se_text" name="se_text" value="<%=se_text %>" Onkeypress="srchCheck()" onKeyUp="sechnotin();" />							<a href="#" class="search_btn" id="btn_search">검색</a>						</div>					</div>					<!--//board_top-->		<!-- galArea --> 		<div id="galArea" class="gallery_list">			<ul>		 <!--<table class="galList">		  <caption>갤러리 리스트</caption>-->		<%		if(rtn_tmp_List == null || rtn_tmp_List.size()==0){		%> 		 <li style="width:100%;text-align:center;"> 등록된 글이 없습니다.</li>		<%		}else{			for(i=0;i<rtn_tmp_List.size();i++){					rtn_row_Map = (Map)rtn_tmp_List.get(i);				//out.println("rtn_row_Map:"+rtn_row_Map);								arti_No=  HtmlText.parseStoftoi(String.valueOf(rtn_page_List.get("setTotalCount"))) - Integer.parseInt(show_rows,10)*(Integer.parseInt(curr_page,10)-1)-i;				if(i==0 || i % 5 == 0){		%>   				<!-- <tr> -->		<%				}		%>				<!-- <td width="18%" > -->				<li>					<span class="alt"></span>					<a href="com_gallery_view.html">						<div class="title">							<div class="thumbnail"><%						if(!HtmlTag.returnString((String)rtn_row_Map.get("file_nms"),"").equals("")){							// 첫번째 첨부파일을 대표이미지로 한다							String [] file_nms_arr = new String[0];							String [] file_seq_arr = new String[0];								if(rtn_row_Map.get("file_nms")!=null){									file_nms_arr = ((String)rtn_row_Map.get("file_nms")).split("::");								}								if(rtn_row_Map.get("file_seq")!=null){									file_seq_arr = ((String)rtn_row_Map.get("file_seq")).split("::");								}														      String fext = "";  // 파일 확장자						      if(file_nms_arr != null){						    	  for(j=0;j<file_nms_arr.length;j++){							    		  if(j==0 && !file_nms_arr[j].equals("")){						    			  fext = file_nms_arr[j].substring(file_nms_arr[j].indexOf(".")+1).toLowerCase();						    	%>						    							    	<!-- <a href="#none" onclick="preview_Image('<%=RequestURL%>?scode=000008&amp;pcode=000015&amp;pstate=FILEDOWN&amp;&fpcode=<%=pcode %>&sidx=<%=rtn_row_Map.get("data_seqno") %>&fidx=<%=(j+1) %>','<%=rtn_row_Map.get("photo_image_alt")%>'); return false;"> -->						    	<a href="#" onclick="Go_View('<%=rtn_row_Map.get("menu_cd") %>',<%=rtn_row_Map.get("data_seqno") %>);return false;">						    	<img src="<%=RequestURL%>?scode=000008&amp;pcode=000015&amp;pstate=FILEDOWN&amp;&fpcode=<%=pcode %>&sidx=<%=rtn_row_Map.get("data_seqno") %>&fidx=<%=(j+1) %>&img_type=thumnail_file"  alt="<%=rtn_row_Map.get("photo_image_alt")%>" style="width:208px;height:159px;" /></a>						    	<%						    		  }						    	  }						      }						}else{						%><a href="#" onclick="Go_View('<%=rtn_row_Map.get("menu_cd") %>',<%=rtn_row_Map.get("data_seqno") %>);return false;"><img src="<%=img_url%>/<%=scode%>/search/no_img01.gif" alt="noimg" /></a><%						}					      %>														</div>							<h4><a href="#" onclick="Go_View('<%=rtn_row_Map.get("menu_cd") %>',<%=rtn_row_Map.get("data_seqno") %>);return false;"><%=rtn_row_Map.get("data_title")%></a></h4>							</div>						<dl class="info">							<dt>등록일</dt>							<dd class="date"><%=rtn_row_Map.get("reg_dt")%></dd>							<dt>조회수</dt>							<dd><%=rtn_row_Map.get("inq_cnt")%></dd>						</dl>					</a>				</li>									<%				//' i를 5로 나눈나머지가 4이면 마지막 이므로 tr을 닫아준다				if (i % 5 == 4){				%>				<!-- </tr> -->				<%				}								}// for문종료						if((i-1) % 5 != 4){				for(j=0;j<4-(((i-1) % 5));j++){		%>				<!-- <td width="18%">&nbsp;</td>				<td width="2%">&nbsp;</td> -->		<%						}		%>				<!-- </tr>-->		<%					}					}		%> 		<!-- </table> -->		   		    </ul> 		</div> <!-- //galArea -->    			<% 			//페이징 관련 변수설정			String formname = "document.listfrm";														// from 이름 ;; document.form[0];			String action	= RequestURL; 						// action 			//out.println(rtn_map.get("setTotalCount")+" "+rtn_map.get("setTotalPageCount"));			String formele = "curr_page";			String pagestr = CM_Util.PageindexS(TotalCount,curr_page,TotalPageCount,curr_page,formname,action,formele,img_url+"/cmsadmin");			%><!--페이지 출력-->		     <div class="paging">		          <%=pagestr%>		     </div><!-- //paging --><div class="fR">      <%-- <%      // 게시판 종류가 통합형, 공지형, 갤러리형이 아닐일경우 등록버튼을 보여준다      if(!BOARD_TY.equals("000025") && !BOARD_TY.equals("000008") && !BOARD_TY.equals("000011")){      %> --%>      <!-- <a Onclick="Go_wrin(); return false;" href="#none"  class="boardBtn">글쓰기</a> --><%-- 	  <%      }	  %>  --%>     </div></form><script type='text/javascript'>$(document).ready(function() {	$("#se_field").singleSelect();	$(".singleSelect").css("width","100px");		// 셀렉트 박스 검색조건 안보이게	$(".singleSelect-selection__rendered").click(function() {		$(".singleSelect-search").hide();		$(".singleSelect-search__field").hide();        });		$(".singleSelect-selection__arrow").click(function() {		$(".singleSelect-search").hide();		$(".singleSelect-search__field").hide();        });	var mode = '<%=mode %>';	if('main'==mode){		Go_View('<%=pcode%>','<%=ssidx %>');			}		$("#btn_search").click( function() {						su_form=document.listfrm;/* 			if (isEmpty(su_form.se_text.value)) {				alert("\n검색어를 입력해 주세요.");				su_form.se_text.value = "";				su_form.se_text.focus(); 				return false;			} */						if (getLength(su_form.se_text.value) > 50) {				alert("\n검색어는 한글 25자 이상을 입력할수 없습니다.");				su_form.se_text.value = "";				su_form.se_text.focus();  				return false;			}									if (char_chk(su_form.se_text.value,"'") == false) {				alert("\n검색어는 '을 포함할 수 없습니다.");				su_form.se_text.value = "";				su_form.se_text.focus();  				return false;			}							  			  su_form.pstate.value='L';			  su_form.curr_page.value=1;			  su_form.action='<%=RequestURL%>';			  su_form.submit();			  su_form.target = "";	});		$("#btn_save").click( function() {		  su_form=document.listfrm;		  su_form.method='post';		  su_form.pstate.value='CF';		  su_form.action='<%=RequestURL%>';		  		  	if(com.tab.isExist()){ //hidden 탭이 존재하면..				var _url = $(document.listfrm).attr('action') + '?' + $(document.listfrm).serialize();				//com.tab.add('CF0','글등록',_url);				com.tab.changeS(_url);			}else{			  su_form.submit();			  su_form.target = "";			}			});		});//<![CDATA[function Go_View(pcode,pidx){	  su_form=document.listfrm;	  su_form.method='post';	  su_form.pcode.value=pcode;	  su_form.sidx.value=pidx;	  su_form.pstate.value='R';	  su_form.action='<%=RequestURL%>';	  	  su_form.submit();	  su_form.target = "";}//글수정처리페이지이동function Go_modin(pidx){  su_form=document.listfrm;  su_form.method='post';  su_form.sidx.value=pidx;  su_form.pstate.value='UF';  su_form.action='<%=RequestURL%>';    	if(com.tab.isExist()){ //hidden 탭이 존재하면..		var _url = $(document.listfrm).attr('action') + '?' + $(document.listfrm).serialize();		//com.tab.add('UF'+pidx,'글수정',_url);		com.tab.changeS(_url);	}else{	  su_form.submit();	  su_form.target = "";	}}//글삭제처리페이지이동function Go_delin(pidx){	  su_form=document.listfrm;  	if(confirm("삭제하시겠습니까?")){		  su_form.target = "successIframe";		  su_form.sidx.value=pidx;		  su_form.pstate.value='D';		  su_form.action='<%=RequestURL%>';		  su_form.submit();		  su_form.target = "";	}else{		return;	}	}// 파일다운로드function GoDownfile(file_seqno){	$.fn.cmfile.fileDownLoad("",file_seqno);}	function sechnotin(){	   var m_Sp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\<\>]/;	   var m_val = document.getElementsByName("se_text")[0].value;	   var strLen = m_val.length;	   var m_char = m_val.charAt((strLen) - 1);	   if(m_char.search(m_Sp) != -1) {	      alert("특수문자는 사용할수없습니다.");	      document.getElementsByName("se_text")[0].value = "";	      document.getElementsByName("se_text")[0].focus();	      return;	   }}function srchCheck(){	if(event.keyCode==13){		$("#btn_search").trigger("click");	}}//#####문자체크function char_chk(str,chk){	for(i = 0; i < str.length; i++){		c = str.charAt(i);		if(c == chk){			return false;		}	}}//]]></script>