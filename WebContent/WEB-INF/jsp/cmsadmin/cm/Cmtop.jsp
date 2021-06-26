<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cmsadmin/cm/Cmtop.jsp
/* 프로그램 이름     : Cmtop    
/* 소스파일 이름     : Cmtop.jsp
/* 설명              : SYSTEM 시스템 관리자top페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-15
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
Map ADMININFO = (Map)request.getAttribute("ADMININFO");
%>
	<!-- header 시작 -->
	<div id="header">
		<div id="header_inner">
			<!--Header Title Area-->
			<div class="hta">
				<h1>
					<a href="#" onclick="location.href='<%=RequestURL%>?scode=<%=scode %>&amp;pcode=main'"><%=_system_name %></a>
				</h1>
			</div>
			<!--//Header Title Area-->
			<div class="line_msg">
				<b><%=((String)SITE_ADM_SESSION.get("USER_NM"))%></b>
				<span>최근접속일 : <%=((String)SITE_ADM_SESSION.get("LASTLOGIN"))%></span> 
				<span style="margin-left:40px;"><b>시스템운영자 : 전화:<%=((String)ADMININFO.get("naesun"))%>, Email:<%=((String)ADMININFO.get("email"))%></b></span> 
			</div>
			<div style="position:absolute;top:0;right:248px;width:130px;background:rgba(0, 153, 61, 1);text-align:center;line-height:40px;opacity:0.8;font-size:14px:border-right:1px solid #ddd">
				<a herf="#" onclick="admInfoChg();return false;" style="color:#fff;cursor:pointer;">정보변경</a>
			</div>			
			<div style="position:absolute;top:0;right:118px;width:130px;background:#052b63;text-align:center;line-height:40px;opacity:0.8;font-size:14px:border-right:1px solid #ddd">
				<a herf="#" onclick="pwdChg();return false;" style="color:#fff;cursor:pointer;">비밀번호변경</a>
			</div>
			<!--Global Navigation Bar-->
			<div class="gnb">
				<ul>
					<li class="alt"><a href="#" onclick="location.href='<%=RequestURL%>?scode=<%=scode %>&amp;pcode=logoff'">로그아웃</a></li>
				</ul>
			</div>
			<!--//Global Navigation Bar-->		</div>   	
	</div> 
	


<!-- 등록,수정 창  -->	
	<!-- header 끝 -->
	<script type="text/javascript">
	function pwdChg(){
		popWinScroll("<c:url value='/cmsmain.do'/>?scode=000008&pcode=000014", "pwChgWinPop", 602, 360);
	}
	
	function admInfoChg(){
		CmopenpageDisable();
		
		// 로그인한 사용자의 정보를 불러온다.
		$("form[name=admInfoChg_formfm]").find("#pstate").val("X3");
		
		var params =  $("form[name=admInfoChg_formfm]").serialize();
		
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

	           if(data.ViewMap == null || data.ViewMap == ""){
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_user_nm").val("");	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_sosok_han").val("");	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_zzjikmu_txt").val("");	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_moblphon").val("");
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_naesun").val("");
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_email").val("");
		        	
        	   
	           }else{
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_user_nm").val(data.ViewMap.user_nm);	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_sosok_han").val(data.ViewMap.sosok_han);	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_zzjikmu_txt").val(data.ViewMap.zzjikmu_txt);	
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_moblphon").val(data.ViewMap.moblphon);
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_naesun").val(data.ViewMap.naesun);
	        	   $("form[name=admInfoChg_formfm]").find("#admInfo_email").val(data.ViewMap.email);		
	           }


	           $("form[name=admInfoChg_formfm]").find("#pstate").val("L");
	        }
			
		});			
		
		
		// 수정, 등록창의 위치를 잡는다
		$("#admInfoChgPop").css("left",( (($(document).width() - 600) / 2) + $(document).scrollLeft() )+"px");
		$("#admInfoChgPop").css("top", ($(document).scrollTop() +100)+"px");	
		//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);

		
		
		$("#admInfoChgPop").show(500);		
	}
	
	// 등록 ,수정창 닫기
	function admInfoChg_close(){
		$("#admInfoChgPop").hide();
		CmclospageDisable();
	}	
	
	// 로그인사용자 정보 변경처리
	function admInfoChg_update(){
		//========== 필수 체크 start ==========
		if(isEmpty($("form[name=admInfoChg_formfm]").find("#admInfo_user_nm").val())){
			alert("사용자명 입력해주세요.");
			$("form[name=admInfoChg_formfm]").find("#admInfo_user_nm").focus();
			return;
		}

		/*if(isEmpty($("form[name=admInfoChg_formfm]").find("#admInfo_sosok_han").val())){
			alert("소속을 입력해주세요.");
			$("form[name=admInfoChg_formfm]").find("#admInfo_sosok_han").focus();
			return;
		}
		
		if(isEmpty($("form[name=admInfoChg_formfm]").find("#admInfo_zzjikmu_txt").val())){
			alert("직위를 입력해주세요.");
			$("form[name=admInfoChg_formfm]").find("#admInfo_zzjikmu_txt").focus();
			return;
		}*/
		
		if(isEmpty($("form[name=admInfoChg_formfm]").find("#admInfo_moblphon").val())){
			alert("휴대폰번호를 입력해주세요.");
			$("form[name=admInfoChg_formfm]").find("#admInfo_moblphon").focus();
			return;
		}
		
		if(isEmpty($("form[name=admInfoChg_formfm]").find("#admInfo_email").val())){
			alert("이메일을 입력해주세요.");
			$("form[name=admInfoChg_formfm]").find("#admInfo_email").focus();
			return;
		}
		
		//========== 필수 체크 end ==========	
		$("form[name=admInfoChg_formfm]").find("#pstate").val("U3");
		
		var params =  $("form[name=admInfoChg_formfm]").serialize();
		
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
        	   	   	alert("변경처리되었습니다.");
        	   		admInfoChg_close();
	           }else{
	        	   	alert("변경중 오류가 발생했습니다.");
	           }


	           $("form[name=admInfoChg_formfm]").find("#pstate").val("L");
	        }
			
		});				
	}
	</script>
