package com.ji.dao.inter;

import java.util.List;

import com.ji.vo.MenuVO;

public interface MenuDao {
	//사용자 탑메뉴, 사이트맵 / 관리자 레프트메뉴
	public List<MenuVO> selectMenuList(MenuVO menuVO) throws Exception;
	//메뉴 상세정보
	public List<MenuVO> selectMenuDetail(MenuVO menuVO) throws Exception;
	//메뉴관리 메뉴트리
	public List<MenuVO> selectMenuMngList(MenuVO menuVO) throws Exception;
	//메뉴코드 중복체크
	public Integer selectMenuCdCheck(MenuVO menuVO) throws Exception;
	//메뉴등록
	public void insertMenuProc(MenuVO menuVO) throws Exception;
	//메뉴삭제
	public void deleteMenuProc(MenuVO menuVO) throws Exception;
	//메뉴수정(상세)
	public MenuVO selectMenu(MenuVO menuVO) throws Exception;
	//메뉴수정
	public void updateMenuProc(MenuVO menuVO) throws Exception;
}
