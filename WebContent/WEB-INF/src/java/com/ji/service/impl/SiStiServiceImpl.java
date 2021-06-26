package com.ji.service.impl;
import java.util.HashMap;import java.util.Map;
import javax.annotation.Resource;
import org.apache.log4j.Logger;import org.springframework.stereotype.Service;import org.springframework.transaction.PlatformTransactionManager;import org.springframework.transaction.TransactionDefinition;import org.springframework.transaction.TransactionStatus;import org.springframework.transaction.support.DefaultTransactionDefinition;
import com.ji.common.JSysException;import com.ji.dao.cm.sti.SiStiDAO;import com.ji.service.SiStiService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
@Service("siStiService")public class SiStiServiceImpl extends AbstractServiceImpl implements SiStiService {
	protected Logger log = Logger.getLogger(SiStiServiceImpl.class);
	/** asService */    @Resource(name="siStiDAO")    private SiStiDAO siStiDAO;
    @Resource(name="txManagerds")    private PlatformTransactionManager txManagerds;

	@Override	public Map insertAS(Map param) throws Exception {		Map rtn_map=new HashMap();		DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);	
		try{			rtn_map = siStiDAO.insertAS(param);
		}catch(JSysException q){				log.debug("throw JSysException >>>>> :  ");				txManagerds.rollback(txStatus);			throw q;	
		}catch(Exception q){							log.debug("ctlCMS Exception >>>>> :  ");				txManagerds.rollback(txStatus);			throw new JSysException("Exception",q);
		}
		txManagerds.commit(txStatus);		
		return rtn_map;		
	}
}
