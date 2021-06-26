<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
int i=0;
%>
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>
<body>
<form method="post" id="listfrm" name="listfrm" onSubmit="return false;">
	<input type="hidden" name="scode" id="scode" value="sysadm" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="000014" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="" title="페이지상태"  />

<div class="ly_pop" style="width:600px;">
	<h1><span>&#8226;</span>비밀번호변경</h1><span class="close" id="popupClose" onclick="return false;"><a href="#" ></a></span>

        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>정보변경-현재비밀번호,신규비밀번호,신규비밀번호확인,</caption>
            <colgroup>
                <col width="20%" />
                <col width="*" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <thead>
		      <tr>
		        <th scope="row" class="essential">현재 비밀번호</th>
		        <td colspan="3">
		            <input type="password" name="login_passwd" id="login_passwd" maxlength="12" title="" class="input_type01" value="" />
		        </td>
		     </tr>
		     
		      <tr>
		        <th scope="row" class="essential">신규 비밀번호</th>
		        <td colspan="3">
		            <input type="password" name="pass" id="pass" maxlength="12" title="" class="input_type01" value="" />
		        </td>
		     </tr>
		     
		      <tr>
		        <th scope="row" class="essential">신규 비밀번호확인</th>
		        <td colspan="3">
		            <input type="password" name="pass1" id="pass1" maxlength="12" title="" class="input_type01" value="" />
		        </td>
		     </tr>	
		     
            	<tr>
                    <td scope="row" colspan="4">
						<div class="section aC mT5 mB5">
							<p class="exp mat_5">비밀번호는 <b class="fc_1">9~12자의 영문 대문자, 소문자, 숫자, 특수문자를 혼합</b>해서 <br>사용하실 수 있습니다.</p>
							<p class="exp mat_5">해당 특수문자는 사용하실 수 없습니다.(&nbsp;&nbsp;<b class="fc_1">&lt; ,&nbsp; &gt; ,&nbsp; / ,&nbsp; \\ ,&nbsp; &amp; ,&nbsp; | ,&nbsp;  ^ ,&nbsp; % ,&nbsp; + ,&nbsp; .</b>&nbsp;&nbsp;)</p>
						</div>                    
                    </td>                    
                </tr>
                		     
            	<tr>
                    <td scope="row" id="button" colspan="4">
						<div class="section aC mT5 mB5">
						<span class="btn_pack large" id="save"><a href="#" onclick="return false;">비밀번호 변경</a></span>
						<span class="btn_pack large" id="btn_Chg_close"><a href="#" onclick="popup_close();return false;">닫기</a></span>
						</div>                    
                    </td>                    
                </tr> 		     
		   </thead>
		</table>		   	     		                 
            

</div>
<!--//popup-->
</form>
</body>
</html>
					
<script type="text/javascript">

$(function(){

	$("#save").click(function(e){
		
		var check = false;

		if($("#login_passwd").val()==''){
			alert('현재 비밀번호를 입력해 주세요');
			clear($("#login_passwd"));
			$("#login_passwd").focus();
			return;
		}

		if($("#pass").val()==''){
			alert('신규 비밀번호를 입력해 주세요');
			clear($("#pass"));
			$("#pass").focus();
			return;
		}
		
		if($("#pass1").val()==''){
			alert('신규 비밀번호확인 입력해 주세요');
			clear($("#pass1"));
			$("#pass1").focus();
			return;
		}		
		
		  	$("#pstate").val("P3");
			var params = $("#listfrm").serialize();
			CmopenLoading();
			 $.ajax({
	             type: "post",
	             url: "/cmsajax.do",
	             data: params,
	             async: false,
	             dataType:"json",
	             success: function(data){
	               if(data.result==true){

	               }else{

					alert('현재 비밀번호가 틀렸습니다');
					$("#login_passwd").focus();
					check=true;

	               }
	               CmcloseLoading();
	             },

			     error:function(request, status, error) {
			    	 CmcloseLoading();
			    	 check=false;
	             }
	      });

		if(check){
			return;
		}


		if($('input[name=login_passwd]').val() == $('input[name=pass]').val()){
			alert("이전비밀번호는 사용 할 수 없습니다.");
			clear($("#pass"));
			clear($("#pass1"));
			document.getElementsByName("pass")[0].focus();
			return;
		}

		if($('input[name=pass]').val().length < 9 || $('input[name=pass]').val().length > 12){
			alert("비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");
			clear($("#pass"));
			document.getElementsByName("pass")[0].focus();
			return;
		}
		
		if(!$('input[name=pass]').val().match(/([a-zA-Z0-9].*[!,@,#,$,*,?,_,~,(,)])|([!,@,#,$,*,?,_,~,(,)].*[a-zA-Z0-9])/)){

			alert("비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");
			clear($("#pass"));
			document.getElementsByName("pass")[0].focus();
			return;
		}

		if($('input[name=pass]').val() != $('input[name=pass1]').val()){

			alert("신규 비밀번호확인이 같지 않습니다."+$('input[name=pass]').val()+" != "+$('input[name=pass1]').val());
			$('input[name=pass]').val("");
			$('input[name=pass1]').val("");
			document.getElementsByName("pass1")[0].focus();
			return;

		}

	  	$("#pstate").val("P4");
		var params = $("#listfrm").serialize();
		CmopenLoading();
		 $.ajax({
             type: "post",
             url: "<c:url value='/cmsajax.do'/>",
             data: params,
             async: false,
             dataType:"json",
             success: function(data){
               if(data.result==true){
            	   alert('비밀번호가 변경되었습니다.');
				   self.close();

               }else{
					alert('비밀번호 변경중 에러가 발생하였습니다.');
               }

               CmcloseLoading();

             },

		     error:function(request, status, error) {
		    	 alert('비밀번호 변경중 에러가 발생하였습니다.');
		    	 CmcloseLoading();
             }
      });

	});

});



function clear($this){
	if($this.attr("type")==""){
		$($this).val("");
	}
	$($this).attr("type","password");

}



function tabkey($this){
	var _id = $($this).attr("id");
	if(event.keyCode==9){

		if(_id=="login_passwd"){
			$("#pass").attr("type","password");
			$("#pass").val("");

		}else if(_id=="pass"){
			$("#pass1").attr("type","password");
			$("#pass1").val("");

		}else if(_id=="pass1"){
			$("#login_passwd").attr("type","password");
			$("#login_passwd").val("");

		}
	}
}

function popup_close(){
	$("#popupClose").trigger("click");
}
//닫기
$("#popupClose").click(function(e){
	
	self.close();
	
});

</script>