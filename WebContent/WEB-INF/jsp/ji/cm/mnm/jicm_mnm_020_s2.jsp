<%--
/*=================================================================================*/
/* 시스템            : 공통/ Web Proxy관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/mnm/jicm_mnm_020_s2.jsp 
/* 프로그램 이름     : jicm_mnm_020_s2    
/* 소스파일 이름     : jicm_mnm_020_s2.jsp
/* 설명              : Web Proxy관리
/* 버전              : 1.0.0
/* 최초 작성자       : cys
/* 최초 작성일자     : 2018-11-19
/* 최근 수정자       : 
/* 최근 수정일시     : 
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<style>

	.ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column { white-space: normal; }
	.ui-jqgrid-htable th{ text-align: center; }
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr {border-left : 1px solid; border-left-color: #dcdcdc; }
	.ui-th-rtl, .ui-jqgrid .ui-jqgrid-htable th.ui-th-rtl {border-right : 1px solid; border-right-color: #dcdcdc; }	
	.ui-jqgrid .ui-jqgrid-htable th div{height : auto; padding: 5px; }	
</style>
		<div >
			<!-- tab -->
			<ul class="tab_menu">
				<li><a href="#" onclick="chgTab(0);return false;" id="tab_link0">링크Alive관리</a></li>
				<li class="selected"><a href="#" onclick="chgTab(1);return false;" id="tab_link1">Web Proxy관리</a></li>
			</ul>
			<!-- tab //-->	
		</div>
		
<form name="listfrm" id="listfrm" method="post" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="gridId" id="gridId" value="" />
	<input type="hidden" name="JSONDataList" id="JSONDataList" value="" />
	
<div class="searchArea" style="margin-top:10px;">
  <table class="tbl_search">
    <colgroup>
	    <col width="100" />
	    <col width="150" />
	    <col width="100" />
	    <col width="150" />
	    <col width="100" />
	    <col width="*" />
    </colgroup>
	<tr>
		<th scope="row">대상시스템</th>
		<td colspan="3">
	        <input type="text" name="stext" id="stext" title="검색어 입력"/>
		</td>



	  	<td colspan="2">
       		<p class="fR mL10">	
				    <span class="btn_pack large"><a href="#none" id="btn_search">검색</a></span>
				    <span class="btn_pack largeO vM"><a href="#none" id="btn_save">저장</a></span>
	      	</p>
		</td>  	     	  
    </tr>
  </table>
</div>

<!-- end of search -->
<div class="section mT10">
	<h3 class="fL"><span>&#8226;</span>Web Proxy 리스트</h3>
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



<script type="text/javascript">
//<![CDATA[
var searchYn = false;

$(function(){
	//Web Proxy 리스트
		var cols =[ {label:'번호'          					,index:'row_seq'     			,name:'row_seq'         	,align:'center' ,width : '60',  hidden:false, sortable : true }
					,{label:'상태' 							,index:'row_status'    			,name:'row_status'     		,align:'center' ,width : '60', hidden:true, sortable : true ,formatter : fm_row_status}
					,{label:'접속 구분' 					,index:'conn_type'    			,name:'conn_type'     		,align:'center' ,width : '100', hidden:false, sortable : true ,formatter : fm_conn_type}
					,{label:'대상시스템 명' 				,index:'tg_sys_nm' 				,name:'tg_sys_nm' 			,align:'center' ,width : '180', hidden:false, sortable : true ,formatter : fm_tg_sys_nm }
					,{label:'접속 WEB<br />서버주소' 			,index:'web_proxy_addr' 		,name:'web_proxy_addr' 		,align:'center' ,width : '110', hidden:false, sortable : true ,formatter : fm_web_proxy_addr}
					,{label:'접속 WEB<br />서버포트' 			,index:'web_proxy_port'   		,name:'web_proxy_port'    	,align:'center' ,width : '110', hidden:false,  sortable : true ,formatter : fm_web_proxy_port}
				    ,{label:'접속 대상시스템<br /> 실재주소'	,index:'web_proxy_rl_addr'    	,name:'web_proxy_rl_addr'  	,align:'center' ,width : '110', hidden:false, sortable : true ,formatter : fm_web_proxy_rl_addr}
				    ,{label:'접속 대상시스템<br /> 실재포트'	,index:'web_proxy_rl_port'    	,name:'web_proxy_rl_port' 	,align:'center' ,width : '110', hidden:false, sortable : true ,formatter : fm_web_proxy_rl_port}
				    ,{label:'접속 대상시스템<br /> 실재도메인'	,index:'web_proxy_rl_domain'   	,name:'web_proxy_rl_domain' ,align:'center' ,width : '160', hidden:false, sortable : true ,formatter : fm_web_proxy_rl_domain}
				    ,{label:'비고'		 					,index:'web_proxy_desc'  		,name:'web_proxy_desc'   	,align:'center' ,width : '200', hidden:false, sortable : true ,formatter : fm_web_proxy_desc}
				    ,{label:'등록자ID'	 					,index:'reg_id'   				,name:'reg_id'    			,align:'center' ,width : '100', hidden:false, sortable : true }
				    ,{label:'등록일자'						,index:'reg_dt'      			,name:'reg_dt'      		,align:'center' ,width : '100', hidden:false, sortable : true }
				    ,{label:'등록자'	 					,index:'reg_nm'   				,name:'reg_nm'    			,align:'center' ,width : '1', 	hidden:true,  sortable : true }
				    ,{label:'key'	     					,index:'web_proxy_seqno' 		,name:'web_proxy_seqno'  	,align:'center' ,width : '1',   hidden:true }
			    ]
			
			
	//init grid
		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: 452
			,autowidth  : true
			,rowList	: 1000
			,rowNum		: 200
			,shrinkToFit : true
			,multiselect: true
			,scroll 	: 1
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
			//var chcell = $("#jqGrid").jqGrid("getChangedCells","all");
			//console.log("chcell==>"+chcell);
			//return;
			var	field = ["row_seq","row_status","conn_type","tg_sys_nm","web_proxy_addr","web_proxy_port","web_proxy_rl_addr","web_proxy_rl_port","web_proxy_rl_domain","web_proxy_desc","web_proxy_seqno"]; //grid 내 element id
			
			   $("#pstate").val("C2");
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
				//jQuery("#jqGrid").closest(".ui-jqgrid-bdiv").scrollTop(22*addCnt);
				//var gr_row = jQuery("#jqGrid").jqGrid('getGridParam','selrow');
				//var gr_row = jQuery("#jqGrid").jqGrid('getRowData',addCnt);
				//console.log(gr_row);
				//jQuery("#jqGrid").jqGrid("setSelection",addCnt);
				$("#jqGrid").find("#"+addCnt).focus();
			
		});	 
		
		//그리드 삭제
		$("#btn_grid_remove").click(function(e){
			var ids = jQuery("#jqGrid").jqGrid('getGridParam', 'selarrrow');
			var delkey_col = "";
			var org_delkey = "";
			var delkey_val = "";
			var delkey_col_row = "";
			delkey_col="web_proxy_seqno";
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
	
	
	/* 출력 클릭*/
	$("#listfrm").find("#printBtn").click( function() {		
		$("#pstate").val("X2");
		
		//엑셀로 저장[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
		excelDownload3("jqGrid","","WebProxy 화면 리스트");
		
		$("#pstate").val("L2");			

	});
	
	$("#listfrm").find("#printBtnAll").click( function() {			
		
		$("#pstate").val("X2");
		
		//엑셀로 저장[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
		excelDownload3("jqGrid","A","WebProxy 전체 리스트");
		
		$("#pstate").val("L2");	

	});		
	
	refreshGrid(); //조회
	
});



//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	$("form[name=listfrm]").find("#delkey").val("");
	$("form[name=listfrm]").find("#gridId").val("");
	$("form[name=listfrm]").find("#JSONDataList").val("");
	
	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','<%=con_root%>/cmsajax.do',params);
	setTimeout(CmcloseLoading,1000);
}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X2';

	return _params;
}

// row 상태값
function fm_row_status(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = ""+cellvalue+"";
	}else{
		url = "R";
	}
	
    return url;
}


// 접속구분
function fm_conn_type(cellvalue, options, rowObject) {
	var url ="";
	url = "<select name='conn_type' id='conn_type"+options.rowId+"' style='width:96%;' onchange='rowStatusChg(\""+options.rowId+"\")'><option value=''>-- 선택 --</option>"+"<%=(String)rtn_Map.get("stconn_type")%>"+"</selecd>";
	
	

	if(cellvalue!="" && cellvalue!=null){
		var selregE = "value=\'"+cellvalue+"\'";
		url = url.replace(selregE,"value=\'"+cellvalue+"\' selected ");
	}

    return url;
}

function rowStatusChg(rowid){
	var ret = $("#jqGrid").jqGrid("getRowData",rowid);
	$("#jqGrid").jqGrid("setCell",rowid,"row_status","U");
}


//대상시스템명
function fm_tg_sys_nm(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="tg_sys_nm'+options.rowId+'" style="width:96%;" name="tg_sys_nm" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="tg_sys_nm'+options.rowId+'" style="width:96%;" name="tg_sys_nm" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
    return url;
}

// 접속 WEB서버주소
function fm_web_proxy_addr(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_addr'+options.rowId+'" style="width:96%;" name="web_proxy_addr" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_addr'+options.rowId+'" style="width:96%;" name="web_proxy_addr" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
    return url;
}

//접속 WEB서버포트
function fm_web_proxy_port(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_port'+options.rowId+'" style="width:96%;" name="web_proxy_port" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_port'+options.rowId+'" style="width:96%;" name="web_proxy_port" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
    return url;
}

//접속 대상시스템 실재주소
function fm_web_proxy_rl_addr(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_rl_addr'+options.rowId+'" style="width:96%;" name="web_proxy_rl_addr" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_rl_addr'+options.rowId+'" style="width:96%;" name="web_proxy_rl_addr" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
    return url;
}

//접속 대상시스템 실재포트
function fm_web_proxy_rl_port(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_rl_port'+options.rowId+'" style="width:95%;" name="web_proxy_rl_port" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_rl_port'+options.rowId+'" style="width:95%;" name="web_proxy_rl_port"  onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
    return url;
}

//접속 대상시스템 실재도메인
function fm_web_proxy_rl_domain(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_rl_domain'+options.rowId+'" style="width:96%;" name="web_proxy_rl_domain" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_rl_domain'+options.rowId+'" style="width:96%;" name="web_proxy_rl_domain" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\')"></a></span></div>';
    return url;
}

//비고
function fm_web_proxy_desc(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url = '<input type="text" id="web_proxy_desc'+options.rowId+'" style="width:96%;" name="web_proxy_desc" value="'+cellvalue+'" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}else{
		url = '<input type="text" id="web_proxy_desc'+options.rowId+'" style="width:96%;" name="web_proxy_desc" onkeyup=\"rowStatusChg(\''+options.rowId+'\')\"/>';
	}
	
	//url += '<span class="btnIc_search" id="btn_grid_menu_search" style="vertical-align:bottom;"><a href="#" onclick="btn_grid_menu_search(\''+options.rowId+'\');return false;"></a></span></div>';
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

//]]>
</script>
