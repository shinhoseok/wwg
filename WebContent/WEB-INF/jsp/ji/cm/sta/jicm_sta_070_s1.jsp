<%--
/*=================================================================================*/
/* 시스템            : 시스템 통계 / 통계 / 데이터 제공 요청
/* 프로그램 아이디   : /WEB-INF/jsp/ji/sta/jista_010_m1.jsp
/* 프로그램 이름     : jista_070_s1
/* 소스파일 이름     : jista_070_s1.jsp
/* 설명              : 데이터 종류별
/* 버전              : 1.0.0
/* 최초 작성자       : 윤성종
/* 최초 작성일자     : 2018-03-12
/* 최근 수정자       : 윤성종
/* 최근 수정일시     : 2018-03-12
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
	    <col width="30" />
	    <col width="*" />
	    <col width="50" />
	    <col width="*" />
	    </colgroup>
	    <tr>
		    <th scope="row">조회기간</th>
		        <td colspan="2">
					<input type="text" name="start_ymd" id="start_ymd" value="" onclick="Calendar_D(document.getElementById('start_ymd'))" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" readonly="readonly" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('start_ymd'));return false;"></a></span>
					<span class="clear"> ~&nbsp;</span> 
					<input type="text" name="end_ymd" id="end_ymd" value="" onclick="Calendar_D(document.getElementById('end_ymd'))" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" readonly="readonly" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('end_ymd'));return false;"></a></span>
		       </td>
		    <td colspan="2" class="aR"> 
				<span class="btn_pack large vM"><a href="#" id="btn_search">검색</a></span> 
				<span class="btn_pack largeO vM"><a href="#" id="btn_excel_down_day">엑셀다운로드</a></span>    
			</td>
		 </tr>
	  </table>
	</div>
	
	
	<!-- <h3><span>&#8226;</span> 홈페이지 방문</h3> -->
	<div id="chart" style="height:550px; "></div>
	<span style="display:none;"><table id='jqGrid'></table></span>
	
</form>






<script type="text/javascript">

//초기화
$(document).ready(function() {
	
	//현재 날짜 기본설정
	$("#start_ymd").val("<%=DateUtility.getaddmon(curDate,"-", 11).substring(0,4)+"-"+DateUtility.getaddmon(curDate,"+", 1).substring(4,6)+"-"+DateUtility.getaddmon(curDate,"-", 1).substring(6,8)%>"); // 1년 전 데이타 설정
	$("#end_ymd").val("<%=curDate.substring(0,4)+"-"+curDate.substring(4,6)+"-"+ curDate.substring(6,8)%>");
	
	var cols =[
	           	 {label:'번호'       ,index:'stdinfo_dtl_cd'   ,name:'stdinfo_dtl_cd'   ,align:'center' 	,width:'50'	  ,hidden:true  ,sortable:true}
	           	/* ,{label:'일별'    ,name:'reg_mon'        ,index:'reg_mon'     ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false} */
	           	,{label:'내용'    ,name:'stdinfo_dtl_nm'        ,index:'stdinfo_dtl_nm'     ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false}
	           	,{label:'건수'  ,name:'cnt'       ,index:'cnt'    ,align:'center'  ,width:'100'  ,hidden:false  ,sortable:false}
		      ];
	
	//init grid
	var grid = com.grid.init({
		id			: '#jqGrid'
		,viewrecords: true
		,multiselect: true
		,height		: 452
		,autowidth  : true
		,rowNum		: 100
		,rowList		: 100
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
		
		refreshDes();
	});
	
	$("#btn_excel_down_day").on("click",function(e){
		$("#pstate").val("X11");
		excelDownload3("jqGrid", "A", $("#start_ymd").val()+"~"+$("#end_ymd").val()+"_데이터종류");
		$("#pstate").val("L");		
	});
	
	refreshGrid(); //조회
	// 화면로딩시 기본검색
	$("#btn_search").trigger("click");
	
});

//검색
function refreshDes(){
	 
	var start_ymd = $("#start_ymd").val();
	var end_ymd = $("#end_ymd").val();
	var checkdate = addDate("m",1,start_ymd,"-");
	
	if(parseInt(start_ymd.replace(/-/g,"")) > parseInt(end_ymd.replace(/-/g,""))){
		alert('종료일이 시작일보다 이전일수 없습니다.');
		return;
	}
	
	$("#chart2").empty();
	
	//추이그래프 생성
	$("#pstate").val("X7");
	var params =  $("form[name=listfrm]").serialize();
	
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
        	CmcloseLoading();          
        },
        success: function(data){
           if(data.result==true){
        	   
				if(data.rows!=""){
					//console.log(data.cumulativeCount);
					$("#page_info_id").html("[누적 건수 총 <b>"+data.cumulativeCount+"</b>건]");
					addHichartGraph(data) // 하이차트 그래프 생성
					// addChart(data);	//그래프 생성
					
				}else{
				
				}
           
           }else{
	        	alert(data.TRS_MSG);
	        	top.location.href="<%=RequestURL%>";
	        	
           }
		
        }
	
	});
	
}

function refreshGrid(){
	var _frm = document.listfrm;
	var start_ymd = $("#start_ymd").val();
	var end_ymd = $("#end_ymd").val();
	var checkdate = addDate("m",1,start_ymd,"-");
	
	_frm.action='<%=RequestURL%>';
	var params = com.frm.getParamJSON(document.listfrm);
	params.pstate = 'X11';
	com.grid.reload('#jqGrid','/cmsajax.do',params);
}

function addChart(res_data){
	 
	var hi=0;
	var rows = res_data.rows;

	
	var items1 = new Array();
	
	for(hi=0;hi<rows.length;hi++){
		
		//추이그래프
		var tempItems1 = new Array();
		
		tempItems1.push(rows[hi].stdinfo_dtl_nm, rows[hi].cnt);
		
		items1[hi] = tempItems1;
	}
	
	$("#chart2").empty();
	$.jqplot.config.enablePlugins = true;
	
	//그래프
	var plot1 = $
		.jqplot(
			'chart2',
			eval([ items1 ]),
			{
				//title : '데이터 종류별',
				animate: true,
				seriesDefaults : {
						shadow : false,
						renderer:$.jqplot.BarRenderer,
						rendererOptions :{
						varyBarColor: true
						
						/*
						startAngle : -90,
						showDataLabels : false,
						dataLabels : 'value',
						totalLabel : false
						*/
						}
				},
    	        axesDefaults : {
	    	        	tickRenderer : $.jqplot.CanvasAxisTickRenderer,
	    	        	tickOptions:{
	    	        		//angel : -100,
	    	        		fontsize : '10pt'
	    	        		
	    	        	}
    	        	
    	        },
    	        axes:{
    	            xaxis:{
    	                renderer: $.jqplot.CategoryAxisRenderer
    	            }
    	        
    	        },
    	        highlighter: {	// 막대그래프 툴팁 옵션(Mousehover)
		            show: false,
		            //showLabel: true,
		            //tooltipAxes: 'y'	// 그래프 상단에 보여지게 Y축을 기준으로 보여지게 하는 것
		            //sizeAdjust: 7.5, 
		            //tooltipLocation : 'ne'
	        	},
				/*
				seriesColors:[  
								"#2d94d4",
								"#d4e8dc",
								"#95d4d0",
								"#ef4e4c",
								"#a7d163",
								"#15708c",
								"#fcb94c",
								"#111"
						     ],
								
				*/
				
				/* 									
				legend : {
					show : legendShow,
					location : 's',
					placement : 'outside',
					marginTop : '30px',
					rendererOptions : {
						numberRows : 1
					}
				}, 
				*/
				
				/*
				grid : {
					drawGridlines : false,
					background : 'White',
					borderColor : 'white',
					shadow : false
				}
				*/
				
			}); // var par1
		
		
 	   $("#chart2").height($("#chart2").height()+30);
	   $(".jqplot-axis").height(30);
	
} // addChart

//하이차트 그래프 생성
function addHichartGraph(data){
	
	console.log(data);
	
	var arrData = new Array();
	var arrCategories = new Array(); //카테고리
	
	for (i in data.rows) {
		
		var obj = { "name" : data.rows[i].stdinfo_dtl_nm, "y" : data.rows[i].cnt };
		arrData[i] = obj;
	}
	
    // 카테고리 생성
    for (i in data.rows) {
        var obj = data.rows[i].stdinfo_dtl_nm;
        arrCategories[i] = obj;
    }
	
	// 차트 세팅
    Highcharts.setOptions({  //모든숫자 천단위콤마
        lang: {
            thousandsSep: ','
        }
    });
	
	Highcharts.chart('chart', {
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: null
	    },
	    subtitle: {
	        text: ''
	    },
	    xAxis: {
	    	categories: arrCategories,
	    	crosshair: true
	    },
	    yAxis: {
	    	min: 0,
	        title: {
	            //text: 'Rainfall (mm)'
	        },
	        allowDecimals:false
	    },
	    tooltip: {
			headerFormat: '<span style="font-size: 10px">{point.key}</span><table>',
			pointFormat: '<tr><td style="color:{series.color}; padding:0>{series.name}: </td>'
						+'<td style="padding:0"><b>{point.y} </b></td></tr>',
			footerFormat: '</table>',
			shared: true,
			useHTML: true
	    },
	    plotOptions: {
			column: {
				pointPadding: 0.2,
				borderWidth: 0
			}
	    },
        legend: {
        	enabled: false
        },
	    series: [{
	    	colorByPoint: true,
	        name  : '',
	        data  : arrData
	    }]
	});
}
</script>
