<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : CmSuccess     
/* 소스파일 이름     : CmSuccess.jsp
/* 설명              : SYSTEM 공통 결과 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-15
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
<title>::<%=_system_name %> ::: 환경설정결과::</title>
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
try{
//if(true){
//	return;
//}
// 에러가 발생한경우
if(!rtn_Msg.equals("") && rtn_Sta.equals(FORWARD_FAILURE)){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");

		out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
		//return;
			
}

// 결과가 성공인경우
if(pstate.equals("C") || pstate.equals("U") || pstate.equals("D") || pstate.equals("M")){
	if(!rtn_Msg.equals("") && rtn_Sta.equals(FORWARD_SUCCESS)){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");
		if(rtn_Url_R.equals("") || rtn_Url_R.equals("N")){
			if(rtn_Url.equals("")){
				out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
				//return;
			}else{
				if(rtn_Url_T.equals("")){
					out.print(HtmlTag.getPopup_msg_gourl(rtn_Url, rtn_Msg));
					//return;
				}else{
					out.print(HtmlTag.getPopup_msg_gourl(rtn_Url_T, rtn_Url, rtn_Msg));
					//return;
				}
			}
		}else if(rtn_Url_R.equals("Y")){
			if(rtn_Url_F.equals("")){
				out.print(""+HtmlTag.getPopup_msg_reloadT(rtn_Url_T, rtn_Msg)+"");
			}else{
%>
			<form name="successfrm" method="post">
			<%=rtn_Url_F %>
			</form>
			<script type="text/javascript">
			//<![CDATA[
			    alert('<%=rtn_Msg%>');
			    su_form = document.successfrm;
			    <%=rtn_Url_T%>.window.name = "rtntarget"
			    //targetname = <%=rtn_Url_T%>.contentFrame.name;
			    su_form.target = "rtntarget";
				su_form.action='<%=RequestURL%>';
				su_form.submit();
			//]]>
			</script>
<%							
			}
			
			//return;			
		}
	}
}else{
%>
<script type='text/javascript'>
//<![CDATA[
    alert("정상적인 접근이 아닙니다.");     
//]]>
</script>
<%
}

} catch(NullPointerException e){
	System.out.println("######  cmsadmin cmsuccess NullPointerException ######");
	
} catch(ArrayIndexOutOfBoundsException e){
	System.out.println("######  cmsadmin cmsuccess ArrayIndexOutOfBoundsException ######");
	
}catch (Exception e) {
	System.out.println("######  cmsadmin cmsuccess Exception ######");

}finally{
	System.out.println("######  cmsadmin cmsuccess End ######");
	//return;
}
%>

	</body>
</html>
