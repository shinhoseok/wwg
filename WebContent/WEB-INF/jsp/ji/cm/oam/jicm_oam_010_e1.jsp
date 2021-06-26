<%@page import="org.apache.poi.hssf.util.Region"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CreationHelper"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@page import="com.ji.common.HtmlTag"%>
<%@page import="java.io.OutputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> --%>
<%

    String excelFileName = "발전사업본부 인원현황";
	Map<String,Object> paramMap = new HashMap<String,Object>();
	List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
	
	Map<String,Object> dataMap = new HashMap<String,Object>();
	paramMap = (Map)request.getAttribute("excelParam"); // 조회된전체left메뉴 리스트
	
	//System.out.println("codeList==>"+codeList);
	
try{
	HSSFWorkbook wb = new HSSFWorkbook();  // or  new HSSFWorkbook();
	CreationHelper createHelper = wb.getCreationHelper();
	
	// 헤더 스타일 적용
	CellStyle gstyle = wb.createCellStyle();
	gstyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // 헤더 색깔 설정
	gstyle.setFillPattern(CellStyle.SOLID_FOREGROUND); // 헤더 색깔 설정
	gstyle.setAlignment(CellStyle.ALIGN_CENTER);
	gstyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
	CellStyle dstyleC = wb.createCellStyle();
	dstyleC.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	dstyleC.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	dstyleC.setAlignment(CellStyle.ALIGN_CENTER);
	dstyleC.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
	CellStyle dstyleR = wb.createCellStyle();
	dstyleR = wb.createCellStyle();
	dstyleR.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	dstyleR.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	dstyleR.setAlignment(CellStyle.ALIGN_RIGHT);
	dstyleR.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
	int cellIdx = 0;
	
	//1.당월발전실적 : 월별조회를 선택했을경우
	Sheet sheet = wb.createSheet("발전사업본부 사업소 인원현황"); // 시트명 셋팅
	Row row = sheet.createRow((short) 0);
	// 0,1,0,1 을 예를 들어 기술 
	//숫자 4개의 값은 앞 2개의 숫자 는 Y축 뒤 숫자 2개는 X축을 의미 앞 숫자 0,1은 Y죄표 0부터 1까지 즉 엑셀 문서에서 row 1~2까지 범위를 차지  뒤 0,1 은 X축 0 에서 부터 1까지를 범위를 의미 행 A에서부터 B까지의 범위  (결과값은   1행 2행 A열 B열 셀병합 되어있음)
	
	sheet.addMergedRegion(new CellRangeAddress( 0,1,0,1));  
	sheet.addMergedRegion(new CellRangeAddress( 0,1,2,2));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,3,3));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,4,4));
	
	sheet.addMergedRegion(new CellRangeAddress( 0,0,5,6));
	
	sheet.addMergedRegion(new CellRangeAddress( 0,1,7,7));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,8,8));
	
	
 	sheet.addMergedRegion(new CellRangeAddress( 0,0,5,5));
	sheet.addMergedRegion(new CellRangeAddress( 0,0,6,6)); 
	
/* 	sheet.addMergedRegion(new CellRangeAddress( 0,1,1,1));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,2,2));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,3,3));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,4,4));
	sheet.addMergedRegion(new CellRangeAddress( 0,1,5,5));
	sheet.addMergedRegion(new CellRangeAddress( 0,0,6,7));
	sheet.addMergedRegion(new CellRangeAddress( 0,0,8,9)); */

	
	Cell cell = row.createCell((short) 0);
	cell.setCellValue(createHelper.createRichTextString("구분"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
	
	cell = row.createCell((short) 1);
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
    
    cell = row.createCell((short) 2);
    cell.setCellValue(createHelper.createRichTextString("소장"));
    gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
    gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
    
    
    cell = row.createCell((short) 3);
	cell.setCellValue(createHelper.createRichTextString("공무"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 4);
	cell.setCellValue(createHelper.createRichTextString("정비원(발전,배전)"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
	
    cell = row.createCell((short) 5);
	cell.setCellValue(createHelper.createRichTextString("발전운전원"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 6);
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 7);
	cell.setCellValue(createHelper.createRichTextString("계기원"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 8);
	cell.setCellValue(createHelper.createRichTextString("계"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
 
	
    row = sheet.createRow((short) 1);
    
    cell = row.createCell((short) 0);
   	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
   	
    cell = row.createCell((short) 1);
   	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
   	
    cell = row.createCell((short) 2);
  	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
   	
    cell = row.createCell((short) 3);
  	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
    
    cell = row.createCell((short) 4);
  	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
   	
    
    cell = row.createCell((short) 5);
	cell.setCellValue(createHelper.createRichTextString("배전반"));
	gstyle.setBorderTop(CellStyle.BORDER_THIN); // 테두리 설정
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 6);
	cell.setCellValue(createHelper.createRichTextString("현장"));
	gstyle.setBorderTop(CellStyle.BORDER_THIN); // 테두리 설정
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
    cell = row.createCell((short) 7);
  	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
   	
   	
    cell = row.createCell((short) 8);
  	gstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
   	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
  
    resultList=(List<HashMap<String,Object>>)paramMap.get("report");
    int dataSize = resultList.size();
    
    int sojang = 0;
    int gongmu = 0;
    int jeongbiwon = 0;
    int baljeon1 = 0;
    int baljeon2 = 0;
    int gegi = 0;
    int hab = 0;
    
    String aaa ="";
    
    if(dataSize > 0){
    //sheet.addMergedRegion(new CellRangeAddress( 2,1+dataSize,0,0));
	
    
    for(int i=0; i < dataSize; i++) {
        cellIdx = 0;	
        dataMap = (Map<String, Object>) resultList.get(i);
        row = sheet.createRow((short) (i+2));
     
    	sojang += Integer.parseInt(String.valueOf(dataMap.get("sojang")));
    	gongmu += Integer.parseInt(String.valueOf(dataMap.get("gongmu")));
    	jeongbiwon += Integer.parseInt(String.valueOf(dataMap.get("jeongbiwon")));
    	baljeon1 += Integer.parseInt(String.valueOf(dataMap.get("baljeon1")));
    	baljeon2 += Integer.parseInt(String.valueOf(dataMap.get("baljeon2")));
    	gegi += Integer.parseInt(String.valueOf(dataMap.get("gegi")));
    	hab += Integer.parseInt(String.valueOf(dataMap.get("hab")));
        
    	sheet.setColumnWidth((short) cellIdx, (short) 4000);
   	    cell = row.createCell((short) cellIdx++);
   		cell.setCellValue(dataMap.get("rootOrgNm") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("orgNm") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("sojang") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("gongmu") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 4500);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("jeongbiwon") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("baljeon1") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("baljeon2") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("gegi") + "");
        cell.setCellStyle(dstyleC);
        
        sheet.setColumnWidth((short) cellIdx, (short) 3000);
    	cell = row.createCell((short) cellIdx++);
    	cell.setCellValue(dataMap.get("hab") + "");
        cell.setCellStyle(dstyleC);
    
      }
    }
    
    row = sheet.createRow((short) (dataSize+2));
    
   sheet.addMergedRegion(new CellRangeAddress( dataSize+2,dataSize+2,0,1));
	
    
	cell = row.createCell((short) 0);
	cell.setCellValue(createHelper.createRichTextString("소계"));
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
    
    cell = row.createCell((short) 1);
	gstyle.setBorderBottom(CellStyle.BORDER_NONE); // 테두리 설정
	gstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    cell.setCellStyle(gstyle);
	
	
    cell = row.createCell((short) 2);
	cell.setCellValue(sojang);
    cell.setCellStyle(dstyleC);
	
    cell = row.createCell((short) 3);
	cell.setCellValue(gongmu);
    cell.setCellStyle(dstyleC);
    
    cell = row.createCell((short) 4);
	cell.setCellValue(jeongbiwon);
    cell.setCellStyle(dstyleC);
    
    cell = row.createCell((short) 5);
	cell.setCellValue(baljeon1);
    cell.setCellStyle(dstyleC);
    
    cell = row.createCell((short) 6);
	cell.setCellValue(baljeon2);
    cell.setCellStyle(dstyleC);
    
    cell = row.createCell((short) 7);
	cell.setCellValue(gegi);
    cell.setCellStyle(dstyleC);
    
    cell = row.createCell((short) 8);
	cell.setCellValue(hab);
    cell.setCellStyle(dstyleC);
	
    
    String userAgent = request.getHeader("User-Agent");
	//System.out.println("userAgent==>"+userAgent);
	
	// MS IE 5.5 이하
	if (userAgent.indexOf("MSIE 5.5") > -1) { 
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// MS IE (보통은 6.x 이상 가정)
	else if (userAgent.indexOf("MSIE") > -1) { 
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// IE 11.0
	else if(userAgent.contains("11.0")){
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// 안드로이드 크롬브라우저 대응
	else if(userAgent.indexOf("Android") > -1){
		excelFileName = URLEncoder.encode(excelFileName, "UTF-8");
	}
	// 모질라나 오페라
	else { 
		excelFileName = new String(excelFileName.getBytes("UTF-8"), "ISO-8859-1"); 
	}
	
	//System.out.println("excelFileName==>"+excelFileName);
	
	// 엑셀 파일로 반환
	response.setHeader("Content-Type", "application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName.replace("+", " ") + ".xls" );	//띄워쓰기(+생성됨) 관련해서 추가함
    response.setHeader("Content-Description", "JSP Generated Data");
    
    OutputStream excelOut = response.getOutputStream();
    //System.out.println("excelOut==>"+excelOut);
    
	wb.write(excelOut);
	//excelOut.flush();
	excelOut.close();
	} catch(NullPointerException e){		System.out.println("NullPointerException");		} catch(ArrayIndexOutOfBoundsException e){				System.out.println("ArrayIndexOutOfBoundsException");
	}catch (Exception e) {		System.out.println("Exception: ");
		
	}

%>
<%!

%>

<html>
<head>
	<style> .excel_header {background-color:#efefef;} </style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>

</body>
</html>