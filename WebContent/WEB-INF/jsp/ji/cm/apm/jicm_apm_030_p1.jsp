<%--
/*=================================================================================*/
/* 시스템            : 결재
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_030_p1
/* 프로그램 이름     : jicm_apm_030_p1    
/* 소스파일 이름     : jicm_apm_030_p1.jsp
/* 설명              : 결재상태조회 팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-05-06
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-29
/* 최종 수정내용     : 전력데이터제공 포털시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>

<% 
	String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
	String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
	String real_stat_seqno = HtmlTag.returnString((String)request.getAttribute("real_stat_seqno"),"");

%>
<script type="text/javascript">

$(function(){
	
	var w1 = 980;
	var h1 = 499;// 그리드 높이만큼 미리 키워준다

	window.resizeTo(w1, h1);

	//결재상태 리스트
		var cols =[  {label:'순번' 			 ,index:'aprv_seqno'     		,name:'aprv_seqno'      	  ,align:'center' 		,width : '50', 	    hidden:false, sortable : false }
		            ,{label:'번호'           ,index:'row_seq'     			,name:'row_seq'         	  ,align:'center' 		,width : '50',   	hidden:true,  sortable : false }
					,{label:'부서명' 		 ,index:'aprv_org_nm'     		,name:'aprv_org_nm'      	  ,align:'center' 		,width : '110', 		hidden:false, sortable : false }
					,{label:'직급' 			 ,index:'aprv_now_jobgrd_cd_nm' ,name:'aprv_now_jobgrd_cd_nm' ,align:'center' 		,width : '90', 		hidden:false,  sortable : false }
					,{label:'사번' 			 ,index:'aprv_emp_id'     		,name:'aprv_emp_id'      	  ,align:'center' 		,width : '90', 		hidden:false, sortable : false }
					,{label:'성명' 	 		 ,index:'aprv_emp_nm'     		,name:'aprv_emp_nm'      	  ,align:'center' 		,width : '90', 		hidden:false, sortable : false }
					,{label:'결재구분'    	 ,index:'aprv_auth_nm'			,name:'aprv_auth_nm'          ,align:'center'  		,width : '80',      hidden:false, sortable : false}		
					,{label:'결재상태' 	 ,index:'aprv_stat_cd_nm'       ,name:'aprv_stat_cd_nm'    	  ,align:'center' 		,width : '80', 		hidden:false, sortable : false }
					,{label:'결재상태코드' ,index:'aprv_stat_cd'     		,name:'aprv_stat_cd'      	  ,align:'center' 		,width : '1', 		hidden:true,  sortable : false }
				    ,{label:'결재요청일' 	 ,index:'aprv_req_ymd'      	,name:'aprv_req_ymd'   		  ,align:'center' 		,width : '130', 	hidden:true, sortable : false }
				    ,{label:'결재일'	 	 ,index:'aprv_exe_ymd'     		,name:'aprv_exe_ymd'    	  ,align:'center' 		,width : '140', 	hidden:false, sortable : false }
				    ,{label:'결재비고'		 ,index:'appr_stat_desc'     	,name:'appr_stat_desc'    	  ,align:'center' 		,width : '160', 	hidden:false, sortable : false }
				    ,{label:'key'	     	 ,index:'real_stat_seqno'     	,name:'real_stat_seqno'  	  ,align:'center'       ,width : '1',     	hidden:true }
			    ];


	//init grid
	var grid = com.grid.init({
 		id			: '#jqGrid' 
		,viewrecords: true
		,height		: 230
		,autowidth 	: true
		,rowNum		: 10
		,shrinkToFit: true
		,scroll 	: 1
		,autowidth : true
		,gridComplete: function(){
			mergeCellcomplet($(this));
				
		}
		,ondblClickRow: function(id) { // row를 선택했을때 액션.
			
			var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.

			//$("#btn_confirm").click();
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
	
	refreshGrid(true); //조회	
	
	
	$("#btn_search").click( function() {
		refreshGrid(true); //조회
		
	});
	
	
	//닫기
	$("#btn_close").click(function(e){
		self.close();
		
	});
	
	
});


//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	var searchresult = new Array();
	if(isNotCheckVal==true){
		/*if(getLength($("#stext").val()) < 4){
			alert("검색어는 한글2자 영문4자이상 입력해주세요.");
			return;
		} */
		
	}
	
	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','<%=con_root%>/cmsajax.do', params);
	
	setTimeout(CmcloseLoading,500);
}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'PX1';
	return _params;
}


</script>

<form id="listfrm"  name="listfrm" method="post" onSubmit='return false;Go_search();' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="real_stat_seqno" id="real_stat_seqno" value="<%=real_stat_seqno%>" title="결재상태번호"  />
	
 
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>결재 상태 조회</h1>
	<div class="desc">
	    <div class="section mT10" style="height:300px;">
			<!-- 첫번째 목록영역 -->  
			<div class="section mT5 mB10" id="jqGridDiv">
				<table id='jqGrid' fixwidth="Y"></table>
				<div id="jqGridPager" style="text-align:center;"></div>       
			</div>              
		
	    </div>    
	    <div class="button a_c mat_10">
			<a href="#" class="btn_2 size_s" id="btn_close">닫기</a>
		</div>
	</div>
</div>
<div id="pageLoading" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:9999;display:none;"></div>
</form>
