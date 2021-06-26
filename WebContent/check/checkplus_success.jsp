<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="egovframework.rte.fdl.property.impl.EgovPropertyServiceImpl"%>
<%	//인증 후 결과값이 null로 나오는 부분은 관리담당자에게 문의 바랍니다.
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
	
    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
    String callPcode = requestReplace(request.getParameter("callPcode"),"");
    String callPstate = requestReplace(request.getParameter("callPstate"),"");
    String paramR1 = requestReplace(request.getParameter("param_r1"),"");
    String authFlag = "";

    if(callPstate.equals("L33")){
    	authFlag = "Y";
    }
    if(callPcode.equals("000138") && callPstate.equals("L32")){	//법정대리인 동의
    	callPstate = "L3-3";
    }else if(callPcode.equals("000138")){				//회원가입
    	callPstate = "L4";
    }else if(callPcode.equals("000254")){		//아이디찾기
    	callPstate = "FH";
    }else if(callPcode.equals("000255")){		//비밀번호찾기
    	callPstate = "FI";
    }else if(callPcode.equals("000377")){ 	// RSS 본인인증
    	//callPstate = "";
    }
    
    String sSiteCode = "AD500";					// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "z6vDhVBB5AHH";		

    String sCipherTime = "";			// 복호화한 시간
    String sRequestNumber = "";			// 요청 번호
    String sResponseNumber = "";		// 인증 고유번호
    String sAuthType = "";				// 인증 수단
    String sName = "";					// 성명
    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
    String sBirthDate = "";				// 생년월일(YYYYMMDD)
    String sGender = "";				// 성별
    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
	String sMobileNo = "";				// 휴대폰번호
	String sMobileCo = "";				// 통신사
    String sMessage = "";
    String sPlainData = "";
    
    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if( iReturn == 0 )
    {
        sPlainData = niceCheck.getPlainData();
        sCipherTime = niceCheck.getCipherDateTime();
        
        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber  = (String)mapresult.get("REQ_SEQ");	// 요청번호
        sResponseNumber = (String)mapresult.get("RES_SEQ"); // 인증 고유번호:
        sAuthType		= (String)mapresult.get("AUTH_TYPE"); // 인증수단
        sName			= (String)mapresult.get("NAME"); // 성명
		//sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
        sBirthDate		= (String)mapresult.get("BIRTHDATE"); // 생년월일(YYYYMMDD)
        sGender			= (String)mapresult.get("GENDER"); // 성별 코드
        sNationalInfo  	= (String)mapresult.get("NATIONALINFO"); // 내/외국인 정보
        sDupInfo		= (String)mapresult.get("DI"); // 중복가입 확인값 (DI)
        sConnInfo		= (String)mapresult.get("CI"); // 연계정보 확인값 (CI)
        sMobileNo		= (String)mapresult.get("MOBILE_NO"); // 휴대폰번호
        sMobileCo		= (String)mapresult.get("MOBILE_CO"); // 통신사
        
        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
        if(!sRequestNumber.equals(session_sRequestNumber))
        {
            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
            sResponseNumber = "";
            sAuthType = "";
        }
    }
    else if( iReturn == -1)
    {
        sMessage = "복호화 시스템 에러입니다.";
    }    
    else if( iReturn == -4)
    {
        sMessage = "복호화 처리오류입니다.";
    }    
    else if( iReturn == -5)
    {
        sMessage = "복호화 해쉬 오류입니다.";
    }    
    else if( iReturn == -6)
    {
        sMessage = "복호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else if( iReturn == -12)
    {
        sMessage = "사이트 패스워드 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }

    String svr_name				= request.getServerName();
    
    if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost") && !svr_name.equals("127.0.0.1")){
		Map SITE_AUTH_SESSION = new HashMap();
		SITE_AUTH_SESSION.put("sName",sName);
		SITE_AUTH_SESSION.put("sDupInfo",sDupInfo);
		SITE_AUTH_SESSION.put("sBirthDate",sBirthDate);
		SITE_AUTH_SESSION.put("sMobileNo",sMobileNo);
		SITE_AUTH_SESSION.put("sAuthType","CHECKPLUS");	
		SITE_AUTH_SESSION.put("sVNumber",""); // 아이핀인증일경우 가상번호
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
		session.setAttribute(((EgovPropertyServiceImpl)wac.getBean("propertiesService")).getString("SITE_AUTH_SESSION_FN"), SITE_AUTH_SESSION);
    }    
%>
<%!

	public String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            	paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
%>

<script language='javascript'>
	

	
	function fnLoad(){
		// 당사에서는 최상위를 설정하기 위해 'parent.opener.parent.document.'로 정의하였습니다.
		// 따라서 귀사에 프로세스에 맞게 정의하시기 바랍니다.
		try{
			parent.opener.parent.document.my_form.sName.value = "<%= sName %>";
			parent.opener.parent.document.my_form.sDupInfo.value = "<%= sDupInfo %>";
			parent.opener.parent.document.my_form.sBirthDate.value = "<%= sBirthDate %>";
			parent.opener.parent.document.my_form.sMobileNo.value = "<%= sMobileNo %>";
			parent.opener.parent.document.my_form.pstate.value = "<%=callPstate %>";
			<%if(authFlag.equals("Y")){%>
				parent.opener.parent.document.my_form.authFlag.value = "Y";
			<%}%>
			parent.opener.parent.document.my_form.submit();
			self.close();			
		}catch(e){
			parent.opener.parent.document.forms[0].pstate.value = "<%=paramR1%>";
			parent.opener.parent.document.forms[0].submit();
			self.close();
		}

		
	}
	

	fnLoad();
	
	
	
</script>


<%-- 
<html>
<head>
    <title>NICE평가정보 - CheckPlus 안심본인인증 테스트</title>
</head>
<body>
    <center>
    <p><p><p><p>
    본인인증이 완료 되었습니다.<br>
    <table border=1>
        <tr>
            <td>복호화한 시간</td>
            <td><%= sCipherTime %> (YYMMDDHHMMSS)</td>
        </tr>
        <tr>
            <td>요청 번호</td>
            <td><%= sRequestNumber %></td>
        </tr>            
        <tr>
            <td>NICE응답 번호</td>
            <td><%= sResponseNumber %></td>
        </tr>            
        <tr>
            <td>인증수단</td>
            <td><%= sAuthType %></td>
        </tr>
		<tr>
            <td>성명</td>
            <td><%= sName %></td>
        </tr>
		<tr>
            <td>중복가입 확인값(DI)</td>
            <td><%= sDupInfo %></td>
        </tr>
		<tr>
            <td>연계정보 확인값(CI)</td>
            <td><%= sConnInfo %></td>
        </tr>
		<tr>
            <td>생년월일(YYYYMMDD)</td>
            <td><%= sBirthDate %></td>
        </tr>
		<tr>
            <td>성별</td>
            <td><%= sGender %></td>
        </tr>
				<tr>
            <td>내/외국인정보</td>
            <td><%= sNationalInfo %></td>
        </tr>
        </tr>
			<td>휴대폰번호</td>
            <td><%= sMobileNo %></td>
        </tr>
		<tr>
			<td>통신사</td>
			<td><%= sMobileCo %></td>
        </tr>
		<tr>
			<td colspan="2">인증 후 결과값은 내부 설정에 따른 값만 리턴받으실 수 있습니다. <br>
			일부 결과값이 null로 리턴되는 경우 관리담당자 또는 계약부서(02-2122-4615)로 문의바랍니다.</td>
		</tr>
		</table><br><br>        
    <%= sMessage %><br>
    </center>
</body>
</html> 
 --%>