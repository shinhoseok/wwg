<%--
/*=================================================================================*/
/* 시스템            : 시스템 통계 / 통계 / 홈페이지 운영실적
/* 프로그램 아이디   : /WEB-INF/jsp/ji/sta/jista_010_m1.jsp
/* 프로그램 이름     : jista_020_s1
/* 소스파일 이름     : jista_020_s1.jsp
/* 설명              : 분석보고서
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
<input type="hidden" name="p_start_ymd" id="p_start_ymd" value="" title="시작연월" />
<input type="hidden" name="p_end_ymd" id="p_end_ymd" value="" title="종료연월" />
<input type="hidden" name="sidx" value="" title="선택된인덱스" />

	
	<div class="searchArea mT10 ">
	  <table class="tbl_search">
	    <colgroup>
	    <col width="50" />
	    <col width="*" />
	    <col width="*" />
	    <col width="*" />
	    </colgroup>
	    <tr>
	    	<!-- 
		    <th scope="row">조회기간</th>
		        <td>
					<input type="text" name="start_ymd" id="start_ymd" value="" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('start_ymd'));return false;"></a></span>
					<span class="clear"> ~&nbsp;</span> 
					<input type="text" name="end_ymd" id="end_ymd" value="" size="12" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" title="팝업존시작일 입력" />
					<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('end_ymd'));return false;"></a></span>
		       </td>
			 -->
            <th scope="row">검색어</th>
            <td><input type="text" name="searchText" id="searchText" title="검색어 입력"></td>
		    <td colspan="2" class="aR">
				<span class="btn_pack large vM"><a href="#" id="btn_search">검색</a></span>    
			</td>
		 </tr>
	  </table>
	</div>
	
	<!-- <h3><span>&#8226;</span> 분석 보고서</h3> -->
	<div id="chart" style="height:640px; "></div>
	
</form>


<script type="text/javascript">

//초기화
$(document).ready(function() {
	
	//현재 날짜 기본설정
	$("#start_ymd").val("<%=DateUtility.getaddmon(curDate,"-", 11).substring(0,4)+"-"+DateUtility.getaddmon(curDate,"+", 1).substring(4,6)+"-"+DateUtility.getaddmon(curDate,"-", 1).substring(6,8)%>");	// 한달 전 데이타 설정
	$("#end_ymd").val("<%=curDate.substring(0,4)+"-"+curDate.substring(4,6)+"-"+ curDate.substring(6,8)%>");
	
	// 검색
	$("#btn_search").click( function() {
		
		refreshDes();
	});
	
	
	// 화면로딩시 기본검색
	$("#btn_search").trigger("click");
	
});

//검색
function refreshDes(){
	
	 /* 
	var start_ymd = $("#start_ymd").val().substr(0, 7);
	var end_ymd = $("#end_ymd").val().substr(0, 7);
	$("#p_start_ymd").val(start_ymd); 	//시작연월
	$("#p_end_ymd").val(end_ymd);		//종료연월
	
	
	if(parseInt(start_ymd.replace(/-/g,"")) > parseInt(end_ymd.replace(/-/g,""))){
		alert('종료일이 시작일보다 이전일수 없습니다.');
		return;
	}
	 */
	 
	$("#chart").empty();
	
	//추이그래프 생성
	$("#pstate").val("X2");
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
					
					addHichartGraph(data);	// 하이차트 그래프 생성
					//addChart(data);		// 그래프 생성
				}else{
				
				}
           
           }else{
	        	alert(data.TRS_MSG);
	        	top.location.href="<%=RequestURL%>";
	        	
           }
		
        }
	
	});
	
}

function addChart(res_data){

	var hi=0;
	var rows = res_data.rows;

	var items1 = new Array();
	
	
	for(hi=0;hi<rows.length;hi++){
		
		//추이그래프
		var tempItems1 = new Array();
		
		tempItems1.push(rows[hi].inq_cnt, rows[hi].data_title);
		
		items1[hi] = tempItems1;
	}
	
	
	 $.jqplot.config.enablePlugins = true;
	 
	  //그래프
	  var plot1 = $.jqplot('chart', [items1], {
	       // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
	       // title: '분석보고서',
	       animate: true, 
	       seriesDefaults:{
				           renderer:$.jqplot.BarRenderer,
				           pointLabels : {show:true , location: 'e',edgeTolerance:-15},
				           shadowAngel :135,
				           rendererOptions: {
				               barDirection:'horizontal',
				               barMargin:30, 
				               fillToZero:true
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
	              yaxis:{
	               		  renderer: $.jqplot.CategoryAxisRenderer
	               		  //pad : 1.05,
	                      
	              		}
	       }
	
	   });
	   
	   $("#chart").height($("#chart").height()+30);
	   $(".jqplot-axis").height(30);
	   
} // addChart

//하이차트 그래프 생성
function addHichartGraph(data){
	
	console.log(data);
	
    var arrData = new Array();
    var arrCategories = new Array();
    
    for (i in data.rows) {
        //var obj = { "name" : data.rows[i].data_title, "data" : [Number(data.rows[i].inq_cnt)] };
        arrData[i] = Number(data.rows[i].inq_cnt);
    }
    
    for (i in data.rows) {
        var obj = data.rows[i].data_title;
        arrCategories[i] = obj;
    }
    
    // 차트 세팅
    Highcharts.setOptions({  //모든숫자 천단위콤마
        lang: {
            thousandsSep: ','
        }
    });
    
    
    // 하이차트 시작
    Highcharts.chart('chart', {
        chart: {
            type: 'bar'
        },
        title: {
            //text: '분석 보고서'
        	text: null
        },
        xAxis: {
            categories: arrCategories
        },
        yAxis: {
            min: 0,
            title: {
                //text: 'Total fruit consumption'
            	text: null
            }
        },
        tooltip: {
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
	    series: [{
	    	colorByPoint: true,
	        name  : '',
	        data  : arrData
	    }]
    });
	
	
	/* 
    for (i in data.rows) {
        var obj = { "name" : data.rows[i].data_title, "data" : [Number(data.rows[i].inq_cnt)] };
        arrData[i] = obj;
    }
	
	// 하이차트 시작
    Highcharts.chart('chart', {
        chart: {
            type: 'bar'
        },
        title: {
            text: '평균판매단가'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [
         				"10년 동안의 전력 사용량 변화로 본 지자체별 제조업 현황",
         				"전기차 보급 지역별 충전기 수요",
         				"주택 태양광 설치로 인한 전기요금 절감",
         				"10년 동안의 전력 사용량 변화로 본 주요 업황",
         				"지역별 전력사용량 비교",
         				"10년간 국가전력 사용량 변화"
			],
            type: null,
            reversed:false,
            title: {
                text: null
            },
            labels: {
                enabled: false
            }
        },
        yAxis: {
        	minPadding: 0.01,
            min: 0,
            title: {
                text: '',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            formatter : function () {
            	return this.series.name + ': <b>' + this.y + '</b>';
            }
        },
        plotOptions: {
        	series: {
        		groupPadding: 0,
        		pointPadding: 0
        	},
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            showInLegend: true
        },
        legend: {
        },
        credits: {
            enabled: false
        },
        series: arrData
    });
     */
}

</script>
