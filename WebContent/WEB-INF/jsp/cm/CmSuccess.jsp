<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : CmSuccess 
/* 프로그램 이름     : CmSuccess    
/* 소스파일 이름     : CmSuccess.jsp
/* 설명              : SYSTEM 결과 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2011-05-16
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2011-05-16
/* 최종 수정내용     : 최초작성
/* 최근 수정자		 : 
/* 최근 수정일시     : 
/* 최근 수정내용     : 

/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<!DOCTYPE html>
<html>
<head>
<title>::<%=_system_name %> ::: 결과::</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="googlebot" content="noindex" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<link href="<%=con_root%>/style/cmsadmin/login.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=con_root%>/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/default.js"></script>
<script type="text/javascript" src="<%=con_root%>/js/CmCommon.js"></script>
</head>
	<body>
	
<%
	if(!scode.equals(SYS_ADMIN_CD)){
		if(dev_mode.equals("D")){
		rtn_Url = "http://localhost:8080/KomipoWwg/cmsmain.do";
		}else{
		rtn_Url = "http://www.komipo.co.kr/KomipoWwg/cmsmain.do";
		}
	}


if(!file_Msg.equals("")){
	file_Msg = HtmlText.replace(file_Msg,"\"","&quot;");
	file_Msg = HtmlText.replace(file_Msg,"'","\\'");
	out.print(HtmlTag.getPopup_msg_only(file_Msg));
}

	
if(scode.equals("000008")){
	if(!rtn_Msg.equals("") ){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");
		out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
%>
	</body>
</html>
<%
		return;		
	}
}else{
// 에러가 발생한경우
if(!rtn_Msg.equals("") ){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");
		if(rtn_Url.equals("")){
			out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
			//out.print("<textarea style='width:100%;height:80%;'>"+HtmlTag.getPopup_msg_only(rtn_Msg)+":::::::1"+"</textarea>");
%>
	</body>
</html>
<%		
			return;
		}else{
			if(rtn_Url_T.equals("")){
				out.print(HtmlTag.getPopup_msg_gourl(rtn_Url.replaceAll("&amp;","&"), rtn_Msg));
				//out.print("<textarea style='width:100%;height:80%;'>"+HtmlTag.getPopup_msg_gourl(rtn_Url, rtn_Msg)+":::::::2"+"</textarea>");
%>
	</body>
</html>
<%				
				return;
			}else{
				out.print(HtmlTag.getPopup_msg_gourl(rtn_Url_T, rtn_Url.replaceAll("&amp;","&"), rtn_Msg));
				//out.print("<textarea style='width:100%;height:80%;'>"+HtmlTag.getPopup_msg_gourl(rtn_Url_T, rtn_Url, rtn_Msg)+":::::::3"+"</textarea>");
%>
	</body>
</html>
<%				
				return;
			}
		}
}

if(!rtn_Url.equals("")){

	if(rtn_Url_T.equals("")){
		out.print(HtmlTag.getPopup_msg_gourl(rtn_Url.replaceAll("&amp;","&"), rtn_Msg));
%>
	</body>
</html>
<%		
		return;
	}else{
		out.print(HtmlTag.getPopup_msg_gourl(rtn_Url_T, rtn_Url.replaceAll("&amp;","&"), rtn_Msg));
%>
	</body>
</html>
<%		
		return;
	}
}
}


%>

