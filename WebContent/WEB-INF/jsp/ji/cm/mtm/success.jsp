<%--
/*=================================================================================*/
/* ìì¤í            : JRCMS ìì¤í SYSTEM
/* íë¡ê·¸ë¨ ìì´ë   : /WEB-INF/jsp/cm/mtm/success 
/* íë¡ê·¸ë¨ ì´ë¦     : success    
/* ìì¤íì¼ ì´ë¦     : success.jsp
/* ì¤ëª              : SYSTEM ìëí° ì´ë¯¸ì§ ìë¡ë ê²°ê³¼ íì´ì§
/* ë²ì               : 1.0.0
/* ìµì´ ìì±ì       : ì´ê¸ì©
/* ìµì´ ìì±ì¼ì     : 2014-02-19
/* ìµê·¼ ìì ì       : ì´ê¸ì©
/* ìµê·¼ ìì ì¼ì     : 2014-02-19
/* ìµì¢ ìì ë´ì©     : ìµì´ìì±
/* ìµê·¼ ìì ì		 : 
/* ìµê·¼ ìì ì¼ì     : 
/* ìµê·¼ ìì ë´ì©     : 

/*=================================================================================*/
--%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%
try {
	
String inpcode = HtmlTag.returnString((String)request.getAttribute("inpcode"),"");
if(inpcode.equals("000142")){
	//inpcode = "000115";
}
String imagealtfile = HtmlTag.returnString((String)request.getAttribute("imagealtfile"),"");
//String callback_func = HtmlTag.returnString((String)request.getAttribute("callback_func"),"");

List rtn_tmp_List = (List)rtn_Map.get("EDIT_IMG_INFO");
//callback_func="&callback_func&"&bNewLine=true&sFileName="&FileName&"&sFileURL="&FileURL
//
// ìëí° ì´ë¯¸ì§ ë±ë¡ê²°ê³¼
if(pstate.equals("CE2")){
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>FileUploader Callback</title>
</head>
<body>
<%
Object paramtype =  request.getAttribute("callback_func");
String [] callback_func = new String[0];
String callback_func_str="";
if (paramtype instanceof String){
	
		callback_func_str = HtmlTag.returnString((String)request.getAttribute("callback_func"),"");

}else{
	callback_func = (String [])request.getAttribute("callback_func");
	if(callback_func.length==1){
		callback_func_str = callback_func[0];

	}else{
		callback_func_str = callback_func[callback_func.length-1];
	}	
}

if(rtn_tmp_List!=null){
	if(rtn_tmp_List.size() > 0){
		rtn_row_Map = (Map)rtn_tmp_List.get(0);
		String FileURL = con_root+"/cmsmain.do?scode="+scode+"&pcode="+pcode+"&pstate=DO&inpcode="+inpcode+"&rfile="+rtn_row_Map.get("maskName");
		String sFileName = (String)rtn_row_Map.get("fileName");
		
%>
    <script type="text/javascript">
    	// alert("callback");
		// document.domain ì¤ì 
		//try { document.domain = "http://*.naver.com"; } catch(e) {}
		try { 
			//document.domain = "http://222.99.52.195:1503"; 
		} catch(e) {}
		
        // execute callback script
        //var sUrl = document.location.search.substr(1);
        var sUrl = "callback_func=<%=callback_func_str.replace("&lt;x-frame","Frame")%>&bNewLine=true&sFileName=<%=sFileName%>&sFileURL=<%=FileURL%>";
		if (sUrl != "blank") {
	        var oParameter = {}; // query array

	        sUrl.replace(/([^=]+)=([^&]*)(&|$)/g, function(){
	            oParameter[arguments[1]] = arguments[2];
	            return "";
	        });
	        
	        oParameter['sFileURL']="<%=FileURL%>";
	        //console.log(oParameter);

	        
	        
	        if ((oParameter.errstr || '').length) { // on error
	            (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_error'])(oParameter);
	        } else {
		        (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_success'])(oParameter);
		    }

		}
    </script>
<%		
	}
}


//for(int ci=0;ci<callback_func.length;ci++){
//callback_func[ci]

//}
//[{fileSize=5142, maskName=20170110155438_000047_0.png, fileformName=uploadInputBox, cnt=1, file_group_seq=1, fileName=logo_s.png, file_group_nm=cmfile}]
//
%>


</body>
</html>
<%							

	
}else if(pstate.equals("DO")){	
	
	String rfile = HtmlTag.returnString((String)request.getAttribute("rfile"),"");
	//String real_path = docsave_root+"/"+pcode+"/"+inpcode+"/"+curDate+"/"+rfile;
	//out.print("real_path:::"+docsave_root+"/"+pcode+"/"+inpcode+"/"+curDate+"/"+rfile);
	//String real_path = docsave_root.replaceAll("[.][.]","")+"/"+pcode.replaceAll("[.][.]","")+"/"+inpcode.replaceAll("[.][.]","")+"/"+curDate.replaceAll("[.][.]","")+"/"+rfile.replaceAll("[.][.]","");
	String real_path = docsave_root.replaceAll("[.][.]","")+"/"+pcode.replaceAll("[.][.]","")+"/"+inpcode.replaceAll("[.][.]","")+"/"+rfile.substring(0,8)+"/"+rfile.replaceAll("[.][.]","");
	
	//out.print("::::::::::::real_path:::"+real_path);
	String mimeType = "file/unknown";
	String fext = "";  // 파일 확장자
	
	fext = rfile.substring(rfile.indexOf(".")+1).toLowerCase();  // 파일 확장자
	
	if(fext.equals("jpg")){
		mimeType = "image/jpeg";
	}else if(fext.equals("jpeg")){
		mimeType = "image/jpeg";		
	}else if(fext.equals("gif")){
		mimeType = "image/gif";
	}else if(fext.equals("png")){
		mimeType = "image/png";
	}else if(fext.equals("bmp")){
		mimeType = "image/bmp";		
	}else{
		mimeType = "application/octet-stream";
	}	
	File fName = new File(real_path);
	FileInputStream fInputStream = null;
	ServletOutputStream fOutputStream = null;
		if (fName.exists()) {
			//set response headers to force download
			response.setContentType(mimeType);
			// filenameì ë¤ì´ë¡ë ì°½ì´ ë°ë íì¼ëªì´ë©° íê¸ì¸ ê²½ì° íì¼ì´ ê¹¨ì§ë¯ë¡ decodingë íì¼ ì´ë¦ì ì ìµëë¤.
			// ì´ ìì¤ììë szReqFileName ìëë¤. Headerë¥¼ ì ìíë ì´ë¶ë¶ì´ íµì¬ìëë¤.
			// attachmentê° ìì¼ë©´ ì¼ìª½ ë§ì°ì¤ í´ë¦­ì ì¹ë¸ë¼ì°ì ¸ íë©´ìì ê·¸ë¥ ì´ë¦¬ê² ë©ëë¤.
			//response.setHeader("Content-Disposition","attachment; filename=\""+ rfile + "\"");
			//response.setHeader("Content-Transfer-Encoding: binary");
			//response.setHeader("Accept-Ranges: bytes\n");
			//response.setHeader("Content-Length: "+fName.length());
			//response.setHeader("Connection: close");
			  
			
			//getOutputStream() has already been called for this responseí´ê²° 2018.06.22
			out.clear();
			out = pageContext.pushBody();
			try{			
			//stream out file
			fInputStream =new FileInputStream(fName);
			fOutputStream = response.getOutputStream();
			int i;

				while ((i=fInputStream.read()) != -1) {
					fOutputStream.write(i);
				}
			}catch(IOException exp){
				if(fInputStream!=null)fInputStream.close();
				if(fOutputStream!=null)fOutputStream.close();				
				System.out.println("IOException: ");
			}catch(NullPointerException exp){
				if(fInputStream!=null)fInputStream.close();
				if(fOutputStream!=null)fOutputStream.close();				
				System.out.println("NullPointerException: ");
			}finally{
				if(fInputStream!=null)fInputStream.close();
				if(fOutputStream!=null)fOutputStream.close();				
			}

		}else {
			System.out.println(real_path + "real_path.");
		}


}else{
%>
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>
	<body>
<script type='text/javascript'>
//<![CDATA[
    alert("alert.");     
//]]>
</script>
	</body>
</html>
<%
}

}catch(IOException exp){
		
	System.out.println("IOException: ");
	
}catch(NullPointerException exp){
		
	System.out.println("NullPointerException: ");
	
}catch(ArrayIndexOutOfBoundsException exp){
		
	System.out.println("ArrayIndexOutOfBoundsException: ");
	
}catch (Exception exp){
	
	System.out.println("Exception: ");
	
}finally{
	System.out.println("end: ");
}

%>	