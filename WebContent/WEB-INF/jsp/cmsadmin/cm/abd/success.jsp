<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : success    
/* 소스파일 이름     : success.jsp
/* 설명              : SYSTEM 게시판관리 결과 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-21
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-21
/* 최종 수정내용     : 최초작성
/* 최근 수정자		 : 
/* 최근 수정일시     : 
/* 최근 수정내용     : 

/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%><%try{%>
	<body>
	<!--  rtn_Msg:<%=rtn_Msg%><br />
	rtn_Sta:<%=rtn_Sta%><br />
	rtn_Url:<%=rtn_Url%><br />
	rtn_Url_T:<%=rtn_Url_T%><br />
	rtn_Url_R:<%=rtn_Url_R%><br />
	rtn_Url_F:<%=rtn_Url_F%><br />
	pstate:<%=pstate%>
	FORWARD_SUCCESS:<%=FORWARD_SUCCESS%>
	FORWARD_FAILURE:<%=FORWARD_FAILURE%>
	<br />-->
<%
String getAM_IC = "";//아이디 중복체크값
//에러가 발생한경우
if(!rtn_Msg.equals("") && rtn_Sta.equals(FORWARD_FAILURE)){
		rtn_Msg = HtmlText.replace(rtn_Msg,"\"","&quot;");
		rtn_Msg = HtmlText.replace(rtn_Msg,"'","\\'");

		out.print(HtmlTag.getPopup_msg_only(rtn_Msg));
		return;
			
}

// 결과가 성공인경우
if(pstate.equals("C") || pstate.equals("U") || pstate.equals("D") || pstate.equals("RE") 
		||  pstate.equals("RR") ||  pstate.equals("RRU") || pstate.equals("RRD") || pstate.equals("RRC")){
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
			<input type="hidden" name="pstate" value="L" title="페이지상태" />
			</form>
			<script type="text/javascript">
			//<![CDATA[
			    alert('<%=rtn_Msg%>');
			    su_form = document.successfrm;
			    <%=rtn_Url_T%>.window.name = "rtntarget"
			    //targetname = <%=rtn_Url_T%>.contentFrame.name;
			    su_form.target = "rtntarget";
			    <%
			    // 댓글등록일경우는 이동할 페이지가 상세보기화면임
			    if(pstate.equals("RR") || pstate.equals("RRU") || pstate.equals("RRD") || pstate.equals("RRC") ){
			    %>
			    su_form.pstate.value = "R";
			    <%
			    }
			    %>
				su_form.action='<%=RequestURL%>';
				su_form.submit();
			//]]>
			</script>
<%							
			}
			
			return;			
		}
	}
	
// 아이디체크인경우	
}else if(pstate.equals("IC")){
	getAM_IC = HtmlTag.returnString((String) rtn_Map.get("getAM_IC"),"0");
%>
<script type='text/javascript'>
//<![CDATA[
   parent.writefrm.in_id.value="<%=getAM_IC%>";	
<%           
	
	// 아이디가 중복이 아닌경우
	if(getAM_IC.equals("0")){
%>
	if(parent.writefrm.AM_ID.value.length > 4){
		parent.document.getElementById("idcheck").src="<%=img_adm_url%>/Success.gif";
		
	}else{
		parent.document.getElementById("idcheck").src="<%=img_adm_url%>/Error.gif";
	}
<%
	// 아이디가 중복인 경우
	}else{
%>
		
		parent.document.images['check'].src="<%=img_adm_url%>/Error.gif";
<%
	}
%>	
//]]>
</script>
<%
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
</html><%} catch(NullPointerException e){	System.out.println("######  cmsadmin abd success NullPointerException ######");	//return;} catch(ArrayIndexOutOfBoundsException e){	System.out.println("######  cmsadmin abd success ArrayIndexOutOfBoundsException ######");	//return;} catch (Exception e) {	System.out.println("######  cmsadmin abd success Exception ######");	//return;}finally{	System.out.println("######  cmsadmin abd success End ######");	//return;}%>
