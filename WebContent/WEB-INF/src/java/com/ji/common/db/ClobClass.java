/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.db.ClobClass.java
 * Description        : 오라클 CLOB타입을 데이터베이스에 매칭하는  클래스.
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
package com.ji.common.db;

import java.io.IOException;
import java.io.Reader;
import java.io.Serializable;
import java.io.StringReader;
import java.sql.SQLException;
import oracle.sql.CLOB;

public class ClobClass implements Serializable{
	private int contlen;
	private StringReader cont_sr;
	public int getContlen() { return contlen; }
	public void setContlen(int contlen) 
	{ 
		this.contlen = contlen; 
	}
	public StringReader getCont_sr() { return cont_sr; }
	public void setCont_sr(StringReader cont_sr) 
	{ 
		this.cont_sr = cont_sr; 
	}	
	
	public static String getClobStr(CLOB cdata) throws SQLException, IOException{
	      Reader reader = cdata.getCharacterStream();   
	      char[] char_array = new char [(int)(cdata.length())];
	      int rcnt = reader.read(char_array);

	      String contents = (new String(char_array));

	      reader.close();
	      
		return contents;
		
	}
}