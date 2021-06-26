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
import com.ji.dao.cm.ABDDAO;
import com.ji.dao.cm.board.CommonBoardDAO;
import com.ji.service.ABDService;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("abdService")
public class ABDServiceImpl extends AbstractServiceImpl implements ABDService {
	protected Logger log = Logger.getLogger(ABDServiceImpl.class);
	/** abdService */
    @Resource(name="abdDAO")
    private ABDDAO abdDAO;
    
    @Resource(name="commonBoardDAO")
    private CommonBoardDAO commonBoardDAO;
    
    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;
    

    // TODO ctlABD
	@Override
	public Map ctlABD(Map param) throws Exception {

		Map rtn_map=new HashMap();
		DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);	
	
			try{
				String scode = (String) param.get("scode");
				if(scode.equals("S01")) {
					rtn_map = abdDAO.ctlCMS(param);
				} else {
					rtn_map = commonBoardDAO.ctlCMS(param);
				}
				
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

