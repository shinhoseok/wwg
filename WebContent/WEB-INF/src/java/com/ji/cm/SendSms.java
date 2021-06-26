package com.ji.cm;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ji.common.JSysException;
import com.ji.util.CmsDs3Dao;

import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("sendSms")
public class SendSms extends CmsDs3Dao{
	protected Logger log = Logger.getLogger(SendSms.class); //현재 클래스 이름을 Logger에 등록
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
    
    
    @Resource(name="txManagerds3")
    private PlatformTransactionManager txManagerds3;
    
    
    public Map start(Map param) throws Exception {
    	
    	DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds3.getTransaction(txcDefinition);
    	
    	Map result_map = new HashMap();
    	
    	try{
			log.debug("==== SMS Inser Start ====");
			
			String sql_id="";	
			sql_id="JiCmCms.insertSMS";
			
			insert(sql_id, param);
			
			txManagerds3.commit(txStatus);
			
			log.debug("==== LMS Inser End ====");
			
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		

		}catch(NullPointerException q){
			log.debug("NullPointerException:"+q);
			result_map.put("result","SMS Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			log.debug("SMS Insert Exception:");	
			//throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:"+q);
			result_map.put("result","SMS Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
			log.debug("SMS Insert Exception:");	
			//throw q;
		}catch(JSysException q){
			log.debug("SMS Insert JSysException:"+q);			
			//throw q;			
		}catch(Exception q){
			log.debug("SMS Insert Exception:"+q);
			result_map.put("result","SMS Insert 중 에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));		
						
			//throw q;
		}finally{
			
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
	
		}
	    	log.debug("==== multiDBTest : END ====");
	    	return result_map;
	    	
    }
      
}
