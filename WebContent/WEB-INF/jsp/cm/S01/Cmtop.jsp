<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/jsp/cm/S01/Cmtop    
/* 프로그램 이름     : Cmtop    
/* 소스파일 이름     : Cmtop.jsp
/* 설명              : SYSTEM 시스템 관리자top페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-11-11
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-11-11
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%
	String js_treelist_nm = "listtreeval";
	String mnb_on_cls = "";
	String[] M_PATH_STR_arr = new String[0];
	String[] CUR_M_PATH_CODE_arr = new String[0];

	if (!pcode.equals("main")) {
		if (MENUCFG == null) {
			MENUCFG = (Map) rtn_Map.get("MENUCFG");
			//site_title = ((String)MENUCFG.get("mNms")).replaceAll("ROOT::", "");
		} else {
			//site_title = ((String)MENUCFG.get("mNms")).replaceAll("ROOT::", "");
		}

		// 현재 선택된 메뉴의 경로
		M_PATH_STR_arr = M_PATH_STR
				.substring(0, M_PATH_STR.lastIndexOf("::") + 2)
				.replaceAll("ROOT::", "").split("::");
		CUR_M_PATH_CODE_arr = CUR_M_PATH_CODE
				.substring(0, CUR_M_PATH_CODE.lastIndexOf("::") + 2)
				.replaceAll("000000::", "").split("::");

	}
%>
<!-- disable -->
<div id="pageDisable" style="position: absolute; width: 100%; height: 100%; top: 0%; left: 0%; z-index: 8000; display: none;"></div>
<!-- disable -->
<div class="loadingarea" id="loadingarea" style="display: none;">
	<div class="loading">로딩중입니다.</div>
	<div class="loading_txt">Loading...</div>
	<div class="loading_shadow">가림영역</div>
</div>
<div title="스킵메뉴" class="skipMenu">
	<a href="#nav" tabindex="-1">주 메뉴 바로가기</a>
	<a href="#contents">본문 바로가기</a>
</div>
<!--//스킵네비게이션-->
<div class="shadow"></div>
<header>
	<!--헤더영역-->
	<div class="header_t">
		<div class="wrap">
			<div class="quick_link">
				<ul>
					<li><a href="https://blog.naver.com/komipo_official" class="blog" target="_blank">BLOG</a></li>
					<li><a href="https://www.facebook.com/komipo" class="facebook" target="_blank">FACEBOOK</a></li>
					<li><a href="https://www.instagram.com/komipo_official" class="instagram" target="_blank">INSTAGRAM</a></li>
					<li><a href="https://www.youtube.com/channel/UCew6PRDs_1tIZ0tGvqgpDWw" class="youtube" target="_blank">YOUTUBE</a></li>
					<li><a href="https://www.komipo.co.kr/kor/main/main.do" class="komipo" target="_blank">한국중부발전</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="header_b">
		<div class="wrap">
			<h1 class="logo">
				<a href="<c:out value="${basePath }"/>/cmsmain.do?scode=S01&pcode=main">KOMIPO동반성장오픈플랫폼</a>
			</h1>
			<div class="right">
				<div class="menu_open">메뉴열기</div>
				<nav id="nav">
					<!--메뉴-->
					<div class="mobile_top">
						<ul>
							<li><a href="https://blog.naver.com/komipo_official" class="blog" target="_blank">BLOG</a></li>
							<li><a href="https://www.facebook.com/komipo" class="facebook" target="_blank">FACEBOOK</a></li>
							<li><a href="https://www.instagram.com/komipo_official" class="instagram" target="_blank">INSTAGRAM</a></li>
							<li><a href="https://www.youtube.com/channel/UCew6PRDs_1tIZ0tGvqgpDWw" class="youtube" target="_blank">YOUTUBE</a></li>
						</ul>
					</div>
					<ul id="mnb_data" style="height: auto;">
						<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
							<li id="mnb_0<c:out value="${i.count}"/>" class="">
								<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${oneMenuList.menuCd }"/>"><c:out value="${oneMenuList.menuNm }"/></a>
								<div class="depth2 menu0<c:out value="${i.count}"/>" style="display: none;">
									<div class="menuBg">
										<c:choose>
											<c:when test="${i.count eq '1'}">
												<img src="<c:out value="${basePath}"/>/images/project_img/common/menuBg01.jpg" alt="동반성장전략 중부발전은 동반성장 정책을 선도적으로 추진합니다">
											</c:when>
											<c:when test="${i.count eq '2'}">
												<img src="<c:out value="${basePath}"/>/images/project_img/common/menuBg02.jpg" alt="동반성장문화확산 중부발전은 중소기업과의 교류를 통해 동반성장 문화를 확산시키는데 기여합니다">
											</c:when>
											<c:when test="${i.count eq '3'}">
												<img src="<c:out value="${basePath}"/>/images/project_img/common/menuBg03.jpg" alt="중소기업 지원안내 중부발전은 중소기업의 성장을 지원하며 함께 합니다">
											</c:when>
											<c:when test="${i.count eq '4'}">
												<img src="<c:out value="${basePath}"/>/images/project_img/common/menuBg04.jpg" alt="소통마당 고객의 소중한 의견을 귀담아 듣는 중부발전이 되겠습니다">
											</c:when>
											<c:otherwise>
												<img src="<c:out value="${basePath}"/>/images/project_img/common/menuBg05.jpg" alt="지원시스템 중부발전의 협력기업 지원시스템 입니다">
											</c:otherwise>
										</c:choose>
									</div>
									<ul>
										<c:forEach items="${oneMenuList.menuList}" var="twoMenuList" varStatus="j" >
											<li>
												<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${twoMenuList.menuCd }"/>"><c:out value="${twoMenuList.menuNm }"/></a>
												<ul class="depth3">
													<c:forEach items="${twoMenuList.menuList}" var="threeMenuList" varStatus="z" >
														<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${threeMenuList.menuCd }"/>"><c:out value="${threeMenuList.menuNm }"/></a></li>
													</c:forEach>
												</ul>
											</li>
										</c:forEach>
									</ul>
								</div>
							</li>
						</c:forEach>
					</ul>
				</nav>
				<!--//메뉴-->
				<div class="menu_close">메뉴닫기</div>
				<div class="utill">
					<c:choose>
						<c:when test="${empty sessionScope.SITE_SESS }">
							<div class="login">
								<a href="javascript:void(0);" onclick="Go_LoginPageView('', '','');return false;"><span>로그인</span></a>
							</div>
							<div class="join">
								<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=000138"><span>회원가입</span></a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="logoff">
								<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=logoff"><span>로그아웃</span></a>
							</div>
							<div class="join">
								<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=000404"><span>정보수정</span></a>
							</div>
						</c:otherwise>
					</c:choose>
					
					<div class="sitemap">
						<!--0620 사이트맵추가-->
						<a href="javascript:void(0);" onclick="javascript:fn_selectSiteMap();" class="openSite" style="display: block;"><span>사이트 맵</span></a> 
						<a href="javascript:void(0);" onclick="javascript:fn_closeSiteMap();" class="closeSite" style="display: none;"><span>닫기</span></a>
						<!--0620 사이트맵추가-->
					</div>
				</div>
			</div>
		</div>
		<div class="nav_bg" style="display: none; height: 278px; padding-top: 0px; margin-top: 0px; padding-bottom: 0px; margin-bottom: 0px;"></div>
		<!--0620 사이트맵추가-->
		<div class="siteMap" id="siteMapDiv" style="display: none;">
			<div class="wrap">
				<ul id="sitemap_data">
					<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
						<li id="sitemap_0<c:out value="${i.count}"/>">
							<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=<c:out value="${oneMenuList.menuCd }"/>" class="more"><c:out value="${oneMenuList.menuNm }"/></a>
							<ul class="dep2">
								<c:forEach items="${oneMenuList.menuList}" var="twoMenuList" varStatus="j" >
									<!-- 하위메뉴 있는 애들만 +버튼 및 클릭시 이벤트 분기처리 -->
									<c:choose>
										<c:when test="${fn:length(twoMenuList.menuList) > 0}">
											<li><a href="javascript:void(0);" class="more" onclick="javascript:fn_selectDepth2(this);"><c:out value="${twoMenuList.menuNm }"/></a>
										</c:when>
										<c:otherwise>
											<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=<c:out value="${twoMenuList.menuCd }"/>" class="more" style="background:none" ><c:out value="${twoMenuList.menuNm }"/></a>
										</c:otherwise>
									</c:choose>
										<ul class="depth3" >
											<c:forEach items="${twoMenuList.menuList}" var="threeMenuList" varStatus="z" >
												<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=S01&pcode=<c:out value="${threeMenuList.menuCd }"/>"><c:out value="${threeMenuList.menuNm }"/></a></li>
											</c:forEach>
										</ul>
									</li>
								</c:forEach>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
<!--0620 사이트맵추가-->
<script type="text/javascript">
//사이트 맵 오픈
fn_selectSiteMap = function() {
	$("#siteMapDiv").css("display", "block");
	$(".openSite").css("display", "none");
	$(".closeSite").css("display", "block");
};

//사이트맵 닫기
fn_closeSiteMap = function() {
	$("#siteMapDiv").css("display", "none");
	$(".openSite").css("display", "block");
	$(".closeSite").css("display", "none");
};

//2뎁스 메뉴선택시 + 및 하위메뉴 show
fn_selectDepth2 = function(aTag) {
	var classNm = $(aTag).attr("class");
	if(classNm === "more") {
		$(aTag).attr("class", "more open");
		$(".depth3").css("display", "none");
		$(aTag).parent().children("ul").css("display", "block");
	} else {
		$(aTag).attr("class", "more");
		$(".depth3").css("display", "none");
	}
};

//pc - 메인메뉴
$('nav>ul>li').on({
	mouseenter : function() {
		if (window_w > 1161) {
			$('nav>ul>li').removeClass('on');
			$(this).addClass('on');
			$(this).children('.depth2').stop().slideDown(250);
			$('.nav_bg').stop().slideDown(280);
			$('.shadow').show();
		}
	},
	focusin : function() {
		if (window_w > 1161) {
			$('nav>ul>li').removeClass('on');
			$('.depth2').stop().slideUp(250);
			$(this).addClass('on');
			$(this).children('.depth2').stop().slideDown(250);
			$('.nav_bg').stop().slideDown(280);
			$('.shadow').show();
		}
	},
	mouseleave : function() {
		if (window_w > 1161) {
			$('nav>ul>li').removeClass('on');
			$(this).children('.depth2').hide();
			$('.nav_bg').hide();
			$('.shadow').hide();
		}
	}
});
$('nav>ul>li:last-child>.depth2>ul>li:last-child>a').on('focusout',
		function() {
			$('nav>ul>li').removeClass('on');
			$('.depth2').stop().slideUp(250);
			$('.nav_bg').stop().slideUp(250);
			$('.shadow').hide();
		});

//tablet, mobile - 메인메뉴
var menu1_status = $(this).hasClass('on');
$('.menu_open').on('click', function() {
	$(this).hide();
	$('nav').css('display', 'block');
	$('nav').animate({
		right : -20
	}, 500);
	$('.menu_close').show();
	$('.mobile_top').show();
	$('.shadow_h').show();
	$("html, body").css({
		overflow : "hidden",
		height : "auto"
	}).unbind('scroll touchmove mousewheel');
});
$('.menu_close').on('click', function() {
	$(this).hide();
	$('nav').css('display', 'none');
	$('.menu_open').show();
	$('nav').animate({
		right : -2000
	}, 500);
	$('.mobile_top').hide();
	$('.shadow_h').hide();
	$("html, body").css({
		overflow : "visible",
		height : "auto"
	}).unbind('scroll touchmove mousewheel');
});
$('nav>ul>li>a').on('click', function() {
	if (window_w < 1161) {
		$('.depth2>ul>li>a.more').attr('href', '#n');
		$('.nav_bg').hide();
		menu1_status = $(this).hasClass('on');
		if (menu1_status == true) {
			$(this).removeClass('on');
			$(this).next('.depth2').stop().slideUp(250);
		} else {
			$('nav>ul>li>a').removeClass('on');
			$(this).addClass('on');
			$('.depth2').stop().slideUp(250);
			$(this).next('.depth2').stop().slideDown(250);
		}
	}
});

function Go_SubmenuView(pcode, sidx){
	$("form[name=pagego]").find("input[name=pcode]").val(pcode);
	$("form[name=pagego]").find("input[name=sidx]").val(sidx);
	$("form[name=pagego]").find("input[name=pstate]").val("R");
	$("form[name=pagego]").attr("action","<%=RequestURL%>");
	$("form[name=pagego]").submit();
}

function Go_LoginPageView(rpcode, rpstate, rpidx){
	$("form[name=pagego]").find("input[name=pcode]").val("000253");
	$("form[name=pagego]").find("input[name=sidx]").val("");
	$("form[name=pagego]").find("input[name=pstate]").val("");
	$("form[name=pagego]").append("<input type='hidden' name='rpcode' id='rpcode' value='"+rpcode+"' />");
	$("form[name=pagego]").append("<input type='hidden' name='rpstate' id='rpstate' value='"+rpstate+"' />");
	$("form[name=pagego]").append("<input type='hidden' name='rpidx' id='rpidx' value='"+rpidx+"' />");
	$("form[name=pagego]").attr("action","<c:url value='/cmsmain.do'/>");
	$("form[name=pagego]").submit();
}
</script>

	</div>
	<div class="shadow_h"></div>
</header>