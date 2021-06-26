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

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.ji.util.Page;

/**  
 * @Class Name : CMSService.java
 * @Description : CMSService Class
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
public interface CMSService {
    

    /**
	 * 컨텐츠관리정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map ctlCMS(Map param,Map MenuCfg) throws Exception;

    /**
	 * 데이터를 grid 테이터로 변환한다.
	 * @param Page - 그리드 내용이 담김 값
	 * @return 
	 * @exception Exception
	 */
	List getGridList(Page page) throws Exception;
	
	/** 조회된 page 데이터를 그리드 데이터에 맞게 가공*/
	List getGridListScroll(List pagelist) throws Exception;
	
	/** 조회된 page 데이터를 그리드 데이터에 맞게 가공*/
	List getGridListScrollNotEgov(List pagelist) throws Exception;	
	
	/** 조회된 page 데이터를 암호화 컬럼이 있을경우 복호화후 그리드 데이터에 맞게 가공*/
	List getGridListScrollDec(List pagelist, String [] dec_col)  throws Exception;	
}
