<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/S01/CmMainPop_i1  
/* 프로그램 이름     : CmMainPop_i1    
/* 소스파일 이름     : CmMainPop_i1.jsp
/* 설명              : SYSTEM 시스템 관리자 메인 팝업 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2018-04-16
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2018-04-16
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
////////////////////// 팝업관련
// 사이트별 팝업리스트
List site_popList = (List)rtn_Map.get("getMainPopList");
Map site_popMap = new HashMap();
//out.println("site_popList:::"+site_popList);
if(site_popList!=null){
	for(int pi=0;pi<site_popList.size();pi++){
		site_popMap = (Map)site_popList.get(pi);
	%>
	<div class="ly_pop2" id="create_form_popup_main_<%=scode %>_<%=site_popMap.get("IDX") %>" style="display:none;">
		<h1 id="create_form_popup_main_dragtitle"><%=site_popMap.get("BN_TITLE") %></h1>
		<div class="tBox" id="create_form_popup_contents_<%=scode %>_<%=site_popMap.get("IDX") %>" onclick="<%=(((String)site_popMap.get("BN_LINK")).indexOf("#") > -1 ?"":"location.href='"+site_popMap.get("BN_LINK")+"';")%>return false;" style='<%if((HtmlTag.returnString((String)site_popMap.get("FILE_NMS"),"")).equals("")){%><%}else{%>background:#fff url(<%=con_root%>/cmsmain.do?scode=000008&pcode=000015&pstate=FILEDOWN&fpcode=000150&sidx=<%=site_popMap.get("IDX")%>&fidx=1&img_type=) center no-repeat;background-size:contain;<%}%>cursor:pointer;overflow-y:scroll;max-height:700px;'>
		<%=((String)site_popMap.get("BN_CONTENTS")).replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("&amp;","&") %>
		
	    </div>
		<div class="btn_Box" id="popup_btn_area_cm_apm_main">
			<span><input name="daydisable_create_form_popup_main_<%=scode %>_<%=site_popMap.get("IDX") %>" id="daydisable_create_form_popup_main_<%=scode %>_<%=site_popMap.get("IDX") %>" value="Y" type="checkbox" ><label for="daydisable_create_form_popup_main_<%=scode %>_<%=site_popMap.get("IDX") %>">오늘하루 보지않음</label></span>
	        <a class="btn_close" id="btn_close" onclick="create_form_popup_main_close_<%=scode %>('<%=site_popMap.get("IDX") %>');return false;" href="#">닫기</a>
		</div>
	</div>


	<%	
	}	
}


%>
<script type='text/javascript'>
//<![CDATA[
var popupcnt = 0;

function create_form_popup_main_close_<%=scode %>(popidx){
	$("#create_form_popup_main_<%=scode %>_"+popidx).hide();

	// 오늘하루 보지않음 체크된경우
	if($("#daydisable_create_form_popup_main_<%=scode %>_"+popidx+"").is(":checked")){
		setCookie( "popup_<%=scode %>_"+popidx, "Y", 1 );		
	}
	
	var showcnt = 0;
	$("[id^=create_form_popup_main_<%=scode %>]").each(function (idx) {
		var popidx = $(this).attr("id").substring($(this).attr("id").lastIndexOf("_")+1,$(this).attr("id").length);
		//alert($(this).attr("id")+":::"+$("#"+$(this).attr("id")).css("display"));
		if($("#"+$(this).attr("id")).css("display")=="" || $("#"+$(this).attr("id")).css("display")=="block"){
			
			showcnt++;
		}
		
	});	
	// 보이는 팝업창이 한개도 없을경우 화면 disable 해제
	if(showcnt==0){
		CmclospageDisable();	
	}
	
}

function create_form_popup_main_view_<%=scode %>(popidx, idx){
	CmopenpageDisable();	
	
	// 등록, 수정 폼 드래그앤 드롭 이동
    $("#create_form_popup_main_<%=scode %>_"+popidx).draggable({ opacity:"0.3",handle:"#create_form_popup_main_dragtitle" }); // 끄는 동안만 불투명도 주기

    $("body").droppable({

        accept: "#create_form_popup_main_<%=scode %>_"+popidx,    // 드롭시킬 대상 요소

        drop: function(event, ui) {

        	$("#create_form_popup_main_<%=scode %>_"+popidx).css({ opacity:"1.0" });

        }

    });	
	
	//alert("#create_form_popup_main_<%=scode %>_"+popidx+"========"+$("#create_form_popup_main_<%=scode %>_"+popidx).width());
	
	//$("#create_form_popup_main_<%=scode %>_"+popidx).height(600);
	//grid_win_resizeAuto();
	//alert($("#create_form_popup_cm_apm_<%=pcode %>").width()+"---"+$("#create_form_popup_cm_apm_<%=pcode %>").height());
	
	// 수정, 등록창의 위치를 잡는다
	$("#create_form_popup_main_<%=scode %>_"+popidx).css("left",( (($(document).width() - $("#create_form_popup_main_<%=scode %>_"+popidx).width()) / (2 + (10-(idx*3)))) + $(document).scrollLeft() )+"px");
	$("#create_form_popup_main_<%=scode %>_"+popidx).css("top", ((($(document).height() - $("#create_form_popup_main_<%=scode %>_"+popidx).height()) / (8-(idx*2))) + $(document).scrollTop() )+"px");	


	$("#create_form_popup_main_<%=scode %>_"+popidx).show();
	var pop_maxWidth = 0;
	$("#create_form_popup_contents_<%=scode %>_"+popidx).children().each(function(index){
		if(pop_maxWidth < $(this).width()){
			pop_maxWidth = $(this).width();
		}
		
	});
	/*var pop_maxWidth = Math.max.apply(null,$("#create_form_popup_contents_<%=scode %>_"+popidx).map(function(){
		return $(this).width();
	}).get());*/
	
	if(pop_maxWidth > $("#create_form_popup_main_<%=scode %>_"+popidx).width()){
		$("#create_form_popup_main_<%=scode %>_"+popidx).width(pop_maxWidth+40);
	}
	
	
	
}

function getCookie(name) {
	   var nameOfCookie = name + "=";
	   var x = 0;
	   while ( x <= document.cookie.length ){
	      var y = (x+nameOfCookie.length);
		  if ( document.cookie.substring( x, y ) == nameOfCookie ) {
		     if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
			    endOfCookie = document.cookie.length; 
				return unescape( document.cookie.substring( y, endOfCookie ) ); 
		  }
		  
		  x = document.cookie.indexOf( " ", x ) + 1;
		  if ( x == 0 )
		  break; 
		}
		return "";
}

function setCookie( name, value, expiredays ){ 
	  var todayDate = new Date(); 
	  todayDate.setDate( todayDate.getDate() + expiredays ); 
	  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

$(function() {
	popupcnt = $("[id^=create_form_popup_main_<%=scode %>]").length;
	$("[id^=create_form_popup_main_<%=scode %>]").each(function (idx) {
		var popidx = $(this).attr("id").substring($(this).attr("id").lastIndexOf("_")+1,$(this).attr("id").length);
		// 쿠키값 체크
		var popupCook = getCookie("popup_<%=scode %>_"+popidx);
		// 팝업생성시마다 잠시 쿠키를 삭제한다
		//setCookie( "popup_<%=scode %>_"+popidx, "", -1 );
		//alert("popupCook::"+popupCook);
		if(popupCook==null || popupCook==undefined || popupCook=="" && popupCook!="Y"){
			//alert("popupCook2::"+popupCook);
			create_form_popup_main_view_<%=scode %>(popidx, idx);
		    /*$("#create_form_popup_main_<%=scode %>_"+popidx).on("dragstart",function(event){
	    	//alert(popidx);
	    	//$("#create_form_popup_main_<%=scode %>_"+popidx).mousemove(function(e){return false;});
	    	//$("#create_form_popup_main_<%=scode %>_"+popidx).css("position","fixed");
	    	//event.preventDefault();
	    	//event.stopPropagation();
	    	//event.stopImmediatePropagation();
	    	return false;
	    });	*/			
		}
		
	});
});	

//]]>   
</script>
