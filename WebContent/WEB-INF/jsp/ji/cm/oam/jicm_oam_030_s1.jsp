<%--/*=================================================================================*//* 시스템            : 공통관리(CM)/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_030_s1/* 프로그램 이름     : jicm_oam_030_s1    /* 소스파일 이름     : jicm_oam_030_s1.jsp/* 설명              : 권한그룹정보 조회화면/* 버전              : 1.0.0/* 최초 작성자       : 이금용/* 최초 작성일자     : 2016/11/08/* 최근 수정자       : 이금용/* 최근 수정일시     : 2016/11/08/* 최종 수정내용     : 최초작성/*=================================================================================*/--%><%@page pageEncoding="utf-8"%>	<script type="text/javascript">var searchYn = false;// TODO : $(function()$(function(){		//권한그룹 리스트	var cols =[ 				{label:'번호'			,name:'row_seqno'			,index:'row_seqno'			,align:'center'		,width:'80'		,hidden:false	,sortable:false}			   ,{label:'권한그룹 명'	,name:'auth_grp_nm'      	,index:'auth_grp_nm'		,align:'center'		,width:'300'	,hidden:false	,sortable:false, formatter : modifyemp}          			   ,{label:'권한그룹코드'	,name:'auth_grp_cd'      	,index:'auth_grp_cd'		,align:'center'		,width:'150'	,hidden:false	,sortable:false }			   ,{label:'메뉴갯수'		,name:'auth_grp_menu_cnt'   ,index:'auth_grp_menu_cnt'	,align:'center'		,width:'100'	,hidden:false	,sortable:false }	           ,{label:'사용자수'		,name:'auth_grp_user_cnt'   ,index:'auth_grp_user_cnt'  ,align:'center'		,width:'100'	,hidden:false	,sortable:false }	           ,{label:'등록자'		,name:'reg_id'           	,index:'reg_id'             ,align:'center'		,width:'150'	,hidden:false	,sortable:false }		   	   ,{label:'권한변경이력'	,name:'auth_chg_log'		,index:'auth_chg_log'		,align:'center'		,width:'150'	,hidden:false		,sortable:false ,formatter : fmauth_chg_log	}	           	           ,{label:'key'		,name:'auth_grp_seqno'		,index:'auth_grp_seqno'		,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}		];		//init grid	var grid = com.grid.init({		 id			: '#jqGrid' 		,viewrecords: true		,height		: 452		,rowNum		: 15		,shrinkToFit: false // 컬럼이 그리드 width에 맞춰 자동으로 맞춰질지 여부		,autowidth : true		,viewrecords: true		,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }		,gridComplete: function(){			mergeCellcomplet($(this));		}		,loadComplete: function(data){			// 로드 데이타 갯수 체크			if(searchYn){				isLoadData(data);						}					}		,onSelectRow: function(id) { // row를 선택했을때 액션.				}		,ondblClickRow: function(id) { // row를 선택했을때 액션.			var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.			modify("" + ret.auth_grp_seqno + "");		}		,custom : { //custom			 cols : cols //컬럼정보 - 필수!			,navButton : {				excel : {					exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명				}			}		}	});	    /*  필드별 검색어 입력창을 숨기거나 보여지게한다. */    /* 	    jQuery("#jqGrid").jqGrid('navButtonAdd',"#jqGridPager",{caption:"Toggle",title:"Toggle Search Toolbar", buttonicon :'ui-icon-pin-s',	        onClickButton:function(){	        	grid[0].toggleToolbar();	        } 	    }); */	    /* 각 필드별 검색어 입력창에 입력된 내용를 지운다. *//* 	    jQuery("#jqGrid").jqGrid('navButtonAdd',"#jqGridPager",{caption:"Clear",title:"Clear Search",buttonicon :'ui-icon-refresh',	        onClickButton:function(){	        	grid[0].clearToolbar();	        } 	    }); */	    /*  필드별 검색어 입력창 */    		/* jQuery("#jqGrid").jqGrid('navGrid','#ptoolbar',{del:false,add:false,edit:false,search:false});		jQuery("#jqGrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false}); */						//메뉴 리스트		var cols2 =[{label:'번호'				,name:'row_seqno'			,index:'row_seqno'			,align:'center'		,width:'60'		,hidden:false	,sortable:false}				   ,{label:'메뉴 명'			,   name:'menu_nm'          ,index:'menu_nm'			,align:'center'		,width:'120'	,hidden:false	,sortable:false ,formatter : fm_menu_nm}				   ,{label:'변경일자'			,   name:'reg_dt'           ,index:'reg_dt'				,align:'center'		,width:'100'	,hidden:false	,sortable:false }				   ,{label:'이력상태'			,   name:'log_mode'          ,index:'log_mode'			,align:'center'		,width:'80'		,hidden:false	,sortable:false ,formatter : fmlog_mode2 }				   ,{label:'메뉴코드'			,   name:'menu_cd'          ,index:'menu_cd'			,align:'center'		,width:'100'	,hidden:true	,sortable:false}				   ,{label:'메뉴전체 경로'		,   name:'m_nms'    		,index:'m_nms'				,align:'left'		,width:'300'	,hidden:true	,sortable:false}				   ,{label:'메뉴전체 경로코드'	,   name:'m_codes'    		,index:'m_codes'			,align:'left'		,width:'300'	,hidden:true	,sortable:false}		           ,{label:'key'			,   name:'menu_seqno'		,index:'menu_seqno'			,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}		           ,{label:'key'			,   name:'idx'				,index:'idx'				,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}			    ];				//init grid		var grid2 = com.grid.init({			 id			: '#jqGrid2' 			,viewrecords: true			,height		: 320			,rowNum		: 1000			,rowList	: 1000			,shrinkToFit: true // 컬럼이 그리드 width에 맞춰 자동으로 맞춰질지 여부			,autowidth : true			,multiselect: false			,viewrecords: true			//,rownumbers  : true 	//Row number 표시			,scroll : 1			,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }			,gridComplete: function(){				mergeCellcomplet($(this));				//grid_win_resizeAuto();			}			,loadComplete: function(data){				// 로드 데이타 갯수 체크				if(searchYn){									}								}				,onSelectRow: function(id) { // row를 선택했을때 액션.						}			,ondblClickRow: function(id) { // row를 선택했을때 액션.						var ret = $("#jqGrid2").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.			}			,custom : { //custom				 cols : cols2 //컬럼정보 - 필수!				,navButton : {					excel : {						exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명					}				}			}		});				//사용자 리스트		var cols3 =[{label:'번호'				,name:'row_seqno'			,index:'row_seqno'			,align:'center'		,width:'60'		,hidden:false	,sortable:false}				   ,{label:'사용자 명'			,   name:'user_nm'          ,index:'user_nm'			,align:'center'		,width:'100'	,hidden:false	,sortable:false }          				   ,{label:'사용자 ID'			,   name:'user_id'          ,index:'user_id'			,align:'center'		,width:'100'	,hidden:false	,sortable:false }				   ,{label:'변경일자'			,   name:'reg_dt'           ,index:'reg_dt'				,align:'center'		,width:'100'	,hidden:false	,sortable:false }				   ,{label:'이력상태'			,   name:'log_mode'          ,index:'log_mode'			,align:'center'		,width:'80'		,hidden:false	,sortable:false ,formatter : fmlog_mode3 }				   ,{label:'최상위조직명'		,   name:'emp_top_org_nm'   ,index:'emp_top_org_nm'		,align:'center'		,width:'150'	,hidden:true	,sortable:false }		           ,{label:'부서명'			,   name:'org_nm'           ,index:'org_nm'             ,align:'center'		,width:'150'	,hidden:false	,sortable:false }		           ,{label:'key'			,   name:'user_seqno'		,index:'user_seqno'			,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}		           ,{label:'key'			,   name:'idx'				,index:'idx'				,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}			    ];		//init grid		var grid2 = com.grid.init({			 id			: '#jqGrid3' 			,height		: 320			,rowNum		: 1000			,rowList	: 1000			,shrinkToFit: true // 컬럼이 그리드 width에 맞춰 자동으로 맞춰질지 여부			,autowidth : true			,multiselect: false			,viewrecords: true			//,rownumbers  : true 	//Row number 표시			,scroll : 1			,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }			,gridComplete: function(){				mergeCellcomplet($(this));				//grid_win_resizeAuto();			}			,loadComplete: function(data){									}				,onSelectRow: function(id) { // row를 선택했을때 액션.						}			,ondblClickRow: function(id) { // row를 선택했을때 액션.						var ret = $("#jqGrid3").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.			}			,custom : { //custom				 cols : cols3 //컬럼정보 - 필수!				,navButton : {					excel : {						exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명					}				}			}		});					    $("input[name ='sp_sdate']").datepicker({	        changeMonth: true, 	        changeYear: true,	        nextText: '다음 달',	        prevText: '이전 달', 	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],	        dayNamesMin: ['일','월', '화', '수', '목', '금', '토' ], 	        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,	        showOn:'both',	        dateFormat: "yy-mm-dd",	        yearRange : 'c-3:c', // 100년전부터 현재년도까지	        buttonImage:'<%=con_root%>/images/contents/cal.png',	        onClose:function(selectedDate){	        	//$("#sp_edate").datepicker("option","minDate",selectedDate);	        }		});		    	    $("input[name ='sp_sdate']").datepicker("setDate","-3Y");	    	    $("input[name ='sp_edate']").datepicker({	        changeMonth: true, 	        changeYear: true,	        nextText: '다음 달',	        prevText: '이전 달', 	        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],	        dayNamesMin: ['일','월', '화', '수', '목', '금', '토' ], 	        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,	        showOn:'both',	        dateFormat: "yy-mm-dd",	        yearRange : 'c-3:c', // 100년전부터 현재년도까지	        buttonImage:'<%=con_root%>/images/contents/cal.png',	        onClose:function(selectedDate){	        	//$("#sp_sdate").datepicker("option","maxDate",selectedDate);	        }		});	 	    $("input[name ='sp_edate']").datepicker("setDate","today");	    	    $(".ui-datepicker-trigger").css({verticalAlign:"middle",marginLeft:"3px"}); 				$("#btn_search").click( function() {			refreshGrid();		});				$("#btn_popup2_search").click( function() {			refreshGrid2();			refreshGrid3();		});							//권한그룹정보 등록 페이지 이동		$("#btn_save").click(function(e){			  su_form=document.listfrm;			  su_form.method='post';			  su_form.pstate.value='CF';			  su_form.action='<%=RequestURL%>';			  su_form.submit();			  su_form.target = "";			  		});								$("#btn_excel").click(function(e){						//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:""],엑셀명)			//excelDownload("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 화면리스트");			$("#pstate").val("XL1");			//return;			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 			excelDownload3("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 화면리스트");			$("#pstate").val("L");								});					$("#btn_excelAll").click(function(e){						//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함			//excelDownload("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 전체리스트");			$("#pstate").val("XL1");			//return;			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 			excelDownload3("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 전체리스트");			$("#pstate").val("L");		});				$("#btn_popup2_excel").click(function(e){			//$("form[name=create_formfm2]").find("#pstate").val("XP2");			//console.log($("#mail_loglist_title").html().replace(/[<span >&#8226;</span>]/gi,'').replace(/•/gi,'').replace(/b/gi,' '));			//excelDownload3("jqGrid2", "", $("#mail_loglist_title").html().replace(/[<span >&#8226;</span>]/gi,'').replace(/•/gi,'').replace(/b/gi,' ')+" 메뉴변경이력");			$("form[name=create_formfm2]").find("#pstate").val("XP3");			excelDownload3("jqGrid3", "", $("#mail_loglist_title").html().replace(/[<span >&#8226;</span>]/gi,'').replace(/•/gi,'').replace(/b/gi,' ')+" 담당자변경이력");			$("form[name=create_formfm2]").find("#pstate").val("L");								});							CmopenLoading();			    refreshGrid(false); //조회		setTimeout(grid_win_resizeAuto, 200);				CmcloseLoading();	    });//TODO : modifyemp//수정화면 이동function modifyemp(cellvalue, options, rowObject) {	var url ="";	if (cellvalue != undefined && cellvalue != null && cellvalue != '') {		cellvalue = cellvalue.replace(/&amp;amp;/gi,"&");		url = '<a href="#none" onclick="modify(' + rowObject.auth_grp_seqno + ')">' + cellvalue + '</a>';			}    return url;}//TODO : fm_menu_nmfunction fm_menu_nm(cellvalue, options, rowObject){	//var rowId = options.rowId;	var cell_fm_str = "";	//console.log(cellvalue);	if (cellvalue != undefined && cellvalue != null && cellvalue != '') {		cell_fm_str = cellvalue.replace(/&amp;amp;/gi,"&");	}	return cell_fm_str;}//TODO : modifyfunction modify(auth_grp_seqno) {	//alert(user_seqno);	$("input[name='sauth_grp_seqno']").val(auth_grp_seqno);				  su_form=document.listfrm;	  su_form.method='post';	  su_form.pstate.value='UF';	  su_form.action='<%=RequestURL%>';	  su_form.submit();	  su_form.target = "";	}//TODO : refreshGrid//조회 : 그리드 조회// TODO : refreshGridfunction refreshGrid(isNotCheckVal){	var _frm = document.listfrm;	_frm.action='<%=RequestURL%>';		searchYn = true;		var params = getGridParamDatas();	//alert("subinYn==>"+params.subinYn);	com.grid.reload('#jqGrid','<c:url value='/cmsajax.do'/>',params);}//TODO : getGridParamDatas//그리드 조회시 요청할 파라미터 objectfunction getGridParamDatas(){	var _params = com.frm.getParamJSON(document.listfrm);	_params.pstate = 'XL1';	return _params;}var fmauth_chg_log = function(cellvalue, options, rowObject){			var returnCell = "";	//console.log(rowObject.auth_grp_nm);	if (rowObject.auth_grp_cd != undefined && rowObject.auth_grp_cd != null && rowObject.auth_grp_cd != '') {		returnCell = "<span class='btn_pack medium'> <a href='#' onclick=create_form_view2('" + rowObject.auth_grp_cd + "','" + textToHtml(rowObject.auth_grp_nm.replace(/&amp;amp;/gi,"&")) + "') >권한변경이력 </a></span>";	}		return returnCell;};var refreshGrid2 = function(){		//$("form[name=create_formfm2]").find("#selprod_seq2").val($("form[name=dataForm]").find("#ireq_rcept_no").val())		// 검색 기간이 둘다 입력된경우 확인	if(!isEmpty($("#sp_sdate").val()) && !isEmpty($("#sp_edate").val())){		if(parseInt(StrreplaceAll($("#sp_sdate").val(), "-",""),10) > parseInt(StrreplaceAll($("#sp_edate").val(), "-",""),10)){			alert("검색시작일이 검색종료일 이전이여야합니다");			$("#sp_sdate").focus();			return false;		}	}		$('#jqGrid2').jqGrid('clearGridData', true);	var _frm = document.create_formfm2;	_frm.action='<c:url value='/cmsmain.do'/>';	searchYn = true;	var params = getGridParamDatas2();	var formarr_params = "";		com.grid.reload('#jqGrid2','<c:url value='/cmsajax.do'/>'+formarr_params,params);};var getGridParamDatas2 = function(){	var _params = com.frm.getParamJSON2(document.create_formfm2);	_params.pstate = "XP2";	return _params;};var fmlog_mode2 = function(cellvalue, options, rowObject){		var returnCell = "";	//console.log(rowObject.auth_grp_nm);	if (rowObject.log_mode != undefined && rowObject.log_mode != null && rowObject.log_mode != '') {		if(rowObject.log_mode=="C"){			returnCell = "등록";		}else if(rowObject.log_mode=="U"){			returnCell = "수정";		}else if(rowObject.log_mode=="D"){			returnCell = "삭제";		}			}		return returnCell;};var refreshGrid3 = function(){		//$("form[name=create_formfm2]").find("#selprod_seq2").val($("form[name=dataForm]").find("#ireq_rcept_no").val())	// 검색 기간이 둘다 입력된경우 확인	if(!isEmpty($("#sp_sdate").val()) && !isEmpty($("#sp_edate").val())){		if(parseInt(StrreplaceAll($("#sp_sdate").val(), "-",""),10) > parseInt(StrreplaceAll($("#sp_edate").val(), "-",""),10)){			alert("검색시작일이 검색종료일 이전이여야합니다");			$("#sp_sdate").focus();			return false;		}	}		$('#jqGrid3').jqGrid('clearGridData', true);	var _frm = document.create_formfm2;	_frm.action='<c:url value='/cmsmain.do'/>';	searchYn = true;	var params = getGridParamDatas3();	var formarr_params = "";		com.grid.reload('#jqGrid3','<c:url value='/cmsajax.do'/>'+formarr_params,params);};var getGridParamDatas3 = function(){	var _params = com.frm.getParamJSON2(document.create_formfm2);	_params.pstate = "XP3";	return _params;};var fmlog_mode3 = function(cellvalue, options, rowObject){		var returnCell = "";	//console.log(rowObject.auth_grp_nm);	if (rowObject.log_mode != undefined && rowObject.log_mode != null && rowObject.log_mode != '') {		if(rowObject.log_mode=="C"){			returnCell = "등록";		}else if(rowObject.log_mode=="U"){			returnCell = "수정";		}else if(rowObject.log_mode=="D"){			returnCell = "삭제";		}			}		return returnCell;};//TODO : create_form_close2 //메일이력목록창 닫기function create_form_close2(){	$("#create_form_popup2").hide();	create_form_init2();	CmclospageDisable();}function create_form_init2(){}	//TODO : create_form_view2 //메일전송이력목록 창 오픈function create_form_view2(selauth_grp_cd,selauth_grp_nm){	CmopenpageDisable();	    $("#create_form_popup2").draggable({ opacity:"0.3",handle:"#mail_loglist_title" }); // 끄는 동안만 불투명도 주기    $("body").droppable({        accept: "#create_form_popup2",    // 드롭시킬 대상 요소        drop: function(event, ui) {        	$("#create_form_popup2").css({ opacity:"1.0" });        }    });    	$("form[name=create_formfm2]").find("#selsauth_grp_cd2").val(selauth_grp_cd);		$("#mail_loglist_title").html("<span>&#8226;</span>"+selauth_grp_nm+" 변경 이력");		// 수정, 등록창의 위치를 잡는다	$("#create_form_popup2").css("left",( (($(document).width() - 1000) / 3) + $(document).scrollLeft()  )+"px");	$("#create_form_popup2").css("top", ( (($(document).height() - 640) / 2) + $(document).scrollTop() - (($(document).height() - 600) / 5)  )+"px");		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);	/*$("#gbox_jqGrid3").width(698);	$("#gview_jqGrid3").width(698);	$("#jqGrid3Pager").width(698);	$(".ui-jqgrid-hdiv").width(698);	$("#jqGrid3").width(698);*/	jQuery("#jqGrid2").jqGrid("setGridWidth",480);	$("#jqGrid2").width(480);	jQuery("#jqGrid3").jqGrid("setGridWidth",480);	$("#jqGrid3").width(480);		$("#create_form_popup2").show(500);	refreshGrid2();	refreshGrid3();}</script><form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();' >        	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />	<input type="hidden" name="del" id="del" value="" />	<input type="hidden" name="sauth_grp_cd" id="sauth_grp_cd" />	<input type="hidden" name="sauth_grp_seqno" id="sauth_grp_seqno" /><!-- 복합영역 --><div class="sectionBlue">	<div class="searchArea ">	  <table class="tbl_search">	    <colgroup>	    <col width="50" />	    <col width="100" />	    <col width="50" />	    <col width="100" />	    <col width="50" />	    <col width="*" />     	    </colgroup>	    	    <tr>		      <th scope="row">검색조건</th>		      <td>		        <select name="sty" id="sty" title="검색조건 선택">		          <option value="">--선택--</option>		          <option value="auth_grp_nm">권한그룹명</option>		          <option value="auth_grp_cd">권한그룹코드</option>		        </select>			  </td>		  		      <th scope="row">검색어</th>		      <td>		          <input type="text" name="stext" id="stext" />			  </td>	  		  			<%			// 관리권한이 없는 사용자만 보여주는 조건			//if(isMenuMng != true){			%>			      <td  colspan="2"  class="aR">		            						<%@include file="/WEB-INF/jsp/common/button_s.jsp"%>			  </td> 			<%			//}			%>		  	      </tr>	  </table>	  </div>	    <!-- end of search -->  	    	   <div class="section">		      <h3 class="fL"><span>&#8226;</span>권한그룹 리스트</h3>		      <p class="fR mB5"><!-- 		           <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="#" onclick="return false;">화면출력</a></span> --><!-- 		           <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="#" onclick="return false;">전체출력</a></span> -->		      </p>	    </div> 	    <div class="section" id="jqGridDiv">   	    	<table id='jqGrid' fixwidth="N"></table>	    </div></div></form><!-- 권한변경 이력조회 창  --><div id="create_form_popup2" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9991;width:1000px;display:none;">	<h1 id="mail_loglist_title"><span>&#8226;</span> 권한변경 이력</h1><span class="close" id="btn_mail_loglist_close_icon" onclick="create_form_close2()"><a href="#" onclick="return false;" ></a></span>	<form name="create_formfm2" id="create_formfm2" method="post" onSubmit='return false;'>		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />		<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />		<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />		<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />		<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />			<input type="hidden" name="selsauth_grp_cd2" id="selsauth_grp_cd2" value="" title="선택된 번호"  />        		<div class="searchArea mT0" style="margin:0px;padding:0px 0px !important;">		  <table class="tbl_search">		    <colgroup>		    <col width="50" />		    <col width="350" />		    <col width="60" />		    <col width="90" />		    <col width="60" />		    <col width="*" />		    </colgroup>		    <tr>		    	<th scope="row">기간</th>		    	<td colspan="4">		    		<input type="text" name="sp_sdate" id="sp_sdate" title="검색시작일" />		    		~		    		<input type="text" name="sp_edate" id="sp_edate" title="검색종료일" />		    	</td>			      <td class="aR">			      	<span class="btn_pack large"><a href="#" id="btn_popup2_excel">엑셀다운로드</a></span>			      	<span class="btn_pack largeO "><a href="#" id="btn_popup2_search">검색</a></span>			      </td>		    			    </tr>		  </table>	  	  		</div> 		      	 	<div class="sectionBlue" id="jqGridDiv2">			<div style="width:49%;float:left;"><table id='jqGrid2' fixwidth="Y"></table></div>			<div style="width:49%;float:right;"><table id='jqGrid3' fixwidth="Y"></table></div>		</div>			<div class="section aC mT5 mB5" style="clear:both;padding-top:10px;">			<span class="btn_pack large" id="btn_create_form_close2"><a href="#" onclick="create_form_close2();return false;">닫기</a></span>		</div>                    	</form></div><!-- 메일전송이력조회 창  -->