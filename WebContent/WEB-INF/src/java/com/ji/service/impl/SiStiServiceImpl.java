package com.ji.service.impl;
import java.util.HashMap;
import javax.annotation.Resource;
import org.apache.log4j.Logger;
import com.ji.common.JSysException;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
@Service("siStiService")
	protected Logger log = Logger.getLogger(SiStiServiceImpl.class);
	/** asService */
    @Resource(name="txManagerds")

	@Override
		try{
		}catch(JSysException q){	
		}catch(Exception q){				
		}
		txManagerds.commit(txStatus);		
		return rtn_map;		
	}
}