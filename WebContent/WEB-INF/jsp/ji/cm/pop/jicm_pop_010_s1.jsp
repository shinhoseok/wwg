<%--
/*=================================================================================*/
/* 시스템            : 공통/ 팝업창관리
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/pop/jicm_pop_010_s1.jsp
/* 프로그램 이름     : jicm_pop_010_s1  
/* 소스파일 이름     : jicm_pop_010_s1.jsp
/* 설명              : 자재마스터 관리 리스트
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2017-02-22
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2017-02-22
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
String sst_regst_ymd = DateUtility.getaddmon(curDate,"-", 2);
%>
<style>
/* .ui-jqgrid .ui-jqgrid-htable th div {
    height:17px;
} */
.th.ui-th-column div {
  height:auto!important;
}
.ui-jqgrid .ui-jqgrid-htable th div {
	white-space:normal!important;
	height:auto!important;
	padding:2px;
}
</style>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<script type="text/javascript" src="<%=con_root%>/smarteditor/js/HuskyEZCreator.js"></script>


<form name="listfrm" id="listfrm" method="post" enctype="multipart/form-data" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="cod_used" id="cod_used" value="" />
	<input type="hidden" name="cod_del" id="cod_del" value="" />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="excel_stdinfo_dtl_cd" id="excel_stdinfo_dtl_cd" value="" title="엑셀다운로드 코드분류 검색조건" />
                                  

<div class="searchArea">
  <table class="tbl_search">
    <colgroup>
    <col width="100" />
    <col width="150" />
    <col width="100" />
    <col width="*" />
    <col width="*" />
    <col width="*" />    
    <col width="*" />
    <col width="150" />
    </colgroup>
    
    <tr>
		<th scope="row">검색조건</th>
		<td >
	        <select name="sty" id="sty" title="검색조건 선택">
	          <option value="">--선택--</option>
	          <option value="bn_title">제목</option>
	          <option value="bn_contents">내용</option>
	        </select>
		</td>	
		<th scope="row">검색어</th>
		<td colspan="4">
			<p class="fL">
	        	<input type="text" name="stext" id="stext" title="검색어 입력"/>
	        </p>
	    </td>
	    <td>
      		<p class="fR mL10">	
      			<span class="btn_pack large vM"><a id="btn_search" href="#none">검색</a></span>
      			<span class="btn_pack largeO vM"><a id="btn_save" href="#none">등록</a></span>
	      	</p>		        
		</td>					   
    </tr>
  </table>
</div>
<!-- end of search -->
<!-- 복합영역 -->
<div class="section mT10">
    <div class="section"> 
	   <div class="section">
	   		  <h3 class="fL"><span>&#8226;</span>팝업 리스트</h3>   
		      <p class="fR">
<!-- 		           <span class="btn_pack medium icon" id="printBtn" ><span class="excel"></span><a href="#none">화면출력</a></span> -->
<!-- 		           <span class="btn_pack medium icon" id="printBtnAll" ><span class="excel"></span><a href="#none">전체출력</a></span> -->
		           <!--<span class="btn_pack medium icon" id="btn_grid_addex_sp">
		        		<span style="position:relative;width:83px;" id="btn_grid_addex">
		        			<span class="add" style="left:2px;position:absolute;"></span>
		        			<a href="#none" style="left:20px;position:absolute;">엑셀업로드</a>  
		        			<input type="file" name="excel_file" id="excel_file" onclick='return chk_auth(event);' onchange='excelfileChange(this);' style="width:70px;height:22px;left:0px;filter:alpha(opacity:0);opacity:0;position:relative;">
		        		</span>
		        	</span>	
		           -->	           
		           
		      </p>
	    </div>		
	    <div id="griddiv" style="width:auto;"><table id='jqGrid' fixwidth="N"></table></div>
	    <div id="jqGridPager" style="text-align:center;"></div>
		

	</div>    
</div>
</form>

<!-- 등록,수정 창  -->
<div id="create_form_popup" class="ly_pop" style="position:absolute;top:0%;left:-800px;z-index:9000;width:740px;display;">
	<h1><span>&#8226;</span>팝업관리</h1><span class="close" id="btn_oh_close_icon" onclick="create_form_close()"><a href="#none;" ></a></span>
	<form name="create_formfm" id="create_formfm" method="post" enctype="multipart/form-data" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
		<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
		<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
		<input type="hidden" name="sidx" value="" title="선택된인덱스" />
		<input type="hidden" name="cod_used" id="cod_used" value="" />
		<input type="hidden" name="cod_del" id="cod_del" value="" />
		<input type="hidden" name="delkey" id="delkey" value="" />
		<input type="hidden" name="ORDER_NOh" id="ORDER_NOh" value="" title="선택된 팝업 원래 순번" />
        
        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>팝업정보-팝업명,기간,팝업링크,순번,팝업이미지,내용,</caption>
            <colgroup>
                <col width="20%" />
                <col width="*" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <thead>
            	<tr>
                	<th scope="row">팝업명</th>
                    <td colspan="3">
                    	<input type="text" name="ibn_title" id="ibn_title" style="width:100%" maxlength="200" />
                    </td>
                </tr>
            	<tr>
                	<th scope="row">기간</th>
                    <td colspan="3">
						<input type="text" name="iuse_st_dt" id="iuse_st_dt" value="<%=curDate.substring(0,4)+"-"+curDate.substring(4,6)+"-"+curDate.substring(6,8)%>" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" title="팝업존시작일 입력" />
						<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('iuse_st_dt'));return false;"></a></span>
						<span class="clear"> ~&nbsp;</span> 
						<input type="text" name="iuse_end_dt" id="iuse_end_dt" value="" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" title="팝업종료일 입력" />
						<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('iuse_end_dt'));return false;"></a></span>
                    </td>
                </tr> 
            	<tr>
                	<th scope="row">팝업링크</th>
                    <td colspan="3">
                    	<input type="text" name="ibn_link" id="ibn_link" style="width:100%" maxlength="200" />
                    </td>
                </tr>                 
            	<tr>
                	<th scope="row">순번</th>
                    <td colspan="3">
                    	<input type="text" name="ibn_order_no" id="ibn_order_no" style="width:50%" maxlength="5" class='aR' style='ime-mode: disabled;' onKeyDown='return onlyNum();'/>
                    </td>
                </tr> 
            	<tr>
                	<th scope="row">팝업이미지</th>
                    <td colspan="3">
                    	<div id="cmfile1"></div>
                    </td>
                </tr>
            	<tr>
                	<th scope="row">내용</th>
                    <td colspan="3" id="editor_top_td" style="background-color:#ffffff">
						<%
						// 에디터 환경설정
						String editor_table_size = "94%";
						String editor_form_content="BN_CONTENTS";
						String editor_cdiv="cdiv";	
						String editor_form_name = "listfrm";
						String editor_dir_path = "/editer";				
						%>   
						<textarea name="<%=editor_form_content %>" id="<%=editor_form_content %>" style="width:100%;min-height:200px;"></textarea>                 
                    </td>
                </tr>
            	<tr>
                    <td scope="row" id="create_form_in_btns" colspan="4">
						<div class="section aC mT5 mB5">
							<span class="btn_pack large" id="btn_create_form_insert"><a href="#none;" onclick="create_form_insert()">등록</a></span>
							<span class="btn_pack large" id="btn_create_form_update"><a href="#none;" onclick="create_form_update()">수정</a></span>
							<span class="btn_pack large" id="btn_create_form_delete"><a href="#none;" onclick="create_form_delete()">삭제</a></span>
							<span class="btn_pack large" id="btn_create_form_close"><a href="#none;" onclick="create_form_close()">닫기</a></span>
						</div>                    
                    </td>                    
                </tr>                
            </thead>
         </table>
	</form>
</div>
<!-- 등록,수정 창  -->

<script type="text/javascript">
//<![CDATA[
var searchYn = false;

var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "<%=editor_form_content %>",
    sSkinURI: "<%=con_root%>/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    htParams: {fOnBeforeUnload:function(){}}	
});

//TODO : $(function()
$(function(){
	
	var file = $.fn.cmfile.init({
		 id				: 'cmfile1' 
		 ,onClickNamefn	: "fileNameClick1"
		 ,img_url 		: "<%=img_url%>"
		 ,uploadcnt		: 1
		 ,extchk		: ['GIF','JPG','BMP','PNG']
	});		
	
	//팝업 리스트
		var cols =[{label:'번호'          	,index:'num_of_rows'     	,name:'num_of_rows'         ,align:'center' 	,width : '50',   	hidden:false, 	sortable : false }
				    ,{label:'팝업명' 	 		,index:'bn_title'       	,name:'bn_title'     	,align:'left' 		,width : '200', 	hidden:false, 	sortable : false }
				    ,{label:'팝업내용'			,index:'bn_contents'     	,name:'bn_contents'    	,align:'left' 		,width : '150', 	hidden:true, 	sortable : false}
				    ,{label:'팝업순번'		 	,index:'bn_order_no'    	,name:'bn_order_no'    	,align:'center' 	,width : '90', 	    hidden:false, 	sortable : false}
				    ,{label:'팝업시작일'		,index:'use_st_dt' 			,name:'use_st_dt'  		,align:'center' 	,width : '100', 	hidden:false, 	sortable : false}
				    ,{label:'팝업종료일'		,index:'use_end_dt'    		,name:'use_end_dt'    	,align:'center' 	,width : '100', 	hidden:false, 	sortable : false}
				    ,{label:'팝업링크'			,index:'bn_link'    		,name:'bn_link'    		,align:'left' 		,width : '180', 	hidden:false, 	sortable : false}
				    ,{label:'등록일자'	 		,index:'reg_dt'     		,name:'reg_dt'    		,align:'center' 	,width : '80', 	    hidden:false, 	sortable : false }
				    ,{label:'등록자ID'	     	,index:'reg_id'     		,name:'reg_id'   		,align:'center'    	,width : '80',      hidden:true, 	sortable : false }
				    ,{label:'등록자'	     	,index:'reg_id_nm'     		,name:'reg_id_nm'   		,align:'center'     ,width : '80',      hidden:false, 	sortable : false }
				    ,{label:'파일명'	     	,index:'file_nms'     		,name:'file_nms'   		,align:'center'    	,width : '80',      hidden:true, 	sortable : false }
				    ,{label:'파일시퀀스'	    ,index:'file_seq'     		,name:'file_seq'   		,align:'center'    	,width : '80',      hidden:true, 	sortable : false }
				    
				    ,{label:'key'	     	,index:'idx'     	,name:'idx'  		,align:'center'     ,width : '1',     	hidden:true }
			    ];
	
		//alert(""+$("#content").width()+"::"+$("#content").height());
		//init grid
		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: 364
			,autowidth : true
			,rowList	: 1000
			,rowNum		: 100
			,shrinkToFit : true
			,scroll 	: 1			
			,gridComplete: function(){
				mergeCellcomplet($(this));
			}
			,loadComplete: function(data){
				// 로드 데이타 갯수 체크
				if(searchYn &&  !isLoadData(data)) return false;
	
			}		
			,onSelectRow: function(id) { // row를 선택했을때 액션.
				
				//var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				//var value1 = ret.matr_seqno; // 이런식으로 값을 가져올 수 있다.
				//alert(value1);
				//refreshsubGrid(value1);
				create_form_view(id);
				
			}
			
			,ondblClickRow: function(id) { // row를 선택했을때 액션.
				var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				//var value1 = ret.stdinfo_dtl_seq; // 이런식으로 값을 가져올 수 있다.	
				//modifyMatr(value1);
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
	    
	    //$("#editor_top_td").find("iframe").height(200);
	    //alert($("#editor_top_td").find("iframe").attr("title"));
	    //alert($("#editor_top_td").find("iframe").height());
	    $("#editor_top_td").height(200);
	

	$("#btn_search").click( function() {
		$('#jqGrid').jqGrid('clearGridData', true);
		refreshGrid();
	});

	
	
		//기준정보 등록 페이지 이동
		$("#btn_save").click(function(e){
			create_form_view("");		
		});
		
		/* 출력 클릭*/
		$("#listfrm").find("#printBtn").click( function() {	

			//console.log("excel_sh_stdinfo_dtl_cd:::==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("XL1");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트");
			$("#pstate").val("L");			
			
			//alert(2);
		});
		
		$("#listfrm").find("#printBtnAll").click( function() {			
			
			//console.log("excel_sh_stdinfo_dtl_cd:::==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("XL1");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트");
			$("#pstate").val("L");

		});	
		
		
		$("#stext").keydown(function(e){
			//alert(e.keyCode);
			if(e.keyCode == 13){
				$('#jqGrid').jqGrid('clearGridData', true);
				refreshGrid();
			}
		});	
		
		// 등록, 수정 객체를 body 에 append한다
		$("body").append($('#create_form_popup'));
		// 등록, 수정 폼 드래그앤 드롭 이동
        $('#create_form_popup').draggable({ opacity:"0.3" }); // 끄는 동안만 불투명도 주기

        $("body").droppable({

            accept: "#create_form_popup",    // 드롭시킬 대상 요소

            drop: function(event, ui) {

            	$('#create_form_popup').css({ opacity:"1.0" });

            }

        });
        
        //$("#sty").multiselect().multiselectfilter();
		CmopenLoading();	
	
		refreshGrid(false); //조회
		setTimeout(grid_win_resizeAuto, 200);
		//setTimeout(CmcloseLoading,800);
		
		
});




//TODO : refreshGrid 
//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	//console.log("111111");
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	//alert($("select[name=smatrtpcd]").length);
	/*if(!isEmpty($("#sst_regst_ymd").val()) && !isEmpty($("#send_regst_ymd").val()) ){
		//alert(parseInt($("#sst_regst_ymd").val()) +"======"+ parseInt($("#send_regst_ymd").val()));
		if(parseInt(StrreplaceAll($("#sst_regst_ymd").val(),"-",""),10) > parseInt(StrreplaceAll($("#send_regst_ymd").val(),"-",""),10) ){
			alert("검색시작일자가 검색종료일자보다 이후이면 안됩니다.");
			return;
		}
		
	}*/
	searchYn = true;
	var params = getGridParamDatas();
	//$("#pstate").val("X");
	//var formparams = $("form[name=listfrm]").serialize();
	var formarr_params = "";
	//alert($("select[name=smatrtpcd]").length);
	
	
	//alert(formarr_params);
	//alert(""+$("select[name=sh_stdinfo_dtl_cd]").length+"::formarr_params:=="+formarr_params);
	//return;
	com.grid.reload('#jqGrid','<c:url value='/cmsajax.do'/>'+formarr_params,params);

	/*$("#jqGrid").jqGrid("setGridParam",{
					 url:'/cmsajax.do'+formarr_params
					,datatype:"json"
					,postData:params
				}).trigger("reloadGrid");*/
	//closeLoading();
	setTimeout(CmcloseLoading,1000);
	//console.log("222222");
}
//TODO : getGridParamDatas 
//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	//$("#pstate").val("X");
	//var _params =  $("form[name=listfrm]").serialize();
	//console.log(_params);
	var _params = com.frm.getParamJSON2(document.listfrm);
	_params.pstate = "XL1";
	
	return _params;
	
}


//TODO : create_form_close 
// 등록 ,수정창 닫기
function create_form_close(){
	$("#create_form_popup").hide();
	create_form_init();
	CmclospageDisable();
}
// TODO : create_form_view 
// 등록 ,수정창 오픈
function create_form_view(grid_id){
	CmopenpageDisable();
	var i = 0;
	
	var sc_pos = 0;
	// 등록 모드이면
	if(grid_id==""){
		sc_pos = 0;

			// 수정, 초기화버튼을 숨긴다
			$("#btn_create_form_update").css("display","none");
			$("#btn_create_form_delete").css("display","none");
			//$("#btn_create_form_init").css("display","none");			
	
	// 수정 모드이면
	}else{
		var ret = $("#jqGrid").jqGrid("getRowData",grid_id); // ret는 선택한 row 값을 쥐고있는 객체다.

		$("form[name=create_formfm]").find('input[name=ibn_title]').val(ret.bn_title);

		$("form[name=create_formfm]").find('input[name=iuse_st_dt]').val(ret.use_st_dt);
		$("form[name=create_formfm]").find('input[name=iuse_end_dt]').val(ret.use_end_dt);

		$("form[name=create_formfm]").find('input[name=ibn_link]').val(ret.bn_link);
		$("form[name=create_formfm]").find('input[name=ibn_order_no]').val(ret.bn_order_no);		
		$("form[name=create_formfm]").find("#<%=editor_form_content%>").val(ret.bn_contents);
		//alert(ret.bn_contents);
  	    oEditors.getById["<%=editor_form_content%>"].exec("LOAD_CONTENTS_FIELD");
		   
		$("form[name=create_formfm]").find('input[name=ORDER_NOh]').val(ret.bn_order_no);
	
		// 수정 키값을 셋팅
		$("form[name=create_formfm]").find('input[name=sidx]').val(ret.idx);
		
		//alert(ret.file_nms+"-------"+ret.file_seq);
		// 첨부파일을 셋팅한다
		var file_group1 = new Array();
		if(ret.file_nms!=""){
			var file_group1_tmp = new Array();
			file_group1_tmp['file_seqno']=ret.file_seq;
			file_group1_tmp['file_nm']=ret.file_nms;
			file_group1.push(file_group1_tmp);
			$.fn.cmfile.setfileList("cmfile1", file_group1);
		}
		//
		//$.fn.cmfile.setfileList("cmfile1", file_group1);		
		
		// 등록버튼을 숨긴다
		$("#btn_create_form_insert").css("display","none");
		
	}

	// 수정, 등록창의 위치를 잡는다
	$("#create_form_popup").css("left",( (($(document).width() - 600) / 2) + $(document).scrollLeft() )+"px");
	$("#create_form_popup").css("top", ((($(document).height() - 500) / 3) + $(document).scrollTop() )+"px");	
	//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);

	
	
	$("#create_form_popup").show(500);
	

}

function create_form_init(){
	$("#btn_create_form_insert").css("display","");
	$("#btn_create_form_update").css("display","");
	$("#btn_create_form_delete").css("display","");
	//$("#btn_create_form_init").css("display","");	
	
		
	$("form[name=create_formfm]").find('input[name=ibn_title]').val("");

	$("form[name=create_formfm]").find('input[name=iuse_st_dt]').val("");
	$("form[name=create_formfm]").find('input[name=iuse_end_dt]').val("");

	$("form[name=create_formfm]").find('input[name=ibn_link]').val("");
	$("form[name=create_formfm]").find('input[name=ibn_order_no]').val("");		
	$("form[name=create_formfm]").find("#<%=editor_form_content%>").val("");

	$("form[name=create_formfm]").find('input[name=ORDER_NOh]').val("");
	// 수정 키값을 셋팅
	$("form[name=create_formfm]").find('input[name=sidx]').val("");	
	
	// 파일객체를 초기화하고 재생성한다
	$("#cmfile1").html("");
	var file = $.fn.cmfile.init({
		 id				: 'cmfile1' 
		 ,onClickNamefn	: "fileNameClick1"
		 ,img_url 		: "<%=img_url%>"
		 ,uploadcnt		: 1
		 ,extchk		: ['GIF','JPG','BMP','PNG']
	});		
}



//TODO : create_form_insert
//코드등록
function create_form_insert(){
	
	/*if($("form[name=create_formfm]").find("#istdinfo_dtl_cd").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_cd").val()) ){
		alert('코드를 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_cd").focus();
		return;
	}*/	
	
	if($("form[name=create_formfm]").find("#ibn_title").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_title").val()) ){
		alert('팝업명을 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_title").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#iuse_st_dt").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iuse_st_dt").val()) ){
		alert('기간 시작일을 입력해 주세요');
		$("form[name=create_formfm]").find("#iuse_st_dt").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#iuse_end_dt").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iuse_end_dt").val()) ){
		alert('기간 종료일을 입력해 주세요');
		$("form[name=create_formfm]").find("#iuse_end_dt").focus();
		return;
	}	
	
	
	// 기간이 둘다 입력된경우 확인
	if(!isEmpty($("form[name=create_formfm]").find("#iuse_st_dt").val()) && !isEmpty($("form[name=create_formfm]").find("#iuse_end_dt").val())){
		if(parseInt(StrreplaceAll($("form[name=create_formfm]").find("#iuse_st_dt").val(), "-",""),10) > parseInt(StrreplaceAll($("form[name=create_formfm]").find("#iuse_end_dt").val(), "-",""),10)){
			alert("기간 시작일이 종료일 이후여야합니다");
			$("form[name=create_formfm]").find("#iuse_st_dt").focus();
			return false;
		}
	}	
	
	if($("form[name=create_formfm]").find("#ibn_link").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_link").val()) ){
		alert('팝업링크를 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_link").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#ibn_order_no").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_order_no").val()) ){
		alert('순번을 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_order_no").focus();
		return;
	}
	
	// textarea에 값 삽입
	oEditors.getById["<%=editor_form_content %>"].exec("UPDATE_CONTENTS_FIELD", []);	

		if(isEmpty($("form[name=create_formfm]").find("#<%=editor_form_content%>").val())){
		   alert('내용을 입력해주세요');
		   return;
		}		
	
	$("form[name=create_formfm]").find("#pstate").val("C");
	var params = jQuery("form[name=create_formfm]").serialize();
	CmLoadingChg_Zindex(9999);
	
	//alert("11111");
	jQuery("#create_formfm").ajaxSubmit({
        type: "post",
        url: "<c:url value='/cmsajax.do'/>",
        data: params,
        dataType:"json",			    	  
	    beforeSubmit:function(data,form,option){
  		  return true;

  	  	},success: function(data){
            if(data.result==true){
        	   	alert('저장 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            refreshGrid();
				create_form_close();
           
           }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
           }



  	  }

    });		
    //alert(params);
	/*jQuery("#create_formfm").ajaxSubmit({
         type: "post",
         url: "<c:url value='/cmsajax.do'/>",
         data: params,
         async: false,
         dataType:"json",
         timeout: 3000,
         error: function (jqXHR, textStatus, errorThrown) {
             // 통신에 에러가 있을경우 처리할 내용(생략가능)
	        	alert("네트웍장애가 발생했습니다. 다시시도해주세요");
	        	CmLoadingChg_Zindex(8000);             
         },
  
         success: function(data){
           if(data.result==true){
        	   	alert('저장 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            refreshGrid();
				create_form_close();
           
           }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
           }
         }

	});*/
}	 

//TODO : create_form_update
//코드수정
function create_form_update(){
	
	if($("form[name=create_formfm]").find("#ibn_title").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_title").val()) ){
		alert('팝업명을 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_title").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#iuse_st_dt").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iuse_st_dt").val()) ){
		alert('기간 시작일을 입력해 주세요');
		$("form[name=create_formfm]").find("#iuse_st_dt").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#iuse_end_dt").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iuse_end_dt").val()) ){
		alert('기간 종료일을 입력해 주세요');
		$("form[name=create_formfm]").find("#iuse_end_dt").focus();
		return;
	}	
	
	
	// 기간이 둘다 입력된경우 확인
	if(!isEmpty($("form[name=create_formfm]").find("#iuse_st_dt").val()) && !isEmpty($("form[name=create_formfm]").find("#iuse_end_dt").val())){
		if(parseInt(StrreplaceAll($("form[name=create_formfm]").find("#iuse_st_dt").val(), "-",""),10) > parseInt(StrreplaceAll($("form[name=create_formfm]").find("#iuse_end_dt").val(), "-",""),10)){
			alert("기간 시작일이 종료일 이후여야합니다");
			$("form[name=create_formfm]").find("#iuse_st_dt").focus();
			return false;
		}
	}	
	
	if($("form[name=create_formfm]").find("#ibn_link").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_link").val()) ){
		alert('팝업링크를 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_link").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#ibn_order_no").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#ibn_order_no").val()) ){
		alert('순번을 입력해 주세요');
		$("form[name=create_formfm]").find("#ibn_order_no").focus();
		return;
	}
	
	// textarea에 값 삽입
	oEditors.getById["<%=editor_form_content %>"].exec("UPDATE_CONTENTS_FIELD", []);	

		if(isEmpty($("form[name=create_formfm]").find("#<%=editor_form_content%>").val())){
		   alert('내용을 입력해주세요');
		   return;
		}	
	
	$("form[name=create_formfm]").find("#pstate").val("U");
	var params = jQuery("form[name=create_formfm]").serialize();
	CmLoadingChg_Zindex(9999);
	
	jQuery("#create_formfm").ajaxSubmit({
        type: "post",
        url: "<c:url value='/cmsajax.do'/>",
        data: params,
        dataType:"json",			    	  
	    beforeSubmit:function(data,form,option){
  		  return true;

  	  	},success: function(data){
            if(data.result==true){
            	alert('수정 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            refreshGrid();
				create_form_close();
           
           }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
           }



  	  }

    });
	
  //alert(params);
  /*
	$.ajax({
       type: "post",
       url: "<c:url value='/cmsajax.do'/>",
       data: params,
       async: false,
       dataType:"json",
       timeout: 3000,
       error: function (jqXHR, textStatus, errorThrown) {
           // 통신에 에러가 있을경우 처리할 내용(생략가능)
	        	alert("네트웍장애가 발생했습니다. 다시시도해주세요");
	        	CmLoadingChg_Zindex(8000);             
       },

       success: function(data){
         if(data.result==true){
      	   	alert('수정 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            refreshGrid();
				create_form_close();
         
         }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
         }
       }

	});*/
}	




//TODO : create_form_delete
//코드삭제
function create_form_delete(){
	if(confirm("삭제하시겠습니까?")){
		$("form[name=create_formfm]").find("#pstate").val("D");
	}else{
		
		return;
	}	
	
	var params = jQuery("form[name=create_formfm]").serialize();
	CmLoadingChg_Zindex(9999);
	
//alert(params);
	$.ajax({
     type: "post",
     url: "<c:url value='/cmsajax.do'/>",
     data: params,
     async: false,
     dataType:"json",
     timeout: 3000,
     error: function (jqXHR, textStatus, errorThrown) {
         // 통신에 에러가 있을경우 처리할 내용(생략가능)
	        	alert("네트웍장애가 발생했습니다. 다시시도해주세요");
	        	CmLoadingChg_Zindex(8000);             
     },

     success: function(data){
       if(data.result==true){
    	   	alert('삭제 되었습니다.');

	            CmLoadingChg_Zindex(8000);
	            refreshGrid();
				create_form_close();
       
       }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
       }
     }

	});
}


//]]>
</script>
