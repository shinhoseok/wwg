package com.ji.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.ji.common.StringUtil;
import com.ji.dao.inter.CodeDao;
import com.ji.dao.inter.MenuDao;
import com.ji.service.MenuService;
import com.ji.vo.CodeVO;
import com.ji.vo.MenuVO;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "menuDao")
	private MenuDao menuDao;
	
	@Resource(name = "codeDao")
	private CodeDao codeDao;
	
	@Resource(name="txManagerds")
	private DataSourceTransactionManager txManager;
	
	//사용자 탑메뉴, 사이트맵
	public List<MenuVO> selectMenuList(MenuVO menuVO) throws IOException, NullPointerException, Exception {
		List<MenuVO> sqlMenuList = menuDao.selectMenuList(menuVO);
		List<MenuVO> menuList = new ArrayList<MenuVO>();
		List<MenuVO> twoDepthMenuList = null;
		List<MenuVO> threeDepthMenuList = null;
		
		try {
			String oneDepthMenuCd = "";
			String twoDepthMenuCd = "";
			
			Map<String, Integer> oneMap = new HashMap<String, Integer>();
			Map<String, Integer> twoMap = new HashMap<String, Integer>();
			//1메뉴 생성
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!sqlMenuList.get(i).getMenuDepth2Cd().equals(oneDepthMenuCd)) { //중복메뉴명 제거
					oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd();
					MenuVO oneMenuVO = new MenuVO();
					oneMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth2Cd());
					
					//제일 상위 메뉴를 클릭했을 때 자식 중 2레벨 메뉴가 있으면 2레벨 메뉴코드, 3레벨메뉴가 있으면 3레벨 메뉴코드 셋팅하여 자식 메뉴로 이동하기 위함
					if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth3Cd())) { 
						oneMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
					}
					if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) { 
						oneMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
					}
					oneMenuVO.setMenuDepth1Cd(sqlMenuList.get(i).getMenuDepth2Cd());
					oneMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth2Nm());
					menuList.add(oneMenuVO); //1뎁스메뉴리스트
				}
			}
			for(int i=0; i<menuList.size(); i++) {
				oneMap.put(menuList.get(i).getMenuDepth1Cd(), i);
			}
			
			//2메뉴 생성
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth2Cd())) {
					if(!oneDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth2Cd())) { //1레벨코드와 2레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							if(i != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
							}
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //1레벨의 메뉴코드를 변수에 담음
							twoDepthMenuList = new ArrayList<MenuVO>();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							//2레벨 메뉴를 클릭했을 때  자식 중 3레벨메뉴가 있으면 3레벨 메뉴코드 셋팅하여 자식 메뉴로 이동하기 위함
							if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) {
								twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							}
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					} else {//1레벨코드와 2레벨의 부모코드가 같을경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							//2레벨 메뉴를 클릭했을 때  자식 중 3레벨메뉴가 있으면 3레벨 메뉴코드 셋팅하여 자식 메뉴로 이동하기 위함
							if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) {
								twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							}
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					}
				}
			}
			
			//3메뉴 생성
			int startIdx = 0;
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) {
					if(!twoDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth3Cd())) { //2레벨코드와 3레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							if(startIdx != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
							}
							startIdx++;
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd(); //2레벨의 메뉴코드를 변수에 담음
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //1레벨의 메뉴코드를 변수에 담음
							threeDepthMenuList = new ArrayList<MenuVO>();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							threeDepthMenuList.add(threeMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
						
					} else {//2레벨코드와 3레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							threeDepthMenuList.add(threeMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
					}
				}
			}
			
		}catch(NullPointerException e){
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		} catch(Exception e) {
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		}
		return menuList;
	}
	
	//관리자 레프트메뉴
	public List<MenuVO> selectAdminMenuList(MenuVO menuVO) throws IOException, NullPointerException, Exception {
		List<MenuVO> sqlMenuList = menuDao.selectMenuList(menuVO);
		List<MenuVO> menuList = new ArrayList<MenuVO>();
		List<MenuVO> twoDepthMenuList = null;
		List<MenuVO> threeDepthMenuList = null;
		
		try {
			String oneDepthMenuCd = "";
			String twoDepthMenuCd = "";
			
			Map<String, Integer> oneMap = new HashMap<String, Integer>();
			Map<String, Integer> twoMap = new HashMap<String, Integer>();
			//1메뉴 생성
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!sqlMenuList.get(i).getMenuDepth2Cd().equals(oneDepthMenuCd)) { //중복메뉴명 제거
					oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd();
					MenuVO oneMenuVO = new MenuVO();
					oneMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth2Cd());
					
					oneMenuVO.setMenuDepth1Cd(sqlMenuList.get(i).getMenuDepth2Cd());
					oneMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth2Nm());
					menuList.add(oneMenuVO); //1뎁스메뉴리스트
				}
			}
			for(int i=0; i<menuList.size(); i++) {
				oneMap.put(menuList.get(i).getMenuDepth1Cd(), i);
			}
			
			//2메뉴 생성
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth2Cd())) {
					if(!oneDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth2Cd())) { //1레벨코드와 2레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							if(i != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
							}
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //1레벨의 메뉴코드를 변수에 담음
							twoDepthMenuList = new ArrayList<MenuVO>();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					} else {//1레벨코드와 2레벨의 부모코드가 같을경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					}
				}
			}
			
			//3메뉴 생성
			int startIdx = 0;
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) {
					if(!twoDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth3Cd())) { //2레벨코드와 3레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							if(startIdx != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
							}
							startIdx++;
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd(); //2레벨의 메뉴코드를 변수에 담음
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //1레벨의 메뉴코드를 변수에 담음
							threeDepthMenuList = new ArrayList<MenuVO>();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							threeDepthMenuList.add(threeMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
						
					} else {//2레벨코드와 3레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							threeDepthMenuList.add(threeMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
					}
				}
			}
			
		}catch(NullPointerException e){
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		} catch(Exception e) {
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		}
		return menuList;
	}
	
	//메뉴관리 메뉴트리
	public List<MenuVO> selectMngMenuTree(MenuVO menuVO) throws Exception {
		List<MenuVO> sqlMenuList = menuDao.selectMenuMngList(menuVO);
		List<MenuVO> menuList = new ArrayList<MenuVO>();
		List<MenuVO> twoDepthMenuList = null;
		List<MenuVO> threeDepthMenuList = null;
		List<MenuVO> fourDepthMenuList = null;
		
		try {
			String oneDepthMenuCd = "";
			String twoDepthMenuCd = "";
			String threeDepthMenuCd = "";
			String fourDepthMenuCd = "";
			
			Map<String, Integer> oneMap = new HashMap<String, Integer>();
			Map<String, Integer> twoMap = new HashMap<String, Integer>();
			Map<String, Integer> threeMap = new HashMap<String, Integer>();
			//1메뉴 생성
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!sqlMenuList.get(i).getMenuDepth1Cd().equals(oneDepthMenuCd)) { //중복메뉴명 제거
					oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth1Cd();
					MenuVO oneMenuVO = new MenuVO();
					oneMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth1Cd());
					
					oneMenuVO.setMenuDepth1Cd(sqlMenuList.get(i).getMenuDepth1Cd());
					oneMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth1Nm());
					menuList.add(oneMenuVO); //1뎁스메뉴리스트
				}
			}
			for(int i=0; i<menuList.size(); i++) {
				oneMap.put(menuList.get(i).getMenuDepth1Cd(), i);
			}
			
			//2메뉴 생성
			oneDepthMenuCd = "";
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth2Cd())) {
					if(!oneDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth1Cd())) { //1레벨코드와 2레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth2Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd();
							if(i != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
							}
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth1Cd(); //1레벨의 메뉴코드를 변수에 담음
							twoDepthMenuList = new ArrayList<MenuVO>();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth2Cd());
							
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth2Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth2Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					} else {//1레벨코드와 2레벨의 부모코드가 같을경우
						if(!sqlMenuList.get(i).getMenuDepth2Cd().equals(twoDepthMenuCd)) { //중복메뉴명 제거
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd();
							MenuVO twoMenuVO = new MenuVO();
							twoMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth2Cd());
							
							twoMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth2Nm());
							twoDepthMenuList.add(twoMenuVO);
							twoMap.put(sqlMenuList.get(i).getMenuDepth2Cd(), twoDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).setMenuList(twoDepthMenuList);
						}
					}
				}
			}
			
			//3메뉴 생성
			twoDepthMenuCd = "";
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth3Cd())) {
					if(!twoDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth2Cd())) { //2레벨코드와 3레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(threeDepthMenuCd)) { //중복메뉴명 제거
							threeDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							if(i != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
							}
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth1Cd(); //1레벨의 메뉴코드를 변수에 담음
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //2레벨의 메뉴코드를 변수에 담음
							threeDepthMenuList = new ArrayList<MenuVO>();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							threeDepthMenuList.add(threeMenuVO);
							threeMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), threeDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
					} else {//2레벨코드와 3레벨의 부모코드가 같을경우
						if(!sqlMenuList.get(i).getMenuDepth3Cd().equals(threeDepthMenuCd)) { //중복메뉴명 제거
							threeDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd();
							MenuVO threeMenuVO = new MenuVO();
							threeMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth3Cd());
							
							threeMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth3Nm());
							threeDepthMenuList.add(threeMenuVO);
							threeMap.put(sqlMenuList.get(i).getMenuDepth3Cd(), threeDepthMenuList.size()-1);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).setMenuList(threeDepthMenuList);
						}
					}
				}
			}
			
			//4메뉴 생성
			int startIdx = 0;
			threeDepthMenuCd = "";
			for(int i=0; i<sqlMenuList.size(); i++) {
				if(!StringUtil.isEmpty(sqlMenuList.get(i).getMenuDepth4Cd())) {
					if(!threeDepthMenuCd.equals(sqlMenuList.get(i).getMenuDepth3Cd())) { //3레벨코드와 4레벨의 부모코드가 다를경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(fourDepthMenuCd)) { //중복메뉴명 제거
							if(startIdx != 0) {
								menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).getMenuList().get(threeMap.get(threeDepthMenuCd)).setMenuList(fourDepthMenuList);
							}
							startIdx++;
							threeDepthMenuCd = sqlMenuList.get(i).getMenuDepth3Cd(); //3레벨의 메뉴코드를 변수에 담음
							twoDepthMenuCd = sqlMenuList.get(i).getMenuDepth2Cd(); //2레벨의 메뉴코드를 변수에 담음
							oneDepthMenuCd = sqlMenuList.get(i).getMenuDepth1Cd(); //1레벨의 메뉴코드를 변수에 담음
							fourDepthMenuList = new ArrayList<MenuVO>();
							MenuVO fourMenuVO = new MenuVO();
							fourMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							fourMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							fourDepthMenuList.add(fourMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).getMenuList().get(threeMap.get(threeDepthMenuCd)).setMenuList(fourDepthMenuList);
						}
						
					} else {//3레벨코드와 4레벨의 부모코드가 같을경우
						if(!sqlMenuList.get(i).getMenuDepth4Cd().equals(fourDepthMenuCd)) { //중복메뉴명 제거
							fourDepthMenuCd = sqlMenuList.get(i).getMenuDepth4Cd();
							MenuVO fourMenuVO = new MenuVO();
							fourMenuVO.setMenuCd(sqlMenuList.get(i).getMenuDepth4Cd());
							fourMenuVO.setMenuNm(sqlMenuList.get(i).getMenuDepth4Nm());
							fourDepthMenuList.add(fourMenuVO);
							menuList.get(oneMap.get(oneDepthMenuCd)).getMenuList().get(twoMap.get(twoDepthMenuCd)).getMenuList().get(threeMap.get(threeDepthMenuCd)).setMenuList(fourDepthMenuList);
						}
					}
				}
			}
			
		}catch(NullPointerException e){
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		} catch(Exception e) {
			log.error("selectMenuList throw Exception >>>>> :  "+e);
			throw e;
		}
		return menuList;
	}
	
	//메뉴관리 상세화면
	public Map<String, Object> selectMenuDetail(MenuVO menuVO) throws Exception {
		Map<String, Object> rsltMap = new HashMap<String, Object>();
		
		//하위메뉴 리스트
		List<MenuVO> menuList = menuDao.selectMenuDetail(menuVO);
		//메뉴 연결종류 코드리스트
		List<CodeVO> linkKindList = codeDao.selectCodeList("M00002");
		//게시판 종류 코드리스트
		List<CodeVO> boardCdList = codeDao.selectCodeList("M00003");
		
		rsltMap.put("menuList", menuList);
		rsltMap.put("linkKindList", linkKindList);
		rsltMap.put("boardCdList", boardCdList);
		
		return rsltMap;
	}
	
	//메뉴코드 중복확인
	public Integer selectMenuCdCheck(MenuVO menuVO) throws Exception {
		return menuDao.selectMenuCdCheck(menuVO);
	}
	
	//메뉴등록
	public void insertMenuProc(MenuVO menuVO) throws Exception {
		menuVO.setMenuSeqno(codeDao.selectSequence("JIT9160"));
		menuDao.insertMenuProc(menuVO);
	}
	
	//메뉴삭제
	public void deleteMenuProc(MenuVO menuVO) throws Exception {
		menuDao.deleteMenuProc(menuVO);
	}
	
	//메뉴수정
	public Map<String, Object> updateMenu(MenuVO menuVO) throws Exception {
		Map<String, Object> rsltMap = new HashMap<String, Object>();
		
		//메뉴상세정보
		MenuVO resultVO = menuDao.selectMenu(menuVO);
		//메뉴 연결종류 코드리스트
		List<CodeVO> linkKindList = codeDao.selectCodeList("M00002");
		//게시판 종류 코드리스트
		List<CodeVO> boardCdList = codeDao.selectCodeList("M00003");
		
		rsltMap.put("resultVO", resultVO);
		rsltMap.put("linkKindList", linkKindList);
		rsltMap.put("boardCdList", boardCdList);
		
		return rsltMap;
	}
	
	//메뉴수정
	public void updateMenuProc(MenuVO menuVO) throws Exception {
		menuDao.updateMenuProc(menuVO);
	}
}
