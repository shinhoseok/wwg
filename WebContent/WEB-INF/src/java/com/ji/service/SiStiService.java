package com.ji.service;
import java.util.HashMap;import java.util.List;import java.util.Map;
import org.springframework.stereotype.Component;
/**   * @Class Name : ASService.java * @Description : ASService Class * @Modification Information   * @ * @  수정일      수정자              수정내용 * @ ---------   ---------   ------------------------------- * @ 2014.06.01           최초생성 *  * @author 개발프레임웍크 실행환경 개발팀 * @since 2014.06.01 * @version 1.0 * @see *  */@Componentpublic interface SiStiService {    /**	 * 시스템 접근관리정보를 조회한다.	 * @param searchVO - 조회할 정보가 담긴 VO	 * @return 글 목록	 * @exception Exception	 */
	Map insertAS(Map param) throws Exception;
}
