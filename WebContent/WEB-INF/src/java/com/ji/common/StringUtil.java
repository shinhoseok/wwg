/*===================================================================================
 * System             : Jrinfo Library �����
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.StringUtil.java
 * Description        : 臾몄��댁�由ъ� 愿�����ㅼ���湲곕�����났��� �대���
 * Author             : �닿���
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : �닿���
 * Updated content    : �⑦�吏�� 蹂�꼍
 *        			1) 'rplc' 硫����� JDK 1.4 踰�� 遺������� ���.
  	        		2) ��� comments泥�━��method��commons-lang.jar��dependency 
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.sql.Clob;
import java.util.Random;
import java.util.regex.Pattern;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 * String ��愿�� Utility �대���
 * 
 * @version 1.0
 * @author 
 */
public class StringUtil {
	
	protected static Logger log = Logger.getLogger(StringUtil.class); //현재 클래스 이름을 Logger에 등록
	
	public static String rplc(String str, String pattern, String replace) { 
        int s = 0;
        int e = 0;
        StringBuffer result = new StringBuffer();
        
        while ((e = str.indexOf(pattern, s)) >= 0) { 
            result.append(str.substring(s, e)); 
            result.append(replace); 
            s = e + pattern.length(); 
        } 
        result.append(str.substring(s)); 
        return result.toString(); 
    }
	
	/**
	   * BASE64 Encoder
	   * 
	   * @param str
	   * @return
	   * @throws java.io.IOException
	   */
//	  public static String base64Encode(String str) {
//	    String result = "";
//	    sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder(); 
//	    byte[] b1 = str.getBytes();
//	    result = encoder.encode(b1);
//	    return result;
//	  }

	  /**
	   * BASE64 Decoder
	   * 
	   * @param str
	   * @return
	   * @throws java.io.IOException
	   */
//	  public static String base64Decode(String str) {
//	    String result = "";
//	    try {
//	      sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
//	      byte[] b1 = decoder.decodeBuffer(str);
//	      result = new String(b1);
//	    } catch(NullPointerException e){
//			log.debug("NullPointerException");	      
//	    } catch (IOException ex) {
//	    	log.debug("IOException");
//	    }
//	    return result;
//	  } 
	  
	  /**
	   * Base64Encoding 諛⑹��쇰� 諛����諛곗��������臾몄��대� �몄��⑺��� 
	   * In-Binany, Out-Ascii
	   * 
	   * @param encodeBytes  �몄��⑺� 諛����諛곗�(byte[])
	   * @return  �몄��⑸� �����臾몄���String)
	   */
//	 public static String base64Encode2(String str) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
//	   byte[] buf = null;
//	   String strResult = null;
//	   byte[] b1 = str.getBytes();
//	   sun.misc.BASE64Encoder base64Encoder = new sun.misc.BASE64Encoder();
//	   ByteArrayInputStream bin = new ByteArrayInputStream(b1);
//	   ByteArrayOutputStream bout = new ByteArrayOutputStream();
//	   
//	   try {
//	    base64Encoder.encodeBuffer(bin, bout);
//	   } catch(NullPointerException e){
//		   log.debug("NullPointerException");
//
//	   } catch(ArrayIndexOutOfBoundsException e){
//		   log.debug("ArrayIndexOutOfBoundsException");	
//	   } catch (Exception e) {
//		   log.debug("Exception");
//	   }
//	   buf = bout.toByteArray();
//	   if(buf!=null){
//		   strResult = new String(buf).trim();
//	   }else{
//		   strResult = "";
//	   }
//	   
//	   return strResult;
//	 }



	 /**
	   * Base64Decoding 諛⑹��쇰� �����臾몄��댁� 諛����諛곗�濡�����⑺��� 
	   * In-Ascii, Out-Binany
	   * 
	   * @param  strDecode ����⑺� �����臾몄���String)
	   * @return  ����⑸� 諛����諛곗�(byte[])
	   */
//	 public static byte[] base64Decode2(String strDecode) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
//	   byte[] buf = null;
//	   
//	   sun.misc.BASE64Decoder base64Decoder = new sun.misc.BASE64Decoder();
//	   ByteArrayInputStream bin = new ByteArrayInputStream(strDecode.getBytes());
//	   ByteArrayOutputStream bout = new ByteArrayOutputStream();
//
//	   try {
//	    base64Decoder.decodeBuffer(bin, bout);
//	   } catch(NullPointerException e){
//		   log.debug("NullPointerException");
//	
//	   }catch(ArrayIndexOutOfBoundsException e){
//		   log.debug("ArrayIndexOutOfBoundsException");
//
//	   }catch (Exception e) {
//		   log.debug("Exception");
//
//	   }
//	   buf = bout.toByteArray();
//	   return buf;
//	 }

	 /*諛���몃���� 臾몄�����Ⅴ湲����源⑥����)
	  */
	 public static String strCut(String szText, int nLength)
	 { // 臾몄�����Ⅴ湲�
	  String r_val = szText;
	  int oF = 0, oL = 0, rF = 0, rL = 0;
	  int nLengthPrev = 0;
	  try
	  {
	   byte[] bytes = r_val.getBytes("UTF-8"); // 諛���몃� 蹂닿�
	   // x遺�� y湲몄�留�� ����몃�. �����묠吏��.
	   int j = 0;
	   if (nLengthPrev > 0)
	    while (j < bytes.length)
	    {
	     if ((bytes[j] & 0x80) != 0)
	     {
	      oF += 2;
	      rF += 3;
	      if (oF + 2 > nLengthPrev)
	      {
	       break;
	      }
	      j += 3;
	     }
	     else
	     {
	      if (oF + 1 > nLengthPrev)
	      {
	       break;
	      }
	      ++oF;
	      ++rF;
	      ++j;
	     }
	    }
	   j = rF;
	   while (j < bytes.length)
	   {
	    if ((bytes[j] & 0x80) != 0)
	    {
	     if (oL + 2 > nLength)
	     {
	      break;
	     }
	     oL += 2;
	     rL += 3;
	     j += 3;
	    }
	    else
	    {
	     if (oL + 1 > nLength)
	     {
	      break;
	     }
	     ++oL;
	     ++rL;
	     ++j;
	    }
	   }
	   r_val = new String(bytes, rF, rL, "UTF-8"); // charset �듭�
	  }
	  catch (UnsupportedEncodingException e)
	  {
		  log.debug("UnsupportedEncodingException");
	  }
	  catch (Exception e)
	  {
		  log.debug("strcut Exception:"+e);		  
	  }
	  
	  return r_val;
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
		
		
		 /***
			 * egovmap를 grid변수명으로 변환한다.
			 * @param str
			 * @return
			 */		
	public static String egovmapToGrid(String str){	

		String repStr = "";

        Pattern p = Pattern.compile("[A-Z]{1}");
        java.util.regex.Matcher m = p.matcher(str);
         int cnt = 0;

         while (m.find()) {
             repStr = m.replaceFirst("_"+m.group().toLowerCase());
             m = p.matcher(repStr);

            //log.debug("repCnt : " + cnt + " / repStr : " + repStr);

            cnt++;
         }
         
         if(cnt == 0 || repStr.equals("")){
        	 repStr = str;
         }
         //log.debug("str : " + str + " / repStr : " + repStr);
         return repStr;
	}
	
	 /*
	  * String 배열에 저장된 값 중 매개변수로 받은 key값과 동일한 값 검색하여 출력 만약 검색 결과가 없을 경우에는
	  * "검색 결과가 없습니다."라는 문구 출력
	  */
	 public static boolean searchData(String [] data, String key) {
		 boolean rtn_bl = false;
		 int cnt = 0;
	 	for (int i = 0; i < data.length; i++) {
	 		if (null != data[i]) {
	 			if (data[i].equals(key)) {
	 				cnt++;
	 				//log.debug(i + "번째에 존재합니다.");
	 			}
	 		}
	 	}
	 	if (cnt == 0) {
	 		return false;
	 	}else{
	 		return true;
	 	}
	 }	
	 
	 /*
	  * 정수형 범위에서 랜덤값을 출력
	  */
	 /*public static int javaRandom(int minint, int maxint) {
		 double dbl_ranval = Math.random();
		 int int_ranval = (int)(dbl_ranval * maxint) + 1;
		 return int_ranval;
	 }*/	 

	 public static int javaRandom(int minint, int maxint) {
		 java.util.Random r = new Random();
		 int int_ranval = r.nextInt(maxint - minint + 1) + minint;
		 return int_ranval;
	 }	
	/*=================================================================*/
	/*== �����common-lang.jar��dependency瑜�媛����遺�� ============*/
	/*=================================================================*/
	
	public static String deleteLastNewLine(String str) {
		return StringUtils.chomp(str);
	}
	
	  public static int countMatches(String str, String sub) {
	   return StringUtils.countMatches(str, sub);
	 }
	
	  public static String deleteSpace(String str) {
		return StringUtils.deleteWhitespace(str);
	  }
	
	  public static boolean isAlpha(String str) {
		return StringUtils.isAlpha(str);
	  }
	
	  public static boolean isAlphanumeric(String str) {
		return StringUtils.isAlphanumeric(str);
	  }
	
	  public static boolean isAlphanumericSpace(String str) {
		return StringUtils.isAlphanumericSpace(str);
	  }
	
	  public static boolean isAlphaSpace(String str) {
		return StringUtils.isAlphaSpace(str);
	  }
	
	  public static boolean isEmpty(String str) {
	   return StringUtils.isEmpty(str);
	 }
	
	 public static boolean isNumeric(String str) {
	   return StringUtils.isNumeric(str);
	 }
	
	 public static boolean isNumericSpace(String str) {
	   return StringUtils.isNumericSpace(str);
	 }
	
	 public static String repeat(String str, int repeat) {
	   return StringUtils.repeat(str, repeat);
	 }
	
	 public static String replace(String text, String repl, String with) {
	   return StringUtils.replace(text,repl, with);
	 }
	
	 public static String reverse(String str) {
	   return StringUtils.reverse(str);
	 }
	
	 public static String[] split(String str, String separatorChars) {
	   return StringUtils.split(str, separatorChars);
	 }
	
	 public static String strip(String str) {
		return StringUtils.strip(str);
	 }
	
	 public static String[] stripAll(String[] strs) {
		return StringUtils.stripAll(strs);
	 }
	
	 public static String substring(String str, int start, int end) {
		return StringUtils.substring(str, start, end);
	 }
	
	 public static String substring(String str, int start) {
		return StringUtils.substring(str, start);
	 }
	
	 public static String swapCase(String str) {
	    return StringUtils.swapCase(str);
	  }
	
	   /*
	    * Clob 를 String 으로 변경
	    */
	   public static String clobToString(Clob clob) throws Exception, IOException {

		   if (clob == null) {
			   return "";
		   }

		   Reader reader = clob.getCharacterStream();   
		      char[] char_array = new char [(int)(clob.length())];
		      //int rcnt = reader.read(char_array);

		      String contents = (new String(char_array));

		      reader.close();
		      
			return contents;
		   
		   /*StringBuffer strOut = new StringBuffer();

		   String str = "";

		   BufferedReader br = new BufferedReader(clob.getCharacterStream());

		   while ((str = br.readLine()) != null) {
			   strOut.append(str);
		   }
		   return strOut.toString();*/
	   }

		/**
		   * RPAD 함수 - 우측에 자릿수 채우기
		   * 
		   * @param str 대상문자열
		   * @param len 길이
		   * @param addStr 대체문자
		   * @return result
		   * @throws java.io.IOException
		   */
		  public static String rpad(String str, int len, String addStr) {
			  
			  	String result = str;
		    	
				try {
					
					
			    	int templen = len - result.getBytes("EUC-KR").length;

					for(int i=0; i<templen; i++){
						result = result+addStr;
					}
					
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					
					log.debug("IOException occurred");
				}

		    return result;
		  }	   
		  
		/**
		   * charChg 함수 - 문자열변환
		   * 
		   * @param str 대상문자열
		   * @param fchr 원본 케릭터셋
		   * @param tchr 변환할 케릭터셋
		   * @return result
		   * @throws UnsupportedEncodingException 
		   */
		  public static String charChg(String str, String fchr, String tchr) throws UnsupportedEncodingException{
			  String char_result = str;
			  CharBuffer cbuffer = CharBuffer.wrap((new String(char_result.getBytes(fchr), fchr)).toCharArray());
			  Charset charset = Charset.forName(tchr);
			  ByteBuffer bbuffer = charset.encode(cbuffer);
			  
			  char_result = new String(bbuffer.array());
			  return char_result;
			  
		  }
	   
			/**
		   * convert 함수 - 문자열변환
		   * 
		   * @param str 대상문자열
		   * @param enc 변환할 케릭터셋
		   * @return result
		   * @throws UnsupportedEncodingException 
		   */
		  public static String convert(String str, String enc) throws IOException{
			  ByteArrayOutputStream requestOutputStream = new ByteArrayOutputStream();
			  requestOutputStream.write(str.getBytes(enc));
			  return requestOutputStream.toString(enc);
			  
		  }
	   
		  
	    //랜덤 생성  10자리
	    public static String getRandomPassword( int length ) throws Exception{
	        char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','!','@','#','$','^','(',')'};
	        StringBuilder sb = new StringBuilder("");
	        //Random rn = new Random();
	        if(length < 0){
	        	return sb.toString();
	        }
	        for( int i = 0 ; i < length ; i++ ){
	            //sb.append( charaters[ rn.nextInt( charaters.length ) ] );
	        	int jr = javaRandom(0, length-1);
	        	if(jr < 0){
	        		jr = 0;
	        	}
	        	sb.append( charaters[ jr ] );
	        	
	        }
	        return sb.toString();
	    }
		  
	   //마스킹함수 : 앞뒤 한글자를 제외하고 *로 마스킹한다
	    public static String masking_name(String name) throws Exception{
	    	String mask = "";
	    	if(name.length() > 2){
	    		mask = substring(name,0,1)+rpad("*",name.length()-2,"*")+name.substring(name.length()-1,name.length());
	    	}else{	//이름이 2자이하인 경우
	    		mask = substring(name,0,1)+rpad("*",name.length()-2,"*");
	    	}
	    	return mask;
	    }
	    
	    //첨부파일 내 개인정보 여부 확인_2019-09-25
	    public static List getAtchFilePersonalData(String totSrchUrl, String fileFullPath) throws Exception {
			String result = getResponseFile(totSrchUrl + fileFullPath);
			
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			log.debug(result);
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			log.debug("===========================================================================");
			
			result = result.replace("FilteredFile:" + fileFullPath + "FilteredData:", ""); 
			result = result.replace("<<EOD>>", "");
			
			List<HashMap<String,String>> resultList = chkRegExpFile(result); 
			
			return resultList;
		}
	    
	    public static String getResponseFile(String strUrl) throws Exception {
			URL url = new URL(strUrl);
			InputStreamReader isr = new InputStreamReader(url.openStream()); 
			String rtn = ""; 

			try{
				BufferedReader br = new BufferedReader(isr);
				StringBuffer sb = new StringBuffer();
				String tempStr = null;
				while(true){
					tempStr = br.readLine();
					if(tempStr == null) break;
					sb.append(tempStr); // 응답결과
				}
				br.close();

				if(sb != null) {
					rtn = sb.toString(); 
				}
			} catch (NullPointerException e) {
				log.error("error", e);
			} catch (Exception e) {
				log.error("error", e);
			} finally {
				if(isr != null) {
					try {
						isr.close();
					} catch(NullPointerException e) {
						log.error("error",e);
					} catch(Exception e) {
						log.error("error",e);
					}
				}
			}
			return rtn; 
		}
	    
	    /**
		 * 문자열에서 개인정보 패턴을 추출하여 '*' 로 치환한다. (ex. 750101-1234567 -> ******-*******)
		 * @param String str : 개인정보가 포함된 문자열
		 * @return '*'로 치환된 문자열
		 */
		public static List chkRegExpFile(String str){
			
			List<HashMap<String, String>> resultList = new ArrayList<HashMap<String,String>>();
			
			resultList = juminPatternCheck(str, resultList);
			resultList = passportPatternCheck(str, resultList); 
			resultList = drivePatternCheck(str, resultList);
			resultList = hpPatternCheck(str, resultList);
			resultList = foreignerPatternCheck(str, resultList);
			resultList = creditCardPatternCheck(str, resultList);
			resultList = healthPatternCheck(str, resultList);
			resultList = bankNoPatternCheck(str, resultList);
			
			return resultList;
		}
		
		/**
		 * 계좌번호 
		 * @param str
		 * @param resultList
		 * @return
		 */
		private static List<HashMap<String, String>> bankNoPatternCheck(String str,	List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0; 
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "([0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|" +											//계좌번호
								"[0-9]{3}[-~.[:space:]]([0-9]{5,6}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{5}|[0-9]{2,3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{7}|" +
								"[0-9]{2}[-~.[:space:]][0-9]{4,6}[-~.[:space:]][0-9]|[0-9]{5}[-~.[:space:]][0-9]{3}[-~.[:space:]][0-9]{2}|[0-9]{2}[-~.[:space:]][0-9]{5}[-~.[:space:]][0-9]{3}|" +
								"[0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{3}|[0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{7})|" +
								"[0-9]{4}[-~.[:space:]]([0-9]{3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9])|[0-9]{5}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|" +
								"[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{5,6})";

				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "계좌번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		/**
		 * 건강보험 
		 * @param str
		 * @param resultList
		 * @return
		 */
		private static List<HashMap<String, String>> healthPatternCheck(String str, List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0; 
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "[1257][-~.[:space:]][0-9]{10}|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "건강보험");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}
		
		/**
		 * 신용카드
		 * @param str
		 * @param resultList
		 * @return
		 */
		private static List<HashMap<String, String>> creditCardPatternCheck(String str,	List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0; 
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "[34569][0-9]{3}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "신용카드");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		private static List<HashMap<String, String>> foreignerPatternCheck(String str,	List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0; 
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "([01][0-9]{5}[[:space:]~-]+[1-8][0-9]{6}|[2-9][0-9]{5}[[:space:]~-]+[1256][0-9]{6})|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "외국인 등록번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		private static List<HashMap<String, String>> hpPatternCheck(String str, List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0;
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				                
				regExpPttrn = "01[016789][-~.[:space:]][0-9]{3,4}[-~.[:space:]][0-9]{4}|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);
	 

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "휴대폰번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		private static List<HashMap<String, String>> drivePatternCheck(String str, List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			int cnt = 0; 
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9]{2}|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "운전면허번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		private static List<HashMap<String, String>> passportPatternCheck(String str, List<HashMap<String, String>> resultList) {
			String rtrnStr = "";
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "([a-zA-Z]{2}[-~.[:space:]][0-9]{7})|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);
				int cnt = 0; 

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "여권번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}

		private static List<HashMap<String, String>> juminPatternCheck(String str, List<HashMap<String, String>> resultList) {
			
			String rtrnStr = "";
			
			if(str != null && !str.equals("")){
				rtrnStr = str;
				String regExp = "";
				String regExpPttrn = ""; 

				// 주민등록번호 패턴 검사 
				regExpPttrn = "([01][0-9]{5}[[:space:],~-]+[1-4][0-9]{6}|[2-9][0-9]{5}[[:space:],~-]+[1-2][0-9]{6})|"; 
				//정규식 패턴으로 등록
				Pattern pattern = Pattern.compile(regExpPttrn);
				//입력받은 문자열 중에 패턴에 등록된 정규식이 포함되어 있는지 검사
				Matcher matches = pattern.matcher(str);
				int cnt = 0; 

				String rStr = "";
				while(matches.find()) {
					regExp = matches.group();
					if(!regExp.equals("")) {
						if(cnt == 0) {
							rStr = regExp;	
						} else  {
							rStr =  "," + rStr + regExp;
						}
						cnt++;					
					}
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();			
				
				resultMap.put("resultTyp", "주민등록번호");
				resultMap.put("resultStr", rStr); 
				resultMap.put("resultCnt", cnt+ "");
				resultList.add(resultMap); 
			}
			
			return resultList;
		}
	    
}
