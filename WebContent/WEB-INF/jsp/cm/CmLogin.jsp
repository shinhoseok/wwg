<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmLogin    
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
<!DOCTYPE html>
<html>
<head>
<title>::<%=_system_name %> ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="googlebot" content="noindex" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<link href="<%=con_root%>/style/cmsadmin/login.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/js/default.js"></script>
<script type="text/javascript" src="/js/CmCommon.js"></script>
<script type='text/javascript'>
//<![CDATA[
	$(function(){
		//input 항목에 엔터클릭 이벤트 추가 (엔터시 검색실행) -mrkim (2015-06-23)
		$("input").on("keypress",$(this),function(){
			//alert(event.keyCode);
			if(event.keyCode==13){
				sendit();        
			}
		});
	});
	           
	           
	function start() 
	{
		$('input[name=id]').focus();
	}
	function sendit() 
	{
		//아이디
		if (isEmpty($('input[name=id]').val())) {
				alert("아이디를 입력해 주십시오");
				$('input[name=id]').focus();
				return ;
		}else{
			if(getLength($('input[name=id]').val()) > 50){
				alert("아이디의 입력내용이 너무 깁니다");
				$('input[name=id]').focus();
				return ;		
			}
		}
		//암호
		if (isEmpty($('input[name=PassWord]').val())) {
				alert("패스워드를 입력해 주십시오");
				$('input[name=PassWord]').focus();
				return ;
		}else{
			if(getLength($('input[name=PassWord]').val()) > 50){
				alert("패스워드의 입력내용이 너무 깁니다");
				$('input[name=PassWord]').focus();
				return ;		
			}
		}
			
		document.my_form.submit();        
	}
	

	
	function onkey() {
		if( event.keyCode == 13 ) {
			sendit();
		}
	}
	
	
	start();
//]]>	
</script>	
</head>
<body>
 <form action="<%=RequestURL%>" method="post" name="my_form" onSubmit="sendit();return false;">
 <input type="hidden" name="scode" value="S01" />
 <input type="hidden" name="pcode" value="login" />
  <!-- content -->
	<div class="loginBox">
		<p>당진화력 발전출력 시스템 <span>LOGIN</span></p>
	    <div class="login">
	    	<div class="inputBox">
	            <dl>
	                <dt><label for="info1">사번</label></dt>
	                <dd><input type="text" name="id" title="" class="id" value="" /></dd>
	            </dl>
	            <dl>
	                <dt><label for="info2">비밀번호</label></dt>
	                <dd><input type="password" name="PassWord" title="" class="pw" value="" /></dd>
	            </dl>
	        </div>
	        <a href="#" onclick="sendit();return false;">LOGIN</a>
	    </div><!--//.login -->
		<div class="copy">Copyright&copy; 2016 KOREA EAST-WEST POWER CO.,LTD (EWP). All rights reserved.
		</div>
	</div>
  <!-- 
  <div id="logcontainer">
	  <div id="loginBox">
	 	<ul>
	 		<li class="logId"><label for="id">아이디</label><input type="text" name="id" title="" class="id" value="ewp_gen" /></li>
	  		<li class="logPw"><label for="PassWord">비밀번호</label><input type="password" name="PassWord" title="" class="pw" value="111www!!!" /></li>
	  	</ul>
	  	
	  	<a  class="btnLogin" href="javascript:sendit();">로그인</a>
	 	
	   </div>
	   <div id="Logfooter">Copyright&copy; 2016 KOREA EAST-WEST POWER CO.,LTD (EWP). All rights reserved.
	   </div>  	
   
  </div>
   -->
  <!-- content //--> 
 </form>
</body>


</html>
