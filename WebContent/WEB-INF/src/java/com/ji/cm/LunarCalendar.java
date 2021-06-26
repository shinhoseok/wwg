/*===================================================================================
 * System             : ��ƿ��Ƽ �ý���
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.cm.MailMgr
 * Description        : ���ϰ�  ��õ� �ټ��� ����� �����ϴ� Ŭ����.
 * Author             : �̱ݿ�
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2006-10-23
 * Updated Date       : 2006-10-23
 * Last modifier      : �̱ݿ�
 * Updated content    : 
 * License            : 
 *==================================================================================*/
package com.ji.cm;


import com.ibm.icu.util.Calendar;
import com.ibm.icu.util.ChineseCalendar;

public class LunarCalendar {

 private Calendar cal;
 private ChineseCalendar cc;

 public LunarCalendar() {
  cal = Calendar.getInstance();
  cc = new ChineseCalendar();
 }

 /**
  * ���(yyyyMMdd) -> ����(yyyyMMdd)
  * 
  */
 public synchronized String toLunar(String yyyymmdd) {
  if (yyyymmdd == null)
   return "";

  String date = yyyymmdd.trim();
  if (date.length() != 8) {
   if (date.length() == 4)
    date = date + "0101";
   else if (date.length() == 6)
    date = date + "01";
   else if (date.length() > 8)
    date = date.substring(0, 8);
   else
    return "";
  }

  cal.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
  cal.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
  cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));

  cc.setTimeInMillis(cal.getTimeInMillis());

  // ChinessCalendar.YEAR �� 1~60 ������ ���� ������ ,
  // ChinessCalendar.EXTENDED_YEAR �� Calendar.YEAR ���� 2637 ��ŭ�� ���̸� ����ϴ�.
  int y = cc.get(ChineseCalendar.EXTENDED_YEAR) - 2637;
  int m = cc.get(ChineseCalendar.MONTH) + 1;
  int d = cc.get(ChineseCalendar.DAY_OF_MONTH);

  StringBuffer ret = new StringBuffer();
  if (y < 1000)
   ret.append("0");
  else if (y < 100)
   ret.append("00");
  else if (y < 10)
   ret.append("000");
  ret.append(y);

  if (m < 10)
   ret.append("0");
  ret.append(m);

  if (d < 10)
   ret.append("0");
  ret.append(d);

  return ret.toString();
 }

 /**
  * ����(yyyyMMdd) -> ���(yyyyMMdd)
  * 
  */
 public synchronized String fromLunar(String yyyymmdd) {
  if (yyyymmdd == null)
   return "";

  String date = yyyymmdd.trim();
  if (date.length() != 8) {
   if (date.length() == 4)
    date = date + "0101";
   else if (date.length() == 6)
    date = date + "01";
   else if (date.length() > 8)
    date = date.substring(0, 8);
   else
    return "";
  }

  cc.set(ChineseCalendar.EXTENDED_YEAR, Integer.parseInt(date.substring(
    0, 4)) + 2637);
  cc.set(ChineseCalendar.MONTH,
    Integer.parseInt(date.substring(4, 6)) - 1);
  cc.set(ChineseCalendar.DAY_OF_MONTH, Integer
    .parseInt(date.substring(6)));

  cal.setTimeInMillis(cc.getTimeInMillis());

  int y = cal.get(Calendar.YEAR);
  int m = cal.get(Calendar.MONTH) + 1;
  int d = cal.get(Calendar.DAY_OF_MONTH);

  StringBuffer ret = new StringBuffer();
  if (y < 1000)
   ret.append("0");
  else if (y < 100)
   ret.append("00");
  else if (y < 10)
   ret.append("000");
  ret.append(y);

  if (m < 10)
   ret.append("0");
  ret.append(m);

  if (d < 10)
   ret.append("0");
  ret.append(d);

  return ret.toString();
 }


 

}

