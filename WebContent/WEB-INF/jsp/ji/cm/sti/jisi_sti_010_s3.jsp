<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : main2    
/* 소스파일 이름     : main2.jsp
/* 설명              : SYSTEM 통계관리 메뉴별통계 메인페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-25
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-25
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<script type="text/javascript">
$(document).ready(function(){
	//현재 날짜 기본설정
	$("#start_ymd").val(getDateStr("m",-1));	// 한달 전 데이타 설정
	$("#end_ymd").val(getDateStr());
	chart();
	$("#btn_search").click( function() {
		var start_ymd = $("#start_ymd").val();
		var end_ymd = $("#end_ymd").val();
		var checkdate = addDate("m",1,start_ymd,"-"); 
		if(parseInt(start_ymd.replace(/-/g,"")) > parseInt(end_ymd.replace(/-/g,""))){
			alert('종료일이 시작일보다 이전일수 없습니다.');
			return;
		}
		if(parseInt(end_ymd.replace(/-/g,"")) > parseInt(checkdate.replace(/-/g,""))){
			alert('조회 기간은 한달 이내에만 가능합니다.');
			return;
		}
		chart();
		refreshGrid(); //조회
	});
    
	var cols =[
	           	{label:'번호'          ,index:'row_seq'     ,name:'row_seq'          ,align:'center' 		,width : '50',   	hidden:false, sortable : true }
	           	,{label:'메뉴명'    ,   name:'name'           ,index:'name'             ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false}
	           	,{label:'등록건수'    ,   name:'line1'           ,index:'line1'             ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
	           	,{label:'조회건수'    ,   name:'line2'           ,index:'line2'             ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
	           	,{label:'수정건수'    ,   name:'line3'           ,index:'line3'             ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
	           	,{label:'삭제건수'    ,   name:'line4'           ,index:'line4'             ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false }
		    ]
//init grid
var grid = com.grid.init({
id			: '#jqGrid' 
,viewrecords: true
,multiselect: true
,height		: 230
,autowidth : true
,rowNum		: 15
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
$('#tab_2').hide();	
	
	
$("#btn_excel").click(function(e){

	//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:""],엑셀명)
	excelDownload("jqGrid","","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 화면리스트");
	
});	

$("#btn_excelAll").click(function(e){
	
	//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명) - java 리스트쪽 구현해야함
	excelDownload("jqGrid","A","<%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("> ")+1)%> 전체리스트");

});


$("#li_1").click( function() {
	$('#li_1').attr('class','selected');
	$('#li_2').attr('class','');
	$('#tab_1').fadeIn(700);
	$('#tab_2').hide();
});

//작업계획 tab 클릭시
$("#li_2").click( function() {
	$('#li_1').attr('class','');
	$('#li_2').attr('class','selected');
	$('#tab_1').hide();
	$('#tab_2').fadeIn(700);
});
	
});



function refreshGrid(){
	var _frm = document.listfrm;
	_frm.action='<%=RequestURL%>';
	var params = com.frm.getParamJSON(document.listfrm);
	params.pstate = 'X1';
	com.grid.reload('#jqGrid','/cmsajax.do',params);
}


function refreshChart(){
	ParamDatas();
}

//그리드 조회시 요청할 파라미터 object
function ParamDatas(){
	var _params = com.frm.getParamJSON(document.listfrm);
	return _params;
}

function chart(){
	$("#chart1").empty();
	var crudDatachart = new Array();
	var name = new Array();
	var line1 = new Array();
	var line2 = new Array();
	var line3 = new Array();
	var line4 = new Array();
	var horizonbarchart = new Array();
	var params = ParamDatas();
	params.pstate = 'X';
	 $.ajax({
         type: "post",
         url: "/cmsajax.do",
         data: params,
         async: false,
         dataType:"json",
         success: function(data){
         	 if(data.result==false){
         		$("#chart1").empty();
         		 alert('데이터가 존재하지 않습니다');
         	 }else{
         		line1  = data.data1
         		line2  = data.data2
         		line3  = data.data3
         		line4  = data.data4
           	 $.jqplot.config.enablePlugins = true;
         		var legendlabels = ['등록','조회','수정','삭제'];
           	    var plot1 = $.jqplot('chart1', [line1,line2,line3,line4], {
           	        // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
           	        //title: '메뉴별 CRUD 통계 리스트',
           	        animate: true, 
           	        seriesDefaults:{
           	            renderer:$.jqplot.BarRenderer,
           	            pointLabels : {show:true , location: 'e',edgeTolerance:-15},
           	            shadowAngel :135,
           	            rendererOptions: {
           	                barDirection:'horizontal',
           	                highlightMouseDown : true
           	                //fillToZero:true
           	                //barMargin:30
           	            }
           	        },
           	        legend:{
           	        	show:false,
           	        	location :'e',
           	        	placement : "outside",
           	        	marginTop : "100px",
           	        	labels : legendlabels,
           	        	renderOptions:{numberRows:1}
           	        	
           	        },
           	        axesDefaults : {
           	        	tickRenderer : $.jqplot.CanvasAxisTickRenderer,
           	        	tickOptions:{
           	        		//angel : -100,
           	        		fontsize : '15pt'
           	        		
           	        	}
           	        	
           	        },
           	        axes:{
           	            yaxis:{
           	                renderer: $.jqplot.CategoryAxisRenderer
           	        
           	                //pad : 1.05
           	               
           	            }
           	        }
           	    });
           	    
            }
   	 }
  });	 
}    
	
</script>
					
<form name="listfrm" id="listfrm" method="post" onSubmit='return false;Go_search();'>        
<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드" />
<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호" />
<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수" />
<input type="hidden" name="sidx" value="" title="선택된인덱스" />

   <div class="section" style="position:relative;"> 
		<!-- tab -->
		<ul class="tab_menu">
			<li id="li_1" class="selected"><a href="#">차트보기</a></li>
			<li id="li_2" class=""><a href="#">리스트보기</a></li>
		</ul>
		<!-- tab //--> 
	</div>
	
<div class="searchArea mT10 ">
  <table class="tbl_search">
    <colgroup>
    <col width="50" />
    <col width="250" />
    <col width="50" />
    <col width="*" />
    <col width="50" />
    <col width="*" />
    </colgroup>
    <tr>
   <%--    <th scope="row">년도선택</th>
      <td  id="org_select_group">
        <select name="syear" id="syear">
          <option value="">--선택--</option>
          	<%=(String)rtn_Map.get("optionYear")%>
        </select>
      </td>
       <th scope="row">월선택</th>
      <td  id="org_select_group">
        <select name="smonth" id="smonth" >
          <option value="">--선택--</option>
          	<%=(String)rtn_Map.get("optionMonth")%>
        </select>
      </td> --%>
        <th scope="row">조회기간</th>
        <td>
        	<div class="item iDate mR5">
            <input type="text" name="start_ymd" id="start_ymd" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL" /> 
            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('start_ymd'));return false;"></a></span>
            </div>
            <span class="fL">~</span> 
            <div class="item iDate mL5">
            <input type="text" name="end_ymd" id="end_ymd" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL"/>
            <span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('end_ymd'));return false;" ></a></span>
            </div>
       </td>       
	<th scope="row">사이트선택</th>
      <td  id="org_select_group">
        <select name="siteCode" id="siteCode" title="사이트 선택">
          <option value="">--선택--</option>
          	<%=(String)rtn_Map.get("siteCode")%>
        </select>
      </td>      
   <td colspan="2" class="aR"> 
		<span class="btn_pack largeO"><a href="#" id="btn_search">검색</a></span>    
	</td>
	 </tr>
  </table>
  </div>
    <!-- end of search -->
  <div id="tab_1" class="">     
<h3><span>&#8226;</span>매뉴별 CRUD 통계 리스트</h3>    
   <div id="chart1" style="height:8000px;width:85%"></div>
</div>

<div id="tab_2" class="">   
    <div class="section">
	      <h3 class="fL mT10"><span>&#8226;</span>매뉴별 CRUD 통계 리스트</h3>
	      <p class="fR mB5"><!-- 	           <span class="btn_pack medium icon" id="btn_excel" ><span class="excel"></span><a href="# none;" >화면출력</a></span> --><!-- 	           <span class="btn_pack medium icon" id="btn_excelAll" ><span class="excel"></span><a href="# none;" >전체출력</a></span> -->	      </p>
    </div>
    <table id='jqGrid'></table>
 </div>  
</form>
					