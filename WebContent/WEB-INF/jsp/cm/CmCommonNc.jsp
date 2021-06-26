<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : CmCommon    
/* 프로그램 이름     : CmCommon    
/* 소스파일 이름     : CmCommon.jsp
/* 설명              : SYSTEM 공통 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-01-24
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-01-24
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<% 


// context root 경로
String con_root 			= (String)request.getAttribute("CON_ROOT");//  /jrcms
String con_root_svl			= (String)request.getAttribute("CON_ROOT_SVL");//  /jrcms
String img_url				= (String)request.getAttribute("IMG_URL");// /images
String img_adm_url			= (String)request.getAttribute("IMG_ADM_URL");
String sys_encoding			= (String)request.getAttribute("SYS_ENCODING");// utf-8


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
String dev_mode = (String)request.getAttribute("DEV_MODE");// 

//리턴된 메시지를 받을 변수
String trs_msg = "";

//달력팝업크기
String cal_pop_w = (String)request.getAttribute("CAL_POP_W");// 200
String cal_pop_h = (String)request.getAttribute("CAL_POP_H");// 185

//현재일자(20061026)
DateUtility dateUtility = new DateUtility();
String curDate = dateUtility.getToday();
String curweek = dateUtility.getDayWeekHan(curDate.substring(0,4),curDate.substring(4,6),curDate.substring(6,8));


String RESULT_DTO_KEY= (String)request.getAttribute("RESULT_DTO_KEY");// 
String RESULT_MSG_KEY= (String)request.getAttribute("RESULT_MSG_KEY");//
String RESULT_URL_KEY= (String)request.getAttribute("RESULT_URL_KEY");// 
String RESULT_URL_T_KEY= (String)request.getAttribute("RESULT_URL_T_KEY");//
String RESULT_URL_R_KEY= (String)request.getAttribute("RESULT_URL_R_KEY");//
String RESULT_URL_F_KEY= (String)request.getAttribute("RESULT_URL_F_KEY");// 
String RESULT_STA_KEY= (String)request.getAttribute("RESULT_STA_KEY");//
String SSO_COOKIE_NM= (String)request.getAttribute("SSO_COOKIE_NM");//
String SITE_ADM_SESSION_FN= (String)request.getAttribute("SITE_ADM_SESSION_FN");//
String SITE_SESSION_FN= (String)request.getAttribute("SITE_SESSION_FN");//

String FORWARD_SUCCESS = (String)request.getAttribute("FORWARD_SUCCESS");//  propertiesService.getString("FORWARD_SUCCESS");
String FORWARD_FAILURE = (String)request.getAttribute("FORWARD_FAILURE");// propertiesService.getString("FORWARD_FAILURE");
String FORWARD_CONFIRM = (String)request.getAttribute("FORWARD_CONFIRM");// propertiesService.getString("FORWARD_CONFIRM");
String FORWARD_SYS_FAILURE =(String)request.getAttribute("FORWARD_SYS_FAILURE");//  propertiesService.getString("FORWARD_SYS_FAILURE");


String scode = HtmlTag.returnString((String)request.getAttribute("scode"),"");
String pcode = HtmlTag.returnString((String)request.getAttribute("pcode"),"");
String cur_menu = HtmlTag.returnString((String)request.getAttribute("cur_menu"),"");
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


if(session.getAttribute(SITE_ADM_SESSION_FN) != null){
	isAdmin = true;
	SITE_ADM_SESSION = (Map)session.getAttribute(SITE_ADM_SESSION_FN);
}


if(session.getAttribute(SITE_ADM_SESSION_FN) != null){
	isAdmin = true;
	SITE_SESSION = (Map)session.getAttribute(SITE_ADM_SESSION_FN);

}



/*세션 정보 셋팅*/
String SS_empId		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("EMP_ID"),"N");// 직원ID
String SS_empNm		    = HtmlTag.returnString((String)SITE_ADM_SESSION.get("EMP_NM"),"N");// 직원명


Map rtn_Map = new HashMap();
String rtn_Msg = "";
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
_context_root = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("CON_ROOT"); //propertie에 설정된 context root
_system_name = ((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("SYSTEM_NAME"); //propertie에 설정된 context root
%>


