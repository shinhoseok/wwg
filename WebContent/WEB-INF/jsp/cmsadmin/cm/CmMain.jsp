<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
/* 설명              : SYSTEM 시스템 관리자 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-01-27
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-01-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
int i=0;
%>
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>
	<body >

	<div id="wrap_ex"> <!--wrap_ex footer배경용--> 
		<!--wrap-->
		<div id="wrap"> 
		<!-- 공통 top jsp 파일-->
		<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmtop.jsp"%>
		<!-- 공통 top jsp 파일-->	
			<!-- header 끝 -->
			<div id="container">
			
			<!-- 레프트메뉴 시작 -->
			<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmmenu.jsp"%>
			<!-- 레프트메뉴 끝 -->
            <!--//Main Navigation Bar-->
		
				<!--content-->
				<div id="content">	
				
				<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmnavi.jsp"%>	

				<!--메인-->	
				<div class="admin_main">
					<img src="<%=con_root %>/images/cmsadmin/admin_main.jpg">
				</div>
				<!--//메인-->
				
				</div>
				<!--//content-->
			</div>
			<!--//container-->
		</div>
		<!--//wrap-->
	</div><!--//wrap_ex footer배경용--> 


	<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmfooter.jsp"%>

	</body>
</html>