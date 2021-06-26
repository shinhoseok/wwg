<%--
/*=================================================================================*/
/* 시스템            : 공통/ 링크Alive
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/mnm/jicm_mnm_020_s1.jsp 
/* 프로그램 이름     : jicm_mnm_020_s1    
/* 소스파일 이름     : jicm_mnm_020_s1.jsp
/* 설명              : 링크Alive
/* 버전              : 1.0.0
/* 최초 작성자       : cys
/* 최초 작성일자     : 2018-04-12
/* 최근 수정자       : 
/* 최근 수정일시     : 
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>

		<div >
			<!-- tab -->
			<ul class="tab_menu">
				<li class="selected"><a href="#" onclick="chgTab(0);return false;" id="tab_link0">링크Alive관리</a></li>
				<li><a href="#" onclick="chgTab(1);return false;" id="tab_link1">Web Proxy관리</a></li>
			</ul>
			<!-- tab //-->	
		</div>
		
<form name="listfrm" id="listfrm" method="post" enctype="multipart/form-data" onSubmit='return false;' >
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="excel_stdinfo_dtl_cd" id="excel_stdinfo_dtl_cd" value="" title="엑셀다운로드 코드분류 검색조건" />
    <input type="hidden" name="menu_arr" id="menu_arr" value="" />
    <input type="hidden" name="alive_arr" id="alive_arr" value="" />
    

<div class="searchArea" style="margin-top:10px;">
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
        <td>
          <select name="sty" id="sty" title="검색조건 선택">
            <option value="">--선택--</option>
            <option value="menu_cd">메뉴코드</option>
            <option value="menu_nm">메뉴명</option>
          </select>
	    </td>    
		<th scope="row">검색어</th>
		<td colspan="2">
			<p class="fL">
	        	<input type="text" name="stext" id="stext" onkeypress="srchCheck()" onKeyUp="sechnotin();" title="검색어 입력"/>
	        </p>
	    </td>
		<th scope="row">Alive</th>
		<td>
	        <select name="alive_yn" id="alive_yn" title="사용가능 여부 선택">
	          <option value="">--전체--</option>
	          <option value="Y">사용가능</option>
	          <option value="N">사용불가</option>
	        </select>
		</td>
	    <td>
      		<p class="fR mL10">	
      			<span class="btn_pack large vM"><a id="btn_search" href="#none">검색</a></span>
      			<span class="btn_pack largeO vM"><a id="btn_exe" href="#none">실행</a></span>
	      	</p>		        
		</td>					   
    </tr>
    <tr>
    <td colspan="8">
    	<span style="font-weight:600;color:blue;">※ 검색조건 오른쪽의 실행버튼을 클릭하면 링크주소에 해당하는 주소연결이 활성화
        되어있는지 확인되며(약 3분소요) 사용불가는 http리퀘스트체크시 200 성공 상태
        가 리턴되지 않을시 사용불가로 표시됨
         <br />www.khnp.co.kr(한수원홈페이지)의경우 한수원쪽 서버 셋팅으로 체크불가
    	</span>
    </td>
    </tr>
  </table>
</div>
<!-- end of search -->
<!-- 복합영역 -->
<div class="section mT20">
    <div class="section"> 
	   <div class="section mB5">
	   		  <h3 class="fL" id="alive_time"><span>&#8226;</span>기준일시 : 0000-00-00 00:00:00 기준
	   		  	
	   		  </h3>
	   		  <span class="btn_pack largeO vM" style="display:;"><a id="btn_exetest" href="#">TEST실행</a></span>
	   		  <span class="btn_pack largeO vM" style="display:;"><a id="btn_exetest2" href="#">TEST크롤링실행</a></span>
		      <p class="fR">
<!-- 		           <span class="btn_pack medium icon" id="printBtn" ><span class="excel"></span><a href="#none">화면출력</a></span> -->
<!-- 		           <span class="btn_pack medium icon" id="printBtnAll" ><span class="excel"></span><a href="#none">전체출력</a></span>           -->
		      </p>
	    </div>		
	    <div id="griddiv" style="width:auto;"><table id='jqGrid' fixwidth="N"></table></div>
	    <div id="jqGridPager" style="text-align:center;"></div>
		

	</div>    
</div>
</form>



<script type="text/javascript">
//<![CDATA[
var searchYn = false;

//TODO : $(function()
$(function(){		
	
	//팝업 리스트
		var cols =[
				     {label:'메뉴코드'   ,name:'menu_cd'	,index:'menu_cd'    ,align:'center' ,width : '80', hidden:false, sortable : false}
				    ,{label:'메뉴명'	  ,name:'menu_nm'	,index:'menu_nm'   	,align:'left'   ,width : '200', hidden:false, sortable : false}
				    ,{label:'링크주소'	  ,name:'link_path'	,index:'link_path'  ,align:'left'   ,width : '300', hidden:false, sortable : false, formatter : fm_alive_link}
				    ,{label:'Web서버주소'	  ,name:'webtob_url'	,index:'webtob_url'  ,align:'left'   ,width : '300', hidden:false, sortable : false, formatter : fm_webtob_url}
				    ,{label:'상태'		  ,name:'alive_yn'	,index:'alive_yn' 	,align:'center' ,width : '80', hidden:false, sortable : false, formatter : fm_alive_yn}
				    ,{label:'기준일시'   ,name:'alive_time'	,index:'alive_time'    ,align:'center' ,width : '80', hidden:true, sortable : false}
				   ];

		var grid = com.grid.init({
			 id			: '#jqGrid' 
			,viewrecords: true
			,height		: 452
			,autowidth  : true
			,rowList	: 1000
			,rowNum		: 200
			,shrinkToFit : true
			,scroll 	: 1
			,gridComplete: function(){
				mergeCellcomplet($(this));
			}
			,loadComplete: function(data){

				// 로드 데이타 갯수 체크
				if(searchYn &&  !isLoadData(data)) return false;
				
				//기준일시 업데이트
				if(data.rows!=""){
					$('#alive_time').html('<span>&#8226;</span>기준일시 : '+data.rows[0].alive_time+' 기준');
				}
	
			}		
			,onSelectRow: function(id) { // row를 선택했을때 액션.
				//create_form_view(id);
				
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
			
	    /* 그리드 크기를 조절할 수 있도록 한다. */
	    jQuery("#jqGrid").jqGrid('gridResize',{});

		$("#btn_search").click( function() {
			$('#jqGrid').jqGrid('clearGridData', true);
			refreshGrid();
		});
		
		//링크관리 실행
		$("#btn_exe").click(function(e){
				
				$("#pstate").val("U");
				var params =  $("form[name=listfrm]").serialize();
				CmopenLoading();
				
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
			        	refreshGrid();
			        },
			        success: function(data){
			           CmopenLoading();
			           if(data.result==true){

			           }else{
				        	alert(data.TRS_MSG);
				        	
			           }
		        	   CmcloseLoading();
			           $("#pstate").val("L");
			           refreshGrid();
			        }
					
				});
		});
		
		$("#btn_exetest").click(function(e){
			
			$("#pstate").val("UT");
			var params =  $("form[name=listfrm]").serialize();
			CmopenLoading();
			
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
		        	refreshGrid();
		        },
		        success: function(data){
		           CmopenLoading();
		           if(data.result==true){
						alert("링크테스트 성공");
		           }else{
			        	alert(data.TRS_MSG);
			        	
		           }
	        	   CmcloseLoading();

		        }
				
			});
		});	
		
		$("#btn_exetest2").click(function(e){
			
			$("#pstate").val("UT2");
			var params =  $("form[name=listfrm]").serialize();
			CmopenLoading();
			
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
		        	refreshGrid();
		        },
		        success: function(data){
		           CmopenLoading();
		           if(data.result==true){
						alert("크롤링테스트 성공");
		           }else{
			        	alert(data.TRS_MSG);
			        	
		           }
	        	   CmcloseLoading();

		        }
				
			});
		});			
		
		
		/* 출력 클릭*/
		$("#listfrm").find("#printBtn").click( function() {

			//console.log("excel_sh_stdinfo_dtl_cd:::==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("L");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트");

		});
		
		$("#listfrm").find("#printBtnAll").click( function() {			
			
			//console.log("excel_sh_stdinfo_dtl_cd:::==>"+$("#excel_sh_stdinfo_dtl_cd").val());
			$("#pstate").val("L");
			//return;
			//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) 
			excelDownload3("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트");

		});
		
		$("#stext").keydown(function(e){
			//alert(e.keyCode);
			if(e.keyCode == 13){
				$('#jqGrid').jqGrid('clearGridData', true);
				refreshGrid();
			}
		});	
		

		CmopenLoading();	
	
		refreshGrid(true); //조회
		setTimeout(grid_win_resizeAuto, 200);
		
});


function fm_alive_link(cellvalue, options, rowObject){
	
	var url ="";
	if(cellvalue!=null && cellvalue!=undefined){
		url = "<a href='"+StrreplaceAll(cellvalue, '&amp;','&')+"' target='_blank'>"+StrreplaceAll(cellvalue, '&amp;','&')+"</a>";
	}
	
    return url;
	
}

function fm_webtob_url(cellvalue, options, rowObject){
	
	var url ="";
	if(cellvalue!=null && cellvalue!=undefined){
		url = ""+StrreplaceAll(cellvalue, '&amp;','&')+"";
	}
	
    return url;
	
}




function fm_alive_yn(cellvalue, options, rowObject){
	var yn_str=""
	if(cellvalue == 'Y'){
		yn_str = "사용가능";
	}else if(cellvalue == 'N'){
		yn_str = "<span class='fc_red_normal'>사용불가</span>"
	}else{
		yn_str = ""
	}
	return yn_str
}


//TODO : refreshGrid 
//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	//console.log("111111");
	CmopenLoading();
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';

	searchYn = true;
	var params = getGridParamDatas();
	
	com.grid.reload('#jqGrid','<c:url value='/cmsajax.do'/>',params);

	setTimeout(CmcloseLoading,1000);

}

//TODO : getGridParamDatas 
//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	//$("#pstate").val("X");
	//var _params =  $("form[name=listfrm]").serialize();
	//console.log(_params);
	var _params = com.frm.getParamJSON2(document.listfrm);
	
	return _params;
	
}

function sechnotin(){
	   var m_Sp = /[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\<\>]/;
	   var m_val = document.getElementsByName("se_text")[0].value;
	   var strLen = m_val.length;
	   var m_char = m_val.charAt((strLen) - 1);
	   if(m_char.search(m_Sp) != -1) {
	      alert("특수문자는 사용할수없습니다.");
	      document.getElementsByName("se_text")[0].value = "";
	      document.getElementsByName("se_text")[0].focus();
	      return;
	   }
}

function srchCheck(){
	if(event.keyCode==13){
		$("#btn_search").trigger("click");
	}
}

//]]>
</script>
