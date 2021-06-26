<%--
/*=================================================================================*/
/* 시스템            : 시스템 통계 / 개인정보관련 통계 / 개인정보 접속 이력
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/sta/jicm_sta_050_s1.jsp
/* 프로그램 이름     : jicm_sta_050_s1
/* 소스파일 이름     : jicm_sta_050_s1.jsp
/* 설명              : 요청분류별
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2019-08-06
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2019-08-06
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<script type="text/javascript" src="/js/highcharts/highcharts.js"></script>  <!-- 하이차트js -->
<script type="text/javascript" src="/js/highcharts/exporting.js"></script>   <!-- 하이차트 옵션 파일내보내기관련 js -->
<script type="text/javascript" src="/js/highcharts/export-data.js"></script> <!-- 하이차트 옵션 파일내보내기관련 js -->


<form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();' >        
<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
<input type="hidden" name="sidx" value="" title="선택된인덱스" />

	<p class="count" id="page_info_id"></p>
	
	<div class="searchArea mT10 ">
	  <table class="tbl_search">
	    <colgroup>
	    <col width="50" />
	    <col width="*" />
	    <col width="50" />
	    <col width="*" />
	    <col width="*" />
	    </colgroup>
	    <tr>
		    <th scope="row">조회기간</th>
		        <td >
					<input type="text" name="start_ymd" id="start_ymd" value="" onclick="Calendar_D(document.getElementById('start_ymd'))" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" readonly="readonly" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('start_ymd'));return false;"></a></span>
					<span class="clear"> ~&nbsp;</span> 
					<input type="text" name="end_ymd" id="end_ymd" value="" onclick="Calendar_D(document.getElementById('end_ymd'))" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" readonly="readonly" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('end_ymd'));return false;"></a></span>
		       </td>
		    <th scope="row">대상메뉴</th> 
		    	<td>  
					<select name="target_menu" id="target_menu" title="대상매뉴 선택">
							<option value="">선택</option>
							<c:forEach var="list" items="${R_MAP.privMenuList}" varStatus="status">
								<option value="<c:out value='${list.menu_cd}'/>" ><c:out value="${list.menu_nm}"/></option>
							</c:forEach>											
						</select>
				</td>		       
		    <td class="aR"> 
				<span class="btn_pack large vM"><a href="#" id="btn_search">검색</a></span> 
<!-- 				<span class="btn_pack largeO vM"><a href="#" id="btn_excel_down_day">엑셀다운로드</a></span>  -->
			</td>
		 </tr>
	  </table> 
	</div>	
	
	<!-- <h3><span>&#8226;</span> 요청분류별</h3> -->
	<span style="display:;"><table id='jqGrid'></table></span>
	
</form>






<script type="text/javascript">
//초기화
$(document).ready(function() {
	
	//현재 날짜 기본설정
	$("#start_ymd").val("<%=DateUtility.getaddmon(curDate,"-", 11).substring(0,4)+"-"+DateUtility.getaddmon(curDate,"+", 1).substring(4,6)+"-"+DateUtility.getaddmon(curDate,"-", 1).substring(6,8)%>"); // 1년 전 데이타 설정
	$("#end_ymd").val("<%=curDate.substring(0,4)+"-"+curDate.substring(4,6)+"-"+ curDate.substring(6,8)%>");
	
	var cols =[
	           	 {label:'번호'      	,index:'row_seq'   				,name:'row_seq'   			,align:'center' 	,width:'50'	  ,hidden:false  ,sortable:false}
	           	,{label:'메뉴'    	,index:'menu_nm'				,name:'menu_nm'   			,align:'center'  	,width:'150'  ,hidden:false  ,sortable:false}
	           	,{label:'일시'    	,index:'reg_dt'					,name:'reg_dt'    			,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	,{label:'수행업무'    	,index:'menu_pstate_nm'			,name:'menu_pstate_nm'    	,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false ,formatter : fmmenu_pstate_nm}
	           	,{label:'접속자'    	,index:'reg_id_nm'				,name:'reg_id_nm'    		,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	,{label:'접속자IP'    ,index:'ac_ip'					,name:'ac_ip'    			,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	,{label:'글번호'    	,index:'data_seq'				,name:'data_seq'    		,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	,{label:'작성자'    	,index:'reg_nm'					,name:'reg_nm'    			,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	,{label:'글제목'    	,index:'data_title'				,name:'data_title'    		,align:'center'  	,width:'120'  ,hidden:false  ,sortable:false}
	           	
	           	,{label:'key'  		,index:'reg_id'					,name:'reg_id'   			,align:'center'  	,width:'0'  ,hidden:true  ,sortable:false}
	           	,{label:'key'  		,index:'aces_log_desc'			,name:'aces_log_desc'   	,align:'center'  	,width:'0'  ,hidden:true  ,sortable:false}
	           	,{label:'key'  		,index:'menu_ori_pstate'		,name:'menu_ori_pstate'   	,align:'center' 	,width:'0'  ,hidden:true  ,sortable:false}
	           	,{label:'key'  		,index:'menu_pstate'			,name:'menu_pstate'       	,align:'center'  	,width:'0'  ,hidden:true  ,sortable:false}
	           	,{label:'key'  		,index:'menu_cd'				,name:'menu_cd'           	,align:'center'  	,width:'0'  ,hidden:true  ,sortable:false}
	           	,{label:'key'  		,index:'aces_log_seqno'			,name:'aces_log_seqno'    	,align:'center'  	,width:'0'  ,hidden:true  ,sortable:false}
		      ];
	
	//init grid
	var grid = com.grid.init({
		id			: '#jqGrid'
		,viewrecords: true
		,multiselect: false
		,height		: 452
		,autowidth  : true
		,rowNum		: 100
		,rowList	: 100
		,scroll : 1
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
	
	
	// 검색
	$("#btn_search").click( function() {
		
		refreshGrid();
	});
	
	$("#btn_excel_down_day").on("click",function(e){
		$("#pstate").val("X9");
		excelDownload3("jqGrid", "A", $("#start_ymd").val()+"~"+$("#end_ymd").val()+"_<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%>");
		$("#pstate").val("L");		
	});
	
	refreshGrid(); //조회
	
});


function refreshGrid(){
	var _frm = document.listfrm;
	var start_ymd = $("#start_ymd").val();
	var end_ymd = $("#end_ymd").val();
	var checkdate = addDate("m",1,start_ymd,"-");
	
	if(parseInt(start_ymd.replace(/-/g,"")) > parseInt(end_ymd.replace(/-/g,""))){
		alert('종료일이 시작일보다 이전일수 없습니다.');
		return;
	}
	
	_frm.action='<%=RequestURL%>';
	var params = com.frm.getParamJSON(document.listfrm);
	params.pstate = 'X9';
	com.grid.reload('#jqGrid','<c:url value="/cmsajax.do" />',params);
}

var fmmenu_pstate_nm = function(cellvalue, options, rowObject){
	
	
	var returnCell = "";
	//console.log(rowObject.auth_grp_nm);
	if (rowObject.menu_pstate != undefined && rowObject.menu_pstate != null && rowObject.menu_pstate != '') {
		if(rowObject.menu_pstate == "L"){
			returnCell = "조회";
		}else if(rowObject.menu_pstate == "C"){
			returnCell = "등록";
		}else if(rowObject.menu_pstate == "U"){
			returnCell = "수정";
		}else if(rowObject.menu_pstate == "D"){
			returnCell = "삭제";
		}
		
	}
	
	return returnCell;
};
</script>
