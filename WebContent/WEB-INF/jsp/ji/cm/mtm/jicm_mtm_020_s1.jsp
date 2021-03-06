<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : list  
/* 소스파일 이름     : list.jsp
/* 설명              : SYSTEM 코드관리 목록페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-05
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-05
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");
String se_code	= HtmlTag.returnString((String)request.getAttribute("se_code"),"000000");
String se_lv	= HtmlTag.returnString((String)request.getAttribute("se_lv"),"1");
String sel_num	= HtmlTag.returnString((String)request.getAttribute("sel_num"),"");
String se_code_up_c	= HtmlTag.returnString((String)request.getAttribute("se_code_up_c"),"000000");
ArrayList se_code_arr =  new ArrayList();
if(!sel_num.equals("")){
	for(int r=0;r<=Integer.parseInt(sel_num,10);r++){
		se_code_arr.add(HtmlTag.returnString((String)request.getAttribute("dto_SELMENU_"+r),""));
	}
}
%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<script type="text/javascript">
$(function(){
	//기준정보 리스트
		var cols =[
					 {label:'번호'    		,name:'row_seq'           ,index:'row_seq'           ,align:'center'  ,width:'50'   ,hidden:false  ,sortable:false }
					,{label:'메뉴명'    	,name:'menu_nm'           ,index:'menu_nm'           ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
					,{label:'업무 제목'    ,name:'menu_data_title'   ,index:'menu_data_title'   ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
					,{label:'파일명'   		,name:'file_nm'           ,index:'file_nm'           ,align:'left'    ,width:'250'  ,hidden:false  ,sortable:false, formatter : filedown }
					,{label:'파일크기'     ,name:'file_size'         ,index:'file_size'         ,align:'center'  ,width:'70'   ,hidden:false  ,sortable:false }
					,{label:'파일 순번'    ,name:'file_order_no'     ,index:'file_order_no'     ,align:'center'  ,width:'50'   ,hidden:false  ,sortable:false }
					,{label:'등록자'    	,name:'regst_emp_nm'       ,index:'regst_emp_nm'     ,align:'center'  ,width:'50'   ,hidden:false  ,sortable:false }					
					,{label:'등록일자'     ,name:'regst_ymd'          ,index:'regst_ymd'        ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
					,{label:'key'    		,name:'file_seqno'         ,index:'file_seqno'       ,align:'center'  ,width:'100'  ,hidden:true   ,sortable:false }
			    ]
//init grid
var grid = com.grid.init({
	 id			: '#jqGrid' 
	,viewrecords: true
	,height		: 350
	,autowidth : true
	,rowNum		: 15
	,gridComplete: function(){
		mergeCellcomplet($(this));
	}
	,onSelectRow: function(id) { // row를 선택했을때 액션.
		//var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
		//var value1 = ret.std_info_seqno; // 이런식으로 값을 가져올 수 있다.
		
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
		refreshGrid();
	});
	
	$("#btn_menu_search").click( function() {
		popWinScroll("/cmsmain.do?scode=000008&pcode=000326&dto_FUN_FN=setMenuAdd&pstate=PF1&multi_yn=Y&check_yn=Y", "MenuWinPop", 500, 680);
	});	
	
	
	
	$("#btn_excel").click(function(e){
		//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:""],엑셀명)
		excelDownload("jqGrid", "", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트", "<c:url value='/cmsmain.do'/>");		
	});	
	
	$("#btn_excelAll").click(function(e){
		//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
		excelDownload("jqGrid", "A", "<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트", "<c:url value='/cmsmain.do'/>");
	});
});


//인력 수정화면 이동
function filedown(cellvalue, options, rowObject) {
	var url ="";
	url = "<a href='#' onclick=down('" + rowObject.file_seqno + "'); ><font color='blue'>" + textToHtml(cellvalue)  + "</font></a>";
    return url;
}

function down(file_seqno){
	$.fn.cmfile.fileDownLoad("",file_seqno);
	
}
//메뉴 검색팝업 리턴값 셋팅
function setMenuAdd(rtnArr){
	$("#menu_cd").val(rtnArr[0].join(','));		//코드
	$("#menu_nm").val(rtnArr[1].join(','));			//코드명
}

//조회 : 그리드 조회
function refreshGrid(isNotCheckVal){
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	var params = getGridParamDatas();
	com.grid.reload('#jqGrid','/cmsajax.do',params);
}

//그리드 조회시 요청할 파라미터 object
function getGridParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	_params.pstate = 'X1';
	return _params;
}


</script>

<form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" value="" title="선택된인덱스" />
<div class="searchArea">
  <table class="tbl_search">
    <colgroup>
	    <col width="80" />
	    <col width="180" />
	    <col width="80" />
	    <col width="150" />
	    <col width="*" />
    </colgroup>
    <tr>
      <th scope="row">메뉴선택</th>
      <td><div class="item iSearch">
          <input type="text" name="menu_nm" id="menu_nm" readonly="readonly" />
          <span class="btnIc_search" id="btn_menu_search"><a href="#"></a></span></div>
          <input type="hidden" name="menu_cd" id="menu_cd" /></td>
      <th scope="row">검색구분</th>
	      <td><select id="searchType" name="searchType" style="width:100px;" title="검색 조건 선택">
		          <option value="">-- 선택 --</option>
		          <option value="1">업무제목</option>
		          <option value="2">파일이름</option>
		          <option value="3">등록자</option>
			  </select>
	</td>     
      <th scope="row">검색어</th>
      <td>
          <input type="text" name="searchText" id="searchText" />
	  </td>
         <th scope="row">등록기간</th>
         <td>
        	<div class="item iDate mR5">
            <input type="text" name="start_ym" id="start_ym" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL" /> 
            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('start_ym'));return false;"></a></span>
            </div>
            <span class="fL">~</span> 
            <div class="item iDate mL5">
            <input type="text" name="end_ym" id="end_ym" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL"/>
            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('end_ym'));return false;" ></a></span>
            </div>
       </td>	  
  	<td class="aR">
    	<span class="btn_pack large"><a href="#" id="btn_search">검색</a></span>
	</td>  	     	  
    </tr>
  </table>
  </div>
    <!-- end of search -->
       <div class="section">
	      <h3 class="fL"><span>&#8226;</span>권한 그룹 조회</h3>
	      <p class="fR mT5">
<!-- 	           <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="# none;" >화면출력</a></span> -->
<!-- 	           <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="# none;" >전체출력</a></span> -->
	      </p>
    </div>
    <table id='jqGrid'></table>
</form>
