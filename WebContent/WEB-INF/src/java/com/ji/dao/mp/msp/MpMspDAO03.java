package com.ji.dao.mp.msp;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;


import com.ji.cm.CM_Util;
//import com.ji.cm.SendEmail;
//import com.ji.cm.SendSms;
import com.ji.common.DateUtility;
import com.ji.common.HtmlTag;
import com.ji.common.HtmlText;
import com.ji.common.JSysException;
//import com.ji.common.JasyptUtil;
import com.ji.common.Param;
import com.ji.dao.cm.CMDAO;
import com.ji.dao.cm.mtm.CmMtmDAO01;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/** 
 * front K - shop 중소기업 제품관 - 사업소별 설비분야별 담당자관리
 * @author maging
 * @since  2019. 7. 16.
 * @see    MpMspDAO03
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일                         수정자              수정내용
 *  ------------       --------    ---------------------------
 *  2019. 7. 16.     	    lky       최초생성
 *  
 * </pre>
 * 
*/
@Repository("mpMspDAO03")
public class MpMspDAO03 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(MpMspDAO03.class); //현재 클래스 이름을 Logger에 등록
	
	
	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    @Resource(name="cmMtmDAO01")
    private CmMtmDAO01 cmMtmDAO01;
    
    /** sendSms 
    @Resource(name="sendSms")
    private SendSms sendSms;
    */
    
    /** sendEmail 
    @Resource(name="sendEmail")
    private SendEmail sendEmail;
    */
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;
 
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** jasyptUtil 
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;
    */
    
    /**
     * front K - shop 중소기업 제품관 - 사업소별 설비분야별 담당자관리 정보를 처리한다.
     * @author lky
     * @since 2019. 7. 16.
     * @see MpMspDAO02.ctlCMS
     * @param param
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws NullPointerException
     * @throws ArrayIndexOutOfBoundsException
     * @throws Exception Map
    */
    @SuppressWarnings("unchecked")
    public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
    	
    	log.debug("==== MpMspDAO03 ctlCMS Start ====");
		Map result_map		= new HashMap();
		Map temp_map 		= new HashMap();
		Map reqRceptNo 	= new HashMap();
		
				
		Map codeparam 		= new HashMap();
		codeparam.put("use_yn", "Y");
		codeparam.put("notinstr", "");
		codeparam.put("inout_fl", "");
		
		// SMS 초기값
		String tran_msg = "";
		String tran_etc2 = "";
		String tran_etc3 = "";		
		
		String[] rtn_form_obj_in = {"scode","pcode"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		
		Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String scode = HtmlTag.returnString((String)param.get("scode"),"S01");
		
		try{
			
			if(scode.equals(propertiesService.getString("SYS_ADMIN_CD", ""))){
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			}
			/*
			 * L      	:  List
			 * CF		: 등록화면
			 * C		: 등록
			 * UF		: 수정화면
			 * U		: 수정
			 * DF		: 상세화면
			 * D		: 삭제
			 */
			// TODO : L
			if(pstate.equals("L")){
								
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}

				
			
				if(param.get("sDate") == null){
					param.put("sDate", DateUtility.getRelativeDate(DateUtility.getToday(), -DateUtility.getLastDayOfMonth(DateUtility.getToday().substring(0, 6))));
					param.put("eDate", DateUtility.getToDay());
				}else{
					param.put("sDate", String.valueOf(param.get("sDate")).replaceAll("-", ""));
					param.put("eDate", String.valueOf(param.get("eDate")).replaceAll("-", ""));
				}
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectBusinessOfficeList"); // 사업소목록
				
				// 설비분야
				codeparam.put("all_fl", "M00101");
				result_map.put("m00101List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));				
				
				
				result_map.put("param", param);
			// TODO : CF	
			}else if(pstate.equals("CF")){
				
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}
				
				if(SITE_SESSION!= null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    }
				
				param.put("show_rows", "100");	//100개씩 조회
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectBusinessOfficeList"); // 사업소목록
				
				// 설비분야
				codeparam.put("all_fl", "M00101");
				result_map.put("m00101List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));				
				result_map.put("param", param);				
			// TODO : C	
			}else if(pstate.equals("C")){
				
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}				
				
				if(SITE_SESSION!= null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	
			    }
				
				int i=0;
				Map query_param = new HashMap();
				JSONArray jsonArray;
				Map jsonObjmap = new HashMap();
				Iterator iterator;
				Map tmp_map = new HashMap();
				int iseqno = 0;
				String sql = "";
			    // 그리드 삭제정보
			    String delkey		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("delkey"),""));
			    String [] delkey_sp = new String[0];				    
				
				// 권한그룹 메뉴목록을 불러온다
				if(!delkey.equals("")){
					delkey_sp = delkey.split(",");
					sql = "JiMpMsp.deleteJIT_MP_TY_CHARGER"; 
					param.put("delkey", delkey);
					param.put("delkey_sp", delkey_sp);

					delete(sql, param);
				}				
				
				// 담당자목록을 불러온다
				jsonArray = JSONArray.fromObject(((String) param.get("JSONDataList")).replaceAll("&amp;quot;", "\""));				
				
				for(i=0;i<jsonArray.size();i++){
					tmp_map = new HashMap();
					jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
					iterator = jsonObjmap.entrySet().iterator();
	
					  while (iterator.hasNext()) {
						   Entry entry = (Entry)iterator.next();
						   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
					  }

					  // 키값이 없으면 등록한다.
					  if("".equals(HtmlTag.returnString((String)tmp_map.get("chag_seq"),""))){
						  //sequence 추출
						  sql = "JiMpMsp.insertJIT_MP_TY_CHARGER"; 
						  iseqno = cmDAO.getSequence("JIT_MP_TY_CHARGER_CHAG_SEQ");
						  tmp_map.put("iseqno", iseqno);
						  tmp_map.put("user_id", HtmlTag.returnString((String)param.get("user_id"),""));
						  //tmp_map.put("BS_OFC_ORG_CD", HtmlTag.returnString((String)param.get("BS_OFC_ORG_CD"),""));
						  tmp_map.put("BS_OFC_ORG_CD","0000");
						  tmp_map.put("FAC_KIND_CD", HtmlTag.returnString((String)param.get("FAC_KIND_CD"),""));

						  insert(sql, tmp_map);						  
					  }
				  

				}
				
				result_map.put("result",true);
				result_map.put("TRS_MSG","저장되었습니다");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				
				
			/********************************************** 관리자 기능 *******************************************/
			// 관리자 목록조회 GRID
			// TODO : 관리자 시작
			}else if(pstate.equals("XL")){		
								
				//result_map = cmDAO.selectListGrid(param, "JiScSrm.selectRequstDataMgtList");
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectJIT_MP_TY_CHARGERList");
				result_map.put("result", true);
				result_map.put("TRS_MSG", "");				
				
			}else if(pstate.equals("XL2")){		
				param.put("sBsOfcOrgCd",HtmlTag.returnString((String)param.get("BS_OFC_ORG_CD"),""));
				param.put("sFecKindCd",HtmlTag.returnString((String)param.get("FAC_KIND_CD"),""));
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectJIT_MP_TY_CHARGERList");
				result_map.put("result", true);
				result_map.put("TRS_MSG", "");
				
				
				
			/********************************************** 관리자 기능 *******************************************/		
			//보완요청만료 테스트
			}else if(pstate.equals("TEND")){
					log.error("==== pstate TEND ====::"+pstate);

					/*scSrmRequestSplemnt(param);*/
							
					result_map.put("result", true);
					result_map.put("TRS_MSG", "");						
			}
			
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
			result_map.put("result",false);
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:"+q);
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:"+q);
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> : "+q);	
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
		log.debug("==== ScSrmDAO01 ctlCMS End ====");
		
		return result_map;
		
    }
    
    

    
    /**
     * SMS 발송
     * tran_phone	:	수신번호(숫자만)
     * tran_msg		:	내용
     * 	tran_etc1		:	발송시스템명
     * tran_etc2		:	담당자명
     * tran_etc3		:	담당자 연락처
     * @author maging
     * @since 2018. 6. 1.
     * @see MyMypDAO01.setSendSms
     * @param param
     * @throws Exception void
    */
    public void setSendSms(Map param) throws Exception {
    	//param.put("tran_etc1", propertiesService.getString("SYSTEM_NAME"));
    	param.put("tran_etc1", "동반성장 오픈플랫폼");
    	if(!HtmlTag.returnString((String)param.get("tran_phone"),"").equals("")){ 
    		//sendSms.start(param);
    	}
		
	}

    
    /**
     * EMAIL 발송
     * subject		:	제목
     * mailfrom	:	발송자이메일
     * mailto		:	수신자이메일
     * sql				:	실제발송되는 이메일 ㅡ> "SSV:"+mailto
     * gubun		:	발송시스템명
     * rname		:	담당자명
     * content		:	내용
     * @author maging
     * @since 2018. 6. 4.
     * @see MyMypDAO01.setSendEmail
     * @param param
     * @throws Exception void
    */
    public void setSendEmail(Map param) throws Exception {
    	//param.put("gubun", propertiesService.getString("SYSTEM_NAME"));
    	param.put("gubun", "동반성장 오픈플랫폼");
    	if(!HtmlTag.returnString((String)param.get("mailto"),"").equals("")){ 
    		//sendEmail.start(param);
    	}
		
	}
}
