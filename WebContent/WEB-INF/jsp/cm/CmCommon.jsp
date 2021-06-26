<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmCommon    
/* 프로그램 이름     : CmCommon    
/* 소스파일 이름     : CmCommon.jsp
/* 설명              : SYSTEM 공통 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-08
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-08
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page import="com.ji.util.JSONManager"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="edPotal"   uri="/WEB-INF/tld/edPotal.tld"%>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@ page import="java.net.* " %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="egovframework.rte.fdl.property.impl.EgovPropertyServiceImpl"%>
<%@ page import="com.ji.cm.*" %>
<%@ page import="com.ji.common.*" %>
<%@ page import="com.ji.common.db.*" %>
<%@ page buffer = "600kb" %>

<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="rootPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<c:set var="basePath" value="${rootPath}${path}"/>


<%
// context root 경로
String con_root 			= (String)request.getAttribute("CON_ROOT");
String con_root_svl			= (String)request.getAttribute("CON_ROOT_SVL");
String img_url				= (String)request.getAttribute("IMG_URL");
String img_adm_url			= (String)request.getAttribute("IMG_ADM_URL");
String sys_encoding			= (String)request.getAttribute("SYS_ENCODING");

// 팝업창 세션 유지를 위해
response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
//페이지 설정
/* response.setHeader("cache-control","no-cache, must-revalidate");
response.setHeader("expires","0");
response.setHeader("pragma","no-cache"); */
if(sys_encoding!=null){
	request.setCharacterEncoding(sys_encoding);
}


//server 명
String svr_name				= request.getServerName();
//server port
int svr_port				= request.getServerPort();
//현재 페이지
String page_self			= request.getRequestURI();
//이전 페이지
String referer				= request.getHeader("referer");
if(referer!=null){
	if(!referer.equals("")){
		referer = referer.replaceAll("^([A-Za-z://]*[^/?]*)","");
	}
}

//요청 type
String contentType			= request.getContentType();
//요청 ip
//String RemoteAddr			= request.getRemoteAddr();
String RemoteAddr			= request.getRemoteHost();

//서블릿패스
String ServletPath			= request.getServletPath();

//현재페이지 요청 url
//String RequestURL			= request.getRequestURL().toString();
String RequestURL			= con_root+"/cmsmain.do";

//개발환경여부 D:개발 R:실운영
String dev_mode = (String)request.getAttribute("DEV_MODE"); 

//리턴된 메시지를 받을 변수
String trs_msg = "";
String file_msg = "";

//달력팝업크기
String cal_pop_w = (String)request.getAttribute("CAL_POP_W");
String cal_pop_h = (String)request.getAttribute("CAL_POP_H");

//현재일자(20061026)
DateUtility dateUtility = new DateUtility();
String curDate = dateUtility.getToday();
String curweek = dateUtility.getDayWeekHan(curDate.substring(0,4),curDate.substring(4,6),curDate.substring(6,8));


String SYS_ADMIN_CD = (String)request.getAttribute("SYS_ADMIN_CD");
String SYS_COMMON_CD = (String)request.getAttribute("SYS_COMMON_CD");
String SYS_SITE_CD = (String)request.getAttribute("SYS_SITE_CD");

String RESULT_DTO_KEY= (String)request.getAttribute("RESULT_DTO_KEY"); 
String RESULT_MSG_KEY= (String)request.getAttribute("RESULT_MSG_KEY");
String RESULT_URL_KEY= (String)request.getAttribute("RESULT_URL_KEY"); 
String RESULT_URL_T_KEY= (String)request.getAttribute("RESULT_URL_T_KEY");
String RESULT_URL_R_KEY= (String)request.getAttribute("RESULT_URL_R_KEY");
String RESULT_URL_F_KEY= (String)request.getAttribute("RESULT_URL_F_KEY"); 
String RESULT_STA_KEY= (String)request.getAttribute("RESULT_STA_KEY");
String SSO_COOKIE_NM= (String)request.getAttribute("SSO_COOKIE_NM");
String SITE_ADM_SESSION_FN= (String)request.getAttribute("SITE_ADM_SESSION_FN");
String SITE_SESSION_FN= (String)request.getAttribute("SITE_SESSION_FN");

String FORWARD_SUCCESS = (String)request.getAttribute("FORWARD_SUCCESS");
String FORWARD_FAILURE = (String)request.getAttribute("FORWARD_FAILURE");
String FORWARD_CONFIRM = (String)request.getAttribute("FORWARD_CONFIRM");
String FORWARD_SYS_FAILURE =(String)request.getAttribute("FORWARD_SYS_FAILURE");

String MSIS_ITEM_IMG_PATH =(String)request.getAttribute("MSIS_ITEM_IMG_PATH");
String MSIS_REPR_IMG_PATH =(String)request.getAttribute("MSIS_REPR_IMG_PATH");


//업로드임시파일경로 설정
String CONTEXTROOT_REALPATH = (String)request.getAttribute("CONTEXTROOT_REALPATH");
String docsave_root = (String)request.getAttribute("DOCSAVE_ROOT");	

String uploadtmppath = docsave_root+"/tmpup";

int maxupload = request.getAttribute("MAXUPLOAD")==null?0:Integer.parseInt((String)request.getAttribute("MAXUPLOAD"));

int uploadcnt = request.getAttribute("UPLOADCNT")==null?0:Integer.parseInt((String)request.getAttribute("UPLOADCNT"));

String scode = HtmlTag.returnString((String)request.getAttribute("scode"),"");
String pcode = HtmlTag.returnString((String)request.getAttribute("pcode"),"");
String pstate = HtmlTag.returnString((String)request.getAttribute("pstate"),"L");


Map rtn_tmp_Map = new HashMap();
List tmp_list= new ArrayList();
Map rtn_row_Map = new HashMap();
String rtn_String = "";
String site_title = "";


// 사용자의 로그인정보를 가져온다
Map SITE_SESSION = new HashMap();
Map SITE_ADM_SESSION = new HashMap();
boolean isAdmin = false;
int ma = 0;

Map MENUCFG = (Map)request.getAttribute("MENUCFG");
String M_PATH_STR = "";
String CUR_M_PATH_CODE ="";
if(MENUCFG!=null){
	M_PATH_STR = (String)MENUCFG.get("mNms");
	CUR_M_PATH_CODE = (String)MENUCFG.get("mCodes");
	
}

if(session.getAttribute(SITE_ADM_SESSION_FN) != null){
	isAdmin = true;
	SITE_ADM_SESSION = (Map)session.getAttribute(SITE_ADM_SESSION_FN);
}


if(session.getAttribute(SITE_SESSION_FN) != null){
	isAdmin = true;
	SITE_SESSION = (Map)session.getAttribute(SITE_SESSION_FN);

}


/*세션 정보 셋팅*/
String SS_authC			= HtmlTag.returnString((String)request.getAttribute("authC"),"N");
String SS_authR			= HtmlTag.returnString((String)request.getAttribute("authR"),"N");
String SS_authU			= HtmlTag.returnString((String)request.getAttribute("authU"),"N");
String SS_authO			= HtmlTag.returnString((String)request.getAttribute("authO"),"N");
String SS_authD			= HtmlTag.returnString((String)request.getAttribute("authD"),"N");
String SS_authA			= HtmlTag.returnString((String)request.getAttribute("authA"),"N");
List AdmSubAuth 		= (List)request.getAttribute("AdmSubAuth");

//관리자
String SS_admin			= HtmlTag.returnString((String)SITE_ADM_SESSION.get("ADMAUTH"),"N");
String SS_admin_lv		= HtmlTag.returnString((String)SITE_ADM_SESSION.get("ADMIN_LEVEL"),"");

String SS_empId		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),"N");
String SS_empNm		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"N");
String SS_orgNm		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_NM"),"N");
String SS_orgCd		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ORG_CD"),"N");
String SS_uppoOrgNm	    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("UPPO_ORG_NM"),"N");
String SS_rootOrgNm	    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ROOT_ORG_NM"),"N");
String SS_rootOrgCd	    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("ROOT_ORG_CD"),"N");


//사용자
String userId		    = HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"N");
String userNm		    = HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"N");


Map rtn_Map = new HashMap();
String rtn_Msg = "";
String file_Msg = "";
String rtn_Sta = "";
String rtn_Url = "";
String rtn_Url_T = "";
String rtn_Url_R = "";
String rtn_Url_F = "";



if(RESULT_DTO_KEY!=null){
	//request에 담겨진 결과값을 받는다
	rtn_Map = (Map) request.getAttribute(RESULT_DTO_KEY);
	
	rtn_Msg = HtmlTag.returnString((String) request.getAttribute(RESULT_MSG_KEY),"");
	rtn_Url = HtmlTag.returnString((String) request.getAttribute(RESULT_URL_KEY),"");
	rtn_Url_T = HtmlTag.returnString((String) request.getAttribute(RESULT_URL_T_KEY),"");
	rtn_Url_R = HtmlTag.returnString((String) request.getAttribute(RESULT_URL_R_KEY),"");
	rtn_Url_F = HtmlTag.returnString((String) request.getAttribute(RESULT_URL_F_KEY),"");
	rtn_Sta = HtmlTag.returnString((String) request.getAttribute(RESULT_STA_KEY),"");
}


Map viewMap = new HashMap();

if(rtn_Map != null){
	if(rtn_Msg.equalsIgnoreCase("")){
		rtn_Msg = HtmlTag.returnString((String) rtn_Map.get("TRS_MSG"),"");
	}
	if(file_Msg.equalsIgnoreCase("")){
		file_Msg = HtmlTag.returnString((String) rtn_Map.get("FILE_MSG"),"");
	}
	if(rtn_Sta.equalsIgnoreCase("")){
		rtn_Sta = HtmlTag.returnString((String) rtn_Map.get(RESULT_STA_KEY),"");
	}
	if(rtn_Url.equalsIgnoreCase("")){
		rtn_Url = HtmlTag.returnString((String) rtn_Map.get(RESULT_URL_KEY),"");
	}
	if(rtn_Url_T.equalsIgnoreCase("")){
		rtn_Url_T = HtmlTag.returnString((String) rtn_Map.get(RESULT_URL_T_KEY),"");
	}
	if(rtn_Url_R.equalsIgnoreCase("")){
		rtn_Url_R = HtmlTag.returnString((String) rtn_Map.get(RESULT_URL_R_KEY),"");
	}	
	
	if(rtn_Url_F.equalsIgnoreCase("")){
		rtn_Url_F = HtmlTag.returnString((String) rtn_Map.get(RESULT_URL_F_KEY),"");
	}	

	if(rtn_Map.containsKey("ViewMap")){
		viewMap = (Map)rtn_Map.get("ViewMap");
	}

}

WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
String _context_root = request.getSession().getServletContext().getContextPath(); //context root 
String _system_name = "";
_context_root = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("CON_ROOT"); 
_system_name = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("SYSTEM_NAME"); 

String _vworld_api_key = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("VWORLD_API_KEY"); 
String _vworld_domain_uri = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("VWORLD_DOMAIN_URI");

pageContext.setAttribute("cr", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("sp2x", "  ");
pageContext.setAttribute("br", "<br />");
pageContext.setAttribute("nbsp", "&nbsp;");
pageContext.setAttribute("lt1", "<");
pageContext.setAttribute("gt1", ">");
pageContext.setAttribute("lt2", "&lt;");
pageContext.setAttribute("gt2", "&gt;");

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
			
			// script type="text/javascript" top.location.href=originalURL /script
%>

<%
		}
		
	}
	
}else if(url.startsWith("https://")){
	originalURL = "http://"+svr_name+""+originalURL;
	if(scode.equals("S01") && pcode.equals("000397")){
		
		// script type="text/javascript" top.location.href=originalURL /script
%>
		
<%
	}
}

%>

<%if(scode.equals(SYS_ADMIN_CD)){ %>
<c:set var="nUser" value="<%=SS_empId%>"/>
<%}else if(scode.equals(SYS_SITE_CD)){ %>
<c:set var="nUser" value="<%=userId%>"/>
<%} %>
<%-- cmHeader로 이동 
<script type="text/javascript">
var context_root = '<%= _context_root %>';
</script> 
--%>
