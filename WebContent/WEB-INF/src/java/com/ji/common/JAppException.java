/*===================================================================================
 * System             : 유틸리티 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.JAppException
 * Description        : 애플리케이션에서 비즈니스 로직 수행중 예외사항을 처리 하기 위한 클래스
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-05-28
 * Updated Date       : 2011-05-28
 * Last modifier      : 이금용
 * Updated content    : 패키지명 변경
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.io.PrintStream;
import java.io.PrintWriter;


/**
 * <pre>
 * 애플리케이션에서 비즈니스 로직 수행 시 예외사항을 처리 하기 위한 클래스
 * 
 *  Runtime 시 발생 하는 예외 처리 시 사용한다.
 * 
 * try {
 *   ..
 * } catch (Exception e) {
 * 	thrwo new JAppException(e);
 * }
 * 	
 * </pre>
 * @author 
 * @version 
 */ 

public class JAppException extends RuntimeException {
	
	/**
	 * 메시지 key와 Origin Exception Instance 정보를 얻기 위한 에외 사항 처리.
	 * 
	 */
    public JAppException(String msg, Throwable th) {
        super(msg, th);
    }
	
	/**
	 * 메시지 key 만으로 에외 사항 처리한다.
	 */
    public JAppException(String msg) {
        super(msg);
    }

	/**
	 * Origin Exception Instance 정보를 위한 예외 사항 처리
	 */
    public JAppException(Throwable th) {
        super(th);
    }

    /**
     * Exception 원인에 대한 Stack Trace를 Print 한다.
     */
    public void printStackTrace(PrintStream s) {
        if (super.getCause() != null) {
            s.print(getClass().getName() + " Caused by: ");
            
        } else {
            
        }
    }

    /**
     * Exception 원인에 대한 Stack Trace를 Print 한다.
     */
    public void printStackTrace(PrintWriter s) {
        if (super.getCause() != null) {
            s.print(getClass().getName() + " Caused by: ");
           
        } else {
            
        }
    }

}
