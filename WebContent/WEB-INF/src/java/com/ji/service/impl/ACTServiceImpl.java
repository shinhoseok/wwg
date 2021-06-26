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

import com.ji.common.JSysException;
import com.ji.dao.cm.ACTDAO;
import com.ji.service.ACTService;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("actService")
public class ACTServiceImpl extends AbstractServiceImpl implements ACTService {
	protected Logger log = Logger.getLogger(ACTServiceImpl.class);
	
	/** actService */
    @Resource(name="actDAO")
    private ACTDAO actDAO;
    
    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;
    
    // TODO ctlACT
	@Override
	public Map ctlACT(Map param) throws Exception {
		Map rtn_map=new HashMap();		
		DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);	
	
			try{
				rtn_map = actDAO.ctlCMS(param);
			}catch(JSysException q){	
				log.debug("throw JSysException >>>>> :  ");	
				txManagerds.rollback(txStatus);
				throw q;	
			}catch(Exception q){				
				log.debug("ctlCMS Exception >>>>> :  ");	
				txManagerds.rollback(txStatus);
				throw new JSysException("Exception",q);
			}
			txManagerds.commit(txStatus);		
			return rtn_map;		

	}

}

