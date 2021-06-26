<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/S01/Cmfooter    
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
/* 설명              : SYSTEM 시스템 관리자 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 
/* 최근 수정일시     : 
/* 최종 수정내용     : 
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
    <footer id="footer"><!--푸터영역-->
        <a id="footer" href="#n" tabindex="-1" class="hide">하단정보</a>
        <div class="footer_t">
            <div class="wrap">
                <ul>
                    <li><a href="https://www.komipo.co.kr/fr/content/128/main.do?mnCd=FN130201" target="_blank"><b>개인정보처리방침</b></a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000051','000048','Y');return false;">찾아오시는길</a></li>
                </ul>
                <div class="familySite">
                    <a href="#n">관련기관 서비스</a>
                    <!--0620 관련기관서비스 메뉴 추가-->
                    <ul>
                        <li><a href="http://www.smba.go.kr" target="_blank">중소기업청</a></li>
                        <li><a href="http://hp.sbc.or.kr/" target="_blank">중소기업진흥공단</a></li>
                        <li><a href="http://www.kbiz.or.kr/home/homeIndex.do" target="_blank">중소기중앙화</a></li>
                        <li><a href="http://www.bizinfo.go.kr/spi/jsp/spt/userguidance/rss.jsp" target="_blank">기업마당(黨 비즈인포)</a></li>
                    </ul>
                    <!--0620 관련기관서비스 메뉴 추가-->
                </div>
            </div>
        </div>
        <div class="footer_b">
            <div class="wrap">
                <h1 class="logo_f"><a href="#">KOMIPO</a></h1>
                <address>본사 : (33439)충청남도 보령시 보령북로 160&emsp;대표자명 : 김호빈<br>사업자등록번호 : 120-86-19170&emsp;대표전화 : 070-7511-1114&emsp;FAX : 070-7511-1046<br>COPYRIGHT © 2019 KOREA MIDLAND POWER Co., LTD. ALL RIGHTS RESERVED.</address>
                <div class="mark">
                    <a href="http://www.kwacc.or.kr/CertificationSite/WA/List" title="웹접근성 품질인증마크(새창열림)" target="_blank">
                        <img src="<%=con_root %>/images/project_img/common/web_mark.png" alt="국가공인 웹 접근성 품질인증마크" style="width: 68px; height: 48px;">
                    </a>
                    <%-- <div class="certifymark">
                        <img src="<%=con_root %>/images/project_img/common/pims_mark.png" alt="개인정보보호 관리체게 인증">
                        <div class="text">
                            <span>인증유형 : 유형4</span>
                            <span>유효기간 : 2016.11.11~2019.11.10</span>
                            <span>인증범위 : 외부자 및 임직원 개인정보 처리 서비스</span>
                        </div>
                    </div> --%>
                </div>
            </div>
        </div>
    </footer><!--//푸터영역-->
    <!-- 
				<li><a href="<%=RequestURL%>?scode=<%=scode %>&amp;pcode=000393">개인정보처리방침</a></li>
				<li><a href="http://home.kepco.co.kr/kepco/CU/G/C/CUGCPP00101.do?menuCd=FN120403" target="_new">개인정보침해신고</a></li>
				<li><a href="<%=RequestURL%>?scode=<%=scode %>&amp;pcode=000394">이메일주소무단수집금지</a></li>
				<li><a href="<%=RequestURL%>?scode=<%=scode %>&amp;pcode=000471">이용약관</a></li>    
     -->
    

<a href="#" id="top_move_btn" style="display:scroll;position: fixed; right: 2%; bottom: 2%; text-align: center;opacity:0.5;border:2px solid rgba(204, 204, 204, 1);border-radius: 12px;padding: 5px;cursor:pointer;">
	<img src="<%=img_url %>/cm/up_ar2.png" style="width:3em;" alt="상단으로 이동"/>
</a>
<form name="pagego" id="pagego" method="post">
	<input type="hidden" name="scode" value="<%=HtmlTag.returnString((String)request.getAttribute("scode"),"")%>">
	<input type="hidden" name="pcode" value="<%=HtmlTag.returnString((String)request.getAttribute("pcode"),"")%>">
	<input type="hidden" name="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="sidx" id="sidx" value="" title="선택된인덱스" />	
</form>

<form name="cmPwForm" id="cmPwForm" method="post" onSubmit='javascript:return false;'>
	<input type="hidden" name="scode" id="scode" value="<%=HtmlTag.returnString((String)request.getAttribute("scode"),"")%>">
	<input type="hidden" name="pcode" id="pcode" value="<%=HtmlTag.returnString((String)request.getAttribute("pcode"),"")%>">
	<input type="hidden" name="pstate" id="pstate" title="페이지상태"  />
	<input type="hidden" id="pageStatus" name="pageStatus" title="화면명" />
	<input type="hidden" id="ikey_data" name="ikey_data" title="키값" />
	
	
	<div class="password_layer" >
		<div class="password_box">
			<div class="pass_tit">비밀번호 입력</div>
			<dl>
				<dt><label for="">비밀번호<br />(비밀번호는 영문,숫자,특수문자 조합으로 9~20자리)</label></dt>
				<dd><input type="password" id="req_SECRET_NO" name="req_SECRET_NO" style="width:95%;" maxlength="20" title="비밀번호를 입력하세요"></dd>
			</dl>
			<!--button-->
			<div style="margin-top:20px;">
				<a href="#" class="btnBL" id="password_ly_confirm" onclick="return false;">확인</a>
				<a href="#" class="btnRM" id="password_ly_close" onclick="return false;">취소</a>
			</div>
			<!--//button-->
		</div>
	</div>
	
	
	
	<div class="password_layer2" style="display:none;">
		<div class="password_box">
			<div class="pass_tit">비밀번호 변경</div>
			<c:if test='${!empty R_MAP.edReqDtl.rqester_password}'>
			<dl>
				<dt><label for="">이전 비밀번호</label></dt>
				<dd><input type="password" id="before_password" name="before_password" class="input_type01 w_100" maxlength="20" title="이전비밀번호를 입력하세요"></dd>
			</dl>
			</c:if>
			<dl>
				<dt><label for="">신규 비밀번호<br />(비밀번호는 영문,숫자,특수문자 조합으로 9~20자리)</label></dt>
				<dd><input type="password" id="after_password" name="after_password" class="input_type01 w_100" maxlength="20"  title="비밀번호를 입력하세요"></dd>
			</dl>
			<dl>
				<dt><label for="">신규 비밀번호 확인</label></dt>
				<dd><input type="password" id="after_password_confirm" name="after_password_confirm" class="input_type01 w_100" maxlength="20" title="비밀번호 확인를 입력하세요"></dd>
			</dl>
			<div class="button mat_20">
				<a href="#" class="btn_1 size_s" id="btn_confirm2">확인</a>
				<a href="#" class="btn_2 size_s password_close" id="btn_cancel">취소</a>
			</div>
		</div>
	</div>
	
	
</form>

<iframe name ="successIframe" id="successIframe" width="100%" height="0" title="결과처리프레임" style="display:none;"></iframe>

<!--//footer-->
<%
String help_m_code = "";
String help_cnt = "";
if(MENUCFG!=null){
	help_m_code = (String)MENUCFG.get("menuCd");
	if(MENUCFG.get("helpCnt")!=null){
		help_cnt = String.valueOf(MENUCFG.get("helpCnt"));
	}
	
}

if(!help_m_code.equals("") && !help_cnt.equals("0") && !help_cnt.equals("")){
%>
<!-- 도움말 조회 창  -->
<div id="create_form_helppopup" class="ly_pop" style="position:absolute;top:0%;left:-800px;z-index:9000;width:35%;height:70%;display:none;">
	<span id="help_drag_obj"><h1 id="sel_help_title"><span>&#8226;</span>도움말</h1><span class="close" id="btn_help_close_icon" onclick="create_form_helpclose()"><a href="#" ></a></span></span>
	<form name="create_formfm_help" id="create_formfm_help" method="post" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="000008" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="000016" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="XP1" title="페이지상태"  />
		<input type="hidden" name="curr_page" id="curr_page" value="1" title="현재페이지번호"  />
		<input type="hidden" name="show_rows" id="show_rows" value="1000" title="현재페이지당데이터수"  />
		<input type="hidden" name="m_code" id="m_code" value="<%=help_m_code %>" title="선택메뉴코드"  />
        <div class="board_A0_W" style="padding:5px;"><!-- 하단 복합영역 구분-->
        	<div class="section" style="height:600px;overflow-y:scroll;">
		        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
		            <caption>도움말정보</caption>
		            <colgroup>
		                <col width="15%" />
		                <col width="*" />
		                <col width="20%" />
		                <col width="*" />
		            </colgroup>
		            <thead>
		            	<!-- <tr>
		                	<th scope="row" colspan="4">도움말</th>
		                </tr> -->
		                <tr>
		                    <td colspan="4" id="editor_top_helptd" style="background-color:#ffffff;">
		               
		                    </td>
		                </tr>
		                
		            </thead>
		         </table>
		     </div>
				<!-- 버튼 -->
				<div class="button a_r fL mat_15">
					<!-- 버튼 -->	
					<a href="#" class="btn_2 size_s" id="btn_create_form_helpclose" style="" onclick="create_form_helpclose();return false;">닫기</a>
				</div>
				<!-- 버튼 --> 
		</div>        
	</form>
</div>
<!-- 등록,수정 창  -->
<%
}
%>
<!-- help_m_code:<%=help_m_code %><br />
help_cnt:<%=help_cnt %><br /> -->
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#password_ly_confirm").click(function(e){
			fnPwConfirm();
		});
		
		$("#password_ly_close").click(function(e){
			fnClosePwLayer();
		});	
		
		$("#btn_confirm2").click(function(e){
			fnPwConfirm();
		});
		$("#req_SECRET_NO").bind("keydown", function(e) {
            if (e.keyCode == 13) {
            	fnPwConfirm();
            	return false;
            }
        });

		var topmoveEle = $('#top_move_btn');
		var delay = 300;
		topmoveEle.on('click', function() {
		  $('html').stop().animate({scrollTop: 0}, delay);
		});	
		topmoveEle.hide();
		$(window).scroll(function(){
			var wh = $(window).height();
			var st = $(window).scrollTop();
			//console.log("height::::"+wh+"::st::::"+st);
			//console.log("top::"+(wh+st-50));
			if(wh+st < wh+20){
				topmoveEle.hide();
			}else{
				topmoveEle.show();
			}
			
		});
		<%
		if(!help_m_code.equals("") && !help_cnt.equals("0") && !help_cnt.equals("")){
		%>
		// 도움말 객체를 body 에 append한다
		$("body").append($('#create_form_helppopup'));
		// 등록, 수정 폼 드래그앤 드롭 이동
	    $('#create_form_helppopup').draggable({ opacity:"0.3" }); // 끄는 동안만 불투명도 주기

	    $("body").droppable({

	        accept: "#help_drag_obj",    // 드롭시킬 대상 요소

	        drop: function(event, ui) {

	        	$('#create_form_helppopup').css({ opacity:"1.0" });

	        }

	    });		
	    $(".main_title").find("strong").append("&nbsp;&nbsp;<div id='help_icon_id' style='display:inline-block;width:35px;height:35px;text-align:center;background-image:url(/images/cm/cir_2.png);background-repeat:no-repeat;background-size:100% 100%;cursor:pointer;' onclick='Go_HelpMngView();return false;'>?</div>");
	    setInterval(fnHelpIconupdateTm, 1000);
		<%
		}
		%>
		
	});
	
	var iconnum = "2";
	var  fnHelpIconupdateTm = function(){
		if(iconnum=="2"){
			$("#help_icon_id").css("background-image","url(/images/cm/cir_2.png)");
			iconnum="3";
		}else{
			$("#help_icon_id").css("background-image","url(/images/cm/cir_3.png)");
			iconnum="2";			
		}
		//console.log("iconnum:"+iconnum);
		
	};
	
	var fnOpenPwLayer = function(pageSeq, pageStatus){
		//alert(pageSeq+"----"+pageStatus);
		$("#cmPwForm").find("#pageStatus").val(pageStatus);
		$("#cmPwForm").find("#ikey_data").val(pageSeq);
		
		$('.password_layer').addClass('on');
		
		// 수정, 등록창의 위치를 잡는다
		$(".password_layer").css("left",( $(document).scrollLeft() )+"px");
		$(".password_layer").css("top", ( $(document).scrollTop() )+"px");
		
		$('body').addClass('no_scroll');
		CmopenpageDisable();
		$("#req_SECRET_NO").focus();
	};
	
	var fnClosePwLayer = function(pageSeq, pageStatus){
		//alert(pageSeq+"----"+pageStatus);
		$("#cmPwForm").find("#pageStatus").val("");
		$("#cmPwForm").find("#ikey_data").val("");
		
		   $('.password_layer').removeClass('on');
		   $('.password_layer2').removeClass('on');
		   $('body').removeClass('no_scroll');
		   CmclospageDisable();
		$("#btn_mod").focus();
	};
	

	
	var fnPwConfirm = function(){
		
		var dpLayer = $('.password_layer').hasClass("on");
		
		if(dpLayer){
			if ($("#cmPwForm").find("#req_SECRET_NO").val()=="") {
				alert("비밀번호를 입력해 주시기 바랍니다.");
				$("#cmPwForm").find("#req_SECRET_NO").focus();
				return;
			}
			// 비밀번호가 입력되어있을경우 비밀번호를 체크한다
			if(!isEmpty($("#cmPwForm").find('#req_SECRET_NO').val()) ){
				if($("#cmPwForm").find('#req_SECRET_NO').val().length < 9 || $("#cmPwForm").find('#req_SECRET_NO').val().length > 20){
					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
					$("#cmPwForm").find('#req_SECRET_NO').focus();
					return;
				}
				
				if(!$("#cmPwForm").find('#req_SECRET_NO').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
					$("#cmPwForm").find('#req_SECRET_NO').focus();
					return;
				}				
			}			
			/*if ($("#cmPwForm").find("#req_SECRET_NO").val().length < 4) {
				alert("비밀번호는 숫자4자리로 입력해 주시기 바랍니다.");
				$("#cmPwForm").find("#req_SECRET_NO").focus();
				return;
			}*/
		}else{
			if($("#cmPwForm").find("#before_password").val() == ""){
				alert("이전 비밀번호를 입력해 주시기 바랍니다.");
				$("#cmPwForm").find("#before_password").focus();
				return false;
			}
			
			if($("#cmPwForm").find("#after_password").val() == ""){
				alert("신규 비밀번호를 입력해 주시기 바랍니다.");
				$("#cmPwForm").find("#after_password").focus();
				return false;
			}else{
				
				// 비밀번호가 입력되어있을경우 비밀번호를 체크한다
				if(!isEmpty($("#cmPwForm").find('#after_password').val()) ){
					if($("#cmPwForm").find('#after_password').val().length < 9 || $("#cmPwForm").find('#after_password').val().length > 20){
						alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
						$("#cmPwForm").find('#after_password').focus();
						return;
					}
					
					if(!$("#cmPwForm").find('#after_password').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
						alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
						$("#cmPwForm").find('#after_password').focus();
						return;
					}				
				}
				/*
				if($("#cmPwForm").find("#after_password").val().length < 4 ){
					alert('비밀번호는 숫자4자리로 입력해 주시기 바랍니다.');
					$("#cmPwForm").find('#after_password').focus();
					return;
				}
				*/
				
				if($("#cmPwForm").find("#after_password").val() ==  $("#cmPwForm").find("#before_password").val()){
					alert('이전 비밀번호와 신규 비밀번호가 동일합니다. \n비밀번호를 다시 입력하여 주시기 바랍니다!');
					$("#cmPwForm").find('#after_password').focus();
					return;
				}
				

			}
			
			if($("#cmPwForm").find("#after_password_confirm").val() == ""){
				alert("신규 비밀번호 확인을 입력해 주시기 바랍니다.");
				$("#cmPwForm").find("#after_password_confirm").focus();
				return false;
			}
			
			if($("#cmPwForm").find("#after_password").val() != $("#cmPwForm").find("#after_password_confirm").val()){
				alert("입력하신 비밀번호가 일치하지 않습니다.");
				$("#cmPwForm").find("#after_password_confirm").focus();
				return false;
			}
		}
		
		$("#cmPwForm").find("input[name=pstate]").val("PWC");
		
		var params = jQuery("#cmPwForm").serialize();

		$.ajax({ type     : "post"
			   , url      : "<c:url value='/cmsajax.do' />"
			   , data     : params
			   , async    : false
			   , dataType :"json"
			   , timeout  : 3000
			   , error    : function (jqXHR, textStatus, errorThrown) {
				   // 통신에 에러가 있을경우 처리할 내용(생략가능)
				   alert("네트웍장애가 발생했습니다. 다시시도해주세요");
				   $('.password_layer').removeClass('on');
				   $('.password_layer2').removeClass('on');
				   $('body').removeClass('no_scroll');
				   CmclospageDisable();
				   return false;
			   }			             
			   , success  : function(data){
				   if (data.result==true){
					   try{
						   data.pageStatus = $("#cmPwForm").find("#pageStatus").val();
						   data.ikey_data = $("#cmPwForm").find("#ikey_data").val();
						   data.chk_secret_no = $("#cmPwForm").find("#req_SECRET_NO").val();
						   fnPwcCallBack(data); 
					   }catch(e){
						   alert("정의되지 않은 함수 오류입니다.");
						   return false;
					   }
					   
					   $('.password_layer').removeClass('on');
					   $('.password_layer2').removeClass('on');
					   $('body').removeClass('no_scroll');
					   CmclospageDisable();
				   }else{
					   if(data.TRS_MSG==""){
						   alert("비밀번호가 일치하지 않습니다.");
					   }else{
						   alert(data.TRS_MSG);
					   }
				       	
						   $('.password_layer').removeClass('on');
						   $('.password_layer2').removeClass('on');
						   $('body').removeClass('no_scroll');
						   CmclospageDisable();				       	
				       	return false;
					   
			       }
			   }
		});
	}
	
	//도움말관리		
	function Go_HelpMngView(){	
		CmopenpageDisable();
		var i = 0;
		
		var sc_pos = 0;
		$("#sel_help_title").html("<span >&#8226; </span> <%if(!M_PATH_STR.equals("")){%><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%><%}%> 도움말");
		
		// ajax로 도움말이 등록되어있는지 확인한다.
		$("form[name=create_formfm_help]").find("#pstate").val("XP1");
			var params =  $("form[name=create_formfm_help]").serialize();
			
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
		        },
		        success: function(data){
		        	
		           if(data.result==true){
						if(data.rows!=""){
							//데이터 셋팅
							$("#editor_top_helptd").html(data.rows[0].m_contents.replace(/&amp;quot;/gi,"\"").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&").replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&amp;/gi,"&"));
						}else{

							$("#editor_top_helptd").html("");

						}
		           
		           }else{
			        	alert(data.TRS_MSG);
			        			        	
		           }
		           
		        }
			});	
		
		var pop_w = 750;
		var pop_h = 550;

		// 수정, 등록창의 위치를 잡는다
		$("#create_form_helppopup").css("left",( (($(document).width() - pop_w) / 2) + $(document).scrollLeft() )+"px");
		$("#create_form_helppopup").css("top", ((($(document).height() - pop_h) / 10) + $(document).scrollTop() )+"px");		

		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);

		
		
		$("#create_form_helppopup").show(500);	
	}	
	
	//TODO : create_form_helpclose 
	//등록 ,수정창 닫기
	function create_form_helpclose(){
		$("#create_form_helppopup").hide();
		$("#editor_top_helptd").html("");
		CmclospageDisable();
	}	
</script>