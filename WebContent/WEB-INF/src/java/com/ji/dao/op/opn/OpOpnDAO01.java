package com.ji.dao.op.opn;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

//import org.apache.catalina.connector.Request;
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
 * @see    OpOpnDAO01
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
@Repository("opOpnDAO01")
public class OpOpnDAO01 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(OpOpnDAO01.class); //현재 클래스 이름을 Logger에 등록
	
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
    	
    	log.debug("==== OpOpnDAO01 ctlCMS Start ====");
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
			
			/*
			 * L      	:  인트로
			 * L2      	:  접수확인 화면
			 * CF		: 등록화면
			 * C		: 등록
			 * UF		: 수정화면
			 * U		: 수정
			 * DF		: 상세화면
			 * D		: 삭제
			 * UCL		: 요청취소
			 * **********************************************
			 * U2		: 관리자 접수저장
			 */
			// TODO : L
			if(pstate.equals("L")){
	
				result_map.put("param", param);
			// TODO : L1	
			}else if(pstate.equals("L1")){
				// 휴대전화국번
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 이메일코드
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				
				result_map.put("param", param);	
				
			// TODO : L2	
			}else if(pstate.equals("L2")){
					
				String page = HtmlTag.returnString((String)param.get("page"),"1");
				param.put("page", page);
				
							
				result_map.put("param", param);					
				
			// TODO : X	
			}else if(pstate.equals("X")){	
				// 로그인을 한경우
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
			    	}
			    }				
				result_map = cmDAO.selectListGrid(param, "JiOpOpn.selectJIT_BOARD_PROPOSALList");	
				
			// TODO : R
			}else if(pstate.equals("R")){				
			
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
		    	
			    }
				if(SITE_SESSION!= null){
					param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
					
				}
				
				// 상세정보 조회
				HashMap proposalDtl = (HashMap) getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", param);
				result_map.put("proposalDtl", proposalDtl);		
				
				if( HtmlTag.returnString((String)proposalDtl.get("data_seqno")).equals("")){
					throw new JSysException("수정할 정보가 없습니다.");
				}
				
				// 등록한 회원정보
				if(HtmlTag.returnString((String)proposalDtl.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", proposalDtl.get("reg_id"));
					if(!HtmlTag.returnString((String)proposalDtl.get("reg_id"),"").equals(HtmlTag.returnString((String)param.get("USER_ID"),""))){
						throw new JSysException("수정할 권한이 없습니다.");
					}
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}
				
				// 조회수증가
				update("JiOpOpn.updateJIT_BOARD_PROPOSALCnt", param);
				
				// 첨부파일
				param.put("file_menu_cd", HtmlTag.returnString((String)param.get("pcode"),""));
				param.put("file_group_no", "1");
				// 첨부파일 목록
				result_map.put("fileList1", list("JiOpOpn.selectFileList", param));					
				
				result_map.put("param", param);	
				
				result_map.put("result",true);
				result_map.put("TRS_MSG","");					
				
			// TODO : CF	
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
						throw new JSysException("정상적으로 본인인증이 되지않았습니다");
					}else{
						if(SITE_AUTH_SESSION.get("sName")==null){
							throw new JSysException("정상적으로 본인인증이 되지않았습니다");
						}else{
							log.debug("session chk 2======================");
				    		param.put("SITE_AUTH_SESSION", SITE_AUTH_SESSION);
						
						}
			    	}
			    }
				
				// 휴대전화국번
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 이메일코드
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 등록한 회원정보
				if(!HtmlTag.returnString((String)param.get("user_id"),"").equals("")){
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}
				
				result_map.put("param", param);
				
			// TODO : UF	
			}else if(pstate.equals("UF")){	
				if(SITE_SESSION!= null){
			    	param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
			    }
								
				temp_map = getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", param);
				
				if( HtmlTag.returnString((String)temp_map.get("data_seqno")).equals("")){
					throw new JSysException("수정할 정보가 없습니다.");
				}

				// 비밀번호 암호화 비교 체크
				param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO")));
				Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", param);
				
				// 등록한 회원정보
				if(HtmlTag.returnString((String)temp_map.get("auth_type"),"").equals("LOGIN")){
					param.put("user_id", temp_map.get("reg_id"));
					if(!HtmlTag.returnString((String)temp_map.get("reg_id"),"").equals(HtmlTag.returnString((String)param.get("USER_ID"),""))){
						throw new JSysException("수정할 권한이 없습니다.");
					}
					result_map.put("userDtl", getSelectByPk("JiMpMsp.selectUserInfo", param));					
				}else{
					if(!HtmlTag.returnString((String)temp_map.get("reg_nm"),"").equals(HtmlTag.returnString((String)param.get("REG_NM"),""))
							|| !HtmlTag.returnString((String)temp_map.get("reg_hp_no"),"").equals(HtmlTag.returnString((String)param.get("REG_HP_NO"),""))
							|| !HtmlTag.returnString((String)temp_map.get("reg_email"),"").equals(HtmlTag.returnString((String)param.get("REG_EMAIL"),""))
							|| !HtmlTag.returnString((String)temp_map.get("secret_no"),"").equals(pwdCheck.get("data_ipns"))
							
					){
						throw new JSysException("수정할 권한이 없습니다.");
					}
				}
				
				// 휴대전화국번
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 이메일코드
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));	
				
				
				
				result_map.put("proposalDtl", temp_map);
				
				
				result_map.put("param", param);		
				
				
				
			// TODO : CF1	
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
					throw new JSysException("개인정보 동의 내용이 없습니다.");
				}
				
				result_map.put("param", param);
					
			// TODO : C	
			}else if(pstate.equals("C")){
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
						throw new JSysException("정상적으로 본인인증이 되지않았습니다");
					}else{
						if(SITE_AUTH_SESSION.get("sName")==null){
							throw new JSysException("정상적으로 본인인증이 되지않았습니다");
						}else{
							log.debug("session chk 2======================");
				    		param.put("SITE_AUTH_SESSION", SITE_AUTH_SESSION);
						
						}
			    	}
			    }
								
				// 본인인증 종류
				// 회원가입 로그인시
				if(!HtmlTag.returnString((String)param.get("user_id"),"").equals("")){
					param.put("AUTH_TYPE", "LOGIN");
					param.put("REG_NM", HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
					param.put("REG_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				
				}else{
					// 본인 인증시
					if(!HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),"").equals("")){
						param.put("AUTH_TYPE", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),""));
						param.put("REG_NM", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sName"),""));
						
						// 핸드폰 실명인증시
						if(HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),"").equals("CHECKPLUS")){
							String sMobileNo = HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sMobileNo"),"");
							if(!sMobileNo.equals("")){
								if(sMobileNo.length()==11){
									param.put("REG_HP_NO", sMobileNo.substring(0,3)+"-"+sMobileNo.substring(3,7)+"-"+sMobileNo.substring(7,11));

								}else if(sMobileNo.length()==10){
									param.put("REG_HP_NO", sMobileNo.substring(0,3)+"-"+sMobileNo.substring(3,6)+"-"+sMobileNo.substring(6,10));
								}else{
									param.put("REG_HP_NO", "");
								}
								
							}
							
							
							param.put("IPIN_NO", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sVNumber"),""));
							param.put("DUPL_INFO", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sDupInfo"),""));
						// IPIN 인증시
						}else if(HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),"").equals("IPIN")){
							param.put("IPIN_NO", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sVNumber"),""));
							param.put("DUPL_INFO", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sDupInfo"),""));
						}
								            
			    		param.put("SITE_AUTH_SESSION", SITE_AUTH_SESSION);
						
					// 미인증시
					}else{
						param.put("AUTH_TYPE", "NONE");
						log.debug("session chk 3======================");
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));						
					}
					
				}				
				
				int i=0;
				int JIT_BOARD_PROPOSAL_SEQ = 0;
				Map query_param = new HashMap();
				long r_idx= 0;
			    int r_depth=1;
			    int r_order=1;				
				
				Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
				String MENU_NM = HtmlTag.returnString((String)MENUCFG.get("menuNm"),""); //메뉴명				
			    /*
			     * 1.제안하기 등록
			     * 2.첨부파일정보 등록
			     * 
			     */
				JIT_BOARD_PROPOSAL_SEQ = cmDAO.getSequence("JIT_BOARD_PROPOSAL");
				// 파일정보 연결키값
				param.put("ikey_datas", ""+JIT_BOARD_PROPOSAL_SEQ);	
				
				r_idx = JIT_BOARD_PROPOSAL_SEQ;
				param.put("r_idx", ""+r_idx);	
				param.put("r_depth", ""+r_depth);	
				param.put("r_order", ""+r_order);	
				param.put("REG_TY", "1");	
				// 1.제안하기 등록
				insert("JiOpOpn.insertJIT_BOARD_PROPOSAL", param);
				
				// 2.첨부파일정보 등록
				
				param.put("imenu_data_title", "["+MENU_NM+"]"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("DATA_TITLE").toString(),"")));
				param.put("ikey_datas", param.get("ikey_datas"));
				// 첨부파일 체크
				cmMtmDAO01.InsertFile(param);	
				
				// 담당자에게 메일을 전송한다
				// EMAIL 발송부분
				String emailForm = propertiesService.getString("CM_EMAIL_FORM");	//메일폼을 불러온다
				String emailFormFt = propertiesService.getString("CM_EMAIL_FORM_FT");	//메일폼 하단을 불러온다
				String gubun = HtmlTag.StripStrInXss(HtmlTag.returnString(propertiesService.getString("SYSTEM_NAME")));
				String system_url = HtmlTag.returnString(propertiesService.getString("CM_SYSTEM_URL"),"");
				String CM_ADMIN_DEFAULT_ID = HtmlTag.returnString(propertiesService.getString("CM_ADMIN_DEFAULT_ID"));
				String mailFrom = propertiesService.getString("CM_ADMIN_EMAIL");				
				String emailSubject = "["+gubun+"]";
				String emailTitle = "["+gubun+"]";
				String emailContent = MENU_NM+"";
										
				emailSubject = emailSubject+" "+MENU_NM+"에 제안이 등록되었습니다.";
				emailTitle = emailTitle+" "+MENU_NM;
				emailContent = emailContent+" 제안이 등록되었습니다.<br />";
						emailContent = emailContent+"제안제목 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("DATA_TITLE").toString(),""))+"<br />";
						emailContent = emailContent+"등록자 :"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("REG_NM").toString(),""))+"<br />";

				        
				//log.debug("emailForm111==>"+emailForm);
					emailForm = emailForm.replaceAll("\\{시스템url}",system_url).replaceAll("\\{시스템nm}",gubun);
					emailForm = emailForm.replace("{제목}", emailTitle);
					//emailForm = emailForm.replace("{내용}", emailContent);
					//log.debug("emailForm222==>"+emailForm);
					// 내용 제목과 동일하게 넣어달라는 현업요구 반영
					emailForm = emailForm.replace("{내용}", emailContent);
					
				// 권한관리 권한그룹 연구개발 000003 지원사업 000005 수출규제 000006 코로나19 000007
				if(HtmlTag.returnString((String)param.get("pcode"),"").equals("000470")){
					param.put("sauth_grp_cd", "000003");
				}else if(HtmlTag.returnString((String)param.get("pcode"),"").equals("000523")){
					param.put("sauth_grp_cd", "000005");
				}else if(HtmlTag.returnString((String)param.get("pcode"),"").equals("000552")){
					param.put("sauth_grp_cd", "000006");
				}else if(HtmlTag.returnString((String)param.get("pcode"),"").equals("000554")){
					param.put("sauth_grp_cd", "000007");
				}

		  		List rtn_list = list("JiCmOam.selectAuthGrpUserList", param);
		  		List gridList = new ArrayList();
		  		Map sendInfo = new HashMap();
		  		Map emailParam = new HashMap();
		  		if(rtn_list!=null){
		  			gridList = cmsService.getGridListScroll(rtn_list);	
		  			if(gridList!=null){
		  				if(gridList.size()> 0){
		  					for(i=0;i<gridList.size();i++){
		  						sendInfo = (Map)gridList.get(i);
		  						String mailto = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("email")));
		  						String mailto_nm = HtmlTag.StripStrInXss(HtmlTag.returnString((String) sendInfo.get("user_nm")));
		  						emailParam = new HashMap();
		  						emailParam.put("subject", emailSubject);						//제목
		  						emailParam.put("mailfrom", "\""+gubun+"\"<"+mailFrom+">");		//발송자이메일
		  						emailParam.put("mailto", "\""+sendInfo.get("user_nm")+"\"<"+sendInfo.get("email")+">");		//수신자이메일
		  						emailParam.put("sql", "SSV:"+sendInfo.get("email"));							//***** 실제발송되는 이메일 *****
		  						emailParam.put("gubun", gubun);									//발송시스템명
		  						emailParam.put("rname", sendInfo.get("user_nm"));		//담당자명
		  						
		  						emailForm = emailForm.replace("{내용하단}", emailFormFt.replaceAll("\\{시스템url}"
		  																		,system_url+HtmlTag.returnString(propertiesService.getString("CON_ROOT"),"")+"/cmsmain.do?scode=sysadm").replaceAll("\\{시스템nm}",gubun));
		  						//log.debug("emailForm333==>"+emailForm);
		  						emailParam.put("content", emailForm);							//내용
		  						
		  						emailParam.put("MENU_CD", HtmlTag.returnString((String) param.get("pcode"),""));
		  						emailParam.put("MENU_DATA_KEY", HtmlTag.returnString((String) param.get("ikey_datas"),""));
		  						emailParam.put("ORDER_NO", ""+(i+1));
		  						emailParam.put("REG_ID", CM_ADMIN_DEFAULT_ID);
		  						emailParam.put("FR_MAIL", HtmlTag.returnString((String) emailParam.get("mailfrom"),""));
		  						emailParam.put("TO_MAIL", HtmlTag.returnString((String) emailParam.get("mailto"),""));
		  						emailParam.put("TO_USER_ID", HtmlTag.returnString((String)sendInfo.get("user_id"),""));
		  						emailParam.put("TO_USER_TY", "1");
		  						
		  						//log.error("mail emailParam==>"+emailParam);
		  						
		  						// 메일전송이력을 저장한다
		  						
		  						this.setSendEmail(emailParam);		  						
		  					}
		  				}
		  				
		  			}
		  			
		  		}
		  					

				
				result_map.put("result",true);
				result_map.put("TRS_MSG","등록되었습니다");	
				
			// TODO : U	
			}else if(pstate.equals("U")){
					Map query_param = new HashMap();
					// 로그인을 한경우
					if(SITE_SESSION!= null){
						log.debug("session chk 1======================");
				    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
				    	param.put("user_nm", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"")));
				    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
				    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
				    	}else{
							query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
							query_param.put("data_seqno", HtmlTag.returnString((String)param.get("data_seqno"),""));
							query_param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
							query_param.put("SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));
							
				    	}
				    }else{
				    	// 로그인 없이 수정인경우 필수 입력값체크
				    	if(HtmlTag.returnString((String)param.get("data_seqno"),"").equals("")
				    			|| HtmlTag.returnString((String)param.get("orgREG_NM"),"").equals("")
				    			|| HtmlTag.returnString((String)param.get("orgREG_HP_NO"),"").equals("")
				    			|| HtmlTag.returnString((String)param.get("orgREG_EMAIL"),"").equals("")
				    			|| HtmlTag.returnString((String)param.get("SECRET_NO"),"").equals("")
				    	){
				    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.notauth"));
				    	}else{
							query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
							query_param.put("data_seqno", HtmlTag.returnString((String)param.get("data_seqno"),""));
							query_param.put("REG_NM", HtmlTag.returnString((String)param.get("orgREG_NM"),""));
							query_param.put("REG_HP_NO", HtmlTag.returnString((String)param.get("orgREG_HP_NO"),""));
							query_param.put("REG_EMAIL", HtmlTag.returnString((String)param.get("orgREG_EMAIL"),""));
							query_param.put("SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));				    		
				    	}
				    	
				    	
				    }	
					
					Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
					String MENU_NM = HtmlTag.returnString((String)MENUCFG.get("menuNm"),""); //메뉴명						
								
					temp_map = getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", query_param);
					
					if( HtmlTag.returnString((String)temp_map.get("data_seqno")).equals("")){
						throw new JSysException("수정할 권한이 없습니다.");
					}
					
					// 제안게시판 번호 셋팅
					param.put("ikey_datas", HtmlTag.returnString((String)param.get("data_seqno"),""));
					
					// 1.제안게시판 수정
					update("JiOpOpn.updateJIT_BOARD_PROPOSAL", param);
					
					// 2. 첨부파일 처리
					param.put("imenu_data_title", "["+MENU_NM+"]"+HtmlTag.StripStrInXss(HtmlTag.returnString(param.get("DATA_TITLE").toString(),"")));
					param.put("iuploadseq", "");
					cmMtmDAO01.InsertFile(param);
					
					result_map.put("result",true);
					result_map.put("TRS_MSG","수정되었습니다");					
				
			// TODO : D ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			}else if(pstate.equals("D")){
					
				Map query_param = new HashMap();
				// 로그인을 한경우
				if(SITE_SESSION!= null){
					log.debug("session chk 1======================");
			    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
			    	param.put("user_nm", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"")));
			    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
			    	}else{
						query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
						query_param.put("data_seqno", HtmlTag.returnString((String)param.get("data_seqno"),""));
						query_param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
						query_param.put("SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));
						
			    	}
			    }else{
			    	// 로그인 없이 수정인경우 필수 입력값체크
			    	
			    	if(HtmlTag.returnString((String)param.get("data_seqno"),"").equals("")
			    			|| HtmlTag.returnString((String)param.get("orgREG_NM"),HtmlTag.returnString((String)param.get("REG_NM"),"")).equals("")
			    			|| HtmlTag.returnString((String)param.get("orgREG_HP_NO"),HtmlTag.returnString((String)param.get("REG_HP_NO"),"")).equals("")
			    			|| HtmlTag.returnString((String)param.get("orgREG_EMAIL"),HtmlTag.returnString((String)param.get("REG_EMAIL"),"")).equals("")
			    			|| HtmlTag.returnString((String)param.get("SECRET_NO"),"").equals("")
			    	){
			    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.notauth"));
			    	}else{
						query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
						query_param.put("data_seqno", HtmlTag.returnString((String)param.get("data_seqno"),""));
						query_param.put("REG_NM", HtmlTag.returnString((String)param.get("orgREG_NM"),HtmlTag.returnString((String)param.get("REG_NM"),"")));
						query_param.put("REG_HP_NO",  HtmlTag.returnString((String)param.get("orgREG_HP_NO"),HtmlTag.returnString((String)param.get("REG_HP_NO"),"")));
						query_param.put("REG_EMAIL", HtmlTag.returnString((String)param.get("orgREG_EMAIL"),HtmlTag.returnString((String)param.get("REG_EMAIL"),"")));
						query_param.put("SECRET_NO", HtmlTag.returnString((String)param.get("SECRET_NO"),""));				    		
			    	}
			    	
			    	
			    }	
				
				Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
				String MENU_NM = HtmlTag.returnString((String)MENUCFG.get("menuNm"),""); //메뉴명						
							
				temp_map = getSelectByPkNoEgov("JiOpOpn.selectJIT_BOARD_PROPOSALList", query_param);
				
				if( HtmlTag.returnString((String)temp_map.get("data_seqno")).equals("")){
					throw new JSysException("삭제할 권한이 없습니다.");
				}			
					
					String data_seqno = HtmlTag.returnString((String)temp_map.get("data_seqno"),"");
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
						     * 1.제안게시판 삭제
						     * 2.첨부파일정보 삭제
						     */
							
							query_param = new HashMap();
							// 제안게시판 번호 셋팅
							param.put("ikey_datas", data_seqno);
						
						
							// 1.제안게시판 삭제
							update("JiOpOpn.deleteJIT_BOARD_PROPOSAL", param);
							
							
							// 2. 첨부테이블을 삭제한다
							sql = "JiCmMtm.getdeleteJRCMS_FILE_MGR_ALL";
							query_param = new HashMap();
							query_param.put("pcode", HtmlTag.returnString((String)param.get("pcode"),""));
							query_param.put("sidx", data_seqno);
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
							query_param.put("sidx", data_seqno);
							
							delete(sql, query_param);
							result_map.put("result",true);
							result_map.put("TRS_MSG","삭제처리가 완료되었습니다.");						
						//}
					//}				
				
			// TODO : XL1	
			}else if(pstate.equals("XL1")){				
				// 접수 확인 
				HashMap chkDtl = (HashMap) getSelectByPk("JiOpOpn.getJIT_BOARD_PROPOSALChk", param);
				result_map.put("chkDtl", chkDtl);
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
