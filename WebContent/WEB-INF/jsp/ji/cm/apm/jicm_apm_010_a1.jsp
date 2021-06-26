<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_010_a1.jsp 
/* 프로그램 이름     : jicm_apm_010_a1  
/* 소스파일 이름     : jicm_apm_010_a1.jsp
/* 설명              : 공통 결재업무 관리 리스트
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-27
/* 최근 수정자       : 최유성
/* 최근 수정일시     : 2018-03-14
/* 최종 수정내용     : 전력데이터제공포털에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
String sdlv_req_ymd = DateUtility.getaddmon(curDate,"-", 2);
String edlv_req_ymd = DateUtility.getaddmon(curDate,"+", 1);
%>
<script type="text/javascript">

$(function(){
	//결재업무 리스트
		var cols =[ {label:'번호'          		,index:'row_seq'     	,name:'row_seq'         ,align:'center' ,width : '70',  hidden:false, sortable : true }
					,{label:'결재업무명' 		,index:'aprv_job_nm'    ,name:'aprv_job_nm'     ,align:'center' ,width : '130', hidden:true, sortable : true ,formatter : fm_aprv_job_nm}
					,{label:'대상메뉴명' 		,index:'aprv_job_cl_nm' ,name:'aprv_job_cl_nm' 	,align:'center' ,width : '150', hidden:false, sortable : true ,formatter : fm_aprv_job_cl_nm }
					,{label:'대상메뉴코드' 	,index:'aprv_job_cl_cd' ,name:'aprv_job_cl_cd' 	,align:'center' ,width : '120', hidden:false, sortable : true ,formatter : fm_aprv_job_cl_cd}
					,{label:'메뉴상태코드' 	,index:'menu_stat_cd'   ,name:'menu_stat_cd'    ,align:'center' ,width : '130', hidden:true,  sortable : true ,formatter : fm_menu_stat_cd}
				    ,{label:'호출메뉴코드'		,index:'rtn_menu_cd'    ,name:'rtn_menu_cd'  	,align:'center' ,width : '120', hidden:true, sortable : true ,formatter : fm_rtn_menu_cd}
				    ,{label:'호출메뉴상태'		,index:'rtn_pstate'    	,name:'rtn_pstate' 		,align:'center' ,width : '130', hidden:false, sortable : true ,formatter : fm_rtn_pstate}
				    ,{label:'호출파라메터명'	,index:'rtn_param_nm'   ,name:'rtn_param_nm'    ,align:'center' ,width : '130', hidden:false, sortable : true ,formatter : fm_rtn_param_nm}
				    ,{label:'비고'		 		,index:'aprv_job_desc'  ,name:'aprv_job_desc'   ,align:'center' ,width : '500', hidden:false, sortable : true ,formatter : fm_aprv_job_desc}
				    ,{label:'등록자ID'	 		,index:'reg_id'   		,name:'reg_id'    		,align:'center' ,width : '130', hidden:false, sortable : true }
				    ,{label:'등록일자'			,index:'reg_dt'      	,name:'reg_dt'      	,align:'center' ,width : '130', hidden:false, sortable : true }
				    ,{label:'등록자'	 		,index:'reg_nm'   		,name:'reg_nm'    		,align:'center' ,width : '1', 	hidden:true,  sortable : true }
				    ,{label:'key'	     		,index:'aprv_job_seqno' ,name:'aprv_job_seqno'  ,align:'center' ,width : '1',   hidden:true }
			    ]
			
			
	//init grid
		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: 350
			,autowidth  : true
			,shrinkToFit : false
			,rowList	: [15,50,100]
			,rowNum		: 15
			,multiselect: true
			,gridComplete: function(){
				mergeCellcomplet($(this));
				//grid_win_resizeAutoHeight();
			}
			,onSelectRow: function(id) { // row를 선택했을때 액션.
				
				var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				var value1 = ret.aprv_job_seqno; // 이런식으로 값을 가져올 수 있다.
				
			}
			,custom : { //custom
				 cols : cols //컬럼정보 - 필수!
				,navButton : {
					excel : {
						exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
					}
				}
			}
		});
			
	    /* 그리드 크기를 조절할 수 있도록 한다. */
	    jQuery("#jqGrid").jqGrid('gridResize',{});
	    
		//저장
		$("#btn_save").click(function(e){
			
			var	field = ["row_seq","menu_cd","menu_nm","menu_stat_cd","aprv_job_cl_cd","aprv_job_cl_nm","aprv_job_desc","aprv_job_seqno","rtn_menu_cd","rtn_pstate","rtn_param_nm","aprv_job_seqno"]; //grid 내 element id
			
			   $("#pstate").val("C");
			   $("#JSONDataList").val(JSONDataList("jqGrid",field)); 
				
				var params = jQuery("#listfrm").serialize();
				
				CmopenLoading();
					 $.ajax({
			             type: "post",
			             url: "<%=con_root%>/cmsajax.do",
			             data: params,
			             async: false,
			             dataType:"json",
			             success: function(data){
			               if(data.result==true){
				                alert('저장 되었습니다.');
				                refreshGrid(false);
			               }else{
			            	   if(data.TRS_MSG==null){
			            		   alert("정의되지 않은 에러입니다.");
			            	   }else{
			            		   alert(data.TRS_MSG);
			            	   }
			               }
			               setTimeout(CmcloseLoading,1000);
			             }
			      });
		});		    
	    
	    
		// 현재 선택된 탭의 그리드 삽입 
		$("#btn_grid_add").click(function(e){
			var ids = jQuery("#jqGrid").jqGrid('getDataIDs');
			var addCnt  = 0;
			for(var i=0;i < ids.length;i++) {
				addCnt = ids[i];
				addCnt = addCnt.replace('jqg', '');
			}
	 		addCnt = parseInt(addCnt)+1;
			var targetData = "";
           
				targetData = { 
					row_seq 		: ''
  				}
				
			jQuery("#jqGrid").jqGrid('addRowData',addCnt,targetData);
			
		});	 
		
		//그리드 삭제
		$("#btn_grid_remove").click(function(e){
			var ids = jQuery("#jqGrid").jqGrid('getGridParam', 'selarrrow');
			var delkey_col = "";
			var org_delkey = "";
			var delkey_val = "";
			var delkey_col_row = "";
			delkey_col="aprv_job_seqno";
			    if(ids.length==0){
			    	alert('삭제할 항목을 선택하세요');
			    	return;
			    }
			    org_delkey = $("#delkey").val();
			  
			    for(i=0;i<ids.length;i++){
			    	delkey_val = $("#jqGrid").jqGrid('getCell', ids[i], delkey_col);
			    	delkey_col_row = $("#jqGrid").jqGrid('getCell', ids[i], 'row_seq');
			    	//console.log("delkey_col_row:=="+delkey_col_row+"::delkey_val:=="+delkey_val);
			    	if(delkey_col_row!="" && delkey_val!=""){
			    		org_delkey+= (org_delkey==""?"":",")+delkey_val;
			    	}
			    }
			    
			    for( var i=ids.length; i>0; i-- ){
			        $('#jqGrid').jqGrid('delRowData', ids[i-1]);
			    }
			    
			    $("#delkey").val(org_delkey);
		
		});	
	    
	
	$("#btn_search").click( function() {
		//openLoading();
		refreshGrid();
		//closeLoading();
	});
	
	//  메뉴선택팝업 호출
	$("#btn_menu_search").click( function() {
		popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000326&dto_FUN_FN=setMenuAdd&pstate=PF1&multi_yn=Y&check_yn=Y", "MenuWinPop", 500, 680);
	});	

	
	/* 출력 클릭*/
	$("#listfrm").find("#printBtn").click( function() {			
		excelDownload("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트", "<c:url value='/cmsmain.do'/>");
	});
	
	$("#listfrm").find("#printBtnAll").click( function() {			
		
		//엑셀로 저장[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
		excelDownload("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트", "<c:url value='/cmsmain.do'/>");

	});		
	
	refreshGrid(); //조회
	
});



//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	
	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','<%=con_root%>/cmsajax.do',params);
	setTimeout(CmcloseLoading,1000);
}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X';
	return _params;
}

//메뉴 검색팝업 리턴값 셋팅
function setMenuAdd(rtnArr){
	$("#s_menu_cd").val(rtnArr[0].join(','));		//코드
	$("#s_menu_nm").val(rtnArr[1].join(','));		//코드명
}

//메뉴검색
function btn_grid_menu_search(rowId) {
	$("#gridId").val(rowId);
	popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000326&dto_FUN_FN=setGridMenuAdd&pstate=PF1&multi_yn=N&check_yn=Y", "MenuWinPop", 500, 680);
}

//메뉴 검색팝업 리턴값 셋팅
function setGridMenuAdd(rtnArr){

	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'menu_cd',rtnArr[0].join(','));// 자재코드
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'menu_nm',rtnArr[1].join(','));// 자재명

}



//메뉴코드
function fm_aprv_job_cl_cd(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="aprv_job_cl_cd'+options.rowId+'" style="width:85%;" name="aprv_job_cl_cd" value="'+cellvalue+'"/>';
	}else{
		url = '<input type="text" id="aprv_job_cl_cd'+options.rowId+'" style="width:85%;" name="aprv_job_cl_cd" />';
	}
	
    return url;
}

// 메뉴명
function fm_aprv_job_cl_nm(cellvalue, options, rowObject) {
	var url ='';
	url = '<div class="iDate vT">';
	if(cellvalue!=undefined && cellvalue!=""){
		url += '<input type="text" id="aprv_job_cl_nm'+options.rowId+'"  name="aprv_job_cl_nm" class="fL" maxlength="200" style="width:90%;" value="'+cellvalue+'"/>';
	}else{
		url += '<input type="text" id="aprv_job_cl_nm'+options.rowId+'"  name="aprv_job_cl_nm" class="fL" maxlength="200" style="width:90%;" />';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
    return url;
}

//메뉴검색
function btn_grid_menu_search2(rowId) {
	$("#gridId").val(rowId);
	popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000326&dto_FUN_FN=setGridMenuAdd2&pstate=PF1&multi_yn=N&check_yn=Y", "MenuWinPop", 500, 680);
}

//메뉴 검색팝업 리턴값 셋팅
function setGridMenuAdd2(rtnArr){

	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'rtn_menu_cd',rtnArr[0].join(','));// 자재코드
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'rtn_menu_cd_nm',rtnArr[1].join(','));// 자재명

}

 //호출메뉴코드
function fm_rtn_menu_cd(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="rtn_menu_cd'+options.rowId+'" style="width:95%;" name="rtn_menu_cd"  value="'+cellvalue+'"/>';
	}else{
		url = '<input type="text" id="rtn_menu_cd'+options.rowId+'" style="width:95%;" name="rtn_menu_cd"  />';
	}
	
    return url;
}

//호출메뉴상태코드
function fm_rtn_pstate(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<input type='text' name='rtn_pstate' id='rtn_pstate"+options.rowId+"' maxlength='10' class='fL' style='width:95%;' value='"+cellvalue+"' />";
	}else{
		url = "<input type='text' name='rtn_pstate' id='rtn_pstate"+options.rowId+"' maxlength='10' class='fL' style='width:95%;' />";
	}
	
    return url;
}

//호출메뉴파라메터
function fm_rtn_param_nm(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<input type='text' name='rtn_param_nm' id='rtn_param_nm"+options.rowId+"' maxlength='20' class='fL' style='width:95%;' value='"+cellvalue+"' />";
	}else{
		url = "<input type='text' name='rtn_param_nm' id='rtn_param_nm"+options.rowId+"' maxlength='20' class='fL' style='width:95%;' />";
	}
	
    return url;
} 

//메뉴상태코드
function fm_menu_stat_cd(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<input type='text' name='menu_stat_cd' id='menu_stat_cd"+options.rowId+"' maxlength='5' class='fL' style='width:95%;' value='"+cellvalue+"' />";
	}else{
		url = "<input type='text' name='menu_stat_cd' id='menu_stat_cd"+options.rowId+"' maxlength='5' class='fL' style='width:95%;' />";
	}
	
    return url;
}


// 결재업무명
function fm_aprv_job_nm(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<input type='text' name='aprv_job_nm' id='aprv_job_nm"+options.rowId+"' maxlength='200' class='fL' style='width:95%;' value='"+cellvalue+"' />";
	}else{
		url = "<input type='text' name='aprv_job_nm' id='aprv_job_nm"+options.rowId+"' maxlength='200' class='fL' style='width:95%;' />";
	}
	
    return url;
}

//비고
function fm_aprv_job_desc(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<input type='text' name='aprv_job_desc' id='aprv_job_desc"+options.rowId+"' maxlength='4000' class='fL' style='width:95%;' value='"+cellvalue+"' />";
	}else{
		url = "<input type='text' name='aprv_job_desc' id='aprv_job_desc"+options.rowId+"' maxlength='4000' class='fL' style='width:95%;' />";
	}
	
    return url;
}

//Grid 데이터 json 데이터로 반환
function JSONDataList(jqGrid,field) {
	var colModel = $("#"+jqGrid).jqGrid('getGridParam','colModel');
	var arrObj = new Array();
	var ids = jQuery("#"+jqGrid).jqGrid('getDataIDs');
	var _value ="";
	var _type ="";
    for ( var i=0; i<ids.length; i++ ) {
        var vo = new Object();  
        for(var j=0;j<field.length;j++){

        	if($("#"+field[j]+ids[i]).val()!=undefined){
        		_value = $("#"+field[j]+ids[i]).val();
        		_type  = $("#"+field[j]+ids[i]).attr("type");
        	}else{
        		_value = $("#"+jqGrid).jqGrid('getCell', ids[i], field[j]);
        		_type  = "string";
        	}
        	
    		if(_type=="radio"){
    			if($("#"+jqGrid+" input:radio[id="+field[j-1]+[i+1]+"]").is(":checked")){
    				_value = "Y"
    					eval("vo."+field[j]+"='"+_value+"';");
    			}else{
    				_value = "N"
    					eval("vo."+field[j]+"='"+_value+"';");
    			}
    		}else{
	    		if(_value==undefined){
	    			eval("vo."+field[j]+"='';");	
	    		}else{
	    			eval("vo."+field[j]+"='"+_value+"';");
	    		} 
    		}        	
        	
        }
        arrObj.push(vo);   
    }
    return JSON.stringify(arrObj);
}
/////////////////////////////////////////////////////////////////////////////////////////////////
// 그리드 높이 동적변환
$(window).resize(function(){
	//setTimeout(grid_win_resizeAutoHeight, 200);
	
});

function grid_win_resizeAutoHeight(){
	var grid_list=$("TABLE[id^=jqGrid]");
	var grid_div_ht = 0;
	var grid_ht = 0;
	var grid_htgap = 0;
	var grid_top = 0;
	
	grid_list.each(function(){
		if($(this).get(0).tagName=="TABLE"){
			grid_ht = $("#"+$(this).attr("id")).height();
			grid_top = $("#"+$(this).attr("id")).offset().top;
			grid_div_ht = $("body").height();
			//console.log("grid_htgap==="+grid_htgap);
			if($("#"+$(this).attr("id")).attr("landcnt")!=undefined){
				if($("#"+$(this).attr("id")).attr("landcnt")>1){
					//console.log("landcnt==="+$("#"+$(this).attr("id")).attr("landcnt"));
					if($("#"+$(this).attr("id")).attr("minusht")!=undefined){
						if($("#"+$(this).attr("id")).attr("minusht")>0){
							grid_htgap = (grid_div_ht-parseInt($("#"+$(this).attr("id")).attr("minusht")))/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
						}else{
							grid_htgap = grid_div_ht/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
						}
					}else{
						grid_htgap = grid_div_ht/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
					}
					
				}else{
					if($("#"+$(this).attr("id")).attr("minusht")!=undefined){
						if($("#"+$(this).attr("id")).attr("minusht")>0){					
							grid_htgap = $("#"+$(this).attr("id")).height()+((grid_div_ht-parseInt($("#"+$(this).attr("id")).attr("minusht")))-grid_ht);
						}else{
							grid_htgap = $("#"+$(this).attr("id")).height()+(grid_div_ht-grid_ht);
						}
					}else{
						grid_htgap = $("#"+$(this).attr("id")).height()+(grid_div_ht-grid_ht);
					}
				}
				
			}else{
				if($("#"+$(this).attr("id")).attr("minusht")!=undefined){
					if($("#"+$(this).attr("id")).attr("minusht")>0){					
						grid_htgap = $("#"+$(this).attr("id")).height()+((grid_div_ht-parseInt($("#"+$(this).attr("id")).attr("minusht")))-grid_ht);
					}else{
						grid_htgap = $("#"+$(this).attr("id")).height()+(grid_div_ht-grid_ht);
					}
				}else{
					grid_htgap = $("#"+$(this).attr("id")).height()+(grid_div_ht-grid_ht);
				}				

			}
			//console.log("grid_htgap==="+grid_htgap+"::"+(grid_htgap-grid_top-64));
			
			jQuery("#"+$(this).attr("id")).jqGrid("setGridHeight",(grid_htgap-grid_top-64));
		}
	});
	
}
//그리드 높이 동적변환
/////////////////////////////////////////////////////////////////////////////////////////////////

</script>

<form name="listfrm" id="listfrm" method="post" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="saprv_job_seqno" id="saprv_job_seqno" value="" />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="gridId" id="gridId" value="" />
	<input type="hidden" name="JSONDataList" id="JSONDataList" value="" />
	
<div class="searchArea">
  <table class="tbl_search">
    <colgroup>
	    <col width="40" />
	    <col width="*" />
	    <col width="40" />
	    <col width="*" />
	    <col width="10" />
	    <col width="*" />
    </colgroup>
	<tr>
		<th scope="row">결재업무명</th>
		<td colspan="3">
	        <input type="text" name="stext" id="stext" title="검색어 입력"/>
		</td>
<!-- 		<th scope="row">결재메뉴</th>
		<td>
	    	<select id="s_menu_cd" name="s_menu_cd" style="width:120px;" >
	    		<option value="">-- 선택 --</option>
		          	<option value="000479">운용상품공고</option>
		          	<option value="000555">입찰제안심사</option>	
	        </select>
		</td> -->
		<th scope="row">삭제여부</th>
		<td>
			<input type="checkbox" name="cod_yn" id="cod_yn" value="Y" />
			삭제포함	
		</td>
	  	<td colspan="2">
       		<p class="fR">	
				<!-- 결재 업무관리는 관리자 페이지에만 있어야한다 만일 일반 사용자 페이지로 이동되게 되면 문제 발생함-->
				    <span class="btn_pack large"><a href="#none" id="btn_search">검색</a></span>
				<%if(SS_admin.equals("Y")){ %>
				    <span class="btn_pack largeO vM"><a href="#none" id="btn_save">저장</a></span>
				<%}else{ %>
					<%if(SS_authC.equals("Y")){ %>
					<span class="btn_pack largeO vM"><a href="#none" id="btn_save">저장</a></span>
					<%}%>
				<%}%>
	      	</p>
		</td>  	     	  
    </tr>
  </table>
</div>

<!-- end of search -->
<div class="section mT10">
	<h3 class="fL"><span>&#8226;</span>결재업무 리스트</h3>
	<p class="fR">
	    <span class="btn_pack medium icon" id="btn_printAll" ><span class="excel"></span><a href="#" id="printBtnAll" >엑셀로 저장</a></span>
		<span class="btn_pack medium icon" id="btn_grid_add_sp"><span class="add"></span><a href="#" id="btn_grid_add">추가</a></span>
		<span class="btn_pack medium icon" id="btn_grid_remove_sp"><span class="delete"></span><a href="#" id="btn_grid_remove">삭제</a></span>
	</p>
</div>
<div class="section">
	<table id='jqGrid' fixwidth="N"></table>
</div>

</form>


