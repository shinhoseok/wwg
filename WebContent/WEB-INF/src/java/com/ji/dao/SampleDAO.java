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
package com.ji.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ji.common.HtmlTag;
import com.ji.dao.cm.CMDAO;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : AMMDAO.java
 * @Description : AMMDAO DAO Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 * 
 *  Copyright (C) by MOPAS All right reserved.
 */

@Repository("sampleDAO")
public class SampleDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(SampleDAO.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	

    /**
	 * 메소드
	 * @param Map
	 * @return 
	 * @exception Exception
	 */
    public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		log.debug("==== SampleDAO ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String samplePageType = HtmlTag.returnString((String)param.get("samplePageType"),"HWP");
		result_map.put("samplePageType", samplePageType);
		
		try{
			
			if(pstate.equals("L")){
//				result_map = getListAMM(param);
			// 등록
			}else if(pstate.equals("C")){
//				result_map = insertAMM(param);
				
			// 수정
			}else if(pstate.equals("U")){
//				result_map = updateAMM(param);
			// 삭제
			}else if(pstate.equals("D")){
//				result_map = deleteAMM(param);
			}

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}		
		}catch(Exception q){
			log.debug("ctlCMS Exception:");
			if(((String)result_map.get("TRS_MSG")).equals("")){
				result_map.put("TRS_MSG",q);
			}
		}
		
    	log.debug("==== SampleDAO ctlCMS End ====");
		return result_map;
    }

    

}
