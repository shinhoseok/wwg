<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_030_i1.jsp 
/* 프로그램 이름     : jicm_apm_030_i1
/* 소스파일 이름     : jicm_apm_030_i1.jsp
/* 설명              : 공통 업무 결재 처리 include
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-05-04
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-26
/* 최종 수정내용     : 전력데이터제공 포털시스템 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<script type="text/javascript">

var	field_aprv_line = ["row_seq","aprv_seqno","aprv_org_nm","aprv_now_jobgrd_cd_nm","aprv_emp_id","aprv_emp_nm","aprv_auth_nm","aprv_stat_cd_nm","aprv_exe_ymd","absence","base_aprv_line_seqno","real_stat_seqno","next_emp_email"]; //grid 내 element id
var staprv_job_cl_cd = "";
var absence_option = "";
var absense = false;	//부재체크

$(function(){
	//결재선
		var cols_aprv =[
	             {label:'번호'           	,name:'row_seq'           		,index:'row_seq'             	,align:'center'  ,width:'50'   		,hidden:true    ,sortable:false }
	            ,{label:'순번'          	,name:'aprv_seqno'           	,index:'aprv_seqno'             ,align:'center'  ,width:'60'   		,hidden:false   ,sortable:false }
	            ,{label:'소속'    			,name:'aprv_org_nm'          	,index:'aprv_org_nm'            ,align:'center'  ,width:'280'   	,hidden:false   ,sortable:false }
	            ,{label:'직위'    			,name:'aprv_now_jobgrd_cd_nm'   ,index:'aprv_now_jobgrd_cd_nm'  ,align:'center'  ,width:'150'   	,hidden:false   ,sortable:false }	            
	            ,{label:'사번'         		,name:'aprv_emp_id'           	,index:'aprv_emp_id'            ,align:'center'  ,width:'150'  		,hidden:false   ,sortable:false }
	            ,{label:'성명'         		,name:'aprv_emp_nm'           	,index:'aprv_emp_nm'            ,align:'right'   ,width:'150'  		,hidden:false   ,sortable:false	,formatter : fm_aprv_emp_nm }
	            ,{label:'결재구분'    		,name:'aprv_auth_nm'          	,index:'aprv_auth_nm'           ,align:'center'  ,width:'180'   	,hidden:false   ,sortable:false }
	            ,{label:'기본결재선번호'      ,name:'base_aprv_line_seqno'   ,index:'base_aprv_line_seqno'   ,align:'center'  ,width:'1'      ,hidden:true    ,sortable:false }
	            ,{label:'결재상태일련 번호'  ,name:'real_stat_seqno'   	   ,index:'real_stat_seqno'        ,align:'center'  ,width:'1'      ,hidden:true    ,sortable:false }
	            <%if(!aprv_key.equals("")){%>
	            ,{label:'결재상태' 	 	,name:'aprv_stat_cd_nm' 		,index:'aprv_stat_cd_nm'        ,align:'center'  ,width:'100'		,hidden:false	,sortable:false }
			    ,{label:'결재일'	 	 	,name:'aprv_exe_ymd' 			,index:'aprv_exe_ymd'     		,align:'center'  ,width:'170'		,hidden:false	,sortable:false }
			    ,{label:'결재비고'			,name:'appr_stat_desc' 			,index:'appr_stat_desc'     	,align:'center'  ,width:'200'		,hidden:false	,sortable:false }
	            <%}else{%>
	            ,{label:'부재'    			,name:'absence'          		,index:'absence'           		,align:'center'  ,width:'150'   	,hidden:true   ,sortable:false	,formatter : fm_absence }
	            <%}%>
	            ,{label:'이메일'  			,name:'next_emp_email'   		,index:'next_emp_email'         ,align:'center'  ,width:'200'      	,hidden:true    ,sortable:false }
	            
		];
	
	//init grid
	var grid_aprv = com.grid.init({
		 id			: '#jqGridAprv'
		,viewrecords: true
		,height		: 225
		,autowidth  : true
		,shrinkToFit: false
		,rowNum		: 10
		,scroll 	: 1
		,multiselect: true
		,gridComplete: function(){
			mergeCellcomplet($(this));
		}
		,onSelectRow: function(id) { // row를 선택했을때 액션.
			var ret = $("#jqGridAprv").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
		
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
	
	refreshAprvGrid();	//기본결재정보조회
	jQuery("#jqGridAprv").jqGrid('gridResize',{});
	

	// 실결재선 그리드 삽입
	$("#btn_aprvgrid_add").click(function(e){
		
		var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		if(ids.length >=5){
			alert('결재는 5단계까지 가능합니다');
			return;
		}
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
		
		jQuery("#jqGridAprv").jqGrid('addRowData',addCnt,targetData);
		
		// 결재선을 추가할경우 변경된 경우이므로 결재선변경여부를 Y로 셋팅한다.
		$("#aprv_line_modify_yn").val("Y");
		
		// 순서 및 결재권한명을 다시 셋팅해준다
		ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		for(i=0;i < ids.length;i++) {
			addCnt = ids[i];
			
		}
		for(i=0;i < ids.length;i++) {
			addCnt = ids[i];
			
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
	
	
	// 결재선목록
	$("#btn_aprv_req4").on("click", function(){
		var submit_url = "<%=con_root%>/cmsmain.do?scode=000008&pcode=000387&dto_FUN_FN=setAprvPop&pstate=PF2";
			popWinScroll(submit_url, "setAprvWinPop", 760, 635);
			
	});
	
	
	// 결재요청버튼 클릭시
	$("#btn_aprv_req5").on("click", function(){
		
		var maxlength = "";
		var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		
		if(isEmpty($("#aprv_pcode").val())){
			alert("결재 기본셋팅값중 pcode 값이 셋팅되지 않았습니다");
			return;
		}
		
		if(isEmpty($("#aprv_job_cl_cd").val())){
			alert("결재 업무가 선택되지 않았습니다. 관리자에게 문의하세요");
			return;
		}
		
		if(ids.length<2){
			alert('결재는 2인이상 가능합니다.');
			return;
		}
		
		//모든 결재자가 부재중인경우
 		$('#jqGridAprv select[name=absence]').not('#absence1').each(function(){
			if( $(this).val() == ''){
				absense=true;

			}
			
		});

		if(absense==false){
			alert('모든결재자가 부재중일 수 없습니다.');
			return;
		}
		
		// 결재 실결재선 입력항목을 체크한다
		var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
		var gridcheck = ["aprv_org_nm","aprv_emp_nm"]; //grid 내 element id; //grid validation check
		if(ids.length<1){
			alert("입력된 결재선이 없습니다. 결재선을 입력해주세요");
			return;
		}
		
		$("#JSONDataListAprv").val(JSONDataList("jqGridAprv", field_aprv_line));

		// 결재중상태값셋팅
		$("#aprv_stat_cd").val("20");
		$("#aprv_btn_index").val("1");
		 
		aprv_job_call();
		
	});
	
	
	//재요청버튼 클릭시
	$("#btn_aprv_req6").on("click", function(){
		
		var i = 0;
		var ids = $('#jqGridAprv').jqGrid('getDataIDs');
		for( i=ids.length; i>0; i-- ){
			$('#jqGridAprv').jqGrid('delRowData', ids[i-1]);
		}
		
		refreshGrid3();
		$('#aprv_key').val('');
		$('#pstate').val('U1');
		absense = true
		
		//추가,삭제 버튼 활성
		$('#btn_aprvgrid_add_sp').show();
		$('#btn_aprvgrid_remove_sp').show();
		
		//결재요청, 결재선목록 버튼 활성
		$("#btn_aprv_req5").show();
		$("#btn_aprv_req4").show();
		
		//재요청버튼 비활성
		$("#btn_aprv_req6").hide();
		
		
		
		
		
		
	});
	
	
	// 결재승인버튼 클릭시
	$("#btn_aprv_req2").click(function(e){
		if(!confirm("결재승인 하시겠습니까?")){
			return;
		}
		var maxlength = "";
		
		if(isEmpty($("#aprv_pcode").val())){
			alert("결재 기본셋팅값중 pcode 값이 셋팅되지 않았습니다");
			return;
		}
		
		if(isEmpty($("#aprv_job_cl_cd").val())){
			alert("결재 업무가 선택되지 않았습니다. 관리자에게 문의하세요");
			return;
		}

       
       // 결재 승인시 필수값 입력여부확인
		if($("#cur_real_stat_seqno").val()==""){
			alert("현결재업무번호가 셋팅되지 않았습니다");
			return;
		}
        
		if($("#cur_aprv_seqno").val()==""){
			alert("현결재순번이 셋팅되지 않았습니다");
			return;
		}
		
		if($("#cur_aprv_lastyn").val()==""){
			alert("최종결재자여부가 셋팅되지 않았습니다");
			return;
		}
		
		var gridcheck = ["aprv_emp_nm"]; //grid 내 element id; //grid validation check
		// 추가 결재선정보가 있으면 추가로 처리한다.
		if(!gridValidation("jqGridAprv", gridcheck)) return false; //필수 체크
		$("#JSONDataListAprv").val(JSONDataList("jqGridAprv",field_aprv_line));
		
	    $("#aprv_stat_cd").val("40");// 결재승인상태값셋팅
	    
	    $("#aprv_btn_index").val("2");
	    aprv_job_call();
		
	});	
	
	// 결재반송버튼 클릭시
	$("#btn_aprv_req3").click(function(e){
		if(!confirm("결재반송 하시겠습니까?")){
			return;
		}
		var maxlength = "";
		// 결재 입력항목을 체크한다
		if(isEmpty($("#iappr_stat_desc").val())){
			alert("결재반송시에는 반송사유를 반송사유란에 입력하셔야합니다.");
			$("#iappr_stat_desc_tr").show();
			return;
		}
		
       $("#aprv_stat_cd").val("30");// 결재반송상태값셋팅
       
       // 결재 승인시 필수값 입력여부확인
		if($("#cur_real_stat_seqno").val()==""){
			alert("현결재업무번호가 셋팅되지 않았습니다");
			return;
		}
       
		if($("#cur_aprv_seqno").val()==""){
			alert("현결재순번이 셋팅되지 않았습니다");
			return;
		}
		
		if($("#cur_aprv_lastyn").val()==""){
			alert("최종결재자여부가 셋팅되지 않았습니다");
			return;
		}		
		
		$("#aprv_btn_index").val("3");
		aprv_job_call();
		
	});		

});




// 업무쪽으로 제어권을 넘긴다
function aprv_job_call(){
	<%=aprv_javascript_fn%>();
	setTimeout(aprv_job_call_init ,300);
}


function aprv_job_call_init(){
	$("#aprv_stat_cd").val("");	// 업무단에서 실행을 멈출경우 값을 초기화한다	
}


//조회 : 결재관련그리드 조회()
function refreshAprvGrid(){
	var params = getAprvGridParamDatas();

	CmopenLoading();
	 $.ajax({
         type: "post",
         url: "<%=con_root%>/cmsajax.do",
         data: params,
         async: false,
         dataType:"json",
         success: function(data){
           if(data.result==true){
           	   
        	   staprv_job_cl_cd = data.staprv_job_cl_cd;
        	   $("#aprv_job_cl_cd").val(data.aprv_job_cl_cd);
        	   if(isEmpty($("#aprv_job_cl_cd").val())){
        		   alert("결재 업무가 선택되지 않았습니다. 관리자에게 문의하세요");
        	   }
        	   absence_option = data.absence;	//결재
        	   setAprvLine(data.aprv_line, data.aprv_reqchk, data.aprv_job_cl_cd, data.aprv_stat_cd, data.aprv_req_nm);
        	   
        	   
           }else{
        	   if(data.TRS_MSG==null){
        		   alert("정의되지 않은 에러입니다.=====");
        	   }else{
        		   alert(data.TRS_MSG);
        	   }
        	   
           }
           setTimeout(CmcloseLoading,1000);
           
         },
         error: function(request,status,error){
        	 setTimeout(CmcloseLoading,1000);
         
         }
  	});	
}


//그리드 조회시 요청할 파라미터 object
function getAprvGridParamDatas(){
	var r = new Array();
	r.push({name:'scode',value:'<%=scode%>'});
	r.push({name:'pcode',value:'000384'});
	r.push({name:'pstate',value:'AX1'});
	r.push({name:'aprv_key',value:$("#aprv_key").val()});
	r.push({name:'aprv_pcode',value:$("#aprv_pcode").val()});

	return r;
}


//조회 : 그리드 조회(본인조회)
function refreshGrid3(){

	var params = getGridParamDatas3();

	CmopenLoading();
	 $.ajax({
         type: "post",
         url: "<%=con_root%>/cmsajax.do",
         data: params,
         async: false,
         dataType:"json",
         success: function(data){
           
         	 if(data.result==true){
           
        	   var aprv_temp = data.rows[0];
        	   
	   			var targetData = "";
	   			targetData = {
			   				 row_seq 		: ''
			   				,aprv_seqno		: '1'
			   				,aprv_org_nm	: aprv_temp.aprv_org_nm
			   				,aprv_now_jobgrd_cd_nm	: aprv_temp.aprv_now_jobgrd_cd_nm
			   				,aprv_emp_id	: aprv_temp.aprv_emp_id
			   				,aprv_emp_nm	: aprv_temp.aprv_emp_nm
			   				,aprv_auth_nm	: aprv_temp.aprv_auth_nm
	   			}
	   			
	   			jQuery("#jqGridAprv").jqGrid('addRowData', 1, targetData);
	   			
	   			//요청자 부재 disable
	   			$('select[name=absence]').eq(0).prop('disabled', true);
	        	   
	           }else{
	        	   if(data.TRS_MSG==null){
	        		   alert("정의되지 않은 에러입니다.=====");
	        	   }else{
	        		   alert(data.TRS_MSG);
	        	   }
	        	   
	           }
	           setTimeout(CmcloseLoading,1000);
           
         },
         error: function(request,status,error){
        	 setTimeout(CmcloseLoading,1000);
         
         }
  	});	

}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas3(){
	
	var r = new Array();
	r.push({name:'scode',value:'<%=scode%>'});
	r.push({name:'pcode',value:'000384'});
	r.push({name:'user_id',value:'<%=SS_empId%>'});
	r.push({name:'pstate',value:'X2'});

	return r;
}


//현재 조회된 결재라인셋팅
function setAprvLine(aprv_line, aprv_reqchk, aprv_job_cl_cd, aprv_stat_cd, aprv_req_nm){

	var ids = jQuery("#jqGridAprv").jqGrid("getDataIDs");
	var addCnt  = 0;
	var i = 0;
	var j = 0;
	var cur_id_chk = false;
	
	// 현재 결재상태를 셋팅한다
	$("#cur_aprv_stat_cd").val(aprv_stat_cd);
	if(aprv_req_nm != ''){
		$("#iaprv_req_nm").val(aprv_req_nm);
	}
	
	
	//console.log('aprv_job_cl_cd=== '+aprv_job_cl_cd);
	//console.log('aprv_reqchk=== '+aprv_reqchk);
	
	// 결재 업무가 셋팅된 경우만 보여준다
	if(!isEmpty(aprv_job_cl_cd)){
		
		// 결재 진행중이 아닐경우
		if(aprv_reqchk==false){
		
			<%
			// 현재 등록화면일경우
			if(aprv_key.equals("") && aprv_org_data_reg_id.equals("")){
			%>
			//console.log('등록');
			   
				for(i=0;i < ids.length;i++) {
					addCnt = ids[i];
					addCnt = addCnt.replace('jqg', '');
				}
				addCnt = parseInt(addCnt)+1;
				
/* 				for(i=0;i < aprv_line.length;i++) {
					jQuery("#jqGridAprv").jqGrid('addRowData', addCnt, aprv_line[i]);
					addCnt++;
				} */
				
				// 결재선이 셋팅되지 않았으면 결재요청버튼을 보여준다 ==> 결재선지정은 결재 요청시에는 무조건 보여준다
				<%
				// 해당 메뉴에 등록권한이 있는경우에만 결재요청버튼이 보인다
				if(SS_admin.equals("Y")){
				%>
			    //결재요청, 결재선목록버튼 활성화
			    $("#btn_aprv_req4").show();
				$("#btn_aprv_req5").show();
			    <%
				}
				
			// 수정화면일경우 원데이터 등록자와 현재 화면을 보고 있는 사용자가 같은경우만 결재 요청, 결재정보 등록 버튼을 보여준다
			}else{
				if(aprv_key.equals("") && aprv_org_data_reg_id.equals(SS_empId)){
			%>
			//console.log('수정 - 등록자');

				for(i=0;i < ids.length;i++) {
					addCnt = ids[i];
					addCnt = addCnt.replace('jqg', '');
				}
				addCnt = parseInt(addCnt)+1;
				
/* 				for(i=0;i < aprv_line.length;i++) {
					jQuery("#jqGridAprv").jqGrid('addRowData', addCnt, aprv_line[i]);
					addCnt++;
				} */
				
			  //결재전일 경우만 결재요청, 결재선목록버튼 활성화
			  <%
			    	if(aprv_key.equals("")){
			  %>
			  			$("#btn_aprv_req4").show();
			    		$("#btn_aprv_req5").show();
			  <%
			    	}

					// 등록자가 아닌경우 결재요청등 버튼을 모두 숨긴다
				}else{
				
				}
			}
			%>
	
			//1단계 결재자는 본인으로 설정한다.
			refreshGrid3();
			
		// 결재 진행중일경우 결재선정보를 테이블로 만든다
		}else{
			//console.log('결재중');
			
			//결재요청명 비활성
			$('#iaprv_req_nm').prop('readonly', true);
			
			//추가,삭제 버튼 비활성
			$('#btn_aprvgrid_add_sp').hide();
			$('#btn_aprvgrid_remove_sp').hide();
			
			//수정,삭제버튼 비활성
			$('#btn_modify').hide();
			$('#btn_delete').hide();
			
			//삭제, 등록버튼 비활성
			$('#btn_del').hide();
			$('#btn_save').hide();
			
			//결재정보를 세팅한다
			for(i=0;i < aprv_line.length;i++) {
				jQuery("#jqGridAprv").jqGrid('addRowData', addCnt, aprv_line[i]);
				addCnt++;
			}
			 
			// 먼저 현결재자를 셋팅한다 ==========================================================
			// 현결재상태가 반송이 아닐경우
			if(aprv_stat_cd != "30"){
				var aprv_last = aprv_line.length-1;
				
				for(i=0;i < aprv_line.length;i++) {

					// 현결재자를 셋팅한다(결재중인경우)
					if(aprv_line[i].aprv_exe_ymd==null){
						if(cur_id_chk==false){
							$("#cur_real_stat_seqno").val(aprv_line[i].real_stat_seqno);
							$("#cur_aprv_seqno").val(aprv_line[i].aprv_seqno);
							$("#cur_aprv_emp_id").val(aprv_line[i].aprv_emp_id);
							
							if(i==aprv_line.length-1){	//최종결재자 여부
								$("#cur_aprv_lastyn").val("Y");
							}else{
								$("#cur_aprv_lastyn").val("N");
								
								//최종결재자가 부재중일때
								if((aprv_line[aprv_last].absence != null) && (aprv_line[i].aprv_seqno)==i+1){
									$("#cur_aprv_lastyn").val("Y");
								}
							}
						}
						
						cur_id_chk = true;
					}
					
				}
			// 만일 현결재상태가 반송인경우 반송자가 속한 결재그룹의 첫번째 결재자가 현결재자로 셋팅되고 
			// 다시 결재요청을 올릴수 있도록 한다
			}else{

				// 기본결재선을 로드한다
				/* refreshAprvGridPs(); */
				$("#btn_aprv_req6").show();
				
			}
			
			
			// 먼저 현결재자를 셋팅한다 ==========================================================
			// 만일 현결재자가 셋팅되지 않았으면 결재 완료이므로 결재승인,반송버튼을 숨긴다
			if(isEmpty($("#cur_real_stat_seqno").val())){
				   
			    // 결재승인 버튼 비 활성화
			    $("#btn_aprv_req2").hide();
			    // 결재반송 버튼 비활성화
			    $("#btn_aprv_req3").hide();	

			    // 결재선지정 버튼을 보여주지 않는다
			    $("#btn_aprv_req5").hide();

			   
				   
			// 현결재자가 셋팅된경우 현결재자가 로그인 사용자와 동일한 직원인지 확인해서 결재버튼을 보여줄지여부를 결정한다
			}else{
				
				// 현재 반송이아닌경우
				if(aprv_stat_cd!="30"){
					
					// 현결재자가 아니면 숨긴다
					if($("#cur_aprv_emp_id").val() != "<%=SS_empId%>"){


						   // 결재선지정 버튼을 보여주지 않는다
						    $("#btn_aprv_req5").hide();

						  
					// 로그인한사람이 현결재자인경우
					}else{

						   // 결재선지정 버튼을 보여주지 않는다
					       $("#btn_aprv_req5").hide();

						   // 현결재자가 일반결재자인경우 결재승인 ,반송버튼을 활성화한다
						   // 결재승인 버튼  활성화
						   $("#btn_aprv_req2").show();
						   // 결재반송 버튼 활성화
						   $("#btn_aprv_req3").show();

					}
					
				// 현재 결재상태가 반송인경우
				}else{
					
					// 현결재자가 아니면 숨긴다
					if($("#cur_aprv_emp_id").val()!="<%=SS_empId%>"){
						   
						   // 결재선지정 버튼을 보여주지 않는다
						    $("#btn_aprv_req5").hide();
						   
						   // 결재승인 버튼 비 활성화
						   $("#btn_aprv_req2").hide();
						   // 결재반송 버튼 비활성화
						   $("#btn_aprv_req3").hide();	
						   
						   
					// 로그인한사람이 현결재자인경우
					}else{

						   // 수정,삭제버튼만 비활성화한다
						   $("#btn_modify").hide();
						   $("#btn_delete").hide();
						   

					}					
				}
			}

			// 현결재가능자일경우 로직을 여기에 추가해야한다============================================================
				
				
			// 현결재가능자일경우 로직을 여기에 추가해야한다============================================================			
		}
		
	// 결재업무가 셋팅되지않은경우
	}else{
		$("#aprv_form_sp").hide();
		if(isEmpty(aprv_job_cl_cd)){
			alert("결재 업무가 셋팅되지 않았습니다. 관리자에게 문의하세요");
		}
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
	$("#AprvgridId").val(rowId);
	if(rowId == '1'){
		alert('요청자는 변경할 수 없습니다.');
		return;
	}
	popWinScroll("<c:url value='/cmsmain.do'/>?scode=000008&pcode=000038&dto_FUN_FN=setOrgSawonAdd&pstate=PF2&multi_yn=N&check_yn=N", "orgSawonWinPop", 720, 680);
}


//조직 검색팝업 리턴값 셋팅
function setOrgSawonAdd(rtnArr){
	//console.log(rtnArr);
 	if('<%=SS_empId%>'==rtnArr[0]){
		//alert("본인은 결재자로 지정할수 없습니다.");
		//return;
	}
 	
	
	// 결재선에 동일한 결재자가 등록되어있는지 확인한다
 	var ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
	var chk_j =0;
	var chk_val0 = rtnArr[0];
	for (chk_j=0; chk_j<ids.length; chk_j++ ) {
		//console.log('rtnArr[0] === '+rtnArr[0]);
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
	jQuery("#jqGridAprv").jqGrid('setCell', $("#AprvgridId").val(), 'next_emp_email',rtnArr[10]);// 이메일
}


//결재선목록 팝업창을 통해서 셋팅된값을 숨겨진 결재선정보에 셋팅한다
function setAprvPop(rtnArr){
	var i = 0;
	var addCnt = 1;
	var targetData = "";
	var ids = jQuery("#jqGridAprv").jqGrid("getDataIDs");
	
	// 기존에 등록된 결재선이 있으면 삭제한다
    for( var i=ids.length; i>0; i-- ){
        $('#jqGridAprv').jqGrid('delRowData', ids[i-1]);
    }

	for(i=0;i<rtnArr[0].length;i++){
		targetData = {
					 row_seq 				: ''
					,top_org_nm				: rtnArr[0][i].top_org_nm
					,aprv_org_nm			: rtnArr[0][i].aprv_org_nm
					,aprv_emp_id			: rtnArr[0][i].aprv_emp_id
					,aprv_emp_nm			: rtnArr[0][i].aprv_emp_nm
					,aprv_auth_nm			: rtnArr[0][i].aprv_auth_nm
					,aprv_seqno				: rtnArr[0][i].aprv_seqno
					,base_aprv_line_seqno	: rtnArr[0][i].base_aprv_line_seqno
					,aprv_now_jobgrd_cd_nm	: rtnArr[0][i].aprv_now_jobgrd_cd_nm
					,absence				: rtnArr[0][i].absence
		}
		jQuery("#jqGridAprv").jqGrid('addRowData', addCnt, targetData);
		addCnt++;
	}
	
	// 순서 및 결재권한명을 다시 셋팅해준다
	for(i=0;i < ids.length;i++) {
		addCnt = ids[i];
		
	}
	
	for(i=0;i < ids.length;i++) {
		addCnt = ids[i];
		
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
	
}	


//부재
function fm_absence(cellvalue, options, rowObject) {
	var url ="";
	url = "<select name='absence' id='absence"+options.rowId+"' style='width:90px;'><option value=''>-- 선택 --</option>"+absence_option+"</selecd>";
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
        	if($("#"+jqGrid).find("#"+field[j]+ids[i]).val()!=undefined){
        		
        		_value = $("#"+jqGrid).find("#"+field[j]+ids[i]).val();
        		_type  = $("#"+jqGrid).find("#"+field[j]+ids[i]).attr("type");        		
        	}else{
        		_value = $("#"+jqGrid).jqGrid('getCell', ids[i], field[j]);
        		_type  = "string";         		
        	}
        	
    		if(_type=="radio"){
    			//console.log("field["+j+"]:=="+field[j]+"::ids["+i+"]:==="+ids[i]+":=="+$("#"+jqGrid+" input:radio[id="+field[j]+ids[i]+"]").is(":checked"));
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
    			//console.log("field["+j+"]:=="+field[j]);

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

</script>

		<!-- 결재관련폼 -->
		<div>
			<input type="hidden" name="aprv_key" id="aprv_key" value="<%=aprv_key %>" />
			<input type="hidden" name="aprv_pcode" id="aprv_pcode" value="<%=((aprv_rpcode.equals(""))?pcode:aprv_rpcode) %>" />
			<input type="hidden" name="AprvgridId" id="AprvgridId" />
			<input type="hidden" name="JSONDataListAprv" id="JSONDataListAprv" title="결재선json" />
			<input type="hidden" name="aprv_stat_cd" id="aprv_stat_cd" value="" title="결재상태구분" />
			<input type="hidden" name="aprv_job_cl_cd" id="aprv_job_cl_cd" value="" title="결재업무메뉴코드" />
			<input type="hidden" name="cur_real_stat_seqno" id="cur_real_stat_seqno" value="" title="현결재자 결재상태일련번호" />
			<input type="hidden" name="cur_aprv_seqno" id="cur_aprv_seqno" value="" title="현결재자 결재상태순번" />
			<input type="hidden" name="cur_aprv_lastyn" id="cur_aprv_lastyn" value="" title="최종결재자여부" />
			<input type="hidden" name="cur_aprv_emp_id" id="cur_aprv_emp_id" value="" title="현결재자아이디" />
			<input type="hidden" name="cur_aprv_stat_cd" id="cur_aprv_stat_cd" value="" title="결재상태" />
			<input type="hidden" name="aprv_line_modify_yn" id="aprv_line_modify_yn" value="N" title="결재선수정여부" />
			<input type="hidden" name="aprv_btn_index" id="aprv_btn_index" value="" title="결재관련버튼클릭번호" />
			<input type="hidden" name="AprvDefault" id="AprvDefault" title="기본결재선 조회여부"/>
			
		    <div class="board_A0_W" id="aprv_form_sp"><!-- 하단 복합영역 구분-->

					<div class="section">
					<h3 class="mT10"><span>&#8226;</span>결재정보</h3>
					    <table class="inTbl">
					      	<colgroup>
						      	<col width="14%" />
						      	<col width="*" />
				      		</colgroup>
						    <tr id="iaprv_req_nm_tr">
								<th scope="row" class="essential">결재요청명</th>
								<td>
									<input type="text" name="iaprv_req_nm" id="iaprv_req_nm" maxlength="300" class="input_type01 w_95p" value="<%=aprv_to_title_col_id %>" />
								</td>
						    </tr>
				      		<tr id="iappr_stat_desc_tr" style="display:none;">
				        		<th scope="row" class="essential">반송사유</th>
				        		<td>
				            		<textarea name="iappr_stat_desc" id="iappr_stat_desc" maxlength="1000" class="input_type01 w_95p"></textarea>
				       			</td>
				       		</tr>
					    </table>
				 	</div>
					<div class="section">
						<h3 class="fL mT10"><span>&#8226;</span>결재선정보</h3>
						<p class="fR mT10">
							<span class="btn_pack medium icon" id="btn_aprvgrid_add_sp"><span class="add"></span><a href="#none" id="btn_aprvgrid_add">추가</a></span>
					      	<span class="btn_pack medium icon" id="btn_aprvgrid_remove_sp"><span class="delete"></span><a href="#none" id="btn_aprvgrid_remove">삭제</a></span>
						</p>
					</div>
					<div class="section"> 
			 			<table id='jqGridAprv' fixwidth="Y"></table>
			 		</div>
			 	<!-- 결재선 -->
			</div>
			
			<!-- 결재버튼 -->
			<div class="button a_r fL mat_15">
				<!-- 결재버튼 -->	
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req5" style="display:none;">결재요청</a>
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req6" style="display:none;">재요청</a>
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req4" style="display:none;">결재선목록</a>
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req1" style="display:none;"></a>
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req2" style="display:none;">결재승인</a>
				<a href="#none" class="btn_1 size_n" id="btn_aprv_req3" style="display:none;">결재반송</a>
			</div>
			<!-- 결재버튼 -->
		</div>
		<!-- 결재관련폼 -->		

	