<%@page pageEncoding="utf-8"%>
<%
String rpcode =  HtmlTag.returnString((String)request.getAttribute("rpcode"),"");
String rpstate =  HtmlTag.returnString((String)request.getAttribute("rpstate"),"");
String rpidx =  HtmlTag.returnString((String)request.getAttribute("rpidx"),"");
%>
<form action="<%=RequestURL%>" method="post" id="dataForm" name="dataForm" onSubmit="return false;">	
<!--login-->
                    <div class="prg">
                        <div class="loginInput">
                            <div class="memLogin">
                                <div class="inputArea">
                                    <div class="id">
                                        <label for="id_inpit">아이디입력</label>
                                        <input type="text" id="id" name="id"  maxlength="20" class="inputtxt id_input" alt="아이디를 입력하세요" title="아이디를 입력하세요" value="" placeholder="아이디를 입력하세요.">
                                    </div>
                                    <div class="pass">
                                        <label for="pass_input">비밀번호입력</label>
                                        <input type="password" id="PassWord" name="PassWord" maxlength="20" class="inputtxt pass_input" alt="비밀번호를 입력하세요" title="비밀번호를 입력하세요" placeholder="비밀번호를 입력하세요.">
                                    </div>
                                </div>
                                <div class="memcheck">
                                    <div class="checkBox">
                                        <input type="checkbox" id="login_chk" name="login_chk">
                                        <label for="login_chk" class="idsave">아이디저장</label>
                                        
                                    </div>
                                    <div class="memsearch">
                                        <a href="#" id="findId">아이디 찾기</a>
                                        <a href="#" id="findPw">비밀번호 찾기</a>
                                    </div>
                                </div>
                                <div class="btnArea">
                                    <a href="#" class="btnB" id="btn_login">로그인</a>
                                </div>
                            </div>
                            <div class="memJoin">
                                <div class="joinTitle">
                                    <p><strong>동반성오픈플랫폼 회원</strong>이 <strong>아니신 분</strong>은, 회원가입을 통하여 다양한 서비스를 이용하시기 바랍니다. </p>
                                </div>
                                <div class="btnArea">
                                    <a href="#" class="btnR" id="join">회원가입</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    

<!--//login-->
 <input type="hidden" name="scode" value="<%=scode %>" />
 <input type="hidden" name="pcode" value="<%=pcode %>" />
 <input type="hidden" name="pstate" value="<%=pstate %>" />
 <input type="hidden" name="refererURL" id="refererURL" value="<%=referer %>" title="이전페이지" />
 <input type="hidden" name="rpcode" id="rpcode" value="<%=rpcode %>" title="이후페이지" />
 <input type="hidden" name="rpstate" id="rpstate" value="<%=rpstate %>" title="이후페이지상태" />  
 <input type="hidden" name="rpidx" id="rpidx" value="<%=rpidx %>" title="이후페이지키" /> 
 
</form>


<%
// 세션이 있는경우만 출력한다
if(SITE_SESSION != null){

   	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
   	if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_SESSION.get("CHGDTCNT"),"0")) > 90 
   			|| !HtmlTag.returnString((String)SITE_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) ){
%>

<!-- 변경 창  -->
<style>
/* Layer Popup */
.ly_pop { position:absolute;3 margin:0 50%; left:0px;top:1px; z-index:99999; border:5px solid #4b5876; background:#fff; box-shadow: 3px 3px 3px rgba(200, 200, 200, 0.7); padding-bottom:30px; }
.ly_pop h1 { font-size:16px; color:#fff; letter-spacing:-1px; line-height:20px; background:#4b5876; padding:5px 20px 15px 5px; font-weight:bold; margin:0;}
.ly_pop h1 span { float:left; font-size:28px; color:#fff; line-height:18px; display:inline-block; width:14px; }
.ly_pop .desc { background:#fff; padding:20px 20px 0; }
.ly_pop .tBox { border-top: solid 2px #999; border-bottom: solid 1px #999; }
.ly_pop .btn { clear:both; margin-top:17px; padding:10px 0; border-top:1px solid #e5e5e5; text-align:center; margin:17px 20px 0; }
.ly_pop .close { position:absolute; top:8px; right:8px; width:19px; height:19px;  }
.ly_pop .close a:before { width:20px; height:2px; content:''; display:block; position:absolute; top:23px; 
/*방향회전*/-webkit-transform:rotate(-45deg); -moz-transform:rotate(-45deg); -ms-transform:rotate(-45deg); -o-transform:rotate(-45deg); transform:rotate(-45deg); }
.ly_pop .close a:after { width:20px; height:2px; content:''; display:block; position:absolute; top:23px;
/*방향회전*/-webkit-transform:rotate(45deg); -moz-transform:rotate(45deg); -ms-transform:rotate(45deg); -o-transform:rotate(45deg); transform:rotate(45deg); }
.ly_pop .pw_change_txt { text-align:center; padding:30px 0; font-size:20px; }
.ly_pop .btn_change { text-align:center; margin-top:10px; }
.ly_pop .change_table { width:80%; margin:0 auto; }
.ly_pop .change_table .change_line th { background:#dfe6ef; font-weight:normal; font-size:16px; text-align:left; padding:15px 20px; border:1px solid #a8a8a8; } 
.ly_pop .change_table .change_line td { background:#fff; font-weight:normal; font-size:16px; text-align:center; padding:15px 20px; border:1px solid #a8a8a8; }
.ly_pop .change_table .change_line td input { width:250px; background:#f6f6f6; }
.btn_round { font-size:16px; color:#fff; display:inline-block; line-height:40px; border-radius:5px; background:#3e98e6; border:1px solid #3079b8; }
.btn_round a { color:#fff; padding:0px 40px; display:block }
</style>
<div id="create_form_popup" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9000;width:600px;display:none;">
	<h1 id="popup_title_id"><span>&#8226;</span>비밀번호변경</h1><span class="close" id="btn_oh_close_icon" onclick="create_form_close()"><a href="#none;" ></a></span>
	<div class="pw_change_txt">
		비밀번호를 변경한지 3개월이 지났습니다.<br>
		<strong>변경하시고 재로그인해주세요</strong>
	</div>
	<form id="create_formfm" name="create_formfm" method="post" action="<%=RequestURL%>" >
		<input type="hidden" name="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" value="<%=pcode%>" title="페이지코드"  />
		<input type="hidden" name="pstate" value="<%=pstate%>" title="페이지상태"  />
        
        <table class="bbs change_table" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>비밀번호변경 - 기존비밀번호, 변경비밀번호, 변경비밀번호확인로 구성</caption>
            <colgroup>
				<col width="" />
				<col width="" />
            </colgroup>
            <thead>
            	<tr class="change_line">
                	<th scope="row">기존비밀번호
                    </th>
                    <td colspan="3">
                    <input type="password" name="iprev_pin_str" id="iprev_pin_str" class="input_type01 w_large" maxlength="20" />
                    </td>
                </tr>
            	<tr class="change_line">
                	<th scope="row">변경비밀번호
                    </th>
                    <td colspan="3">
                    <input type="password" name="inext_pin_str" id="inext_pin_str" class="input_type01 w_large" maxlength="20" />
                    </td>
                </tr>  
            	<tr class="change_line">
                	<th scope="row">변경비밀번호확인
                    </th>
                    <td colspan="3">
                    <input type="password" name="inext_pin_str2" id="inext_pin_str2" class="input_type01 w_large" maxlength="20" />
                    </td>
                </tr>
            	<tr>
                    <td scope="row" id="create_form_in_btns" colspan="2">
						<div class="section aC mT5 mB5 btn_change">
						<span class="btn_round" id="btn_create_form_insert"><a href="#none;" onclick="create_form_insert()">변경</a></span>
						<span class="btn_round" id="btn_create_form_close"><a href="#none;" onclick="create_form_later()">다음에 변경</a></span>
						</div>                    
                    </td>                    
                </tr>                
            </thead>
         </table>
	</form>
</div>

<%
	}
}
%>
	

<script type="text/javascript">
//<![CDATA[
           
	$(function(){
		$('#contents').parent('div').addClass('login');
		<%
		// 세션이 있는경우만 출력한다
		if(SITE_SESSION != null){
        	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
        	if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_SESSION.get("CHGDTCNT"),"0")) > 90 
        			|| !HtmlTag.returnString((String)SITE_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) ){
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
 		}
		%>
		
		$('#id').focus();
		
		if($.cookie('userId') != "") {
			$("#id").val($.cookie('userId'));
			$("#login_chk").prop('checked', true);
	    }else{
	    	$("#login_chk").prop('checked', false);
	    }
		
		$("#login_chk").change(function(){
			if($("#login_chk").is(":checked")){
				$.cookie('userId', $("#id").val());
			}else{
				$.cookie('userId', "");
			}
		});
		
		$("#btn_login").click( function() {
			
			if($("#id").val() == ""){
				alert("아이디을 입력해주세요.");
				$("input[name=id]").focus();
				return false;
			}
			
			if($("#PassWord").val() == ""){
				alert("비밀번호을 입력해주세요.");
				$("input[name=PassWord]").focus();
				return false;
			}
			
			$.cookie('userId', $("#id").val());
			$("input[name=pcode]").val("login");
			
			document.dataForm.submit();
		});
		
		$("#PassWord").on("keydown", function(e) {
			if (e.keyCode == 13) {
				$("#btn_login").trigger("click");
				return false;
			}
		});
		
		/*$(".memLogin").find("#findId").click( function() {
			
			var clickId = this.id;
			
			if(clickId == "join"){
				//alert("임시오픈중에는 회원가입이 안됩니다.");
				//return;				
				$("input[name=pcode]").val("000138");
			}else if(clickId == "findId"){
				$("input[name=pcode]").val("000254");
			}else if(clickId == "findPw"){
				$("input[name=pcode]").val("000255");
			}
			
			$("input[name=pstate]").val("L");
			document.dataForm.submit();
		});*/
		
		$(".memLogin").find("#findId").click( function() {
			
			var clickId = this.id;
			
			$("input[name=pcode]").val("000254");
		
			$("input[name=pstate]").val("L");
			document.dataForm.submit();
		});	
		
		$(".memLogin").find("#findPw").click( function() {
			
			var clickId = this.id;
			
			$("input[name=pcode]").val("000255");
		
			$("input[name=pstate]").val("L");
			document.dataForm.submit();
		});	
		
		$(".memJoin").find("#join").click( function() {
			
			var clickId = this.id;
			
			$("input[name=pcode]").val("000138");
		
			$("input[name=pstate]").val("L");
			document.dataForm.submit();
		});		
		
	});
	
<%
// 세션이 있는경우만 출력한다
if(SITE_SESSION != null){

   	// 비밀번호 변경일이 90일이 지난경우, 초기비밀번호 수정 여부 체크
    if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals("") && ( Integer.parseInt(HtmlTag.returnString((String)SITE_SESSION.get("CHGDTCNT"),"0")) > 90 
       			|| !HtmlTag.returnString((String)SITE_SESSION.get("PASSWDINITYN"),"N").equals("Y") ) ){
%>
	
	//TODO : create_form_close 
	// 변경창 닫기
	function create_form_close(){
		$("#create_form_popup").hide();
		create_form_init();
		CmclospageDisable();
	}
	
	//다음에 변경
	function create_form_later(){
	
		//다음에 변경시 메인화면으로 이동
		document.location.href = "<%=RequestURL%>?scode=S01";
	
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
			if($("form[name=create_formfm]").find("input[name=inext_pin_str]").val().length < 9 || $("form[name=create_formfm]").find("input[name=inext_pin_str]").val().length > 20){
				alert("변경비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
				$("form[name=create_formfm]").find("input[name=inext_pin_str]").focus();
				return;
			}
			
			if(!$("form[name=create_formfm]").find("input[name=inext_pin_str]").val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
				alert("변경비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
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
	
//]]>
</script>