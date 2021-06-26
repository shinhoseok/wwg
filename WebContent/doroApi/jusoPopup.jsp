<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@ page import="com.ji.common.HtmlTag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도로명주소검색</title>
<%
	request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	//request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
	String inputYn = HtmlTag.returnString((String)request.getParameter("inputYn"));
	String roadFullAddr = HtmlTag.returnString((String)request.getParameter("roadFullAddr"));
	String roadAddrPart1 = HtmlTag.returnString((String)request.getParameter("roadAddrPart1"));
	String roadAddrPart2 = HtmlTag.returnString((String)request.getParameter("roadAddrPart2"));
	String engAddr = HtmlTag.returnString((String)request.getParameter("engAddr"));
	String jibunAddr = HtmlTag.returnString((String)request.getParameter("jibunAddr")); 
	String zipNo = HtmlTag.returnString((String)request.getParameter("zipNo"));
	String addrDetail = HtmlTag.returnString((String)request.getParameter("addrDetail")); 
	String admCd    = HtmlTag.returnString((String)request.getParameter("admCd"));
	String rnMgtSn = HtmlTag.returnString((String)request.getParameter("rnMgtSn"));
	String bdMgtSn  = HtmlTag.returnString((String)request.getParameter("bdMgtSn"));
	String detBdNmList  = HtmlTag.returnString((String)request.getParameter("detBdNmList"));
	/** 2017년 2월 추가제공 **/
	String bdNm  = HtmlTag.returnString((String)request.getParameter("bdNm"));
	String bdKdcd  = HtmlTag.returnString((String)request.getParameter("bdKdcd"));
	String siNm  = HtmlTag.returnString((String)request.getParameter("siNm"));
	String sggNm  = HtmlTag.returnString((String)request.getParameter("sggNm"));
	String emdNm  = HtmlTag.returnString((String)request.getParameter("emdNm"));
	String liNm  = HtmlTag.returnString((String)request.getParameter("liNm"));
	String rn  = HtmlTag.returnString((String)request.getParameter("rn"));
	String udrtYn  = HtmlTag.returnString((String)request.getParameter("udrtYn"));
	String buldMnnm  = HtmlTag.returnString((String)request.getParameter("buldMnnm"));
	String buldSlno  = HtmlTag.returnString((String)request.getParameter("buldSlno"));
	String mtYn  = HtmlTag.returnString((String)request.getParameter("mtYn"));
	String lnbrMnnm  = HtmlTag.returnString((String)request.getParameter("lnbrMnnm"));
	String lnbrSlno  = HtmlTag.returnString((String)request.getParameter("lnbrSlno"));

%>
</head>
<script language="javascript">
function init(){
	var url = location.href;
	var confmKey = "U01TX0FVVEgyMDE3MDMwNzE2NTI0ODE5NTAx";
	var resultType = "4"; // 도로명주소 검색결과 화면 출력내용, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
	var inputYn= "<%=inputYn%>";
	<%
	String svr_name				= request.getServerName();
	// 내부망에서 테스트가 안되므로 이동
	if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost")){
	%>
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType;
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
		document.form.submit();
	}else{
		opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>", "<%=detBdNmList%>", "<%=bdNm%>", "<%=bdKdcd%>", "<%=siNm%>", "<%=sggNm%>", "<%=emdNm%>", "<%=liNm%>", "<%=rn%>", "<%=udrtYn%>", "<%=buldMnnm%>", "<%=buldSlno%>", "<%=mtYn%>", "<%=lnbrMnnm%>", "<%=lnbrSlno%>");
		window.close();
	}
	<%
	// 실운영
	}else{
	%>
	opener.jusoCallBack("<%=roadFullAddr%>","경기도 성남시 분당구 야탑로 20","탑마을 선경아파트 110동 202호","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","13522", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>", "<%=detBdNmList%>", "<%=bdNm%>", "<%=bdKdcd%>", "경기도", "성남시 분당구", "야탑동", "<%=liNm%>", "야탑로", "<%=udrtYn%>", "20", "<%=buldSlno%>", "<%=mtYn%>", "536번지", "<%=lnbrSlno%>");
	window.close();		
	<%
	}
	%>	

}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START-->
		<!-- 
		<input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
		 -->
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
	</form>
</body>
</html>