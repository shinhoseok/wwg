/*===================================================================================
 * System             : JRCMS 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.cm.CM_Util.java
 * Description        : jrcms 유틸 클래스.
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2014-02-24
 * Updated Date       : 2014-02-24
 * Last modifier      : 이금용
 * Updated content    : 패키지명 변경
 * License            : 
 *==================================================================================*/
package com.ji.cm;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;




import org.apache.poi.ss.util.NumberToTextConverter;
import org.springframework.web.util.UrlPathHelper;

import com.ji.common.HtmlTag;
import com.ji.common.JSysException;

import egovframework.rte.fdl.property.EgovPropertyService;


public class CM_Util{
	/**
	 * 현재 클래스에 대한 로그를 처리하는 변수
	 *
	 * @see org.apache.commons.logging.Log
	 * @see org.apache.commons.logging.LogFactory
	 */
	private static Logger log = Logger.getLogger(CM_Util.class);
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;		

	public void ScriptOut(HttpServletResponse res, String msg) throws JSysException{
		String script = "<script type='text/javascript'>";
		script = script + "\n //<![CDATA[ ";
		script = script + "\n alert('"+msg+"');";
		script = script + "\n //]]> ";
		script = script + "\n </script>";
		log.debug("CM_Util.ScriptOut:msg:"+msg);
		res.setHeader("cache-control","no-cache, must-revalidate");
		res.setHeader("expires","0");
		res.setHeader("pragma","no-cache");
		res.setCharacterEncoding("UTF-8"); 
		res.setContentType("text/html;charset=UTF-8");
		try {
			res.getWriter().println(script);
		} catch (IOException e) {
			log.debug("ScriptOut ERROR:");
		}
	}
	
	public void ScriptOutGourl(HttpServletResponse res, String msg, String url) throws JSysException{
		String script = "<script type='text/javascript'>";
		script = script + "\n //<![CDATA[ ";
		script = script + "\n alert('"+msg+"');";
		script = script + "\n top.location.href='"+url+"'";
		script = script + "\n //]]> ";
		script = script + "\n </script>";
		log.debug("CM_Util.ScriptOut:msg:"+msg);
		res.setHeader("cache-control","no-cache, must-revalidate");
		res.setHeader("expires","0");
		res.setHeader("pragma","no-cache");
		res.setCharacterEncoding("UTF-8"); 
		res.setContentType("text/html;charset=UTF-8");
		try {
			res.getWriter().println(script);
		} catch (IOException e) {
			log.debug("ScriptOut ERROR:");
		}
	}	
	
	/* 	  TODO : FunctionOut */
	public void FunctionOut(HttpServletResponse res, String msg, String func) throws JSysException{
		StringBuffer script = new StringBuffer();
		script.append("<script type='text/javascript'> ");
		script.append("\n //<![CDATA[ ");
		if(msg!=""){
			script.append("\n alert('"+msg+"');  ");
			
		}
		if(func!=""){
			script.append("\n "+func);
			
		}		
		script.append("\n //]]> ");
		script.append("\n </script> ");
		log.debug("CM_Util.FunctionOut:msg:"+msg);
		log.debug("CM_Util.FunctionOut:func:"+func);
		res.setHeader("cache-control","no-cache, must-revalidate");
		res.setHeader("expires","0");
		res.setHeader("pragma","no-cache");
		res.setCharacterEncoding("UTF-8"); 
		res.setContentType("text/html;charset=UTF-8");
		try {
			res.getWriter().println(script.toString());
		} catch (IOException e) {
			log.debug("FunctionOut ERROR:");
		}
	}

	/**
	 * TODO : Pageindex
	 * @param TotalCount
	 * @param show_rows
	 * @param TotalPageCount
	 * @param curr_page
	 * @param formname
	 * @param action
	 * @return
	 */
	public static String Pageindex(int TotalCount, String show_rows,
			int TotalPageCount, String curr_page, String formname, String action,
			String formele, String imgcon_root){
		// TODO Pageindex
		StringBuffer pagestr = new StringBuffer();
		int reapAmount= 10;
		int indexSize = 10;		
		int currs_page = Integer.parseInt(curr_page,10);

	       int fromPage= ((currs_page) - ((currs_page - 1) % indexSize));
	       if(TotalPageCount==0){
	    	   TotalPageCount = 1;
	       }
	       int toPage = TotalPageCount;
	       if (toPage > (fromPage + indexSize - 1)){
	  	       toPage = (fromPage + indexSize - 1);
	  	   }    
        
	      int prevPage =0;
	      int reapPrevPage =0;
	      boolean prevDisabled = false; 
	      boolean reapPrevDisabled = false; 
	      if(0<(currs_page-1)){
	         prevPage = currs_page-1;
	      }else{
	         prevDisabled = true;
	      }
	      if(0<(currs_page-reapAmount)){
	         reapPrevPage = currs_page-reapAmount;
	      }else{
	         reapPrevDisabled = true;
	      }

          
	      pagestr.append("<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','1','"+formele+"')\"><img src='"+imgcon_root+"/btn_first.gif' alt='처음페이지' border='0' "
	    		  + "onmouseover=this.src='"+imgcon_root+"/btn_first.gif' "
	    		  + "onmouseout=this.src='"+imgcon_root+"/btn_first.gif' /></a>");
	      
	      if(!prevDisabled){  
	    	  pagestr.append("<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+prevPage+"','"+formele+"')\"><img src='"+imgcon_root+"/btn_prev.gif' alt='이전페이지' border='0'   "
			  		+ "onmouseover=this.src='"+imgcon_root+"/btn_prev.gif' "
		    		+ "onmouseout=this.src='"+imgcon_root+"/btn_prev.gif' class='mR10' /></a>&nbsp;");
	      }else{
	    	  pagestr.append("<a href=\"#none\"><img src='"+imgcon_root+"/btn_prev.gif' border='0' alt='이전페이지'   class='mR10' /></a>");	    	  
	      }
	      //pagestr.append("\n<TD colSpan='"+toPage+"' align='center'>");
		  	
	      for(int k=fromPage;k<=toPage;k++){ 
	    	  int index = k;
	    	  boolean isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='pgBtn on'>"+index+"</a>");
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='pgBtn'>"+index+"</a>");
	    	  }
	    	  
	    	  if(k!=toPage){
	    		  pagestr.append(" ");
	    	  }
	      }
	  

	      int nextPage =0;
	      int reapNextPage =0;
	      boolean nextDisabled = false; 
	      boolean reapNextDisabled = false; 
	      if((currs_page+1)<=TotalPageCount){
	         nextPage = currs_page+1;
	      }else{
	         nextDisabled = true;
	      }
	      if((currs_page+reapAmount)<=TotalPageCount){
	         reapNextPage = currs_page+reapAmount;
	      }else{
	         reapNextDisabled = true;
	      }

	      if(!nextDisabled){  
	    	  pagestr.append("&nbsp;<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+nextPage+"','"+formele+"')\"><img src='"+imgcon_root+"/btn_next.gif' alt='다음페이지' border='0'   "
				  		+ "onmouseover=this.src='"+imgcon_root+"/btn_next.gif' "
			    		+ "onmouseout=this.src='"+imgcon_root+"/btn_next.gif'  /></a>");
	    	  
	      }else{
		      pagestr.append("\n&nbsp;<a href=\"#\" onclick=\"return false;\"><img src='"+imgcon_root+"/btn_next.gif' alt='다음페이지' border='0' /></a>"); 
	      }
	      
	      pagestr.append("<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+TotalPageCount+"','"+formele+"')\"><img src='"+imgcon_root+"/btn_last.gif' alt='마지막페이지' border='0' "
	    		  + "onmouseover=this.src='"+imgcon_root+"/btn_last.gif' "
	    		  + "onmouseout=this.src='"+imgcon_root+"/btn_last.gif' /></a>");	      
		
		return pagestr.toString();
	}
	
	/**
	 * TODO : PageindexS
	 * @param TotalCount
	 * @param show_rows
	 * @param TotalPageCount
	 * @param curr_page
	 * @param formname
	 * @param action
	 * @return
	 */
	public static String PageindexS(int TotalCount, String show_rows,
			int TotalPageCount, String curr_page, String formname, String action,
			String formele, String imgcon_root){
		// TODO Pageindex
		StringBuffer pagestr = new StringBuffer();
		int reapAmount= 10;
		int indexSize = 10;		
		int currs_page = Integer.parseInt(curr_page,10);

	       int fromPage= ((currs_page) - ((currs_page - 1) % indexSize));
	       if(TotalPageCount==0){
	    	   TotalPageCount = 1;
	       }
	       int toPage = TotalPageCount;
	       if (toPage > (fromPage + indexSize - 1)){
	  	       toPage = (fromPage + indexSize - 1);
	  	   }    
        
	      int prevPage =0;
	      int reapPrevPage =0;
	      boolean prevDisabled = false; 
	      boolean reapPrevDisabled = false; 
	      if(0<(currs_page-1)){
	         prevPage = currs_page-1;
	      }else{
	         prevDisabled = true;
	      }
	      if(0<(currs_page-reapAmount)){
	         reapPrevPage = currs_page-reapAmount;
	      }else{
	         reapPrevDisabled = true;
	      }
    


	      pagestr.append("<a href=\"#\" class=\"boxFirst\" onclick=\"goPagination('"+formname+"','"+action+"','1','"+formele+"');return false;\">"
	    		  + "처음 페이지로<span></span></a>");
	      
	      if(!prevDisabled){  
	    	  pagestr.append("<a href=\"#\" class=\"boxPrev\" onclick=\"goPagination('"+formname+"','"+action+"','"+prevPage+"','"+formele+"');return false;\">"
		    		+ "이전 페이지로</a>");
	      }else{
	    	  pagestr.append("<a href=\"#\" class=\"boxPrev\" onclick=\"return false;\">이전 페이지로</a>");	    	  
	      }

	      for(int k=fromPage;k<=toPage;k++){ 
	    	  int index = k;
	    	  boolean isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" class='boxnow' onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\">"+index+"</a>");
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"');return false;\" >"+index+"</a>");
	    	  }
	    	  
	    	  if(k!=toPage){
	    		  pagestr.append(" ");
	    	  }
	      }

	      int nextPage =0;
	      int reapNextPage =0;
	      boolean nextDisabled = false; 
	      boolean reapNextDisabled = false; 
	      if((currs_page+1)<=TotalPageCount){
	         nextPage = currs_page+1;
	      }else{
	         nextDisabled = true;
	      }
	      if((currs_page+reapAmount)<=TotalPageCount){
	         reapNextPage = currs_page+reapAmount;
	      }else{
	         reapNextDisabled = true;
	      }

	      if(!nextDisabled){  
	    	  pagestr.append("<a href=\"#\" class=\"boxNext\" onclick=\"goPagination('"+formname+"','"+action+"','"+nextPage+"','"+formele+"');return false;\">"
			    		+ "다음 페이지로</a>");
	    	  
	      }else{
		      pagestr.append("<a href=\"#\" class=\"boxNext\" onclick=\"return false;\">다음 페이지로</a>"); 
	      }
	      
	      pagestr.append("<a href=\"#\" class=\"boxLast\" onclick=\"goPagination('"+formname+"','"+action+"','"+TotalPageCount+"','"+formele+"');return false;\">"
	    		  + "마지막 페이지로<span></span></a>");	      
		
		return pagestr.toString();
	}	
	
	public static String b_unit(String n, int digits) {
		  String rtn_str="";
		  if(n.length() < digits){
			rtn_str = "0";
		  }else{
			rtn_str = n.substring(0,n.length()-digits);

		  }

		  return rtn_str;
	}
	
	public static String b_unit2(String n, int digits) {
		  String rtn_str="";
		  if(n.length() < digits){
			rtn_str = "0";
		  }else{
			rtn_str = n.substring(0,n.length()-digits);

		  }
		  
		  for(int i=0;i<digits;i++){
			  rtn_str = rtn_str +"0";
		  }

		  return rtn_str;
	}	
	/*
	 * 
	 * 78.53981633 일 경우

	'0.###' : 78.54  (78.540 이므로 0은 출력되지 않는다.)

	'000.##' : 078.54 

	'00.#' : 78.5

	 */
	
	public static String decimal_fmt(Double n, String sfmt) {	
	
		DecimalFormat fmt = new DecimalFormat(sfmt);

		String decimal =  fmt.format(n);
		
		return decimal; 
	
	}
	
	// 소숫점이하 반올림 ex)소수 3자리 이하에서 반올림 decimal_round(123.4567, 100)==123.46
	public static String decimal_round(Double n, int sfmt) {	
		
		return ((int)(n*sfmt+0.5)/Double.parseDouble(String.valueOf(sfmt+".0")))+"";

	
	}
	
	// 소숫점이하버림 ex)소수 3자리 이하에서 버림 decimal_trun(123.456, 100)==123.45
	public static String decimal_trun(Double n, int sfmt) {	
		
		return  ((int)(n*sfmt)/Double.parseDouble(String.valueOf(sfmt+".0")))+""; 

	
	}	
	
	// 소숫점이하버림 ex)소수 3자리 이하에서 버림 decimal_trun(123.456, 100)==123.45
	public static String make_mailContents(Map param) {	
		String mail_conts = "";
		
		String mailcontents = HtmlTag.returnString((String)param.get("mailcontents"),"");
		String mail_imgurl = HtmlTag.returnString((String)param.get("mail_imgurl"),"");
		String CHARGE_NM = HtmlTag.returnString((String)param.get("CHARGE_NM"),"");
		String CHARGE_DATE = HtmlTag.returnString((String)param.get("CHARGE_DATE"),"");
		String MAIL_SUBJECT = HtmlTag.returnString((String)param.get("MAIL_SUBJECT"),"");
		String MAIL_CONTENTS = HtmlTag.returnString((String)param.get("MAIL_CONTENTS"),"");
		
		mail_conts=mail_conts+"<style type='text/css' rel='stylesheet' >";
		mail_conts=mail_conts+"caption {width:0; height:0; text-indent:-55555px;}";

		mail_conts=mail_conts+"#mailWrap {width:766px;margin:0 auto; font-size:12px;font-family:NG, '돋움', Dotum, Sans-Serief; color:#555;}";
		mail_conts=mail_conts+"#mailWrap h1 {float:left;margin:14px 0 10px 0;}";
		mail_conts=mail_conts+"#mailWrap .office {float:right;text-align:right;margin-top:18px;background:url("+mail_imgurl+"/form_mail/mail_bullet.gif) no-repeat 3px 5px;padding-left:10px;}";
		mail_conts=mail_conts+"#mailContents {width:766px;padding:20px 30px;border:1px solid #e5e5e5;background:url("+mail_imgurl+"/form_mail/mail_img.jpg) no-repeat 30px 0;clear:both;}";
		mail_conts=mail_conts+"#mailContents .mailDate {float:left;font-weight:bold;color:#3062a4;}";
		mail_conts=mail_conts+"#mailContents .mailType {float:right;margin-bottom:10px;}";
		mail_conts=mail_conts+"#mailContents .mailType span {color:#e81b2e;}";
		mail_conts=mail_conts+"#mailContents .tWrite {clear:both;}";
		mail_conts=mail_conts+"#mailContents .bgAlt {text-indent:-5555px;height:128px;}";
		mail_conts=mail_conts+"#mailContents .whoIs {padding:12px 20px;font-weight:bold;margin-bottom:30px;}";
		mail_conts=mail_conts+"#mailContents .tWrite table {width:100%;}";
		mail_conts=mail_conts+"#mailContents .tWrite td {padding:20px; height:350px; vertical-align:top;}";
		mail_conts=mail_conts+"#mailContents .result {border-top:2px solid #1479c7;border-bottom:2px solid #e1e1e1; margin-bottom:20px;}";
		mail_conts=mail_conts+"#mailContents .copy {float:right; font-size:11px;}";

		mail_conts=mail_conts+".mB20 {margin-bottom:20px;}";
		mail_conts=mail_conts+"</style>";

		mail_conts=mail_conts+"<div id='mailWrap'>";
		mail_conts=mail_conts+"<h1><img src='"+mail_imgurl+"/form_mail/mail_logo.gif' alt='한국중부발전' /></h1>";
		mail_conts=mail_conts+"<div class='office'>"+CHARGE_NM+"</div>";
		mail_conts=mail_conts+"<div id='mailContents'>";
		mail_conts=mail_conts+"<div class='mailDate'>"+CHARGE_DATE+"</div>";
		mail_conts=mail_conts+"<p class='bgAlt'>대한민국 행복 발전소 power komipo</p>";
		mail_conts=mail_conts+"<p class='whoIs'>"+MAIL_SUBJECT+"</p>";
		mail_conts=mail_conts+"<div class='tWrite result '>";
		mail_conts=mail_conts+"<table class='tWrite_tpl' summary='안내 내용'>";
		mail_conts=mail_conts+"<caption>";
		mail_conts=mail_conts+"안내메일";
		mail_conts=mail_conts+"</caption>";
		mail_conts=mail_conts+"<tbody>";
		mail_conts=mail_conts+"<tr>";
		mail_conts=mail_conts+"<td scope='row'>"+MAIL_CONTENTS+"</td>";
		mail_conts=mail_conts+"</tr>";
		mail_conts=mail_conts+"</tbody>";
		mail_conts=mail_conts+"</table> ";
		mail_conts=mail_conts+"</div>";
		mail_conts=mail_conts+"<div class='copy'>COPYRIGHT(C) 2014 KOREA MIDDLAND POWER CO., LTD ALLRIGHT RESERVED.</div>";
		mail_conts=mail_conts+"</div>";
		mail_conts=mail_conts+"</div>";	
		return  mail_conts; 

	
	}		
	
	/***
	 * null를 ""으로 변환한다.
	 * @param str
	 * @return
	 */
	public static String nullToEmpty(String str) {
        if( str == null || str.equals(null) || "null".equals(str) ){
        	str = "";
        }

        return str;
    }
	
	/**
	 * 
	 * Method Name  : nullToDefault
	 * Description      :  null일 경우, 디폴트값을 반환  
	 * Comment        :  
	 * Parameter       : 
	 * form History    : 2015. 4. 22. : mrkim:  최초작성
	 * @param str
	 * @param defaultVal
	 * @return
	 */
	 public static String nullToDefault(String str,String defaultVal){
	   	 if (str == null || str.equals("")) 
	   	 	return defaultVal; 
	   	 else 
	   	 	return str;
	    }
	
	 /**
     * 
     * Method Name  : convertMultiSelectParam
     * Description      : 검색조건의 멀티셀렉트 검색에서 사용    
     * Comment        : 멀티셀렉트 검색을 위한 쿼리용 데이타로 변경
     * Parameter       : 
     * form History    : 2015. 3. 24. : mrkim:  최초작성
     * @param param
     * @param key
     * @return Map
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map convertMultiSelectParam(Map param, String key){
    	String selectedData = "";
    	
    	if(param.containsKey(key) && nullToEmpty((String)param.get(key))!="" ){
    		selectedData =  (String)param.get(key);
    	}
    	
    	if(!"".equals(selectedData)){
	    	String[] selectedArr = selectedData.split(",");
	    	
			String convertData = "";
			for(int i=0; i<selectedArr.length; i++){
				if(i!=0){ 
					convertData += "','"; 
				}
				convertData += selectedArr[i];
			}			
			param.put(key, convertData);
    	}
    	
    	return param;
    }
    
    /**
     * 
     * Method Name  : convertMultiSelectString
     * Description      : 멀티조회 조건을 위한 쿼리용 param처리 (IN 조건)    
     * Comment        : 멀티검색을 위한 쿼리용 데이타로 변경
     * Parameter       : 
     * form History    : 2015. 3. 24. : mrkim:  최초작성
     * @param keyStr
     * @return String
     */
	public static String convertMultiSelectString(String keyStr){
    	String convertData = "";    	
		if(!HtmlTag.isNull(keyStr)){	
			if(keyStr!=null){
		    	String[] keyStrArr = keyStr.split(","); 	
				
				for(int i=0; i<keyStrArr.length; i++){
					if(i!=0){ 
						convertData += "','"; 
					}
					convertData += keyStrArr[i];
				}				
			}

    	}
    	
    	return convertData;
    }

	 /**
     * 
     * Method Name  : comma
     * Description      : 1000단위로 콤마찍기   
     * Comment        : 1000단위로 콤마찍기
     * Parameter       : 
     * form History    : 2015. 3. 26. : sskang:  최초작성
     * @param num : 변환할 오브젝트
     * @return String
     */
	public static String comma(Object num){
		return comma(num,0);
	}

	/**
     * 
     * Method Name  : comma
     * Description      : 소수 자리수 지정  
     * Comment        : 소수 자리수 지정
     * Parameter       : 
     * form History    : 2015. 3. 26. : sskang:  최초작성
     * @param num : 변환할 오브젝트
	 * @param po : 자리수
     * @return String
     */
	public static String comma(Object num,int po){
		String str = String.valueOf(num);
		if(!"".equals(str)){


		    double _num = Double.parseDouble(str);
		    String range = "";
		    //소수점 로직 추가(소숫점 숫자가 있으면 출력)
		    for(int i=0;i<po;i++){
		    	if(i == 0) range +=".";
				range += "#";
			}
		    DecimalFormat df = new DecimalFormat("#,##0"+range);

	        return df.format(_num);
		}
		else{
			return "";
		}
	}
	
	/**
	 * 
	 * Method Name  : convertCarriageToBlank
	 * Description      : 개행문자를 공란으로 변경  
	 * Comment        :  개행문자를 공란으로 변경  ..
	 * Parameter       : 
	 * form History    : 2015. 3. 30. : mrkim:  최초작성
	 * @param val
	 * @return
	 */
	public static String convertCarriageToBlank( String val )
	{		

		val = val.replaceAll( "\\n", "" );
		val = val.replaceAll( "\\r", "" );	

		return val;
	}

	/**
	 * 
	 * Method Name  : convertHWPContent
	 * Description      : 한글에디터로 저장된 데이타의 화면 표시를 위한 데이타 변환  
	 * Comment        :  한글에디터로 저장된 데이타의 화면 표시를 위한 데이타 변환  
	 * Parameter       : 
	 * form History    : 2015. 3. 30. : mrkim:  최초작성
	 * @param fieldContent
	 * @return
	 */
	public static String convertHWPContent(Clob fieldContent){
				
		Reader reader = null;
		String hWPContent = "";
		try {
			if(!HtmlTag.isNull(fieldContent)){
				if(fieldContent!=null){
					reader = fieldContent.getCharacterStream();
					StringBuffer sb = new StringBuffer();
					char[] buff = new char[1024];
					int len=-1;
					
					while((len=reader.read(buff))!=-1){
						sb.append(buff,0,len);
					}
					hWPContent = convertCarriageToBlank(sb.toString());					
				}

			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.debug("convertCarriageToBlank ERROR : ");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.debug("convertCarriageToBlank ERROR : ");
		}	   
		
		return hWPContent ;
	}
	
	/**
	 * 
	 * Method Name  : convertHTMLContent
	 * Description      : 한글에디터로 저장된 데이타의 화면 표시를 위한 데이타 변환  
	 * Comment        :  한글에디터로 저장된 데이타의 화면 표시를 위한 데이타 변환  
	 * Parameter       : 
	 * form History    : 2015. 3. 30. : mrkim:  최초작성
	 * @param fieldContent
	 * @return
	 */
	public static String convertHTMLContent(Clob fieldContent){
				
		Reader reader = null;
		String HTMLContent = "";
		try {
			if(!HtmlTag.isNull(fieldContent)){
				if(fieldContent!=null){
					reader = fieldContent.getCharacterStream();
					StringBuffer sb = new StringBuffer();
					char[] buff = new char[1024];
					int len=-1;
					
					while((len=reader.read(buff))!=-1){
						sb.append(buff,0,len);
					}
					HTMLContent = sb.toString();					
				}

			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.debug("convertCarriageToBlank ERROR : ");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.debug("convertCarriageToBlank ERROR : ");
		}	   
		
		return HTMLContent ;
	}
	
	
	
	/**
	 * 
	 * Method Name  : getCurDateStr
	 * Description      : 현재 날짜를 주어진 날짜포멧에 맞춰 변환하여 반환    
	 * Comment        :  예) yyyymmdd
	 * Parameter       : 
	 * form History    : 2015. 3. 30. : mrkim:  최초작성
	 * @param formatStr
	 * @return
	 */
	public static String getCurDateStr(String formatStr) {
		 return new SimpleDateFormat(formatStr).format(new Date());
	}
	
	
	/**
	 * 
	 * Method Name  : logEncoding
	 * Description      : 현재 날짜를 주어진 날짜포멧에 맞춰 변환하여 반환    
	 * Comment        :  예) yyyymmdd
	 * Parameter       : 
	 * form History    : 2015. 3. 30. : mrkim:  최초작성
	 * @param formatStr
	 * @return
	 */
	public static void logEncoding(String str) {
		try {
			log.debug("orgstr :"+str);
			log.debug("utf-8-> euc-kr : "+new String(str.getBytes("utf-8"))+"->"+new String(str.getBytes("utf-8"),"euc-kr"));
			log.debug("utf-8-> ksc5601 :"+new String(str.getBytes("utf-8"),"ksc5601"));
			log.debug("utf-8-> MS949 :"+new String(str.getBytes("utf-8"),"MS949"));
			log.debug("utf-8-> 8859_1 :"+new String(str.getBytes("utf-8"),"8859_1"));
			log.debug("utf-8-> ascii :"+new String(str.getBytes("utf-8"),"ascii"));
			
			
			log.debug("8859_1-> euc-kr : "+new String(str.getBytes("8859_1"))+"->"+new String(str.getBytes("8859_1"),"euc-kr"));
			log.debug("8859_1-> ksc5601 :"+new String(str.getBytes("8859_1"),"ksc5601"));
			log.debug("8859_1-> MS949 :"+new String(str.getBytes("8859_1"),"MS949"));
			log.debug("8859_1-> utf-8 :"+new String(str.getBytes("8859_1"),"utf-8"));
			log.debug("8859_1-> ascii :"+new String(str.getBytes("8859_1"),"ascii"));
			
			log.debug("euc-kr-> 8859_1 : "+new String(str.getBytes("euc-kr"))+"->"+new String(str.getBytes("euc-kr"),"8859_1"));
			log.debug("euc-kr-> ksc5601 :"+new String(str.getBytes("euc-kr"),"ksc5601"));
			log.debug("euc-kr-> MS949 :"+new String(str.getBytes("euc-kr"),"MS949"));
			log.debug("euc-kr-> utf-8 :"+new String(str.getBytes("euc-kr"),"utf-8"));
			log.debug("euc-kr-> ascii :"+new String(str.getBytes("euc-kr"),"ascii"));
			
			log.debug("ksc5601-> 8859_1 : "+new String(str.getBytes("ksc5601"))+"->"+new String(str.getBytes("ksc5601"),"8859_1"));
			log.debug("ksc5601-> euc-kr :"+new String(str.getBytes("ksc5601"),"euc-kr"));
			log.debug("ksc5601-> MS949 :"+new String(str.getBytes("ksc5601"),"MS949"));
			log.debug("ksc5601-> utf-8 :"+new String(str.getBytes("ksc5601"),"utf-8"));	
			log.debug("ksc5601-> ascii :"+new String(str.getBytes("ksc5601"),"ascii"));
			
			log.debug("MS949-> 8859_1 : "+new String(str.getBytes("MS949"))+"->"+new String(str.getBytes("MS949"),"8859_1"));
			log.debug("MS949-> euc-kr :"+new String(str.getBytes("MS949"),"euc-kr"));
			log.debug("MS949-> ksc5601 :"+new String(str.getBytes("MS949"),"ksc5601"));
			log.debug("MS949-> utf-8 :"+new String(str.getBytes("MS949"),"utf-8"));	
			log.debug("MS949-> ascii :"+new String(str.getBytes("MS949"),"ascii"));
			
			log.debug("testEncoding MS949:"+testEncoding(str,"MS949"));
			log.debug("testEncoding UTF-8:"+testEncoding(str,"UTF-8"));
			log.debug("testEncoding CP933:"+testEncoding(str,"CP933"));
			log.debug("testEncoding EUC-KR:"+testEncoding(str,"EUC-KR"));
			

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			
		} catch (Exception e) {
			log.debug("지원되지않는 인코딩");
		}
	}	
	
	public static String convert(String str, String encoding) throws IOException {
		  ByteArrayOutputStream requestOutputStream = new ByteArrayOutputStream();
		  requestOutputStream.write(str.getBytes(encoding));
		  return requestOutputStream.toString(encoding);
	}

	public static String testEncoding(String str, String encoding) throws IOException {
		  String result = convert(str, encoding);
		  log.debug(result + "=>encoding=" + encoding + ",length=("
		    + result.getBytes(encoding).length + ")");
		  return result;
	}	
	
	
	/**
	 * 
	 * Method Name  : readExcel
	 * Description      : 엑셀업로드시 엑셀파일 데이타 변환  
	 * Comment        :  엑셀업로드시 엑셀파일 데이타 변환  
	 * Parameter       : 
	 * form History    : 2015. 4. 20. : sskang:  최초작성
	 * @param fieldContent
	 * @return
	 */
	public static List readExcel (File xlsxFile, int sheetNum, int rowStart, int cellNum) throws Exception
	{
		List sheetList =new ArrayList();
	
		FileInputStream fis = null;
	
		log.info("xlsxFile==>"+xlsxFile);
		
		try{
			fis = new FileInputStream(xlsxFile);
			Workbook workbook = WorkbookFactory.create(fis);
			FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
			
			//for(int i=0; i<sheetcnt; i++){
				Sheet sheet = workbook.getSheetAt(sheetNum);
			
				int rows = sheet.getPhysicalNumberOfRows();
			
				log.info(" ########### Excel Upload Start ########### ");
				
				for(int j=rowStart; j<rows; j++){
					Row row = sheet.getRow(j);
					
					log.info("------ "+ j + " rows ------");

					if(row==null){ 
						log.info("row is null");
						continue;
					}
			
					int cells = cellNum>0?cellNum:row.getPhysicalNumberOfCells();
			
					HashMap<Object, Object> cellMap = new HashMap<Object, Object>();
					
					int index = 0;
					for(int k=0; k<= cells; k++) {
						Cell cell = row.getCell(k);

						if(cell==null)  {
							cellMap.put(index++, "");
							log.info("[" + k + "] : is cell null => " + cellMap.get(index-1));
							continue;
						}
						switch(cell.getCellType()){
							case	Cell.CELL_TYPE_BLANK :
								cellMap.put(index++, "");
							break;
							
							case Cell.CELL_TYPE_BOOLEAN :
								cellMap.put(index++, cell.getBooleanCellValue());
							break;
							
							case Cell.CELL_TYPE_ERROR :
								cellMap.put(index++, cell.getErrorCellValue());
							break;
							
							case Cell.CELL_TYPE_FORMULA :
								cellMap.put(index++, cell.getCellFormula());
								/*CellValue cellvalue = evaluator.evaluate(cell);
								if(cellvalue.getCellType()==Cell.CELL_TYPE_BOOLEAN){
									cellMap.put(index++, cellvalue.getBooleanValue()+"");
								}else if(cellvalue.getCellType()==Cell.CELL_TYPE_NUMERIC){
									cellMap.put(index++, cellvalue.getNumberValue()+"");
								}else if(cellvalue.getCellType()==Cell.CELL_TYPE_STRING){
									cellMap.put(index++, cellvalue.getStringValue()+"");									
								}*/

							break;
							
							case Cell.CELL_TYPE_STRING :
								cellMap.put(index++, cell.getStringCellValue());								
								break;
								
							case Cell.CELL_TYPE_NUMERIC :
								if (DateUtil.isCellDateFormatted(cell)) {
		                        	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		                        	cellMap.put(index++, formatter.format(cell.getDateCellValue()));									
								} else {
//									cellMap.put(index++, cell.getNumericCellValue());
									cellMap.put(index++, NumberToTextConverter.toText(cell.getNumericCellValue()));
									
								}
							break;
							
							
							default :
								cellMap.put(index++, "");
							break;
						}
						
						log.info("[" + k + "] : " + cellMap.get(index-1));
					}
					
					sheetList.add(cellMap);
				}
				//sheetList.add(rowList);
				log.info(" ########### Excel Upload End ########### ");
			//}
		} catch (InvalidFormatException e){
			log.debug("readExcel InvalidFormatException ERROR : ");
		} catch (FileNotFoundException e){
			log.debug("readExcel FileNotFoundException ERROR : ");
		} catch (IOException e){
			log.debug("readExcel IOException ERROR : ");
		} finally {
			if(fis!=null) {
				try {
					fis.close();
				} catch (IOException e){
					log.debug("readExcel IOException ERROR : ");
				}
			}
		}
		return sheetList;	
	}
	
	//해쉬암호화 (SHA-256) 단방향암호화
	public static String encode(String message) throws NoSuchAlgorithmException{
		return encode(message,"SHA-256");
	}
	
	//해쉬암호화 처리
	public static String encode(String message, String algorithm) throws NoSuchAlgorithmException{
		MessageDigest md=null;
		String out = "";
		
		if(algorithm==null || algorithm.equals("")){
			algorithm="SHA-256";
		}
		
		try{
			md=MessageDigest.getInstance(algorithm);
			md.update(message.getBytes());
			byte[] mb=md.digest();
			
			for(int i=0;i<mb.length;i++){
				byte temp = mb[i];
				String s=Integer.toHexString(new Byte(temp));
				while(s.length()<2){
					s="0"+s;
				}
				s=s.substring(s.length()-2);
				out+=s;
				
				if(out.length()>8){
					break;
				}
			}
			
		}catch(NoSuchAlgorithmException e){
			log.debug("encode ERROR : ");
			
		}
		return out;
	}
	
	/**
	 * 대상데이타가 지정된 배열에 포함되어 있는지 비교 판단 -mr317.kim (2015/08/18)
	 * Method Name  : isTargetValInArray
	 * Description      :    있으면 true, 없으면 false를 반환 
	 * Comment        :  
	 * Parameter       : 
	 * form History    : 2015. 8. 18. : mrkim:  최초작성
	 * @param targetVal
	 * @param valArr
	 * @return
	 */
	public static boolean isTargetValInArray(String targetVal, String[] valArr){
		boolean checkFlag = false;
		targetVal = targetVal.trim();

		if(!HtmlTag.isNull(targetVal)){
		    for (int i = 0; i < valArr.length; i++){
		    	if(targetVal.toUpperCase().equals((valArr[i].trim()).toUpperCase())){
		    		checkFlag = true;
		    		break;
		    	}
		    }
		}
		return checkFlag;
	}
	
	/**
	 * 배열 중 가장 큰 값 반환
	 * Method Name  : getMaxDataInArr
	 * Description      :    
	 * Comment        :  
	 * Parameter       : 
	 * form History    : 2015. 8. 25. : mrkim:  최초작성
	 * @param arr
	 * @return
	 */
	public static String getMaxDataInArr(ArrayList list){
		String temp = new String("0");		
		
		if(list.size()>0){
			int arrSize = list.size();
			for(int i=0;i<arrSize;i++){
				String val = CM_Util.nullToDefault( (String)list.get(i), "0");
				if(Integer.parseInt(temp) < (Integer.parseInt(val))){
					temp = val;
				}
				
			}
		}
		return temp;
	}
	
	/**
	 * HttpServletRequest에서 URL추출
	 * Method Name  : OriginGetURL
	 * Description      :    
	 * Comment        :  
	 * Parameter       : 
	 * form History    : 2018. 11. 23. : 이금용:  최초작성
	 * @param HttpServletRequest
	 * @return String
	 */	
	public static String OriginGetURL(HttpServletRequest request){
		
		Enumeration<?> param = null;
		
	    StringBuffer strParam = new StringBuffer();
	    StringBuffer strURL = new StringBuffer();
	    
		if(request!=null){
			 param = request.getParameterNames();
			 UrlPathHelper urlPathHelper = new UrlPathHelper(); 
			 String originalURL = urlPathHelper.getOriginatingRequestUri(request);
			 if(originalURL==null){
				 originalURL = "/";
			 }
			    
			 if(param!=null){
				    if (param.hasMoreElements())
				    {
				      strParam.append("?");
				    }

				    while (param.hasMoreElements())
				    {
				      String name = (String) param.nextElement();
				      String value = request.getParameter(name);

				      strParam.append(name + "=" + HtmlTag.StripStrInXss(value).replaceAll("\n","").replaceAll("\r",""));

				      if (param.hasMoreElements())
				      {
				        strParam.append("&");
				      }
					}
  

				    strURL.append(originalURL);
				    strURL.append(strParam);				 
			 }else{
				 strURL.append(originalURL);
			 }
			
		}else{
			strURL = new StringBuffer("");
		}
	   

	  return strURL.toString();
	}	
}
