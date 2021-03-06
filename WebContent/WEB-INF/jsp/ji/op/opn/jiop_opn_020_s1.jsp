<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
// jiop_opn_020_s1.jsp
%>
<style>

	.ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column { white-space: normal; }
	.ui-jqgrid-htable th{ text-align: center; }
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr {border-left : 1px solid; border-left-color: #dcdcdc; }
	.ui-th-rtl, .ui-jqgrid .ui-jqgrid-htable th.ui-th-rtl {border-right : 1px solid; border-right-color: #dcdcdc; }	

</style>
<script language="javascript" src="<%=con_root%>/js/com-tree.js"></script>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<form name="listfrm" id="listfrm" method="post" onSubmit="return false;srchCheck(event);" >        
<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
<input type="hidden" name="adm_rpcode" id="adm_rpcode" value="<%=adm_rpcode%>" title="현재참조메뉴코드"  />

 <input type="hidden" 	id="data_seqno" 			name="data_seqno" />


<div class="supply_box">
<!--search-->
	<div class="searchArea mT10">
	  <table class="tbl_search">
	    <colgroup>
	    <col width="100">
	    <col width="150">
	    <col width="100">
	    <col width="150">
	    <col width="100">
	    <col width="*">
	    </colgroup>
		    <tbody>
		    	<tr>
		        	<th scope="row">
		        		<select name="searchGubun" id="searchGubun" title="검색구분 선택">
		        			<option value="" <c:if test="'' == R_MAP.param.searchGubun}">selected="selected"</c:if>>전체</option>
		        			<option value="REG_NM">작성자</option>
		        			<option value="DATA_TITLE">제목</option>
		        			<option value="DATA_DESC">내용</option>
		        			<option value="REG_HP_NO">휴대번호</option>
		        			<option value="REG_EMAIL">이메일</option>
		        			<option value="REG_SOSOK">소속</option>
		        		</select>
		        	</th>
		        	<td colspan="3">
						<input type="text" name="searchValue" id="searchValue" value="<c:out value="${R_MAP.param.searchValue}"/>" title="검색어 입력" onKeyDown="srchCheck(event);" onKeyUp="sechnotin();" />
                        <input type="text" name="submitguard" id="submitguard" style="display:none;" />
		        	</td>
		        	<td style="text-align:right;" colspan="2">
		        		<span class="btn_pack large vM" id="btn_search"><a href="#"  onclick="return false;">검색</a></span>
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
		<table id='jqGrid' fixwidth="N"></table>
	</div>
	
	
</div>
</form>

<!-- 내용조회 창  -->
<div id="create_form_popup1" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9000;width:1000px;display:none;">
	<h1 id="contents_view_title1"><span >&#8226;</span> 제안 상세 조회</h1><span class="close" id="btn_create_form_popup1_close_icon" onclick="create_form_close1()"><a href="#" onclick="return false;" ></a></span>
	<form name="create_formfm1" id="create_formfm1" method="post" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
		<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
		<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
		<input type="hidden" name="adm_rpcode" id="adm_rpcode" value="<%=adm_rpcode%>" title="현재참조메뉴코드"  />	
		<input type="hidden" name="seldata_seqno" id="seldata_seqno" value="" title="선택된 번호"  />
		<div id="contents_view_area" style="width:100%;overflow:auto;">
			<span style="font-weight:600;margin-top:10px;">&#8226; 제안상세내용</span> 
	        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
	        	<caption>제안상세내용-작성자,제목,휴대번호,이메일,소속,내용,첨부파일,담당자,승인일시</caption>
	            <colgroup>
	                <col width="12%">
	                <col width="35%">
	                <col width="15%">
	                <col width="*">
	            </colgroup>
	            <thead>
	                <tr>
	                    <th scope="row" ><label for="REG_NM">작성자</label></th>
	                    <td colspan="3" id="REG_NM"></td>
	                </tr>
	                
	                <tr>
	                    <th scope="row" ><label for="DATA_TITLE">제목</label></th>
	                    <td colspan="3" id="DATA_TITLE">                              
	                    </td>
	                </tr>
                      
	                <tr>
	                    <th scope="row" ><label for="REG_HP_NO">휴대번호</label></th>
	                    <td colspan="3" id="REG_HP_NO"></td>
	                </tr>  
	                
	                <tr>
	                    <th scope="row" ><label for="REG_EMAIL">이메일</label></th>
	                    <td colspan="3" id="REG_EMAIL"></td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" ><label for="REG_SOSOK">소속</label></th>
	                    <td colspan="3" id="REG_SOSOK"></td>
	                </tr> 
	                
	                <tr>
	                    <th scope="row" ><label for="DATA_DESC">내용</label></th>
	                    <td colspan="3" id="DATA_DESC"></td>
	                </tr>                                        
	                                                                                                                                           
	                <tr>
	                    <th scope="row" ><label for="DATA_ATTACH">첨부파일</label></th>
	                    <td colspan="3" id="DATA_ATTACH"><div id="cmfile1"></div></td>
	                </tr>
	                
	                <tr>
	                    <th scope="row" ><label for="APR_ID_NM">담당자</label></th>
	                    <td colspan="3" ><input type="text" style="width:30%;" id="APR_ID_NM" name="APR_ID_NM" value="" maxlength="30" title="담당자" readonly="readonly" />
	                    <span class="btn_pack large" id="btn_apr_seladd"><a href="#" onclick="return false;">선택</a></span>
	                    <input type="hidden" style="width:30%;" id="APR_ID" name="APR_ID" value="" maxlength="30" title="담당자" />
	                    </td>
	                </tr>	                	
	                
	                <tr style="display:none;">
	                    <th scope="row" ><label for="APR_DT">승인 일시</label></th>
	                    <td colspan="3" id="APR_DT">	</td>
	                </tr>                							                                                                                                                                                                            
	            </thead>
	
	         </table>
	         
         	                  
        </div>
		<div class="section aC mT5 mB5">
			<span class="btn_pack large" id="btn_create_form_save1"><a href="#" onclick="create_form_save1();return false;">저장</a></span>
			<span class="btn_pack large" id="btn_create_form_close1"><a href="#" onclick="create_form_close1();return false;">닫기</a></span>
		</div>                    

	</form>
</div>
<!-- 내용조회 창  -->

<script type="text/javascript">

var searchYn = false;

// TODO : $(function()
		$(function(){
					
			var cols =[{label:'번호'				,name:'rnum'					,index:'rnum'					,align:'center'		,width:'100'	,hidden:false		,sortable:false	}
						,{label:'제목'			,name:'data_title'				,index:'data_title'				,align:'left'		,width:'200'	,hidden:false		,sortable:false }
						,{label:'작성자'			,name:'reg_nm'					,index:'reg_nm'					,align:'center'		,width:'90'		,hidden:false		,sortable:false }
						,{label:'휴대번호'			,name:'reg_hp_no'				,index:'reg_hp_no'				,align:'center'		,width:'120'	,hidden:false		,sortable:false }
						,{label:'이메일'			,name:'reg_email'				,index:'reg_email'				,align:'center'		,width:'150'	,hidden:false		,sortable:false 	}						
				   		,{label:'소속'			,name:'reg_sosok'				,index:'reg_sosok'				,align:'left'		,width:'150'	,hidden:false		,sortable:false 	}
				   		,{label:'인증종류'			,name:'auth_type_nm'			,index:'auth_type_nm'			,align:'center'		,width:'100'	,hidden:false		,sortable:false 	}
				   		,{label:'등록일'			,name:'reg_dt'					,index:'reg_dt'					,align:'center'		,width:'110'	,hidden:false		,sortable:false 	}
				   		,{label:'담당자'			,name:'apr_id_nm'				,index:'apr_id_nm'				,align:'center'		,width:'90'		,hidden:false		,sortable:false 	}
				   		,{label:'승인일시'			,name:'apr_dt'					,index:'apr_dt'					,align:'center'		,width:'150'	,hidden:true		,sortable:false 	}
				   		
				   		
				   		,{label:'담당자'			,name:'apr_id'					,index:'apr_id'					,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'인증종류'			,name:'auth_type'				,index:'auth_type'				,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'제안게시판메뉴코드'	,name:'menu_cd'					,index:'menu_cd'				,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
				   		,{label:'key'			,name:'data_seqno'				,index:'data_seqno'				,align:'center'  	,width:'0'  	,hidden:true  		,sortable:false	}
			 
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
					create_form_view1(ret.data_seqno);
				}
			});
			
		    /*$("#jqGrid").jqGrid('setGroupHeaders',{
				useColSpanStyle: true,    // 셀병합 여부(Group 대상 제외)
		    	groupHeaders:[             // 명명한 컬럼으로 부터 n개까지 병합(Group 대상)
		    					
								 {startColumnName: 'provd_charger_nm', numberOfColumns: 3, titleText: '가공'}
								,{startColumnName: 'non_idntfc_sttus_cd_nm', numberOfColumns: 4, titleText: '비식별'}
								
						]
			});	*/		
			

		
			
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
		
		//사용자 선택(레이어 팝업)
		$("#btn_apr_seladd").click(function(e){	
			//multi_yn, check_yn,returnId,sorg_cd
			btn_sawon_search2_cm_oam_<%=pcode %>('N', 'Y','','');
		});			

		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
			 ,updatemode	: "R"
		});		
		
		refreshGrid(false);
		CmcloseLoading();
		
	}).ajaxStart(function() {
		//CmopenLoading();
	}).ajaxStop(function() {
		//CmcloseLoading();
	});
	
	var refreshGrid = function(){
		CmopenLoading();
		$('#jqGrid').jqGrid('clearGridData', true);
		CmopenLoading();
		$('#data_seqno').val("");
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
					if(data.proposalDtl!=""){ 
						
						ConListToHtml(data);
					}else{
						alert("제안 상세 정보를 조회하는데 실패했습니다.");
						create_form_close1();
					}
					
	           }else{
		        	alert(data.TRS_MSG);
		        	
		        	
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
		var rows = res_data.proposalDtl;
		var di = 0;
		
		///////////////////////////////////////////////////////////////////////////////////////   	
		$("form[name=create_formfm1]").find("#REG_NM").html(rows.reg_nm);		
		$("form[name=create_formfm1]").find("#DATA_TITLE").html(rows.data_title);
		$("form[name=create_formfm1]").find("#REG_HP_NO").html(rows.reg_hp_no);
		$("form[name=create_formfm1]").find("#REG_EMAIL").html(rows.reg_email);
		$("form[name=create_formfm1]").find("#REG_SOSOK").html(rows.reg_sosok);
		$("form[name=create_formfm1]").find("#DATA_DESC").html(rows.data_desc.replace(/\n/gi,"<br />"));
		$("form[name=create_formfm1]").find("#APR_ID_NM").val(htmlTextAreaGridBr(rows.apr_id_nm));
		$("form[name=create_formfm1]").find("#APR_ID").val(htmlTextAreaGridBr(rows.apr_id));
		$("form[name=create_formfm1]").find("#APR_DT").html(nullToDefault(rows.apr_dt, ""));                                                                                                           

 
		///////////////////////////////////////////////////////////////////////////////////////  	

		var fileList1_seq = rows.file1_seq;
		var fileList1_nm = rows.file1_nms;
		fileList1_seq = fileList1_seq.replace(/::/gi,",");
		fileList1_nm = fileList1_nm.replace(/::/gi,",");
		
		var file_group1 = getFileHtmlArray(fileList1_seq, fileList1_nm);
		$.fn.cmfile.setfileList("cmfile1", file_group1);			
		/////////////////////////////////////////////////////////////////////////////////////// 

	};	
	
	//TODO : create_form_close1 
	// 닫기
	function create_form_close1(){
		$("#create_form_popup1").hide();
		create_form_init1();
		CmclospageDisable();
	}

	function create_form_init1(){
		$("form[name=create_formfm1]").find("#REG_NM").html("");		
		$("form[name=create_formfm1]").find("#DATA_TITLE").html("");
		$("form[name=create_formfm1]").find("#REG_HP_NO").html("");
		$("form[name=create_formfm1]").find("#REG_EMAIL").html("");
		$("form[name=create_formfm1]").find("#REG_SOSOK").html("");
		$("form[name=create_formfm1]").find("#DATA_DESC").html("");

		$("form[name=create_formfm1]").find("#APR_ID_NM").val("");
		$("form[name=create_formfm1]").find("#APR_ID").val("");
		$("form[name=create_formfm1]").find("#APR_DT").html(""); 
		
		$("#cmfile1").html("");
		var file = $.fn.cmfile.init({
			 id				: 'cmfile1' 
			 ,onClickNamefn	: "fileNameClick1"
			 ,img_url 		: "<%=img_url%>"
			 ,uploadcnt		: <%=uploadcnt%>
			 ,extchk		: ['GIF','JPG','BMP','PNG','TIF']
			 ,updatemode	: "R"
		});
		
	}	

	//TODO : create_form_view1 
	// 창 오픈
	function create_form_view1(seldata_seqno){
		CmopenpageDisable();
		
	    $("#create_form_popup1").draggable({ opacity:"0.3",handle:"#contents_view_title1" }); // 끄는 동안만 불투명도 주기

	    $("body").droppable({

	        accept: "#create_form_popup2",    // 드롭시킬 대상 요소

	        drop: function(event, ui) {

	        	$("#create_form_popup2").css({ opacity:"1.0" });

	        }

	    });
	    
		$("form[name=create_formfm1]").find("#seldata_seqno").val(seldata_seqno);
		
		$("#contents_view_title1").html("<span >&#8226; </span>"+" 제안 상세 조회");
		
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_popup1").css("left",( (($(document).width() - 1000) / 3) + $(document).scrollLeft()  )+"px");
		$("#create_form_popup1").css("top", ( (($(document).height() - 580) / 2) + $(document).scrollTop() - (($(document).height() - 540) / 5)  )+"px");	

		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);
		$("#contents_view_area").height(500);

		$("#create_form_popup1").show(500);

		refresh1();
	}	
	
	//TODO : setOrgSawonAdd
	//조직사원 검색팝업 리턴값 셋팅
	function setOrgSawonAdd_cm_oam_<%=pcode%>(rtnArr){
		//rtnArr[0]//직원아이디
		//rtnArr[1]//직원명
		//rtnArr[2]//최상위조직명
		//rtnArr[3]//조직명
		//rtnArr[4]//조직코드
		//rtnArr[5]//returnId
		//rtnArr[6]//조직유형코드
		//rtnArr[7]//조직유형명
		//rtnArr[8]//상위조직코드
		//rtnArr[9]//최상위 조직코드
		var ri =0;
		var rj =0;
		//var set_str1="";
		//var set_str2="";
		//console.log(rtnArr[0]);
		for(ri=0;ri<rtnArr[0].length;ri++){
			
			$("form[name=create_formfm1]").find("#APR_ID_NM").val(rtnArr[1]);
			$("form[name=create_formfm1]").find("#APR_ID").val(rtnArr[0]);

		}	
		CmopenpageDisable();
	}	
	
	function create_form_save1(){
		if($("form[name=create_formfm1]").find("#APR_ID_NM").val()==""
			|| isEmpty($("form[name=create_formfm1]").find("#APR_ID").val()) ){
			alert('담당자를 선택해 주세요');
			$("form[name=create_formfm1]").find("#APR_ID_NM").focus();
			return;
		}	
			
		$("form[name=create_formfm1]").find("#pstate").val("U");
		var params = jQuery("form[name=create_formfm1]").serialize();
		CmLoadingChg_Zindex(9999);
		
	  //alert(params);
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
		        	CmLoadingChg_Zindex(8000);             
	       },

	       success: function(data){
	         if(data.result==true){
	      	   	alert('저장 되었습니다.');
		            CmLoadingChg_Zindex(8000);
		            refreshGrid(false);
					create_form_close1();
	         
	         }else{
		        	alert(data.TRS_MSG);
		        	CmLoadingChg_Zindex(8000);
		        	
	         }
	       }

		});		
		
	}
	
	// 내용조회팝업 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

	
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
	
	function srchCheck(){
		if(event.keyCode==13){
			$("#btn_search").trigger("click");
		}
	}

	//#####문자체크
	function char_chk(str,chk){
		for(i = 0; i < str.length; i++){
			c = str.charAt(i);
			if(c == chk){
				return false;
			}
		}
	}
	
//////////////////////////////사원선택 팝업창 ///////////////////////////////
	<%@include file="/WEB-INF/jsp/ji/cm/oam/jicm_oam_010_i2.jsp"%>
//////////////////////////////사원선택 팝업창 ///////////////////////////////	
</script>