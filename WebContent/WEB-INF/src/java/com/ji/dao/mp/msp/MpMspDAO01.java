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
 * front K - shop 중소기업 제품관
 * @author maging
 * @since  2019. 7. 05.
 * @see    MpMspDAO01
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일                         수정자              수정내용
 *  ------------       --------    ---------------------------
 *  2019. 7. 05.     	    maging       최초생성
 *  
 * </pre>
 * 
*/
@Repository("mpMspDAO01")
public class MpMspDAO01 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(MpMspDAO01.class); //현재 클래스 이름을 Logger에 등록
	
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
     * front K - shop 중소기업 제품관 정보를 처리한다.
     * @author maging
     * @since 2019. 3. 07.
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
    	
    	log.debug("==== MpMspDAO01 ctlCMS Start ====");
		Map result_map		= new HashMap();
		Map temp_map 		= new HashMap();
	
				
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
		
		log.debug("MpMspDAO01====pstate==>"+pstate);
		
		try{
			
			if(scode.equals(propertiesService.getString("SYS_ADMIN_CD", ""))){
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			}else{
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
			}
			/*
			 * L      	:  List
			 * CF		: 등록화면
			 * C		: 등록
			 * UF		: 수정화면
			 * U		: 수정
			 * R		: 상세화면
			 * D		: 삭제
			 */
			// TODO : L ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if(pstate.equals("L")){
				// 사용자 조회 화면
			
				if(param.get("sDate") == null){
					param.put("sDate", DateUtility.getRelativeDate(DateUtility.getToday(), -DateUtility.getLastDayOfMonth(DateUtility.getToday().substring(0, 6))));
					param.put("eDate", DateUtility.getToDay());
				}else{
					param.put("sDate", String.valueOf(param.get("sDate")).replaceAll("-", ""));
					param.put("eDate", String.valueOf(param.get("eDate")).replaceAll("-", ""));
				}
				
				if(param.get("searchTab") == null){
					param.put("searchTab", "1");
				}
				
				if(param.get("searchGubun") == null){
					param.put("searchGubun", "");
				}
				
				if(param.get("searchValue") == null){
					param.put("searchValue", "");
				}				
				
				String page = HtmlTag.returnString((String)param.get("page"),"1");
				param.put("page", page);
				
				// 목록
				List rtn_list = new ArrayList();
				result_map.put("list", rtn_list);
		

				result_map.put("param", param);
			// TODO : CF1 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("CF1")){				
					
				if(SITE_SESSION!= null){
				    param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
				}
					
				result_map.put("param", param);
				
			// TODO : CF2	
			}else if(pstate.equals("CF2")){				
						
				if(SITE_SESSION!= null){
					param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
				}
				
				// 개인정보 동의여부 체크
				if(!HtmlTag.returnString((String)param.get("agree_1"),"").equals("Y")){
					throw new JSysException("개인정보 동의가 되지않았습니다.");
				}
					
				result_map.put("param", param);				
					
			// TODO : CF ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("CF")){
				// 사용자 등록화면
				Map SITE_AUTH_SESSION = (Map)param.get(propertiesService.getString("SITE_AUTH_SESSION_FN"));
				// 로그인을 한경우
				if(SITE_SESSION!= null){
					log.debug("session chk 1======================");
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	param.put("user_nm", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"")));
			    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
			    	}
			    }else{
			    	// 로그인 없이 글등록시 본인인증한값 체크
					if(SITE_AUTH_SESSION==null){
						//throw new JSysException("정상적으로 본인인증이 되지않았습니다");
					}else{
						if(SITE_AUTH_SESSION.get("sName")==null){
							//throw new JSysException("정상적으로 본인인증이 되지않았습니다");
						}else{
							//log.debug("session chk 2======================");
				    		//param.put("SITE_AUTH_SESSION", SITE_AUTH_SESSION);
						
						}
			    	}
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

				//////////////////////////////////////////////////////////////////추가 코드
				
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
				
				// 회원정보
				// 등록한 회원정보
				if(!HtmlTag.returnString((String)param.get("user_id"),"").equals("")){
					// 마스킹된 회원정보 불러올시 사용
					//result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));	
					result_map.put("userDtl", getSelectByPk("JiCmOam.selectUserInfo", param));	
					
				}			
				
				

				result_map.put("param", param);
				
				
			// TODO : C ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("C")){
				// 사용자 등록처리
				if(SITE_SESSION!= null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
		    	
			    }
				
				
				int i=0;
				int JIT_MSC_PROD_PROD_SEQ = 0;
				Map query_param = new HashMap();
			    /*
			     * 1.K - shop 중소기업 제품관 등록
			     * 2.첨부파일정보 등록
			     * 3.담당자 알림 이메일 발송
			     */
				JIT_MSC_PROD_PROD_SEQ = cmDAO.getSequence("JIT_MSC_PROD_PROD_SEQ");
				// 파일정보 연결키값
				param.put("ikey_datas", ""+JIT_MSC_PROD_PROD_SEQ);
				
				
				///////////////////////////////// 1.K - shop 중소기업 제품관 등록
				// 담당자 전화(현재 사용되지않음)
				param.put("MANAGER_TEL_NO", "");
				// 이메일
				if(!HtmlTag.returnString((String)param.get("email1"),"").equals("") && !HtmlTag.returnString((String)param.get("email2"),"").equals("")){
					param.put("CORP_EMAIL", HtmlTag.returnString((String)param.get("email1"),"")+"@"+HtmlTag.returnString((String)param.get("email2"),""));
				}else{
					param.put("CORP_EMAIL", "");
				}
				
				// 대표번호
				if(!HtmlTag.returnString((String)param.get("CORP_TEL_NO_11"),"").equals("") && !HtmlTag.returnString((String)param.get("CORP_TEL_NO_12"),"").equals("")
						&& !HtmlTag.returnString((String)param.get("CORP_TEL_NO_13"),"").equals("")){
					param.put("CORP_TEL_NO_1", HtmlTag.returnString((String)param.get("CORP_TEL_NO_11"),"")+"-"+HtmlTag.returnString((String)param.get("CORP_TEL_NO_12"),"")
							+"-"+HtmlTag.returnString((String)param.get("CORP_TEL_NO_13"),""));
				}else{
					param.put("CORP_TEL_NO_1", "");
				}	
				
				// fax번호
				if(!HtmlTag.returnString((String)param.get("CORP_FAX_NO1"),"").equals("") && !HtmlTag.returnString((String)param.get("CORP_FAX_NO2"),"").equals("")
						&& !HtmlTag.returnString((String)param.get("CORP_FAX_NO3"),"").equals("")){
					param.put("CORP_FAX_NO", HtmlTag.returnString((String)param.get("CORP_FAX_NO1"),"")+"-"+HtmlTag.returnString((String)param.get("CORP_FAX_NO2"),"")
							+"-"+HtmlTag.returnString((String)param.get("CORP_FAX_NO3"),""));
				}else{
					param.put("CORP_FAX_NO", "");
				}				
				
				// 주소(현재 사용되지않음)
				param.put("CORP_ADDR", "");
				
				// 인증번호(현재 사용되지않음)
				param.put("CERT_NO", "");	
				
				// IPIN번호(작업필요)
				//param.put("IPIN_NO", "");		
				
				// 본인인증 중복여부체크값(작업필요)
				//param.put("DUPL_INFO", "");	
				
				// 본인인증 종류
				// 회원가입 로그인시
				if(!HtmlTag.returnString((String)param.get("user_id"),"").equals("")){
					param.put("AUTH_TYPE", "LOGIN");
				
				}else{
					// 핸드폰 실명인증시
					if(!HtmlTag.returnString((String)param.get("dupl_info"),"").equals("")){
						param.put("AUTH_TYPE", "CHECKPLUS");
					// ipin인증시
					}else if(!HtmlTag.returnString((String)param.get("ipin_no"),"").equals("")){
						param.put("AUTH_TYPE", "IPIN");
					// 미인증시
					}else{
						param.put("AUTH_TYPE", "NONE");
					}
					
				}
				
				
				
				// 사용안함
				//#CORP_TEL_NO_2#,  #CORP_TEL_NO_3#, #CORP_TEL_NO#					
				insert("JiMpMsp.insertJIT_MSC_PROD", param);
				
				/* 
				ArrayList<String> ent_psn_nms_arr = HtmlText.iterateQueryParam2(HtmlTag.returnString((String)param.get("ent_psn_nms"),""), ",");
				ArrayList<String> ent_psn_brtymds_arr = HtmlText.iterateQueryParam2(HtmlTag.returnString((String)param.get("ent_psn_brtymds"),""), ",");
				
				for(i=0;i<ent_psn_nms_arr.size();i++){
					query_param = new HashMap();
					query_param.put("ikey_datas", param.get("ikey_datas").toString());
					query_param.put("ent_psn_nm", ent_psn_nms_arr.get(i));
					query_param.put("ent_psn_brtymd", ent_psn_brtymds_arr.get(i));
					query_param.put("ent_psn_orderno", (i+1)+"");
					query_param.put("user_id", param.get("user_id").toString());
					
					insert("JiScSrm.insertRequstEntPsn", query_param);
				}
				*/
				
				// 2.첨부파일정보 등록
					
				param.put("imenu_data_title", "[K - shop 중소기업 제품관]"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("PROD_NM").toString(),"")));
				param.put("ikey_datas", param.get("ikey_datas"));
				// 첨부파일 체크
				cmMtmDAO01.InsertFile(param);
				
				// JIT_MP_TY_CHARGER에 등록된 사업소별 설비분야별 담당자를 조회하여 메일을 전송한다
				// 담당자 알림 이메일 발송
				Map emailParam = new HashMap();
				//Map<String,Object> sendInfo = getSelectByPk("JiScSrm.selectSendInfo", param);
				Map<String,Object> sendInfo = new HashMap<String,Object>();
				List rtn_list = new ArrayList();
				List gridList = new ArrayList();
				
				// EMAIL 발송부분
				String emailForm = propertiesService.getString("CM_EMAIL_FORM");	//메일폼을 불러온다
				String emailFormFt = propertiesService.getString("CM_EMAIL_FORM_FT");	//메일폼 하단을 불러온다
				String emailSubject = "K - shop 중소기업 제품관에 제품등록이 요청되었습니다.";
				String emailTitle = "K - shop 중소기업 제품관에 제품등록";
				String emailContent = "K - shop 중소기업 제품관에 제품등록이 요청되었습니다.<br />";
						emailContent = emailContent+"회사명 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("CORP_NM").toString(),""))+"<br />";;
						emailContent = emailContent+"제품명 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("PROD_NM").toString(),""))+"<br />";
				String gubun = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("SYSTEM_NAME")));
				String system_url = HtmlTag.returnString(propertiesService.getString("CM_SYSTEM_URL"),"");
				String CM_ADMIN_DEFAULT_ID = HtmlTag.returnString(propertiesService.getString("CM_ADMIN_DEFAULT_ID"));
				String mailFrom = propertiesService.getString("CM_ADMIN_EMAIL");
				//log.debug("emailForm111==>"+emailForm);
					emailForm = emailForm.replaceAll("\\{시스템url}",system_url).replaceAll("\\{시스템nm}",gubun);
					emailForm = emailForm.replace("{제목}", emailTitle);
					//emailForm = emailForm.replace("{내용}", emailContent);
					//log.debug("emailForm222==>"+emailForm);
					// 내용 제목과 동일하게 넣어달라는 현업요구 반영
					emailForm = emailForm.replace("{내용}", emailContent);				
				// 사업소별 설비분야별 담당자 정보를 불러온다
				ArrayList<String> corp_fac_divn_cds = HtmlText.iterateQueryParam2(HtmlTag.returnString((String)param.get("CORP_FAC_DIVN_cds"),""), ",");
				param.put("corp_fac_divn_cds", corp_fac_divn_cds);	
		  		rtn_list = list("JiMpMsp.selectJIT_MP_TY_CHARGERList", param);
		  		//log.error("rtn_list==>"+rtn_list);
		  		if(rtn_list!=null){
		  			gridList = cmsService.getGridListScroll(rtn_list);	
		  			if(gridList!=null){
		  				if(gridList.size()> 0){
		  					for(i=0;i<gridList.size();i++){
		  						sendInfo = (Map)gridList.get(i);
		  						String mailto = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("charger_email")));
		  						String mailto_nm = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("charger_user_nm")));
		  						emailParam = new HashMap();
		  						emailParam.put("subject", emailSubject);						//제목
		  						emailParam.put("mailfrom", "\""+gubun+"\"<"+mailFrom+">");		//발송자이메일
		  						emailParam.put("mailto", "\""+sendInfo.get("chag_user_nm")+"\"<"+sendInfo.get("chag_user_email")+">");		//수신자이메일
		  						emailParam.put("sql", "SSV:"+sendInfo.get("chag_user_email"));							//***** 실제발송되는 이메일 *****
		  						emailParam.put("gubun", gubun);									//발송시스템명
		  						emailParam.put("rname", sendInfo.get("chag_user_nm"));		//담당자명
		  						
		  						emailForm = emailForm.replace("{내용하단}", emailFormFt.replaceAll("\\{시스템url}"
		  																		,system_url+HtmlTag.returnString(propertiesService.getString("CON_ROOT"),"")+"/cmsmain.do?scode=S01&pcode=000484&pstate=R&prod_seq="+param.get("ikey_datas")).replaceAll("\\{시스템nm}",gubun));
		  						//log.debug("emailForm333==>"+emailForm);
		  						emailParam.put("content", emailForm);							//내용
		  						
		  						emailParam.put("MENU_CD", HtmlTag.returnString((String) param.get("pcode"),""));
		  						emailParam.put("MENU_DATA_KEY", HtmlTag.returnString((String) param.get("ikey_datas"),""));
		  						emailParam.put("ORDER_NO", ""+(i+1));
		  						emailParam.put("REG_ID", CM_ADMIN_DEFAULT_ID);
		  						emailParam.put("FR_MAIL", HtmlTag.returnString((String) emailParam.get("mailfrom"),""));
		  						emailParam.put("TO_MAIL", HtmlTag.returnString((String) emailParam.get("mailto"),""));
		  						emailParam.put("TO_USER_ID", HtmlTag.returnString((String)sendInfo.get("chag_emp_no"),""));
		  						emailParam.put("TO_USER_TY", "1");
		  						
		  						
		  						log.error("mail emailParam==>"+emailParam);
		  						
		  						// 메일전송이력을 저장한다
		  						
//		  						this.setSendEmail(emailParam);		  						
		  					}
		  				}
		  				
		  			}
		  		}else{
		  			gridList = new ArrayList();
		  		}
		  				  			
				
				form_list = Param.getObjectNameIn(param, rtn_form_obj_in);
				rtn_form_obj = Param.getListToArr(form_list);
				result_map.put(propertiesService.getString("RESULT_URL_F_KEY"),Param.getFormObjectIn(param, rtn_form_obj,null,null));
				
				result_map.put("result",true);
				result_map.put("TRS_MSG","등록되었습니다");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			// TODO : UF ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("UF")){
				
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
		    	
			    }
				if(!HtmlTag.returnString((String)param.get("rpidx"),"").equals("")){
					param.put("prod_seq", HtmlTag.returnString((String)param.get("rpidx"),""));
				}

					param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("ichk_secret_no"),""));

				// 상세정보 조회
				HashMap prodDtl = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
				
				// 비밀번호 암호화 비교 체크
				Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", param);
				
				result_map.put("prodDtl", prodDtl);
				
				
				if( HtmlTag.returnString((String)prodDtl.get("prod_seq")).equals("")){
					throw new JSysException("수정할 정보가 일치하지 않습니다.");
				}
				
				// 등록한 회원정보
				if(HtmlTag.returnString((String)prodDtl.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", prodDtl.get("reg_id"));
					if(!HtmlTag.returnString((String)prodDtl.get("reg_id"),"").equals(HtmlTag.returnString((String)param.get("USER_ID"),""))){
						throw new JSysException("수정할 권한이 없습니다.");
					}
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}else{
					if(HtmlTag.returnString((String)param.get("ichk_secret_no"),"").equals("")
							|| !pwdCheck.get("data_ipns").equals(HtmlTag.returnString((String)prodDtl.get("secret_no"),""))
					){
						throw new JSysException("수정할 권한이 없습니다.");
					}
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

				//////////////////////////////////////////////////////////////////추가 코드
				
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
				
				// 제품이미지
				param.put("file_menu_cd", "000484");
				param.put("file_group_no", "1");
				// 첨부파일 목록
				result_map.put("fileList1", list("JiMpMsp.selectFileList", param));
				
				// 카탈로그
				param.put("file_menu_cd", "000484");
				param.put("file_group_no", "2");
				// 첨부파일 목록
				result_map.put("fileList2", list("JiMpMsp.selectFileList", param));
				
					
				// 조회수증가
				//update("JiScSrm.updateRequstCnt", param);
							
				

				
				//if(!temp_map.get("req_usr_id").equals(param.get("user_id"))){
				//	result_map.put("result",false);
				//	result_map.put("TRS_MSG","수정 권한이 없습니다.");
				//}else{
											
					

				//}
				
				result_map.put("param", param);
					

			// TODO : U	사용자 수정 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			}else if(pstate.equals("U")){
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
		    	
			    }
				if(!HtmlTag.returnString((String)param.get("rpidx"),"").equals("")){
					param.put("prod_seq", HtmlTag.returnString((String)param.get("rpidx"),""));
				}

				param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));

				
				// 상세정보 조회
				HashMap prodDtl = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
				
				// 비밀번호 암호화 비교 체크
				Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", param);
				
				result_map.put("prodDtl", prodDtl);
				
				
				if( HtmlTag.returnString((String)prodDtl.get("prod_seq")).equals("")){
					throw new JSysException("수정할 정보가 일치하지 않습니다.");
				}
				
				// 등록한 회원정보
				if(HtmlTag.returnString((String)prodDtl.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", prodDtl.get("reg_id"));
					if(!HtmlTag.returnString((String)prodDtl.get("reg_id"),"").equals(HtmlTag.returnString((String)param.get("USER_ID"),""))){
						throw new JSysException("수정할 권한이 없습니다.");
					}
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}else{
					if(HtmlTag.returnString((String)param.get("SECRET_NO"),"").equals("")
							|| !pwdCheck.get("data_ipns").equals(HtmlTag.returnString((String)prodDtl.get("secret_no"),""))
							
					){
						throw new JSysException("수정할 권한이 없습니다.");
					}
				}				
							
				

				String prod_seq = HtmlTag.returnString((String)prodDtl.get("prod_seq"),"");
				
				int i=0;
				//if(!temp_map.get("req_usr_id").equals(param.get("user_id"))){
				//	result_map.put("result",false);
				//	result_map.put("TRS_MSG","수정 권한이 없습니다.");
				//}else{	
					if(!pwdCheck.get("data_ipns").equals(prodDtl.get("secret_no"))){
						result_map.put("result",false);
						result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
						throw new JSysException("비밀번호가 일치하지않습니다.!");
					}else{
					    /*
					     * 1.K - shop 중소기업 제품관 수정
					     * 2.첨부파일정보 등록
					     * 3.담당자 알림 이메일 발송
					     */
						
						Map query_param = new HashMap();
						// K - shop 중소기업 제품관 번호 셋팅
						param.put("ikey_datas", prod_seq);
					
					
						// 1.K - shop 중소기업 제품관 수정
						update("JiMpMsp.updateJIT_MSC_PROD", param);
						
						
						// 2. 첨부파일 처리
						param.put("imenu_data_title", "[K - shop 중소기업 제품관]"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("PROD_NM").toString(),"")));
						param.put("iuploadseq", "");
						cmMtmDAO01.InsertFile(param);	

						// 3.담당자 알림 이메일 발송
						// JIT_MP_TY_CHARGER에 등록된 사업소별 설비분야별 담당자를 조회하여 메일을 전송한다
						// 담당자 알림 이메일 발송
						Map emailParam = new HashMap();
						//Map<String,Object> sendInfo = getSelectByPk("JiScSrm.selectSendInfo", param);
						Map<String,Object> sendInfo = new HashMap<String,Object>();
						List rtn_list = new ArrayList();
						List gridList = new ArrayList();
						
						// EMAIL 발송부분
						String emailForm = propertiesService.getString("CM_EMAIL_FORM");	//메일폼을 불러온다
						String emailFormFt = propertiesService.getString("CM_EMAIL_FORM_FT");	//메일폼 하단을 불러온다
						String emailSubject = "K - shop 중소기업 제품관에 제품이 수정되었습니다.";
						String emailTitle = "K - shop 중소기업 제품관에 제품 수정";
						String emailContent = "K - shop 중소기업 제품관에 제품이 수정되었습니다.<br />";
								emailContent = emailContent+"회사명 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("CORP_NM").toString(),""))+"<br />";;
								emailContent = emailContent+"제품명 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("PROD_NM").toString(),""))+"<br />";
						String gubun = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("SYSTEM_NAME")));
						String system_url = HtmlTag.returnString(propertiesService.getString("CM_SYSTEM_URL"),"");
						String CM_ADMIN_DEFAULT_ID = HtmlTag.returnString(propertiesService.getString("CM_ADMIN_DEFAULT_ID"));
						String mailFrom = propertiesService.getString("CM_ADMIN_EMAIL");
						//log.debug("emailForm111==>"+emailForm);
							emailForm = emailForm.replaceAll("\\{시스템url}",system_url).replaceAll("\\{시스템nm}",gubun);
							emailForm = emailForm.replace("{제목}", emailTitle);
							//emailForm = emailForm.replace("{내용}", emailContent);
							// 내용 제목과 동일하게 넣어달라는 현업요구 반영
							//log.debug("emailForm222==>"+emailForm);
							emailForm = emailForm.replace("{내용}", emailContent);				
						// 사업소별 설비분야별 담당자 정보를 불러온다
						ArrayList<String> corp_fac_divn_cds = HtmlText.iterateQueryParam2(HtmlTag.returnString((String)param.get("CORP_FAC_DIVN_cds"),""), ",");
						param.put("corp_fac_divn_cds", corp_fac_divn_cds);	
				  		rtn_list = list("JiMpMsp.selectJIT_MP_TY_CHARGERList", param);
				  		//log.error("rtn_list==>"+rtn_list);
				  		if(rtn_list!=null){
				  			gridList = cmsService.getGridListScroll(rtn_list);	
				  			if(gridList!=null){
				  				if(gridList.size()> 0){
				  					for(i=0;i<gridList.size();i++){
				  						sendInfo = (Map)gridList.get(i);
				  						String mailto = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("charger_email")));
				  						String mailto_nm = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("charger_user_nm")));
				  						emailParam = new HashMap();
				  						emailParam.put("subject", emailSubject);						//제목
				  						emailParam.put("mailfrom", "\""+gubun+"\"<"+mailFrom+">");		//발송자이메일
				  						emailParam.put("mailto", "\""+sendInfo.get("chag_user_nm")+"\"<"+sendInfo.get("chag_user_email")+">");		//수신자이메일
				  						emailParam.put("sql", "SSV:"+sendInfo.get("chag_user_email"));							//***** 실제발송되는 이메일 *****
				  						emailParam.put("gubun", gubun);									//발송시스템명
				  						emailParam.put("rname", sendInfo.get("chag_user_nm"));		//담당자명
				  						
				  						emailForm = emailForm.replace("{내용하단}", emailFormFt.replaceAll("\\{시스템url}"
				  																		,system_url+HtmlTag.returnString(propertiesService.getString("CON_ROOT"),"")+"/cmsmain.do?scode=S01&pcode=000484&pstate=R&prod_seq="+param.get("ikey_datas")).replaceAll("\\{시스템nm}",gubun));
				  						
				  						//log.debug("emailForm333==>"+emailForm);
				  						emailParam.put("content", emailForm);							//내용
				  						
				  						emailParam.put("MENU_CD", HtmlTag.returnString((String) param.get("pcode"),""));
				  						emailParam.put("MENU_DATA_KEY", HtmlTag.returnString((String) param.get("ikey_datas"),""));
				  						emailParam.put("ORDER_NO", ""+(i+1));
				  						emailParam.put("REG_ID", CM_ADMIN_DEFAULT_ID);
				  						emailParam.put("FR_MAIL", HtmlTag.returnString((String) emailParam.get("mailfrom"),""));
				  						emailParam.put("TO_MAIL", HtmlTag.returnString((String) emailParam.get("mailto"),""));
				  						emailParam.put("TO_USER_ID", HtmlTag.returnString((String)sendInfo.get("chag_emp_no"),""));
				  						emailParam.put("TO_USER_TY", "1");
				  						
				  						
				  						log.error("mail emailParam==>"+emailParam);
				  						
				  						// 메일전송이력을 저장한다
				  						
				  						this.setSendEmail(emailParam);		  						
				  					}
				  				}
				  				
				  			}
				  		}else{
				  			gridList = new ArrayList();
				  		}						
						
						// EMAIL 발송부분

				  		
						result_map.put("result",true);
						result_map.put("TRS_MSG","수정처리가 완료되었습니다.");						
					}
				//}


			// TODO : PWC 비밀번호확인 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("PWC")){
				String ikey_data = HtmlTag.returnString((String)param.get("ikey_data"),"");
				String req_SECRET_NO = HtmlTag.returnString((String)param.get("req_SECRET_NO"),"");
				param.put("prod_seq", ikey_data);

				temp_map = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
				
				if(temp_map==null){
					result_map.put("result",false);
					result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");					
				}else{
					if(temp_map.get("prod_seq")==null){
						result_map.put("result",false);
						result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");						
					}else{
						result_map.put("result",true);
					}
				}

			// TODO : DF ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("R")){
				
				// 미로그인 공개여부가 공개일경우 등록자ID로 회원정보을 취득한다.
				if(SITE_SESSION!= null){
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
    	
			    }
				
				if(!HtmlTag.returnString((String)param.get("rpidx"),"").equals("")){
					param.put("prod_seq", HtmlTag.returnString((String)param.get("rpidx"),""));
				}
				
				
				// 제품이미지
				param.put("file_menu_cd", "000484");
				param.put("file_group_no", "1");
				// 첨부파일 목록
				result_map.put("fileList1", list("JiMpMsp.selectFileList", param));
				
				// 카탈로그
				param.put("file_menu_cd", "000484");
				param.put("file_group_no", "2");
				// 첨부파일 목록
				result_map.put("fileList2", list("JiMpMsp.selectFileList", param));
				
					
				// 조회수증가
				//update("JiScSrm.updateRequstCnt", param);
							
				
				// 상세정보 조회
				HashMap prodDtl = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
				result_map.put("prodDtl", prodDtl);
			
				// 이전글 , 다음글 정보를 불러온다
				List rtn_list = list("JiMpMsp.getJIT_MSC_PROD_RN", param);
				Map tmp_map = new HashMap();
				
				//log.debug("getABDNe1=====================================================");
				if(rtn_list.size() < 1){
					//log.debug("getABDNe2=====================================================");
					log.debug("게시물정보를 가져오지 못했습니다!!");
					result_map.put("TRS_MSG","게시물정보를 가져오지 못했습니다!!");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));	
					throw new JSysException("게시물정보를 가져오지 못했습니다!!");
				}else{				
					tmp_map = (Map)rtn_list.get(0);
					log.debug("========================== tmp_map ===========================");
						result_map.put("prodDtlPrNe",tmp_map);				
				}				
								
				// 등록한 회원정보
				if(HtmlTag.returnString((String)prodDtl.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", prodDtl.get("reg_id"));
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}

				result_map.put("param", param);

			// TODO : D ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("D")){
				
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
		    	
			    }
				if(!HtmlTag.returnString((String)param.get("rpidx"),"").equals("")){
					param.put("prod_seq", HtmlTag.returnString((String)param.get("rpidx"),""));
				}
				
				if(HtmlTag.returnString((String)param.get("USER_ID"),"").equals("")){
					param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("ichk_secret_no"),""));
				}else{
					param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));
				}
				
				
				// 상세정보 조회
				HashMap prodDtl = (HashMap) getSelectByPkNoEgov("JiMpMsp.selectJIT_MSC_PRODList", param);
				
				// 비밀번호 암호화 비교 체크
				Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", param);
				
				result_map.put("prodDtl", prodDtl);
				
				
				if( HtmlTag.returnString((String)prodDtl.get("prod_seq")).equals("")){
					throw new JSysException("삭제할 정보가 일치하지 않습니다.");
				}
				
				// 등록한 회원정보
				if(HtmlTag.returnString((String)prodDtl.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", prodDtl.get("reg_id"));
					if(!HtmlTag.returnString((String)prodDtl.get("reg_id"),"").equals(HtmlTag.returnString((String)param.get("USER_ID"),""))){
						throw new JSysException("삭제할 권한이 없습니다.");
					}
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}else{
					if(HtmlTag.returnString((String)param.get("ichk_secret_no"),"").equals("") 
							|| !pwdCheck.get("data_ipns").equals(HtmlTag.returnString((String)prodDtl.get("secret_no"),""))
							
					){
						throw new JSysException("삭제할 권한이 없습니다.");
					}
				}
				

				String prod_seq = HtmlTag.returnString((String)prodDtl.get("prod_seq"),"");
				String docsave_root = propertiesService.getString("UPLOADROOTPATH");
				String sql = "";
				List rtn_list = new ArrayList();
				Map tmp_map = new HashMap();
				int i=0;
				int chk_cnt=0;

				String rsM_CODE = "";
				String rsRFILE_NM = "";
				String rsREG_DT = "";
				
				//if(!temp_map.get("req_usr_id").equals(param.get("user_id"))){
				//	result_map.put("result",false);
				//	result_map.put("TRS_MSG","수정 권한이 없습니다.");
				//}else{	
					//if(!param.get("SECRET_NO").equals(temp_map.get("secret_no"))){
					//	result_map.put("result",false);
					//	result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
					//	throw new JSysException("비밀번호가 일치하지않습니다.!");
					//}else{
					    /*
					     * 1.K - shop 중소기업 제품관 삭제
					     * 2.첨부파일정보 삭제
					     */
						
						Map query_param = new HashMap();
						// K - shop 중소기업 제품관 번호 셋팅
						param.put("ikey_datas", prod_seq);
					
					
						// 1.K - shop 중소기업 제품관 삭제
						update("JiMpMsp.deleteJIT_MSC_PROD", param);
						
						
						// 2. 첨부테이블을 삭제한다
						sql = "JiCmMtm.getdeleteJRCMS_FILE_MGR_ALL";
						query_param = new HashMap();
						query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
						query_param.put("sidx", prod_seq);
						rtn_list = list(sql, query_param);

						chk_cnt = rtn_list.size();

						if(rtn_list.size() > 0){
							for(i=0;i<rtn_list.size();i++){
								tmp_map = (Map)rtn_list.get(i);
								
								if(tmp_map.get("mCode")!=null){
									rsM_CODE = (String)tmp_map.get("mCode");
								}else{
									rsM_CODE =  "";
								}

								if(tmp_map.get("rfileNm")!=null){
									rsRFILE_NM = (String)tmp_map.get("rfileNm");
								}else{
									rsRFILE_NM =  "";
								}					

								if(tmp_map.get("regDt")!=null){
									rsREG_DT = (String)tmp_map.get("regDt");
								}else{
									rsREG_DT =  "";
								}					

								
								log.debug("deletefile::"+docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);
								FileUtility.deletefile(docsave_root+"/"+rsM_CODE+"/"+rsREG_DT+"/"+rsRFILE_NM);
							}
						}			
						
						sql = "JiCmCms.DeleteJRCMS_FILE_MGR_ALL";
						query_param = new HashMap();
						query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
						query_param.put("sidx", prod_seq);
						
						delete(sql, query_param);
						result_map.put("result",true);
						result_map.put("TRS_MSG","삭제처리가 완료되었습니다.");						
					//}
				//}
				


			// TODO : XPU 비밀번호변경	 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("XPU")){
				
				
				/*// 이전 비밀번호 
				String before_password = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("before_password"),""));
				// 이전 비밀번호 Check
				String chk_password = "";
				// 신규 비밀번호
				String after_password = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("after_password"),""));
				
				temp_map = getSelectByPk("JiScSrm.selectRequst", param);
				
				chk_password = HtmlTag.StripStrInXss(HtmlTag.returnString((String)temp_map.get("rqester_password"), ""));
				
				if(chk_password.equals("")){
					param.put("after_password", JasyptUtil.encSHA256(after_password));
					// 맞춤데이터 요청자 비밀번호 변경
					update("JiScSrm.updateRequstChangePw", param);
					
					result_map.put("newPw", after_password);
					result_map.put("result",true);
					result_map.put("TRS_MSG","비밀번호가 변경되었습니다.");
				}else if(!JasyptUtil.encSHA256(before_password).equals(chk_password)){
					
					result_map.put("result",false);
					result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
					
				}else{
					
					param.put("after_password", JasyptUtil.encSHA256(after_password));
					// 맞춤데이터 요청자 비밀번호 변경
					update("JiScSrm.updateRequstChangePw", param);
					
					result_map.put("newPw", after_password);
					result_map.put("result",true);
					result_map.put("TRS_MSG","비밀번호가 변경되었습니다.");
				}
				*/
				result_map.put("result",true);
				result_map.put("TRS_MSG","비밀번호가 변경되었습니다.");				
				
			}else if(pstate.equals("X")){
				
				result_map = cmDAO.selectListGrid(param, "JiMpMsp.selectJIT_MSC_PRODList");
	
			// 테스트
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
		
		log.debug("==== MpMspDAO01 ctlCMS End ====");
		
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
    		sendEmail.start(param);
    	}
		
	}
}
