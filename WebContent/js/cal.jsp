<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : CmMain    
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
/* 설명              : SYSTEM 시스템 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-01-27
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-01-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="egovframework.rte.fdl.property.impl.EgovPropertyServiceImpl"%>
<%
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
String _context_root = request.getSession().getServletContext().getContextPath(); //context root 
_context_root = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("CON_ROOT"); //propertie에 설정된 context root
%>
<%

String img_url = _context_root+"/images";
%><!-- 공통 jsp 파일-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="googlebot" content="noindex" />
<meta http-equiv="X-UA-Compatible" content="IE-Edge" />
<title>달력 | 도서발전통합관리시스템</title>

<script type="text/javascript">
//<![CDATA[
	function doOver() {
		var el = event.srcElement;
		cal_Day = el.title;

		if (cal_Day.length > 7) {
			el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
			el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
		}
	}

	function doOut(){
		var el = event.srcElement;
		cal_Day = el.title;

		if (cal_Day.length > 7){
			el.style.borderColor = "white";
		}
	}

	function day2(d) {																// 2자리 숫자료 변경
		var str = new String();
		d = ""+d;
		if (parseInt(d) < 10) {
			str = "0" + parseInt(d);
		} else {
			str = "" + parseInt(d);
		}
		return str;
	}
	
	function Show_cal(sYear, sMonth, sDay) {
		var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
		//var Weekday_name = new Array("일", "월", "화", "수", "목", "금", "토");
		var Cal_HTML = "";
		var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();
		document.all.cal.innerHTML = "";
		datToday = new Date();													// 현재 날자 설정

		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		intThisDay = parseInt(sDay);
		//alert(intThisYear+"::"+intThisMonth+"::"+intThisDay);


		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// 값이 없을 경우
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// 월 값은 실제값 보다 -1 한 값이 돼돌려 진다.
		if (intThisDay == 0) intThisDay = datToday.getDate();

		switch(intThisMonth) {
			case 1:
					intPrevYear = intThisYear -1;
					intPrevMonth = 12;
					intNextYear = intThisYear;
					intNextMonth = 2;
					break;
			case 12:
					intPrevYear = intThisYear;
					intPrevMonth = 11;
					intNextYear = intThisYear + 1;
					intNextMonth = 1;
					break;
			default:
					intPrevYear = intThisYear;
					intPrevMonth = parseInt(intThisMonth) - 1;
					intNextYear = intThisYear;
					intNextMonth = parseInt(intThisMonth) + 1;
					break;
		}
		intPPyear = intThisYear-1
		intNNyear = intThisYear+1

		NowThisYear = datToday.getFullYear();										// 현재 년
		NowThisMonth = datToday.getMonth()+1;										// 현재 월
		NowThisDay = datToday.getDate();											// 현재 일

		datFirstDay = new Date(intThisYear, intThisMonth-1, 1);						// 현재 달의 1일로 날자 객체 생성(월은 0부터 11까지의 정수(1월부터 12월))
		intFirstWeekday = datFirstDay.getDay();										// 현재 달 1일의 요일을 구함 (0:일요일, 1:월요일)

		intSecondWeekday = intFirstWeekday;
		intThirdWeekday = intFirstWeekday;

		datThisDay = new Date(intThisYear, intThisMonth, intThisDay);				// 넘어온 값의 날자 생성
		intThisWeekday = datThisDay.getDay();										// 넘어온 날자의 주 요일

		//varThisWeekday = Weekday_name[intThisWeekday];								// 현재 요일 저장

		intPrintDay = 1;																// 달의 시작 일자
		secondPrintDay = 1;
		thirdPrintDay = 1;

		Stop_Flag = 0

		if ((intThisYear % 4)==0) {													// 4년마다 1번이면 (사로나누어 떨어지면)
			if ((intThisYear % 100) == 0) {
				if ((intThisYear % 400) == 0) {
					Months_day[2] = 29;
				}
			} else {
				Months_day[2] = 29;
			}
		}
		intLastDay = Months_day[intThisMonth];										// 마지막 일자 구함


	
	Cal_HTML += "<table class='calBox'>";
	Cal_HTML += "<tr class='calselect'>";
	Cal_HTML += "<td colspan='6'><img src='<%=img_url%>/cm/cal/icon_arrow9.jpg' alt='이전달' OnClick='Show_cal("+intPrevYear+","+intPrevMonth+","+intThisDay+");' style='cursor:hand' align='absmiddle'> ";
	Cal_HTML += "<select class='iYear' name='iYear' onchange='Show_cal(this.value,document.getElementsByName(\"iMonth\")[0].value,"+intThisDay+");'>";
	
	for(cai=1960;cai<=2030;cai++){
		if (intThisYear == cai){
			Cal_HTML += "	<option value="+cai+" selected >"+cai+"</option>";
		}else{
			Cal_HTML +=  "	<option value="+cai+">"+cai+"</option>";
		}	
	}

	Cal_HTML +=  "</select>년";
	Cal_HTML +=  "<select class='iMonth' name='iMonth' onchange='Show_cal(document.getElementsByName(\"iYear\")[0].value,this.value,"+intThisDay+");' style='width:40px;'>";

	for(cami=1;cami<=12;cami++){
		if (intThisMonth == cami){
			Cal_HTML += "	<option value="+cami+" selected >"+cami+"</option>";
		}else{
			Cal_HTML +=  "	<option value="+cami+">"+cami+"</option>";
		}	
	}


	Cal_HTML +=  "</select>월 <img src='<%=img_url%>/cm/cal/icon_arrow10.jpg' alt='다음달' OnClick='Show_cal("+intNextYear+","+intNextMonth+","+intThisDay+");' style='cursor:hand' align='absmiddle'></td><td><img src='<%=img_url%>/cm/cal/icon_close.png' onmouseover=this.src='<%=img_url%>/cm/cal/icon_close_over.png' onmouseout=this.src='<%=img_url%>/cm/cal/icon_close.png'  border='0' alt='닫기' onclick='parent.Calendar_Close();' style='cursor:hand;' align='absmiddle'>";
	Cal_HTML +=  "</td>";
	Cal_HTML +=  "</tr>";
	
	//Cal_HTML +=  "<tr height='4' bgcolor='white'>";
	//Cal_HTML +=  "<td>";
	//Cal_HTML +=  "</td>";
	//Cal_HTML +=  "</tr>";

	Cal_HTML +=  "<tr>";
	Cal_HTML +=  "<td colspan='7'>";
	Cal_HTML +=  "<table class='calHeader'><tr>"; // 요일표시
	Cal_HTML +=  "<td class='sun'>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td class='sat'>토</td>";
	Cal_HTML +=  "</tr></table></td></tr>";
	
		//alert(intLastDay);
		for (intLoopWeek=0; intLoopWeek < 7; intLoopWeek++) {						// 주단위 루프 시작, 최대 6주
		
			Cal_HTML += "<tr><td colspan='7'><table  class='calBody'><tr>";
			for (intLoopDay=1 ;intLoopDay<= 7;intLoopDay++){// '요일단위 루프 시작, 일요일부터

				if (intThirdWeekday > 0){// '첫주시작일이 1보다 크면
					//alert(intThirdWeekday);
					Cal_HTML += "<td class='blank'>&nbsp;</td>";
					intThirdWeekday=intThirdWeekday-1;
				}else{
					if (thirdPrintDay > intLastDay){// '입력날짜가 월말보다 크다면
						Cal_HTML += "<td class='blank'>&nbsp;</td>";
					}else{// '입력날짜가 현재월에 해당되면
						Cal_HTML += "<td class='calDay' onClick='parent.Calendar_Click(this);' title=\""+intThisYear+"-"+day2(intThisMonth).toString()+"-"+day2(thirdPrintDay).toString()+"\" style='cursor: hand;";
						if  (intLoopDay==1){// '일요일이면 빨간 색으로
							Cal_HTML += "color:#FD7B97;";
						}else if( intLoopDay==7){
							Cal_HTML += "color:#3592CF;";
						}else{// ' 그외의 경우
							Cal_HTML += "color:#333;";
						}
						if (intThisYear-NowThisYear==0 && intThisMonth-NowThisMonth==0 && thirdPrintDay-intThisDay==0){ //'오늘 날짜이면은 글씨폰트를 다르게
							Cal_HTML += "background:#fffccc; color:#ff6600;";
							Cal_HTML +="'> "+thirdPrintDay;					
						}else{
							Cal_HTML += "' onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\" >"+thirdPrintDay;					
						}
					}
					thirdPrintDay=thirdPrintDay+1;// '날짜값을 1 증가

					if( thirdPrintDay > intLastDay){
						Stop_Flag=1;// '만약 날짜값이 월말값보다 크면 루프문 탈출
					}
				}
				Cal_HTML += "</td>"
			}//for종료
			Cal_HTML += "</tr></table></td></tr>";
			if (Stop_Flag==1) break;
		

		}
		Cal_HTML += "</table>";
		
		document.all.cal.innerHTML = Cal_HTML;

		// 달력 출력이 완료되면 iframe의 크기를 재조정한다.
		var Cal_Table = document.getElementById("cal");
		//alert(Cal_Table.offsetHeight);
		window.resizeTo(200, Cal_Table.offsetHeight);
	}
	


	function Show_cal_M(sYear, sMonth) {
		//var Weekday_name = new Array("일", "월", "화", "수", "목", "금", "토");
		var intThisYear = new Number(), intThisMonth = new Number()
		document.all.cal.innerHTML = "";

		intThisYear = parseInt(sYear);
		intThisMonth = parseInt(sMonth);
		datToday = new Date();

		if (intThisYear == 0) intThisYear = datToday.getFullYear();				// 값이 없을 경우
		if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// 월 값은 실제값 보다 -1 한 값이 돼돌려 진다.

		switch(intThisMonth) {
			case 1:
					intPrevYear = intThisYear -1;
					intNextYear = intThisYear;
					break;
			case 12:
					intPrevYear = intThisYear;
					intNextYear = intThisYear + 1;
					break;
			default:
					intPrevYear = intThisYear;
					intNextYear = intThisYear;
					break;
		}
		intPPyear = intThisYear-1
		intNNyear = intThisYear+1

		Stop_Flag = 0

		Cal_HTML = "<table class='calYear'  onmouseover='doOver()' onmouseout='doOut()' >";
		Cal_HTML += "<thead><tr>";
		//Cal_HTML += "<td></td>";
		Cal_HTML += "<td colspan='3'  style='text-align:right;'><img src='<%=img_url%>/cm/cal/icon_arrow9.jpg' alt='이전년' style='cursor:hand;' OnClick='Show_cal_M("+intPPyear+","+intThisMonth+");' align='absmiddle'>";
		Cal_HTML += "&nbsp;&nbsp;&nbsp;&nbsp;<b>"+ intThisYear +"년</b>&nbsp;&nbsp;&nbsp;<img src='<%=img_url%>/cm/cal/icon_arrow10.jpg' alt='다음년' style='cursor:hand;' OnClick='Show_cal_M("+intNNyear+","+intThisMonth+");' align='absmiddle'>";
		Cal_HTML += "<td style='text-align:right;'>";
		Cal_HTML += "<img src='<%=img_url%>/cm/cal/icon_close.png' onmouseover=this.src='<%=img_url%>/cm/cal/icon_close_over.png' onmouseout=this.src='<%=img_url%>/cm/cal/icon_close.png'  border='0' alt='닫기' onclick='parent.Calendar_Close();' style='cursor:hand'></td></tr>";
		Cal_HTML += "<tr></thead><tbody>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-01"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">1월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-02"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">2월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-03"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">3월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-04"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">4월</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-05"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">5월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-06"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">6월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-07"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">7월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-08"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">8월</td>";
		Cal_HTML += "</tr>";
		Cal_HTML += "<tr>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-09"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">9월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-10"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">10월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-11"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">11월</td>";
		Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear+"-12"+" onMouseOver=\"this.style.backgroundColor='#ffffcc'\" onMouseOut=\"this.style.backgroundColor=''\">12월</td>";
		Cal_HTML += "</tr></tbody>";
		Cal_HTML += "</table>";
		document.all.cal.innerHTML = Cal_HTML;

		// 달력 출력이 완료되면 iframe의 크기를 재조정한다.
		var Cal_Table = document.getElementById("cal");
		//alert(Cal_Table.offsetHeight);
		window.resizeTo(200, Cal_Table.offsetHeight);
	}
//]]>
</script>
<style type="text/css">
body {margin:0; background:none;}
#cal {margin:0; padding:3px;background:#bfcfe5; font-family:Malgun Gothic, dotum, Tahoma, Sans-serif;-moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; }
#cal table{width:100%;border-collapse:collapse;}
#cal table td {text-align:center;font-size:12px; -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; }
.calBox{ }
.calselect { height:28px;/* background:#eef7ff;*/}
.iYear, .iMonth {border:solid 1px #ccc;font-size:12px;}
.iYear { width:55px;}
.iMonth { width:35px;}
.calYear thead td {/*text-align:right; */}
.calYear tbody td {background:#fff;border:solid 2px #bfcfe5;cursor:Hand; width:25%; }

.calHeader{}
.calHeader td {font-weight:bold;border:solid 2px #bfcfe5; color:#fff;background:#929292; height:1.5em; line-height:1.5em; width:14%;}
.calHeader td.sun{background:#FD7B97;}
.calHeader td.sat{background:#3592CF;}
.calBody td { border:solid 2px #bfcfe5; height:1.2em; line-height:1.2em; width:14%; font-weight:bold;}
.calBody td.calDay {background:#fff;}
.calBody td.blank{background:none;}


</style>

</head>
<body>
	<div id="cal"></div>
</body>
</html>