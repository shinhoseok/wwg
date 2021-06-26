<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : Cmmenu    
/* 소스파일 이름     : Cmmenu.jsp
/* 설명              : SYSTEM 시스템 관리자 메뉴페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 조정권
/* 최근 수정일시     : 2016-03-15
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>

<%@page pageEncoding="utf-8"%>
<div class="mnb" id="mnb">
	<div class="mnb_inner" id="tree_left_root" style="overflow-y:hidden;">
		<div class="mnb_1depth" id="mnb_1depth">
			<div class="mnb_title">
				<h2>
					<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=sysadm&pcode=main">ADMINISTRATOR MODE</a>
				</h2>
				<span> </span>
			</div>
		</div>
		<div class="new_mnb" id="jstree">
			<ul>
				<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
					<li id="<c:out value="${oneMenuList.menuCd }"/>"><c:out value="${oneMenuList.menuNm }"/>
						<ul>
							<c:forEach items="${oneMenuList.menuList}" var="twoMenuList" varStatus="j" >
								<li id="<c:out value="${twoMenuList.menuCd }"/>"><c:out value="${twoMenuList.menuNm }"/>
									<ul>
										<c:forEach items="${twoMenuList.menuList}" var="threeMenuList" varStatus="z" >
											<li id="<c:out value="${threeMenuList.menuCd }"/>"><c:out value="${threeMenuList.menuNm }"/></li>
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
</div>
<script>
$(document).ready(function() {
	var onMenuId = "<c:out value='${pcode}'/>";
	var linkTy = "<c:out value='${linkTy}'/>";
	
	//컨텐츠 일땐 컨텐츠 관리 메뉴로 셋팅
	if(linkTy === "000006") {
		onMenuId = "000556";
	}
	
	//게시판 일땐 게시판 관리 메뉴로 셋팅
	if(linkTy === "000008") {
		onMenuId = "000557";
	}
	
	var menuCd = "";
	$("#jstree").jstree({
// 		"core" : {"dblclick_toggle" :  false}	// 더블클릭 이벤트 제거
	}).on('ready.jstree', function (e, data) {
		data.instance.open_node([ onMenuId ]);	// 메뉴 수정 시 열려 있던 메뉴 노드 열기
		data.instance.select_node([ onMenuId ]); // 메뉴 수정 시 열려 있던 메뉴 노드 선택
	}).on("select_node.jstree", function (e, data) {
		var childrenLength = data.node.children.length;
		if(childrenLength === 0) {
			menuCd = data.node.id;
			if(onMenuId === menuCd) {
			} else {
				location.href="<c:out value='${basePath}'/>/cmsmain.do?scode=<c:out value='${scode }'/>&pcode="+menuCd;
			}
		} else {
			data.instance.open_node([ data.node.id ]);
		}
	}).init("loaded.jstree", function (e, data) {
		$("#jstree").show();
	});
});
</script>