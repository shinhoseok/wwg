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
package com.ji.dao.cm.sti;
import java.io.IOException;
/**  
	/** cmDAO */
    /** EgovPropertyService */
    //event end
    
    /**
		try{
				// 통계조회
				}
				//result_map = ctlAS(param);
			}else if(classMethod.equals("ctlCRUD")){
				if(pstate.equals("L")){
				// 통계조회
			}
 		}catch(IOException q){

		return result_map;
    }
	public Map ctlAS (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		Map result_map = new HashMap();
		
		String curdate = HtmlTag.returnString((String)param.get("curdate"),"");// 현재일자
		String sql = "";
		try{
			// 일별통계리스트를 가져온다
			rtn_list = list(sql, query_param);
			/*log.debug("getListASD:"+query.toString());
			result_map.put("ListASD", rtn_list);
			// 요일별 통계리스트를 가져온다 일~토
			rtn_list = list(sql, query_param);
		}catch(JSysException q){	
    	log.debug("==== ctlAS End ====");
	}
	
		try{
			rtn_list = list(sql, query_param);
		}catch(JSysException q){	
    	log.debug("==== ctlASM End ====");
		return result_map;
	}	

	/**
		String sql = "";
		log.debug("==== insertAS : END ====");
	}   
}