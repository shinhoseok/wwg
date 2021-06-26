/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.HtmlText.java
 * Description        : HtmlText처리에 관련된 다수의 기능을 제공하는 클래스.
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : 이금용
 * Updated content    : 패키지명 변경
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class HtmlText{
	/**
	 * 현재 클래스에 대한 로그를 처리하는 변수
	 *
	 * @see org.apache.commons.logging.Log
	 * @see org.apache.commons.logging.LogFactory
	 */
	private static Log log = LogFactory.getLog(HtmlText.class);
	
	static int charWidth = 11;
	static int koCharWidth = 15;
	static int EnUpCharWidth = 10;
	static int EnLoCharWidth = 8;
	static int digitCharWidth = 6;
	static int anotherCharWidth = 4;


	public static int getListHeight(){
		return 20;
	}
	
	public static int parseStoftoi(String str){
		// TODO parseStoftoi
		return Math.round(Float.parseFloat(HtmlTag.returnString(str,"0")));
	}
	/**
	 * Integer 형 데이터를 int형 데이터로 리턴
	 * @param itg
	 * @return
	 */
	public static int parseItoi(Integer itg){
		// TODO StoItoi
		return itg.intValue();
	}	

	public static String parseChar(String str, int width){
		// TODO parseChar
		int lenSum = 0;
		char[] chars = str.toCharArray();
		char[] temp = new char[chars.length];
		
		for(int i=0;i<chars.length;i++){
			if(Character.isDigit(chars[i])){
				lenSum+=digitCharWidth;
				temp[i] = chars[i];
				//log.debug("digit : "+temp[i]+","+lenSum);
			}
			else if(Character.isLetter(chars[i])){
				if(Character.isUpperCase(chars[i])){
					lenSum+=EnUpCharWidth;
					temp[i] = chars[i];
					//log.debug("up case : "+temp[i]+","+lenSum);
				}
				else if(Character.isLowerCase(chars[i])){
					lenSum+=EnLoCharWidth;
					temp[i] = chars[i];
					//log.debug("lo case : "+temp[i]+","+lenSum);
				}
				else{
					lenSum+=koCharWidth;
					temp[i] = chars[i];
					//log.debug("kor : "+temp[i]+","+lenSum);
				}
			}
			else{
				lenSum+=anotherCharWidth;
				temp[i] = chars[i];
				//log.debug("else : "+temp[i]+","+lenSum);
			}

			if(lenSum>width){
				return new String(temp).trim()+"...";
			}
		}

		return new String(temp).trim();
	}

	public static String substring(String str, int width){
		// TODO substring
		String text = "";
		int w = width/charWidth;

		if(str!= null){
			text = str.trim();
			if(text.length()>w){
				return parseChar(text, width);
			}
		}

		return text;
	}

	public static String substring(String str, String str1, int width){
		// TODO substring
		String text = "";
		int w = width/charWidth;

		if(str!= null && str1!=null){
			text = str.trim()+"("+str1.trim()+")";
			if(text.length()>w){
				return parseChar(text, width);
			}
		}
		else if(str!= null){
			text = str.trim();
			if(str.length()>w){
				return parseChar(text, width);
			}
		}
		else if(str1!=null){
			text = "("+str1.trim()+")";
			if(text.length()>w){
				return parseChar(text, width);
			}
		}

		return text;
	}

	public static String getDescription(String desc){
		// TODO getDescription
		String description = "";

		if(desc!= null){
			description = desc.trim();
			/*
			StringTokenizer st	= new StringTokenizer(desc);
			StringBuffer buffer	= new StringBuffer();

			while (st.hasMoreTokens()) {
				buffer.append(st.nextToken("\r"));
				buffer.append("<br>");
			}
			*/
		}

		return description;
	}

	/**
	* yn의 값에 따라 Y/N 문자열을 리턴한다.
	* <br>
	* yn이 1인 경우 Y<br>
	* 0인 경우 N<br>
	* <br>
	*
	* @param	yn Y/N 여부
	* @return	String yn에 대응되는 문자열
	*/
	public static String getYn(String yn){
		// TODO getYn
		String ynstr = "";

		if("0".equals(yn)) ynstr = "N";
		else if("1".equals(yn)) ynstr = "Y";

		return ynstr;
	}

	/**
	* yn의 값에 따라 ratio버튼에 checked 값을 리턴한다.
	* <br>
	* yn이 1인 경우 check
	* <br>
	*
	* @return String 
	*/
 	public static String getRadioChecked(String yn){
 		// TODO getRadioChecked
 		String ynstr = "";
 
         if("1".equals(yn)) ynstr = "checked";
 
 		return ynstr;
 	}

	public static String getRadioChecked(String yn,String parm ){
		// TODO getRadioChecked
 		String ynstr = "";
         if(yn == null) return ynstr;

         if(parm.equals(yn)) ynstr = "checked";
 
 		return ynstr;
 	}
	
    // 입력된 숫자를 가지고 kb또는 Mb로표현	
	public static String File_SizeStr(String sizestr) throws  NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		// TODO File_SizeStr
		String sizeStr = "";
		try{
			
		    double sizeL = Long.parseLong(sizestr,10);
		    if( sizeL < 1024 ) sizeStr = sizestr + "b";
		    else if( sizeL < 1024*1024 ) sizeStr = Math.ceil( sizeL/1024 ) + "KB";
		    else sizeStr = Math.ceil( sizeL/(1024*1024) ) + "MB";
		}catch(NullPointerException e){
			log.debug("File_SizeStr::"+sizestr);
			throw new JSysException("File_SizeStr:");		
		}catch(ArrayIndexOutOfBoundsException e){
			log.debug("File_SizeStr::"+sizestr);
			throw new JSysException("File_SizeStr:");		
		}catch(Exception e){
			log.debug("File_SizeStr::"+sizestr);
			throw new JSysException("File_SizeStr:");
		}
		return sizeStr;
 	}	

	/**
	* 컬럼/속성의 데이터 타입을 표현하는 문자열을 리턴한다..
	* <br>
	* 타입이 NUNERIC일 경우 NUMERIC(10,6) <br>
	* 다른 타입일 경우 CHAR(10)로 출력한다<br>
	*
	* @param type 데이터타입
	* @param presnLen 유효길이
	* @param scaleLen 소수길이
	* @return String 데이터 타입을 나타내는 문자열
	*/
	public static String getColumnType(String type, long presnLen, long scaleLen){
		// TODO getRelationNo
		String colType = "";

		if(type==null) return colType;

		if(type.startsWith("DEC") || type.startsWith("NUMBER") || type.startsWith("NUMERIC")){
			colType = type+"("+presnLen+","+scaleLen+")";
		}
		// data_tp_sort : B1
		else if(type.startsWith("BINARY") || type.startsWith("VARBINARY")){
			colType = type+"("+presnLen+")";
		}
		// data_tp_sort : C1
		else if(type.startsWith("CHAR") || type.startsWith("VARCHAR")){
			colType = type+"("+presnLen+")";
		}
		// data_tp_sort : C4
		else if(type.startsWith("NCHAR") || type.startsWith("NVARCHAR")){
			colType = type+"("+presnLen+")";
		}
		else{
			colType = type;
		}

		return colType;
	}


	/**
	* 엔티티/속성의 관계수를 표현하는 문자열을 리턴한다.
	* <br>
	*
	* @param	source 상위옵션/관계수
	* @return	String 관계수를 표현하는 문자열
	*/
	public static String getRelationNo(String source){
		// TODO getRelationNo
		if(source != null && source.charAt(0) == '0'){
			String source1 = source.replace('0','Y');		
			String source2 = source1.replace(',','/');		
			return source2;
		}
		else if(source != null){
			String source3 = "N/"+source;
			return source3;
		}
		else{
			return source;
		}
	}

	/**
	 * Method replace
	 * @param mainString
	 * @param oldString
	 * @param newString
	 * @return String
	 */
	public static String replace(
  	    String mainString,
		String oldString,
		String newString) {
		// TODO replace
		if (mainString == null) {
			return null;
		}
		if (oldString == null || oldString.length() == 0) {
			return mainString;
		}
		if (newString == null) {
			newString = "";
		}

		int i = mainString.lastIndexOf(oldString);
		if (i < 0)
			return mainString;

		StringBuffer mainSb = new StringBuffer(mainString);

		while (i >= 0) {
			mainSb.replace(i, (i + oldString.length()), newString);
			i = mainString.lastIndexOf(oldString, i - 1);
		}
		return mainSb.toString();
	}	
	
	public static String [] split(String orgstr, String expr){
		String [] resstr = null;
		String tmp_str = ""; 
		String tmp_str2 = "";
		int i = 0;
		int tmp_int = 0;
		int idx_cnt = 0;
		// 구분자의 갯수를 센다
		  while(i < orgstr.length()){
		     tmp_str = orgstr.substring(i,i+1);
		       if(tmp_str.equals(expr)){
		           tmp_int = tmp_int+1;
		       }
		       i=i+1;
		  }	
		  if(tmp_int==0){
			  resstr = orgstr.split(expr);
		  }else{
			  resstr = orgstr.split(expr,tmp_int+1);
		  }

		return resstr;
	}
	
	/**
	* 리스트 리턴한다.chpark
	* @param	String
	* @return	list 
	*/
	public static ArrayList<String> iterateQueryParam(String param){
		String [] _key = HtmlTag.returnString(param,"").split(",");
		ArrayList<String> Key = new ArrayList<String>();
			for(int i=0;i<_key.length;i++){
				Key.add(_key[i]);
			}
			return Key;
	}
	
	public static ArrayList<String> iterateQueryParam2(String param,String spstr){
		String [] _key = HtmlTag.returnString(param,"").split(spstr);
		ArrayList<String> Key = new ArrayList<String>();
			for(int i=0;i<_key.length;i++){
				Key.add(_key[i]);
			}
			return Key;
	}	
	
	public static String [] split2(String orgstr, String expr){
		String [] resstr = null;
		String tmp_str = ""; 
		String tmp_str2 = "";
		List tmp_list = new ArrayList();
		int i = 0;
		int tmp_int = 0;
		int idx_cnt = 0;
		// 구분자의 갯수를 센다
		tmp_str = orgstr;
		for(i=0;i<orgstr.length();){
			if(tmp_str.indexOf(expr) < 0){
				break;
			}
			tmp_int = tmp_str.indexOf(expr);
			//log.debug("======================"+idx_cnt+":"+tmp_str);
			//log.debug("======================"+idx_cnt+":"+tmp_str.substring(0, tmp_str.indexOf(expr)));
			tmp_list.add(tmp_str.substring(0, tmp_str.indexOf(expr)));
			tmp_str = tmp_str.substring(tmp_str.indexOf(expr)+(expr.length()), tmp_str.length());
			//log.debug("======================"+idx_cnt+":"+tmp_str);
			idx_cnt++;
			i=i+(tmp_int+(expr.length()));
			//log.debug("======================"+idx_cnt+":=============:"+i);
		}
		//log.debug("최종문자열:"+tmp_str+":"+tmp_str.length()+":"+tmp_str.equals(""));
		if(tmp_str.equals("")){
			tmp_list.add("");
		}else{
			tmp_list.add(tmp_str);
		}
		 //log.debug("배열갯수:"+tmp_list.size());
	
		resstr = new String[tmp_list.size()];
		for(i=0;i<tmp_list.size();i++){
			if(tmp_list.get(i)==null){
				resstr[i] = "";
			}else{
				resstr[i]=(String)tmp_list.get(i);
			}
		}
		//log.debug("배열갯수:"+resstr.length);
		//for(i=0;i<resstr.length;i++){
		//	log.debug("최종배열:"+i+":"+resstr[i]);
		//}

		return resstr;
	}	
	
    /***
     * 문자열 중 HTML 특수기호인 문자를 HTML특수기호 로 대체한다.
     * @param htmlstr
     * @return
     */
    public static String replaceHtml(String htmlstr) {
		String convert = new String();
		convert = replaceHtmlChars(htmlstr, "<", "&lt;");
		convert = replaceHtmlChars(convert, ">", "&gt;");
		convert = replaceHtmlChars(convert, "\"", "&quot;");
		convert = replaceHtmlChars(convert, "&nbsp;", "&amp;nbsp;");
		return convert;
	}
    
    /***
     * 문자열중 지정한 문자열을 찾아서 새로운 문자열로 대체한다.
     * @param original - 대상 문자열
     * @param oldstr   - 찾을 문자열
     * @param newstr   - 바꿀 문자열
     * @return
     */
	public static String replaceHtmlChars(String original, String oldstr, String newstr)	{
		String convert = new String();
		int pos   = original.indexOf(oldstr);
		int begin = 0;
	
		if(pos == -1) return original;
	
		while(pos != -1) {
			convert = convert + original.substring(begin, pos) + newstr;
			begin   = pos + oldstr.length();
			pos     = original.indexOf(oldstr, begin);
		}
		
		convert = convert + original.substring(begin);
	
		return convert;
	}
}
