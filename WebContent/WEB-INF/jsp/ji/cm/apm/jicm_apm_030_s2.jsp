<%--
/*=================================================================================*/
/* 시스템            : 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_030_s2.jsp 
/* 프로그램 이름     : jicm_apm_030_s2  
/* 소스파일 이름     : jicm_apm_030_s2.jsp
/* 설명              : 결재현황 (사용자 본인리스트)
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-06-11
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-27
/* 최종 수정내용     : 전력데이터제공 포털시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
String st_aprv_req_ymd = DateUtility.getaddmon(curDate,"-", 2);
String ed_aprv_req_ymd = DateUtility.getaddmon(curDate,"+", 1);
%>
<script type="text/javascript">

$(function(){
	//결재현황 리스트
		var cols =[
		             {label:'번호'          		,index:'row_seq'     		,name:'row_seq'          ,align:'center' 	,width : '40',   hidden:true,frozen:true }
					,{label:'결재번호' 	 		,index:'real_stat_seqno'    ,name:'real_stat_seqno'  ,align:'center' 	,width : '60', 	 hidden:false,frozen:true }
					,{label:'결재요청명' 	 		,index:'aprv_req_nm'     	,name:'aprv_req_nm'      ,align:'left' 		,width : '250',  hidden:false,formatter : fm_moveJob }
					,{label:'대상업무' 			,index:'menu_nm'     		,name:'menu_nm'      	 ,align:'center' 	,width : '100',  hidden:false }
					,{label:'결재상태코드'		 	,index:'aprv_stat_cd'    	,name:'aprv_stat_cd'  	 ,align:'center' 	,width : '80',   hidden:true }
					,{label:'결재상태'		 		,index:'aprv_stat_cd_nm'    ,name:'aprv_stat_cd_nm'  ,align:'center' 	,width : '90',   hidden:false,formatter : fm_AprvStatPop}					
					,{label:'요청자' 	 			,index:'f_emp_nm'     		,name:'f_emp_nm'      	 ,align:'center' 	,width : '90',   hidden:false }
				    ,{label:'현결재자'				,index:'aprv_emp_nm'      	,name:'aprv_emp_nm'      ,align:'center' 	,width : '90', 	 hidden:false }
				    ,{label:'최종승인자'			,index:'aprv_emp_nm_last'   ,name:'aprv_emp_nm_last' ,align:'center' 	,width : '70', 	 hidden:false }
				    ,{label:'결재요청일'	 		,index:'aprv_req_ymd'   	,name:'aprv_req_ymd'     ,align:'center' 	,width : '150',  hidden:false }
				    ,{label:'결재완료일'	 		,index:'aprv_exe_ymd'   	,name:'aprv_exe_ymd'     ,align:'center' 	,width : '150',  hidden:false }
				    ,{label:'비고'	 				,index:'appr_stat_desc'   	,name:'appr_stat_desc'   ,align:'center' 	,width : '200',  hidden:true }
				    ,{label:'대상메뉴코드' 		,index:'menu_cd'     		,name:'menu_cd'      	 ,align:'center' 	,width : '90', 	 hidden:true }
				    ,{label:'결재연결키값'	 		,index:'aprv_req_job_no'   	,name:'aprv_req_job_no'  ,align:'center' 	,width : '100',  hidden:true }
				    ,{label:'업무화면상태'	 		,index:'job_pstate'   		,name:'job_pstate'    	 ,align:'center' 	,width : '100',  hidden:true }
				    ,{label:'업무화면파라메터명'	,index:'job_param_nm'   	,name:'job_param_nm'     ,align:'center' 	,width : '100',  hidden:true }
				    ,{label:'호출화면상태'	 		,index:'rtn_pstate'   		,name:'rtn_pstate'    	 ,align:'center' 	,width : '100',  hidden:true }
				    ,{label:'호출화면파라메터명'	,index:'rtn_param_nm'  	 	,name:'rtn_param_nm'     ,align:'center' 	,width : '100',  hidden:true }
				    ,{label:'호출화면메뉴'	 		,index:'rtn_menu_cd'   		,name:'rtn_menu_cd'    	 ,align:'center' 	,width : '100',  hidden:true }
		];

	//init grid
		var grid = com.grid.init({
					 id			: '#jqGrid' 
					,multiselect: false	
					,sortable	: false
					,viewrecords: true
					,shrinkToFit : true
					,height		: 370
					,autowidth  : true
					,rowList	: [15,50,100]
					,rowNum		: 15

			,gridComplete: function(){
				mergeCellcomplet($(this));
			}
			,onSelectRow: function(id) { // row를 선택했을때 액션.
				
				var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				var value1 = ret.matr_seqno; // 이런식으로 값을 가져올 수 있다.

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

		$("#btn_search").click( function() {
	
			refreshGrid();
	
		});

	//  결재업무선택팝업 호출
	$("#btn_aprv_job_search").click( function() {
		popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000499&dto_FUN_FN=setAprvJobAdd&pstate=PF1&multi_yn=N&check_yn=Y", "aprvjobWinPop", 700, 680);
	});	

	
	//엑셀로 저장
	$("#btn_excelAll").click(function(e){
		
		$("#pstate").val("X");
		
		//엑셀로 저장[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
		excelDownload3("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 리스트");
		
		$("#pstate").val("L");	
		
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

//업무 수정화면 이동
function fm_moveJob(cellvalue, options, rowObject) {
	var url ="";
	url = "<span class='large'><a href='#' style='color:blue;' onclick=moveJob('" + options.rowId + "'); >" + textToHtml(cellvalue)  + "</a></span>";
    return url;
}

//업무 수정화면 이동
function moveJob(rowId) {
	var ret = $("#jqGrid").jqGrid("getRowData",rowId); // ret는 선택한 row 값을 쥐고있는 객체다.

	var url = '';
	url = url+'<%=RequestURL%>?scode='+$("#scode").val()+'&req_pcode=<%=pcode%>';
	
	if(ret.rtn_menu_cd!=""){
		url = url+'&pcode='+ret.rtn_menu_cd;
	}else{
		url = url+'&pcode='+ret.menu_cd;
	}

	if(ret.job_param_nm=="" && ret.rtn_param_nm==""){
		url = url+'&saprv_req_job_no='+ret.aprv_req_job_no;

	}else{
		if(ret.job_param_nm!=""){
			url = url+'&'+ret.job_param_nm+'='+ret.aprv_req_job_no;
		}else{
			url = url+'&'+ret.rtn_param_nm+'='+ret.aprv_req_job_no;
		}
		
	}	

	if(ret.rtn_pstate!=''){
		url = url+'&pstate='+ret.rtn_pstate;
	}else{
		if(ret.aprv_stat_cd == '20'){
			url = url+'&pstate=UF2';
		}else{
			url = url+'&pstate=UF3';
		}
	}	

	top.location.href=url;
	
}

// 결재상태조회 팝업창
function fm_AprvStatPop(cellvalue, options, rowObject) {
	var url ="";
	if(cellvalue!=undefined && cellvalue!=""){
		url = "<span class='large' ><a href='#' style='color:blue;' onclick=AprvStatPop('" + options.rowId + "'); >" + textToHtml(cellvalue)  + "</a></span>";
	}
    return url;
}

//결재상태조회 팝업창
function AprvStatPop(rowId) {
	var ret = $("#jqGrid").jqGrid("getRowData",rowId); // ret는 선택한 row 값을 쥐고있는 객체다.
	
	popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000384&pstate=PF1&real_stat_seqno="+ret.real_stat_seqno, "AprvStatWinPop", 980, 680);
}


//직원검색팝업 호출
function btn_sawon_search() {
	popWinScroll("<%=con_root%>/cmsmain.do?scode=000008&pcode=000502&dto_FUN_FN=setOrgSawonAdd&pstate=PF2&multi_yn=N&check_yn=N", "orgSawonWinPop", 700, 680);
}

//조직 직원검색팝업 리턴값 셋팅
function setOrgSawonAdd(rtnArr){
	$("#sf_emp_id").val(rtnArr[0]);
	$("#sf_emp_nm").val(rtnArr[1]);

}

//결재업무 검색팝업 리턴값 셋팅
function setAprvJobAdd(rtnArr){
	$("#s_aprv_job_cl_cd").val(rtnArr[0]);		//코드
	$("#s_aprv_job_nm").val(rtnArr[1]);			//코드명

}

/////////////////////////////////////////////////////////////////////////////////////////////////
// 그리드 높이 동적변환
/* $(window).resize(function(){
	setTimeout(grid_win_resizeAutoHeight, 200);
	
}); */

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
			
			if($("#"+$(this).attr("id")).attr("landcnt")!=undefined){
				if($("#"+$(this).attr("id")).attr("landcnt")>1){
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
	<input type="hidden" name="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="cod_used" id="cod_used" value="" />
	<input type="hidden" name="cod_del" id="cod_del" value="" />
	<input type="hidden" name="saprv_req_job_no" id="saprv_req_job_no" value="" />
	<input type="hidden" name="delkey" id="delkey" value="" />
                                     
	<div class="searchArea mT10">
	  <table class="tbl_search" border="0" cellspacing="0" cellpadding="0" summary="조건검색 입니다.">
	    <colgroup>
	    	<col width="10%" />
		    <col width="15%" />
		    <col width="10%" />
		    <col width="17%" />
		    <col width="10%" />
			<col width="30%" />
			<col width="8%" />
	    </colgroup>
	    <tr>
			<th scope="row">결재제목</th>
			<td>
				<input type="text" name="stext" id="stext" title="검색어 입력"/>
			</td>
			<th scope="row">결재상태</th>
			<td>
		    	<select id="s_aprv_stat_cd" name="s_aprv_stat_cd" style="width:100px;" title="결재상태 선택">
		    		<option value="">-- 전체 --</option>
		          		<%=(String)rtn_Map.get("staprv_stat_cd")%>
		        </select>
			</td> 
			<th scope="row">결재요청일</th>
			<td colspan="2">
	            <input type="text" name="sst_aprv_req_ymd" id="sst_aprv_req_ymd" size="12" value="<%=st_aprv_req_ymd.substring(0,4)+"-"+st_aprv_req_ymd.substring(4,6)+"-"+st_aprv_req_ymd.substring(6,8)%>" readonly onClick="Calendar_D(this);" title="결재요청일자 검색시작일 입력"  /> 
	            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementsByName('sst_aprv_req_ymd')[0]);return false;"></a></span>
	            ~
	            <input type="text" name="sed_aprv_req_ymd" id="sed_aprv_req_ymd" size="12" value="<%=curDate.substring(0,4)+"-"+curDate.substring(4,6)+"-"+curDate.substring(6,8)%>" readonly onClick="Calendar_D(this);" title="결재요청일자 검색종료일 입력" />
	            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementsByName('sed_aprv_req_ymd')[0]);return false;" ></a></span>
			</td>
   

		  	<td>	
	   			<p class="fR mL10">
	   				<span class="btn_pack large vM"><a id="btn_search" href="#none">검색</a></span>
	    		</p>
			</td>  	     	  
	    </tr>
	  </table>
	</div>

    <div class="section">
	      <h3 class="fL"><span>&#8226;</span>결제현황 리스트</h3>
	      <p class="fR">  
<!-- 	           <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="# none;" >화면출력</a></span> -->
<!-- 	           <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="# none;" >엑셀로 저장</a></span> -->
	      </p>
    </div>
	<div id="grid">
		<table id='jqGrid' class="tbl_type2"></table>
	</div> 
	 
</form>


