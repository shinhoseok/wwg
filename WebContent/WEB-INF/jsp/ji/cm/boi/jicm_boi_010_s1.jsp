<%--
/*=================================================================================*/
/* 시스템            : 공통/ 기준정보
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/boi/jicm_boi_010_s1.jsp 
/* 프로그램 이름     : jicm_boi_010_s1
/* 소스파일 이름     : jicm_boi_010_s1.jsp
/* 설명              : 기준정보 관리 목록
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-10-31
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-05-04
/* 최종 수정내용     : 전력데이터제공포털에 맞게 수정
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
String sst_regst_ymd = DateUtility.getaddmon(curDate,"-", 2);
%>
<style>
/* .ui-jqgrid .ui-jqgrid-htable th div {
    height:17px;
} 
.th.ui-th-column div {
  height:auto!important;
}
.ui-jqgrid .ui-jqgrid-htable th div {
	white-space:normal!important;
	height:auto!important;
	padding:2px;
}*/
</style>
<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<script type="text/javascript" src="<%=con_root%>/js/com-tree-fms.js"></script>
<script type="text/javascript">
//<![CDATA[
var searchYn = false;
//TODO : $(function()
$(function(){
	
	// 코드트리
	var cmtreeval = new Array();

	//init tree
	$.fn.cmtree({
		 id			: '#cmtree_data' 
		 ,treeAreaId : "#treeArea"
		 ,treeMenuId : "#treeMenu"
		 ,treeHeight : ($("#content").height()-40)+"px"
		 ,treeWidth  : "250px"
		 ,treemHeight : ($("#content").height()-80)+"px"
		 ,treemWidth : "210px"	 
		 ,checkBoxYn: false
		 ,treeArr   : cmtreeval
		 ,setAllYn : false
		 ,onClickTitlefn: "treeClickTitle01"
		 ,treeRelComboId : "sh_sel_group"
		 ,treeRelComboboxId : "sh_stdinfo_dtl_cd"
		 ,treeImgPath : "<%=img_url%>"
	});	
	
	//코드 리스트
		var cols =[{label:'번호'          	,index:'row_seq'     			,name:'row_seq'         		,align:'center' 	,width : '50',   	hidden:false, 	sortable : true }
				    ,{label:'코드' 	 		,index:'stdinfo_dtl_cd'     	,name:'stdinfo_dtl_cd'      	,align:'center' 	,width : '90', 	    hidden:false, 	sortable : true }
				    ,{label:'코드명' 	 		,index:'stdinfo_dtl_nm'       	,name:'stdinfo_dtl_nm'     		,align:'left' 		,width : '180', 	hidden:false, 	sortable : true }
				    ,{label:'코드라벨'			,index:'stdinfo_dtl_label'     	,name:'stdinfo_dtl_label'    	,align:'left' 		,width : '180', 	hidden:false, 	sortable : false}
				    ,{label:'상위코드'		 	,index:'stdinfo_dtl_uppo_cd'    ,name:'stdinfo_dtl_uppo_cd'    	,align:'center' 	,width : '90', 	    hidden:false, 	sortable : false}
				    ,{label:'상위코드명'		,index:'stdinfo_dtl_uppo_cd_nm' ,name:'stdinfo_dtl_uppo_cd_nm'  ,align:'left' 		,width : '180', 	hidden:false, 	sortable : false}
				    ,{label:'코드그룹코드'		,index:'stdinfo_cd'    			,name:'stdinfo_cd'    			,align:'center' 	,width : '90', 		hidden:false, 	sortable : false}
				    ,{label:'코드그룹명'		,index:'stdinfo_cd_nm'    		,name:'stdinfo_cd_nm'    		,align:'left' 		,width : '180', 	hidden:false, 	sortable : false}
				    ,{label:'정렬순번'			,index:'order_no'    			,name:'order_no'    			,align:'left' 		,width : '100', 	hidden:false, 	sortable : true}
				    ,{label:'등록일자'	 		,index:'reg_dt'     			,name:'reg_dt'    				,align:'center' 	,width : '80', 	    hidden:false, 	sortable : true }
				    ,{label:'등록자ID'	     	,index:'reg_id'     			,name:'reg_id'   				,align:'center'    	,width : '80',      hidden:true, 	sortable : false }
				    ,{label:'등록자'	     	,index:'reg_nm'     			,name:'reg_nm'   				,align:'center'     ,width : '80',      hidden:false, 	sortable : false }
				    ,{label:'참조정보1'	    ,index:'stdinfo_dtl_data1'     	,name:'stdinfo_dtl_data1' 		,align:'center'     ,width : '100',      hidden:false, 	sortable : false }
				    ,{label:'참조정보2'	    ,index:'stdinfo_dtl_data2'     	,name:'stdinfo_dtl_data2' 		,align:'center'     ,width : '100',      hidden:false, 	sortable : false }
				    ,{label:'참조정보3'	    ,index:'stdinfo_dtl_data3'     	,name:'stdinfo_dtl_data3' 		,align:'center'     ,width : '100',      hidden:false, 	sortable : false }
				    ,{label:'참조정보4'	    ,index:'stdinfo_dtl_data4'     	,name:'stdinfo_dtl_data4' 		,align:'center'     ,width : '100',      hidden:false, 	sortable : false }
				    ,{label:'참조정보5'	    ,index:'stdinfo_dtl_data5'     	,name:'stdinfo_dtl_data5' 		,align:'center'     ,width : '100',      hidden:false, 	sortable : false }
				    
				    ,{label:'key'	     	,index:'stdinfo_dtl_seq'     	,name:'stdinfo_dtl_seq'  		,align:'center'     ,width : '1',     	hidden:true }
				    ,{label:'key'	     	,index:'code_nms'     			,name:'code_nms'  		,align:'center'     ,width : '1',     	hidden:true }
				    ,{label:'key'	     	,index:'code_cs'     			,name:'code_cs'  		,align:'center'     ,width : '1',     	hidden:true }
			    ];
	
		//alert(""+$("#content").width()+"__"+$("#content").height());
		//init grid
		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: $("#treeArea").height()-60
			,autowidth : true
			,rowList	: 1000
			,rowNum		: 100
			,shrinkToFit : false
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
	    /* $("#jqGrid").jqGrid('setGroupHeaders',{
			useColSpanStyle: true,    // 셀병합 여부(Group 대상 제외)
		    groupHeaders:[            // 명명한 컬럼으로 부터 n개까지 병합(Group 대상)
		                {startColumnName: 'chk_cycl_250_qty', numberOfColumns: 5, titleText: '<font color="black">'+'예방점검 1회 교체수량'+'</font>'}
		               ]
		}); */	    
	    
	    
	    /*  필드별 검색어 입력창을 숨기거나 보여지게한다. */    
	    //jQuery("#jqGrid").jqGrid('navButtonAdd',"#jqGridPager",{caption:"Toggle",title:"Toggle Search Toolbar", buttonicon :'ui-icon-pin-s',
	    //    onClickButton:function(){
	    //    	grid[0].toggleToolbar();
	    //    } 
	    //});

	    /* 각 필드별 검색어 입력창에 입력된 내용를 지운다. */
	    //jQuery("#jqGrid").jqGrid('navButtonAdd',"#jqGridPager",{caption:"Clear",title:"Clear Search",buttonicon :'ui-icon-refresh',
	    //    onClickButton:function(){
	    //    	grid[0].clearToolbar();
	    //    } 
	    //});
	    /*  필드별 검색어 입력창 */    
		//jQuery("#jqGrid").jqGrid('navGrid','#ptoolbar',{del:false,add:false,edit:false,search:false});
		//jQuery("#jqGrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});
	
	
	

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
			// 배열객체의 경우 엑셀다운로드시 조건이 넘어가지 않아서 따로 처리
			
			if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()==""){
				if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=undefined
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=null
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=""){
					//console.log("__:==>"+$("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val());
					$("#excel_stdinfo_dtl_cd").val($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val());
				}else{
					$("#excel_stdinfo_dtl_cd").val("");
				}
				
			}else{
				if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=undefined
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=null
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=""){
					//console.log("__:==>"+$("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val());
					$("#excel_stdinfo_dtl_cd").val($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val());
				}else{
					$("#excel_stdinfo_dtl_cd").val("");
				}				

			}
			//console.log("excel_sh_stdinfo_dtl_cd__:==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("XL1");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid",""," 화면리스트");
			$("#pstate").val("L");			
			
			//alert(2);
		});
		
		$("#listfrm").find("#printBtnAll").click( function() {			
			

			// 배열객체의 경우 엑셀다운로드시 조건이 넘어가지 않아서 따로 처리
			
			if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()==""){
				if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=undefined
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=null
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val()!=""){
					//console.log("__:==>"+$("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val());
					$("#excel_stdinfo_dtl_cd").val($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-2).val());
				}else{
					$("#excel_stdinfo_dtl_cd").val("");
				}
				
			}else{
				if($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=undefined
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=null
						&& $("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val()!=""){
					//console.log("__:==>"+$("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val());
					$("#excel_stdinfo_dtl_cd").val($("select[name=sh_stdinfo_dtl_cd]").eq($("select[name=sh_stdinfo_dtl_cd]").length-1).val());
				}else{
					$("#excel_stdinfo_dtl_cd").val("");
				}				

			}
			//console.log("excel_sh_stdinfo_dtl_cd__:==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("XL1");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid","A"," 전체리스트");
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
		refreshTree();//트리조회
		// 자재분류 셀렉트 박스를 만든다
		$.fn.cmtree.treeRelComboboxMake('','', 0);	
	
		refreshGrid(false); //조회
		setTimeout(grid_win_resizeAuto, 200);
		//setTimeout(CmcloseLoading,800);
		
		
});


//TODO : gridEventRemove 
//그리드 이벤트를 지워준다
function gridEventRemove(gridid){
	$("#"+gridid+"").find(".jqgrow").mouseover(function(e){
		var row_id = $(this).attr("id");
		//alert(row_id);
		$("#"+gridid+"").jqGrid('setRowData',row_id,false,{color:"#454545",background:"#FFFFFF",border:"1px solid #e4e4e4"})
		//$("#jqGrid").setRowData(row_id,false,{background:"#FFFFFF",border:"1px solid #e4e4e4"});
		//$(this).css("background","#FFFFFF");
		//$(this).css("border","1px solid #e4e4e4");
	});
	


	$("#"+gridid+"").find(".jqgrow").click(function(e){
		var row_id = $(this).attr("id");
		$("#"+gridid+"").jqGrid('setRowData',row_id,false,{color:"#454545",background:"#FFFFFF",border:"1px solid #e4e4e4"})
		//$("#jqGrid").setRowData(row_id,false,{background:"#FFFFFF",border:"1px solid #e4e4e4"});
		//$(this).css("background","#FFFFFF");
		//$(this).css("border","1px solid #e4e4e4");
	});
	
	$("#"+gridid+"").find(".jqgrow").dblclick(function(e){
		var row_id = $(this).attr("id");
		$("#"+gridid+"").jqGrid('setRowData',row_id,false,{color:"#454545",background:"#FFFFFF",border:"1px solid #e4e4e4"})
		//$("#jqGrid").setRowData(row_id,false,{background:"#FFFFFF",border:"1px solid #e4e4e4"});
		//$(this).css("background","#FFFFFF");
		//$(this).css("border","1px solid #e4e4e4");
	});	
	

	
}



//TODO : refreshTree 
//조회 : 트리조회
function refreshTree(){
		
	//alert('refreshTree');
	$("#pstate").val("XL4");
	var params =  $("form[name=listfrm]").serialize();
	//var params = jQuery('form').serialize();
	//var params = com.frm.getParamJSON(document.listfrm);
	//alert(params);
	$.fn.cmtree.reload('#cmtree_data','<c:url value='/cmsajax.do'/>',params);
	
}
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
	

	
	// 배열 객체의 경우 따로 get파라메터로 만들어서 보낸다
	if($("select[name=sh_stdinfo_dtl_cd]").length>0){
		formarr_params = "";
		for(var i=0;i<$("select[name=sh_stdinfo_dtl_cd]").length;i++){
			//alert("sel "+i+" val:=="+$("select[name=sh_stdinfo_dtl_cd]").eq(i).val());
			if(i==0){
				formarr_params = formarr_params + "?se_stdinfo_dtl_cd="+$("select[name=sh_stdinfo_dtl_cd]").eq(i).val();
			}else{
				formarr_params = formarr_params + "&se_stdinfo_dtl_cd="+$("select[name=sh_stdinfo_dtl_cd]").eq(i).val();
			}
			
		}
	}
	//
	//var params = $("#listfrm").serializeJSON();
	
	//alert(formarr_params);
	//alert(""+$("select[name=sh_stdinfo_dtl_cd]").length+"__formarr_params:=="+formarr_params);
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
//TODO : treeClickTitle01
function treeClickTitle01(rtnArr){
	//console.log("boi jsp:--"+rtnArr[6]+"--"+rtnArr[4]+"--"+rtnArr[2]);
	//0: TREE_SEQ, 1: TREE_CD, 2: TREE_NM, 3:TREE_UPPO_CD, 4: TREE_LEVEL, 5: TREE_NMS, 6: TREE_CDS, 7: TREE_SUB_CNT
	//$.fn.cmtree.treeRelComboboxSet(rtnArr[1], rtnArr[4]);
	//$.fn.cmtree.treeRelComboboxMake(rtnArr[1],'', rtnArr[4]);
	
	//$.fn.cmtree.selTreeParentAll(rtnArr[1], rtnArr[4]);//조직트리 해당 조직으로 선택
	$.fn.cmtree.selTreeParentAll(rtnArr[6], rtnArr[4]);//조직트리 해당 조직으로 선택
	//$.fn.cmtree.selTreeParentAll2(rtnArr[6]);
	optionGroupToTree(rtnArr[6], rtnArr[4]);
	//$.fn.cmtree.treeRelComboboxMake(rtnArr[1],'', rtnArr[1]);
	/*
		var alinkidobj=$("#tree_link_"+rtnArr[6]);
		var thislink = alinkidobj.parent().children("img");
		thislink.trigger("click");	
	*/
	
	
	//
	//insertfInit();
}

function optionGroupToTree(tree_cds, tree_level){
	/*// 역으로 찾아가며 처리한다
	var ogi = 0;
	//alert(tree_cds+"---"+tree_level);
	var tree_cds_sp = tree_cds.split("__");

	var bar_pos = tree_cds.indexOf("__");
	var tree_set_id = "";
	for(ogi=0;ogi<tree_cds_sp.length;ogi++){
		if(tree_cds_sp.length==1){
			tree_set_id = tree_cds;
		}else{
			tree_set_id = tree_cds.substring(0,bar_pos);
		}
		
		if(ogi < tree_cds_sp.length-1){
			bar_pos = tree_set_id.length+2+tree_cds_sp[ogi+1].length;
		}else{
			bar_pos = tree_cds.length;
		}
		
		
		console.log("ogi---:"+ogi+":"+tree_cds+":"+bar_pos+":tree_set_id---:"+tree_set_id);
		$("select[name='sh_stdinfo_dtl_cd']").eq(ogi).val(tree_set_id);
		optionGroup($("select[name='sh_stdinfo_dtl_cd']").eq(ogi), ogi+1, "N", "", "N");
		
		
	}*/
	$.fn.cmtree.treeRelComboboxSet(tree_cds, tree_level);
	$.fn.cmtree.treeRelComboboxMake(tree_cds,'', tree_level);
	
	
	// 그리드 조회
	refreshGrid(false); //조회	
}

// TODO : optionGroup
function optionGroup($this, lev, treeyn, treecode, gridreloadyn){
	//alert($this.attr("id"));
	/*if(treeyn=="Y"){
		$this.val(treecode);
		$.fn.cmtree.treeRelComboboxMake(treecode,'', lev);//하위 셀렉트박스 생성
		$.fn.cmtree.selTreeParentAll(treecode, lev);//트리 해당 코드로 선택			
	}else{
		if(isEmpty($this.val())){
			if(lev>1){
				//alert($("select[name='smatrtpcd']").eq(lev-2).val()+"----"+(lev-2));
				$.fn.cmtree.treeRelComboboxMake($("select[name='sh_stdinfo_dtl_cd']").eq(lev-2).val(),'', lev-1);//하위 셀렉트박스 생성
				
				$.fn.cmtree.selTreeParentAll($("select[name='sh_stdinfo_dtl_cd']").eq(lev-2).val(), lev-1);//조직트리 해당 조직으로 선택					
			}else{
				$.fn.cmtree.treeRelComboboxMake($this.val(),'', lev);//하위 셀렉트박스 생성
				
				$.fn.cmtree.selTreeParentAll($this.val(), lev);//조직트리 해당 조직으로 선택				
			}
		
		}else{
			$.fn.cmtree.treeRelComboboxMake($this.val(),'', lev);//하위 셀렉트박스 생성
			
			$.fn.cmtree.selTreeParentAll($this.val(), lev);//조직트리 해당 조직으로 선택			
		}
			
	}*/
	$.fn.cmtree.treeRelComboboxSet($this.val(), lev);
	$.fn.cmtree.treeRelComboboxMake($this.val(),'', lev);
	$.fn.cmtree.selTreeParentAll2($this.val(), lev);
	
	var opt_i = 0;
	var opts_str = "";
	// 현재 선택된 마지막 분류코드를 불러온다
	var selmatrtpcd = "";
	var selmatrtpcd_lev = "";
	var selmatrtpcd_lev4 = "";
	if($("select[name='sh_stdinfo_dtl_cd']").eq($("select[name='sh_stdinfo_dtl_cd']").length-1).val() == ""){
		selmatrtpcd = $("select[name='sh_stdinfo_dtl_cd']").eq($("select[name='sh_stdinfo_dtl_cd']").length-2).val();
	}else{
		selmatrtpcd = $("select[name='sh_stdinfo_dtl_cd']").eq($("select[name='sh_stdinfo_dtl_cd']").length-1).val();
	}
	
	// 그리드 조회
	if(gridreloadyn!="N"){
		refreshGrid(false); //조회
	}
	

}





//TODO : chk_auth 
function chk_auth(evt){
	<%//if(!SS_admin.equals("Y")){ %>
		<%//if(!SS_authC.equals("Y")){ %>
		alert("엑셀업로드권한이 없습니다.!!");
		if(window.event){
			  event.returnValue=false; //IE , - Chrome both 
		}else{ 
			  evt.preventDefault(); //FF , - Chrome both 
		}		
		
		return false;
		<%//}%>
	<%//}%>	
}

//TODO : excelfileChange 
function excelfileChange(obj){
	var agt = navigator.userAgent.toLowerCase();
	if (agt.indexOf("msie") != -1) brow_kind =  'Internet Explorer'; 
	var val = $(obj).val().split("\\");
	var filename = val[val.length-1];
	var fileType = "";
	var fileType_chk = false;
	fileType = filename.substring(filename.lastIndexOf(".")+1,filename.length);
	fileType = fileType.toUpperCase();
	if(fileType=="XLS" || fileType=="XLSX"){
		fileType_chk = true;
	}
	
	if(fileType_chk==false){
		alert("엑셀파일만 업로드 가능합니다");
		$(obj).remove();
		
		$("#btn_grid_addex").append("<input type='file' name='excel_file' id='excel_file' onclick='return chk_auth(event);' onchange='excelfileChange(this);' class='fL' style='width:68px;height:24px;filter:alpha(opacity:0);opacity:0;left:2px;position:relative;'>");
	// 파일을 업로드 한후 데이터를 바인딩한다
	}else{
		var params;
		//console.log("66666666:=="+getlogTime());
		$("#pstate").val("EXCELUPLOAD");
		//CmopenLoading();
		/*$("#excel_file").select();
		document.selection.clear();
		document.cffrm.submit();*/
		
		//console.log("555555555:=="+getlogTime());
		//return;	
		
		$('#jqGrid').jqGrid('clearGridData', true);

		CmopenLoading();
		jQuery("#listfrm").ajaxSubmit({
          type: "post",
          url: "/cmsajax.do",
          data: params,
          dataType:"json",			    	  
    	  beforeSubmit:function(data,form,option){
    		  ////console.log('33333');
    		  return true;
    	  },success: function(data){
               if(data.result==true){
            	    alert("수정되었습니다.");
           			$(obj).remove();
            	   	refreshGrid();            	   
 					
	           }else{
	            	alert(data.TRS_MSG);
           			$(obj).remove();
 	        		$("#btn_grid_addex").append("<input type='file' name='excel_file' id='excel_file' onclick='return chk_auth(event);' onchange='excelfileChange(this);' class='fL' style='width:68px;height:24px;filter:alpha(opacity:0);opacity:0;left:2px;position:relative;'>");
	            	
	           }
               setTimeout(CmcloseLoading,400);

    	  }
      	});		
		//console.log("555555555:=="+getlogTime());
		//$("#btn_grid_addex2").trigger("click");
		//setTimeout(excelupload,200);
		//console.log("555555555:=="+getlogTime());
		
	}
	
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
		// 현재 선택된 코드 분류를 가져온다
		last_code = "";
		last_code_nm = "";
		if($("select[name=sh_stdinfo_dtl_cd]").length>0){
			for(i=0;i<$("select[name=sh_stdinfo_dtl_cd]").length;i++){
				//alert("sel "+i+" val:=="+$("select[name=sh_stdinfo_dtl_cd]").eq(i).val());
				// 코드그룹셋팅
				if(i==0){
					if($("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").val()!=""){
						$("form[name=create_formfm]").find('input[name=istdinfo_cd]').val($("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").val());
						$("form[name=create_formfm]").find('input[name=istdinfo_cd_nm]').val($("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").text());
					}
				}
				
				if($("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").val()!=""){
					last_code = $("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").val();
					last_code_nm = $("select[name=sh_stdinfo_dtl_cd]").eq(i).children("option:selected").text();
				}
				
				
			}
			//alert($("form[name=create_formfm]").find('input[name=istdinfo_cd]').val());
			// 상위코드셋팅
			$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd]').val(last_code);
			$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd_nm]').val(last_code_nm);
			// 수정, 초기화버튼을 숨긴다
			$("#btn_create_form_update").css("display","none");
			$("#btn_create_form_delete").css("display","none");
			//$("#btn_create_form_init").css("display","none");			
		}else{
			alert("코드분류가 생성되지않았습니다");
			create_form_close();
		}	
	// 수정 모드이면
	}else{
		var ret = $("#jqGrid").jqGrid("getRowData",grid_id); // ret는 선택한 row 값을 쥐고있는 객체다.
		// 코드그룹셋팅
		$("form[name=create_formfm]").find('input[name=istdinfo_cd]').val(ret.stdinfo_cd);
		$("form[name=create_formfm]").find('input[name=istdinfo_cd_nm]').val(ret.stdinfo_cd_nm);
		// 상위코드셋팅
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd]').val(ret.stdinfo_dtl_uppo_cd);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd_nm]').val(ret.stdinfo_dtl_uppo_cd_nm);
		
		var code_cs = ret.code_cs.replace(/::/gi,'__');
		//var code_cs_sp = code_cs.split("__");
		//code_cs_sp= code_cs_sp.reverse();
		//code_cs_sp.join("__")
		
		$("form[name=create_formfm]").find('input[name=selcode_cs]').val(code_cs.substring(0,code_cs.lastIndexOf("__")));
		
		// 코드 셋팅
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_cd]').val(ret.stdinfo_dtl_cd);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_cd_nm]').val(ret.stdinfo_dtl_nm);		
		// 코드라벨
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_label]').val(ret.stdinfo_dtl_label);
		// 코드순번
		$("form[name=create_formfm]").find('input[name=iorder_no]').val(ret.order_no);
		$("form[name=create_formfm]").find('input[name=ORDER_NOh]').val(ret.order_no);
		
		// 참조정보 1~5셋팅
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data1]').val(ret.stdinfo_dtl_data1);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data2]').val(ret.stdinfo_dtl_data2);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data3]').val(ret.stdinfo_dtl_data3);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data4]').val(ret.stdinfo_dtl_data4);
		$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data5]').val(ret.stdinfo_dtl_data5);		
		
		// 수정 키값을 셋팅
		$("form[name=create_formfm]").find('input[name=sidx]').val(ret.stdinfo_dtl_seq);
		
		// 등록버튼을 숨긴다
		$("#btn_create_form_insert").css("display","none");
		
	}

	// 수정, 등록창의 위치를 잡는다
	$("#create_form_popup").css("left",( (($(document).width() - 600) / 2) + $(document).scrollLeft() )+"px");
	$("#create_form_popup").css("top", ((($(document).height() - 500) / 2) + $(document).scrollTop() )+"px");	
	//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);

	
	
	$("#create_form_popup").show(500);
	

}

function create_form_init(){
	$("#btn_create_form_insert").css("display","");
	$("#btn_create_form_update").css("display","");
	$("#btn_create_form_delete").css("display","");
	//$("#btn_create_form_init").css("display","");	
	// 코드그룹셋팅
	$("form[name=create_formfm]").find('input[name=istdinfo_cd]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_cd_nm]').val("");
	// 상위코드셋팅
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_uppo_cd_nm]').val("");
	// 코드 셋팅
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_cd]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_cd_nm]').val("");		
	// 코드라벨
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_label]').val("");
	// 코드순번
	$("form[name=create_formfm]").find('input[name=iorder_no]').val("");
	$("form[name=create_formfm]").find('input[name=ORDER_NOh]').val("");
	// 수정 키값을 셋팅
	$("form[name=create_formfm]").find('input[name=sidx]').val("");	
	
	// 참조정보 1~5셋팅
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data1]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data2]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data3]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data4]').val("");
	$("form[name=create_formfm]").find('input[name=istdinfo_dtl_data5]').val("");
	
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
	
	if($("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").val()) ){
		alert('코드명을 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#istdinfo_dtl_label").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_label").val()) ){
		alert('코드라벨을 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_label").focus();
		return;
	}	
	
	/*if($("form[name=create_formfm]").find("#iorder_no").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iorder_no").val()) ){
		alert('코드순번을 입력해 주세요');
		$("form[name=create_formfm]").find("#iorder_no").focus();
		return;
	}*/	
	
	$("form[name=create_formfm]").find("#pstate").val("C");
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
        	   	alert('저장 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            // 저장처리후 트리와 리스트를 재조회한다
	            //console.log("111");
				refreshTree();//트리조회
				//console.log("222");
				// 코드분류 셀렉트 박스를 만든다
				var tree_arr = $.fn.cmtree.rtnTreeArr($("form[name=create_formfm]").find("#istdinfo_dtl_uppo_cd").val());
				//alert($("form[name=create_formfm]").find("#istdinfo_dtl_uppo_cd").val()+'__'+tree_arr[1]);
				//console.log("333");
				$.fn.cmtree.delay(100);
				//console.log("444");
				//console.log("555"+tree_arr[6]);
				$.fn.cmtree.selTreeParentAll(tree_arr[6], tree_arr[4]);
				$.fn.cmtree.onClickTreeTitle(tree_arr[6]);
				
				//$.fn.cmtree.onClickTreeChecked(tree_arr[1]);
				create_form_close();
           
           }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
           }
         }

	});
}	 

//TODO : create_form_update
//코드수정
function create_form_update(){
	
	if($("form[name=create_formfm]").find("#istdinfo_dtl_cd").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_cd").val()) ){
		alert('코드를 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_cd").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").val()) ){
		alert('코드명을 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_cd_nm").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#istdinfo_dtl_label").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#istdinfo_dtl_label").val()) ){
		alert('코드라벨을 입력해 주세요');
		$("form[name=create_formfm]").find("#istdinfo_dtl_label").focus();
		return;
	}	
	
	if($("form[name=create_formfm]").find("#iorder_no").val()==""
		|| isEmpty($("form[name=create_formfm]").find("#iorder_no").val()) ){
		alert('코드순번을 입력해 주세요');
		$("form[name=create_formfm]").find("#iorder_no").focus();
		return;
	}	
	
	$("form[name=create_formfm]").find("#pstate").val("U");
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
      	   	alert('수정 되었습니다.');
	            CmLoadingChg_Zindex(8000);
	            // 저장처리후 트리와 리스트를 재조회한다
				refreshTree();//트리조회
				$.fn.cmtree.delay(100);
				//console.log("code_cs---"+$("form[name=create_formfm]").find("#selcode_cs").val());
				// 코드분류 셀렉트 박스를 만든다
				var tree_arr = $.fn.cmtree.rtnTreeArr($("form[name=create_formfm]").find("#selcode_cs").val());
				//alert($("form[name=create_formfm]").find("#istdinfo_dtl_uppo_cd").val()+'__'+tree_arr[1]);
				
				//console.log("tree_arr---"+tree_arr);
				$.fn.cmtree.selTreeParentAll(tree_arr[6], tree_arr[4]);
				$.fn.cmtree.onClickTreeTitle(tree_arr[6]);
				//$.fn.cmtree.onClickTreeChecked(tree_arr[1]);
				create_form_close();
         
         }else{
	        	alert(data.TRS_MSG);
	        	CmLoadingChg_Zindex(8000);
	        	
         }
       }

	});
}	




//TODO : create_form_delete
//코드삭제
function create_form_delete(){
	if(confirm("코드를 삭제하시겠습니까?\r\n삭제할코드의 하위코드도 함께삭제됩니다.")){
		$("form[name=create_formfm]").find("#pstate").val("D");
	}else{
		Go_initin();
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
	            // 저장처리후 트리와 리스트를 재조회한다
				refreshTree();//트리조회
				$.fn.cmtree.delay(100);
				//console.log("code_cs---"+$("form[name=create_formfm]").find("#selcode_cs").val());
				// 코드분류 셀렉트 박스를 만든다
				var tree_arr = $.fn.cmtree.rtnTreeArr($("form[name=create_formfm]").find("#selcode_cs").val());
				//alert($("form[name=create_formfm]").find("#istdinfo_dtl_uppo_cd").val()+'__'+tree_arr[1]);
				
				//console.log("tree_arr---"+tree_arr);
				$.fn.cmtree.selTreeParentAll(tree_arr[6], tree_arr[4]);
				$.fn.cmtree.onClickTreeTitle(tree_arr[6]);
				//$.fn.cmtree.onClickTreeChecked(tree_arr[1]);
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

			<th scope="row">코드분류</th>
			<td id="sh_sel_group" colspan="6">
				<select name="sh_stdinfo_dtl_cd" id="sh_stdinfo_dtl_cd" onchange="optionGroup($(this), 1,'N','')" style="vertical-align: middle;" title="코드분류">
					<option value="">--선택--</option>
				</select>			

			</td>
			<td>&nbsp;</td>
    </tr>
    
    <tr>

			
			<th scope="row">검색조건</th>
			<td >
		        <select name="sty" id="sty" title="검색조건">
		          <option value="">--선택--</option>
		          <option value="stdinfo_dtl_nm">코드명</option>
		          <option value="stdinfo_dtl_cd">코드</option>
		          <option value="stdinfo_dtl_label">코드라벨</option>
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
	<!-- 트리 영역 -->
	
	<div class="treeArea" id="treeArea">
		<p class="tit round fL"><a href="#" >코드분류</a>
		</p>
		<div class="treeMenu round fL mR10" id="treeMenu">
			<ul id="cmtree_data">
			</ul>
		</div>
	</div>
	<!-- 트리 영역 // -->     
    <!-- 우측영역 구분 -->
    <div class="section"> 
		 
	   <div class="section">
	   		  <h3 class="fL"><span>&#8226;</span>코드 리스트</h3>   
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
	    <div id="griddiv" style="width:auto;"><table id='jqGrid' minuswh="270" fixwidth="N"></table></div>
	    <div id="jqGridPager" style="text-align:center;"></div>
		

	</div>    
</div>
</form>

<!-- 등록,수정 창  -->
<div id="create_form_popup" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9000;width:600px;display:none;">
	<h1><span>&#8226;</span>코드관리</h1><span class="close" id="btn_oh_close_icon" onclick="create_form_close()"><a href="#none;" ></a></span>
	<form name="create_formfm" method="post" onSubmit='return false;'>
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="cod_used" id="cod_used" value="" />
	<input type="hidden" name="cod_del" id="cod_del" value="" />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="selcode_cs" id="selcode_cs" value="" />
	<input type="hidden" name="ORDER_NOh" id="ORDER_NOh" value="" title="선택된 코드 원래 순번" />
		
	
	
        
        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>코드정보-코드그룹,상위코드,코드,코드명,코드라벨,코드순번,참조정보1,참조정보2,참조정보3,참조정보4,참조정보5</caption>
            <colgroup>
                <col width="20%" />
                <col width="*" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <thead>
            	<tr>
                	<th scope="row">코드그룹
                    </th>
                    <td><input type="hidden" name="istdinfo_cd" id="istdinfo_cd" />
                    <input type="text" name="istdinfo_cd_nm" id="istdinfo_cd_nm" style="width:100%" class="ronly" maxlength="200" readOnly />
                    </td>
                                	
                	<th scope="row">상위코드
                    </th>
                    <td><input type="hidden" name="istdinfo_dtl_uppo_cd" id="istdinfo_dtl_uppo_cd" />
                    <input type="text" name="istdinfo_dtl_uppo_cd_nm" id="istdinfo_dtl_uppo_cd_nm" class="ronly" style="width:100%" maxlength="200" readOnly />
                    </td>
                     
                </tr>
                
            	<tr>
                	<th scope="row">코드
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_cd" id="istdinfo_dtl_cd" style="width:96%" maxlength="10" />
                    </td>
                                	
                	<th scope="row">코드명
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_cd_nm" id="istdinfo_dtl_cd_nm" style="width:96%" maxlength="200" />
                    </td>
                    
                </tr>  
                
            	<tr>
                	<th scope="row">코드라벨
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_label" id="istdinfo_dtl_label" style="width:96%" maxlength="200" />
                    </td>
                                	
                	<th scope="row">코드순번
                    </th>
                    <td>
                    <input type="text" name="iorder_no" id="iorder_no" style="width:96%" maxlength="5" class='aR' style='ime-mode: disabled;' onKeyDown='return onlyNum();'/>
                    </td>
                    
                </tr> 
                
            	<tr>
                	<th scope="row">참조정보1
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_data1" id="istdinfo_dtl_data1" style="width:96%" maxlength="500" />
                    </td>
                                	
                	<th scope="row">참조정보2
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_data2" id="istdinfo_dtl_data2" style="width:96%" maxlength="500" />
                    </td>
                    
                </tr>   
                
            	<tr>
                	<th scope="row">참조정보3
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_data3" id="istdinfo_dtl_data3" style="width:96%" maxlength="500" />
                    </td>
                                	
                	<th scope="row">참조정보4
                    </th>
                    <td>
                    <input type="text" name="istdinfo_dtl_data4" id="istdinfo_dtl_data4" style="width:96%" maxlength="500" />
                    </td>
                    
                </tr> 
                
                
            	<tr>
                	<th scope="row">참조정보5
                    </th>
                    <td colspan="3">
                    <input type="text" name="istdinfo_dtl_data5" id="istdinfo_dtl_data5" style="width:98%" maxlength="500" />
                    </td>

                    
                </tr>                                                                           
                
               
            	<tr>
                    <td scope="row" id="create_form_in_btns" colspan="4">
						<div class="section aC mT5 mB5">
						<span class="btn_pack large" id="btn_create_form_insert"><a href="#" onclick="create_form_insert()">등록</a></span>
						<span class="btn_pack large" id="btn_create_form_update"><a href="#" onclick="create_form_update()">수정</a></span>
						<span class="btn_pack large" id="btn_create_form_delete"><a href="#" onclick="create_form_delete()">삭제</a></span>
						<span class="btn_pack large" id="btn_create_form_close"><a href="#" onclick="create_form_close()">닫기</a></span>
						<!--<span class="btn_pack large" id="btn_create_form_init"><a href="#none;" onclick="create_form_init()">초기화</a></span>	-->
						</div>                    
                    </td>                    
                </tr>                
            </thead>
         </table>
         
 	</div>	
	</form>
</div>
<!-- 등록,수정 창  -->
