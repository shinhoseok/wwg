<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmDownFile   
/* 프로그램 이름     : CmDownFile    
/* 소스파일 이름     : CmDownFile.jsp
/* 설명              : SYSTEM 시스템 관리자 공통 파일 다운로드 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-18
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-18
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%

String rtIDX 		= "";
String rtM_CODE		= "";
String rtRIDX		= "";
String rtFILE_NM	= "";
String rtRFILE_NM	= "";
String rtORDER_NO	= "";
String rtREG_DT 	= "";

if (rtn_Map.get("getFileInfo") != null) {
	rtn_row_Map = (Map)rtn_Map.get("getFileInfo"); // 조회된 파일정보
	rtIDX 		= HtmlTag.returnString(String.valueOf(rtn_row_Map.get("idx")),"");
	rtM_CODE	= HtmlTag.returnString((String)rtn_row_Map.get("mCode"),"");
	rtRIDX		= HtmlTag.returnString(String.valueOf(rtn_row_Map.get("ridx")),"");
	rtFILE_NM	= HtmlTag.returnString((String)rtn_row_Map.get("fileNm"),"");//원본파일정보
	rtRFILE_NM	= HtmlTag.returnString((String)rtn_row_Map.get("rfileNm"),"");//실재파일정보
	rtORDER_NO	= HtmlTag.returnString(String.valueOf(rtn_row_Map.get("orderNo")),"");//순번
	rtREG_DT 	= HtmlTag.returnString((String)rtn_row_Map.get("regDt"),"");//
} else {
	if ("000096".equals((String)request.getAttribute("fpcode"))) {
		if ("1".equals((String)request.getAttribute("vsfile")))	{
			rtFILE_NM = "붙임 생활연수원입소신청서(양식).hwp";
			rtRFILE_NM= "form1.hwp";
		} else if ("2".equals((String)request.getAttribute("vsfile"))) {
			rtFILE_NM = "제주연수신청양식.xlsx";
			rtRFILE_NM= "form2.xlsx";
		}
		rtM_CODE = (String)request.getAttribute("fpcode");
	}	
}

String fext = rtFILE_NM.substring(rtFILE_NM.indexOf(".")+1).toLowerCase();  // 파일 확장자

String real_path = docsave_root+"/"+rtM_CODE+"/"+rtRFILE_NM.substring(0,8)+"/"+rtRFILE_NM;
System.out.println("downfile:"+real_path);	
String mimeType = "file/unknown";
File fName = new File(real_path);
try {
	if (fName.exists()) {
		//set response headers to force download
		response.setContentType(mimeType);
		// filename은 다운로드 창이 뜰때 파일명이며 한글인 경우 파일이 깨지므로 decoding된 파일 이름을 적습니다.
		// 이 소스에서는 szReqFileName 입니다. Header를 정의하는 이부분이 핵심입니다.
		// attachment가 없으면 왼쪽 마우스 클릭시 웹브라우져 화면에서 그냥 열리게 됩니다.
		//response.setHeader("Content-Disposition","attachment; filename=\""+ URLEncoder.encode(rtFILE_NM,sys_encoding) + "\"");
		response.setHeader("Content-Disposition","attachment; filename=\""+ new String(rtFILE_NM.getBytes("KSC5601"), "8859_1") + "\"");
		/*response.setHeader("Content-Transfer-Encoding: binary");
		response.setHeader("Accept-Ranges: bytes\n");
		response.setHeader("Content-Length: "+fName.length());
		response.setHeader("Connection: close");*/
		  
		//stream out file
		FileInputStream fInputStream =new FileInputStream(fName);
		ServletOutputStream fOutputStream = response.getOutputStream();
		int i;
		while ((i=fInputStream.read()) != -1) {
			fOutputStream.write(i);
		}
		fInputStream.close();
		fOutputStream.close();
	}else {
		System.out.println(real_path + " 이 경로에 해당 파일이 없습니다.");
	}
}catch(NullPointerException exp){
	System.out.println("NullPointerException: ");
}catch(ArrayIndexOutOfBoundsException exp){
	System.out.println("ArrayIndexOutOfBoundsException: ");
}catch (Exception exp){
	System.out.println("Exception: ");
}
%>