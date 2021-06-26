<%--
/*=================================================================================*/
/* 시스템            : JRCMS 결재관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/apm/jicm_apm_020_s1.jsp 
/* 프로그램 이름     : jicm_apm_020_s1  
/* 소스파일 이름     : jicm_apm_020_s1.jsp
/* 설명              : 공통 기본결재선관리 리스트
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-28
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-04-20
/* 최종 수정내용     : 전력데이터제공 포털시스템에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>

<script language="javascript" src="<%=con_root%>/js/jqGridTablespan.js"></script>
<script type="text/javascript">

$(function(){
	//결재업무 리스트
		var cols =[
		           	 {label:'번호'          ,index:'row_seq'     		 ,name:'row_seq'         	 ,align:'center' ,width : '50',   hidden:false, sortable : false }
					,{label:'결재선 명' 	,index:'bs_aprv_ln_nm'     	 ,name:'bs_aprv_ln_nm' 		 ,align:'left' 	 ,width : '200',  hidden:false, sortable : false, formatter : fm_bs_aprv_ln_nm  }
					,{label:'기본결재선' 	,index:'default_aprv'        ,name:'default_aprv'     	 ,align:'center' ,width : '100',  hidden:true,  sortable : false }
					,{label:'등록일'		,index:'reg_dt'      		 ,name:'reg_dt'      		 ,align:'center' ,width : '100',  hidden:false, sortable : false }
				    ,{label:'수정일'		,index:'mod_dt'      		 ,name:'mod_dt'      		 ,align:'center' ,width : '100',  hidden:true,  sortable : false }
				    ,{label:'비고'		 	,index:'base_aprv_line_desc' ,name:'base_aprv_line_desc' ,align:'center' ,width : '300',  hidden:false, sortable : false }
				    ,{label:'key'	     	,index:'bs_aprv_ln_seqno'    ,name:'bs_aprv_ln_seqno'  	 ,align:'center' ,width : '100',  hidden:true }
								    
			    ]

	//init grid
		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: 350
			,autowidth  : true
			,rowList	: [15,50,100]
			,rowNum		: 15
			,multiselect: false
			,gridComplete: function(){
				mergeCellcomplet($(this));
			}
			,onSelectRow: function(id) { // row를 선택했을때 액션.

				var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				var value1 = ret.bs_aprv_ln_seqno; 	// 이런식으로 값을 가져올 수 있다.

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
	    
	    
		//등록페이지로 이동
		$("#btn_save").click(function(e){

			  su_form=document.listfrm;
			  su_form.method='get';
			  su_form.pstate.value='CF';
			  su_form.action='<%=RequestURL%>';
			  su_form.submit();
			  su_form.target = "";
					  
		});		    

		$("#btn_search").click( function() {

			refreshGrid();

		});
	

	$("#listfrm").find("#btn_print").click( function() {		
		$("#pstate").val("X");
		excelDownload("jqGrid","","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트", "<c:url value='/cmsmain.do'/>");
		$("#pstate").val("<%=pstate%>");
	});	
	
	$("#listfrm").find("#btn_printAll").click( function() {			
		$("#pstate").val("X");
		//엑셀로 저장[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
		excelDownload("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트", "<c:url value='/cmsmain.do'/>");
		$("#pstate").val("<%=pstate%>");

	});		

	refreshGrid(); //조회

});



//결재선 명fm
function fm_bs_aprv_ln_nm(cellvalue, options, rowObject) {
	var url ='';
	if(cellvalue!=undefined && cellvalue!=""){
		url =cellvalue;
		url = '<span class=\'large\' ><a href=\'#\' style=\'color:blue;\' onclick=modifyAprvJobLine(\'' + rowObject.bs_aprv_ln_seqno + '\'); >' + textToHtml(cellvalue)  + '</a></span>';
	}
	
    return url;
}


//결재선 수정화면 이동
function modifyAprvJobLine(key) {
	
	  //기준정보 수정 페이지 이동
	  su_form=document.listfrm;
	  su_form.bs_aprv_ln_seqno.value=key;
	  su_form.method='post';
	  su_form.pstate.value='UF';
	  su_form.action='<%=RequestURL%>';
	  su_form.submit();
	  su_form.target = "";

}


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


/////////////////////////////////////////////////////////////////////////////////////////////////

</script>

<form name="listfrm" id="listfrm" method="post" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="bs_aprv_ln_seqno" id="bs_aprv_ln_seqno" value="" />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="gridId" id="gridId" value="" />
	<input type="hidden" name="JSONDataList" id="JSONDataList" value="" />
	
	<div class="supply_box">                                  
		<div class="searchArea">
		  <table class="tbl_search" border="0" cellspacing="0" cellpadding="0" summary="조건검색 입니다.">
		    <colgroup>
			    <col width="8%" />
			    <col width="80%" />
			    <col width="12%" />
		    </colgroup>
		    <tr>
				<th scope="row">결재선 명</th>
				<td>
					<input type="text" name="stext" id="stext" title="검색어 입력"/>
				</td>
		     	<td>	
					<span class="btn_pack large vM"><a href="#" id="btn_search">검색</a></span>
					<span class="btn_pack largeO vM"><a href="#" id="btn_save">등록</a></span>
				</td>
		    </tr>
		  </table>
		</div>
		
		<div class="mT20 h100">
			<table id='jqGrid' fixwidth="N"></table>
		</div>   
	</div>
</form>


