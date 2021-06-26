package com.ji.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.ji.vo.MenuVO;

public interface MenuService {
	//사용자 탑메뉴, 사이트맵
	public List<MenuVO> selectMenuList(MenuVO menuVO) throws Exception;
	//관리자 레프트메뉴
	public List<MenuVO> selectAdminMenuList(MenuVO menuVO) throws IOException, NullPointerException, Exception;
	//메뉴관리 메뉴트리
	public List<MenuVO> selectMngMenuTree(MenuVO menuVO) throws Exception;
	//메뉴관리 상세보기
	public Map<String, Object> selectMenuDetail(MenuVO menuVO) throws Exception;
	//메뉴코드 중복확인
	public Integer selectMenuCdCheck(MenuVO menuVO) throws Exception;
	//메뉴등록
	public void insertMenuProc(MenuVO menuVO) throws Exception;
	//메뉴삭제
	public void deleteMenuProc(MenuVO menuVO) throws Exception;
	//메뉴수정
	public Map<String, Object> updateMenu(MenuVO menuVO) throws Exception;
	//메뉴수정
	public void updateMenuProc(MenuVO menuVO) throws Exception;
}
