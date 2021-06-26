<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_020_p1.jsp 
/* 프로그램 이름     : jicm_apm_020_p1  
/* 소스파일 이름     : jicm_apm_020_p1.jsp
/* 설명              : 관리자 선택팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-28
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-03-27
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
	String dto_FUN_FN = HtmlTag.returnString((String)request.getAttribute("dto_FUN_FN"),"");
	String multi_yn = HtmlTag.returnString((String)request.getAttribute("multi_yn"),"Y");
	String check_yn = HtmlTag.returnString((String)request.getAttribute("check_yn"),"Y");
%>
<script language="javascript" src="<%=con_root%>/js/com-tree.js"></script>
<script type="text/javascript">

$(function(){
				var cols =[
				 {label:'담당자SEQ'  ,index:'user_seqno'  	,name:'user_seqno' 	,align:'center' ,width : '50'	,hidden:true,  sortable : false }
			    ,{label:'성명' 	 	  ,index:'user_nm'    	,name:'user_nm'     ,align:'center' ,width : '70'	,hidden:false, sortable : false }
			    ,{label:'아이디' 	  ,index:'user_id'    	,name:'user_id'     ,align:'center' ,width : '60'	,hidden:false, sortable : false }
				,{label:'소속' 	 	  ,index:'org_nm' 		,name:'org_nm'  	,align:'center' ,width : '80'	,hidden:false, sortable : false }
				,{label:'소속코드'   ,index:'org_cd' 		,name:'org_cd'  	,align:'center' ,width : '60'	,hidden:true,  sortable : false }
			    ,{label:'직급' 	 	  ,index:'grd_nm'  		,name:'grd_nm' 		,align:'center' ,width : '60'	,hidden:false, sortable : false }
			    ,{label:'전화번호'   ,index:'naesun'      	,name:'naesun'      ,align:'center' ,width : '60'	,hidden:false, sortable : false }
			    ,{label:'휴대전화'   ,index:'moblphon' 	,name:'moblphon'	,align:'center' ,width : '70'	,hidden:true,  sortable : false }
			    ,{label:'이메일' 	  ,index:'email'        ,name:'email'      	,align:'left'   ,width : '100'	,hidden:false, sortable : false }
			]
	//init grid
	var grid = com.grid.init({
		id			: '#jqGrid'
		,viewrecords: true
		,multiselect: true
		,height		: 380
		,autowidth  : true
		,scroll 	: 1
		,rowList	: [10,50,100]
		,rowNum		: 10
		,gridComplete: function(){
			mergeCellcomplet($(this));
		}
		,onSelectRow: function(id) { // row를 선택했을때 액션.
	
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
	
	refreshGrid(); //조회	
	
	//확인버튼
	$("#btn_confirm").click(function(e){
		var gridArr = new Array();
		var ids = jQuery('#jqGrid').jqGrid('getGridParam', 'selarrrow');

	    if(ids.length==0){
	    	alert('추가할 항목을 선택하세요.');
	    	return;
	    }
	    
	    if(ids.length>1){
	    	alert('1명만 선택하세요.');
	    	return;
	    }
	
	    for(var i=0;i<ids.length;i++){

			gridArr.push($("#jqGrid").jqGrid('getRowData', ids[i]).user_id);	//직원아이디
			gridArr.push($("#jqGrid").jqGrid('getRowData', ids[i]).user_nm);	//직원명
			gridArr.push($("#jqGrid").jqGrid('getRowData', ids[i]).org_cd);		//소속
			gridArr.push($("#jqGrid").jqGrid('getRowData', ids[i]).grd_cd);		//직급

	    }

		opener.<%=dto_FUN_FN%>(gridArr);
		self.close();
	});
	
	//닫기
	$("#btn_close").click(function(e){
		
		self.close();
		
	});
	
});

//조회 : 그리드 조회
function refreshGrid(){
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	var searchresult = new Array();
	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','<%=con_root%>/cmsajax.do',params);
}

 //그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X1';

	return _params;
}

</script>

<form id="listfrm"  name="listfrm" method="post" onSubmit='return false;Go_search();' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" id="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="dto_FUN_FN" value="<%=dto_FUN_FN%>" title="리턴될 함수명"  />
 
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>관리자 선택</h1>
	<div class="desc">
    <div class="section mT10" style="">
			<!-- 트리 영역 -->
		    <!-- 우측영역 구분GrayBg pT5 pR5 pB5-->
		    <div class="section"> 
		        <!-- 첫번째 목록영역 -->
		        <div class="section "><h3><span>&#8226;</span>기관당당자 리스트</h3>
		        </div>
		        <!-- 첫번째 목록영역 -->  
		        <div class="section mT5 mB10" id="jqGridDiv">
				    <table id='jqGrid'></table>      
		        </div>
			</div>
	
			<div id="pageLoading" style="position:absolute;width:100%;height:400px;top:10%;left:3%;z-index:5;display:none;background:url(<%=img_adm_url%>/loading77.gif) no-repeat center;"></div>				
      </div>
    </div>
	<div class="button a_r mar_10">
		<a href="#" id="btn_confirm" class="btn_1 size_s">확인</a>
		<a href="#" id="btn_close" class="btn_2 size_s">닫기</a>
	</div>
</div>

</form>
