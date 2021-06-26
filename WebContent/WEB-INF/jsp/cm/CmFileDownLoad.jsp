<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmFileDownLoad
/* 프로그램 이름     : CmFileDownLoad    
/* 소스파일 이름     : CmFileDownLoad.jsp
/* 설명              : SYSTEM 시스템 관리자 공통 파일 다운로드 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-24
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2015-04-24
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

String file_seqno 			= "";
String menu_cd				= "";
String menu_data_key_datas	= "";
String file_nm				= "";
String update_file_nm		= "";
String file_order_no		= "";
String file_size 			= "";
String regst_ymd 			= "";

String file_path 			= "";
String file_ext 			= "";

String userAgent			= "";

String fext = "";  // 파일 확장자


String real_path = "";

String fpcode = HtmlTag.returnString((String)request.getAttribute("fpcode"),"");
String img_type = HtmlTag.returnString((String)request.getAttribute("img_type"),"");

String downfileNm = "";
String mimeType = "";
//System.out.println("한글:viewMap:정관.hwp");	
//System.out.println("downfile:viewMap:"+viewMap);	
if(pstate.equals("FILEDOWN2")){//파일명을 파라미터로 다운로드 - 2015.08.05 kss
	
	file_seqno 			= CM_Util.nullToEmpty((String)viewMap.get("file_seqno"));
	menu_cd				= CM_Util.nullToEmpty((String)viewMap.get("menu_cd"));
	menu_data_key_datas	= CM_Util.nullToEmpty((String)viewMap.get("menu_data_key_datas"));
	file_nm				= CM_Util.nullToEmpty((String)viewMap.get("file_nm"));
	update_file_nm		= CM_Util.nullToEmpty((String)viewMap.get("update_file_nm"));
	file_order_no		= CM_Util.nullToEmpty((String)viewMap.get("file_order_no"));
	file_size 			= CM_Util.nullToEmpty((String)viewMap.get("file_size"));
	regst_ymd 			= CM_Util.nullToEmpty((String)viewMap.get("regst_ymd"));
	userAgent			= (String)request.getHeader("user-agent");
	
	file_nm= file_nm.replaceAll("\\.\\.", "").replaceAll("/", "");
	update_file_nm= update_file_nm.replaceAll("\\.\\.", "").replaceAll("/", "");	
	
	fext = file_nm.substring(file_nm.indexOf(".")+1).toLowerCase();  // 파일 확장자
	
	real_path = docsave_root+"/"+menu_cd+"/"+update_file_nm.substring(0,8)+"/"+update_file_nm;
	
}else{//기존 파일다운로드
	
	file_seqno 			= CM_Util.nullToEmpty((String)viewMap.get("file_seqno"));
	menu_cd				= CM_Util.nullToEmpty((String)viewMap.get("menu_cd"));
	menu_data_key_datas	= CM_Util.nullToEmpty((String)viewMap.get("menu_data_key_datas"));
	file_nm				= CM_Util.nullToEmpty((String)viewMap.get("file_nm"));
	update_file_nm		= CM_Util.nullToEmpty((String)viewMap.get("update_file_nm"));
	file_order_no		= CM_Util.nullToEmpty((String)viewMap.get("file_order_no"));
	file_size 			= CM_Util.nullToEmpty((String)viewMap.get("file_size"));
	regst_ymd 			= CM_Util.nullToEmpty((String)viewMap.get("regst_ymd"));
	userAgent			= (String)request.getHeader("user-agent");
	
	fext = file_nm.substring(file_nm.indexOf(".")+1).toLowerCase();  // 파일 확장자
	
	file_nm= file_nm.replaceAll("\\.\\.", "").replaceAll("/", "");
	update_file_nm= update_file_nm.replaceAll("\\.\\.", "").replaceAll("/", "");
	
	if(img_type.equals("static_file")){
		//System.out.println("static_file file_nm:"+file_nm);	
		//CM_Util.logEncoding(file_nm);
		//real_path = CONTEXTROOT_REALPATH+"/images/S01/down/"+update_file_nm;
		//real_path = CONTEXTROOT_REALPATH+"/images/S01/down/정관.hwp";
		real_path = CONTEXTROOT_REALPATH+"/down/"+update_file_nm;
		//System.out.println("real_path ========== "+real_path);	
	/*
	 * 20180502
	 * 임시 정적 Rss파일 및 qrCode 다운로드 필터추가
	 * 업무정의후 변경 및 삭제 진행예정
	*/
	}else if(img_type.equals("static_rss")){
		real_path = docsave_root+"/000377/"+update_file_nm;
	}else if(img_type.equals("static_qrCode")){
		real_path = docsave_root+"/000371/"+update_file_nm;
	}else{
		
		// 썸네일 파일일경우
		if(img_type.equals("thumnail_file")){
			real_path = docsave_root+"/"+menu_cd+"/"+update_file_nm.substring(0,8)+"/"+update_file_nm.replace("."+fext, "").replace("."+fext.toUpperCase(), "")+"_thum.png";
		}else{
			real_path = docsave_root+"/"+menu_cd+"/"+update_file_nm.substring(0,8)+"/"+update_file_nm;
			System.out.println(update_file_nm.substring(0,8));
		}
			
	}
	

	

}


//CM_Util.logEncoding(file_nm);
// ie의 경우
if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
	if(img_type.equals("static_file")){
		System.out.println("downfile:11111111111111111");	
		//downfileNm = URLEncoder.encode(CM_Util.nullToEmpty((String)viewMap.get("file_nm")),"UTF-8").replaceAll("\\+", "%20");
		downfileNm = URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20");
		//downfileNm = new String(file_nm.getBytes("UTF-8"), "UTF-8");
		//downfileNm = new String(file_nm.getBytes("UTF-8"), "8859_1");
		//downfileNm = new String (file_nm.getBytes("UTF-8"), "euc-kr");

		
		//downfileNm = new String(file_nm.getBytes("8859_1"),"UTF-8");
		//real_path = new String(real_path.getBytes("8859_1"), "UTF-8");
		//real_path = new String(real_path.getBytes("UTF-8"), "KSC5601");
	}else{
		System.out.println("downfile:22222222222222222");	
		downfileNm = URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20");
	}
	
	//downfileNm = new String(file_nm.getBytes("euc-kr"), "8859_1");
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
	
	//System.out.println("downfile:ie:"+downfileNm);	
}else{
	System.out.println("downfile:3333333333333333333");	
	//downfileNm = new String(file_nm.getBytes("KSC5601"), "8859_1");
	downfileNm = URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20");
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
		mimeType = "file/unknown";
	}	
	
	//mimeType = "application/octet-stream";
	//System.out.println("downfile:ie else:"+downfileNm);	
}

// 썸네일 파일일경우
if(img_type.equals("thumnail_file")){
	mimeType = "image/png";
}

System.out.println("real_path:"+real_path);	
System.out.println("downfileNm:"+downfileNm);	
// System.out.println("mimeType:"+mimeType);	

File fName = new File(real_path);
System.out.println("fName.exists()=== "+fName.exists());	

try {
	if (fName.exists()) {

		System.out.println(real_path + " 이 경로에 해당 파일이 exists");
	}else {
		if(img_type.equals("thumnail_file")){
			real_path = docsave_root+"/"+menu_cd+"/"+update_file_nm.substring(0,8)+"/"+update_file_nm;
			fName = new File(real_path);
			
		}else{
			downfileNm = new String("no_img01.gif".getBytes("KSC5601"), "8859_1");
			if(img_type.equals("thumnail_file")){
				real_path = CONTEXTROOT_REALPATH+"/images/S01/search/no_img01_thum.gif";
			}else{
				real_path = CONTEXTROOT_REALPATH+"/images/S01/search/no_img01.gif";
			}
			
			mimeType = "image/gif";
			fName = new File(real_path);
			System.out.println(real_path + " 이 경로에 해당 파일이 없습니다.");			
		}

	}
		//set response headers to force download
		response.setContentType(mimeType);
		// filename은 다운로드 창이 뜰때 파일명이며 한글인 경우 파일이 깨지므로 decoding된 파일 이름을 적습니다.
		// 이 소스에서는 szReqFileName 입니다. Header를 정의하는 이부분이 핵심입니다.
		// attachment가 없으면 왼쪽 마우스 클릭시 웹브라우져 화면에서 그냥 열리게 됩니다.
		//response.setHeader("Content-Disposition","attachment; filename=\""+ URLEncoder.encode(rtFILE_NM,sys_encoding) + "\"");
		response.setHeader("Content-Disposition","attachment; filename=\""+ downfileNm + "\"");
		response.setHeader("Content-Transfer-Encoding","binary");
		//response.setHeader("Accept-Ranges: bytes\n");
		//response.setHeader("Content-Length: "+fName.length());
		response.setHeader("Connection","close");
		out.clear();
		out=pageContext.pushBody();		  
		//stream out file
		FileInputStream fInputStream =new FileInputStream(fName);
		ServletOutputStream fOutputStream = response.getOutputStream();
		int i;
		while ((i=fInputStream.read()) != -1) {
			fOutputStream.write(i);
		}
		fInputStream.close();
		fOutputStream.close();

}catch(NullPointerException exp){
	System.out.println("NullPointerException: ");
}catch(ArrayIndexOutOfBoundsException exp){
	System.out.println("ArrayIndexOutOfBoundsException: ");
}catch (Exception exp){
	System.out.println("Exception: ");
}
%>