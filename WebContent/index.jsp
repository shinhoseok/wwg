<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URL " %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.*" %>

<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="egovframework.rte.fdl.property.impl.EgovPropertyServiceImpl"%>

<%@ page import="com.ji.cm.*" %>
<%
//server 명
String svr_name				= request.getServerName();
//server port
int svr_port				= request.getServerPort();
String jsessionid = request.getSession().getId();
response.setHeader("SET-COOKIE","JSESSIONID="+jsessionid+";HttpOnly");
response.setHeader("cache-control", "no-cache, no-store, must-revalidate");
response.setHeader("expires", "0");
response.setHeader("pragma", "no-cache");
response.setHeader("x-frame-options", "SAMEORIGIN");		//교차 프레임 스크립팅 방어
response.setHeader("x-content-type-options", "nosniff");	//Missing "X-Content-Type-Options" header
response.setHeader("x-xss-protection", "1; mode=block");	//Missing "X-XSS-Protection" header
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
String _context_root = request.getSession().getServletContext().getContextPath(); //context root 
_context_root = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("CON_ROOT"); //propertie에 설정된 context root
String RequestURL			= _context_root +"/cmsmain.do";



//SSL 적용
String url = request.getRequestURL().toString();
//int port = request.getRemotePort();

String originalURL =CM_Util.OriginGetURL(request);
//out.print("OriginalURL ==>" + originalURL  );
//System.out.println("CmCommon originalURL111:==>"+originalURL+"::"+ServletPath+"::"+page_self);
//if(url.startsWith("http://") && url.indexOf("localhost") < 0) {

if(url.startsWith("http://")) {
	originalURL = "https://"+svr_name+""+originalURL;
	//originalURL = "https://"+svr_name+":443"+originalURL;
	//System.out.println("CmCommon originalURL222:==>"+originalURL+"::"+ServletPath+"::"+page_self);
	//return;
	if(svr_name!=null){
		// 내부망접속이 아닐경우만
		if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost")){
			//response.sendRedirect(originalURL);
		}
		
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>::index</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="googlebot" content="noindex" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type='text/javascript'>
//<![CDATA[	
	

	location.href="<%=RequestURL%>?scode=S01";



//]]>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
</body>
</html>	
