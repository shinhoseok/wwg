package com.ji.dao.mp.msp;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ji.cm.SendEmail;
import com.ji.cm.SendSms;
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
 * front K - shop 중소기업 제품관 - 관리자
 * @author maging
 * @since  2019. 7. 16.
 * @see    MpMspDAO02
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
@Repository("mpMspDAO02")
public class MpMspDAO02 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(MpMspDAO02.class); //현재 클래스 이름을 Logger에 등록
	
	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    @Resource(name="cmMtmDAO01")
    private CmMtmDAO01 cmMtmDAO01;
    
    /** sendSms */
    @Resource(name="sendSms")
    private SendSms sendSms;
    
    
    /** sendEmail */ 
    @Resource(name="sendEmail")
    private SendEmail sendEmail;
    
    
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
    	
    	log.debug("==== MpMspDAO02 ctlCMS Start ====");
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
			 * X      	:  GridList
			 * R		: 상세화면
			 */
			// TODO : L
			if(pstate.equals("L")){
								
				if(SITE_SESSION==null && scode.equals(propertiesService.getString("SYS_ADMIN_CD", ""))){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}
				
				
				
				// 이메일코드
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 일반전화국번
				codeparam.put("all_fl", "M00008");
				result_map.put("m00008List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 휴대전화국번
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				
				// 기업구분
				codeparam.put("all_fl", "M00100");
				result_map.put("m00100List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 설비분야
				codeparam.put("all_fl", "M00101");
				result_map.put("m00101List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));	
				
				// 제품구분
				codeparam.put("all_fl", "M00102");
				result_map.put("m00102List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));	
				
				// 회원구분
				codeparam.put("all_fl", "M00103");
				result_map.put("m00103List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));	
				
				// 인증구분
				codeparam.put("all_fl", "M00104");
				result_map.put("m00104List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 제품유형
				codeparam.put("all_fl", "M00106");
				result_map.put("m00106List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));				
				
				result_map.put("param", param);

			// TODO : X
			}else if(pstate.equals("X")){
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}
				log.debug("sp_sdate===>"+HtmlTag.returnString((String)param.get("sp_sdate"),""));
				log.debug("sp_edate===>"+HtmlTag.returnString((String)param.get("sp_edate"),""));
				
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectJIT_MSC_PRODList");
				result_map.put("result", true);
				result_map.put("TRS_MSG", "");				
								
			// 상세조회
			}else if(pstate.equals("X2")){
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}				
					log.error("==== pstate TEND ====::"+pstate);

					param.put("prod_seq", HtmlTag.returnString((String)param.get("selprod_seq1"),""));
					
					HashMap prodDtl = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
					result_map.put("prodDtl", prodDtl);
					
					result_map.put("result", true);
					result_map.put("TRS_MSG", "");	
					
			// TODO : XP2
			}else if(pstate.equals("XP2")){
				if(SITE_SESSION==null){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
				}
				param.put("selMENU_CD", "000484");
				param.put("selMENU_DATA_KEY", HtmlTag.returnString((String)param.get("selprod_seq2"),"0"));
		
						
				result_map = cmDAO.selectListGrid(param, "JiCmCms.selectMailLogList");
				result_map.put("result", true);
				result_map.put("TRS_MSG", "");				
				
			}
			
		}catch(JSysException q){	
			log.debug("MpMspDAO02 ctlCMS throw JSysException >>>>> :  "+q);	
			result_map.put("result",false);
			throw q;		
		}catch(NullPointerException q){
			log.debug("MpMspDAO02 ctlCMS NullPointerException:"+q);
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("MpMspDAO02 ctlCMS ArrayIndexOutOfBoundsException:"+q);
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(Exception q){
			log.debug("MpMspDAO02 ctlCMS Exception >>>>> : "+q);	
			result_map.put("result",false);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
		log.debug("==== MpMspDAO02 ctlCMS End ====");
		
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
    		sendSms.start(param);
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
    		sendEmail.start(param);
    	}
		
	}
}
