package com.ji.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ji.dao.cm.CMDAO;
import com.ji.dao.cm.oam.CmOamDAO02;
import com.ji.dao.cm.oam.CmOamDAO03;
import com.ji.dao.cm.sta.CmStaDAO;
import com.ji.service.CMService;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("cmService")
public class CMServiceImpl extends AbstractServiceImpl implements CMService {
	/** cmService */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
	/** cmOamDAO02 */
    @Resource(name="cmOamDAO02")
    private CmOamDAO02 cmOamDAO02;
    
	/** cmOamDAO03 */
    @Resource(name="cmOamDAO03")
    private CmOamDAO03 cmOamDAO03;  
    
	/** cmStaDAO */
    @Resource(name="cmStaDAO")
    private CmStaDAO cmStaDAO;    
    

    // TODO getMenuTree
	@Override
	public Map getMenuTree(HashMap param) throws Exception {
		return cmDAO.getMenuTree(param);
	}

    // TODO getMyMenu
	@Override
	public Map getMyMenu(HashMap param) throws Exception {
		return cmDAO.getMyMenu(param);
	}	
	
	
    // TODO getSiteLogin
	@Override
	public Map getSiteLogin(Map param) throws Exception {
		return cmDAO.getSiteLogin(param);
	}
	
    // TODO getMenuCfg
	@Override
	public Map getMenuCfg(String scode, String pcode) throws Exception {
		return cmDAO.getMenuCfg(scode, pcode);
	}

	@Override
	public Map getAdmSubAuth(String user_id) throws Exception {
		return cmDAO.getAdmSubAuth(user_id);
	}	
	
    // TODO getAdmLogin
	@Override
	public Map getAdmLogin(Map param) throws Exception {
		return cmDAO.getAdmLogin(param);
	}	
	
	@Override
	public Map getIpCfg(String user_ip) throws Exception {
		return cmDAO.getIpCfg(user_ip);
	}	
	
	@Override
	public Map getAdmLeft() throws Exception {
		return cmDAO.getAdmLeft();
	}
	
    // TODO insertJIT9120_UPDATEJob
	@Override
	public Map insertJIT9120_UPDATEJob(Map param) throws Exception {
		return cmOamDAO02.insertJIT9120_UPDATEJob(param);
	}

    // TODO deleteAuthLogJob
	@Override
	public Map deleteAuthLogJob(Map param) throws Exception {
		return cmOamDAO03.deleteAuthLogJob(param);
	}

    // TODO deleteAccessLogJob
	@Override
	public Map deleteAccessLogJob(Map param) throws Exception {
		return cmStaDAO.deleteAccessLogJob(param);
	}	
	
	@Override
	public Map getAdmInfo() throws Exception {
		return cmDAO.getAdmInfo();
	}



	
}
