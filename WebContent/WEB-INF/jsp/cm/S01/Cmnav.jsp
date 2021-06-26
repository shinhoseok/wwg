<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<ul class="lnb">
	<c:set var="naviMenuCdList" value="${fn:split(MENUCFG.mCodes, '::') }"/>
	<c:set var="naviMenuNmList" value="${fn:split(MENUCFG.mNms, '::') }"/>
	<li class="home"><a href="${basePath}/cmsmain.do">HOME</a></li>
	<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${naviMenuCdList[2] }"/>"><c:out value="${naviMenuNmList[2] }"/></a>
		<div class="lnb_more">
			<ul>
				<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
					<li <c:if test="${oneMenuList.menuNm eq naviMenuNmList[2]}">class="now"</c:if>>
						<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${oneMenuList.menuCd }"/>"><c:out value="${oneMenuList.menuNm }"/></a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</li>
	<c:if test="${not empty naviMenuCdList[3] }">
		<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${naviMenuCdList[3] }"/>"><c:out value="${naviMenuNmList[3] }"/></a>
			<div class="lnb_more">
				<ul>
					<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
						<c:if test="${oneMenuList.menuNm eq naviMenuNmList[2]}">
							<c:forEach items="${oneMenuList.menuList}" var="twoMenuList" varStatus="j" >
								<li <c:if test="${twoMenuList.menuNm eq naviMenuNmList[3]}">class="now"</c:if>>
									<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${twoMenuList.menuCd }"/>"><c:out value="${twoMenuList.menuNm }"/></a>
								</li>
							</c:forEach>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</li>
	</c:if>
	<c:if test="${not empty naviMenuCdList[4] }">
		<li><a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${naviMenuCdList[4] }"/>"><c:out value="${naviMenuNmList[4] }"/></a>
			<div class="lnb_more">
				<ul>
					<c:forEach items="${siteMap}" var="oneMenuList" varStatus="i" >
						<c:if test="${oneMenuList.menuNm eq naviMenuNmList[2]}">
							<c:forEach items="${oneMenuList.menuList}" var="twoMenuList" varStatus="j" >
								<c:if test="${twoMenuList.menuNm eq naviMenuNmList[3]}">
									<c:forEach items="${twoMenuList.menuList}" var="threeMenuList" varStatus="z" >
										<c:choose>
											<c:when test="${threeMenuList.menuCd eq '000595'}">
												<c:if test="${sessionScope.SITE_SESS.USER_TYPE eq '000518'}"> <!-- 제안서평가는 교수들만... -->
													<li <c:if test="${threeMenuList.menuNm eq naviMenuNmList[4]}">class="now"</c:if>>
														<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${threeMenuList.menuCd }"/>"><c:out value="${threeMenuList.menuNm }"/></a>
													</li>
												</c:if>
											</c:when>
											<c:otherwise>
												<li <c:if test="${threeMenuList.menuNm eq naviMenuNmList[4]}">class="now"</c:if>>
													<a href="<c:out value="${basePath}"/>/cmsmain.do?scode=<c:out value="${scode }"/>&pcode=<c:out value="${threeMenuList.menuCd }"/>"><c:out value="${threeMenuList.menuNm }"/></a>
												</li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</li>
	</c:if>
</ul>
<script>
$(function() {
	$('.lnb>li').on({
		mouseenter: function(){
			$(this).addClass('on');
			$(this).children('.lnb_more').stop().slideDown();
		},
		focusin: function(){
			$(this).addClass('on');
			$(this).children('.lnb_more').stop().slideDown();
		},
		mouseleave: function(){
			$('.lnb>li').removeClass('on');
			$('.lnb_more').stop().slideUp();
		},
		focusout: function(){
			$('.lnb>li').removeClass('on');
			$('.lnb_more').stop().slideUp();
		}
	});  
});
</script>