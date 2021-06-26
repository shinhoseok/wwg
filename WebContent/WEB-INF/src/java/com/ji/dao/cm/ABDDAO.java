package com.ji.dao.cm;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.ji.cm.CM_Util;
import com.ji.cm.SendEmail;
import com.ji.cm.SendSms;
import com.ji.common.FileUtility;
import com.ji.common.HtmlTag;
import com.ji.common.HtmlText;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.Param;
import com.ji.dao.cm.mtm.CmMtmDAO01;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : ABDDAO.java
 * @Description : ABDDAO DAO Class
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

@Repository("abdDAO")
public class ABDDAO extends CmsDsDao {
	protected Logger log = Logger.getLogger(ABDDAO.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService;  
    
    /** cmMtmDAO01 */
    @Resource(name="cmMtmDAO01")
    private CmMtmDAO01 cmMtmDAO01;
 
    /** sendEmail */
    @Resource(name="sendEmail")
    private SendEmail sendEmail;	//메일발송
    
    /** sendSms */
    @Resource(name="sendSms")
    private SendSms sendSms;		//문자발송
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	

    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;  
    
    /**
	 * 메뉴트리를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
    public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//TODO ctlCMS
		log.debug("==== ABDDAO ctlCMS Start ====");
		String ikey_data = HtmlTag.returnString((String)param.get("ikey_data"),"");
		//체크
		if(!ikey_data.equals("")){
			param.put("sidx", ikey_data);
		}
		
		Map result_map = new HashMap();
		
		String pcode = HtmlTag.returnString((String)param.get("pcode"),"");
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		String USER_ID = "";
		
		try{
 		    Map SITE_SESSION	= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
 		    if(SITE_SESSION!=null){
 		    	USER_ID	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
 		    }else{
 		    	USER_ID = "";
 		    }
				
 		   Map SITE_ADM_SESSION_FN	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
		    if(SITE_ADM_SESSION_FN!=null){
 		    	USER_ID	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION_FN.get("USER_ID"),""));
 		    }else{
 		    	USER_ID = "";
 		    }
		    
				//jqGrid exceldown 
				if(HtmlTag.returnString((String)param.get("jqGrid.oper"),"").equals("excel")){ //그리드 엑셀다운 : 현재페이지 출력 임시
					if(param.get("jqGrid.page")!=null){ //jqGrid 페이지번호 파라미터 
		    			param.put("curr_page",param.get("jqGrid.page"));
		    		}
					return getListABD_X(param);
				}
				
				// 목록
				if(pstate.equals("L")){
					result_map = getListABD(param);
					
				}else if(pstate.equals("X")){ //ajax jqGrid data관련
					result_map = getListABD_X(param);
					
				// 등록
				}else if(pstate.equals("C")){
					result_map = insertABD(param);
					
				// 등록화면
				}else if(pstate.equals("CF")){
					result_map = getABD_CF(param);
					
					String dsche_st_ymd = HtmlTag.returnString((String)param.get("rdate"),"");
					String ymd="";
					if(!dsche_st_ymd.equals("")){
						ymd += dsche_st_ymd.substring(0, 4);
						ymd += "-"+dsche_st_ymd.substring(4, 6);
						ymd += "-"+dsche_st_ymd.substring(6, 8);
					}
					
					result_map.put("rdate",ymd);
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
					if(!HtmlTag.returnString((String)param.get("agree_1"),"").equals("Y") && !HtmlTag.returnString((String)param.get("scode"),"").equals("sysadm")){
						throw new JSysException("개인정보 동의 내용이 없습니다.");
					}
					
					result_map.put("param", param);					
					
				// 수정화면
				}else if(pstate.equals("UF")){
					result_map = getABD(param);
					
				// 수정
				}else if(pstate.equals("U")){
					result_map = updateABD(param);
					
				// 삭제
				}else if(pstate.equals("D")){
					result_map = deleteABD(param);
					
				// 상세조회
				}else if(pstate.equals("R")){
					result_map = getABD(param);	
					
				// 답변 등록화면
				}else if(pstate.equals("RF")){
					result_map = getABD(param);
					
				// 답변 등록
				}else if(pstate.equals("RE")){
					result_map = insertABDRE(param);
					
				// 댓글 등록
				}else if(pstate.equals("RR")){
					result_map = insertABDRR(param);
					
				// 댓글 수정
				}else if(pstate.equals("RRU")){
					result_map = updateABDRR(param);
					
				// 댓글 삭제
				}else if(pstate.equals("RRD")){
					result_map = deleteABDRR(param);	
					
				// 댓글에 댓글등록
				}else if(pstate.equals("RRC")){
					result_map = insertABDRRC(param);
					
				// 지원사업공고 신청목록 조회
				}else if(pstate.equals("XR1")){
					List rtn_list = list("JiCmAbd.selectBOARDREList", param);
					//List rtn_list = cmDAO.getListSqlOnly (param, "JiCmAbd.selectBOARDREList");
					List gridList = cmsService.getGridListScrollNotEgov(rtn_list);
					
					result_map.put("page", "0"); //현재 page번호
					result_map.put("total", "1"); //전체 page번호
					result_map.put("records", rtn_list.size()); //전체 record수
					result_map.put("rows",gridList);
					
				// 지원사업공고 신청 상세 조회
				}else if(pstate.equals("XR2")){
						//List rtn_list = cmDAO.getListSqlOnly (param, "JiCmAbd.selectBOARDREList");
					SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
					if(!HtmlTag.returnString((String)param.get("scode"),"").equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
						if(SITE_SESSION!= null){
							param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
							param.put("USER_NM", HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));  
				    	}else{
				    		throw new JSysException("로그인 정보가 없습니다.");
				    	}						
					}
					
					Map reMap = cmDAO.getSelectByPkNoEgov("JiCmAbd.selectBOARDREList", param);	
						
					result_map.put("reMap",reMap);
					 
				// TODO : PWC 비밀번호확인 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
				}else if(pstate.equals("PWC")){
					// 로그인이 필요한 게시판일경우
				    SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
					    
					String req_SECRET_NO = HtmlTag.returnString((String)param.get("req_SECRET_NO"),"");
					
					if(SITE_SESSION!= null){
						param.put("USER_ID", HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
						param.put("USER_NM", HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));  
			    	}else{
						param.put("USER_ID", "");
						param.put("USER_NM", "");			    		
			    	}
					Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
					log.debug("MENUCFG::"+MENUCFG);
					// 게시판 종류는 0000000008:공지형 , 0000000009:자유형 , 0000000010:답변형, 0000000011:갤러리형, 0000000025:통합형
					String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
					
					param.put("BOARD_TY", BOARD_TY);
					
					Map temp_map = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_S2", param);
					Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", param);
					
					if(temp_map==null){
						log.debug("temp_map111:::"+temp_map);
						result_map.put("result",false);
						result_map.put("TRS_MSG","접근 권한이 없습니다.");					
					}else{
						if(temp_map.get("data_seqno")==null){
							log.debug("temp_map2222::"+temp_map);
							result_map.put("result",false);
							result_map.put("TRS_MSG","접근 권한이 없습니다.");						
						}else{
							if(!pwdCheck.get("data_ipns").equals(temp_map.get("data_ipns"))){
								log.debug("temp_map3333::"+temp_map);
								log.debug("temp_map4444::"+req_SECRET_NO);
								result_map.put("result",false);
								result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
							}else{
								result_map.put("result",true);
							}							
						}
					}					
				// TODO : IPNSCHK	
				}else if(pstate.equals("IPNSCHK")){
					
					String rqester_password = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("rqester_password"),""));
					String ifrm_rcept_no = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("ifrm_rcept_no"),""));
					param.put("sidx", ifrm_rcept_no);
					
					List res_list = list("JiCmAbd.getBOARD_S2", param);
					Map temp_map = new HashMap();
					if(res_list!=null){
						if(res_list.size()>0){
							temp_map = (Map)res_list.get(0);
							//log.debug("1111===>"+JasyptUtil.encSHA256(rqester_password));
							//log.debug("22222===>"+temp_map);
							if(!JasyptUtil.encSHA256(rqester_password).equals(temp_map.get("DATA_IPNS"))){
								result_map.put("result",false);
								result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
							}else{
								result_map.put("result",true);
							}							
						}else{
							result_map.put("result",false);
							result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");							
						}
					}else{
						result_map.put("result",false);
						result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");						
					}
				}
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.debug("SQLException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  "+q);	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ABDDAO ctlCMS End ====");
		return result_map;
    }

    
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서게시판관리관련 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  게시판관리관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getListABD (Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getListABD
		log.debug("==== getListABD Start ====");
		Map result_map = new HashMap();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();	
		Map result_page = new HashMap();	

		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		int i = 0;
		int j = 0;
		//log.debug("getListABD:111111111111111111111111111111111111111:");
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("mOpt"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		//log.debug("getListABD:222222222222222222222222222222222222222:MENUCFG:"+MENUCFG);
		
		// 게시판 종류는 000010:공지형 , 000011:자유형 , 000012:답변형, 000013:갤러리형 , 000014:통합형
		String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
		String BOARD_INT_M_CODES	= HtmlTag.returnString((String)MENUCFG.get("boardIntMCodes"),"");
		String BOARD_INT_TY			= HtmlTag.returnString((String)MENUCFG.get("boardIntTy"),"");
		
		String BOARD_LI_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItem"),"");
		String BOARD_LI_ITEM_NM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItemNm"),"");
		String BOARD_ETC_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardEtcItem"),"");
		String BOARD_ETC_ITEM_TY	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemTy"),"");
		String BOARD_ETC_ITEM_NM	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemNm"),"");
		String BOARD_OPT			= HtmlTag.returnString((String)MENUCFG.get("boardOpt"),"");
		String BOARD_ETC_ITEM_CODE	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemCode"),"");
		
		String [] BOARD_LI_ITEM_ARR		= HtmlText.split2(BOARD_LI_ITEM,"::");
		String [] BOARD_LI_ITEM_NM_ARR	= HtmlText.split2(BOARD_LI_ITEM_NM,"::");
		String [] BOARD_ETC_ITEM_ARR	= HtmlText.split2(BOARD_ETC_ITEM,"::");
		String [] BOARD_ETC_ITEM_TY_ARR	= HtmlText.split2(BOARD_ETC_ITEM_TY,"::");
		String [] BOARD_ETC_ITEM_NM_ARR	= HtmlText.split2(BOARD_ETC_ITEM_NM,"::");
		String [] BOARD_OPT_ARR			= HtmlText.split2(BOARD_OPT,"::");	
		String [] BOARD_ETC_ITEM_CODE_ARR	= HtmlText.split2(BOARD_ETC_ITEM_CODE,"::");
		//String [] BOARD_INT_M_CODES_ARR	= HtmlText.split2(BOARD_INT_M_CODES,"::");
		ArrayList<String> BOARD_INT_M_CODES_ARR = HtmlText.iterateQueryParam2(BOARD_INT_M_CODES,"::");
		
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		String se_field	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_field"),"") );
		String se_text	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_text"),"") );
		String se_code	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_code"),"") );
		String se_step	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_step"),"") );
		int curr_page	= Integer.parseInt(HtmlTag.returnString((String)param.get("curr_page"),"1"),10);		
		int show_rows	= 0;
		// 갤러리형일경우 20개씩 가져온다
		if(BOARD_TY.equals("000013")){
			show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"20"),10);
		}else{
			show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"10"),10);
		}
		
		// 일정형의 경우 날짜 셋팅
    	String cyear = "";
    	String cmonth = "";
    	int startday = 0;		
		Calendar cal = Calendar.getInstance();
    	if(param.get("cyear") == null || param.get("cmonth") == null) {
    		cyear = String.valueOf(cal.get(Calendar.YEAR));
    		cmonth = ((cal.get(Calendar.MONTH)+1) > 9 ? 
    				String.valueOf(cal.get(Calendar.MONTH)+1) :
    			"0"+String.valueOf(cal.get(Calendar.MONTH)+1));
    	} else {
    		cyear = (String)param.get("cyear");
    		cmonth = (String)param.get("cmonth");
    		cal.set(Calendar.YEAR, Integer.parseInt(cyear));
    		cal.set(Calendar.MONTH, Integer.parseInt(cmonth.startsWith("0")?cmonth.substring(1):cmonth)-1);
    	}
		cal.set(Calendar.DATE, 1); //DAY_OF_WEEK 
		startday = cal.get(Calendar.DAY_OF_WEEK);
		
		
		//log.debug("getListABD:33333333333333333333333333333333333333333:");
		Map SITE_SESSION = new HashMap();
		Map SITE_ADM_SESSION = new HashMap();
		int admin_chk =0;
		String USER_ID = "";
		String USER_NAME = "";
		// 로그인이 필요한 게시판일경우

		    SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
		    SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));

		    
		    if(SITE_SESSION!=null){
		    	log.debug("getListABD:SITE_SESSION111:"+SITE_SESSION);
				   USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				   USER_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
				   admin_chk = 0;
		    
		    }else if(SITE_ADM_SESSION!=null){
		    	log.debug("getListABD:SITE_SESSION222:"+SITE_ADM_SESSION);
				   USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				   USER_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
				   admin_chk = 1;
		    }else{
		    	log.debug("getListABD:SITE_SESSION333:");
				   USER_ID		= "";
				   USER_NAME	= "";
		    	admin_chk =0;
		    }

		// 로그인이 필요없는 게시판일경우
		//}else{
		
		//}
		
	    
		String sql = "";
		Map query_param = new HashMap();		

    	int totalPages = 0;
    	int totalCount = 0;
 	
	    int firstRow =1;
	    int endRow = 1; 
	    Map tmp_page_map = new HashMap();
	    
		try{
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY"), Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			for(i=0;i<=9;i++){	
				//log.debug(i+"::"+BOARD_ETC_ITEM_ARR[i]);
				
				// 임시컬럼의 사용여부가 Y이면
				if(BOARD_ETC_ITEM_ARR[i].equals("Y")){
					// 임시컬럼의 데이터타입이 C(코드)이면
					if(BOARD_ETC_ITEM_TY_ARR[i].equals("C")){
						//log.debug(i+"::"+BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam = new HashMap();
						
						codeparam.put("all_fl", BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam.put("use_yn", "Y");
						codeparam.put("notinstr", "");
						codeparam.put("inout_fl", "");

						temp_code = cmDAO.getCode_Select (codeparam);
						//log.debug(i+"::"+((List)temp_code.get("ListTreeACD")).size());
						result_map.put("ListTreeETC"+i, temp_code.get("ListTreeACD"));		
					}
				}
			}
			
			
			sql = "JiCmAbd.getBOARD_Cnt";
			query_param.put("vmode", "");
			query_param.put("BOARD_TY", BOARD_TY);
			query_param.put("BOARD_INT_M_CODES_ARR", BOARD_INT_M_CODES_ARR);
			query_param.put("pcode", pcode);
			query_param.put("BOARD_INT_TY", BOARD_INT_TY);
			query_param.put("scode", scode);
			query_param.put("USER_ID", USER_ID);
			query_param.put("curr_page", curr_page+"");

			// 일정형인경우 달력이므로 해당 월의 모든 데이터를 가져오도록 셋팅
			if(BOARD_TY.equals("000051")){
				query_param.put("show_rows", "1000");
			}else{
				query_param.put("show_rows", show_rows+"");
			}
			
			query_param.put("cyymm", cyear+cmonth);
			
			// 관리자화면이 아닐경우 미게시외의 자료만 가져온다
			if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
				query_param.put("scodeadm", "N");
			}else{
				query_param.put("scodeadm", "Y");
			}
			
			query_param.put("se_field", se_field);
			query_param.put("se_text", se_text);
			query_param.put("se_code", se_code);
			query_param.put("se_step", se_step);
			result_page = cmDAO.selectListGrid(query_param, "JiCmAbd.getBOARD");			
			
			totalCount = ((Integer)(result_page.get("records"))).intValue();
			totalPages = ((Integer)(result_page.get("total"))).intValue();
	    	
	
	    	log.debug("JiCmAbd.getBOARD_Cnt:GET_GONGJI:totalCount:"+totalCount);

	    	
		    totalPages = (int) Math.ceil( (double) totalCount / ( (double) show_rows));    	
		    
		    firstRow = (curr_page * show_rows) - show_rows;
		    endRow = curr_page * show_rows;  

		    tmp_page_map.put("setTotalCount", totalCount);
		    tmp_page_map.put("setPageSize",Integer.toString(show_rows));
		    tmp_page_map.put("setTotalPageCount",Integer.toString(totalPages));		    
		    tmp_page_map.put("setList",(List)result_page.get("rows"));
		    tmp_page_map.put("setCurrentPage",Integer.toString(curr_page));
		    
			
			result_map.put("PageListABD", tmp_page_map);
			// 일정형 관련 일자
			result_map.put("cyear", cyear);
			result_map.put("cmonth", cmonth);			
			result_map.put("startday", new Integer(startday));
			result_map.put("endday", new Integer(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));			
	
			result_map.put("TRS_MSG","");
		}catch(IOException q){
			log.debug("getListABD IOException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(SQLException q){
			log.debug("getListABD SQLException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(NullPointerException q){
			log.debug("getListABD NullPointerException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("getListABD ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(Exception q){
			log.debug("getListABD Exception:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");
	
		}

    	log.debug("==== getListABD End ====");
		return result_map;
	}
	/**
	 * ajax 임시
	 * @param param
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws NullPointerException
	 * @throws ArrayIndexOutOfBoundsException
	 * @throws Exception
	 */
	public Map getListABD_X (Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getListABD
		log.debug("==== getListABD_X Start ====");
		Map result_map = new HashMap();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();
		
		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		int i = 0;
		int j = 0;
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("mOpt"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		log.debug("getListABD_X:222222222222222222222222222222222222222:param:"+param);
		
		// 게시판 종류는 0000000008:공지형 , 0000000009:자유형 , 0000000010:답변형, 0000000011:갤러리형, 0000000025:통합형
		String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
		String BOARD_INT_M_CODES	= HtmlTag.returnString((String)MENUCFG.get("boardIntMCodes"),"");
		String BOARD_INT_TY			= HtmlTag.returnString((String)MENUCFG.get("boardIntTy"),"");
		
		String BOARD_LI_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItem"),"");
		String BOARD_LI_ITEM_NM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItemNm"),"");
		String BOARD_ETC_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardEtcItem"),"");
		String BOARD_ETC_ITEM_TY	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemTy"),"");
		String BOARD_ETC_ITEM_NM	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemNm"),"");
		String BOARD_OPT			= HtmlTag.returnString((String)MENUCFG.get("boardOpt"),"");
		String BOARD_ETC_ITEM_CODE	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemCode"),"");
		
		String [] BOARD_LI_ITEM_ARR		= HtmlText.split2(BOARD_LI_ITEM,"::");
		String [] BOARD_LI_ITEM_NM_ARR	= HtmlText.split2(BOARD_LI_ITEM_NM,"::");
		String [] BOARD_ETC_ITEM_ARR	= HtmlText.split2(BOARD_ETC_ITEM,"::");
		String [] BOARD_ETC_ITEM_TY_ARR	= HtmlText.split2(BOARD_ETC_ITEM_TY,"::");
		String [] BOARD_ETC_ITEM_NM_ARR	= HtmlText.split2(BOARD_ETC_ITEM_NM,"::");
		String [] BOARD_OPT_ARR			= HtmlText.split2(BOARD_OPT,"::");	
		String [] BOARD_ETC_ITEM_CODE_ARR	= HtmlText.split2(BOARD_ETC_ITEM_CODE,"::");
		//String [] BOARD_INT_M_CODES_ARR	= HtmlText.split2(BOARD_INT_M_CODES,"::");
		ArrayList<String> BOARD_INT_M_CODES_ARR = HtmlText.iterateQueryParam2(BOARD_INT_M_CODES,"::");
		
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		String se_field	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_field"),"") );
		String se_text	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_text"),"") );
		String se_code	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_code"),"") );
		String se_step	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_step"),"") );
		int curr_page		= Integer.parseInt(HtmlTag.returnString((String)param.get("curr_page"),"1"),10);		
		int show_rows		= 0;
		// 갤러리형일경우 20개씩 가져온다
		if(BOARD_TY.equals("000013")){
			show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"20"),10);
		}else{
			show_rows = Integer.parseInt(HtmlTag.returnString((String)param.get("show_rows"),"10"),10);
		}
		Map SITE_SESSION = new HashMap();
		Map SITE_ADM_SESSION = new HashMap();
		int admin_chk =0;
		String USER_ID = "";
		String USER_NAME = "";
		// 로그인이 필요한 게시판일경우

		    SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
		    SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));

		    
		    if(SITE_SESSION!=null){
		    	log.debug("getListABD:SITE_SESSION111:"+SITE_SESSION);
				   USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				   USER_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
				   admin_chk = 0;
		    
		    }else if(SITE_ADM_SESSION!=null){
		    	log.debug("getListABD:SITE_SESSION222:"+SITE_ADM_SESSION);
				   USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				   USER_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
				   admin_chk = 1;
		    }else{
		    	log.debug("getListABD:SITE_SESSION333:");
				   USER_ID		= "";
				   USER_NAME	= "";
		    	admin_chk =0;
		    }
		// 로그인이 필요없는 게시판일경우
		//}else{
		
		//}
		
		// 일정형의 경우 날짜 셋팅
    	String cyear = "";
    	String cmonth = "";
    	int startday = 0;		
		Calendar cal = Calendar.getInstance();
    	if(param.get("cyear") == null || param.get("cmonth") == null) {
    		cyear = String.valueOf(cal.get(Calendar.YEAR));
    		cmonth = ((cal.get(Calendar.MONTH)+1) > 9 ? 
    				String.valueOf(cal.get(Calendar.MONTH)+1) :
    			"0"+String.valueOf(cal.get(Calendar.MONTH)+1));
    	} else {
    		cyear = (String)param.get("cyear");
    		cmonth = (String)param.get("cmonth");
    		cal.set(Calendar.YEAR, Integer.parseInt(cyear));
    		cal.set(Calendar.MONTH, Integer.parseInt(cmonth.startsWith("0")?cmonth.substring(1):cmonth)-1);
    	}
		cal.set(Calendar.DATE, 1); //DAY_OF_WEEK 
		startday = cal.get(Calendar.DAY_OF_WEEK);	    
		
		String sql = "";
		Map query_param = new HashMap();		
		
		int totalPages = 0;
		int totalCount = 0;
		
		int firstRow =1;
		int endRow = 1; 
		Map tmp_page_map = new HashMap();
		
		try{
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			//result_map.put(propertiesService.getString("RESULT_URL_F_KEY") ,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			for(i=0;i<=9;i++){	
				//log.debug(i+"::"+BOARD_ETC_ITEM_ARR[i]);
				
				// 임시컬럼의 사용여부가 Y이면
				if(BOARD_ETC_ITEM_ARR[i].equals("Y")){
					// 임시컬럼의 데이터타입이 C(코드)이면
					if(BOARD_ETC_ITEM_TY_ARR[i].equals("C")){
						//log.debug(i+"::"+BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam = new HashMap();
						
						codeparam.put("all_fl", BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam.put("use_yn", "Y");
						codeparam.put("notinstr", "");
						codeparam.put("inout_fl", "");
						
						temp_code = cmDAO.getCode_Select(codeparam);	
						//log.debug(i+"::"+((List)temp_code.get("ListTreeACD")).size());
						//result_map.put("ListTreeETC"+i, temp_code.get("ListTreeACD"));			
					}
				}
			}
			
			
			sql = "JiCmAbd.getBOARD_Cnt";
			query_param.put("vmode", "");
			query_param.put("BOARD_TY", BOARD_TY);
			query_param.put("BOARD_INT_M_CODES_ARR", BOARD_INT_M_CODES_ARR);
			query_param.put("pcode", pcode);
			query_param.put("BOARD_INT_TY", BOARD_INT_TY);
			query_param.put("scode", scode);
			query_param.put("USER_ID", USER_ID);
			query_param.put("curr_page", curr_page+"");
			query_param.put("mylist_yn", HtmlTag.returnString((String)param.get("mylist_yn"),"N"));

			
			// 일정형인경우 달력이므로 해당 월의 모든 데이터를 가져오도록 셋팅
			if(BOARD_TY.equals("000051")){
				query_param.put("show_rows", "1000");
			}else{
				query_param.put("show_rows", show_rows+"");
			}
			
			query_param.put("cyymm", cyear+cmonth);
			
			// 관리자화면이 아닐경우 미게시외의 자료만 가져온다
			if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
				query_param.put("scodeadm", "N");
			}else{
				query_param.put("scodeadm", "Y");
			}
			
						
			query_param.put("se_field", se_field);
			query_param.put("se_text", se_text);
			query_param.put("se_code", se_code);
			query_param.put("se_step", se_step);
			
			
			result_map = cmDAO.selectListGrid(query_param, "JiCmAbd.getBOARD");
			//list("JiCmAbd.getBOARD", query_param);
			
			log.debug("===================== result_map=====================");
			
		}catch(JSysException q){
			log.debug("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.debug("SQLException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
		log.debug("==== getListABD Ajax End ====");
		return result_map;
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 게시판등록관련 목록을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  게시판관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getABD_CF (Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getABD_CF
		log.debug("==== getABD_CF Start ====");

		Map result_map = new HashMap();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();
		
		
		String sql = "";
		Map query_param = new HashMap();	
		List res = null;
		try{
			
			// 사용자 등록화면
			Map SITE_AUTH_SESSION = (Map)param.get(propertiesService.getString("SITE_AUTH_SESSION_FN"));
			Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
			if(HtmlTag.returnString((String)param.get("scode"),"").equals("sysadm")){
				SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
			}
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
			
			// 이메일코드 리스트를 가져온다
			codeparam = new HashMap();
			codeparam.put("all_fl", "000012");
			codeparam.put("use_yn", "Y");
			codeparam.put("notinstr", "");
			codeparam.put("inout_fl", "");

			temp_code = cmDAO.getCode_Select (codeparam);	
			result_map.put("ListTree0000000012", temp_code.get("ListTreeACD"));
			
			// 게시판의 임시컬럼이 사용인 컬럼중 코드타입 데이터인경우 해당 코드를 가져온다
			Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
			// 게시판 종류는 0000000008:공지형 , 0000000009:자유형 , 0000000010:답변형, 0000000011:갤러리형
			String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
			String BOARD_INT_M_CODES	= HtmlTag.returnString((String)MENUCFG.get("boardIntMCodes"),"");
			String BOARD_INT_TY			= HtmlTag.returnString((String)MENUCFG.get("boardIntTy"),"");
			
			String BOARD_LI_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItem"),"");
			String BOARD_LI_ITEM_NM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItemNm"),"");
			String BOARD_ETC_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardEtcItem"),"");
			String BOARD_ETC_ITEM_TY	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemTy"),"");
			String BOARD_ETC_ITEM_NM	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemNm"),"");
			String BOARD_OPT			= HtmlTag.returnString((String)MENUCFG.get("boardOpt"),"");
			String BOARD_ETC_ITEM_CODE	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemCode"),"");
			
			
			String [] BOARD_LI_ITEM_ARR		= HtmlText.split2(BOARD_LI_ITEM,"::");
			String [] BOARD_LI_ITEM_NM_ARR	= HtmlText.split2(BOARD_LI_ITEM_NM,"::");
			String [] BOARD_ETC_ITEM_ARR	= HtmlText.split2(BOARD_ETC_ITEM,"::");
			String [] BOARD_ETC_ITEM_TY_ARR	= HtmlText.split2(BOARD_ETC_ITEM_TY,"::");
			String [] BOARD_ETC_ITEM_NM_ARR	= HtmlText.split2(BOARD_ETC_ITEM_NM,"::");
			String [] BOARD_OPT_ARR			= HtmlText.split2(BOARD_OPT,"::");	
			String [] BOARD_ETC_ITEM_CODE_ARR	= HtmlText.split2(BOARD_ETC_ITEM_CODE,"::");	
			
			for(int i=0;i<=9;i++){	
				// 임시컬럼의 사용여부가 Y이면
				if(BOARD_ETC_ITEM_ARR[i].equals("Y")){
					// 임시컬럼의 데이터타입이 C(코드)이면
					if(BOARD_ETC_ITEM_TY_ARR[i].equals("C")){
						codeparam = new HashMap();
						codeparam.put("all_fl", BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam.put("use_yn", "Y");
						codeparam.put("notinstr", "");
						codeparam.put("inout_fl", "");

						temp_code = cmDAO.getCode_Select (codeparam);	
						result_map.put("ListTreeETC"+i, temp_code.get("ListTreeACD"));			
					}
				}
			}
			result_map.put("TRS_MSG","");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");		
		}catch(Exception q){
			log.debug("Exception:");
			result_map.put("TRS_MSG","조회중 에러가 발생했습니다");
		
		}
		

    	
    	log.debug("==== getABD_CF End ====");
		return result_map;
	}
	
	/**
	 * @throws Exception 
	 * @throws IOException 
	 * @throws SQLException 
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException
	* @throws
	*/
	public Map insertABD(Map param) throws Exception{
		//	TODO insertABD
		log.debug("==== insertABD : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();
		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};
		
		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		List save_file_list = new ArrayList();
		Param Param_Obj = new Param();
		int i = 0;
		int j = 0;
		log.debug("==== insertABD : 11111111111 ====");
		String B_FILES		= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_FILES"),""));// 파일객체명들
		
		String[] file_obj = null;
		String[] B_FILES_ARR = null;
		log.debug("==== insertABD : 22222222222 ====");
		if(!B_FILES.equals("")){
			log.debug("==== insertABD : 2-1 ====");
			B_FILES_ARR = B_FILES.split("::");
			log.debug("==== insertABD : 2-2 ==B_FILES_ARR.length=="+B_FILES_ARR.length);
			
			if(B_FILES_ARR!=null){
				j= 0;
				for(i=0;i<B_FILES_ARR.length;i++){
					if(B_FILES_ARR[i]!=null){
						if(!B_FILES_ARR[i].equals("")){
							j++;
						}
					}
				}
				log.debug("==== insertABD : 2-2 ==file_obj=="+j);
				file_obj = new String[j];
				j= 0;
				for(i=0;i<B_FILES_ARR.length;i++){
				log.debug("==== insertABD : 2-4 ==i="+i);
					if(B_FILES_ARR[i]!=null){
						log.debug("==== insertABD : 2-5 ====");
						if(!B_FILES_ARR[i].equals("")){
							log.debug("==== insertABD : 2-6 ===="+B_FILES_ARR[i]);
							file_obj[j] = B_FILES_ARR[i];
							j++;
						}
					}
				}
			}
		}

		log.debug("==== insertABD : 33333333333 ====");
		//log.debug(message)
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		List file_arr	= (List)param.get("FILE_ARR");// 업로드 파일정보

		String B_TITLE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_TITLE"),""));// 제목
		String REG_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME"),""));//작성자
		String REG_DT   = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_DT"),""));	//등록일
		String REG_MAIL = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_MAIL"),""));//이메일
		
		String GESI_FL 	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("GESI_FL"),"Y"));//게시구분
		String B_CONTENTS = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_CONTENTS"),""));//내용
		String PASSWD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("PASSWD"),""));//비밀번호
		String DATA_IPNS	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("DATA_IPNS"),""));//비밀번호

		String B_SDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_SDATE"),""));//게시물 기간시작일
		String B_EDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_EDATE"),""));//게시물 기간종료일
		String REG_TEL	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_TEL"),""));//게시물등록자 전화
		String REG_HAND	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_HAND"),""));//게시물등록자 핸드폰
		String REG_IP	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_IP"),""));//게시물등록자 아이피
		String REG_PHOTO_ALT	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_PHOTO_ALT"),""));//게시판종류가 갤러리일경우 대표이미지ALT
		String REG_SVNUMBER	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_SVNUMBER"),""));//게시물등록자 아이핀
		String [] B_ETC_ARR = new String[10];//게시물 임시컬럼 배열
		int [] B_ETC_ARR_IDX = new int[10];//게시물 임시컬럼 배열
		for(i=0;i<B_ETC_ARR.length;i++){
			B_ETC_ARR[i] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_ETC"+i),""));//게시물 임시컬럼
			B_ETC_ARR_IDX[i] = i;
		}
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
		String BOARD_TY	= HtmlTag.returnString((String)MENUCFG.get("boardTy"),""); //게시판타입 0000000010:답변형
		String MENU_NM = HtmlTag.returnString((String)MENUCFG.get("menuNm"),""); //메뉴명
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
		Map SITE_AUTH_SESSION = (Map)param.get(propertiesService.getString("SITE_AUTH_SESSION_FN"));
		
		

	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    


	    log.debug("==== insertABD : 444444444444444 ====");
		
		long max_seq = 0;

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JIT9150","IDX","");
		
		long r_idx= max_seq;
	    int r_depth=1;
	    int r_order=1;

		//DEPTH_NO = Integer.parseInt(se_lv) + 1;
		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		List rtn_list = new ArrayList();
		try{
			
		    // 관리자프로그램접속인경우
		    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){

		    	if(SITE_ADM_SESSION!= null){
					USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
					USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
					param.put("AUTH_TYPE", "ALOGIN");
					admin_chk =1;
		    	}

		    // 일반사이트프로그램접속인경우
		    }else{
			    
		    	if(SITE_SESSION!= null){
					USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
					USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
			    	admin_chk =0;
		    	}

			
				// 사용자 등록화면
				// 로그인을 한경우
				if(SITE_SESSION!= null){
					log.debug("session chk 1======================");
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
				    		//param.put("SITE_AUTH_SESSION", SITE_AUTH_SESSION);
						
						}
			    	}
			    }
								
				// 본인인증 종류
				// 회원가입 로그인시
				if(!USER_ID.equals("")){
					if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
						param.put("AUTH_TYPE", "ALOGIN");
					}else{
						param.put("AUTH_TYPE", "LOGIN");
					}
					
				}else{
					// 본인 인증시
					if(!HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),"").equals("")){
						param.put("AUTH_TYPE", HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sAuthType"),""));
						USER_ID			= "";
						USER_NAME		= HtmlTag.returnString((String)SITE_AUTH_SESSION.get("sName"),"");

						if(!REG_NAME.equals(USER_NAME)){
							REG_NAME = USER_NAME;
						}
						
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
				
			    if(REG_NAME.equals("")){
			    	REG_NAME	= USER_NAME;
			    }
		    }
		    
		    if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
		    	/*log.debug("SITE_SESSION::::::::::::::"+SITE_SESSION.get("USER_NM"));
		    	if(!HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),"").equals(REG_NAME)){
					REG_NAME = USER_NAME;
				}*/
				Map pkMap = new HashMap();
				pkMap = getSelectByPkNoEgov("JiCmAbd.getBOARD_S4", param);
				if(pkMap.get("stdinfo_dtl_cd").equals("000010")){
					throw new JSysException(super.getMessage("ji.cm.common.msg.error.notauth"));
				}
			}

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 해당게시판이 공지형이고 현재 등록하는 게시물의 게시구분이 공지글인경우 공지글수를 제한한다
			if(GESI_FL.equals("T")){
				sql = "JiCmAbd.getBOARD_Gongji";
				query_param = new HashMap();

				query_param.put("pcode", pcode);
				
				rtn_list = list(sql, query_param);

				if(rtn_list.size() > 2){
					log.debug("현재 게시판에 공지글은 3개로 제한되어있습니다.:p_code:"+pcode+"");
					result_map.put("TRS_MSG","현재 게시판에 공지글은 3개로 제한되어있습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;	
				}
			}
			
			sql = "JiCmAbd.insertBOARD";
			query_param = new HashMap();
			//sequence 추출
			//int JIT9150_SQ = cmDAO.getSequence("JIT9150_DATA_SEQNO");
			query_param.put("data_seqno", max_seq);
			query_param.put("B_SDATE", B_SDATE);
			query_param.put("B_EDATE", B_EDATE);
			
			for(i=0;i<B_ETC_ARR.length;i++){
				query_param.put("B_ETC"+i, B_ETC_ARR[i]);

			}			
			query_param.put("B_ETC_ARR_IDX", B_ETC_ARR_IDX);
			query_param.put("B_ETC_ARR", B_ETC_ARR);
			
			query_param.put("max_seq", max_seq);
			query_param.put("pcode", pcode);
			
			query_param.put("REG_DT", REG_DT);
			
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("B_CONTENTS", B_CONTENTS);
			query_param.put("r_idx", max_seq);
			query_param.put("r_depth", r_depth);
			query_param.put("r_order", r_order);
			query_param.put("PASSWD", PASSWD);

			query_param.put("GESI_FL", GESI_FL);
			query_param.put("REG_NAME", (REG_NAME.equals("")? USER_NAME:REG_NAME));
			query_param.put("REG_MAIL", REG_MAIL);

			query_param.put("REG_TEL", REG_TEL);
			query_param.put("REG_HAND", REG_HAND);
			query_param.put("REG_IP", REG_IP);
			query_param.put("REG_PHOTO_ALT", REG_PHOTO_ALT);
			query_param.put("REG_SVNUMBER", REG_SVNUMBER);
			
			query_param.put("IPIN_NO", HtmlTag.returnString((String)param.get("IPIN_NO"),""));
			query_param.put("DUPL_INFO", HtmlTag.returnString((String)param.get("DUPL_INFO"),""));
			query_param.put("AUTH_TYPE", HtmlTag.returnString((String)param.get("AUTH_TYPE"),""));
			
			if(BOARD_TY.equals("000417") || BOARD_TY.equals("000012")){
				query_param.put("DATA_IPNS", DATA_IPNS);
			}else{
				query_param.put("DATA_IPNS", "");
			}
			
/*			param.put("RMAXIDX", Long.toString(max_seq));
			param.put("FILE_OBJ_NM", file_obj);
			//log.debug("==== insertABD : 6666666666666666 ====");
			// 첨부파일정보를 데이터 베이스에 저장한다
			temp_file = cmDAO.InsertFile(param);
			// 파일저장중에러가 발생하면
			if(!"".equals((String)temp_file.get("TRS_MSG"))){
				log.debug("insertABD : :"+temp_file.get("TRS_MSG"));
				result_map.put("TRS_MSG",temp_file.get("TRS_MSG"));
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
				//throw new JSysException("CM_Dao InsertFile 등록중 에러가 발생했습니다");
			}*/
			insert(sql, query_param);
			param.put("imenu_data_title", HtmlTag.StripStrInXss(HtmlTag.returnString(B_TITLE,"")));
			param.put("ikey_datas", Long.toString(max_seq));
			
			temp_file = cmMtmDAO01.InsertFile(param);	
			
			log.debug("==== insertABD : 777777777777777777 ====");

			
			//답변형 게시판에 글이 등록될경우 담당자에게 메일을 발송한다
			if(BOARD_TY.equals("000012")){
				log.debug("===== insertABD 이메일발송 시작 =====");
				
				Map param_email = new HashMap();
				String subject = "Q&A게시판에 글이 등록되었습니다.";
				String mailfrom = "admin@komipo.co.kr";
				String mailto = "snisys@snisystem.co.kr";
				String mailto_nm = "관리자님";	
				String gubun = propertiesService.getString("SYSTEM_NAME");
				String rname = "관리자";
				String content = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>";
				content = content+"<html xmlns='http://www.w3.org/1999/xhtml'>";
				content = content+"<head>";
				content = content+"	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />";
				content = content+"	<title>전력데이터 개방 포털시스템</title>";
				content = content+"</head>";
				content = content+"<body>";
				content = content+"<div style='width:720px; padding:0; margin:0; font-family:Nanum Gothic; color:#333; border-left:1px solid #e0e0e0; border-right:1px solid #e0e0e0;'>";
				content = content+"		<div style='background:url(http://le48.kepco.co.kr:10100/images/header_bg.jpg) no-repeat; width:100%; height:222px; padding:0; margin:0;'>";
				content = content+"			<p style='padding:0; margin:0;font-size:12px; padding-top:30px; padding-right:35px;'></p>";
				content = content+"			<h2 style='padding:0; margin:0; color:#333; font-size:26px; padding-top:60px; padding-left:30px; line-height:34px; font-weight:bold;'>";
				content = content+"			Q&A게시판에 글이 등록되었습니다</h2>";
				content = content+"		</div>";
				content = content+"		<div style='text-align:left; padding-left:30px; width:100%; margin-top:30px; font-size:14px; line-height:22px;'>";
				content = content+"			확인해 주시기 바랍니다.";
				content = content+"		</div>";
				content = content+"		<div style='background:#e0e0e0; color:#666; width:100%; padding:30px 0; margin:0; margin-top:50px; text-align:center;'>";
				content = content+"			<p style='padding:0; margin:0; font-size:12px; line-height:20px;'>COPYRIGHTⓒ2018 한국전력공사 전력데이터 개방 포털시스템. ALL RIGHTS RESERVED.</p>";
				content = content+"		</div>";
				content = content+"</div>";
				content = content+"</body>";
				content = content+"</html>";
				
				param_email.put("subject", subject);							//제목
				param_email.put("mailfrom", "\""+gubun+"\"<"+mailfrom+">");		//발송자이메일
				param_email.put("mailto", "\""+mailto_nm+"\"<"+mailto+">");		//수신자이메일
				param_email.put("sql", "SSV:"+mailto);							//*** 실제발송되는 이메일***
				param_email.put("gubun", gubun);								//발송시스템명
				param_email.put("rname", rname);								//담당자명
				param_email.put("content", content);							//내용
				//sendEmail.start(param_email);
				
				log.debug("===== insertABD 이메일발송 끝 =====");
				
			}
			
			//답변형 게시판에 글이 등록될경우 담당자에게 SMS를 발송한다
			if(BOARD_TY.equals("000012")){
				log.debug("===== insertABD SMS발송 시작 =====");
				
				Map param_sms = new HashMap();
				String tran_phone = "01073210910";
				String tran_msg = "Q&A게시판에 글이 등록되었습니다.";
				String tran_etc1 = "전력데이터제공포털";
				String tran_etc2 = "관리자";
				String tran_etc3 = "02-6445-5367";
				
				param_sms.put("tran_phone", tran_phone);	//수신번호(숫자만)
				param_sms.put("tran_callback", tran_etc3);	//발송번호
				param_sms.put("tran_msg", tran_msg);		//내용
				param_sms.put("tran_etc1", tran_etc1);		//발송시스템명
				param_sms.put("tran_etc2", tran_etc2);		//담당자명
				param_sms.put("tran_etc3", tran_etc3.replaceAll("-", ""));		//담당자연락처(숫자만)
				//sendSms.start(param_sms);
				
				log.debug("===== insertABD SMS발송 끝 =====");
				
			}
			
			log.debug("==== insertABD : 8888888888888888888 ====");
			
			result_map.put("TRS_MSG","등록되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");

		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		
				

		}catch(NullPointerException q){
			log.debug("NullPointerException: ");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> : ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}

		log.debug("==== insertABD : END ====");
		return result_map;	
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 게시판관리관련 상세내용을 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  게시판관리관련 조회결과값을 리턴한다
	* @throws  
	*/
	public Map getABD (Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getABD
		log.debug("==== getABD Start ====");

		Map result_map = new HashMap();
		Map tmp_map = new HashMap();
		List res_list = new ArrayList();
		Map codeparam = new HashMap();
		Map temp_code = new HashMap();		
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		//log.debug("11111111111111111111111");
		String sidx	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0") );
		//log.debug("2222222222222");
		String se_field	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_field"),"") );
		//log.debug("333333");
		String se_text	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_text"),"") );
		//log.debug("444");
		String se_code	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("se_code"),"") );
		//log.debug("555");
		//log.debug("666");
		//log.debug("777");
		String curr_page = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("curr_page"),"") );
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		log.debug("MENUCFG::"+MENUCFG);
		// 게시판 종류는 0000000008:공지형 , 0000000009:자유형 , 0000000010:답변형, 0000000011:갤러리형, 0000000025:통합형
		String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
		String BOARD_INT_M_CODES	= HtmlTag.returnString((String)MENUCFG.get("boardIntMCodes"),"");
		String BOARD_INT_TY			= HtmlTag.returnString((String)MENUCFG.get("boardIntTy"),"");
		
		String BOARD_LI_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItem"),"");
		String BOARD_LI_ITEM_NM		= HtmlTag.returnString((String)MENUCFG.get("boardLiItemNm"),"");
		String BOARD_ETC_ITEM		= HtmlTag.returnString((String)MENUCFG.get("boardEtcItem"),"");
		String BOARD_ETC_ITEM_TY	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemTy"),"");
		String BOARD_ETC_ITEM_NM	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemNm"),"");
		String BOARD_OPT			= HtmlTag.returnString((String)MENUCFG.get("boardOpt"),"");
		String BOARD_ETC_ITEM_CODE	= HtmlTag.returnString((String)MENUCFG.get("boardEtcItemCode"),"");
		
		String [] BOARD_LI_ITEM_ARR		= HtmlText.split2(BOARD_LI_ITEM,"::");
		String [] BOARD_LI_ITEM_NM_ARR	= HtmlText.split2(BOARD_LI_ITEM_NM,"::");
		String [] BOARD_ETC_ITEM_ARR	= HtmlText.split2(BOARD_ETC_ITEM,"::");
		String [] BOARD_ETC_ITEM_TY_ARR	= HtmlText.split2(BOARD_ETC_ITEM_TY,"::");
		String [] BOARD_ETC_ITEM_NM_ARR	= HtmlText.split2(BOARD_ETC_ITEM_NM,"::");
		String [] BOARD_OPT_ARR			= HtmlText.split2(BOARD_OPT,"::");	
		String [] BOARD_ETC_ITEM_CODE_ARR	= HtmlText.split2(BOARD_ETC_ITEM_CODE,"::");
		//String [] BOARD_INT_M_CODES_ARR	= HtmlText.split2(BOARD_INT_M_CODES,"::");
		ArrayList<String> BOARD_INT_M_CODES_ARR = HtmlText.iterateQueryParam2(BOARD_INT_M_CODES,"::");
		

		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
				USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
				admin_chk =1;
	    	}
				
	    // 일반사이트프로그램접속인경우
	    }else{
	    	if(SITE_SESSION!= null){
				USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));		    	
		    	admin_chk =0;	  
	    	}
	    }
	    
		String sql = "";
		Map query_param = new HashMap();
		List rtn_list = new ArrayList();
		
		try{
			if(!HtmlTag.returnString((String)param.get("rpidx"),"").equals("")){
				sidx = HtmlTag.returnString((String)param.get("rpidx"),"");
			}
			
			// 사용자 화면인경우이고 자유형, 답변형 게시판이 아닌경우 무조건 접근을 막는다
			if(!scode.equals("sysadm") && (!BOARD_TY.equals("000417") && !BOARD_TY.equals("000012")) && !pstate.equals("R")){
				// 지원사업공고 게시판은 지원사업참여일경우 로그인되어있으면 통과 시킨다
				if(BOARD_TY.equals("000223") && !USER_ID.equals("")){
					
				}else{
					throw new JSysException("접근권한이 없습니다!!");
				}
				
			}			
			
			// 선택된 게시물 정보를 불러온다
			sql = "JiCmAbd.getBOARD_S2";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("scode", scode);
			query_param.put("pstate", HtmlTag.returnString((String)param.get("pstate"),""));
			query_param.put("sidx", sidx);
			query_param.put("USER_ID", USER_ID);
			query_param.put("BOARD_TY", BOARD_TY);
			query_param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("ichk_secret_no"),""));		

			
			res_list = list(sql, query_param);
			
			if(res_list.size() < 1){
				//log.debug("getABDNe2=====================================================");
				log.debug("게시물정보를 가져오지 못했습니다!!");
				throw new JSysException("게시물정보를 가져오지 못했습니다!!");
			}else if(res_list.size() > 1){
				log.debug("정확한 게시물정보를 가져오지 못했습니다!!");
				throw new JSysException("정확한 게시물정보를 가져오지 못했습니다!!");				
			}else{
				log.debug("getABD1:"+res_list.get(0));
				tmp_map = (Map)res_list.get(0);
				result_map.put("getABD",tmp_map);
				log.debug("getABD2:"+tmp_map);
				//String file_seqno = CM_Util.nullToEmpty((String)tmp_map.get("FILE_GROUP_SEQ"));
				//String file_nm = CM_Util.nullToEmpty((String)tmp_map.get("FILE_GROUP_NM"));
				String file_seqno = CM_Util.nullToEmpty((String)tmp_map.get("FILE_SEQ"));
				String file_nm = CM_Util.nullToEmpty((String)tmp_map.get("FILE_NMS"));
				result_map.put("file_group_htmlarray", cmMtmDAO01.getFileHtmlArray(file_seqno, file_nm));	
				
				file_seqno = CM_Util.nullToEmpty((String)tmp_map.get("FILE_GROUP_SEQ"));
				file_nm = CM_Util.nullToEmpty((String)tmp_map.get("FILE_GROUP_NM"));				
				result_map.put("file_group_htmlarray2", cmMtmDAO01.getFileHtmlArray(file_seqno, file_nm));

				// 상세조회가 아닐경우 권한을 체크한다
				if(!pstate.equals("R")){
					// 게시판 관리자가 아닐경우 등록자 아이디를 비교한다
					if("N".equals((String)param.get("AdmSubAuthYn"))){
						if(!USER_ID.equals(HtmlTag.returnString((String)tmp_map.get("REG_ID"),""))){
							log.debug("비정상적인 접근입니다!!"+"::USER_ID:"+USER_ID+"::RegId:"+tmp_map);
							//result_map.put("TRS_MSG","권한이 없습니다!!");
							throw new JSysException("권한이 없습니다!!");
						}
					}	
				}				
			}
			
			// 이메일코드 리스트를 가져온다
			codeparam = new HashMap();
			codeparam.put("all_fl", "M00004");
			codeparam.put("use_yn", "Y");
			codeparam.put("notinstr", "");
			codeparam.put("inout_fl", "");

			temp_code = cmDAO.getCode_Select (codeparam);	
			result_map.put("ListTree0000000012", temp_code.get("ListTreeACD"));
			
	
			for(int i=0;i<=9;i++){	
				// 임시컬럼의 사용여부가 Y이면
				if(BOARD_ETC_ITEM_ARR[i].equals("Y")){
					// 임시컬럼의 데이터타입이 C(코드)이면
					if(BOARD_ETC_ITEM_TY_ARR[i].equals("C")){
						codeparam = new HashMap();
						codeparam.put("all_fl", BOARD_ETC_ITEM_CODE_ARR[i]);
						codeparam.put("use_yn", "Y");
						codeparam.put("notinstr", "");
						codeparam.put("inout_fl", "");

						temp_code = cmDAO.getCode_Select (codeparam);	
						result_map.put("ListTreeETC"+i, temp_code.get("ListTreeACD"));			
					}
				}
			}			
			
			// 상세조회화면 호출일경우 댓글 목록을 가져온다 조회수를 증가시킨다
			if(pstate.equals("R")){
				// 조회수 증가
				sql = "JiCmAbd.updateBOARD_Read_Cnt";
				query_param = new HashMap();
				// 회원사 공지사항인경우 사용자 공지사항으로 데이터 통합을 한다
				if(pcode.equals("000142")){
					query_param.put("pcode", "000115");
				}else{
					query_param.put("pcode", pcode);
				}
				query_param.put("sidx", sidx);
				
				update(sql, query_param);
				log.debug("updateBOARD_Read_Cnt==> END");
				// 댓글 목록
				sql = "JiCmAbd.getBOARDRR";
				query_param = new HashMap();
				// 회원사 공지사항인경우 사용자 공지사항으로 데이터 통합을 한다
				if(pcode.equals("000142")){
					query_param.put("pcode", "000115");
				}else{
					query_param.put("pcode", pcode);
				}
				query_param.put("sidx", sidx);
				
				rtn_list = list(sql, query_param);

				result_map.put("getABDRR",rtn_list);
				log.debug("getBOARDRR==> END");
				int rn_int  = 0;
				// 이전글 다음글을 불러온다
				//오라클, TIBERO의 경우 현재글의 ROWNUM을 가져온다
				if(propertiesService.getString("CMS_DB_TYPE").equals("ORACLE")
						|| propertiesService.getString("CMS_DB_TYPE").equals("TIBERO")){
					
					sql = "JiCmAbd.getBOARD_RN";
					query_param = new HashMap();
					query_param.put("vmode", "");
					query_param.put("BOARD_TY", BOARD_TY);
					query_param.put("BOARD_INT_M_CODES_ARR", BOARD_INT_M_CODES_ARR);
					
					//log.debug("=======================================================================");
					//log.debug("=============pcode========================================================="+pcode);
					//log.debug("=======================================================================");
					query_param.put("pcode", pcode);
					query_param.put("BOARD_INT_TY", BOARD_INT_TY);
					query_param.put("scode", scode);
					query_param.put("USER_ID", USER_ID);
					// 관리자화면이 아닐경우 미게시외의 자료만 가져온다
					if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
						query_param.put("scodeadm", "N");
					}else{
						query_param.put("scodeadm", "Y");
					}
					
					query_param.put("se_field", se_field);
					query_param.put("se_text", se_text);
					query_param.put("sidx", sidx);
					query_param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("ichk_secret_no"),""));
					
					rtn_list = list(sql, query_param);
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
							result_map.put("getABDNe",tmp_map);
							result_map.put("getABDPr",tmp_map);
						
					}					
				//MSSQL
				}else if(propertiesService.getString("CMS_DB_TYPE").equals("MSSQL")){
					// 다음글
					sql = "JiCmAbd.getBOARD_NEXT";
					query_param = new HashMap();
					query_param.put("vmode", "");
					query_param.put("BOARD_TY", BOARD_TY);
					query_param.put("BOARD_INT_M_CODES_ARR", BOARD_INT_M_CODES_ARR);
					query_param.put("pcode", pcode);
					query_param.put("BOARD_INT_TY", BOARD_INT_TY);
					query_param.put("scode", scode);
					// 관리자화면이 아닐경우 미게시외의 자료만 가져온다
					if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
						query_param.put("scodeadm", "N");
					}else{
						query_param.put("scodeadm", "Y");
					}
					
					query_param.put("se_field", se_field);
					query_param.put("se_text", se_text);
					query_param.put("sidx", sidx);
					query_param.put("MODES", "N");
					rtn_list = list(sql, query_param);

					//log.debug("getABDNe3=====================================================");
					if(rtn_list.size() < 1){
						result_map.put("getABDNe",null);
						//log.debug("getABDNe4=====================================================");
					}else{
						result_map.put("getABDNe",(Map)rtn_list.get(0));
						//log.debug("getABDNe5=====================================================");
					}				
					
			
					// 이전글
					sql = "JiCmAbd.getBOARD_NEXT";
					query_param = new HashMap();
					query_param.put("vmode", "");
					query_param.put("BOARD_TY", BOARD_TY);
					query_param.put("BOARD_INT_M_CODES_ARR", BOARD_INT_M_CODES_ARR);
					query_param.put("pcode", pcode);
					query_param.put("BOARD_INT_TY", BOARD_INT_TY);
					query_param.put("scode", scode);
					// 관리자화면이 아닐경우 미게시외의 자료만 가져온다
					if(!scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
						query_param.put("scodeadm", "N");
					}else{
						query_param.put("scodeadm", "Y");
					}
					
					query_param.put("se_field", se_field);
					query_param.put("se_text", se_text);
					query_param.put("sidx", sidx);
					query_param.put("MODES", "P");
					rtn_list = list(sql, query_param);

					//log.debug("getABDNe3=====================================================");
					if(rtn_list.size() < 1){
						result_map.put("getABDPr",null);
						//log.debug("getABDNe4=====================================================");
					}else{
						result_map.put("getABDPr",(Map)rtn_list.get(0));
						//log.debug("getABDNe5=====================================================");
					}					
				}
				
			}
			

			
			// 게시물의 답글이 있을경우 답글 정보를 불러온다
			// 게시판종류가 답변형일경우 BOARD_TY=000012:답변형 답변이 되는 게시물은 제외하고 가져온다
			if(BOARD_TY.equals("000012")){
				
				sql = "JiCmAbd.getBOARD_R";
				query_param = new HashMap();
				query_param.put("pcode", pcode);
				query_param.put("sidx", sidx);

				res_list = list(sql, query_param);

				if(res_list.size() < 1){
					result_map.put("getABDRE",null);
				}else{
					tmp_map = (Map)res_list.get(0);
					result_map.put("getABDRE",tmp_map);
				}
				
				// 답변글의 첨부파일정보를 불러온다
				if(res_list.size() > 0){
					sql = "JiCmMtm.getdeleteJRCMS_FILE_MGR_ALL";
					query_param = new HashMap();
					//log.debug("getBOARD_R:==>"+tmp_map);
					query_param.put("pcode", pcode);
					query_param.put("sidx", (tmp_map.get("DATA_SEQNO")!=null?String.valueOf(tmp_map.get("DATA_SEQNO")):"0"));

					res_list = list(sql, query_param);
					result_map.put("getABDREFiles",res_list);					
				}
			}			
			
			//페이지 정보
			result_map.put("curr_page", curr_page);
			log.debug("=================================curr_page====================================="+curr_page);
			
			
			// 게시물의 첨부파일정보를 불러온다
			sql = "JiCmMtm.getdeleteJRCMS_FILE_MGR_ALL";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sidx", sidx);
			res_list = list(sql, query_param);

			result_map.put("getABDFiles",res_list);
			result_map.put("TRS_MSG","");

		}catch(JSysException q){	
			log.debug("getABD throw JSysException >>>>> : "+q);	
			throw q;		
		}catch(NullPointerException q){
			log.debug("getABD NullPointerException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("getABD ctlCMS ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(SQLException q){
			log.debug("getABD SQLException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다		
		}catch(Exception q){
			log.debug("getABD Exception >>>>> : "+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}


    	log.debug("==== getABD End ====");
		return result_map;
	}	
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 수정하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  수정 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map updateABD(Map param) throws Exception{
		//	TODO updateABD 
		log.debug("==== updateABD : START ====");

		Map result_map = new HashMap();
		Map temp_file = new HashMap();
		Map tmp_map = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		List save_file_list = new ArrayList();
		Param Param_Obj = new Param();
		int i = 0;
		int j = 0;
		//log.debug("==== insertABD : 11111111111 ====");
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String sseq  = HtmlTag.returnString((String)param.get("sseq"),"0");
		String pcode  = HtmlTag.returnString((String)param.get("pcode"),"");	
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		
		String B_FILES_DEL  = HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_FILES_DEL"),""));// 삭제할파일인덱스
		
		String[] file_obj = null;
		String[] B_FILES_ARR = null;
		String[] B_FILES_DEL_ARR = null;
		if(!B_FILES_DEL.equals("")){
			B_FILES_DEL_ARR = B_FILES_DEL.split("::");
		}


		List file_arr	= (List)param.get("FILE_ARR");// 업로드 파일정보
		/*for(i=0;i<file_arr.size();i++){
			log.debug("file_arr================================"+((Map)file_arr.get(i)).get("fileformName"));
			log.debug("file_arr================================"+((Map)file_arr.get(i)).get("fileName"));
		}*/

		String B_TITLE			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_TITLE"),""));// 제목
		String REG_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME"),""));//작성자
		String REG_DT    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_DT"),""));//등록일
		String REG_MAIL1  = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_MAIL1"),""));//이메일1
		String REG_MAIL2    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_MAIL2"),""));//이메일2
		
		String GESI_FL = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("GESI_FL"),"Y"));//게시구분


		String B_CONTENTS = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_CONTENTS"),""));//내용

		String PASSWD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("PASSWD"),""));//비밀번호
		String DATA_IPNS	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("DATA_IPNS"),""));//비밀번호

		String B_SDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_SDATE"),""));//게시물 기간시작일
		String B_EDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_EDATE"),""));//게시물 기간종료일
		String REG_TEL	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_TEL"),""));//게시물등록자 전화
		String REG_HAND	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_HAND"),""));//게시물등록자 핸드폰
		String REG_IP	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_IP"),""));//게시물등록자 아이피
		String REG_PHOTO_ALT	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_PHOTO_ALT"),""));//게시판종류가 갤러리일경우 대표이미지ALT
		String REG_SVNUMBER	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_SVNUMBER"),""));//게시물등록자 아이핀
		String [] B_ETC_ARR = new String[10];//게시물 임시컬럼 배열
		int [] B_ETC_ARR_IDX = new int[10];//게시물 임시컬럼 배열
		for(i=0;i<B_ETC_ARR.length;i++){
			B_ETC_ARR[i] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_ETC"+i),""));//게시물 임시컬럼
			B_ETC_ARR_IDX[i] = i;
		}
		log.debug("2====================================================================");
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		log.debug("222===================================================================="+MENUCFG);
		String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
		//String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		//String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    int admin_chk =0;
	    String USER_ID	 = "";
	    String USER_NAME = "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    	
	    // 일반사이트프로그램접속인경우
	    }else{
	    	if(SITE_SESSION!= null){
		    	SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
				USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
		    	admin_chk =0;
	    	}

	    }

	    if(REG_NAME.equals("")){
	    	REG_NAME	= USER_NAME;
	    }
		
	    log.debug("3====================================================================");

		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		List rtn_list = new ArrayList();
		
		
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 사용자 화면인경우이고 자유형, 답변형 게시판이 아닌경우 무조건 접근을 막는다
			if(!scode.equals("sysadm") && (!BOARD_TY.equals("000417") && !BOARD_TY.equals("000012") && !BOARD_TY.equals("000223"))){
				throw new JSysException("접근권한이 없습니다!!");
			}

			// 해당게시판이 공지형이고 현재 등록하는 게시물의 게시구분이 공지글인경우 공지글수를 제한한다
			if(GESI_FL.equals("T")){
				sql = "JiCmAbd.getBOARD_Gongji";
				query_param = new HashMap();
				// 회원사 공지사항인경우 사용자 공지사항으로 데이터 통합을 한다
				if(pcode.equals("000142")){
					query_param.put("pcode", "000115");
				}else{
					query_param.put("pcode", pcode);
				}
				rtn_list = list(sql, query_param);

				if(rtn_list.size() > 2){
					log.debug("현재 게시판에 공지글은 3개로 제한되어있습니다.:p_code:"+pcode+"");
					result_map.put("TRS_MSG","현재 게시판에 공지글은 3개로 제한되어있습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;	
				}
			}
			
			// 수정할 글을 조회한다
			sql = "JiCmAbd.getBOARD_S2";
			query_param = new HashMap();
			query_param.put("pcode", pcode);

			query_param.put("scode", scode);
			query_param.put("pstate", HtmlTag.returnString((String)param.get("pstate"),""));
			query_param.put("sidx", sidx);
			query_param.put("USER_ID", USER_ID);
			query_param.put("BOARD_TY", BOARD_TY);
			query_param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("DATA_IPNS"),""));
			
			log.debug("///////////////////////////////////////////"+param.get("DATA_IPNS"));
			
			Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", query_param);

			rtn_list = list(sql, query_param);
			if(!scode.equals("sysadm") && (BOARD_TY.equals("000417") || BOARD_TY.equals("000012"))){
				if(rtn_list!=null){
					if(rtn_list.size() == 1){
						tmp_map = (Map)rtn_list.get(0);
						//if(!JasyptUtil.encSHA256(DATA_IPNS).equals(tmp_map.get("DATA_IPNS"))){
						if(!pwdCheck.get("data_ipns").equals(tmp_map.get("DATA_IPNS"))){
							result_map.put("result",false);
							result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
							result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
							result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
							return result_map;			
						}				
					}else if(rtn_list.size() != 1){	
						result_map.put("TRS_MSG","수정할 정확한 게시물정보가 없습니다.");
						result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
						result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
						//throw new JSysException("코드가 중복되었습니다.");
						return result_map;							
					}else{
						result_map.put("TRS_MSG","수정할 정확한 게시물정보가 없습니다.");
						result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
						result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
						//throw new JSysException("코드가 중복되었습니다.");
						return result_map;						
					}				
				}else{
					result_map.put("TRS_MSG","수정할 정확한 게시물정보가 없습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;					
				}				
			}else if(!scode.equals("sysadm") && BOARD_TY.equals("000223")){
				if(rtn_list!=null){
					if(rtn_list.size() == 1){
						tmp_map = (Map)rtn_list.get(0);
					}else{
						throw new JSysException("수정할 정확한 게시물정보가 없습니다.");
					}
				}else{
									
					throw new JSysException("수정할 정확한 게시물정보가 없습니다.");
				
				}
			}
			
			//log.debug((String[])form_list.toArray(new String[form_list.size()]));
			//log.debug(Param.getFormObjectIn(param, rtn_form_obj,null,null));
			sql = "JiCmAbd.updateBOARD";
			String B_ETC_ARR_query = "";
			query_param = new HashMap();
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("PASSWD", PASSWD);
			query_param.put("GESI_FL", GESI_FL);
			query_param.put("REG_NAME", REG_NAME);
			query_param.put("REG_MAIL", REG_MAIL1+"@"+REG_MAIL2);
			query_param.put("REG_TEL", REG_TEL);
			query_param.put("REG_HAND", REG_HAND);
			query_param.put("REG_IP", REG_IP);
			query_param.put("REG_PHOTO_ALT", REG_PHOTO_ALT);
			query_param.put("REG_SVNUMBER", REG_SVNUMBER);
			query_param.put("B_ETC_ARR_IDX", B_ETC_ARR_IDX);
			query_param.put("B_ETC_ARR", B_ETC_ARR);
			
			for(i=0;i<B_ETC_ARR.length;i++){
				query_param.put("B_ETC"+i, B_ETC_ARR[i]);

			}			
			/*for(i=0;i<B_ETC_ARR.length;i++){
				B_ETC_ARR_query = B_ETC_ARR_query +",DATA_SPA_COL"+i+"='"+B_ETC_ARR[i]+"' ";
			}
			query_param.put("B_ETC_ARR_query", B_ETC_ARR_query);
			*/
			
			query_param.put("B_SDATE", B_SDATE);
			query_param.put("B_EDATE", B_EDATE);
			
			query_param.put("REG_DT", REG_DT);
			query_param.put("B_CONTENTS", B_CONTENTS);
			query_param.put("sidx", sidx);
			
			
			//첨부파일 처리
			param.put("imenu_data_title", HtmlTag.StripStrInXss(HtmlTag.returnString(B_TITLE,"")));
			param.put("ikey_datas", Integer.toString(sidx));
			param.put("iuploadseq", "");
			temp_file = cmMtmDAO01.InsertFile(param);

			log.debug("6====================================================================");

			update(sql, query_param);

			result_map.put("result",true);
			result_map.put("TRS_MSG","수정되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			

		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  "+q);	
			throw q;		
				

		}catch(NullPointerException q){
			log.debug("NullPointerException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  "+q);	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}

		log.debug("==== updateABD : END ====");
		return result_map;	
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 삭제하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  삭제 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map deleteABD(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO deleteABD 
		log.debug("==== deleteABD : START ====");
		Map result_map = new HashMap();
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};
		String[] rtn_form_obj = null;

		List form_list = new ArrayList();
		Param Param_Obj = new Param();		
		//log.debug(message)
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String sseq  = HtmlTag.returnString((String)param.get("sseq"),"0");
		String pcode  = HtmlTag.returnString((String)param.get("pcode"),"");
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		
		
		

		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String BOARD_TY				= HtmlTag.returnString((String)MENUCFG.get("boardTy"),"");
		
		//String M_OPT = HtmlTag.returnString((String)MENUCFG.get("mOpt"),"");// 메뉴옵션
		//String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		//String DATA_IPNS	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("DATA_IPNS"),""));//비밀번호
		String DATA_IPNS	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("ichk_secret_no"),""));//비밀번호
		
		Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
				admin_chk =1;
	    	}
			
	    // 일반사이트프로그램접속인경우
	    }else{
	    	//if(BOARD_TY.equals("000012")){
	    		if(SITE_SESSION!= null){
		    		SITE_SESSION	= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
					USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
					USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));		    	
			    	admin_chk =0;
	    		}

	    	//}else{
			//	USER_ID			= "";
			//	USER_NAME		= "";
	    	//}
	    		
	    		
	    	
	    }

		
		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		int chk_cnt  = 0;
		int i = 0;
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;
		
		String rsIDX = "";
		String rsM_CODE = "";
		String rsRIDX = "";
		String rsFILE_NM = "";
		String rsRFILE_NM = "";
		String rsORDER_NO = "";
		String rsREG_DT = "";
		String docsave_root = propertiesService.getString("UPLOADROOTPATH");		
		try{
			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 사용자 화면인경우이고 자유형, 답변형 게시판이 아닌경우 무조건 접근을 막는다
			if(!scode.equals("sysadm") && (!BOARD_TY.equals("000417") && !BOARD_TY.equals("000012") && !BOARD_TY.equals("000223"))){
				throw new JSysException("접근권한이 없습니다!!");
			}
			
			// 삭제할 글을 조회한다
			sql = "JiCmAbd.getBOARD_S2";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			
			query_param.put("scode", scode);
			query_param.put("pstate", HtmlTag.returnString((String)param.get("pstate"),""));
			query_param.put("sidx", sidx);
			query_param.put("USER_ID", USER_ID);
			query_param.put("BOARD_TY", BOARD_TY);
			query_param.put("req_SECRET_NO", HtmlTag.returnString((String)param.get("ichk_secret_no"),""));				

			rtn_list = list(sql, query_param);
			Map pwdCheck = (HashMap) getSelectByPkNoEgov("JiCmAbd.getBOARD_pwdCheck", query_param);
			
			if(!scode.equals("sysadm") && (BOARD_TY.equals("000417") || BOARD_TY.equals("000012"))){
				if(rtn_list!=null){
					if(rtn_list.size() == 1){
						tmp_map = (Map)rtn_list.get(0);
						//if(!JasyptUtil.encSHA256(DATA_IPNS).equals(tmp_map.get("DATA_IPNS"))){
						log.debug("tmp_map.get =>"+pwdCheck + "/////" + tmp_map.get("DATA_IPNS"));
						if(!pwdCheck.get("data_ipns").equals(tmp_map.get("DATA_IPNS"))){
							result_map.put("result",false);
							result_map.put("TRS_MSG","비밀번호가 일치하지않습니다.");
							result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
							result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));
							return result_map;			
						}				
					}else if(rtn_list.size() != 1){	
						result_map.put("TRS_MSG","삭제할 게시물 정보가 정확하지 않습니다.");
						result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
						result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
						//throw new JSysException("코드가 중복되었습니다.");
						return result_map;						
					}else{
						result_map.put("TRS_MSG","삭제할 게시물 정보가 정확하지 않습니다.");
						result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
						result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
						//throw new JSysException("코드가 중복되었습니다.");
						return result_map;						
					}				
				}else{
					result_map.put("TRS_MSG","삭제할 게시물 정보가 정확하지 않습니다.");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;					
				}				
			}else if(!scode.equals("sysadm") && BOARD_TY.equals("000223")){
				if(rtn_list!=null){
					if(rtn_list.size() == 1){
						tmp_map = (Map)rtn_list.get(0);
					}else{
						throw new JSysException("삭제할 정확한 게시물정보가 없습니다.");
					}
				}else{
									
					throw new JSysException("삭제할 정확한 게시물정보가 없습니다.");
				
				}
			}	
			
			if(rtn_list!=null){
				if(rtn_list.size() > 0){
					tmp_map = (Map)rtn_list.get(0);
		
					if(tmp_map.get("MENU_CODE")==null){
						rsM_CODE = "";
					}else{
						rsM_CODE = HtmlTag.returnString((String)tmp_map.get("MENU_CODE"),"");
					}
					
					if(tmp_map.get("REGST_EMP_ID")==null){
						del_REG_ID = "";
					}else{
						del_REG_ID = HtmlTag.returnString((String)tmp_map.get("REGST_EMP_ID"),"");
					}				
					
					if(tmp_map.get("DATA_SEQNO")==null){
						del_R_IDX = 0;
					}else{
						del_R_IDX = Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SEQNO")),"0"));
					}				

					if(tmp_map.get("DATA_DEPTH")==null){
						del_R_DEPTH = 0;
					}else{
						del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_DEPTH")),"0"));
					}
					
					if(tmp_map.get("DATA_SORT_NO")==null){
						del_R_ORDER = 0;
					}else{
						del_R_ORDER	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SORT_NO")),"0"));
					}				
					

					// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
				}else{
					log.debug("삭제할데이터가 존재하지않습니다:");
					result_map.put("result",false);
					result_map.put("TRS_MSG","삭제할데이터가 존재하지않습니다");
					result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
					result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
					//throw new JSysException("코드가 중복되었습니다.");
					return result_map;				
				}				
			}

			
			// 해당글에 답변글이 등록된 경우는 삭제되지 않도록 한다
			sql = "JiCmAbd.deleteBOARD_Recnt";
			query_param = new HashMap();
			query_param.put("del_R_IDX", del_R_IDX);
			query_param.put("del_R_DEPTH", del_R_DEPTH);
			query_param.put("del_R_ORDER", del_R_ORDER);
			
			rtn_list = list(sql, query_param);
			
			if(rtn_list!=null){
				if(rtn_list.get(0)!=null){
					if(((Map)rtn_list.get(0)).get("replyCnt")!=null){
						if(String.valueOf(((Map)rtn_list.get(0)).get("replyCnt"))!=null){
							if(Integer.parseInt(String.valueOf(((Map)rtn_list.get(0)).get("replyCnt"))) > 0){
								result_map.put("result",false);
								result_map.put("TRS_MSG","답변이 등록된 글은 삭제하실수 없습니다.");
								result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
								result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
								//throw new JSysException("코드가 중복되었습니다.");
								return result_map;				
							}
							
						}
					}
					
				}
			}
			

			
			// 해당글에 댓글이 등록된 경우는 삭제되지 않도록 한다
			sql = "JiCmAbd.deleteBOARD_RE_Recnt";
			query_param = new HashMap();
			query_param.put("del_R_IDX", del_R_IDX);
			query_param.put("del_R_DEPTH", del_R_DEPTH);
			query_param.put("del_R_ORDER", 0);
			
			rtn_list = list(sql, query_param);
			
			if(rtn_list!=null){
				if(rtn_list.get(0)!=null){
					if(((Map)rtn_list.get(0)).get("reReplyCnt")!=null){
						if(String.valueOf(((Map)rtn_list.get(0)).get("reReplyCnt"))!=null){
							if(Integer.parseInt(String.valueOf(((Map)rtn_list.get(0)).get("reReplyCnt"))) > 0){
								result_map.put("result",false);
								result_map.put("TRS_MSG","댓글이 등록된 글은 삭제하실수 없습니다.");
								result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
								result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
								//throw new JSysException("코드가 중복되었습니다.");
								return result_map;				
							}
							
						}
					}
					
				}
			}
			
			
			

			// 댓글 데이블을 삭제한다
			sql = "JiCmAbd.deleteBOARD_RE";
			query_param = new HashMap();
			query_param.put("del_R_IDX", del_R_IDX);

			log.debug("deleteABD deleteBOARD_RE : del_R_IDX:"+del_R_IDX);
			delete(sql, query_param);
		
			// 첨부테이블을 삭제한다
			sql = "JiCmMtm.getdeleteJRCMS_FILE_MGR_ALL";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sidx", del_R_IDX);
			rtn_list = list(sql, query_param);


			chk_cnt = rtn_list.size();

			if(rtn_list.size() > 0){
				for(i=0;i<rtn_list.size();i++){
					tmp_map = (Map)rtn_list.get(i);
					
					if(tmp_map.get("idx")!=null){
						rsIDX =  String.valueOf(tmp_map.get("idx"));
					}else{
						rsIDX =  "0";
					}
					
					if(tmp_map.get("mCode")!=null){
						rsM_CODE = (String)tmp_map.get("mCode");
					}else{
						rsM_CODE =  "";
					}

					if(tmp_map.get("ridx")!=null){
						rsRIDX =  String.valueOf(tmp_map.get("ridx"));
					}else{
						rsRIDX =  "0";
					}					

					if(tmp_map.get("fileNm")!=null){
						rsFILE_NM = (String)tmp_map.get("fileNm");
					}else{
						rsFILE_NM =  "";
					}					

					if(tmp_map.get("rfileNm")!=null){
						rsRFILE_NM = (String)tmp_map.get("rfileNm");
					}else{
						rsRFILE_NM =  "";
					}					

					if(tmp_map.get("orderNo")!=null){
						rsORDER_NO =  String.valueOf(tmp_map.get("orderNo"));
					}else{
						rsORDER_NO =  "0";
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
			query_param.put("pcode", pcode);
			query_param.put("sidx", del_R_IDX);
			
			delete(sql, query_param);
			
			log.debug("deleteABD : DeleteJRCMS_FILE_MGR_ALL : del_R_IDX:"+del_R_IDX);

			// 게시물을 삭제한다
			sql = "JiCmAbd.deleteBOARD";
			query_param = new HashMap();
			query_param.put("sidx", sidx);
			
			delete(sql, query_param);
			
			log.debug("deleteABD deleteBOARD : sidx:"+sidx);

			
			// 게시물의 순번을 조정한다
			sql = "JiCmAbd.updateDelBOARD";
			query_param = new HashMap();
			query_param.put("del_R_IDX", del_R_IDX);
			query_param.put("del_R_ORDER", del_R_ORDER);
			
			update(sql, query_param);
			
			

			result_map.put("TRS_MSG","삭제되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			throw q;		
		
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		//저장 중 오류가 발행하였습니다.

		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}catch(Exception q){				
			log.debug("JSysException Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.save"),q);		///저장 중 오류가 발행하였습니다.

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== deleteABD : END ====");

		return result_map;	
	}	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map insertABDRE(Map param) throws Exception{
		//	TODO insertABDRE 
		log.debug("==== insertABDRE : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();

		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();
		List save_file_list = new ArrayList();
		Param Param_Obj = new Param();
		int i = 0;
		int j = 0;
		//log.debug("==== insertABD : 11111111111 ====");
		String B_FILES		= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_FILES"),""));// 파일객체명들
		
		String[] file_obj = null;
		String[] B_FILES_ARR = null;
		//log.debug("==== insertABD : 22222222222 ====");
		if(!B_FILES.equals("")){
			//log.debug("==== insertABD : 2-1 ====");
			B_FILES_ARR = B_FILES.split("::");
			//log.debug("==== insertABD : 2-2 ==B_FILES_ARR.length=="+B_FILES_ARR.length);
			
			if(B_FILES_ARR!=null){
				j= 0;
				for(i=0;i<B_FILES_ARR.length;i++){
					if(B_FILES_ARR[i]!=null){
						if(!B_FILES_ARR[i].equals("")){
							j++;
						}
					}
				}
				//log.debug("==== insertABD : 2-2 ==file_obj=="+j);
				file_obj = new String[j];
				j= 0;
				for(i=0;i<B_FILES_ARR.length;i++){
					//log.debug("==== insertABD : 2-4 ==i="+i);
					if(B_FILES_ARR[i]!=null){
						//log.debug("==== insertABD : 2-5 ====");
						if(!B_FILES_ARR[i].equals("")){
							log.debug("==== insertABDRE : 2-6 ===="+B_FILES_ARR[i]);
							file_obj[j] = B_FILES_ARR[i];
							j++;
						}
					}
				}
			}
		}

		//log.debug("==== insertABD : 33333333333 ====");
		//log.debug(message)
		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );
		List file_arr	= (List)param.get("FILE_ARR");// 업로드 파일정보

		String B_TITLE	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_TITLE"),""));// 제목
		String REG_NAME	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME"),""));//작성자
		String REG_DT    = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_DT"),""));//등록일
		String REG_MAIL1 = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_MAIL1"),""));//이메일1
		String REG_MAIL2 = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_MAIL2"),""));//이메일2
		
		String GESI_FL = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("GESI_FL"),"Y"));//게시구분


		String B_CONTENTS = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_CONTENTS"),""));//내용

		String PASSWD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("PASSWD"),""));//비밀번호

		String B_SDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_SDATE"),""));//게시물 기간시작일
		String B_EDATE	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_EDATE"),""));//게시물 기간종료일
		String REG_TEL	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_TEL"),""));//게시물등록자 전화
		String REG_HAND	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_HAND"),""));//게시물등록자 핸드폰
		String REG_IP	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_IP"),""));//게시물등록자 아이피
		String REG_PHOTO_ALT	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_PHOTO_ALT"),""));//게시판종류가 갤러리일경우 대표이미지ALT
		String REG_SVNUMBER	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_SVNUMBER"),""));//게시물등록자 아이핀
		String [] B_ETC_ARR = new String[10];//게시물 임시컬럼 배열
		int [] B_ETC_ARR_IDX = new int[10];//게시물 임시컬럼 배열
		for(i=0;i<B_ETC_ARR.length;i++){
			B_ETC_ARR[i] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_ETC"+i),""));//게시물 임시컬럼
			B_ETC_ARR_IDX[i] = i;
		}
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    	
	    // 일반사이트프로그램접속인경우
	    }else{
			// 로그인이 필요한 게시판일경우
	    	if(SITE_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
		    	admin_chk =0;
	    	}
	    	
			// 로그인을 한경우
			if(SITE_SESSION!= null){
				log.debug("session chk 1======================");
		    	if(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"").equals("")){
		    		throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
		    	}
		    }else{
		    	log.debug("session chk 2======================");
		    	// 로그인 없이 글등록시 본인인증한값 체크
				
				throw new JSysException("로그인 정보가 정확하지 않습니다.");
				
		    }	    	

	    }

	    if(REG_NAME.equals("")){
	    	REG_NAME	= USER_NAME;
	    }else{

	    }
		
		long max_seq = 0;

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JIT9150","IDX","");
		
		long r_idx= sidx;
	    int r_depth=1;
	    int r_order=1;
	    
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;

		//DEPTH_NO = Integer.parseInt(se_lv) + 1;
		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 삭제할 글을 조회한다
			sql = "JiCmAbd.getBOARD_S2";
			query_param = new HashMap();
			query_param.put("scode", scode);
			query_param.put("pcode", pcode);
			query_param.put("sidx", sidx);
			query_param.put("pstate", HtmlTag.returnString((String)param.get("pstate"),""));

			rtn_list = list(sql, query_param);
			if(rtn_list.size() > 0){
				tmp_map = (Map)rtn_list.get(0);
				

				
				if(tmp_map.get("REG_ID")==null){
					del_REG_ID = "";
				}else{
					del_REG_ID = HtmlTag.returnString((String)tmp_map.get("REG_ID"),"");
				}				
				
				if(tmp_map.get("DATA_SEQNO")==null){
					del_R_IDX = 0;
				}else{
					del_R_IDX = Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SEQNO")),"0"));
				}				

				if(tmp_map.get("DATA_DEPTH")==null){
					del_R_DEPTH = 0;
				}else{
					del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_DEPTH")),"0"));
				}
				
				if(tmp_map.get("DATA_SORT_NO")==null){
					del_R_ORDER = 0;
				}else{
					del_R_ORDER	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SORT_NO")),"0"));
				}
				

				// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
			}else{
				log.debug("삭제할데이터가 존재하지않습니다:");
				result_map.put("TRS_MSG","삭제할데이터가 존재하지않습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
			}
			
			
			r_idx= del_R_IDX;
		    r_depth=del_R_DEPTH+1;
		    r_order=del_R_ORDER+1; 
		    
			//답변글등록일경우 해당데이터에 대한 답변사항에 대해 정렬을 행한다
			//해당데이터를 중간에 끼워넣는다	
			sql = "JiCmAbd.updateBOARD_mid";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("r_idx", r_idx);
			query_param.put("r_order", r_order);
			
			update(sql, query_param);
			
			
			sql = "JiCmAbd.insertBOARD";
			query_param = new HashMap();
			query_param.put("B_SDATE", B_SDATE);
			query_param.put("B_EDATE", B_EDATE);
			query_param.put("B_ETC_ARR_IDX", B_ETC_ARR_IDX);
			query_param.put("B_ETC_ARR", B_ETC_ARR);
			
			query_param.put("data_seqno", max_seq);
			query_param.put("pcode", pcode);
			query_param.put("REG_DT", REG_DT);
			
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("B_CONTENTS", B_CONTENTS);
			query_param.put("r_idx", r_idx);
			query_param.put("r_depth", r_depth);
			query_param.put("r_order", r_order);
			query_param.put("PASSWD", PASSWD);

			query_param.put("GESI_FL", GESI_FL);
			query_param.put("REG_NAME", REG_NAME);
			query_param.put("REG_MAIL", REG_MAIL1+"@"+REG_MAIL2);

			query_param.put("REG_TEL", REG_TEL);
			query_param.put("REG_HAND", REG_HAND);
			query_param.put("REG_IP", REG_IP);
			query_param.put("REG_PHOTO_ALT", REG_PHOTO_ALT);
			query_param.put("REG_SVNUMBER", REG_SVNUMBER);
			
			
			insert(sql, query_param);
			
			
			param.put("imenu_data_title", HtmlTag.StripStrInXss(HtmlTag.returnString(B_TITLE,"")));
			param.put("ikey_datas", Long.toString(max_seq));
			
			temp_file = cmMtmDAO01.InsertFile(param);			
			
			log.debug("==== insertABDRE : 777777777777777777 ====");

			result_map.put("TRS_MSG","등록되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		
		}catch(SQLException q){
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRE SQLException:"+q);
			throw q;
		}catch(IOException q){
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRE IOException:"+q);
			throw q;
		}catch(Exception q){
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABD Exception:"+q);
			throw q;
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
			
		}
		log.debug("==== insertABDRE : END ====");

		return result_map;	
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map insertABDRR(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO insertABDRR 
		log.debug("==== insertABDRR : START ====");
		

		Map result_map = new HashMap();
		Map temp_file = new HashMap();
		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows","sidx"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();


		int i = 0;
		int j = 0;

		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );

		String B_TITLE			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_TITLE"),""));// 댓글내용
		String REG_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME"),""));//작성자

		String GESI_FL = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("GESI_FL"),"Y"));//게시구분

		String PASSWD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("PASSWD"),""));//비밀번호

		String REG_IP	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_IP"),""));//게시물등록자 아이피
		String REG_SVNUMBER	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_SVNUMBER"),""));//게시물등록자 아이핀
		String [] B_ETC_ARR = new String[10];//게시물 임시컬럼 배열
		int [] B_ETC_ARR_IDX = new int[10];//게시물 임시컬럼 배열
		for(i=0;i<B_ETC_ARR.length;i++){
			B_ETC_ARR[i] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_ETC"+i),""));//게시물 임시컬럼
			B_ETC_ARR_IDX[i] = i;
		}
		
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    	
	    // 일반사이트프로그램접속인경우
	    }else{
	    	if(SITE_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
			    admin_chk =0;
	    	}

	    }
	    
	    if(REG_NAME.equals("")){
	    	REG_NAME	= USER_NAME;
	    }else{

	    }

		
		long max_seq = 0;

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JRCMS_BOARD_RE","IDX","");
		
		long r_idx= max_seq;
	    int r_depth=1;
	    int r_order=1;
	    
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;

		//DEPTH_NO = Integer.parseInt(se_lv) + 1;
		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 삭제할 글을 조회한다
			sql = "JiCmAbd.getBOARD_S2";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sidx", sidx);

			rtn_list = list(sql, query_param);
			if(rtn_list.size() > 0){
				tmp_map = (Map)rtn_list.get(0);
				
				if(tmp_map.get("REG_ID")==null){
					del_REG_ID = "";
				}else{
					del_REG_ID = HtmlTag.returnString((String)tmp_map.get("REG_ID"),"");
				}				
				
				if(tmp_map.get("DATA_SEQNO")==null){
					del_R_IDX = 0;
				}else{
					del_R_IDX = Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SEQNO")),"0"));
				}				

				if(tmp_map.get("DATA_DEPTH")==null){
					del_R_DEPTH = 0;
				}else{
					del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_DEPTH")),"0"));
				}
				
				if(tmp_map.get("DATA_SORT_NO")==null){
					del_R_ORDER = 0;
				}else{
					del_R_ORDER	= Integer.parseInt(HtmlTag.returnString(String.valueOf(tmp_map.get("DATA_SORT_NO")),"0"));
				}				

				// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
				
			}else{
				log.debug("삭제할데이터가 존재하지않습니다:");
				result_map.put("TRS_MSG","삭제할데이터가 존재하지않습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;
			}
			
			r_idx= max_seq;
		    r_depth=1;
		    r_order=1;
		    
			sql = "JiCmAbd.insertBOARDRE";
			query_param = new HashMap();
			query_param.put("max_seq", max_seq);
			query_param.put("pcode", pcode);
			query_param.put("B_ETC_ARR_IDX", B_ETC_ARR_IDX);
			query_param.put("B_ETC_ARR", B_ETC_ARR);
			
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("r_idx", r_idx);
			query_param.put("r_depth", r_depth);
			query_param.put("r_order", r_order);
			query_param.put("PASSWD", PASSWD);
			
			query_param.put("GESI_FL", GESI_FL);
			query_param.put("REG_NAME", REG_NAME);
			
			query_param.put("REG_SVNUMBER", REG_SVNUMBER);
			query_param.put("sidx", sidx);
			
			
			insert(sql, query_param);
			
			log.debug("==== insertABDRR : 777777777777777777 ====");

			result_map.put("result", true);
			result_map.put("TRS_MSG","등록되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRR JSysException:");	
			throw q;
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRR JSysException:");
			throw q;
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRR JSysException:");
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRR JSysException:");	
			throw q;
		}catch(Exception q){
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRR JSysException:");		
			throw q;
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertABDRR : END ====");

		return result_map;	
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 수정하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  수정 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map updateABDRR(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO updateABDRR 
		log.debug("==== updateABDRR : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();

		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows","sidx","sreidx"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();


		int i = 0;
		int j = 0;

		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		int sreidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sreidx"),"0")));
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );

		String B_TITLE		= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_TITLE_"+sreidx),""));// 댓글내용
		String REG_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME_"+sreidx),""));//작성자

	
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    	
	    // 일반사이트프로그램접속인경우
	    }else{	
	    	if(SITE_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
			    admin_chk =0;
	    	}
			
	    }
	    
	    if(REG_NAME.equals("")){
	    	REG_NAME	= USER_NAME;
	    }
	    
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;
		int del_RR_IDX = 0;


		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 수정할 글을 조회한다
			sql = "JiCmAbd.getBOARDRR_S";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sreidx", sreidx);
			
			rtn_list = list(sql, query_param);


			if(rtn_list.size() > 0){
				tmp_map = (Map)rtn_list.get(0);
	
				if(tmp_map.get("regId")==null){
					del_REG_ID = "";
				}else{
					del_REG_ID = HtmlTag.returnString((String)tmp_map.get("regId"),"");
				}				
				
				if(tmp_map.get("rIdx")==null){
					del_R_IDX = 0;
				}else{
					del_R_IDX = Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rIdx"),"0"));
				}				

				if(tmp_map.get("rDepth")==null){
					del_R_DEPTH = 0;
				}else{
					del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rDepth"),"0"));
				}
				
				if(tmp_map.get("rOrder")==null){
					del_R_ORDER = 0;
				}else{
					del_R_ORDER	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rOrder"),"0"));
				}
				
				if(tmp_map.get("rrIdx")==null){
					del_RR_IDX = 0;
				}else{
					del_RR_IDX	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rrIdx"),"0"));
				}				

				

				// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
			}else{
				log.debug("댓글을 수정할 데이터가 존재하지않습니다:p_code:"+pcode+":sidx:"+sidx);
				result_map.put("TRS_MSG","댓글을 수정할 데이터가 존재하지않습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
			}

			sql = "JiCmAbd.updateBOARDRE";
			query_param = new HashMap();
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("REG_NAME", REG_NAME);
			query_param.put("sidx", sreidx);
			
			update(sql, query_param);
			
			log.debug("==== updateABDRR : 777777777777777777 ====");
			result_map.put("result", true);
			result_map.put("TRS_MSG","수정되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("updateABDRR JSysException:");
			throw q;
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("updateABDRR JSysException:");
			throw q;
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("updateABDRR JSysException:");
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("updateABDRR JSysException:");
			throw q;
		}catch(Exception q){
			result_map.put("TRS_MSG","수정중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("updateABDRR JSysException:");	
			throw q;
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");
			

		}
		log.debug("==== updateABDRR : END ====");

		return result_map;	
	}
	
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 삭제하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  삭제 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map deleteABDRR(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO deleteABDRR 
		log.debug("==== deleteABDRR : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();

		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows","sidx","sreidx"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();


		int i = 0;
		int j = 0;

		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		int sreidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sreidx"),"0")));
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );

	
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    
	    // 일반사이트프로그램접속인경우
	    }else{	
	    	if(SITE_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
				USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
			    admin_chk =0;
	    	}

	    }
	    
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;
		int del_RR_IDX = 0;

		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 삭제할 글을 조회한다
			sql = "JiCmAbd.getBOARDRR_S";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sreidx", sreidx);
			
			rtn_list = list(sql, query_param);


			if(rtn_list.size() > 0){
				tmp_map = (Map)rtn_list.get(0);
				if(tmp_map.get("regId")==null){
					del_REG_ID = "";
				}else{
					del_REG_ID = HtmlTag.returnString((String)tmp_map.get("regId"),"");
				}				
				
				if(tmp_map.get("rIdx")==null){
					del_R_IDX = 0;
				}else{
					del_R_IDX = Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rIdx"),"0"));
				}				

				if(tmp_map.get("rDepth")==null){
					del_R_DEPTH = 0;
				}else{
					del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rDepth"),"0"));
				}
				
				if(tmp_map.get("rOrder")==null){
					del_R_ORDER = 0;
				}else{
					del_R_ORDER	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rOrder"),"0"));
				}
				
				if(tmp_map.get("rrIdx")==null){
					del_RR_IDX = 0;
				}else{
					del_RR_IDX	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rrIdx"),"0"));
				}				

				// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
				
			}else{
				log.debug("댓글을 수정할 데이터가 존재하지않습니다:p_code:"+pcode+":sidx:"+sidx);
				result_map.put("TRS_MSG","댓글을 수정할 데이터가 존재하지않습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
			}
			

			
			// 삭제할 댓글의 댓글이 존재하는지 확인한다
			// 해당글에 댓글이 등록된 경우는 삭제되지 않도록 한다
			sql = "JiCmAbd.deleteBOARD_RE_Recnt";
			query_param = new HashMap();
			query_param.put("del_R_IDX", del_R_IDX);
			query_param.put("del_R_DEPTH", del_R_DEPTH);
			query_param.put("del_R_ORDER", del_R_ORDER);
			
			rtn_list = list(sql, query_param);
			
			if(rtn_list!=null){
				if(rtn_list.get(0)!=null){
					if(((Map)rtn_list.get(0)).get("reReplyCnt")!=null){
						if(String.valueOf(((Map)rtn_list.get(0)).get("reReplyCnt"))!=null){
							if(Integer.parseInt(String.valueOf(((Map)rtn_list.get(0)).get("reReplyCnt"))) > 0){
								result_map.put("TRS_MSG","댓글이 등록된 글은 삭제하실수 없습니다.");
								result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
								result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
								//throw new JSysException("코드가 중복되었습니다.");
								return result_map;				
							}
							
						}
					}
					
				}
			}
			
		    
			sql = "JiCmAbd.deleteBOARDRE";
			query_param = new HashMap();
			query_param.put("sreidx", sreidx);
			
			delete(sql, query_param);

			log.debug("==== deleteABDRR : 777777777777777777 ====");
			
			result_map.put("result", true);
			result_map.put("TRS_MSG","삭제되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteABDRR JSysException:");		
			throw q;
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteABDRR JSysException:");		
			throw q;
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteABDRR JSysException:");		
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteABDRR JSysException:");	
			throw q;
		}catch(Exception q){
			result_map.put("TRS_MSG","삭제중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("deleteABDRR JSysException:");
			throw q;

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== deleteABDRR : END ====");

		return result_map;	
	}
	
	/**
	* <p> ctlABD(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 등록 결과를 받아서 리턴한다
	*
	* @param   param		Map		입력데이터
	*
	* @return  등록 결과값을 리턴한다
	 * @throws JSysException 
	* @throws  
	*/	
	public Map insertABDRRC(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		//	TODO insertABDRRC 
		log.debug("==== insertABDRRC : START ====");
		Map result_map = new HashMap();
		Map temp_file = new HashMap();

		
		String[] rtn_form_obj_in = {"scode","pcode","se_field","se_text","se_code","curr_page","show_rows","sidx","sreidx"};

		String[] rtn_form_obj = null;
		List form_list = new ArrayList();


		int i = 0;
		int j = 0;

		int sidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"0")));
		int sreidx = Integer.parseInt(HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sreidx"),"0")));
		String pcode	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("pcode"),"") );
		String scode 	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("scode"),"") );

		String B_TITLE			= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("B_TITLE_"+sreidx),""));// 댓글내용
		String REG_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_NAME_"+sreidx),""));//작성자

		String GESI_FL = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("GESI_FL_"+sreidx),"Y"));//게시구분

		String PASSWD	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("PASSWD_"+sreidx),""));//비밀번호

		String REG_IP	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_IP_"+sreidx),""));//게시물등록자 아이피
		String REG_SVNUMBER	= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("REG_SVNUMBER_"+sreidx),""));//게시물등록자 아이핀
		String [] B_ETC_ARR = new String[10];//게시물 임시컬럼 배열
		int [] B_ETC_ARR_IDX = new int[10];//게시물 임시컬럼 배열
		for(i=0;i<B_ETC_ARR.length;i++){
			B_ETC_ARR[i] = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("B_ETC"+i),""));//게시물 임시컬럼
			B_ETC_ARR_IDX[i] = i;
		}
		
		Map MENUCFG = (Map)param.get("MENUCFG"); // 들어온 환경설정
		String M_OPT = HtmlTag.returnString((String)MENUCFG.get("M_OPT"),"");// 메뉴옵션
		String [] M_OPT_ARR	= HtmlText.split2(M_OPT,"::");
		
	    Map SITE_SESSION		= (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    
	    int admin_chk =0;
	    String USER_ID	= "";
	    String USER_NAME		= "";
	    // 관리자프로그램접속인경우
	    if(scode.equals(propertiesService.getString("SYS_ADMIN_CD","sysadm"))){
	    	if(SITE_ADM_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
		    	USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),""));
		    	admin_chk =1;
	    	}
	    	
	    // 일반사이트프로그램접속인경우
	    }else{		
	    	if(SITE_SESSION!= null){
		    	USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),""));
		    	USER_NAME		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_NM"),""));
			    admin_chk =0;
	    	}

			
	    }

	    
	    if(REG_NAME.equals("")){
	    	REG_NAME	= USER_NAME;
	    }

		
		long max_seq = 0;

		// 등록될 IDX를 채번한다
		max_seq = cmDAO.getTableMaxSeq("JRCMS_BOARD_RE","IDX","");
		
		long r_idx= sidx;
	    int r_depth=1;
	    int r_order=1;
	    
		String del_REG_ID = "";
		int del_R_IDX = 0;
		int del_R_DEPTH = 0;
		int del_R_ORDER = 0;
		int del_RR_IDX = 0;

		// 데이터베이스에 결과를 저장한다.
		String sql = "";
		Map query_param = new HashMap();
		Map tmp_map = new HashMap();
		List rtn_list = new ArrayList();
		try{

			// 결과값을 처리할 form객체를 생성한다
			form_list = Param.getObjectNameIn(param,rtn_form_obj_in);
			rtn_form_obj = Param.getListToArr(form_list);
			result_map.put(propertiesService.getString("RESULT_URL_F_KEY")
							,Param.getFormObjectIn(param, rtn_form_obj,null,null));
			
			// 삭제할 글을 조회한다
			sql = "abdDAO.getBOARDRR_S";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("sreidx", sreidx);
			
			rtn_list = list(sql, query_param);

			if(rtn_list.size() > 0){
				tmp_map = (Map)rtn_list.get(0);
				
				if(tmp_map.get("regId")==null){
					del_REG_ID = "";
				}else{
					del_REG_ID = HtmlTag.returnString((String)tmp_map.get("regId"),"");
				}				
				
				if(tmp_map.get("rIdx")==null){
					del_R_IDX = 0;
				}else{
					del_R_IDX = Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rIdx"),"0"));
				}				

				if(tmp_map.get("rDepth")==null){
					del_R_DEPTH = 0;
				}else{
					del_R_DEPTH	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rDepth"),"0"));
				}
				
				if(tmp_map.get("rOrder")==null){
					del_R_ORDER = 0;
				}else{
					del_R_ORDER	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rOrder"),"0"));
				}
				
				if(tmp_map.get("rrIdx")==null){
					del_RR_IDX = 0;
				}else{
					del_RR_IDX	= Integer.parseInt(HtmlTag.returnString((String)tmp_map.get("rrIdx"),"0"));
				}					

				// 관리자아닐경우   해당글을 등록,요청한 사람일경우 수정삭제가 가능하다
				
			}else{
				log.debug("댓글을 수정할 데이터가 존재하지않습니다:p_code:"+pcode+":sidx:"+sidx);
				result_map.put("TRS_MSG","댓글을 수정할 데이터가 존재하지않습니다");
				result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
				result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));					
				//throw new JSysException("코드가 중복되었습니다.");
				return result_map;				
			}
			
			r_idx= del_R_IDX;
		    r_depth=del_R_DEPTH+1;
		    r_order=del_R_ORDER+1; 
		    
			//답변글등록일경우 해당데이터에 대한 답변사항에 대해 정렬을 행한다
			//해당데이터를 중간에 끼워넣는다
		    sql = "abdDAO.updateBOARDRR_mid";
			query_param = new HashMap();
			query_param.put("pcode", pcode);
			query_param.put("r_idx", r_idx);
			query_param.put("r_order", r_order);
			
			update(sql, query_param);
			
			sql = "abdDAO.insertBOARDRE";
			query_param = new HashMap();
			query_param.put("max_seq", max_seq);
			query_param.put("pcode", pcode);
			query_param.put("B_ETC_ARR_IDX", B_ETC_ARR_IDX);
			query_param.put("B_ETC_ARR", B_ETC_ARR);
			
			query_param.put("USER_ID", USER_ID);
			query_param.put("B_TITLE", B_TITLE);
			query_param.put("r_idx", r_idx);
			query_param.put("r_depth", r_depth);
			query_param.put("r_order", r_order);
			query_param.put("PASSWD", PASSWD);
			
			query_param.put("GESI_FL", GESI_FL);
			query_param.put("REG_NAME", REG_NAME);
			
			query_param.put("REG_SVNUMBER", REG_SVNUMBER);
			query_param.put("sidx", sidx);
			
			insert(sql, query_param);
			log.debug("==== insertABDRRC : 777777777777777777 ====");
			
			result_map.put("result", true);
			result_map.put("TRS_MSG","등록되었습니다");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
		}catch(IOException q){
			log.debug("IOException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRRC Exception:");		
			throw q;
		}catch(SQLException q){
			log.debug("SQLException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRRC Exception:");		
			throw q;
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRRC Exception:");		
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRRC Exception:");		
			throw q;
		}catch(Exception q){
			result_map.put("TRS_MSG","등록중에러가 발생했습니다");
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.debug("insertABDRRC Exception:");
			throw q;
			

		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== insertABDRRC : END ====");

		return result_map;	
	}	
	
	/**
	* <p> MAController.java(메인컨트롤클래스)에서 파일다운로드정보를 조회하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   m_code		String		메뉴코드
	*
	* @return  파일다운로드정보의 조회 결과값을 리턴한다
	* @throws  
	*/
	public Map getBdPwd (Map param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO getBdPwd
		log.debug("==== getBdPwd Start ====");
		Map result_map = new HashMap();
		Map tmp_map  = new HashMap();
		String sidx	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("sidx"),"") );
		String b_passwd	= HtmlTag.StripStrInXss( HtmlTag.returnString((String)param.get("b_passwd"),"") );

		String trs_msg = "";

		String sql = "";
		Map query_param = new HashMap();
		List rtn_list = new ArrayList();
		try{
			// 게시물 정보를 불러온다
			sql = "abdDAO.getBOARD_Pwd";
			query_param = new HashMap();
			query_param.put("sidx", sidx);
			
			rtn_list = list(sql, query_param);

			if(rtn_list.size() < 1){
				result_map.put("getBdPwd", null);
				result_map.put("TRS_MSG","비밀번호가 정확하지 않습니다.");	

			}else{
				tmp_map = (Map)rtn_list.get(0);
				if(b_passwd.equals((String)tmp_map.get("PASSWD"))){
					result_map.put("getBdPwd", tmp_map);
					result_map.put("TRS_MSG","");

				}else{
					result_map.put("getBdPwd", null);
					result_map.put("TRS_MSG","비밀번호가 정확하지 않습니다.");
				}
			}
			
			
		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("TRS_MSG","비밀번호 조회중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("TRS_MSG","비밀번호 조회중 에러가 발생했습니다");		
		}catch(Exception q){
			log.debug("Exception:");
			result_map.put("TRS_MSG","비밀번호 조회중 에러가 발생했습니다");			
		
		}
		

    	//result_map.put("TRS_MSG","");
    	log.debug("==== getBdPwd End ====");
		return result_map;
	}	
	
}

