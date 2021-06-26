<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_020_a1.jsp
/* 프로그램 이름     : jicm_apm_020_a1  
/* 소스파일 이름     : jicm_apm_020_a1.jsp
/* 설명              : 기본결재선 등록
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-28
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-04-20
/* 최종 수정내용     : 전력데이터제공 포털시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>

<script type="text/javascript">

var	field = ["row_seq","aprv_org_nm","aprv_emp_id","aprv_emp_nm","aprv_seqno","base_aprv_line_desc","bs_aprv_ln_seqno"]; //grid 내 element id

$(function(){
	//기본결재선
		var cols =[
					 {label:'순번'          	,name:'aprv_seqno'           	,index:'aprv_seqno'             ,align:'center'  ,width:'40'  ,hidden:false  ,sortable:false }
		            ,{label:'번호'           	,name:'row_seq'           		,index:'row_seq'             	,align:'center'  ,width:'30'  ,hidden:true   ,sortable:false }
		            ,{label:'소속'       	 	,name:'top_org_nm'           	,index:'top_org_nm'            	,align:'center'  ,width:'80'  ,hidden:true   ,sortable:false }
		            
		            ,{label:'소속'    			,name:'aprv_org_nm'          	,index:'aprv_org_nm'            ,align:'center'  ,width:'130'  ,hidden:false  ,sortable:false }
		            ,{label:'직위'    			,name:'aprv_now_jobgrd_cd_nm'   ,index:'aprv_now_jobgrd_cd_nm'  ,align:'center'  ,width:'80'   ,hidden:false  ,sortable:false }	            	            
		            ,{label:'사번'        		,name:'aprv_emp_id'           	,index:'aprv_emp_id'            ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
		            ,{label:'결재자명'         ,name:'aprv_emp_nm'           	,index:'aprv_emp_nm'            ,align:'center'  ,width:'140'  ,hidden:false  ,sortable:false, formatter : fm_aprv_emp_nm }

		            ,{label:'결재구분'    			,name:'aprv_auth_nm'        ,index:'aprv_auth_nm'           ,align:'center'  ,width:'80'   ,hidden:false  ,sortable:false }
		            ,{label:'기본결재선번호'      ,name:'base_aprv_line_seqno',index:'base_aprv_line_seqno'   ,align:'center'  ,width:'1'    ,hidden:true   ,sortable:false }
		            ,{label:'결재상태일련 번호'   ,name:'real_stat_seqno'   	,index:'real_stat_seqno'     	,align:'center'  ,width:'1'    ,hidden:true   ,sortable:false }
		];	


	//init grid
	var grid = com.grid.init({
		 id			 : '#jqGrid' 
		,viewrecords : true
		,height		 : 222
		,autowidth   : true
		,multiselect : true
		,rowNum		 : 15
		,scroll 	 : 1
		,gridComplete: function(){
			mergeCellcomplet($(this));
		}
		,onSelectRow: function(id) { // row를 선택했을때 액션.
			
		}
		,loadComplete: function(data){
			//$("#jqg_jqGrid_jqg20").prop("disabled", true);

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

	jQuery("#jqGrid").jqGrid('gridResize',{});
		
		//목록 이동
		$("#btn_list").click(function(e){
			  su_form=document.cffrm;
			  su_form.method='post';
			  su_form.pstate.value='L';
			  su_form.action='<%=RequestURL%>';
			  su_form.submit();
			  su_form.target = "";
		});
		
		//저장
		$("#btn_save").click(function(e){
			
			if(isEmpty($("#bs_aprv_ln_nm").val())){
				alert("결재선명을 입력하세요.");
				$("#bs_aprv_ln_nm").focus();
				return false;
			}

			var colModel = $("#jqGrid").jqGrid('getGridParam','colModel');
			var ids = jQuery("#jqGrid").jqGrid('getDataIDs');			
			var i = 0;
			var j = 0;
			var org_val = "";
			var jobduty_val = "";
			var emp_val = "";			
			
			if(ids.length<1){
				alert("입력된 결재선 목록이 없습니다. 결재선을 입력해주세요");
				return;
			}
			
			if(!validation("cffrm")) return false; //필수 체크

			
			$("#pstate").val("C");
			$("#JSONDataList").val(JSONDataList("jqGrid",field)); 
			
			// 결재라인에 등록된 내용을 확인해서 중복및 입력값을 확인한다
			// 소유자와 동일한 결재자를 등록할수 없다
 			// 동일한 결재자가 중복되어있는지 확인한다
				var chk_colModel = $("#jqGrid").jqGrid('getGridParam','colModel');
				var chk_arrObj = new Array();
				var chk_ids = jQuery("#jqGrid").jqGrid('getDataIDs');
				var chk_i=0;
				var chk_j=0;
				var chk_val0 = "";

				//요청자만 있을경우
				if(ids.length<2){
					alert("입력된 결재선이 없습니다. 결재선을 입력해주세요");
					return;
				}
				
				// 그리드의 행수만큼 루프를 돌린다
				for ( chk_i=0; chk_i<chk_ids.length; chk_i++ ) {
					if(isEmpty(jqGridval("jqGrid", "aprv_emp_id", chk_ids[chk_i]))){
						alert((chk_i+1)+"번째 행에 결재자가 입력되지 않았습니다.");
						return;
					}

					if(chk_i>0){
						//console.log(chk_val+":==:"+$("#jqGrid0").find("#officecd"+chk_ids[chk_i]).val());
						for ( chk_j=chk_i; chk_j<chk_ids.length; chk_j++ ) {
							if(chk_val0 == jqGridval("jqGrid", "aprv_emp_id", chk_ids[chk_j])){
								alert("결재선 입력내용중 "+jqGridval("jqGrid", "aprv_emp_nm", chk_ids[chk_j])+"가 중복입니다.");
								return;
							}
						}
					}
					chk_val0 = jqGridval("jqGrid", "aprv_emp_id", chk_ids[chk_i]);
				}
				
			//return;
			var params = jQuery("#cffrm").serialize();
			
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
			                $("#btn_list").trigger("click");
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
				
			jQuery("#jqGrid").jqGrid('addRowData',addCnt,targetData);
			
			
			// 순서 및 결재권한명을 다시 셋팅해준다
			ids = jQuery("#jqGrid").jqGrid('getDataIDs');
			for(i=0;i < ids.length;i++) {
				addCnt = ids[i];
				addCnt = addCnt.replace('jqg', '');
				
				//순서 세팅
				jQuery("#jqGrid").jqGrid('setCell', addCnt, 'aprv_seqno', i+1);
				
				//결재권한명 세팅
				if(i==ids.length-1){
					jQuery("#jqGrid").jqGrid('setCell',addCnt,'aprv_auth_nm','승인','');
				}else if(i==0){
					jQuery("#jqGrid").jqGrid('setCell',addCnt,'aprv_auth_nm','요청','');
				}else{
					jQuery("#jqGrid").jqGrid('setCell',addCnt,'aprv_auth_nm','검토','');
				}
			
			}
			
		});
		
		//그리드 삭제
		$("#btn_grid_remove").click(function(e){
			
			if($("#jqg_jqGrid_jqg20").prop("checked")==true){
				alert('본인은 삭제할 수 없습니다.');
				return false;
			}
			
			var ids = jQuery("#jqGrid").jqGrid('getGridParam', 'selarrrow');
			var delkey_col = "";
			var org_delkey = "";
			var delkey_val = "";
			var delkey_col_row = "";
			delkey_col="base_aprv_line_seqno";
			    if(ids.length==0){
			    	alert('삭제할 항목을 선택하세요');
			    	return;
			    }
			    org_delkey = $("#delkey").val();
			  
			    for(i=0;i<ids.length;i++){
			    	delkey_val = $("#jqGrid").jqGrid('getCell', ids[i], delkey_col);
			    	delkey_col_row = $("#jqGrid").jqGrid('getCell', ids[i], 'row_seq');

			    	if(delkey_col_row!="" && delkey_val!=""){
			    		org_delkey+= (org_delkey==""?"":",")+delkey_val; 
			    	}
			    		
			    }				    
			    
			    for( var i=ids.length; i>0; i-- ){
			        $('#jqGrid').jqGrid('delRowData', ids[i-1]);
			    }
			    
			    $("#delkey").val(org_delkey);
			
			    
				// 순서 및 결재권한명을 다시 셋팅해준다
				ids = jQuery("#jqGridAprv").jqGrid('getDataIDs');
				for(i=0;i < ids.length;i++) {
					addCnt = ids[i];
					addCnt = addCnt.replace('jqg', '');
					
					//순서 세팅
					jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'aprv_seqno', i+1);
					
					//결재권한명 세팅
					if(i==ids.length-1){
						jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','승인','');
					}else if(i==0){
						jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','요청','');
					}else{
						jQuery("#jqGridAprv").jqGrid('setCell',addCnt,'aprv_auth_nm','검토','');
					}
				}
				
		});
		
		jQuery("#jqGrid").jqGrid('gridResize',{});	
		
		refreshGrid(true);
		
});

function jqGridval(gridid, colname, idx){
	rtn_val = "";
	if($("#"+colname+idx).val()!=undefined){
		rtn_val = $("#"+colname+idx).val();
      		
	}else{
		rtn_val = $("#"+gridid).jqGrid('getCell', idx, colname);
	}
	return rtn_val;
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
        	//console.log("i:="+i+":j:="+j+":ids:"+ids[i]+":"+field[j]+":tagName:="+$("#"+jqGrid+"_"+field[j]).prop("tagName")+":ch_length:="+$("#"+jqGrid+"_"+field[j]).children().length);
        	//console.log("i:="+i+":j:="+j+":ids:"+ids[i]+":"+field[j]+":cellval:="+$("#"+jqGrid).jqGrid('getCell', ids[i], field[j])+":===:"+$("#"+field[j]+ids[i]).val());
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


//----------------------  formatter 시작


//직원명
function fm_aprv_emp_nm(cellvalue, options, rowObject) {
	var url ='';
	url = '<div class="item iDate fL">';
	if(cellvalue!=undefined && cellvalue!=""){
		url += '<input type="text" id="aprv_emp_nm'+options.rowId+'"  name="aprv_emp_nm" maxlength="100" style="width:75%;" readonly value="'+cellvalue+'"/>';
	}else{
		url += '<input type="text" id="aprv_emp_nm'+options.rowId+'"  name="aprv_emp_nm" maxlength="100" style="width:75%;" readonly />';
	}
	
	url += '<span class="btnIc_search" id="btn_sawon_search"><a href="#" onclick="btn_sawon_search(\''+options.rowId+'\');return false;"></a></span>';
	url += '</div>';
    return url;
}


//---------------------- formatter  끝


//직원검색팝업 호출
function btn_sawon_search(rowId) {
	if(rowId == 'jqg20'){
		alert('본인은 변경할 수 없습니다.');
		return;
	}
	$("#gridId").val(rowId);
	popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000038&dto_FUN_FN=setOrgSawonAdd&pstate=PF2&multi_yn=N&check_yn=N", "orgSawonWinPop", 700, 680);
}


//직원 검색팝업 리턴값 셋팅
function setOrgSawonAdd(rtnArr){
	
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'aprv_emp_id',rtnArr[0]);		// 직원아이디
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'aprv_emp_nm',rtnArr[1]);		// 직원명
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'aprv_org_nm', rtnArr[3]);		// 부서
	jQuery("#jqGrid").jqGrid('setCell', $("#gridId").val(), 'aprv_now_jobgrd_cd_nm', rtnArr[2]);	// 직급
	
}


//결재선 초기값 입력
function AddGridUser(){
	var ids = jQuery("#jqGrid").jqGrid('getDataIDs');
	var addCnt  = 0;
	for(var i=0;i < ids.length;i++) {
		addCnt = ids[i];
	}
	addCnt = parseInt(addCnt)+1;
	var targetData = "";
	targetData = {
					 aprv_seqno				: ''	//순번
		            ,aprv_org_nm			: ''	//부서
		            ,aprv_now_jobgrd_cd_nm	: ''	//직급
		            ,aprv_emp_id 			: ''	//사번
		            ,aprv_emp_nm			: ''	//결재자명
		            ,aprv_auth_nm			: ''	//결재권한
				}
	jQuery("#jqGrid").jqGrid('addRowData', addCnt, targetData);
}


//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	CmopenLoading();
	var _frm = document.cffrm;
	_frm.action='<%=RequestURL%>';

	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','<%=con_root%>/cmsajax.do',params);
	setTimeout(CmcloseLoading,1000);

}


//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.cffrm);
	_params.pstate = 'X3';
	return _params;
}

</script>

<form name="cffrm" id="cffrm" method="post"  onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="editMode" id="editMode" value="" title="선택된인덱스" />
	<input type="hidden" name="JSONDataList" id="JSONDataList" title="선택된인덱스" />
	<input type="hidden" name="gridId" id="gridId" title="그리드선택된인덱스" />
	<input type="hidden" name="delkey" id="delkey" value="" />

  	<div class="supply_box"> 
		  <div class="board_A0_W">
		  	<h3 class="fL mB5"><span>&#8226;</span><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 등록</h3>
		    <table>
		      <colgroup>
			   		<col width="15%" />
			   		<col width="55%" />
			   		<col width="15%" />
			   		<col width="15%" />
		      </colgroup>
		      <tr>
		    	<th scope="row" class="essential">결재선 명</th>
		    	<td colspan="3">
		    		<input type="text" name="bs_aprv_ln_nm" id="bs_aprv_ln_nm" class="input_type01 w_95p" maxlength="100" />
		    	</td>
<!-- 		    	<th scope="row">기본결재선</th>
		    	<td>
		    		<input type="checkbox" name="default_aprv" id="default_aprv" value="Y" />
		    	</td> -->
		      </tr>
		      <tr>
		       	<th scope="row">비고</th>
		       	<td colspan="3">
					<input type="text" name="base_aprv_line_desc" id="base_aprv_line_desc" maxlength="2000" class="input_type01 w_95p" />
		      	</td>
		    </table>
			<div class="aR mT20">
				<span class="btn_pack medium icon" id="btn_aprvgrid_add_sp"><span class="add"></span><a href="#none" id="btn_grid_add">추가</a></span>
				<span class="btn_pack medium icon" id="btn_aprvgrid_remove_sp"><span class="delete"></span><a href="#none" id="btn_grid_remove">삭제</a></span>
			</div>
			
			<div class="mT5">
				<div id="tab_menu" >
					<table id='jqGrid' minusht="100"></table>
				</div>
			</div>
		</div>
		<div class="button a_r mat_15">
			<a href="#" class="btn_1 size_n" id="btn_save">저장</a>
			<a href="#" class="btn_2 size_n" id="btn_list">목록</a>
		</div>
	</div>
</form>
 

