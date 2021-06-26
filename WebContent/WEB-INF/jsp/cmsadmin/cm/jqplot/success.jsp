<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : success    
/* 소스파일 이름     : success.jsp
/* 설명              : SYSTEM 코드관리 결과 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-05
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-05
/* 최종 수정내용     : 최초작성
/* 최근 수정자		 : 
/* 최근 수정일시     : 
/* 최근 수정내용     : 

/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>
	<body>
<%
//if(true){
//	return;
//}
// 에러가 발생한경우
if(!rtn_Msg.equals("") && rtn_Sta.equals(FORWARD_FAILURE)){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");

		out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
		return;
			
}

// 결과가 성공인경우
if(pstate.equals("C") || pstate.equals("U") || pstate.equals("D")){
	if(!rtn_Msg.equals("") && rtn_Sta.equals(FORWARD_SUCCESS)){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");
		if(rtn_Url_R.equals("") || rtn_Url_R.equals("N")){
			if(rtn_Url.equals("")){
				out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
				return;
			}else{
				if(rtn_Url_T.equals("")){
					out.print(HtmlTag.getPopup_msg_gourl(rtn_Url, rtn_Msg));
					return;
				}else{
					out.print(HtmlTag.getPopup_msg_gourl(rtn_Url_T, rtn_Url, rtn_Msg));
					return;
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
			
			return;			
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
%>

	</body>
</html>
