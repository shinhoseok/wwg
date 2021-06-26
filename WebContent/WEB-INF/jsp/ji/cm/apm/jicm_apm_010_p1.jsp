<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_010_p1
/* 프로그램 이름     : jicm_apm_010_p1
/* 소스파일 이름     : jicm_apm_010_p1.jsp
/* 설명              : 결재업무선택팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-28
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-14
/* 최종 수정내용     : 전력데이터제공포털에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>

<% 
	String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
	String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
	String dto_FUN_FN = HtmlTag.returnString((String)request.getAttribute("dto_FUN_FN"),"");
	String matr_seqno = HtmlTag.returnString((String)request.getAttribute("matr_seqno"),"");
	String multi_yn = HtmlTag.returnString((String)request.getAttribute("multi_yn"),"Y");
	String check_yn = HtmlTag.returnString((String)request.getAttribute("check_yn"),"Y");
%>
<script type="text/javascript">

$(function(){
	
	//결재업무 리스트
		var cols =[{label:'번호'          		,index:'row_seq'     		,name:'row_seq'         	,align:'center' 	,width : '50',   	hidden:false, sortable : true }
					,{label:'대상메뉴' 		,index:'menu_cd'     		,name:'menu_cd'      		,align:'center' 	,width : '1', 		hidden:true,  sortable : true }
					,{label:'대상메뉴' 		,index:'menu_nm'     		,name:'menu_nm'      		,align:'center' 	,width : '140', 	hidden:false, sortable : true  }
					,{label:'메뉴상태코드' 	,index:'menu_stat_cd'     	,name:'menu_stat_cd'      	,align:'center' 	,width : '80', 		hidden:false, sortable : true }
				    ,{label:'결재업무명' 		,index:'aprv_job_nm'       	,name:'aprv_job_nm'     	,align:'center' 	,width : '150', 	hidden:false, sortable : true }
				    ,{label:'업무구분' 	 	,index:'aprv_job_cl_nm'     ,name:'aprv_job_cl_nm'   	,align:'center' 	,width : '116', 	hidden:false, sortable : true }
				    ,{label:'비고'		 		,index:'aprv_job_desc'     	,name:'aprv_job_desc'    	,align:'center' 	,width : '100', 	hidden:false, sortable : true }
				    ,{label:'key'	     		,index:'aprv_job_seqno'     ,name:'aprv_job_seqno'  	,align:'center'      ,width : '1',     	hidden:true }
			    ]	

	
	//init grid
	var grid = com.grid.init({
		 		id			: '#jqGrid' 
				,viewrecords: true
				,height		: 200
				,autowidth : true
				,rowList	: [50,100,200]
				,rowNum		: 5
				,shrinkToFit: true
				,multiselect: true
	 
		,gridComplete: function(){
			mergeCellcomplet($(this));
		}
		,ondblClickRow: function(id) { // row를 선택했을때 액션.
			
			var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.

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
	
	refreshGrid(false); //조회	
	
	
	$("#btn_search").click( function() {

		refreshGrid(true); //조회

	});
	
	//확정버튼
	$("#btn_confirm").click(function(e){
		var gridArr = new Array();
		gridArr.push(new Array());
		gridArr.push(new Array());

		
		var ids = jQuery('#jqGrid').jqGrid('getGridParam', 'selarrrow');

	    if(ids.length==0){
	    	alert('추가할 항목을 선택하세요.');
	    	return;
	    }
	    
		<%
		 if(!multi_yn.equals("Y")){
		%>		    
	    if(ids.length>1){
	    	alert('1건만 선택하세요.');
	    	return;
	    }
		 <%
		 }
		 %>	    
	    
	    for(var i=0;i<ids.length;i++){


			gridArr[0].push($("#jqGrid").jqGrid('getRowData', ids[i]).aprv_job_seqno);// 결재업무일련번호
			gridArr[1].push($("#jqGrid").jqGrid('getRowData', ids[i]).aprv_job_nm);//결재업무명
			

	   }
	    
		opener.<%=dto_FUN_FN%>(gridArr);
		//alert('11');
		self.close();
	    

	    
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
	com.grid.reload('#jqGrid','/cmsajax.do',params);
	
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
	<input type="hidden" name="dto_FUN_FN" value="<%=dto_FUN_FN%>" title="리턴될 함수명"  />

 
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>결재업무 선택</h1>
	<div class="desc">
    <div class="searchArea">
	  <table class="tbl_search">
	    <colgroup>
	    <col width="50" />
	    <col width="120" />	    
	    <col width="50" />
	    <col width="120" />
	    <col width="60" />
	    <col width="90" />
	    <col width="*" />
	    </colgroup>
	    <tr>
			<th scope="row">결재업무구분</th>
			<td>
		        <select name="saprv_job_cl_cd" title="결재업무구분 선택">
		          <option value="">--선택--</option>
		          	<%=(String)rtn_Map.get("staprv_job_cl_cd")%>
		        </select>
			</td>	    
	      	<th scope="row">결재업무명</th>
	      	<td colspan="3"><input type="text" id="stext"  name="stext" maxlength="100" title="" style="width:100px;" class="fL" value="" />
	      	</td>
	      	<td><span class="btn_pack large mT5 fR "><a href="#" id="btn_search">검색</a></span>
	      	</td>	      
	    </tr>
	  </table>
  	  
	</div>
    <div class="section mT10" style="height:480px;">
		<!-- 첫번째 목록영역 -->  
		<div class="section mT5 mB10" id="jqGridDiv">
			<table id='jqGrid'></table>
			<div id="jqGridPager" style="text-align:center;"></div>
		</div>              
 
			
						
    </div>
    <div class="btn">
	<span class="btn_pack large"><a href="#" id="btn_confirm" >확인</a></span>
	<span class="btn_pack largeG"><a href="#" id="btn_close">닫기</a></span>
	</div>
</div>
<div id="pageLoading" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:9999;display:none;"></div>
</form>
