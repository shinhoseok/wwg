/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.SelectItem.java
 * Description        : 객체의 SET, GET처리에 관련된 기능을 제공하는 클래스.
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

/**
 * @author 이금용
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.util.*;
import java.sql.Timestamp;

public class SelectItem implements java.io.Serializable{ 

    private String name="";
	private String value="";

    public SelectItem(){
	}

    public SelectItem(String name, String value){
	   this.value = value;
	   this.name = name;
	}

	public void setName(String name){
	    this.name = name;
	}
    public String getName(){
	    return name;
	}

	public void setValue(String value){
	    this.value = value;
	}
	public String getValue(){
	    return value;
	}
}
