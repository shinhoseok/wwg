package com.ji.cm;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.dao.cm.CMDAO;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("sendEmail")
public class SendEmail extends CmsDsDao{
	protected Logger log = Logger.getLogger(SendEmail.class); //현재 클래스 이름을 Logger에 등록
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    
    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;
    
	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    /** mailMgr */
    @Resource(name="mailMgr")
    private MailMgr mailMgr;	//메일발송     


    public Map start(Map param) throws Exception {
    	
    	DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);
    	
    	Map result_map = new HashMap();
    	Map mailsend_map = new HashMap();
    	
    	try{
			log.debug("==== Email Insert Start ====");
			
			String sql_id="";
			sql_id="JiCmCms.insertEmail";
			param.put("gubun", HtmlTag.returnString((String) param.get("gubun"),"동반성장 오픈플랫폼"));
			
			String mailto=HtmlTag.returnString((String)param.get("mailto"),"");
			String mailfrom=HtmlTag.returnString((String)param.get("mailfrom"),"");
			String mailcontent=HtmlTag.returnString((String)param.get("content"),"");

			String mailTo = "";
			String mailToName = "";
			String mailFrom = "";
			String mailFromName = "";
			
			Pattern patn = null;
			Matcher matr = null;
			if(mailto!=null){
				patn = Pattern.compile("<(.*?)>");
				matr = patn.matcher(mailto);	
				if(matr.find()){
					mailTo = matr.group(1);
				}
				patn = Pattern.compile("\"(.*?)\"");
				matr = patn.matcher(mailto);	
				if(matr.find()){
					mailToName = matr.group(1);
				}				
				
			}else{
				mailTo = "";
			}
			
			if(mailfrom!=null){
				patn = Pattern.compile("<(.*?)>");
				matr = patn.matcher(mailfrom);	
				if(matr.find()){
					mailFrom = matr.group(1);
				}
				patn = Pattern.compile("\"(.*?)\"");
				matr = patn.matcher(mailfrom);	
				if(matr.find()){
					mailFromName = matr.group(1);
				}				
			}else{
				mailFrom = "";
			}			
			/////////////////////////////////////////////////////////////////////
			if(mailTo.equals("") || mailFrom.equals("")){
				log.debug("실운영 메일====::전송실패:mailTo:"+mailTo+":mailFrom:"+mailFrom);
				result_map.put("result", false);
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");					
				result_map.put("TRS_MSG", "이메일 전송실패");				
			}else{
				mailsend_map = new HashMap();	
				mailsend_map.put("mailTo", mailTo);
				mailsend_map.put("mailToName", mailToName);				
					
				mailsend_map.put("mailTitle", HtmlTag.returnString((String)param.get("subject"),""));

				int JIT8110_MAIL_SEQ = 0;
				JIT8110_MAIL_SEQ = cmDAO.getSequence("JIT8110_MAIL_SEQ");
				
				// com.ji.dao.cm.mtm.CmMtmDAO01 에 정의됨
				String mail_chk_url="<img src='"+HtmlTag.returnString(propertiesService.getString("CM_SYSTEM_URL"),"")
						+""+HtmlTag.returnString(propertiesService.getString("CON_ROOT"),"")
						+"/cmsmain.do?scode=000008&pcode=000047&pstate=MCK&mailseq="+JIT8110_MAIL_SEQ+"' title='메일확인' style='display:none;width:0px;height:0px;'/>";
				String mailcontent2 = mailcontent.replaceAll("\\{수신확인}",mail_chk_url);
				mailcontent = mailcontent.replaceAll("\\{수신확인}","");
				
				mailsend_map.put("mailContents", mailcontent2);
				mailsend_map.put("mailFrom", mailFrom);
				mailsend_map.put("mailFromName", mailFromName);	
				
				//////////////////////////// 메일전송이력

				
				param.put("MAIL_SEQ", ""+JIT8110_MAIL_SEQ);
				param.put("MAIL_SUBJECT", HtmlTag.returnString((String)mailsend_map.get("mailTitle"),""));
				param.put("MAIL_CONTENTS", mailcontent);

				insert(sql_id, param);
				////////////////////////////메일전송이력
					
				
				/* TODO : 추후 실운영에서 반영*/
				
				
				if(mailMgr.sendMail(mailsend_map)){
					log.debug("실운영 메일====::전송성공:mailTo:"+mailTo+":mailFrom:"+mailFrom);
					result_map.put("result", true);
					result_map.put("TRS_MSG", "");					
	     			
				}else{
					log.debug("실운영 메일====::전송실패:mailTo:"+mailTo+"::"+mailToName+":mailFrom:"+mailFrom+"::"+mailFromName);
					log.debug("실운영 메일====::전송실패:mailto:"+mailto+":mailfrom:"+mailfrom);
					result_map.put("result", false);
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");					
					result_map.put("TRS_MSG", "이메일 전송실패");
				} 	
							
			}
			
			//insert(sql_id, param);
			
			//txManagerds2.commit(txStatus);
			
			log.debug("====  Email Insert End ====");
			

			
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result","Email Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			log.debug("Email Insert Exception:");	
			throw q;
			
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result","Email Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			log.debug("Email Insert Exception:");	
			throw q;
			
		}catch(JSysException q){
			log.debug("Email Insert JSysException:");			
			throw q;
			
		}catch(Exception q){
			result_map.put("result","Email Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));		
			log.debug("Email Insert Exception:");			
			throw q;
		}finally{
			
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
	
		}
	    	log.debug("==== multiDBTest : END ====");
	    	return result_map;
	    	
	   }

}
