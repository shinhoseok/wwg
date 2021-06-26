/**  
 * @Class Name : ACTService.java
 * @Description : ACTService Class
 * @Modification Information  
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2016.10.26           최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2016.10.26
 * @version 1.0
 * @see
 * 
 */

package com.ji.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface ACTService {
    /**
	 * 컨텐츠관리정보를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	Map ctlACT(Map param) throws Exception;

}

