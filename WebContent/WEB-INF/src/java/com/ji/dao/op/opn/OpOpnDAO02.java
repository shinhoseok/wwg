package com.ji.dao.op.opn;

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
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.HtmlText;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.Param;
import com.ji.dao.cm.CMDAO;
import com.ji.dao.cm.mtm.CmMtmDAO01;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/** 
 * front 연구개발(R&D) 아이디어 제안센터
 * @author lky
 * @since  2019. 7. 29.
 * @see    OpOpnDAO02
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일                         수정자              수정내용
 *  ------------       --------    ---------------------------
 *  2019. 7. 29.     	    lky       최초생성
 *  
 * </pre>
 * 
*/
@Repository("opOpnDAO02")
public class OpOpnDAO02 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(OpOpnDAO02.class); //현재 클래스 이름을 Logger에 등록
	
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
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;
    
    /**
     * front 아이디어 제안 정보를 처리한다.
     * @author maging
     * @since 2019. 7. 29.
     * @see MyMypDAO01.ctlCMS
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
    	
    	log.debug("==== OpOpnDAO02 ctlCMS Start ====");
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
			
			log.debug("OpOpnDAO01 pstate==>"+pstate);
			// 관리자 접근일경우 관리자 세션을 확인한다
			if(scode.equals(propertiesService.getString("SYS_ADMIN_CD", ""))){
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			}
			
			if(SITE_SESSION==null){
				throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.admin"));
			}			
			/*
			 * L      	:  List
			 * X      	:  GridList
			 * R		: 상세화면
			 */
			// TODO : L
			if(pstate.equals("L")){
				
				// 휴대전화국번
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 이메일코드
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));				
	
				result_map.put("param", param);
				
				
			// TODO : X	
			}else if(pstate.equals("X")){	
				// 로그인을 한경우
				if(SITE_SESSION!= null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
			    	}
			    }				
				result_map = cmDAO.selectListGrid(param, "JiOpOpn.selectJIT_BOARD_PROPOSALList");	
			// 상세조회
			}else if(pstate.equals("X2")){
					if(SITE_SESSION==null){
				    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
				    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
				    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
				    	}
					}				
						log.error("==== pstate ====::"+pstate);

						param.put("data_seqno", HtmlTag.returnString((String)param.get("seldata_seqno"),""));
						
						HashMap proposalDtl = (HashMap) getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", param);
						result_map.put("proposalDtl", proposalDtl);
						
						
						result_map.put("result", true);
						result_map.put("TRS_MSG", "");				
				
			// TODO : U
			}else if(pstate.equals("U")){				
				if(SITE_SESSION==null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
			    	}
				}
				
				param.put("data_seqno", HtmlTag.returnString((String)param.get("seldata_seqno"),""));
				
				// 상세정보 조회
				HashMap proposalDtl = (HashMap) getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", param);
				result_map.put("proposalDtl", proposalDtl);		
				
				if( HtmlTag.returnString((String)proposalDtl.get("data_seqno")).equals("")){
					throw new JSysException("수정할 정보가 없습니다.");
				}
				
				update("JiOpOpn.updateJIT_BOARD_PROPOSALAprId", param);
				
				// 담당자 알림 이메일 발송
				Map emailParam = new HashMap();

				
				Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
				String MENU_NM = HtmlTag.returnString((String)MENUCFG.get("menuNm"),""); //메뉴명	
				
				temp_map = new HashMap();
				temp_map.put("login_sess_id",HtmlTag.returnString((String)param.get("APR_ID"),""));
				
				Map authDtl = (Map)getSelectByPk("JiCmOam.selectAdmInfo", temp_map);

				// EMAIL 발송부분
				String emailForm = propertiesService.getString("CM_EMAIL_FORM");	//메일폼을 불러온다
				String emailFormFt = propertiesService.getString("CM_EMAIL_FORM_FT");	//메일폼 하단을 불러온다
				String emailSubject = MENU_NM+" 제안요청의 담당자로 지정되었습니다.";
				String emailTitle = MENU_NM+" 제안요청의 담당자로 지정";
				String emailContent = MENU_NM+" 제안요청의 담당자로 지정되었습니다.<br />";
						emailContent = emailContent+"제목 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(proposalDtl.get("data_title").toString(),""))+"<br />";;
						emailContent = emailContent+"작성자 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(proposalDtl.get("reg_nm").toString(),""));
				String gubun = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("SYSTEM_NAME")));
				String system_url = HtmlTag.returnString(propertiesService.getString("CM_SYSTEM_URL"),"");
				String CM_ADMIN_DEFAULT_ID = HtmlTag.returnString(propertiesService.getString("CM_ADMIN_DEFAULT_ID"));
				String mailFrom = propertiesService.getString("CM_ADMIN_EMAIL");
				
					emailForm = emailForm.replaceAll("\\{시스템url}",system_url).replaceAll("\\{시스템nm}",gubun);
					emailForm = emailForm.replace("{제목}", emailTitle);
					//emailForm = emailForm.replace("{내용}", emailContent);
					// 내용 제목과 동일하게 넣어달라는 현업요구 반영
					emailForm = emailForm.replace("{내용}", emailContent);	

								String mailto = HtmlTag.returnString((String) authDtl.get("email"));
		  						String mailto_nm = HtmlTag.returnString((String) authDtl.get("user_nm"));
		  						emailParam = new HashMap();
		  						emailParam.put("subject", emailSubject);						//제목
		  						emailParam.put("mailfrom", "\""+gubun+"\"<"+mailFrom+">");		//발송자이메일
		  						emailParam.put("mailto", "\""+mailto_nm+"\"<"+mailto+">");		//수신자이메일
		  						emailParam.put("sql", "SSV:"+mailto);							//***** 실제발송되는 이메일 *****
		  						emailParam.put("gubun", gubun);									//발송시스템명
		  						emailParam.put("rname", mailto_nm);		//담당자명
		  						
		  						// 관리자 화면으로 이동해서 로그인하도록 한다
		  						emailForm = emailForm.replace("{내용하단}", emailFormFt.replaceAll("\\{시스템url}"
											,system_url+HtmlTag.returnString(propertiesService.getString("CON_ROOT"),"")+"/cmsmain.do?scode=sysadm").replaceAll("\\{시스템nm}",gubun));

		  						
		  						emailParam.put("content", emailForm);							//내용
		  						
		  						emailParam.put("MENU_CD", HtmlTag.returnString((String) param.get("adm_rpcode"),""));
		  						emailParam.put("MENU_DATA_KEY", HtmlTag.returnString((String) param.get("data_seqno"),""));
		  						emailParam.put("ORDER_NO", "1");
		  						emailParam.put("REG_ID", CM_ADMIN_DEFAULT_ID);
		  						emailParam.put("FR_MAIL", HtmlTag.returnString((String) emailParam.get("mailfrom"),""));
		  						emailParam.put("TO_MAIL", HtmlTag.returnString((String) emailParam.get("mailto"),""));
		  						emailParam.put("TO_USER_ID", HtmlTag.returnString((String) authDtl.get("user_id"),""));
		  						emailParam.put("TO_USER_TY", "1");
		  						
		  						
		  						log.error("mail emailParam==>"+emailParam);
		  						
		  						// 메일전송이력을 저장한다
		  						
		  						this.setSendEmail(emailParam);		  						


				result_map.put("param", param);	
				
				result_map.put("result",true);
				result_map.put("TRS_MSG","");					
				

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
		
		log.debug("==== OpOpnDAO02 ctlCMS End ====");
		
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
