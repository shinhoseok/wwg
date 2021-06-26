<%--
/*=================================================================================*/
/* 시스템            : 구매자재
/* 프로그램 아이디   : /WEB-INF/jsp/ji/mp/prp/jimp_prp_020_e1
/* 프로그램 이름     : jimp_prp_020_e1    
/* 소스파일 이름     : jimp_prp_020_e1.jsp
/* 설명              : 구매자재 - 구매입고확정 - 엑셀 샘플
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-05-12
/* 최근 수정자       : 강삼수
/* 최근 수정일시     : 2015-05-12
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page import="com.ji.cm.CM_Util"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.apache.poi.hssf.util.Region"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CreationHelper"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.hssf.util.Region"%>
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
<%
	out.clear();
	pageContext.pushBody();
	System.out.println("######  CmExceldown3 Poi Start ######");
	List headerItem = new ArrayList();
	List dataItemL = new ArrayList();
	Map dataItemM = new HashMap();
	String RESULT_DTO_KEY= (String)request.getAttribute("RESULT_DTO_KEY");
	
	Map rtn_Map = (Map) request.getAttribute(RESULT_DTO_KEY);
	
	String excelFileName ="";
	String paramFileName = HtmlTag.returnString((String)request.getAttribute("excelFileName"),"");
	String colNames = HtmlTag.returnString((String)request.getAttribute("colNames"),"");
	String [] colNames_sp = null;
	String colId = HtmlTag.returnString((String)request.getAttribute("colId"),"");
	String [] colId_sp = null;
	String colWidth = HtmlTag.returnString((String)request.getAttribute("colWidth"),"");
	String [] colWidth_sp = null;	
	dataItemL = (List)rtn_Map.get("rows");
	String headerItem_str = "";
	
	int ei = 0;
	int ej = 0;
	int cellIdx = 0;
	
try{
	//System.out.println("######  dataItemL.size() ######::"+dataItemL.size());
	excelFileName = paramFileName;
	
	//System.out.println("######  excelFileName ######::"+excelFileName);
	colNames_sp = colNames.split(",");
	colId_sp = colId.split(",");
	colWidth_sp = colWidth.split(",");
		
	for(ei=0;ei<colNames_sp.length;ei++){
		headerItem.add(colNames_sp[ei]);
		//System.out.println("######  colWidth_sp["+ei+"] ######::"+colWidth_sp[ei]);
	}
	
	
	
	HSSFWorkbook wb = new HSSFWorkbook();  // or  new HSSFWorkbook();
	Sheet sheet = wb.createSheet("data1"); // 시트명 셋팅
	CreationHelper createHelper = wb.getCreationHelper();
	
	CellStyle hstyle = wb.createCellStyle();
	Cell cell;
	
	Row row = sheet.createRow((short) 0);
	
	sheet.addMergedRegion(new CellRangeAddress( 0,0,0,(headerItem.size()-1)));//가로병합
	
	// 헤더 스타일 적용
	hstyle = wb.createCellStyle();
	hstyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // 헤더 색깔 설정
	hstyle.setFillPattern(CellStyle.SOLID_FOREGROUND); // 헤더 색깔 설정
	hstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	hstyle.setBorderTop(CellStyle.BORDER_THIN); // 테두리 설정
	hstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	hstyle.setAlignment(CellStyle.ALIGN_CENTER);	
	
	cell = row.createCell((short) cellIdx);
	cell.setCellValue(createHelper.createRichTextString(paramFileName));
    cell.setCellStyle(hstyle);	
    
	
	row = sheet.createRow((short) 1);

	
	for(ei=0;ei<headerItem.size();ei++){
		headerItem_str = (String)headerItem.get(ei);
		sheet.setColumnWidth((short) cellIdx, (short) ( 60 * Integer.parseInt(colWidth_sp[ei])));
		
		cell = row.createCell((short) cellIdx);
		cell.setCellValue(createHelper.createRichTextString(headerItem_str));
	    cell.setCellStyle(hstyle);	
	    cellIdx++;
	}

    
    CellStyle dstyle = wb.createCellStyle();
	dstyle = wb.createCellStyle();
	dstyle.setBorderBottom(CellStyle.BORDER_THIN); // 테두리 설정
	dstyle.setBorderRight(CellStyle.BORDER_THIN); // 테두리 설정
	dstyle.setAlignment(CellStyle.ALIGN_CENTER);		
    //예제만들기
    for(ei=0; ei < dataItemL.size(); ei++) {
    	dataItemM = (Map)dataItemL.get(ei);
    	row = sheet.createRow((short) (ei+2));
    	//sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));//세로병합
        //sheet.addMergedRegion(new Region(0,(short)0,1,(short)1));//가로병합
        //sheet.autoSizeColumn((short) (i+1));
        
    	cellIdx = 0;
    	
    	for(ej=0; ej < colId_sp.length; ej++) {
        	//자재번호
    	    cell = row.createCell((short) cellIdx++);   
    	    //System.out.println("###### ei::"+ei+"  dataItemM["+ej+"] ######::"+dataItemM.get(colId_sp[ej]));
			   if(dataItemM.get(colId_sp[ej]) instanceof java.math.BigDecimal ){
				   cell.setCellValue(createHelper.createRichTextString(String.valueOf(dataItemM.get(colId_sp[ej]) ) ) );
			   }else{
				   if(ej==0 && "".equals(CM_Util.nullToEmpty(String.valueOf(dataItemM.get(colId_sp[ej]))))){
					   cell.setCellValue(createHelper.createRichTextString(String.valueOf(ei+1 ) ) );
				   }else{
					   String cellVal = HtmlTag.returnString((String)dataItemM.get(colId_sp[ej]),"");
					   cellVal = cellVal.replaceAll("<br>", "\n");	
				   		cell.setCellValue(createHelper.createRichTextString(cellVal ) );
				   }
			   }        	
    	    
    	    

    		cell.setCellStyle(dstyle);    		
    	}

    }
    

    
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
	
	} catch(NullPointerException e){
		System.out.println("######  CmExceldown3 NullPointerException ######");
	
	} catch(ArrayIndexOutOfBoundsException e){
		System.out.println("######  CmExceldown3 ArrayIndexOutOfBoundsException ######");
	
	}catch (Exception e) {
		System.out.println("######  CmExceldown3 Exception ######");

	}finally{
		System.out.println("######  CmExceldown3 Poi End ######");
		return;
	}

%>