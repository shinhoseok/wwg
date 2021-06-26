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

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

/**  
 * @Class Name : MAService.java
 * @Description : MAService Class
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
public interface MAService {
	
    /**
	 * 컨텐츠관리정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map ctlCMS(Map param) throws Exception;	
    
    /**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getListMD(Map param) throws Exception;
	
	
    /**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getListAdminMD(Map param) throws Exception;	
	
    /**
	 * 로그인정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map getSiteLogin(Map param) throws Exception;
	
	
    /**
	 * 로그인 비밀번호를 수정한다
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map loginPinChg(Map param) throws Exception;
	
    /**
	 * 로그인 비밀번호찾기
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map loginPinSearch(Map param) throws Exception;	
	
    /**
	 * 로그인 인증번호 발송
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map loginPinAuthSend(Map param) throws Exception;		
	
}
