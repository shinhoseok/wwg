package com.ji.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;

import com.ji.service.MenuService;
import com.ji.vo.MenuVO;

@Controller
public class MenuController {
	protected Logger log = Logger.getLogger(MenuController.class);
	
	@Resource(name = "menuService")
	private MenuService menuService; 
	
	//메뉴관리 상세트리
	@RequestMapping(value = "/admin/selectMngMenuTree.do")
	public String selectMngMenuTree(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model) throws Exception {
		
		List<MenuVO> menuMngList = menuService.selectMngMenuTree(menuVO);
		model.addAttribute("menuMngList", menuMngList);
		
		return "/ji/cm/mnm/jicm_mnm_010_s1_ajax1";
	}
	
	//메뉴관리 상세화면
	@RequestMapping(value = "/admin/selectMenuDetail.do")
	public String selectMenuDetail(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model) throws Exception {
		
		Map<String, Object> rsltMap = menuService.selectMenuDetail(menuVO);
		model.addAttribute("rslt", rsltMap);
		
		return "/ji/cm/mnm/jicm_mnm_010_s1_ajax2";
	}
	
	//메뉴등록시 중복 메뉴코드체크
	@RequestMapping(value = "/admin/selectMenuCdCheck.do")
	public String selectMenuCdCheck(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model) throws Exception {
		
		int resultCnt = menuService.selectMenuCdCheck(menuVO);
		boolean menuCdChk = false;
		if(resultCnt == 0) {
			menuCdChk = true;
		}
		model.addAttribute("menuCdChk", menuCdChk);
		
		return "jsonView";
	}
	
	//메뉴등록
	@RequestMapping(value = "/admin/menu/insertMenuProc.do")
	public String insertMenuProc(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model, HttpServletRequest request, SessionStatus status) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		String regId = String.valueOf(SITE_SESS.get("USER_ID"));
		menuVO.setRegId(regId);
		menuService.insertMenuProc(menuVO);
		status.setComplete(); //중복서브밋 방지
		
		return "jsonView";
	}
	
	//메뉴삭제
	@RequestMapping(value = "/admin/menu/deleteMenuProc.do")
	public String deleteMenuProc(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model, HttpServletRequest request, SessionStatus status) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		String delId = String.valueOf(SITE_SESS.get("USER_ID"));
		menuVO.setDelId(delId);
		menuService.deleteMenuProc(menuVO);
		status.setComplete(); //중복서브밋 방지
		
		return "jsonView";
	}
	
	//메뉴수정 페이지
	@RequestMapping(value = "/admin/menu/updateMenu.do")
	public String updateMenu(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model) throws Exception {
		
		Map<String, Object> rsltMap = menuService.updateMenu(menuVO);
		model.addAttribute("rslt", rsltMap);
		
		return "/ji/cm/mnm/jicm_mnm_010_s1_ajax3";
	}
	
	//메뉴수정
	@RequestMapping(value = "/admin/menu/updateMenuProc.do")
	public String updateMenuProc(@ModelAttribute("menuVO") MenuVO menuVO, ModelMap model, HttpServletRequest request, SessionStatus status) throws Exception {
		
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		String modId = String.valueOf(SITE_SESS.get("USER_ID"));
		menuVO.setModId(modId);
		menuService.updateMenuProc(menuVO);
		status.setComplete(); //중복서브밋 방지
		
		return "jsonView";
	}
	
}