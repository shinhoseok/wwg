<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : CmLogin    
/* 소스파일 이름     : CmLogin.jsp
/* 설명              : SYSTEM INDEX페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-08
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-08
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
String jsessionid = request.getSession().getId();
response.setHeader("SET-COOKIE","JSESSIONID="+jsessionid+";HttpOnly");
response.setHeader("cache-control", "no-cache, no-store, must-revalidate");
response.setHeader("expires", "0");
response.setHeader("pragma", "no-cache");
response.setHeader("x-frame-options", "SAMEORIGIN");		//교차 프레임 스크립팅 방어
response.setHeader("x-content-type-options", "nosniff");	//Missing "X-Content-Type-Options" header
response.setHeader("x-xss-protection", "1; mode=block");	//Missing "X-XSS-Protection" header

String _sso_cookie_name = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("SSO_COOKIE_NM","");
Cookie[] cookie_arr = request.getCookies();
if(!HtmlTag.returnCookie(cookie_arr, _sso_cookie_name).equals("")){
	response.sendRedirect("/cmsmain.do?scode=sysadm&pcode=login");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta name="format-detection" content="telephone=no"/><!-- 전화번호 자동링크 없애기 -->
<meta name="keywords" content=""><!-- 키워드 제공 -->
<meta name="description" content=""><!-- 요약정보 -->
<meta name="robots" content="all"><!-- 검색로봇 -->
<title><%=_system_name %> 관리자</title>
<link href="<%=con_root%>/style/cmsadmin/login.css" rel="stylesheet" type="text/css">
<link href="<%=con_root%>/style/cmsadmin/cmsdefault.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="<%=con_root%>/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/CmCommon.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/com.js" charset="utf-8"></script>
<script type='text/javascript'>

	$(function(){
		
		$('#id').focus();	//아이디 포커스
		
		//input 항목에 엔터클릭 이벤트 추가 (엔터시 검색실행) -mrkim (2015-06-23)
		$("form[name=my_form]").find("input").on("keypress",$(this),function(){
			//alert(event.keyCode);
			if(event.keyCode==13){
				sendit();        
			}
		});
		
		// 변경를 body 에 append한다
		$("body").append($('#create_form_popup_ipn'));
		// 등록, 수정 폼 드래그앤 드롭 이동
        $('#create_form_popup_ipn').draggable({ opacity:"0.3" }); // 끄는 동안만 불투명도 주기

        $("body").droppable({

            accept: "#create_form_popup_ipn",    // 드롭시킬 대상 요소

            drop: function(event, ui) {

            	$('#create_form_popup_ipn').css({ opacity:"1.0" });

            }

        });
        
		//input 항목에 엔터클릭 이벤트 추가 (엔터시 검색실행) -mrkim (2015-06-23)
		$("form[name=create_formfm_ipn]").find("input").on("keypress",$(this),function(){
			//alert(event.keyCode);
			if(event.keyCode==13){
				create_ipin_search();        
			}
		});	
		
		//인증번호발송
		$("#phoneauth_btn").click( function(){
			
			if($("form[name=my_form]").find("input[name=authcodeIng]").val()=="Y"){
				alert("현재 인증번호가 발송된 상태입니다.시간경과후 재발송해주세요.");
				return;
			}
			
			if (isEmpty($("form[name=my_form]").find("input[name=id]").val())) {
				alert("아이디를 입력해 주십시오");
				$("form[name=my_form]").find("input[name=id]").focus();
				return ;
			}else{
				if(getLength($("form[name=my_form]").find("input[name=id]").val()) > 50){
					alert("아이디의 입력내용이 너무 깁니다");
					$("form[name=my_form]").find("input[name=id]").focus();
					return ;		
				}
			}
			CmopenpageDisable();
	
			$("form[name=my_form]").find("input[name=pcode]").val("login_pin_authsend");
			var params = jQuery("#my_form").serialize();
			
			$.ajax({ type     : "post"
						, url      : "<c:url value='/cmsajax.do'/>"
						, data     : params
						, async    : false
						, dataType :"json"
						, timeout  : 3000
						, error    : function (jqXHR, textStatus, errorThrown) {
								// 통신에 에러가 있을경우 처리할 내용(생략가능)
								alert("네트웍장애가 발생했습니다. 다시시도해주세요");
								CmclospageDisable();
	               }
	               , success  : function(data) {
	            	   if(data.result==true){
							alert("인증번호가 등록된 핸드폰으로 발송되었습니다.");
							$("form[name=my_form]").find("input[name=authcodeYn]").val("Y");
							$("form[name=my_form]").find("input[name=authcodeIng]").val("Y");
							$("#phoneauth_btn").css("background","#ef4e4c");//#41484c
							countdown("phoneauth_btn", 3, 0);
							CmclospageDisable();
							return;	            		   
	            	   }else{
							alert(data.TRS_MSG);
							CmclospageDisable();
							return;	            	   		
	            	   }

	               }
			});
		});		
		
		<%
		// 세션이 있는경우만 출력한다
		if(SITE_ADM_SESSION != null){
        	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
        	if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"").equals("") /* && ( Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),"0")) > 90 */ 
        			|| !HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) /* ) */{
        %>
			// 변경를 body 에 append한다
			$("body").append($('#create_form_popup'));
			// 등록, 수정 폼 드래그앤 드롭 이동
	        $('#create_form_popup').draggable({ opacity:"0.3" }); // 끄는 동안만 불투명도 주기
			
	        $("body").droppable({
	
	            accept: "#create_form_popup",    // 드롭시킬 대상 요소
	
	            drop: function(event, ui) {
	
	            	$('#create_form_popup').css({ opacity:"1.0" });
	
	            }
	
	        });
	        
			//input 항목에 엔터클릭 이벤트 추가 (엔터시 검색실행) -mrkim (2015-06-23)
			$("form[name=create_formfm]").find("input").on("keypress",$(this),function(){
				//alert(event.keyCode);
				if(event.keyCode==13){
					create_form_insert();        
				}
			});
			
        	create_form_view();
        <%
        	}
 		}else{
		%>
		start();
		<%
 		}
		%>
	});
	           
	           
	function start() 
	{
		$('input[name=id]').focus();
	}
	function sendit() 
	{
		//아이디
		if (isEmpty($("form[name=my_form]").find('input[name=id]').val())) {
				alert("아이디를 입력해 주십시오");
				$("form[name=my_form]").find('input[name=id]').focus();
				return ;
		}else{
			if(getLength($("form[name=my_form]").find('input[name=id]').val()) > 50){
				alert("아이디의 입력내용이 너무 깁니다");
				$("form[name=my_form]").find('input[name=id]').focus();
				return ;		
			}
		}
		//암호
		if (isEmpty($("form[name=my_form]").find('input[name=PassWord]').val())) {
				alert("패스워드를 입력해 주십시오");
				$("form[name=my_form]").find('input[name=PassWord]').focus();
				return ;
		}else{
			if(getLength($("form[name=my_form]").find('input[name=PassWord]').val()) > 50){
				alert("패스워드의 입력내용이 너무 깁니다");
				$("form[name=my_form]").find('input[name=PassWord]').focus();
				return ;		
			}
		}
		
		<%
		if(svr_name!=null){
			// 내부망접속이 아닐경우만 사용하지않는다
			if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost") && !svr_name.equals("www.komipo.co.kr")){
		%>
			if($("form[name=my_form]").find("input[name=authcodeYn]").val()!="Y"){
				alert("인증번호를 전송한후 인증번호를 입력해주세요.");
				return;
			}
			
			if (isEmpty($("form[name=my_form]").find('input[name=authCode]').val())) {
				alert("인증번호를 입력해 주십시오");
				$("form[name=my_form]").find('input[name=authCode]').focus();
				return ;
			}else{
				if(getLength($("form[name=my_form]").find('input[name=authCode]').val()) > 6){
					alert("인증번호의 입력내용이 너무 깁니다");
					$("form[name=my_form]").find('input[name=authCode]').focus();
					return ;		
				}
			}			
		<%
			}
		}
		%>
		$("form[name=my_form]").find("input[name=pcode]").val("login");
			
		document.my_form.submit();        
	}
	

	
	function onkey() {
		if( event.keyCode == 13 ) {
			sendit();  
		}
	}
	
	
	//TODO : create_ipin_search_close 
	// 변경창 닫기
	function create_ipin_search_close(){
		$("#create_form_popup_ipn").hide();
		create_ipin_search_init();
		CmclospageDisable();
	}
	// TODO : create_ipin_search 
	// 변경창 오픈
	function create_ipin_search(){
		CmopenpageDisable();
		var i = 0;
		
		create_ipin_search_init();
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_popup_ipn").css("left",( (($(document).width() - 600) / 2) + $(document).scrollLeft() )+"px");
		$("#create_form_popup_ipn").css("top", ((($(document).height() - 500) / 2) + $(document).scrollTop() )+"px");	
		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);
		
		$("#create_form_popup_ipn").show(500);
		

	}

	function create_ipin_search_init(){
		

		// 값 초기화
		$("form[name=create_formfm_ipn]").find('input[name=iipin_id]').val("");
		$("form[name=create_formfm_ipn]").find('input[name=iipin_email]').val("");
		$("form[name=create_formfm_ipn]").find('input[name=iipin_hp]').val("");
	
	}
	
	//TODO : create_ipin_searchGO
	//코드등록
	function create_ipin_searchGO(){
		
		//아이디
		if (isEmpty($("form[name=create_formfm_ipn]").find("input[name=iipin_id]").val())) {
				alert("아이디를 입력해 주십시오");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_id]").focus();
				return ;
		}else{
			if(getLength($("form[name=create_formfm_ipn]").find("input[name=iipin_id]").val()) > 20){
				alert("아이디의 입력내용이 너무 깁니다");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_id]").focus();
				return ;		
			}
		}
		
		//핸드폰
		if (isEmpty($("form[name=create_formfm_ipn]").find("input[name=iipin_email]").val())) {
				alert("이메일을 입력해 주십시오");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_email]").focus();
				return ;
		}else{
			if(getLength($("form[name=create_formfm_ipn]").find("input[name=iipin_email]").val()) > 60){
				alert("이메일의 입력내용이 너무 깁니다");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_email]").focus();
				return ;		
			}
			
			// 이메일 형식체크
			if(isMail($("form[name=create_formfm_ipn]").find("input[name=iipin_email]").val())){
				alert("이메일형식이 맞지않습니다. 확인하시고 입력해주세요");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_email]").focus();
				return;
			}
		}
		
		//핸드폰
		if (!isEmpty($("form[name=create_formfm_ipn]").find("input[name=iipin_hp]").val())) {

			if(getLength($("form[name=create_formfm_ipn]").find("input[name=iipin_hp]").val()) > 20){
				alert("핸드폰의 입력내용이 너무 깁니다");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_hp]").focus();
				return ;		
			}
			
			// 핸드폰 형식체크
			if(!isHpFormat($("form[name=create_formfm_ipn]").find("input[name=iipin_hp]").val())){
				alert("핸드폰입력 형식이 맞지않습니다. 확인하시고 입력해주세요");
				$("form[name=create_formfm_ipn]").find("input[name=iipin_hp]").focus();
				return;
			}
		}		
		

		$("form[name=create_formfm_ipn]").find("#pcode").val("login_pin_search");
		var params = jQuery("form[name=create_formfm_ipn]").serialize();
		CmLoadingChg_Zindex(9999);
		
	    //alert(params);
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
		        	CmLoadingChg_Zindex(8000);             
	         },
	  
	         success: function(data){
	           if(data.result==true){
	        	   	alert('요청 되었습니다.');
		            CmLoadingChg_Zindex(8000);
		            create_ipin_search_close();
	           
	           }else{
		        	alert(data.TRS_MSG);
		        	CmLoadingChg_Zindex(8000);
		        	
	           }
	         }

		});

	}	
	

	<%
	// 세션이 있는경우만 출력한다
	if(SITE_ADM_SESSION != null){
    	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
        if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),"0")) > 90 
        			|| !HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) ){
    %>
	//TODO : create_form_close 
	// 변경창 닫기
	function create_form_close(){
		$("#create_form_popup").hide();
		create_form_init();
		CmclospageDisable();
	}
	// TODO : create_form_view 
	// 변경창 오픈
	function create_form_view(){
		CmopenpageDisable();
		var i = 0;
		
		create_form_init();
		// 수정, 등록창의 위치를 잡는다
		$("#create_form_popup").css("left",( (($(document).width() - 600) / 2) + $(document).scrollLeft() )+"px");
		$("#create_form_popup").css("top", ((($(document).height() - 500) / 2) + $(document).scrollTop() )+"px");	
		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);
		
		$("#create_form_popup").show(500);
		

	}

	function create_form_init(){
		$("#btn_create_form_insert").css("display","");

		// 값 초기화
		$("form[name=create_formfm]").find('input[name=iprev_pin_str]').val("");
		$("form[name=create_formfm]").find('input[name=inext_pin_str]').val("");
		$("form[name=create_formfm]").find('input[name=inext_pin_str2]').val("");
	
	}



	//TODO : create_form_insert
	//코드등록
	function create_form_insert(){
		
		//암호
		if (isEmpty($("form[name=create_formfm]").find("input[name=iprev_pin_str]").val())) {
				alert("기존비밀번호를 입력해 주십시오");
				$("form[name=create_formfm]").find("input[name=iprev_pin_str]").focus();
				return ;
		}else{
			if(getLength($("form[name=create_formfm]").find("input[name=iprev_pin_str]").val()) > 20){
				alert("기존비밀번호의 입력내용이 너무 깁니다");
				$("form[name=create_formfm]").find("input[name=iprev_pin_str]").focus();
				return ;		
			}
		}
		
		//암호
		if (isEmpty($("form[name=create_formfm]").find("input[name=inext_pin_str]").val())) {
				alert("변경비밀번호를 입력해 주십시오");
				$("form[name=create_formfm]").find("input[name=inext_pin_str]").focus();
				return ;
		}else{
			if(getLength($("form[name=create_formfm]").find("input[name=inext_pin_str]").val()) > 20){
				alert("변경비밀번호의 입력내용이 너무 깁니다");
				$("form[name=create_formfm]").find("input[name=inext_pin_str]").focus();
				return ;		
			}
		}
		
		if (isEmpty($("form[name=create_formfm]").find("input[name=inext_pin_str2]").val())) {
			alert("변경비밀번호확인을 입력해 주십시오");
			$("form[name=create_formfm]").find("input[name=inext_pin_str2]").focus();
			return ;
		}else{
			if(getLength($("form[name=create_formfm]").find("input[name=inext_pin_str2]").val()) > 20){
				alert("변경비밀번호확인의 입력내용이 너무 깁니다");
				$("form[name=create_formfm]").find("input[name=inext_pin_str2]").focus();
				return ;		
			}
		}	
		
		if($("form[name=create_formfm]").find("input[name=inext_pin_str]").val() != $("form[name=create_formfm]").find("input[name=inext_pin_str2]").val()){
			alert("변경비밀번호와 변경비밀번호확인의 입력값이 일치하지 않습니다.");
			return;
		}
		
		// 비밀번호가 입력되어있을경우 비밀번호를 체크한다
			if($("form[name=create_formfm]").find("input[name=inext_pin_str]").val().length < 9 || $("form[name=create_formfm]").find("input[name=inext_pin_str]").val().length > 12){
				alert("변경비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");
				$("form[name=create_formfm]").find("input[name=inext_pin_str]").focus();
				return;
			}
			
			if(!$("form[name=create_formfm]").find("input[name=inext_pin_str]").val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
				alert("변경비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");
				$("form[name=create_formfm]").find("input[name=inext_pin_str]").focus();
				return;
			}
		
		$("form[name=create_formfm]").find("input[name=pcode]").val("login_pin_chg");
		$("form[name=create_formfm]").submit();
	}	
	<%
    	}
	}
	%>
	
	function countdown(eleName, min, sec){
		var elem, endTm, ho, mi, msLe, tim;
		
		elem = document.getElementById(eleName);
		
		function twoDigits(n){
			return (n <=9 ? "0"+n : n);
		}
		
		function updateTm(){
			msLe = endTm -(+new Date);
			if(msLe < 1000){
				// 종료처리
				$("#phoneauth_btn").css("background","#41484c");//#ef4e4c
				$("#phoneauth_btn").html("인증번호발송");//
				$("form[name=my_form]").find("input[name=authcodeIng]").val("N");
			}else{
				tim = new Date(msLe);
				ho = tim.getUTCHours();
				mi = tim.getUTCMinutes();
				elem.innerHTML = (ho ? ho+':'+twoDigits(mi) : mi) +":"+twoDigits(tim.getUTCSeconds());
				setTimeout(updateTm, tim.getUTCMilliseconds()+500);
			}
		}
		
		endTm =(+new Date) + 1000 * (60*min + sec) + 500;
		updateTm();
	}
</script>
</head>
<%@ include file="/WEB-INF/jsp/cm/CmCommonMsg.jsp" %>

<body>
<form action="<%=RequestURL%>" method="post" name="my_form" id="my_form" onSubmit="sendit();return false;">
	<input type="hidden" name="scode" id="scode" value="sysadm" />
	<input type="hidden" name="pcode" id="pcode" value="login" />
	<input type="hidden" name="authcodeYn" id="authcodeYn" value="N" />
	<input type="hidden" name="authcodeIng" id="authcodeIng" value="N" />
	
	
<div id="wrap_login">	
	<h1 class="login_tilte"><strong>관리자로그인</strong><span><%=_system_name %> 로그인 페이지입니다.</span></h1>
	<fieldset class="login_form">
		<legend>로그인</legend>
		<div class="login_img"></div>
		<div class="iogin_input">
			<div class="input_row">
				<label for="">아이디</label>
				<input type="text" placeholder="아이디" name="id" id="id" value="" />
				<span class="login_id"></span>
			</div>
			<div class="input_row">
				<label for="">비밀번호</label>
				<input type="password" placeholder="비밀번호" name="PassWord" id="PassWord" value="" />
				<span class="login_pw"></span>
			</div>
			<div class="input_row" style="display:none;">
				<label for="">인증번호</label>
				<input type="password" placeholder="인증번호" name="authCode" id="authCode" value="" style="width:54%;" />
				<span class="phoneauth_btn" id="phoneauth_btn">인증번호발송</span>		
			</div>
				
			
			<div class="login_btn" onMouseDown="style.filter='gray'" onclick="sendit();return false;">로그인</div>
		</div>
	</fieldset>
</div>
</form>

<%
// 세션이 있는경우만 출력한다
if(SITE_ADM_SESSION != null){
      	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
      	if(!HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"").equals("") /* && ( Integer.parseInt(HtmlTag.returnString((String)SITE_ADM_SESSION.get("CHGDTCNT"),"0")) > 90 */ 
      			|| !HtmlTag.returnString((String)SITE_ADM_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) /* ) */{
      %>
<!-- 변경 창  -->
<div id="create_form_popup" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9000;width:600px;display:none;">
	<h1 id="popup_title_id"><span>&#8226;</span>비밀번호변경</h1><span class="close" id="btn_oh_close_icon" onclick="create_form_close()"><a href="#none;" ></a></span>
	<form name="create_formfm" method="post" action="<%=RequestURL%>" >
		<input type="hidden" name="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" value="<%=pstate%>" title="페이지상태"  />
        
        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>비밀번호변경-기존비밀번호,변경비밀번호,변경비밀번호확인,</caption>
            <colgroup>
                <col width="20%" />
                <col width="*" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <thead>
            	<tr>        	
                	<th scope="row">기존비밀번호
                    </th>
                    <td colspan="3">
                    <input type="password" name="iprev_pin_str" id="iprev_pin_str" class="ronly" style="width:100%" maxlength="20" />
                    </td>
                </tr>
                
            	<tr>
                	<th scope="row">변경비밀번호
                    </th>
                    <td colspan="3">
                    <input type="password" name="inext_pin_str" id="inext_pin_str" class="ronly" style="width:100%" maxlength="20" />
                    </td>
                </tr>  
                
            	<tr>	
                	<th scope="row">변경비밀번호확인
                    </th>
                    <td colspan="3">
                    <input type="password" name="inext_pin_str2" id="inext_pin_str2" class="ronly" style="width:100%" maxlength="20" />
                    </td>
                </tr>
            	<tr>
                    <td scope="row" id="create_form_in_btns" colspan="4">
						<div class="section aC mT5 mB5">
						<span class="btn_pack large" id="btn_create_form_insert"><a href="#none;" onclick="create_form_insert()">변경</a></span>
						<span class="btn_pack large" id="btn_create_form_close"><a href="#none;" onclick="create_form_close()">닫기</a></span>
						</div>                    
                    </td>                    
                </tr>                
            </thead>
         </table>
	</form>
</div>
<!-- 변경 창  -->

<%
	}
}
%>

</body>
<div id="pageDisable" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:8000;display:none;"> </div>
</html>