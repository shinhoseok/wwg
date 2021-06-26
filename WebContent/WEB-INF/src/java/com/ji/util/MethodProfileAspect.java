package com.ji.util;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 컨트롤러 - 서비스 - DAO 간 메소드 호출 및 파라미터 정보 logging  
 */
@Service
@Repository
//@Aspect 미사용
@Order(value=2)
public class MethodProfileAspect {
	
	private Log logger = null;	
	private Map<String, String> jointMap = null;
	final int ADVICE_KIND_BEFORE = 0;
	final int ADVICE_KIND_AFTER  = 1;
	final int ADVICE_KIND_AROUND = 2;	

	@Pointcut("within(@org.springframework.stereotype.Controller *)")	
	public void controlMethod() {}
	
	@Pointcut("execution(* com.ji..*ServiceImpl.*(..))")
	public void serviceMethod() {}
	
	@Pointcut("execution(* com.ji..*DAO.*(..))")
	public void daoMethod() {}
	
	@Before("controlMethod() || daoMethod()")
	public void beforeTraceWeb(JoinPoint thisJoinPoint) {
		preSetJoinPointToMap(thisJoinPoint, true);
		printJoinPointMap(ADVICE_KIND_BEFORE);
	}
	
	@After("controlMethod()")
	public void afterTraceWeb(JoinPoint thisJoinPoint) {
		preSetJoinPointToMap(thisJoinPoint, false);
		printJoinPointMap(ADVICE_KIND_AFTER);
	}
	
	@Before("serviceMethod()")
	public void beforeTraceBiz(JoinPoint thisJoinPoint) {
		preSetJoinPointToMap(thisJoinPoint, true);
		printJoinPointMap(ADVICE_KIND_BEFORE);
	}
	
	/**
	 * AOP가 적용된 지점의 정보를 맵 데이터로 가공하여 설정한다.
	 * @param thisJoinPoint
	 * @param argValFlag
	 */
	private void preSetJoinPointToMap(JoinPoint thisJoinPoint, boolean argValFlag) {		
		HashMap<String, String> ajointMap = new HashMap<String, String>();
		Object[] arguments = thisJoinPoint.getArgs();
		
		StringBuffer argBuf = new StringBuffer();
		StringBuffer argValueBuf = new StringBuffer();
		
		try {
			int i = 0;
			for (Object argument : arguments) {
				String argClassName = argument.getClass().getSimpleName();
				if (i > 0) {
					argBuf.append(", ");
				}
				argBuf.append(argClassName + " arg" + ++i);
				if(argValFlag) {
					argValueBuf.append(".arg" + i + " : " + argument.toString() + "\n");
				}
			}
			ajointMap.put("argsExist",  i > 0 ? "Y" : "N");
			ajointMap.put("argsName",   argBuf.toString());
			ajointMap.put("argsValue",  argValueBuf.toString());
		}catch(NullPointerException e){
			ajointMap.put("argsExist",  "N");
			
		}catch(ArrayIndexOutOfBoundsException e){	
			ajointMap.put("argsExist",  "N");		
		} catch(Exception e) {//예외발생시 맵 파라미터 정보를 무시한다.
			ajointMap.put("argsExist",  "N");
		}
		jointMap.put("className",  thisJoinPoint.getTarget().getClass().getName());
		jointMap.put("methodName", thisJoinPoint.getSignature().getName());
	}
	
	/**
	 * 호출되는 Advice 유형에 따라 Pointcut 정보를 출력한다.
	 * @param adviceKind
	 */
	private void printJoinPointMap(int adviceKind) {
		String className = jointMap.get("className");
		String execMethod = jointMap.get("methodName") + "("+ jointMap.get("argsName") +") method";
		StringBuffer messageBuf = new StringBuffer();
		Log alogger = LogFactory.getLog(className);
		
		if(adviceKind == ADVICE_KIND_BEFORE) {
			messageBuf.append("before executing "+ execMethod);
			
			if(className.endsWith("ServiceImpl")) {
//				if(ComUtil.isCompareStr("Y", jointMap.get("argsExist"))) {
				if(StringUtils.equals("Y", jointMap.get("argsExist"))) {
					messageBuf.append("\n-------------------------------------------------------------------------------\n");
					messageBuf.append(jointMap.get("argsValue"));
					messageBuf.append("-------------------------------------------------------------------------------");
				}
			}
			
			if(alogger.isDebugEnabled()) {
				if(className.endsWith("Controller")) {
					alogger.debug(getCallsignPath() +"===========================================시작");										
				} 
				alogger.debug(messageBuf.toString());
			}
			
		} else if(adviceKind == ADVICE_KIND_AFTER) {
			messageBuf.append("after executed "+ execMethod);
			
			if(alogger.isDebugEnabled()) {
				alogger.debug(messageBuf.toString());
				alogger.debug(getCallsignPath() +"===========================================종료");
			}
		}
	}
	
	private String getCallsignPath() {
		String servletPath = "";
		try {					
			//if(ContextHolderUtil.isExistRequestAttributes()) {	
			if(RequestContextHolder.getRequestAttributes() != null) {	
				//HttpServletRequest curRequest = ContextHolderUtil.getContextRequest();
				HttpServletRequest curRequest = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
				servletPath += "ServletPath="+ curRequest.getServletPath();
				//servletPath += "?method="+ ComUtil.nullToEmpty(curRequest.getParameter("method"));
				servletPath += "?method="+ StringUtils.defaultIfEmpty(curRequest.getParameter("method"), "");
			}	
		}catch(NullPointerException e){
			System.out.println("getCallsignPath Exception  ");
			
		}catch(ArrayIndexOutOfBoundsException e){	
			System.out.println("getCallsignPath Exception  ");		
		} catch(Exception e) {
			System.out.println("getCallsignPath Exception  ");
		}
		return servletPath;
	}
	
	//@Around("controlMethod()")
	@Deprecated
    public Object logMethod(ProceedingJoinPoint joinPoint) throws Throwable{
        final Logger logger = LoggerFactory.getLogger(joinPoint.getTarget().getClass().getName());
        Object retVal = null;

        try {
            StringBuffer startMessageStringBuffer = new StringBuffer();

            startMessageStringBuffer.append("Start method ");
            startMessageStringBuffer.append(joinPoint.getSignature().getName());
            startMessageStringBuffer.append("(");

            Object[] args = joinPoint.getArgs();
            for (int i = 0; i < args.length; i++) {
                startMessageStringBuffer.append(args[i]).append(",");
            }
            if (args.length > 0) {
                startMessageStringBuffer.deleteCharAt(startMessageStringBuffer.length() - 1);
            }

            startMessageStringBuffer.append(")");

            logger.trace(startMessageStringBuffer.toString());

            StopWatch stopWatch = new StopWatch();
            stopWatch.start();

            retVal = joinPoint.proceed();

            stopWatch.stop();

            StringBuffer endMessageStringBuffer = new StringBuffer();
            endMessageStringBuffer.append("Finish method ");
            endMessageStringBuffer.append(joinPoint.getSignature().getName());
            endMessageStringBuffer.append("(..); execution time: ");
            endMessageStringBuffer.append(stopWatch.getTotalTimeMillis());
            endMessageStringBuffer.append(" ms;");

            logger.trace(endMessageStringBuffer.toString());
		}catch(NullPointerException e){
            StringBuffer errorMessageStringBuffer = new StringBuffer();
            //Create error message 
            logger.error(errorMessageStringBuffer.toString(), e);
            throw e;
			
		}catch(ArrayIndexOutOfBoundsException e){	
            StringBuffer errorMessageStringBuffer = new StringBuffer();
            //Create error message 
            logger.error(errorMessageStringBuffer.toString(), e);
            throw e;           
        } catch (Throwable ex) {
            StringBuffer errorMessageStringBuffer = new StringBuffer();
            //Create error message 
            logger.error(errorMessageStringBuffer.toString(), ex);
            throw ex;
        }

        return retVal;
    }
}
