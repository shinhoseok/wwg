var target;
var stime;
var calendar;
var focusElement = null;


$(function(){
	var _tmpDiv = $('<div id="minical" onmouseover="Calendar_Over()" onmouseout="Calendar_Out()" style=" margin:2; border: 1 solid buttonshadow; width:200; overflow:hidden; display:none; position:absolute; z-index:9500"></div>')
		.append('<iframe id="Cal_iFrame" name="Cal_iFrame" width=200 height=200 src="'+context_root+'/js/cal.jsp?img_url='+context_root+'/images" scrolling=no frameborder=no border=1 bordercolor=red></iframe>');
	$('body').append(_tmpDiv);

//	document.writeln('<div id="minical" onmouseover="Calendar_Over()" onmouseout="Calendar_Out()" style="background: buttonface; margin:2; border: 1 solid buttonshadow; width:200;height:180; display:none; position:absolute; z-index:2000">');
//	document.writeln('<iframe id="Cal_iFrame" name="Cal_iFrame" width=200 height=180 src="'+context_root+'/js/cal.jsp?img_url='+context_root+'/images" scrolling=no frameborder=no border=1 bordercolor=red></iframe>');
//	document.writeln('</div>');
});

function Calendar_Over() {
	window.clearTimeout(stime);
}

function Calendar_Out() {
	/*if(focusElement==null){
		stime=window.setTimeout("calendar.style.display='none';", 200);
	}*/
	
}

function Calendar_Close(){
	calendar.style.display='none';
}


function focus_on() { 
	focusElement = event.srcElement;
} 


function focus_un(){
	focusElement = null;
}

function Calendar_Click(e) {
	//alert(":::"+e.title);
	cal_Day = e.title;
	//alert(":::"+cal_Day);
	if (cal_Day.length > 6) {
		target.value = cal_Day;
		target.focus();
	}	
	calendar.style.display='none';
}

function Calendar_D(obj) {
	//alert('11111111111111');
	var now = obj.value.split("-");
	target = obj;

	/*
	var top = document.body.clientTop + GetObjectTop(obj);
	var left = document.body.clientLeft + GetObjectLeft(obj);
	var body_height = $("body").height();
	var body_width = $("body").width();
	
	//var top = GetObjectTop(obj);
	//var left = GetObjectLeft(obj);	
	//alert("top:"+GetObjectTop(obj)+":left:"+GetObjectLeft(obj));
	//alert("top:"+body_height+":left:"+body_width);

	calendar = document.getElementById('minical');
	
	user_area = document.getElementById('content');
	
	if(left > body_width){
		left = body_width;
	}
	//alert("top:"+top+":left:"+left);
	//alert("user_area:"+user_area);
	if(user_area!=null && user_area!=undefined){
		//alert("user_area top:"+GetObjectTop(user_area));
		//alert("user_area left:"+GetObjectLeft(user_area));
		top = top - GetObjectTop(user_area);
		left = left - GetObjectLeft(user_area);
	}
	//alert("top:"+top+":left:"+left);
//	calendar.style.pixelTop = top + obj.offsetHeight;
//	calendar.style.pixelLeft = left;
	top = top + obj.offsetHeight;
	calendar.style.top = top + "px";
	calendar.style.left = left + "px";
	calendar.style.display = '';*/
	//alert('222222222222222');
	target = obj;
	var body_height = $(document).height();
	var body_width = $(document).width();
	//var top = document.body.clientTop + GetObjectTop(obj);
	//var left = document.body.clientLeft + GetObjectLeft(obj);
	
	var top = $(target).offset().top;
	var left = $(target).offset().left;	

	user_area = document.getElementById('content');

	if(left > body_width-200){
		left = body_width-200;
	}

	if(top > body_height-180){
		top = body_height-obj.offsetHeight-20;
	}else{
		top = top + obj.offsetHeight;
	}
	
	
	//alert("top:"+top+"::left::"+left+"::"+"offset().left:"+$(target).offset().left+"::offset().top::"+$(target).offset().top);


//	calendar = document.all.minical;
	calendar = document.getElementById("minical");
	//calendar.style.pixelTop = top;
	//calendar.style.pixelLeft = left;
	calendar.style.display = '';	
	//$(calendar).offset({top: top,left: left});
	$(calendar).css({
		   "position" : "absolute",
		   "top" : top+"px",
		   "left" : left+"px"
		});
	

	if (now.length == 3) {
		Cal_iFrame.Show_cal(now[0],now[1],now[2]);
	} else {
		now = new Date();
		Cal_iFrame.Show_cal(now.getFullYear(), now.getMonth()+1, now.getDate());
	}
}

function Calendar_M(obj) {
	var now = obj.value.split("-");
	target = obj;

	var top = document.body.clientTop + GetObjectTop(obj);
	var left = document.body.clientLeft + GetObjectLeft(obj);

	calendar = document.all.minical;
	calendar.style.pixelTop = top + obj.offsetHeight;
	calendar.style.pixelLeft = left;
	calendar.style.display = '';
	
	if (now.length == 2) {
		Cal_iFrame.Show_cal_M(now[0],now[1]);
	} else {
		now = new Date();
		Cal_iFrame.Show_cal_M(now.getFullYear(), now.getMonth()+1);
	}
}

/**
	HTML 개체용 유틸리티 함수
**/
function GetObjectTop(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetTop;
	else
		return obj.offsetTop + GetObjectTop(obj.offsetParent);
}

function GetObjectLeft(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetLeft;
	else
		return obj.offsetLeft + GetObjectLeft(obj.offsetParent);
}


