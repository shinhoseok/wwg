<%--
/*=================================================================================*/
/* 시스템            : 결재
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_030_p2
/* 프로그램 이름     : jicm_apm_030_p2    
/* 소스파일 이름     : jicm_apm_030_p2.jsp
/* 설명              : 결재선 지정 팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-06-08
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-27
/* 최종 수정내용     : 전력데이터제공 포털시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.net.URLDecoder" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>

<%

	String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
	String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
	String aprv_pcode = HtmlTag.returnString((String)request.getAttribute("aprv_pcode"),"");	// 결재업무 일련번호
	String aprv_key = HtmlTag.returnString((String)request.getAttribute("aprv_key"),""); // 결재 업무키
	String aprv_job_cl_cd = HtmlTag.returnString((String)request.getAttribute("aprv_job_cl_cd"),""); // 결재 업무키
	String dto_FUN_FN = HtmlTag.returnString((String)request.getAttribute("dto_FUN_FN"),""); // 부모창 리턴받을 함수
	
	String iaprv_req_nm = HtmlTag.returnString((String)request.getAttribute("iaprv_req_nm"),""); // 부모창 리턴받을 함수
	String iappr_stat_desc = HtmlTag.returnString((String)request.getAttribute("iappr_stat_desc"),""); // 부모창 리턴받을 함수
	String iaprv_recv_org_nm = HtmlTag.returnString((String)request.getAttribute("iaprv_recv_org_nm"),""); // 부모창 리턴받을 함수
	String iaprv_recv_emp_id = HtmlTag.returnString((String)request.getAttribute("iaprv_recv_emp_id"),""); // 부모창 리턴받을 함수
	String iaprv_recv_emp_nm = HtmlTag.returnString((String)request.getAttribute("iaprv_recv_emp_nm"),""); // 부모창 리턴받을 함수
	String aprv_to_title = HtmlTag.returnString((String)request.getAttribute("aprv_to_title"),""); // 업무타이틀
	aprv_to_title = URLDecoder.decode(aprv_to_title, "UTF-8");
	
	List aprv_line_json = (List)rtn_Map.get("aprv_line_json");
	Map aprv_line_json_map = new HashMap();
	int i = 0;

%>
<script type="text/javascript">

$(function(){

	field = ["aprv_seqno", "row_seq", "top_org_nm", "aprv_org_nm", "aprv_emp_id", "aprv_emp_nm", "aprv_now_jobgrd_cd_nm", "aprv_seqno", "base_aprv_line_seqno", "aprv_auth_nm", "absence"]; //grid 내 element id
	var cols_aprv = [
				 {label:'순번'          	,name:'aprv_seqno'           	,index:'aprv_seqno'             ,align:'center'  ,width:'40'  ,hidden:false  ,sortable:false }
	            ,{label:'번호'           	,name:'row_seq'           		,index:'row_seq'             	,align:'center'  ,width:'30'  ,hidden:true   ,sortable:false }
	            ,{label:'소속'       	 	,name:'top_org_nm'           	,index:'top_org_nm'            	,align:'center'  ,width:'80'  ,hidden:true   ,sortable:false }
	            ,{label:'부서'    			,name:'aprv_org_nm'          	,index:'aprv_org_nm'            ,align:'center'  ,width:'100' ,hidden:false  ,sortable:false }
	            ,{label:'직급'    			,name:'aprv_now_jobgrd_cd_nm'   ,index:'aprv_now_jobgrd_cd_nm'  ,align:'center'  ,width:'80'  ,hidden:false  ,sortable:false }	            	            
	            ,{label:'사번'        		,name:'aprv_emp_id'           	,index:'aprv_emp_id'            ,align:'center'  ,width:'80'  ,hidden:false  ,sortable:false }
	            ,{label:'성명'         		,name:'aprv_emp_nm'           	,index:'aprv_emp_nm'            ,align:'center'  ,width:'130' ,hidden:false  ,sortable:false/* , formatter : fm_aprv_emp_nm */ }
	            ,{label:'결재구분'    		,name:'aprv_auth_nm'          	,index:'aprv_auth_nm'           ,align:'center'  ,width:'80'  ,hidden:false  ,sortable:false }
	            ,{label:'기본결재선번호'     ,name:'base_aprv_line_seqno' ,index:'base_aprv_line_seqno'   ,align:'center'  ,width:'1'   ,hidden:true   ,sortable:false }
	            ,{label:'결재상태일련 번호'  ,name:'real_stat_seqno'   	,index:'real_stat_seqno'     	,align:'center'  ,width:'1'   ,hidden:true   ,sortable:false }
	            ,{label:'부재'    			,name:'absence'          		,index:'absence'           		,align:'center'  ,width:'120' ,hidden:true  ,sortable:false, formatter : fm_absence}
	            
	     ];

	//init grid
	var grid_aprv = com.grid.init({
		 		 id			: '#jqGridAprv' 
				,viewrecords: false
				,height		: 152
				//,autowidth  : true
				//,multiselect: true
				,rowNum		: 5
				//,shrinkToFit: true
				,scroll 	: 1
	 
		,gridComplete: function(){
			mergeCellcomplet($(this));

		}
		,ondblClickRow: function(id) { // row를 선택했을때 액션.
			
			var ret = $("#jqGridAprv").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.

		}
		,loadComplete: function(data){
			var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
			if((ids.length == 0)&&($('#AprvDefault').val()=='N')){
				refreshGrid3(true);
			}
			
			//요청자 부재 disable
			$('select[name=absence]').eq(0).prop('disabled', true);
			
			
		}
		,custom : { //custom
			 cols : cols_aprv //컬럼정보 - 필수!
			,navButton : {
				excel : {
					exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
				}
			}
		}
	});
	
	var cols_aprv2 =[
	           	 {label:'번호'         ,index:'row_seq'     			,name:'row_seq'         	,align:'center' 	,width : '50',   hidden:false, sortable : false }
				,{label:'결재선 명' 	,index:'bs_aprv_ln_nm'     		,name:'bs_aprv_ln_nm' 		,align:'left' 		,width : '200',  hidden:false, sortable : false }
				,{label:'기본결재선' 	,index:'default_aprv'       	,name:'default_aprv'     	,align:'center' 	,width : '90', 	 hidden:true,  sortable : false }
			    ,{label:'등록일자'		,index:'reg_dt'      			,name:'reg_dt'      		,align:'center' 	,width : '90', 	 hidden:false, sortable : false }
			    ,{label:'수정일'		,index:'mod_dt'      			,name:'mod_dt'      		,align:'center' 	,width : '90', 	 hidden:true,  sortable : false }
			    ,{label:'비고'		 	,index:'base_aprv_line_desc'    ,name:'base_aprv_line_desc' ,align:'center' 	,width : '300',  hidden:false, sortable : false }
			    ,{label:'key'	     	,index:'bs_aprv_ln_seqno'     	,name:'bs_aprv_ln_seqno'  	,align:'center'     ,width : '80',   hidden:true }
			
		    ]
			
	//init grid
 	var grid = com.grid.init({
		 id			: '#jqGridAprv2'
		,viewrecords: false
		,height		: 152
		//,autowidth  : true
		,rowNum		: 5
		//,multiselect: true
		,gridComplete: function(){
			mergeCellcomplet($(this));
		}
		,onSelectRow: function(id) { // row를 선택했을때 액션.
			
			var ret = $("#jqGridAprv2").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
			var value1 = ret.bs_aprv_ln_seqno; 	// 이런식으로 값을 가져올 수 있다.
			
			$('#bs_aprv_ln_seqno').val(value1);
			refreshGrid(true);
			
		}
		,custom : { //custom
			 cols : cols_aprv2 //컬럼정보 - 필수!
			,navButton : {
				excel : {
					exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
				}
			}
		}
	});
	
	refreshGrid2(true);
	
	
	//부재
	function fm_absence(cellvalue, options, rowObject) {
		var url ="";
		url = "<select name='absence' id='absence"+options.rowId+"' style='width:90px;'><option value=''>-- 선택 --</option>"+"<%=(String)rtn_Map.get("absence")%>"+"</selecd>";
	    return url;
	}
	
	// 실결재선 그리드 삽입 
	$("#btn_aprvgrid_add").click(function(e){

		var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		if(ids.length >=5){
			alert('결재는 5단계까지 가능합니다');
			return;
		}
		var addCnt  = 0;
		var i=0;
		for(i=0;i < ids.length;i++) {
			addCnt = ids[i];
			addCnt = addCnt.replace('jqg', '');
		}
 		addCnt = 'jqg'+(parseInt(addCnt)+1);
		var targetData = "";
			targetData = {
				row_seq 		: ''
			}

		jQuery("#jqGridAprv").jqGrid('addRowData',addCnt,targetData);
		
		// 결재선을 추가할경우 변경된 경우이므로 결재선변경여부를 Y로 셋팅한다.
		$("#aprv_line_modify_yn").val("Y");
		
		// 순서 및 결재권한명을 다시 셋팅해준다
		ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		for(i=0;i < ids.length;i++) {
			addCnt = ids[i];
			//addCnt = addCnt.replace('jqg', '');
		}
		
		
		
		for(i=0;i < ids.length;i++) {
			addCnt = ids[i];
			//addCnt = addCnt.replace('jqg', '');
			
			//순서 세팅
			jQuery("#jqGridAprv").jqGrid('setCell', addCnt, 'aprv_seqno', i+1);

			//결재권한 세팅
			if(i==0){
				jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','요청');
			}else if(i==ids.length-1){
				jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','승인');
			}else{
				jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','검토');
			}

		}

	});
	
	//실결재선 그리드 삭제
	$("#btn_aprvgrid_remove").click(function(e){
		
		if($('#jqGridAprv input:checkbox').eq(0).prop("checked")==true){
			alert('본인은 삭제할 수 없습니다.');
			return false;
		}
		
		var ids = jQuery("#jqGridAprv").jqGrid('getGridParam', 'selarrrow');
		var addCnt  = 0;
		var i = 0;
		    if(ids.length==0){
		    	alert('삭제할 항목을 선택하세요');
		    	return;
		    }
		    

		    for( i=ids.length; i>0; i-- ){
		    	// 기본결재선이나 실결재선번호가 있는경우를 삭제하는경우 결재선 수정여부를 Y로 셋팅
		    	if(!isEmpty($("#jqGridAprv").jqGrid('getCell', ids[i-1], "base_aprv_line_seqno"))
		    			|| !isEmpty($("#jqGridAprv").jqGrid('getCell', ids[i-1], "real_stat_seqno"))){
		    		$("#aprv_line_modify_yn").val("Y");
		    	}
		        $('#jqGridAprv').jqGrid('delRowData', ids[i-1]);
		    }
		    
			// 순서 및 결재권한명을 다시 셋팅해준다
			ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
			for(i=0;i < ids.length;i++) {
				addCnt = ids[i];
				//addCnt = addCnt.replace('jqg', '');

				//순서 세팅
				jQuery("#jqGridAprv").jqGrid('setCell', addCnt, 'aprv_seqno', i+1);

				//결재권한 세팅
				if(i==0){
					jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','요청');
				}else if(i==ids.length-1){
					jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','승인');
				}else{
					jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','검토');
				}
				
			}
		
	});	
	
	//확인버튼클릭시
	$("#btn_confirm").click(function(e){
		
		var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');

		if(ids == ''){
			alert('결재선을 선택해주세요')
			return;
		}
		
		var rtnArr = new Array();
		var aprv_arrObj = new Array();
		
		aprv_arrObj = JSONDataList("jqGridAprv", field);
		
		rtnArr.push(aprv_arrObj); // 결재선
		
		opener.<%=dto_FUN_FN%>(rtnArr);
		self.close();
		
	});		
	
	//닫기
	$("#btn_close").click(function(e){
		self.close();
		
	});
	
	var arr_opener = new Array();
	var vo = new Object();
	<%
	if(aprv_line_json != null){
		if(aprv_line_json.size() > 0){
			for(i=0;i<aprv_line_json.size();i++){
				aprv_line_json_map = (Map)aprv_line_json.get(i);
	%>
				vo = new Object();
				vo.top_org_nm = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("top_org_nm"),"")%>";
				vo.aprv_org_nm = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("aprv_org_nm"),"")%>";
				vo.aprv_emp_id = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("aprv_emp_id"),"")%>";
				vo.aprv_emp_nm = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("aprv_emp_nm"),"")%>";
				vo.aprv_seqno = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("aprv_seqno"),"")%>";
				vo.base_aprv_line_seqno = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("base_aprv_line_seqno"),"")%>";
				vo.aprv_now_jobgrd_cd_nm = "<%=HtmlTag.returnString((String)aprv_line_json_map.get("aprv_now_jobgrd_cd_nm"),"")%>";
				arr_opener.push(vo);
	<%
			}
		}
	}
	%>

});

function setarr_opener(rtnArr){
	var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
	var addCnt  = 0;
	for(i=0;i < ids.length;i++) {
		addCnt = ids[i];
		addCnt = addCnt.replace('jqg', '');
	}
		addCnt = parseInt(addCnt)+1;
	var targetData = "";
	for(i=0;i<rtnArr.length;i++){
		targetData = { 
			row_seq 				: ''
			,top_org_nm				: rtnArr[i].top_org_nm
			,aprv_org_nm			: rtnArr[i].aprv_org_nm
			,aprv_emp_id			: rtnArr[i].aprv_emp_id
			,aprv_emp_nm			: rtnArr[i].aprv_emp_nm
			,aprv_seqno				: rtnArr[i].aprv_seqno
			,base_aprv_line_seqno	: rtnArr[i].base_aprv_line_seqno
			,aprv_auth_nm			: (i==rtnArr.length-1)?'승인':'검토'
			,aprv_now_jobgrd_cd_nm	: rtnArr[i].aprv_now_jobgrd_cd_nm
		}
		
		jQuery("#jqGridAprv").jqGrid('addRowData',addCnt,targetData);
		addCnt++;
	}
}


//직원명
function fm_aprv_emp_nm(cellvalue, options, rowObject) {
	var url ='';
	url = '<div class="item iDate fL" style="width:120px;">';
	if(cellvalue!=undefined && cellvalue!=""){
		url += '<input type="text" id="aprv_emp_nm'+options.rowId+'"  name="aprv_emp_nm" maxlength="100" style="width:80px;" readonly value="'+cellvalue+'"/>';
	}else{
		url += '<input type="text" id="aprv_emp_nm'+options.rowId+'"  name="aprv_emp_nm" maxlength="100" style="width:80px;" readonly />';
	}
	
	url += '<span class="btnIc_search" id="btn_sawon_search"><a href="#" onclick="btn_sawon_search(\''+options.rowId+'\');return false;"></a></span>';
	url += '</div>';
    return url;
}

//결재자직원검색팝업 호출
function btn_sawon_search(rowId) {
	if(rowId == 'jqg20'){
		alert('본인은 변경할 수 없습니다.');
		return;
	}
	$("#AprvgridId").val(rowId);
	popWinScroll("<c:url value='/cmsmain.do'/>?scode=000008&pcode=000038&dto_FUN_FN=setOrgSawonAdd&pstate=PF2&multi_yn=N&check_yn=N", "orgSawonWinPop", 720, 680);
}


//조직 검색팝업 리턴값 셋팅
function setOrgSawonAdd(rtnArr){
	
 	if('<%=SS_empId%>'==rtnArr[0]){
		alert("본인은 결재자로 지정할수 없습니다.");
		return;
	}
 	
	
	// 결재선에 동일한 결재자가 등록되어있는지 확인한다
 	var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
	var chk_j =0;
	var chk_val0 = rtnArr[0];
	for (chk_j=0; chk_j<ids.length; chk_j++ ) {
		console.log('rtnArr[0] === '+rtnArr[0]);
		//console.log('chk_val0 === '+chk_val0);
		//console.log(' === '+$("#jqGridAprv").jqGrid('getCell', ids[chk_j], 'aprv_emp_id'));
		if(chk_val0 == $("#jqGridAprv").jqGrid('getCell', ids[chk_j], 'aprv_emp_id')){
			alert("이미 결재선에 등록된 사용자입니다.");
			return;
		}
	}
	
	
	// 결재선 추가시 수정여부는 Y로 셋팅한다
	$("#aprv_line_modify_yn").val("Y");
	
	jQuery("#jqGridAprv").jqGrid('setCell', $("#AprvgridId").val(), 'aprv_emp_id',rtnArr[0]);		// 결재자ID
	jQuery("#jqGridAprv").jqGrid('setCell', $("#AprvgridId").val(), 'aprv_emp_nm',rtnArr[1]);		// 결재자명
	jQuery("#jqGridAprv").jqGrid('setCell', $("#AprvgridId").val(), 'aprv_org_nm',rtnArr[3]);		// 부서
	jQuery("#jqGridAprv").jqGrid('setCell', $("#AprvgridId").val(), 'aprv_now_jobgrd_cd_nm',rtnArr[2]);	// 직급
	
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
        	
        	if($("#"+jqGrid).find("#"+field[j]+ids[i]).val()!=undefined){
        		
        		_value = $("#"+jqGrid).find("#"+field[j]+ids[i]).val();
        		_type  = $("#"+jqGrid).find("#"+field[j]+ids[i]).attr("type");        		
        	}else{
        		_value = $("#"+jqGrid).jqGrid('getCell', ids[i], field[j]);
        		_type  = "string";         		
        	}
        	
    		if(_type=="radio"){
    			
    			if($("#"+jqGrid+" input:radio[id="+field[j]+ids[i]+"]").is(":checked")){
    				$("#"+jqGrid+" input:radio[id="+field[j]+ids[i]+"]").each(function(){
    					if($(this).is(":checked")){
    						_value = $(this).val();
    					}
    				});
    				
    					eval("vo."+field[j]+"='"+_value+"';");
    			}else{
    				_value = "";
    					eval("vo."+field[j]+"='"+_value+"';");
    			}
    		}else if(_type=="checkbox"){
    			// console.log("field["+j+"]:=="+field[j]);

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
    //return JSON.stringify(arrObj);
    return arrObj;
}

//조회 : 그리드 조회(기본결재선)
function refreshGrid(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	_frm.AprvDefault.value = "N";

	var params = getGridParamDatas();
	com.grid.reload('#jqGridAprv','<%=con_root%>/cmsajax.do',params);
	setTimeout(CmcloseLoading,1000);

}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X3';
	return _params;
}

//조회 : 그리드 조회(결재선목록)
function refreshGrid2(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';

	var params = getGridParamDatas2();
	com.grid.reload('#jqGridAprv2','<%=con_root%>/cmsajax.do', params);
	setTimeout(CmcloseLoading,1000);

}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas2(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X4';
	return _params;
}

//조회 : 그리드 조회(본인조회)
function refreshGrid3(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';

	var params = getGridParamDatas3();
	com.grid.reload('#jqGridAprv','<%=con_root%>/cmsajax.do',params);
	setTimeout(CmcloseLoading,1000);

}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas3(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X2';
	return _params;
}
</script>

<body>
<form id="listfrm"  name="listfrm" method="post" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="aprv_key" id="aprv_key" value="<%=aprv_key%>" title="결재상태번호"  />
	<input type="hidden" name="aprv_pcode" id="aprv_pcode" value="<%=aprv_pcode%>" title="결재상태번호"  />
	<input type="hidden" name="aprv_job_cl_cd" id="aprv_job_cl_cd" value="<%=aprv_job_cl_cd%>" title="결재업무구분코드"  />
	<input type="hidden" name="AprvgridId" id="AprvgridId" />
	<input type="hidden" name="aprv_line_modify_yn" id="aprv_line_modify_yn" value="N" title="결재선수정여부" />
	<input type="hidden" name="bs_aprv_ln_seqno" id="bs_aprv_ln_seqno" value="" title="결재선 일련번호" />
	<input type="hidden" name="AprvDefault" id="AprvDefault" title="기본결재선 조회여부"/>


<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>결재선목록</h1>
	<div class="desc">
	    <div class="section">
			<!-- 첫번째 목록영역 -->  
			<div class="section mT5 mB10">
				<div class="section" >
					<h3 class="fL"><span>&#8226;</span>결재선정보</h3>
				</div>	
				<div class="section" >		
					<table id='jqGridAprv' fixwidth="Y"></table>

				</div>
			</div>
	    </div>
 	    <div class="section mT10">
			<!-- 두번째 목록영역 -->
			<div class="section mT5 mB10">
				<div class="section" >
					<h3 class="fL"><span>&#8226;</span>결재선을 선택후 확인을 눌러주세요</h3>
				</div>	
				<div class="section" >		
					<table id='jqGridAprv2' fixwidth="Y"></table>

				</div>
			</div>
	    </div>
	    <div class="button a_r mat_5">
		    <a href="#" class="btn_1 size_s" id="btn_confirm" >확인</a>
			<a href="#" class="btn_2 size_s" id="btn_close">닫기</a>
		</div>
	</div>
</div>
<div id="pageLoading" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:9999;display:none;"></div>
</form>
</body>
</html>
