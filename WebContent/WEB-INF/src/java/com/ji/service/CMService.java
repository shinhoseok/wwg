/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ji.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

/**  
 * @Class Name : CMService.java
 * @Description : CMService Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2014.06.01           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2014.06.01
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */
@Component
public interface CMService {
    
    /**
	 * 메뉴 목록을 조회한다.
	 * @param 
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getMenuTree(HashMap param) throws Exception;

	
	/**
	 * 메뉴 목록을 조회한다.
	 * @param 
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getMyMenu(HashMap param) throws Exception;
	
	
	
    /**
	 * 로그인정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getSiteLogin(Map param) throws Exception;
	
    /**
	 * 메뉴정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getMenuCfg(String scode, String pcode) throws Exception;	
	
    /**
	 * 관리자권한정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getAdmSubAuth(String user_id) throws Exception;	
	
    /**
	 * 관리자로그인정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getAdmLogin(Map param) throws Exception;	
	

    /**
	 * 접근아이피정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getIpCfg(String user_ip) throws Exception;	
	
    /**
	 * 관리자 left메뉴정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getAdmLeft() throws Exception;	
	
	
    /**
	 * 인사 정보를 연계한다
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map insertJIT9120_UPDATEJob(Map param) throws Exception;
	
    /**
	 * 권한변경이력정보 3년이상된자료를 삭제한다
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map deleteAuthLogJob(Map param) throws Exception;
	
    /**
	 * 접속이력정보 6개월 이상된자료를 삭제한다
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map deleteAccessLogJob(Map param) throws Exception;	
	
    /**
	 * 관리자 정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getAdmInfo() throws Exception;
	

}
