<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : Cmnavi    
/* 소스파일 이름     : Cmnavi.jsp
/* 설명              : SYSTEM INDEX페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-01-27
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-01-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>

<%
// 메인화면의경우
if(pcode.equals("main") || pcode.equals("login") || pcode.equals("logoff") ){
%>
                <!--sec_top-->
                <div class="sec_top">
                    <div class="title" id="title">
                        <h2>메인</h2>
                    </div>
                    <div class="path" id="path">
                        <span>관리자홈 &gt; <strong>메인</strong></span>
                    </div>
                </div>
                <!--//sec_top-->
	  
<% 	
}else{
%>
                <!--sec_top-->
                <div class="sec_top">
                    <div class="title" id="title">
                        <h2><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replaceAll("&amp;","&")%></h2>
                    </div>
                    <div class="path" id="path">
                        <span><%=M_PATH_STR.substring(0,M_PATH_STR.lastIndexOf("::")).replaceAll("::ROOT","관리자홈").replaceAll("::"," > ").replaceAll("&amp;","&")%>
                        	<strong>> <%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replaceAll("&amp;","&")%></strong>
                        </span>
                    </div>
                </div>
                <!--//sec_top-->

<% 	
}
%>




