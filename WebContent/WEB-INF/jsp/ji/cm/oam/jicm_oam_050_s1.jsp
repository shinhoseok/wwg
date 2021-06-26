<%--/*=================================================================================*//* 시스템            : 공통관리(CM)/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_050_s1/* 프로그램 이름     : jicm_oam_050_s1    /* 소스파일 이름     : jicm_oam_050_s1.jsp/* 설명              : 관리자메뉴 > 사용자관리 목록/* 버전              : 1.0.0/* 최초 작성자       : 박창현/* 최초 작성일자     : 2015/03/26/* 최근 수정자       : cys/* 최근 수정일시     : 2018/03/08/* 최종 수정내용     : 수정/*=================================================================================*/--%><%@page pageEncoding="utf-8"%>	<script type="text/javascript">var searchYn = false;// TODO : $(function()$(function(){		//사용자 리스트	var cols =[ {label:'번호'				,name:'row_seqno'		,index:'row_seqno'			,align:'center'		,width:'80'		,hidden:false	,sortable:false}			   ,{label:'사용자 명'			,name:'user_nm'         ,index:'user_nm'			,align:'center'		,width:'180'	,hidden:false	,sortable:false, formatter : modifyemp }          			   ,{label:'사용자 ID'			,name:'user_id'         ,index:'user_id'			,align:'center'		,width:'180'	,hidden:false	,sortable:false}	           ,{label:'개인/단체'			,name:'indvdl_grp_se'	,index:'indvdl_grp_se'		,align:'center'		,width:'120'	,hidden:false 	,sortable:false, formatter : indvdl_grp }	           ,{label:'가입승인'			,name:'join_yn'			,index:'join_yn'			,align:'center'		,width:'120'	,hidden:true  	,sortable:false, formatter : joinuser }	           ,{label:'로그인초기화'		,name:'bigo2'			,index:'bigo2'				,align:'center'		,width:'180'	,hidden:false  	,sortable:false, formatter : resetlogcnt }	           ,{label:'비밀번호초기화'	,name:'bigo3'			,index:'bigo3'				,align:'center'		,width:'150'	,hidden:false  	,sortable:false, formatter : delpass }	           ,{label:'승인여부'			,name:'join_yn'			,index:'join_yn'			,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}	           ,{label:'최종로그인'		,name:'login_last'		,index:'login_last'			,align:'center'		,width:'200'	,hidden:false  	,sortable:false }			   ,{label:'key'				,name:'user_seqno'		,index:'user_seqno'			,align:'center'  	,width:'0'  	,hidden:true  	,sortable:false}			   ];		//init grid	var grid = com.grid.init({		 id			: '#jqGrid' 		,viewrecords: true		,height		: 452		,autowidth  : true		,shrinkToFit: false // 컬럼이 그리드 width에 맞춰 자동으로 맞춰질지 여부		,rowNum		: 15		,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }		,gridComplete: function(){			mergeCellcomplet($(this));		}		,loadComplete: function(data){			// 로드 데이타 갯수 체크			if(searchYn){				isLoadData(data);						}					}			,onSelectRow: function(id) { // row를 선택했을때 액션.				}		,ondblClickRow: function(id) { // row를 선택했을때 액션.					var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.			modify("" + ret.user_seqno + "");				}		,custom : { //custom			 cols : cols //컬럼정보 - 필수!			,navButton : {				excel : {					exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명				}			}		}	});			$("#btn_search").click( function() {		refreshGrid();	});		$('#useYn').click(function(){        if ($("#useYn").is(":checked")) {        	$("#used").val("Y");        } else {        	$("#used").val("");        } 	}); 					//기준정보 등록 페이지 이동	$("#btn_save").click(function(e){		  su_form=document.listfrm;		  su_form.method='post';		  su_form.pstate.value='CF';		  su_form.action='<%=RequestURL%>';		  su_form.submit();		  su_form.target = "";	});		//sms 발송테스트	$("#btn_tsms").click(function(e){		if(isEmpty($("#tsend_hpone_no").val())){			alert("테스트 SMS 핸드폰번호를 입력해주세요");			$("#tsend_hpone_no").focus();			return;		}					$("#tsend_mail_id").val($("#tsend_hpone_no").val());				    $("#pstate").val("TSMS");				var params = $("#listfrm").serialize();				CmopenLoading();				 $.ajax({		             type: "post",		             url: "<c:url value='/cmsajax.do'/>",		             data: params,		             async: false,		             dataType:"json",		             timeout: 3000,		             success: function(data){		               if(data.result==true){		                	alert('SMS 발송성공');		                			               }else{		            	   alert('SMS 발송실패==>'+data.result);		               }		               CmcloseLoading();		             },				     error:function(request, status, error) {				    	 CmcloseLoading();				    	 alert('SMS 발송 오류가 발생했습니다.');		             }		      });	});			//이메일 발송테스트	$("#btn_temail").click(function(e){		if(isEmpty($("#tsend_mail_nm").val())){			alert("테스트 이메일 성명을 입력해주세요");			$("#tsend_mail_nm").focus();			return;		}		 		if(isEmpty($("#tsend_mail_email").val())){			alert("테스트 이메일 메일주소를 입력해주세요");			$("#tsend_mail_email").focus();			return;		}					$("#tsend_mail_id").val($("#tsend_mail_email").val());		    $("#pstate").val("TEMAIL");				var params = $("#listfrm").serialize();				CmopenLoading();				 $.ajax({		             type: "post",		             url: "<c:url value='/cmsajax.do'/>",		             data: params,		             async: false,		             dataType:"json",		             timeout: 3000,		             success: function(data){		               if(data.result==true){		                	alert('이메일 발송성공');		                			               }else{		            	   alert('이메일 발송실패==>'+data.result);		               }		               CmcloseLoading();		             },				     error:function(request, status, error) {				    	 CmcloseLoading();				    	 alert('이메일 발송 오류가 발생했습니다.');		             }		      });	});						$("#btn_excel").click(function(e){		//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:""],엑셀명)		//excelDownload("jqGrid","","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 화면리스트");		$("#pstate").val("XL1");		//return;		//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 		excelDownload3("jqGrid","","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 화면리스트");		$("#pstate").val("L");				});			$("#btn_excelAll").click(function(e){				//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함		//excelDownload("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 전체리스트");		$("#pstate").val("XL1");		//return;		//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 		excelDownload3("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 전체리스트");		$("#pstate").val("L");				});		CmopenLoading();		    refreshGrid(false); //조회	setTimeout(grid_win_resizeAuto, 200);			CmcloseLoading();	    		}).ajaxStart(function() {      // ajax 통신 시작 callback (로딩바 show)		 //console.log('start');		 CmopenLoading();		//$("#pageDisable").css({"width":"100%","height":($(document).height()+20)+"px","background": "url("+context_root+"/images/loading.gif) no-repeat center rgba(0, 0, 0, 0.5)"});		}).ajaxStop(function() {        // ajax 통신 완료 callback (로딩바 hide)		//console.log('end');      		CmcloseLoading();			});	//TODO : indvdl_grp	//개인/단체	function indvdl_grp(cellvalue, options, rowObject) {		var indvdl_grp_se = rowObject.indvdl_grp_se;		var url ="";		if(indvdl_grp_se=='G'){			url = "<span>단체</span>";		}else if(indvdl_grp_se=='P'){			url = "<span>개인</span>";		}		return url;	}	// TODO : joinuser	//가입승인	function joinuser(cellvalue, options, rowObject) {		var check=rowObject.join_yn;		var url ="";		if(check=="N"){			url = "<span class='btn_pack medium'> <a href='#' onclick=join('" + rowObject.user_id + "'); >가입승인</a></span>";		}else{			url = "<span>승인완료</span>";		}	    return url;	}		// TODO : resetlogcnt	//로그인 실패 횟수 초기화	function resetlogcnt(cellvalue, options, rowObject) {		var url ="";		//url = "<span class='btn_pack medium'> <a href='#' onclick=resetcnt('" + rowObject.user_id + "'); >실패횟수초기화 ("+rowObject.login_fail_cnt+")</a></span>";		var fail_cnt = "0";		if(rowObject.pw_mismatch_count==null || rowObject.pw_mismatch_count=="null"){			fail_cnt = "0";		}else{			fail_cnt = rowObject.pw_mismatch_count;		}		url = "<span class='btn_pack medium'> <a href='#' onclick=resetcnt('" + rowObject.user_id + "'); >실패횟수초기화 ("+fail_cnt+")</a></span>";	    return url;	}		// TODO : delpass	//비밀번호 초기화 	function delpass(cellvalue, options, rowObject) {		var url ="";		url = "<span class='btn_pack medium'> <a href='#' onclick=passdel('"+rowObject.user_id+"','"+rowObject.user_nm+"','"+rowObject.email+"'); >비밀번호초기화</a></span>";	    return url;	}	//TODO : join	//가입승인	function join(userId) {				if(confirm("가입승인 하시겠습니까?")) {	    $("#suser_id").val(userId);   	    $("#pstate").val("PU2");			var params = $("#listfrm").serialize();			CmopenLoading();			 $.ajax({	             type: "post",	             url: "<c:url value='/cmsajax.do'/>",	             data: params,	             async: false,	             dataType:"json",	             timeout: 3000,	          	             success: function(data){	               if(data.result==true){	                	alert('가입승인 처리 되었습니다.');	                	refreshGrid();	               }else{	            	   	alert('가입승인 중 오류가 발생했습니다.');	            	   	refreshGrid();	               }	               CmcloseLoading();	             },			     error:function(request, status, error) {			    	 CmcloseLoading();			    	 refreshGrid();			    	 alert('가입승인 중 오류가 발생했습니다.');	             }	      });		}	}		//TODO : resetcnt 로그인초기화	function resetcnt(userId) {				if(confirm("로그인 실패 횟수를\n초기화 하시겠습니까?")) {	    $("#suser_id").val(userId);   	    $("#pstate").val("PU1");			var params = $("#listfrm").serialize();			CmopenLoading();			 $.ajax({	             type: "post",	             url: "<c:url value='/cmsajax.do'/>",	             data: params,	             async: false,	             dataType:"json",	             timeout: 3000,	             success: function(data){	               if(data.result==true){	                	alert('초기화되었습니다.');	                	refreshGrid(false);	               }else{	            	   alert('초기화중 오류가 발생했습니다.');	               }	               CmcloseLoading();	             },			     error:function(request, status, error) {			    	 CmcloseLoading();			    	 alert('초기화중 오류가 발생했습니다.');	             }	      });		}	}			//TODO : passdel	//비밀번호 초기화 	function passdel(userId, userNm, email) {				if(confirm("비밀번호를 초기화 하시겠습니까?\r\n초기화 하면 "+userNm+"님 이메일로 임시비밀번호가 발송됩니다.")) {	    $("#suser_id").val(userId);	    $("#suser_nm").val(userNm);	    $("#suser_email").val(email);	    	    $("#pstate").val("PU");			var params = $("#listfrm").serialize();						 $.ajax({	             type: "post",	             url: "<c:url value='/cmsajax.do'/>",	             data: params,	             async: false,	             dataType:"json",	             timeout: 3000,	             success: function(data){	               if(data.result==true){	                	alert('초기화되었습니다.');	               }else{	            	   alert('초기화중 오류가 발생했습니다.');	               }	               CmcloseLoading();	             },			     error:function(request, status, error) {			    				    	 alert('초기화중 오류가 발생했습니다.');			    	 CmcloseLoading();	             },	             beforeSend: function( xhr ) {	            	 CmopenLoading(); 	             }	             	      });		}else{			CmcloseLoading();			return;		}	}		//TODO : modifyemp	//인력 수정화면 이동	function modifyemp(cellvalue, options, rowObject) {		var url ="";		url = '<a href="#none" onclick="modify(' + rowObject.user_seqno + ')">' + cellvalue + '</a>';	    return url;	}		//TODO : modify	function modify(user_seqno) {		//alert(user_seqno);		$("input[name='suser_seq']").val(user_seqno);					  su_form=document.listfrm;		  su_form.method='post';		  su_form.pstate.value='UF';		  su_form.action='<%=RequestURL%>';		  su_form.submit();		  su_form.target = "";			}		//TODO : refreshGrid	//조회 : 그리드 조회	// TODO : refreshGrid	function refreshGrid(isNotCheckVal){		var _frm = document.listfrm;		_frm.action='<%=RequestURL%>';						// 삭제포함이면		if($("#useYn").prop("checked")){			jQuery("#jqGrid").jqGrid('showCol',["del_yn"]);		}else{			jQuery("#jqGrid").jqGrid('hideCol',["del_yn"]);		}				searchYn = true;				var params = getGridParamDatas();		com.grid.reload('#jqGrid','<c:url value='/cmsajax.do'/>',params);	}		//TODO : getGridParamDatas	//그리드 조회시 요청할 파라미터 object	function getGridParamDatas(){		var _params = com.frm.getParamJSON(document.listfrm);		_params.pstate = 'XL1';		return _params;	}				//조회 : 트리조회	// TODO : refreshTree	function refreshTree(){					//alert('refreshTree');		$("#pstate").val("XL2");		var params =  $("form[name=listfrm]").serialize();		//var params = jQuery('form').serialize();		//var params = com.frm.getParamJSON(document.listfrm);		//alert(params);		$.fn.cmtree.reload('#cmtree_data','<c:url value='/cmsajax.do'/>',params);			}		//TODO : treeClickTitle01	function treeClickTitle01(rtnArr){		//alert(rtnArr[1]+"---"+rtnArr[4]);		//0: TREE_SEQ, 1: TREE_CD, 2: TREE_NM, 3:TREE_UPPO_CD, 4: TREE_LEVEL, 5: TREE_NMS, 6: TREE_CDS, 7: TREE_SUB_CNT		//$.fn.cmtree.treeRelComboboxSet(rtnArr[1], rtnArr[4]);		//$.fn.cmtree.treeRelComboboxMake(rtnArr[1],'', rtnArr[4]);		$.fn.cmtree.selTreeParentAll(rtnArr[1], rtnArr[4]);//조직트리 해당 조직으로 선택		//$.fn.cmtree.treeRelComboboxMake(rtnArr[1],'', rtnArr[1]);						optionGroupToTree(rtnArr[6], rtnArr[4]);		//		//insertfInit();	}			//TODO : optionGroupToTree	function optionGroupToTree(tree_cds, tree_level){		// 역으로 찾아가며 처리한다		var ogi = 0;		//alert(tree_cds+"---"+tree_level);		var tree_cds_sp = tree_cds.split("::");		for(ogi=0;ogi<tree_cds_sp.length;ogi++){			$("select[name='org_option']").eq(ogi).val(tree_cds_sp[ogi]);			optionGroup($("select[name='org_option']").eq(ogi), ogi+1, "N", "","N");					}				// 그리드 조회		refreshGrid(false); //조회	}		//TODO : optionGroup	function optionGroup($this, lev, treeyn, treecode, gridreloadyn){		//alert($this.attr("id"));		if(treeyn=="Y"){			$this.val(treecode);			$.fn.cmtree.treeRelComboboxMake(treecode,'', lev);//하위 셀렉트박스 생성			$.fn.cmtree.selTreeParentAll(treecode, lev);//트리 해당 코드로 선택					}else{			if(isEmpty($this.val())){				if(lev>1){					//alert($("select[name='smatrtpcd']").eq(lev-2).val()+"----"+(lev-2));					$.fn.cmtree.treeRelComboboxMake($("select[name='org_option']").eq(lev-2).val(),'', lev-1);//하위 셀렉트박스 생성										$.fn.cmtree.selTreeParentAll($("select[name='org_option']").eq(lev-2).val(), lev-1);//조직트리 해당 조직으로 선택									}else{					$.fn.cmtree.treeRelComboboxMake($this.val(),'', lev);//하위 셀렉트박스 생성										$.fn.cmtree.selTreeParentAll($this.val(), lev);//조직트리 해당 조직으로 선택								}						}else{				$.fn.cmtree.treeRelComboboxMake($this.val(),'', lev);//하위 셀렉트박스 생성								$.fn.cmtree.selTreeParentAll($this.val(), lev);//조직트리 해당 조직으로 선택						}						}				// 그리드 조회		if(gridreloadyn!="N"){			refreshGrid(false); //조회		}		}</script><form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();' >        	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />	<input type="hidden" name="sidx" value="" title="선택된인덱스" />	<input type="hidden" name="used" id="used" value="" />	<input type="hidden" name="del" id="del" value="" />	<input type="hidden" name="suser_id" id="suser_id" value="" />	<input type="hidden" name="suser_nm" id="suser_nm" value="" />	<input type="hidden" name="suser_email" id="suser_email" value="" />	<input type="hidden" name="suser_seq" id="suser_seq" /><!-- 복합영역 --><div class="supply_box">	<div class="searchArea ">	  <table class="tbl_search">	    <colgroup>		    <col width="5%" />		    <col width="20%" />		    <col width="5%" />		    <col width="20%" />		    <col width="5%" />		    <col width="20%" />		    <col width="5%" />		    <col width="20%" />   	    </colgroup>	    <tr>		      <th scope="row">검색조건</th>		      <td>		        <select name="sty" id="sty" title="검색조건 선택">		          <option value="">--선택--</option>		          <option value="user_nm">사용자명</option>		          <option value="user_id">사용자ID</option>		        </select>			  </td>		      <th scope="row">검색어</th>		      <td>		          <input type="text" name="stext" id="stext" />			  </td>	  		 	  <th scope="row" style="display:none;">승인여부</th>		      <td style="display:none;">		        <select name="sjoin_yn" id="sjoin_yn" title="승인여부 선택">		          <option value="">--선택--</option>		          <option value="Y">승인</option>		          <option value="N">미승인</option>		        </select>		      </td>		      <th></th>		      <td>	   			<p class="fR mL10">	   				<span class="btn_pack large vM"><a id="btn_search" href="#none">검색</a></span>	   				<!-- <span class="btn_pack largeO vM"><a id="btn_save" href="#none">등록</a></span> -->	   					    		</p>			 </td>	    </tr>	  </table>	</div>	<!-- end of search -->		<div class="searchArea" style="margin-top:5px;">	  <table class="tbl_search">	    <colgroup>		    <col width="10%" />		    <col width="40%" />		    <col width="10%" />		    <col width="*" />   	    </colgroup>	    <tr>		      <th scope="row">테스트이메일</th>		      <td>		      	<input type="hidden" name="tsend_mail_id" id="tsend_mail_id" style="width:100px;" />		      	성명:<input type="text" name="tsend_mail_nm" id="tsend_mail_nm" style="width:100px;" />		      	메일:<input type="text" name="tsend_mail_email" id="tsend_mail_email" style="width:100px;" />		      	<span class="btn_pack largeO vM" style="display:;"><a id="btn_temail" href="#">테스트EAMIL발송</a></span>			  </td>  						 	  <th scope="row" >테스트SMS</th>		      <td>				핸드폰번호:<input type="text" name="tsend_hpone_no" id="tsend_hpone_no" style="width:100px;" />				<span class="btn_pack largeO vM" style="display:;"><a id="btn_tsms" href="#">테스트SMS발송</a></span>		      </td>	    </tr>	  </table>	</div>	  	        <div class="section">	      <h3 class="fL"><span>&#8226;</span>사용자 리스트 	      	 	      </h3>	      <p class="fR mB5"><!-- 	           <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="# none;" >화면출력</a></span> --><!-- 	           <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="# none;" >전체출력</a></span> -->	      </p>     </div>      <div class="section" id="jqGridDiv">        	<table id='jqGrid' fixwidth="N"></table>     </div>	    </div>	</form>