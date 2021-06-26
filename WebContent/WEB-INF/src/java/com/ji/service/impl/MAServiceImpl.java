package com.ji.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.dao.cm.MADAO;
import com.ji.service.MAService;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;



@Service("maService")
public class MAServiceImpl extends AbstractServiceImpl implements MAService {
	protected Logger log = Logger.getLogger(MAServiceImpl.class);
	
	/** maServiceDAO */
    @Resource(name="maDAO")
    private MADAO maDAO;
    
    //event end
    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;     
    
	// TODO ctlCMS
	@Override
	public Map ctlCMS(Map param) throws JSysException, Exception {
		
		Map rtn_map=new HashMap();

		DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);
		
		try{

			String scode = HtmlTag.returnString((String)param.get("scode"),"S01");
			String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
			String pcode = HtmlTag.returnString((String)param.get("pcode"),"main");
	
			if(scode.indexOf("S01") > -1 && pcode.indexOf("main") > -1){	//sample용 
				rtn_map  = maDAO.ctlCMS(param);	
		
			}			
		
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			txManagerds.rollback(txStatus);
			throw new JSysException("JSysException",q);	
		}catch(Exception q){				
			log.debug("ctlCMS Exception >>>>> :  ");	
			txManagerds.rollback(txStatus);
			throw new JSysException("Exception",q);
		}
		txManagerds.commit(txStatus);
		
		return rtn_map;
	}	    
    // TODO getListMD
	@Override
	public Map getListMD(Map param) throws Exception {
		return maDAO.getListMD(param);
	}
	
    // TODO getListAdminMD
	@Override
	public Map getListAdminMD(Map param) throws Exception {
		return maDAO.getListAdminMD(param);
	}	

	
    // TODO getSiteLogin
	@Override
	public Map getSiteLogin(Map param) throws Exception {
		return maDAO.getSiteLogin(param);
	}
	
    // TODO loginPinChg
	@Override
	public Map loginPinChg(Map param) throws Exception {
		return maDAO.loginPinChg(param);
	}
	
    // TODO loginPinSearch
	@Override
	public Map loginPinSearch(Map param) throws Exception {
		return maDAO.loginPinSearch(param);
	}	
	
	
    // TODO loginPinAuthSend
	@Override
	public Map loginPinAuthSend(Map param) throws Exception {
		return maDAO.loginPinAuthSend(param);
	}	
	
}
