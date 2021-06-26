package com.ji.dao.inter.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.inter.MenuDao;
import com.ji.vo.MenuVO;

@Repository("menuDao")
public class MenuDaoJdbc implements MenuDao {
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//사용자 탑메뉴, 사이트맵 / 관리자 레프트메뉴
	@SuppressWarnings("unchecked")
	public List<MenuVO> selectMenuList(MenuVO menuVO) throws Exception {
		return sql.queryForList("JiCmMnm.selectMenuList", menuVO);
	}
	
	//메뉴 상세정보(하위메뉴리스트)
	@SuppressWarnings("unchecked")
	public List<MenuVO> selectMenuDetail(MenuVO menuVO) throws Exception {
		return sql.queryForList("JiCmMnm.selectMenuDetail", menuVO);
	}
	
	//메뉴관리 메뉴트리
	@SuppressWarnings("unchecked")
	public List<MenuVO> selectMenuMngList(MenuVO menuVO) throws Exception {
		return sql.queryForList("JiCmMnm.selectMenuMngList", menuVO);
	}
	
	//메뉴코드 중복체크
	public Integer selectMenuCdCheck(MenuVO menuVO) throws Exception {
		return (Integer) sql.queryForObject("JiCmMnm.selectMenuCdCheck", menuVO);
	}
	
	//메뉴등록
	public void insertMenuProc(MenuVO menuVO) throws Exception {
		sql.insert("JiCmMnm.insertMenuProc", menuVO);
	}
	//메뉴삭제
	public void deleteMenuProc(MenuVO menuVO) throws Exception {
		sql.update("JiCmMnm.deleteMenuProc", menuVO);
	}
	
	//메뉴수정(상세)
	public MenuVO selectMenu(MenuVO menuVO) throws Exception {
		return (MenuVO) sql.queryForObject("JiCmMnm.selectMenu", menuVO);
	}
	
	//메뉴수정
	public void updateMenuProc(MenuVO menuVO) throws Exception {
		sql.update("JiCmMnm.updateMenuProc", menuVO);
	}
}
