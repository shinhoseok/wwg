/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.DateUtility
 * Description        : 일자, 시간과 관련된 다수의 기능을 제공하는 클래스.
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

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import java.util.Vector;

import org.apache.log4j.Logger;


/**
 * 일자, 시간과 관련된 다수의 기능을 제공하는 클래스
 * <p>
 * 일자패턴 사용시의 문법
 * <pre>
 *	 Symbol   Meaning                 Presentation        Example
 *	 ------   -------                 ------------        -------
 *	 G        era designator          (Text)              AD
 *	 y        year                    (Number)            1996
 *	 M        month in year           (Text & Number)     July & 07
 *	 d        day in month            (Number)            10
 *	 h        hour in am/pm (1~12)    (Number)            12
 *	 H        hour in day (0~23)      (Number)            0
 *	 m        minute in hour          (Number)            30
 *	 s        second in minute        (Number)            55
 *	 S        millisecond             (Number)            978
 *	 E        day in week             (Text)              Tuesday
 *	 D        day in year             (Number)            189
 *	 F        day of week in month    (Number)            2 (2nd Wed in July)
 *	 w        week in year            (Number)            27
 *	 W        week in month           (Number)            2
 *	 a        am/pm marker            (Text)              PM
 *	 k        hour in day (1~24)      (Number)            24
 *	 K        hour in am/pm (0~11)    (Number)            0
 *	 z        time zone               (Text)              Pacific Standard Time
 *	 '        escape for text         (Delimiter)
 *	 ''       single quote            (Literal)           '
 *
 *  [예시]
 *	 Format Pattern                         Result
 *	 --------------                         -------
 *	 "yyyyMMdd"                        ->>  19960710
 *	 "yyyy-MM-dd"                      ->>  1996-07-10
 *	 "HHmmss"                          ->>  210856
 *	 "HH:mm:ss"                        ->>  21:08:56
 *	 "hh:mm:ss"                        ->>  09:08:56
 *	 "yyyy.MM.dd hh:mm:ss"             ->>  1996.07.10 15:08:56
 *	 "EEE, MMM d, ''yy"                ->>  Wed, July 10, '96
 *	 "h:mm a"                          ->>  12:08 PM
 *	 "hh 'o''clock' a, zzzz"           ->>  12 o'clock PM, Pacific Daylight Time
 *	 "K:mm a, z"                       ->>  0:00 PM, PST
 *	 "yyyyy.MMMMM.dd GGG hh:mm aaa"    ->>  1996.July.10 AD 12:08 PM
 *
 * </pre>
 * 기타 자세한 것은 <a href="http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html">SimpleDateFormat</a>
 * Class API Document 를 참조할것
 * 
 * @author ispark
 * @version 2.1.0
 */
public class DateUtility {

	protected static Logger log = Logger.getLogger(DateUtility.class); //현재 클래스 이름을 Logger에 등록
	
	/**
	 * <p>날짜 표현의 문자열을 형식을 갖춘 날짜 표현식으로 바꿔주는 메소드이다. String타입의 날짜 8자리를
	 * 입력받아서 yyyy-MM-dd 또는 yyyy/MM/dd로 바꿔준다.</p>
	 * @param date 날짜를 표현한 문자열(20011223로 표현되어야 한다)
	 * @param
	 *		format 날짜의 포맷형식<br>
	 *		포맷형식으로는 다음과 같은 것을 인자로 주어야 한다(대소문자 구분하지 않는다).
	 *		<UL>
	 *		<li>"yyyy-MM-dd" : 2001-12-23을 표현
	 *		<li>"yyyy/MM/dd" : 2001/12/23을 표현
	 *		<li>"yyyy년 MM월 dd일" : 2001년 12월 23일을 표현
	 *		<li>"yyyy:MM:dd" : 2001:12:23을 표현
	 *		</UL>
	 * @return
	 *  String 변환된 문자열<br>
	 *  빈문자열 date가 null인 경우<br>
	 * </p>
	 */
	public static String dateFormat(String date, String format) {
		if (date == null) return "";
		Long.parseLong(date);

		int delimeter = 0;
		if (format.equalsIgnoreCase("yyyy-MM-dd"))
			delimeter = 0;
		else if (format.equalsIgnoreCase("yyyy/MM/dd"))
			delimeter = 1;
		else if (format.equalsIgnoreCase("yyyy년 MM월 dd일"))
			delimeter = 2;
		else if (format.equalsIgnoreCase("yyyy:MM:dd"))
			delimeter = 3;
		else if (format.equalsIgnoreCase("MM-dd"))
			delimeter = 5;
		else if (format.equalsIgnoreCase("MM/dd"))
			delimeter = 6;			
		else
			delimeter = 4;

		StringBuffer sb = new StringBuffer();

		switch(delimeter) {
			case 0 :
				sb.append(date.substring(0,4)).append("-");
				sb.append(date.substring(4,6)).append("-");
				sb.append(date.substring(6,8));
				break;
			case 1 :
				sb.append(date.substring(0,4)).append("/");
				sb.append(date.substring(4,6)).append("/");
				sb.append(date.substring(6,8));
				break;
			case 2 :
				sb.append(date.substring(0,4)).append("년 ");
				sb.append(date.substring(4,6)).append("월 ");
				sb.append(date.substring(6,8)).append("일 ");
				break;
			case 3 :
				sb.append(date.substring(0,4)).append(":");
				sb.append(date.substring(4,6)).append(":");
				sb.append(date.substring(6,8));
				break;
			case 4 :
				sb.append("");
				break;	
			case 5 :
				sb.append(date.substring(4,6)).append("-");
				sb.append(date.substring(6,8));
				break;	
			case 6 :
				sb.append(date.substring(4,6)).append("/");
				sb.append(date.substring(6,8));
				break;				
		}
		return sb.toString();
	}

	/**
	 * <p>시간 표현의 문자열을 형식을 갖춘 시간 표현식으로 바꿔주는 메소드이다. String타입의 시간 6자리를
	 * 입력받아서 hh:MM:ss 또는 hh-MM-ss로 바꿔준다.</p>
	 * @param time 시간을 표현한 문자열(153312로 표현되어야 한다)
	 * @param
	 *		format 시간의 포맷형식<br>
	 *		포맷형식으로는 다음과 같은 것을 인자로 주어야 한다(대소문자 구분하지 않는다).
	 *		<UL>
	 *		<li>"hh:MM:ss" : 15:33:23을 표현
	 *		<li>"hh/MM/ss" : 15/33/23을 표현
	 *		<li>"hh시 MM분 ss초" : 15시 33분 23초를 표현
	 *		<li>"hh-MM-ss" : 15-33-23을 표현
	 *		</UL>
	 * @return
	 *  String 변환된 문자열<br>
	 *  빈문자열 time이 null인 경우<br>
	 * @throws IllegalTimeLengthException 날짜표현 문자열이 6자리가 아닌 경우
	 * @throws IllegalFormatterException 지원하지 않는 포맷형식을 사용한 경우
	 * @throws java.lang.NumberFormatException 날짜표현 문자열에 숫자가 아닌 값이 들어가 있는 경우
	 * </p>
	 */
	public static String timeFormat(String time, String format){
		if (time == null) return "";
		Long.parseLong(time);

		int delimeter = 0;
		if (format.equalsIgnoreCase("hh:MM:ss"))
			delimeter = 0;
		else if (format.equalsIgnoreCase("hh/MM/ss"))
			delimeter = 1;
		else if (format.equalsIgnoreCase("hh시 MM분 ss초"))
			delimeter = 2;
		else if (format.equalsIgnoreCase("hh-MM-ss"))
			delimeter = 3;
		else
			delimeter = 4;

		StringBuffer sb = new StringBuffer();

		switch(delimeter) {
			case 0 :
				sb.append(time.substring(0,2)).append(":");
				sb.append(time.substring(2,4)).append(":");
				sb.append(time.substring(4,6));
				break;
			case 1 :
				sb.append(time.substring(0,2)).append("/");
				sb.append(time.substring(2,4)).append("/");
				sb.append(time.substring(4,6));
				break;
			case 2 :
				sb.append(time.substring(0,2)).append("시 ");
				sb.append(time.substring(2,4)).append("분 ");
				sb.append(time.substring(4,6)).append("초 ");
				break;
			case 3 :
				sb.append(time.substring(0,2)).append("-");
				sb.append(time.substring(2,4)).append("-");
				sb.append(time.substring(4,6));
				break;
			case 4 :
				sb.append("");
				break;				
		}
		return sb.toString();
	}

	/**
	 * <p>날짜와 시간 표현의 문자열을 형식을 갖춘 날짜시간 표현식으로 바꿔주는 메소드이다. String타입의 날짜시간 14자리(날짜 8자리와 시간 6자리)를
	 * 입력받아서 yyyy-MM-dd hh:MM:ss 또는 yyyy:MM:dd hh:MM:ss로 바꿔준다.</p>
	 * @param dateTime 날짜와 시간을 표현한 문자열(20011223081235로 표현되어야 한다)
	 * @param
	 *		dateFormatter 날짜의 포맷형식<br>
	 *		포맷형식으로는 다음과 같은 것을 인자로 주어야 한다(대소문자 구분하지 않는다).
	 *		<UL>
	 *		<li>"yyyy-MM-dd" : 2001-12-23을 표현
	 *		<li>"yyyy/MM/dd" : 2001/12/23을 표현
	 *		<li>"yyyy년 MM월 dd일" : 2001년 12월 23일을 표현
	 *		<li>"yyyy:MM:dd" : 2001:12:23을 표현
	 *		</UL>
	 * @param
	 *		timeFormatter 시간의 포맷형식<br>
	 *		포맷형식으로는 다음과 같은 것을 인자로 주어야 한다(대소문자 구분하지 않는다).
	 *		<UL>
	 *		<li>"hh:MM:ss" : 15:33:23을 표현
	 *		<li>"hh/MM/ss" : 15/33/23을 표현
	 *		<li>"hh시 MM분 ss초" : 15시 33분 23초를 표현
	 *		<li>"hh-MM-ss" : 15-33-23을 표현
	 *		</UL>
	 * @return
	 *  String 변환된 문자열<br>
	 *  빈문자열 dateTime이 null인 경우<br>
	 * </p>
	 */
	public static String dateFormat(String dateTime, String dateFormatter, String timeFormatter) {
		if (dateTime == null) return "";
		Long.parseLong(dateTime);

		StringBuffer sb = new StringBuffer();
		sb.append(dateFormat(dateTime.substring(0,8),dateFormatter));
		sb.append(" ");
		sb.append(timeFormat(dateTime.substring(8,14),timeFormatter));

		return sb.toString();
	}

	/**
	 * <p>현재 날짜와 시간을 주어진 Pattern에 맞춰서 변환한다.
	 * <BR>java.util.Date 객체를 "2001/11/24, 01/11/17"와 같은 형식에 맞춰 변환시에 사용한다.<br>
	 * 변환할 수 있는 형식은 다양한 형태를 사용할 수 있다.<br>
	 * <b>단, 패턴의 형식은 대소문자를 구분한다.</B> '월(M)'은 반드시 대문자로 표기한다.</p>
	 *	<UL>
	 *	<li>yy : 년도. 반드시 소문자로 표기
	 * 	<li>MM : 월. 반드시 대문자로 표기
	 * 	<li>dd : 일. 반드시 소문자로 표기
	 * 	<li>hh : 시간. 소문자면 0-12시, 대문자면 0-23시
	 *  <li>kk : 시간. 1-24시
	 * 	<li>mm : 분. 반드시 소문자로 표기
	 * 	<li>ss : 초. 반드시 소문자로 표기
	 *	</UL>
	 * 적용할 수 있는 Pattern에 대해서는 Java API의 java.text.SimpleDateFormat클래스를 참고한다.<br>
	 * 다음은 사용 예이다.<br>
	 *	<UL>
	 * 	<li>yyyy-MM-dd, hh:mm:ss &gt;&gt; 2001-12-24, 01:15:23으로 표시
	 *	<li>yyyy-MM-dd, HH:mm:ss &gt;&gt; 2001-12-24, 13:15:23으로 표시
	 * 	<li>yyyy/MM/dd hh/mm/ss &gt;&gt; 2001/12/24 01/15/23으로 표시
	 * 	<li>yyyy-MM-dd &gt;&gt; 2001-12-24로 표시
	 * 	<li>hh시 mm분 ss초 &gt;&gt; 01시 15분 23초로 표시
	 * 	<li>안녕하세요. 오늘은 yyyy년 MM월 dd입니다. 현재 시각은 hh시 mm분 ss초입니다. &gt;&gt; 안녕하세요. 오늘은 2001년 12월 24일입니다. 현재 시각은 01시 15분 23초입니다.
	 *	</UL>
	 * @param
	 *		pattern 날짜와 시간을 변환할 형식<br>
	 *		pattern이 null이거나 빈문자열인 경우에는 Default값으로 yyyyMMddHHmmss가 들어간다.
	 * @return
	 *  String 변환된 문자열<br>
	 * @throws java.lang.IllegalArgumentException 지원하지 못하는 Pattern을 사용한 경우 발생한다.
	 * </p>
	 */
	public static String getCurrentDateTime(String pattern) throws java.lang.IllegalArgumentException {
		if ((pattern == null) || (pattern.equals(""))) pattern = "yyyyMMddHHmmss";
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(pattern);
		return formater.format(date);
	}

	/**
	 * 특정 날짜를 특정 형식에 맞춰서 스트링으로 리턴한다. 형식은 <code>getCurrentDateTime(String)의
	 * Pattern을 참고한다.
	 *
	 * @param date 특정 날짜
	 * @param pattern 날짜와 시간을 변환할 형식<br>
	 *				pattern이 null이거나 빈문자열인 경우에는 Default값으로 yyyy-MM-dd가 들어간다.
	 * @return 변환된 문자열
	 * @throws IllegalArgumentException 지원하지 못하는 Pattern을 사용한 경우 발생한다.
	 */
	public static String getFomattedDateTime(java.util.Date date, String pattern) throws java.lang.IllegalArgumentException {
		if ((pattern == null) || (pattern.equals(""))) pattern = "yyyy-MM-dd";
		if (date == null) return null;
		java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(pattern);
		return formater.format(date);
	}

   /**
    * <p>날짜 형식을 바꿔 주는 함수</p>
    * 입력 받을수 있는 날짜 종류 : yyyymmdd, yyyymm
    *                               8        6  
    * @param dateValue String
	* @param format String
    * @return String 포맷에 맞게 변환된 날짜 스트링.
	*                날짜 형식 체크는 거의 하지 않음. 정상적인 날짜가 들어온다고 가정하고 변환함
    */
    public static String formatDate(String dateValue, String format) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
        try {
            if ( dateValue==null || dateValue.equals("") || format.equals("") ) {
                return "";
            }

            int len = dateValue.length();

            // 첫번째 걸러냄
            if ( len!=8 && len!=6 ) {
            	log.debug(
					"길이 안맞음 - 입력받을 수 있는 기본형식이 아님. : " + 
					dateValue);
                return dateValue;
            }

            char[] argArray  = findFormatInformation(format);
            char arrange   = argArray[0];
            char yearLen   = argArray[1];
            char monthLen  = argArray[2];
            char dayLen    = argArray[3];
            char delimiter = argArray[4];

            // 두번째 걸러냄
            if ( len==6 && dayLen=='2' ) {
            	log.debug("'" + dateValue + 
					"' 날짜가 없는 형식을 날짜가 있는 " + format + 
					" 형식으로 변환 할 수 없습니다.");
                return dateValue;
            } else if ( len==8 && dayLen=='0' ) {
            	log.debug("'" + dateValue + 
					"' 날짜가 있는 형식을 날짜가 없는 " + format + 
					" 형식으로 변환 할 수 없습니다.");
                return dateValue;
            }

            String inYear  = null;
            String inMonth = null;
            String inDay   = null;

            switch (len) {
                case 8 :
                    inYear  = dateValue.substring(0,4);
                    inMonth = dateValue.substring(4,6);
                    inDay   = dateValue.substring(6,8);
                    break;
                case 6 :
                    inYear  = dateValue.substring(0,4);
                    inMonth = dateValue.substring(4,6);
                    inDay   = "";
                    break;
                default :
                    inYear  = "";
                    inMonth = "";
                    inDay   = "";
                    break;
            }

            if ( yearLen=='2' ) {
                inYear = inYear.substring(2, 4);
            }

            if ( monthLen=='3' ) {
                switch (Integer.parseInt(inMonth)) {
                    case  1 :    inMonth = "JAN";    break;
                    case  2 :    inMonth = "FEB";    break;
                    case  3 :    inMonth = "MAR";    break;
                    case  4 :    inMonth = "APR";    break;
                    case  5 :    inMonth = "MAY";    break;
                    case  6 :    inMonth = "JUN";    break;
                    case  7 :    inMonth = "JUL";    break;
                    case  8 :    inMonth = "AUG";    break;
                    case  9 :    inMonth = "SEP";    break;
                    case 10 :    inMonth = "OCT";    break;
                    case 11 :    inMonth = "NOV";    break;
                    case 12 :    inMonth = "DEC";    break;
                    default :    inMonth = "mmm"; 	 break;
                }
                if ( inMonth.equals("mmm") ) {
                    log.debug("월에 잘못된 값이 들어있음. : " + dateValue);
                    return dateValue;
                }
            }

            String newDate = null;
            String delimiterStr = (new Character(delimiter)).toString().trim();

            switch (arrange) {
                case 'y' :
                    if ( dayLen=='0' ) {
                        newDate = inYear  + delimiterStr + inMonth;
                    } else {
                        newDate = inYear  + delimiterStr + inMonth + delimiterStr + inDay ;
                    }
                    break;
                case 'm' :
                    if ( dayLen=='0' ) {
                        newDate = inMonth + delimiterStr + inYear;
                    } else {
                        newDate = inMonth + delimiterStr + inDay   + delimiterStr + inYear;
                    }
                    break;
                case 'd' :
                    newDate = inDay   + delimiterStr + inMonth + delimiterStr + inYear;
                    break;
            }

            return newDate;
            
        } catch(NullPointerException e){
            log.debug("NullPointerException Exception : " );
            return dateValue;		
		} catch(ArrayIndexOutOfBoundsException e){
            log.debug("ArrayIndexOutOfBoundsException Exception : " );
            return dateValue;		
		} catch (Exception e) {
            log.debug("[CMUtilDate.scmFormatDate()] 아마도 날짜 형식이 맞지 않는 경우로 생각됨... 점검후 그래도 이상 있으면 문의 바람... ");
            log.debug("[CMUtilDate.scmFormatDate()] Exception : " );
            return dateValue;
        }
    }

   /**
    * 날짜 형식을 기본 형식으로 바꿔 주는 함수 ("-", ".", "/"는 제거)
	*
    * @param dateValue String
	* @param format String
    * @return String yyyymmdd, yyyymm형식의 변환된 날짜 스트링. 날짜 형식 체크는 하지 않음. 
	*                정상적인 날짜가 들어온다고 가정하고 변환함
    */
    public static String formatDateToDefault(String dateValue, String format) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
        try {
            if ( dateValue==null || dateValue.equals("") || format.equals("") ) {
                return "";
            }

            if ( dateValue.length()<4 || 11<dateValue.length() ) {
                log.debug("길이 안맞음 - 입력받을 수 있는 형식의 길이가 아님");
                return dateValue;
            }

            char[] argArray = findFormatInformation(format);
            char arrange   = argArray[0];
            char yearLen   = argArray[1];
            char monthLen  = argArray[2];
            char dayLen    = argArray[3];
            char delimiter = argArray[4];

            dateValue = delDelimiter(dateValue, delimiter);

            int yearStart  = 0;
            int monthStart = 0;
            int dayStart   = 0;

            switch (arrange) {
                case 'y':
                    yearStart = 0;
                    monthStart = Character.getNumericValue(yearLen);
                    dayStart = Character.getNumericValue(yearLen) + Character.getNumericValue(monthLen);
                    break;
                case 'm':
                    monthStart = 0;
                    dayStart = Character.getNumericValue(monthLen);
                    yearStart = Character.getNumericValue(monthLen) + Character.getNumericValue(dayLen);
                    break;
                case 'd':
                    dayStart = 0;
                    monthStart = Character.getNumericValue(dayLen);
                    yearStart = Character.getNumericValue(dayLen) + Character.getNumericValue(monthLen);
                    break;
            }

            String newYear  = dateValue.substring(yearStart , yearStart  + Character.getNumericValue(yearLen)  );
            String newMonth = dateValue.substring(monthStart, monthStart + Character.getNumericValue(monthLen) );
            String newDay   = dateValue.substring(dayStart  , dayStart   + Character.getNumericValue(dayLen)   );


            if ( yearLen=='2' ) {
                int newYearInt = Integer.parseInt(newYear);
                if ( 0<=newYearInt && newYearInt<50 ) {     // 00 ~ 49
                    newYearInt += 2000;
                } else if ( 50<=newYearInt && newYearInt <100 ) {     // 50 ~ 99
                    newYearInt += 1900;
                }
                newYear = newYearInt+"";
            }

            if ( monthLen=='3' ) {
                       if ( newMonth.equals("JAN") ) {    newMonth = "01";
                } else if ( newMonth.equals("FEB") ) {    newMonth = "02";
                } else if ( newMonth.equals("MAR") ) {    newMonth = "03";
                } else if ( newMonth.equals("APR") ) {    newMonth = "04";
                } else if ( newMonth.equals("MAY") ) {    newMonth = "05";
                } else if ( newMonth.equals("JUN") ) {    newMonth = "06";
                } else if ( newMonth.equals("JUL") ) {    newMonth = "07";
                } else if ( newMonth.equals("AUG") ) {    newMonth = "08";
                } else if ( newMonth.equals("SEP") ) {    newMonth = "09";
                } else if ( newMonth.equals("OCT") ) {    newMonth = "10";
                } else if ( newMonth.equals("NOV") ) {    newMonth = "11";
                } else if ( newMonth.equals("DEC") ) {    newMonth = "12";
                } else                               {    newMonth = "99";
                }
            }

            return newYear + newMonth + newDay;

        } catch(NullPointerException e){
        	log.debug("[CMUtilDate.scmFormatDateToDefault()] Exception : " );
            return dateValue;
		} catch(ArrayIndexOutOfBoundsException e){
			log.debug("[CMUtilDate.scmFormatDateToDefault()] Exception : " );
            return dateValue;
		} catch (Exception e) {
            log.debug("[CMUtilDate.scmFormatDateToDefault()] 아마도 날짜 형식이 맞지 않는 경우로 생각됨... 점검후 그래도 이상 있으면 문의 바람... ");
            log.debug("[CMUtilDate.scmFormatDateToDefault()] Exception : " );
            return dateValue;
        } 
    }

   /**
    * 날짜 형식의 minor code를 가지고 그 형식에 대한 정보를 알려줌
	*
    * @param format minor code
    * @return char[] (arrange, yearLen, monthLen, dayLen, delimiter )
    */
    public static char[] findFormatInformation(String format) {
        char minor1 = format.charAt(0);
        char minor2 = format.charAt(1);

        char arrange;
        char yearLen;
        char monthLen;
        char dayLen;
        char delimiter;

        char[] argArray = new char[5];

        switch (minor1) {
            case 'A':    arrange  = 'y';    yearLen  = '4';    monthLen = '2';    dayLen  = '2';    break;
            case 'B':    arrange  = 'y';    yearLen  = '4';    monthLen = '3';    dayLen  = '2';    break;
            case 'C':    arrange  = 'y';    yearLen  = '2';    monthLen = '2';    dayLen  = '2';    break;
            case 'D':    arrange  = 'y';    yearLen  = '2';    monthLen = '3';    dayLen  = '2';    break;

            case 'E':    arrange  = 'y';    yearLen  = '4';    monthLen = '2';    dayLen  = '0';    break;
            case 'F':    arrange  = 'y';    yearLen  = '4';    monthLen = '3';    dayLen  = '0';    break;
            case 'G':    arrange  = 'y';    yearLen  = '2';    monthLen = '2';    dayLen  = '0';    break;
            case 'H':    arrange  = 'y';    yearLen  = '2';    monthLen = '3';    dayLen  = '0';    break;

            case 'I':    arrange  = 'm';    yearLen  = '4';    monthLen = '2';    dayLen  = '2';    break;
            case 'J':    arrange  = 'm';    yearLen  = '4';    monthLen = '3';    dayLen  = '2';    break;
            case 'K':    arrange  = 'm';    yearLen  = '2';    monthLen = '2';    dayLen  = '2';    break;
            case 'L':    arrange  = 'm';    yearLen  = '2';    monthLen = '3';    dayLen  = '2';    break;

            case 'M':    arrange  = 'm';    yearLen  = '4';    monthLen = '2';    dayLen  = '0';    break;
            case 'N':    arrange  = 'm';    yearLen  = '4';    monthLen = '3';    dayLen  = '0';    break;
            case 'O':    arrange  = 'm';    yearLen  = '2';    monthLen = '2';    dayLen  = '0';    break;
            case 'P':    arrange  = 'm';    yearLen  = '2';    monthLen = '3';    dayLen  = '0';    break;

            case 'Q':    arrange  = 'd';    yearLen  = '4';    monthLen = '2';    dayLen  = '2';    break;
            case 'R':    arrange  = 'd';    yearLen  = '4';    monthLen = '3';    dayLen  = '2';    break;
            case 'S':    arrange  = 'd';    yearLen  = '2';    monthLen = '2';    dayLen  = '2';    break;
            case 'T':    arrange  = 'd';    yearLen  = '2';    monthLen = '3';    dayLen  = '2';    break;
            default :    arrange  = 'y';    yearLen  = '4';    monthLen = '2';    dayLen  = '2';    break;
        }

        switch (minor2) {
            case '1':    delimiter = ' ';    break;
            case '2':    delimiter = '-';    break;
            case '3':    delimiter = '/';    break;
            case '4':    delimiter = '.';    break;
            default :    delimiter = ' ';    break;
        }

        argArray[0] = arrange;
        argArray[1] = yearLen;
        argArray[2] = monthLen;
        argArray[3] = dayLen;
        argArray[4] = delimiter;

        return argArray;
    }


   /*
   	* 입력받은 날짜의 delimiter를 제거한다.
	*
    * @param date 날짜값
	* @param delimiter char 디리미터
	* @return String 디리미터가 제거된 날짜 값
    */
    public static String delDelimiter(String date, char delimiter) {
        String arg = date.trim();
        int len = arg.length();
        char[] tempChar = new char[len];
        int j=0;

        for ( int i=0 ; i<len ; i++ ) {
            if ( arg.charAt(i) == delimiter || arg.charAt(i) == ' ' ){
                continue;
            } else {
                tempChar[j] = arg.charAt(i);
                j++;
            }
        }
        return new String(tempChar).trim();
    }

   /*
   	* 입력받은 날짜의 스트링 값에서 Hyphen(-, ., /)을 제거한다.
	*
    * @param date 날짜값
	* @return String Hyphen이 제거된 날짜 값
    */
    private static String delHyphen(String arg) {
        arg = arg.trim();
        int len = arg.length();
        char[] tempChar = new char[len];
        int j=0;

        for (int i=0 ; i<len ; i++){
            if (arg.charAt(i) == '-' || arg.charAt(i) == '.' 
				|| arg.charAt(i) == '/' || arg.charAt(i) == ' ' ){
                continue;
            }else{
                tempChar[j] = arg.charAt(i);
                j++;
            }
        }
        return new String(tempChar).trim();
    }

   /**
   	* 입력받은 포맷의 최대 길이를 반환한다.
	*
    * @param format 포맷
	* @return int 최대길이
    */
    private static int getMaxLength(String format) {
        if(format==null || format.equals("")) {
            return 11;
        }

        char[] argArray = findFormatInformation(format);
        char arrange   = argArray[0];
        char yearLen   = argArray[1];
        char monthLen  = argArray[2];
        char dayLen    = argArray[3];
        char delimiter = argArray[4];

        int delimiterLength = delimiter==' ' ? 0 : 1;

        int maxLength =   Character.getNumericValue(yearLen) + Character.getNumericValue(monthLen)
                        + Character.getNumericValue(dayLen)  + delimiterLength;

        return maxLength;
    }

   /**
	* 한 자리수의 숫자를 두 자리 String으로 변환
	*
    * @param arg int
    * @return   String date
    */
    public static String addZero(int arg) {
        String date = arg + "";
        if ( date.length()==1 ) {
            return "0"+date;
        } else {
            return date;
        }
    }

   /**
    * 두 자리 String을 한 자리수의 숫자로 변환
	*
    * @param arg String
    * @return  int date
    */
    public static int delZero(String arg) {
        if ( arg==null ) {
            return 0;
        } else {
            return Integer.parseInt(arg);
        }
    }

   /**
    * 현재 날짜를 return 해줌
	*
    * @return String 현재날짜 "20000910"
    */
	public static String getToDay() {
		Calendar cal = Calendar.getInstance();
		int year, month, day;
		String today;

		year = cal.get(Calendar.YEAR);
		month= cal.get(Calendar.MONTH)+1; // calendar class의 MONTH는 0이 1월이므로 +1
		day  = cal.get(Calendar.DATE);

		if (month < 10) {
			today = Integer.toString( year )  + "0" + month;
		} else {
			today = Integer.toString( year )  + month;
		}

		if (day < 10) {
			today = today + "0" + day;
		} else {
			today = today + day;
		}

		return today;
	}
	
	   /**
	    * 입력 날짜의 요일을 return 해줌
		*
	    * @return String 입력날짜의요일을 int형으로 리턴
	    */
		public static int getDayWeek(String year,String month,String day) {	
			int week_int = 0;
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR, Integer.parseInt(year));
			cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
			cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day));			
			week_int = cal.get(Calendar.DAY_OF_WEEK); 
			return week_int;
		}
		
		   /**
		    * 입력 날짜의 요일을 return 해줌
			*
		    * @return String 입력날짜의요일을 한글문자로 리턴
		    */
			public static String getDayWeekHan(String year,String month,String day) {	
				int week_int = 0;
				String [] week_arr = {"일","월","화","수","목","금","토"};
				Calendar cal = Calendar.getInstance();
				cal.set(Calendar.YEAR, Integer.parseInt(year));
				cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
				cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day));			
				week_int = cal.get(Calendar.DAY_OF_WEEK)-1; 
				return week_arr[week_int];
			}		
	
   /**
    *현재 날짜를 return 해줌
	*
    * @return String 현재달 01 String "20000901"
    */
	public static String getFirstDay() {
		Calendar cal = Calendar.getInstance();
		int year, month, day;
		String today;

		year = cal.get(Calendar.YEAR);
		month= cal.get(Calendar.MONTH)+1; // calendar class의 MONTH는 0이 1월이므로 +1
		day  = cal.get(Calendar.DATE);

		if (month < 10) {
			today = Integer.toString( year )  + "0" + month;
		} else {
			today = Integer.toString( year )  + month;
		}

			today = today + "01";
		
		return today;
	}

   /**
    * 현재 시간을 return 해줌
	*
    * @return String : 현재 시간 "HHMMSS"
    */
	public static String getCurrentTime() {
		Calendar cal = Calendar.getInstance();
		String currentTime = null;
		String hour, min, sec ;

		int h = cal.get(Calendar.HOUR_OF_DAY) ;
		int m = cal.get(Calendar.MINUTE) ;
		int s = cal.get(Calendar.SECOND);

		if ( h <10) {
			hour = "0" + Integer.toString(h) ;
		 } else {
		 	hour = Integer.toString(h) ;
		 }

		 if (m <10) {
			min = "0" + Integer.toString(m) ;
		 } else {
		 	min = Integer.toString(m) ;
		 }

		 if (s <10) {
			sec = "0" + Integer.toString(s) ;
		 } else {
		 	sec = Integer.toString(s) ;
		 }


		currentTime = ""+hour + min + sec;

		return currentTime;     // HHMMSS
	}

   /**
    * 현재 시간을 Millisecond return 해줌
	*
    * @return String : 현재 시간
    */
    public static String getDateTimeInMillis() {
		java.util.Date curDate = new java.util.Date();
		long currentMillis = curDate.getTime();


		return Long.toString(currentMillis);
	}

   /**
    * 현재 시간을 return 해줌
	*
    * @return String 현재 시간 "HHMM"
    */
	public static String getCurrentTimeS() {
		Calendar cal = Calendar.getInstance();
		String currentTime = null;
		String hour, min;

		int h = cal.get(Calendar.HOUR_OF_DAY) ;
		int m = cal.get(Calendar.MINUTE) ;

		if ( h <10) {
			hour = "0" + Integer.toString(h) ;
		 } else {
		 	hour = Integer.toString(h) ;
		 }

		 if (m <10) {
			min = "0" + Integer.toString(m) ;
		 } else {
		 	min = Integer.toString(m) ;
		 }

		currentTime = ""+hour + min ;

		return currentTime;     // HHMM
	}

   /**
    * 입력한 달의 일수를 반환
	*
    * @param aMonth "200009"
    * @return int	입력달의 일수
    */
	public static int getLastDayOfMonth ( String aMonth ) {

		int year, month;

		year = Integer.parseInt(aMonth.substring(0, 4));
		month= Integer.parseInt(aMonth.substring(4, 6));

		if(month < 1 || month > 12) {
			return 0;
		}

		if(month == 2) {
			if ( ((year%4 == 0) && (year%100 != 0)) || (year%400 == 0) ) {
				return 29;
			}
			else {
				return 28;
			}
		}
		else if(month==4||month==6||month==9||month==11) {
			return 30;
		}
		else {
			return 31;
		}
	}

   /**
    * 입력받은 일로부터 x일후를 계산하여 return
	*
    * @param date "20000908"
    * @param interval 더하고자 하는 날수
    * @return String - date 일로부터 interval 후의 날짜
    */
	public static String getRelativeDate(String date, int interval) {
		String relativeDate;
		int year, month, day;

		year = Integer.parseInt(date.substring(0, 4));
		month= Integer.parseInt(date.substring(4, 6));
		day  = Integer.parseInt(date.substring(6, 8));

		Calendar cal = Calendar.getInstance();
		cal.set( year, month-1, day );
		cal.add( Calendar.DATE, interval );

		year = cal.get( Calendar.YEAR );
		month= cal.get( Calendar.MONTH ) + 1;
		day  = cal.get( Calendar.DATE );

		if( month < 10 ) {
			relativeDate = Integer.toString(year) + "0" + month;
		} else {
			relativeDate = Integer.toString(year) + month;
		}

		if( day < 10 ) {
			relativeDate = relativeDate + "0" + day;
		} else {
			relativeDate = relativeDate + day;
		}

		return relativeDate;
	}

    /**
    *현재 시간으로부터 x시간후를 계산하여 return
    <br>
    *@param interval 더하고자 하는 시간
    *@return String - 현시간으로부터 interval 후 시간
    */
	public static String getRelativeTime(int interval) {
		String relativeTime;
		int hh = 0;
		String mm;

		hh = Integer.parseInt(getCurrentTime().substring(0, 2));
		mm= getCurrentTime().substring(2, 4);

		Calendar cal = Calendar.getInstance();
		cal.set( Calendar.HOUR_OF_DAY, hh);
		cal.add( Calendar.HOUR_OF_DAY, interval );

		hh = cal.get( Calendar.HOUR_OF_DAY );

		if( hh < 10 ) {
			relativeTime =  "0" + Integer.toString(hh)+mm;
		} else {
			relativeTime = Integer.toString(hh)+mm ;
		}

		return relativeTime;
	}

   /**
    * 주어진 날짜 사이에 몇년도 몇월이 들어있는지를 배열로 리턴
	*
    * @param fromDate "20000710"
    * @param endDate	"20001111"
    * @return String[] - fromDate, endDate 사이에 들어있는 년도, 월
    *         ex) "200008","200009","200010"
    */
	public static String[] getMonthsDuringPeriod(String fromDate, String endDate) {
											// String('yyyymm') Vector
		Vector v = new Vector();
		String[] months = new String[0];

		int fromYYYY=0, fromMM=0, endYYYY=0, endMM=0, temp=0;
		String month="", from="";
		if(fromDate==null){
			fromYYYY= 0;
			fromMM  = 0;			
		}else{
			if(fromDate.length()>=6){
				fromYYYY= Integer.parseInt(fromDate.substring(0,4));
				fromMM  = Integer.parseInt(fromDate.substring(4,6));				
			}else{
				fromYYYY= 0;
				fromMM  = 0;					
			}
			
		}
		
		if(endDate==null){
			endYYYY= 0;
			endMM  = 0;			
		}else{
			if(endDate.length()>=6){
				endYYYY = Integer.parseInt(endDate.substring(0,4));
				endMM   = Integer.parseInt(endDate.substring(4,6));				
			}else{
				endYYYY= 0;
				endMM  = 0;						
			}
			
		}		



		if ((fromMM>12)||(endMM>12)||(fromMM<1)||(endMM<1)) {
			return new String[0];
		}

		if(fromDate!=null && endDate!=null){
			/* fromDate가 endDate보다 클 경우 swap해주는 루틴 */
			if (fromDate.compareTo(endDate) > 0) {
				temp = fromYYYY;
				fromYYYY = endYYYY;
				endYYYY = temp;
				temp = fromMM;
				fromMM = endMM;
				endMM = temp;
			}

			v.addElement( fromDate.substring(0,6) );

			while ((fromYYYY < endYYYY) || (fromMM < endMM)) {
				if (fromMM == 12) {
					fromYYYY++;
					fromMM = 1;
				} else {
					fromMM++;
				}

				if (fromMM < 10) {
					month = Integer.toString(fromYYYY) + "0" + fromMM;
				} else {
					month = Integer.toString(fromYYYY) + fromMM;
				}

				v.addElement( month );
			}

			months = new String[v.size()];
			v.copyInto(months);			
		}


		return months;
	}

   /**
    * 주어진 날짜 사이에 몇년도 몇월 몇주가 들어있는지를 벡터로 리턴
	*
    * @param fromDate "20000710"
    * @param endDate	"20001111"
    * @return String[] fromDate, endDate 사이에 들어있는 년도, 월, 주
    */
	public static String[] getWeeksDuringPeriod(String fromDate, String endDate) {
										// 'yyyymmw' Vector
		Vector v = new Vector();
		String[] weeks = null;

		String[] monthsDuringPeriod = null;

		int year, month, day;
		int lastDayOfMonth, lastWeekOfMonth;
		
		Calendar cal = Calendar.getInstance();
		// 그 달에 몇 주가 있는지를 찾는 루틴
		
		if(fromDate!=null && endDate!=null){
			year = Integer.parseInt(fromDate.substring(0, 4));
			month= Integer.parseInt(fromDate.substring(4, 6));
			day  = Integer.parseInt(fromDate.substring(6, 8));

			lastDayOfMonth = getLastDayOfMonth(fromDate.substring(0, 6));
			cal.set(year, month-1, lastDayOfMonth);
			lastWeekOfMonth = cal.get(Calendar.WEEK_OF_MONTH);

			cal.set(year, month-1, day);

			for( int i=cal.get(Calendar.WEEK_OF_MONTH); i <= lastWeekOfMonth; i++ ) {
				v.addElement( fromDate.substring(0, 6) + i );
			}

			monthsDuringPeriod = getMonthsDuringPeriod( fromDate!=null?fromDate:"" , endDate!=null?endDate:"" );

			for( int i=0 ; i < monthsDuringPeriod.length ; i++ ) {
				year = Integer.parseInt((monthsDuringPeriod[i]).substring(0, 4));
				month= Integer.parseInt((monthsDuringPeriod[i]).substring(4, 6));

				lastDayOfMonth = getLastDayOfMonth((monthsDuringPeriod[i]).substring(0, 6));
				cal.set(year, month-1, lastDayOfMonth);
				lastWeekOfMonth = cal.get(Calendar.WEEK_OF_MONTH);

				for( int j=1; j <= lastWeekOfMonth; j++ ) {
					v.addElement((monthsDuringPeriod[i]).substring(0, 6) + i );
				}
			}

			year = Integer.parseInt(endDate.substring(0, 4));
			month= Integer.parseInt(endDate.substring(4, 6));
			day  = Integer.parseInt(fromDate.substring(6, 8));

			cal.set(year, month-1, day);
			lastWeekOfMonth = cal.get(Calendar.WEEK_OF_MONTH);

			for( int i=1 ; i <= lastWeekOfMonth; i++ ) {
				v.addElement( endDate.substring(0, 6) + i );
			}

			weeks = new String[v.size()];
			v.copyInto(weeks);			
		}else{
			weeks = new String[0];
		}



		return weeks;
	}

   /**
    * 오라클의 months_between과 같은 역할
	*
    * @param fromDate "20000710"
    * @param endDate	"20001111"
    * @return float - Month Between
    */
	public static float getMonthsBetweenPeriod(String fromDate, String endDate) {
		Calendar cal = Calendar.getInstance();
		int fromYear, fromMonth, fromDay, toYear, toMonth, toDay, lastDate;
		float monthsBetweenPeriod;

		fromYear = Integer.parseInt(fromDate.substring(0, 4));
		fromMonth= Integer.parseInt(fromDate.substring(4, 6));
		fromDay  = Integer.parseInt(fromDate.substring(6, 8));

		toYear = Integer.parseInt(endDate.substring(0, 4));
		toMonth= Integer.parseInt(endDate.substring(4, 6));
		toDay  = Integer.parseInt(endDate.substring(6, 8));

		lastDate = getLastDayOfMonth( fromDate );
		monthsBetweenPeriod = (float)((lastDate - fromDay - 1) / lastDate);

		monthsBetweenPeriod += (float)(12-fromMonth + (toYear-fromYear-1)*12 + toMonth-1);

		lastDate = getLastDayOfMonth( endDate );
		monthsBetweenPeriod += toDay / lastDate;

		return monthsBetweenPeriod;
	}
	
	   /**
	    * 포함된 월을 포함한 기간의 월차이 
		*
	    * @param fromDate "20000710"
	    * @param endDate	"20001111"
	    * @return int - 5
	    */
		public static int getMonthsBetweenPeriodi(String fromDate, String endDate) {
			Calendar cal = Calendar.getInstance();
			int fromYear, fromMonth, fromDay, toYear, toMonth, toDay, lastDate;

			int diff_mon=0;
			int diff_year=0;

			fromYear = Integer.parseInt(fromDate.substring(0, 4));
			fromMonth= Integer.parseInt(fromDate.substring(4, 6));
			fromDay  = Integer.parseInt(fromDate.substring(6, 8));

			toYear = Integer.parseInt(endDate.substring(0, 4));
			toMonth= Integer.parseInt(endDate.substring(4, 6));
			toDay  = Integer.parseInt(endDate.substring(6, 8));
			// 년도의 차이를 구한다
			diff_year = toYear-fromYear;
			// 년도가 다르면 개월수는 달라진다
			if(diff_year > 0){
				// 먼저 시작년도의 월수를 구한다
				diff_mon = 12-fromMonth+1;
				// 년도의 차이만큼 개월수를 더한다
				diff_mon = diff_mon + (12*(diff_year));
				// 마지막년도의 남은월을 빼준다
				diff_mon = diff_mon - (12-toMonth);
				
			}else{
				diff_mon = toMonth-fromMonth+1;
			}
	
			
			return diff_mon;
		}	

   /**
    * 두 기간동안의 날수
	*
    * @param fromDate "20000710"
    * @param toDate	"20001111"
    * @return float Month Between days
    */
	public static int getDaysBetweenPeriod(String fromDate, String toDate) {
		Calendar cal = Calendar.getInstance();
		int fromYear, fromMonth, fromDay, toYear, toMonth, toDay, curDay, year;
		int daysBetweenPeriod;
		int temp;

		fromYear = Integer.parseInt(fromDate.substring(0, 4));
		fromMonth= Integer.parseInt(fromDate.substring(4, 6));
		fromDay  = Integer.parseInt(fromDate.substring(6, 8));

		toYear = Integer.parseInt(toDate.substring(0, 4));
		toMonth= Integer.parseInt(toDate.substring(4, 6));
		toDay  = Integer.parseInt(toDate.substring(6, 8));

		/* fromDate가 toDate보다 클 경우 swap해주는 루틴 */
		if (fromDate.compareTo(toDate) > 0) {
			temp = fromYear;
			fromYear = toYear;
			toYear = temp;
			temp = fromMonth;
			fromMonth = toMonth;
			toMonth = temp;
			temp = fromDay;
			fromDay = toDay;
			toDay = temp;
		}

		cal.set( toYear, toMonth-1, toDay );
		daysBetweenPeriod = cal.get( Calendar.DAY_OF_YEAR );

		cal.set( fromYear, fromMonth-1, fromDay );
		curDay = cal.get( Calendar.DAY_OF_YEAR );

		if (toYear==fromYear) {
			daysBetweenPeriod -= curDay;
		} else {
			if ( ((fromYear%4 == 0) && (fromYear%100 != 0)) || (fromYear%400 == 0) ) {
				daysBetweenPeriod += 365 - curDay;
			} else {
				daysBetweenPeriod += 364 - curDay;
			}

			for( year=fromYear+1; year < toYear; year++ ) {
				if ( ((year%4 == 0) && (year%100 != 0)) || (year%400 == 0) ) {
					daysBetweenPeriod += 366;
				} else {
					daysBetweenPeriod += 365;
				}
			}
		}

		return daysBetweenPeriod;
	}

   /**
	* 문자열의 값이 일자값인지 검증
	*
	* @param textDate 일자값을 가진 8자리 문자열 예) '20010806'
	* @return 일자값이면 true, 아니면 false
	*/
	public static boolean isDate( String textDate ) throws IOException, SQLException, Exception {
		try {
			dateCheck(textDate);
		}catch(IOException e){
			return false;	
		}catch(SQLException e){
			return false;
		}catch ( Exception e ) {
			return false;
		}
		return true;
   	}

	// 내부적인 Date Value Check용 임
	private static void dateCheck( String textDate ) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		if ( textDate.length() != 8 ) {
			log.debug("[" + textDate + "] is not date value");
			return;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		try {
			sdf.setLenient( false );
			java.util.Date dt = sdf.parse(textDate);
		}catch(NullPointerException e){
			log.debug("[" + textDate + "] is not date value");	
		}catch(ArrayIndexOutOfBoundsException e){
			log.debug("[" + textDate + "] is not date value");
		}catch(Exception e) {
			log.debug("[" + textDate + "] is not date value");
		}
		return;
   	}

   /**
	* 일자값을 가진 8자리 문자열로 Calendar 객체를 생성
	*
	* @param textDate 일자값을 가진 8자리 문자열 예) '20010806'
	* @return Calendar 객체
	*/
    public static Calendar getCalendar(String textDate) throws Exception{
    	dateCheck(textDate);
    	int year = Integer.parseInt(textDate.substring(0,4));
    	int month = Integer.parseInt(textDate.substring(4,6));
    	int date = Integer.parseInt(textDate.substring(6));
    	Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
    	cal.set(year,month-1,date);
        return cal;
    }

   /**
	* 일자값을 가진 8자리 문자열로 Date 객체를 생성
	* @param textDate 일자값을 가진 8자리 문자열 예) '20010806'
	* @return Date 객체
	*/
    public static java.util.Date getDate(String textDate) throws Exception{
        return getCalendar(textDate).getTime();
    }

   /**
	* 주어진 Date 객체를 이용하여 주어진 패턴 날짜형의 문자열을 구함.
	*
	* @param date 원하는 일자의 Date 객체
	* @param pattern 원하는 일자 패턴
	* @return 주어진 패턴의 일자
	*/
    public static String getDateString(java.util.Date date, String pattern){
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }

   /**
	* 주어진 Date 객체를 이용하여 기본날짜형('yyyyMMdd')의 문자열을 구함.
	*
	* @param date 원하는 일자의 Date 객체
	* @return 주어진 패턴의 일자
	*/
    public static String getDateString(java.util.Date date) throws Exception{
        return getDateString(date, "yyyyMMdd");
    }

   /**
	* 주어진 일자를 이용하여 주어진 패턴 날짜형의 문자열을 구함.
	*
	* @param textDate 일자값을 가진 8자리 문자열 예) '20010806'
	* @param pattern 원하는 일자 패턴
	* @return 주어진 패턴의 일자
	*/
    public static String getDateString(String textDate, String pattern)  throws Exception{
        return getDateString(getDate(textDate), pattern);
    }

   /**
	* 주어진 패턴 날짜형 시스템일자를 구함
	*
	* @param pattern 원하는 일자 패턴
	* @return 시스템 일자
	*/
    public static String getToday(String pattern){
        return getDateString(new java.util.Date(), pattern);
    }

   /**
	* 기본패턴('yyyyMMdd') 날짜형 시스템일자를 구함
	*
	* @return 기본형('yyyyMMdd')의 시스템 일자
	*/
    public static String getToday(){
        return getToday("yyyyMMdd");
    }

   /**
	* 기본패턴('HHmmss') 날짜형 시스템시간을 구함
	*
	* @return 기본형('HHmmss')의 시스템 시간
	*/
    public static String getTime(){
        return getToday("HHmmss");
    }

   /**
	* 지정한 분리자를 이용한 시스템일자를 구함
	*
	* @param delmt 원하는 분리자 문자 예) ':', '/' ...
	* @return 분리자가 삽입된 시스템 시간
	*/
    public static String getTime(char delmt){
        return getToday("HH" + delmt + "mm" + delmt + "ss");
    }

   /**
	* 지정된 일자로 부터 일정기간 이후의 일자를 구함
	*
	* @param fromDate 시작일자
	* @param termDays 원하는 기간
	* @param both 양편넣기 여부
	* @return 일정기간 이후의 일자 ('yyyyMMdd')
	*/
    public static String getToDate(String fromDate, int termDays, boolean both) throws Exception{
    	if (both) termDays = termDays - 1;
    	Calendar cal = getCalendar(fromDate);
    	cal.add(Calendar.DATE, termDays);
        return getDateString(cal.getTime(),"yyyyMMdd");
    }

   /**
	* 지정된 일자로 부터 일정기간 이후의 일자를 한편넣기방식으로 구함.
	*
	* @param fromDate 시작일자
	* @param termDays 원하는 기간
	* @return 일정기간 이후의 일자 ('yyyyMMdd')
	*/
    public static String getToDate(String fromDate, int termDays) throws Exception{
        return getToDate(fromDate, termDays, false);
    }

   /**
	* 시작일로부터 종료일까지의 일수를 구함
	*
	* @param fromDate 시작일자
	* @param toDate 종료일자
	* @param both 양편넣기 여부
	* @return 시작일자로 부터 종료일까지의 일수
	*/
    public static int getDiffDays(java.util.Date fromDate, java.util.Date toDate, boolean both){
		long diffDays = toDate.getTime() - fromDate.getTime();
		long days = diffDays / (24 * 60 * 60 * 1000);
		if (both){
			if (days >= 0) days += 1; else days -= 1;
		}
		return new Long(days).intValue();
    }

   /**
	* 시작일로부터 종료일까지의 일수를 한편넣기로 계산함.
	*
	* @param fromDate 시작일자
	* @param toDate 종료일자
	* @return 시작일자로 부터 종료일까지의 일수
	*/
    public static int getDiffDays(java.util.Date fromDate, java.util.Date toDate){
		return getDiffDays(fromDate, toDate, false);
    }

   /**
	* 시작일로부터 종료일까지의 일수를 구함
	*
	* @param fromDate 시작일자
	* @param toDate 종료일자
	* @param both 양편넣기 여부
	* @return 시작일자로 부터 종료일까지의 일수
	*/
    public static int getDiffDays(String fromDate, String toDate, boolean both) throws Exception{
		return getDiffDays(getDate(fromDate),getDate(toDate), both);
    }

   /**
	* 시작일로부터 종료일까지의 일수를 한편넣기로 계산함.
	*
	* @param fromDate 시작일자
	* @param toDate 종료일자
	* @return 시작일자로 부터 종료일까지의 일수
	*/
    public static int getDiffDays(String fromDate, String toDate) throws Exception{
		return getDiffDays(getDate(fromDate),getDate(toDate), false);
    }
    
    /**
	* 시작일로부터 날짜 증가함수
	*
	* @param datestr 시작일자(yyyyMMdd)
	* @param flag (+,-)
	* @param num 증가일,감소일
	* @return 시작일자로 부터 종료일까지의 일수
	*/
    
	public static String getadddate(String datestr,String flag, int num){
       	
		int iyyyy = Integer.parseInt(datestr.substring(0,4));
		int imm	  = Integer.parseInt(datestr.substring(4,6));
		int idd	  = Integer.parseInt(datestr.substring(6,8));
	
		Calendar cal = Calendar.getInstance();
		if(flag.equals("+")){
			cal.set(iyyyy,imm-1,idd+num);
		}else if(flag.equals("-")){
			cal.set(iyyyy,imm-1,idd-num);
		}
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
		return sdf.format(cal.getTime());
	}
	
	public static String getaddmon(String datestr,String flag, int num){
       	
		int iyyyy = Integer.parseInt(datestr.substring(0,4));
		int imm	  = Integer.parseInt(datestr.substring(4,6));
		int idd	  = Integer.parseInt(datestr.substring(6,8));
	
		Calendar cal = Calendar.getInstance();
		if(flag.equals("+")){
			cal.set(iyyyy,imm-1+num,idd);
		}else if(flag.equals("-")){
			cal.set(iyyyy,imm-1-num,idd);
		}
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
		return sdf.format(cal.getTime());
	}	
	
	public static String getaddyear(String datestr,String flag, int num){
       	
		int iyyyy = Integer.parseInt(datestr.substring(0,4));
		int imm	  = Integer.parseInt(datestr.substring(4,6));
		int idd	  = Integer.parseInt(datestr.substring(6,8));
	
		Calendar cal = Calendar.getInstance();
		if(flag.equals("+")){
			cal.set(iyyyy+num,imm-1,idd+num);
		}else if(flag.equals("-")){
			cal.set(iyyyy-num,imm-1,idd-num);
		}
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
		return sdf.format(cal.getTime());
	}
	
	/**
	 * 카렌다 객체를 받아서 해당하는 날짜를 8자리 String으로 리턴
	 * @param day
	 * @return
	 */
	public static String getDateString(Calendar day) {
		String str = "" + day.get(Calendar.YEAR); // 년;

		int thisMonth = day.get(Calendar.MONTH) + 1; // 월 ( 0 ~ 11 )= 0;

		if ( thisMonth < 10 ) {
			str += "0";
		}

		str += "" + thisMonth ;

		int thisDate = day.get(Calendar.DATE) ; // 월 ( 0 ~ 11 )= 0;

		if ( thisDate < 10 ) {
			str += "0";
		}

		str += "" + thisDate ;

		return str;
	}

	/**
	 * 날짜의 요일값을 받아서 한글요일 String으로 리턴
	 * @param day
	 * @return
	 */
	public static String getDayName(int day){
		String str = "";
		if ( day == 1 ) {
			str = "일";
		} else if ( day == 2 ) {
			str = "월";
		} else if ( day == 3 ) {
			str = "화"; 
		} else if ( day == 4 ) {
			str = "수";
		} else if ( day == 5 ) {
			str = "목";
		} else if ( day == 6 ) {
			str = "금";
		} else if ( day == 7 ) {
			str = "토";
		}
		return str; 
	}

	// 해당하는 월의 실재 월을 리턴
	public static int getMonthNum(int month){
		return month + 1 ;
	}  
	
	// 년월일을 int형으로 받아서 'YYYYMMDD'형의 String 으로 리턴
	public static String getIntTodateStr(int year, int mon, int day){
		String rtn_str = "";
		String tmp_str = "";
		mon = mon+1;
		if(mon < 10){
			tmp_str = "0"+mon;
		}else{
			tmp_str = ""+mon;
		}
		rtn_str = year+tmp_str;
		if(day < 10){
			tmp_str = "0"+day;
		}else{
			tmp_str = ""+day;
		}
		rtn_str = rtn_str+tmp_str;
		return rtn_str;
	}
	
	//날짜연별셀렉트박스로 가져오기
	public static String getYearOption(){
		StringBuffer sb   = new StringBuffer();
		String curDate = DateUtility.getToday();
		int curYear = Integer.parseInt(curDate.substring(0,4));
		
  		sb.append("<option title='"+curYear+"' value='" + curYear + "' selected>" + curYear + "</option>");
 
  		for(int i = curYear-1; i >= 2012; i--){
  			sb.append("<option title='"+i+"' value='" + i + "'>" + i + "</option>");
  		}
		return sb.toString();
	}
	
	//날짜월별별셀렉트박스로 가져오기
	public static String getMonthOption(){
		StringBuffer sb   = new StringBuffer();
		String curDate = DateUtility.getToday();
		String sel = "";
		int curMonth = Integer.parseInt(curDate.substring(4,6));
		
  		for(int i = 1; i < 10; i++){
   			if(i == curMonth){
   				sel = "selected";
   			}else{
   				sel = "";
   			}
  			sb.append("<option title='0"+i+"' value='0" + i + "'" + sel + ">" + i + "</option>");
  		}
  		for(int i = 10; i <= 12; i++){
  			if(i == curMonth){
   				sel = "selected";
   			}else{
   				sel = "";
   			}
  			sb.append("<option title='"+i+"' value='" + i + "'" + sel + ">" + i + "</option>");
  		}
		return sb.toString();
	}
	
	// TODO : GMT2Cal
    public static String GMT2Cal(String dategmtstr){ 
 
        // GMT String을 Date 로 변환 
    	//Date inputdate = new Date("Mon Oct 07 2013 00:00:00 GMT+0900 (대한민국 표준시)"); 
    	Date inputdate = new Date(dategmtstr); 
    	
       
        // Date 를 Calendar 로 변환 
        Calendar cal = Calendar.getInstance(); 
        cal.setTime(inputdate) ; 
         
        // 변환된 내용 확인 
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        return sd.format(cal.getTime());
         
    } 
    
}