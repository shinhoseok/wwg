<%--
/*=================================================================================*/
/* 시스템            : 엑셀다운로드
/* 프로그램 아이디   : /WEB-INF/jsp/common/excelDown.jsp
/* 프로그램 이름     : excelDown.jsp    
/* 소스파일 이름     : excelDown.jsp
/* 설명              : 엑셀다운로드
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2017-04-28
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018.03.06
/* 최종 수정내용     : 
/*=================================================================================*/
--%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CreationHelper"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFDataFormat"%>
<%@ page import="java.io.*, java.util.*, java.lang.*, java.text.* " %>
<%@ page import="com.ji.cm.*" %>
<%@ page import="com.ji.common.*" %>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%

    System.out.println("######  엑셀다운로드  ######");

    Map paramMap = new HashMap();
    paramMap = (Map)request.getAttribute("excelParam");
    
    List codeList = new ArrayList();
    Map dataItemM = new HashMap();
    DateUtility dateUtility = new DateUtility();
    String curDate = dateUtility.getToday();
//     int [] itemWArr = {20,20,30,20,30,30,20};
    String [] itemWArr = paramMap.get("excelWidth").toString().split(",");
    String [] itemHeaderArr1 = paramMap.get("excelHeader1").toString().split(","); 
    String [] itemHeaderArr2 = paramMap.get("excelHeader2")==null ? new String[]{} : paramMap.get("excelHeader2").toString().split(","); 
    String [] itemHeaderArr3 = paramMap.get("excelHeader3")==null ? new String[]{} : paramMap.get("excelHeader3").toString().split(","); 
    String [] itemColumnArr = paramMap.get("excelColumn").toString().split(",");
    
    System.out.println("itemWArr->" + itemWArr.length + " / " + "header1->" + itemHeaderArr1.length + " / " + "header2->" + itemHeaderArr2.length + " / " + "header3->" + itemHeaderArr3.length + " / " +"itemColumnArr->" + itemColumnArr.length); 
    String ipcs_tp_cd = "";
    String excelFileName = paramMap.get("excelFileName").toString();
    int startIdx = itemHeaderArr2.length==0 ? 2 : itemHeaderArr3.length==0 ? 3 : 4;
    int cellIdx = 0;
    int i = 0;
    int j = 0;
    String cellVal = "";
    String RESULT_DTO_KEY= (String)request.getAttribute("RESULT_DTO_KEY");
    
    System.out.println(startIdx);
    
    Map rtn_Map = (Map) request.getAttribute(RESULT_DTO_KEY);   
    
    //기본조회
    List des_rows = (List)rtn_Map.get("rows");
    
try{
	
    HSSFWorkbook wb = new HSSFWorkbook();  // or  new HSSFWorkbook();
    Sheet sheet = wb.createSheet(excelFileName + "_" + curDate); //시트명 셋팅
    CreationHelper createHelper = wb.getCreationHelper();
    
    CellStyle hstyle = wb.createCellStyle();
    Cell cell;
    
    //엑셀상단생성
    Row row = sheet.createRow((short) 0);
    cellIdx = 0;
    for(i=0; i < itemHeaderArr1.length; i++) { 
        sheet.setColumnWidth((i+cellIdx), Integer.parseInt(itemWArr[i+cellIdx].trim())*256);
    }
    
    sheet.addMergedRegion(new CellRangeAddress( 0,0,0,(itemHeaderArr1.length-1)));//가로병합
    
    // 헤더 스타일 적용
    hstyle = wb.createCellStyle();
    hstyle.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE.getIndex()); // 헤더 색깔 설정
    hstyle.setFillPattern(CellStyle.SOLID_FOREGROUND); // 헤더 색깔 설정
    hstyle.setBorderTop(CellStyle.BORDER_THIN); // 테두리 설정
    hstyle.setBorderLeft(CellStyle.BORDER_THIN); // 테두리 설정
    hstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
    hstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
    hstyle.setAlignment(CellStyle.ALIGN_CENTER);
    
    cellIdx = 0;
    cell = row.createCell((short) cellIdx);
    cell.setCellValue(createHelper.createRichTextString(excelFileName));
    cell.setCellStyle(hstyle);  
    
    //헤더1생성
    row = sheet.createRow((short) 1);
    cellIdx = 0;
    for(i=0; i < itemHeaderArr1.length; i++) {
        cell = row.createCell((short) (i+cellIdx));
        cell.setCellValue(createHelper.createRichTextString(itemHeaderArr1[i].trim()));
        hstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
        hstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
        cell.setCellStyle(hstyle);  
    }
    
    //헤더2생성
    if (startIdx>2) {
	    row = sheet.createRow((short) 2);
	    cellIdx = 0;
	    for(i=0; i < itemHeaderArr2.length; i++) {
	        cell = row.createCell((short) (i+cellIdx));
	        cell.setCellValue(createHelper.createRichTextString(itemHeaderArr2[i].trim()));
	        hstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	        hstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	        cell.setCellStyle(hstyle);  
	    }
    }
    
    //헤더3생성
    if (startIdx>3) {
	    row = sheet.createRow((short) 3);
	    cellIdx = 0;
	    for(i=0; i < itemHeaderArr3.length; i++) {
	    	String strTmp[] = itemHeaderArr3[i].trim().split("\n");
	        cell = row.createCell((short) (i+cellIdx));
	        cell.setCellValue(createHelper.createRichTextString(itemHeaderArr3[i].trim()));
	        hstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	        hstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	        hstyle.setWrapText(true);
	        cell.setCellStyle(hstyle);
	    }
    }
    
    CellStyle dstyle = wb.createCellStyle();
    dstyle = wb.createCellStyle();
    dstyle.setBorderTop(CellStyle.BORDER_THIN); // 테두리 설정
    dstyle.setBorderLeft(CellStyle.BORDER_THIN); // 테두리 설정
    dstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
    dstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정 
    dstyle.setAlignment(CellStyle.ALIGN_CENTER);
    
    for (i=0; i<des_rows.size(); i++) {
        dataItemM = (Map)des_rows.get(i);
        row = sheet.createRow((short) ((i+startIdx)));
        cellIdx = 0;
        
        for (int z=0; z<itemColumnArr.length; z++) {
//         	System.out.println(itemColumnArr[z].trim());
//         	System.out.println(dataItemM.get(itemColumnArr[z].trim()));
	        cell = row.createCell((short) cellIdx++);
	        cell.setCellValue(createHelper.createRichTextString(StringUtils.trimToEmpty(dataItemM.get(itemColumnArr[z].trim()).toString())));
	        cell.setCellStyle(dstyle);
	        cell.setCellType(Cell.CELL_TYPE_STRING);
        }
    }
    String userAgent = request.getHeader("User-Agent");
    System.out.println("userAgent==>"+userAgent);
    
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
    
    System.out.println("excelFileName==>"+excelFileName);
    out.clear();
    out=pageContext.pushBody();
    
    // 엑셀 파일로 반환
    response.setHeader("Content-Type", "application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName.replace("+", " ") + ".xls" ); //띄워쓰기(+생성됨) 관련해서 추가함
    response.setHeader("Content-Description", "JSP Generated Data");
    
    OutputStream excelOut = response.getOutputStream();
    System.out.println("excelOut==>"+excelOut);
    
    wb.write(excelOut);
    //excelOut.flush();
    excelOut.close();
	} catch(NullPointerException e){
		System.out.println("NullPointerException");
	
	} catch(ArrayIndexOutOfBoundsException e){
		
		System.out.println("ArrayIndexOutOfBoundsException");
    }catch (Exception e) {
        System.out.println("Exception::");
        
    }

%>

