package com.ji.dao.my.myp;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.ss.examples.formula.SettingExternalFunction.BloombergAddIn;
import org.springframework.stereotype.Repository;

import com.ji.cm.CM_Util;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.dao.cm.CMDAO;
import com.ji.dao.cm.mtm.CmMtmDAO01;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;

import egovframework.rte.fdl.property.EgovPropertyService;


/** 
 * My Page
 * @author maging
 * @since  2018. 4. 6.
 * @see    MyMypDAO01
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *     수정일                         수정자              수정내용
 *  ------------       --------    ---------------------------
 *  2018. 4. 6.     	    maging       최초생성
 *  
 * </pre>
 * 
*/
@Repository("myMypDAO01")
public class MyMypDAO01 extends CmsDsDao {
	
	protected Logger log = Logger.getLogger(MyMypDAO01.class); //현재 클래스 이름을 Logger에 등록
	
	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    @Resource(name="cmMtmDAO01")
    private CmMtmDAO01 cmMtmDAO01;
    
    
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
     *  My Page 정보를 처리한다.
     * @author maging
     * @since 2018. 3. 30.
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
    	
    	log.debug("==== MyMypDAO01 ctlCMS Start ====");
		Map result_map = new HashMap();
		Map temp_map 	= new HashMap();
		Map codeparam = new HashMap();
		codeparam.put("use_yn", "Y");
		codeparam.put("notinstr", "");
		codeparam.put("inout_fl", "");
		
		
		// 총 갯수
		int totalCnt = 0;
		Map SITE_SESSION = (Map)param.get(propertiesService.getString("SITE_SESSION_FN"));
		

		
		String pstate 	= HtmlTag.returnString((String)param.get("pstate"),"L");
		String page 	= HtmlTag.returnString((String)param.get("page"),"1");
				
		try{
			
			if(SITE_SESSION != null){
		    	param.put("user_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
		    	param.put("my_reg_id", HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_SESSION.get("USER_ID"),"")));
		    }else{
		    	throw new JSysException(super.getMessage("ji.cm.common.msg.error.login.notauth"));
		    }
			
			log.debug("pstate==>"+pstate);
			/*
			 * L	:	회원정보
			 * U	:	회원정보 수정 
			 * DUSER:	회원탈퇴
			 */
			if(pstate.equals("L")){
				
				// 사용자정보
				param.put("file_menu_cd", "000138");
				temp_map = (Map)select("JiMyMyp.selectUserInfo", param);
				result_map.put("myMypDtl", temp_map);

				
				// 일반전화번호
				codeparam.put("all_fl", "M00008");
				result_map.put("m00008List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 핸드폰
				codeparam.put("all_fl", "M00009");
				result_map.put("m00009List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 이메일
				codeparam.put("all_fl", "M00004");
				result_map.put("m00004List", cmDAO.getCode_Select (codeparam).get("ListTreeACD"));
				
				// 첨부파일 목록
				String user_seqno = HtmlTag.StripStrInXss(HtmlTag.returnString(temp_map.get("userSeqno").toString()));
				param.put("user_seqno", user_seqno);
				result_map.put("fileList", list("JiMyMyp.selectFileList", param));	
				
				//첨부파일 세팅
				String file_seqno = CM_Util.nullToEmpty((String)temp_map.get("fileSeq"));
				String file_nm = CM_Util.nullToEmpty((String)temp_map.get("fileNms"));
				result_map.put("file_group_htmlarray", cmMtmDAO01.getFileHtmlArray(file_seqno, file_nm));
				//log.debug("==== MyMypDAO01 ctlCMS Start temp_map ===="+temp_map);
				//log.debug("==== MyMypDAO01 ctlCMS Start ===="+file_seqno+" === "+file_nm);
				//log.debug("==== MyMypDAO01 ctlCMS Start ===="+cmMtmDAO01.getFileHtmlArray(file_seqno, file_nm));
				
			}else if(pstate.equals("U")){
				
				// 패스워드 체크
		    	String password = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("password"),""));
		    	//비밀번호가 입력되어있으면 암호화한다
		    	if(!password.equals("")){
		    		// db암호화로 변경
					//param.put("login_passwd", JasyptUtil.encSHA256(password));
		    		param.put("login_passwd", password);

				}
		    	
		    	//패스워드 정규식체크 
		    	String pwdPattern = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]{9,12}$";
		    	boolean pwdCheck = Pattern.matches(pwdPattern, password);
		    	
		    	if(!pwdCheck){
		    		throw new JSysException("비밀번호는 영문,숫자,특수문자 조합으로 9~12자리로 사용해야합니다.");
		    	}
				
		    	// 회원정보 수정
//				if("1".equals(temp_map.get("cnt").toString())){
					
					int result = update("JiMyMyp.updateUserInfo", param);
					String user_seqno = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("user_seqno")));
					String imenu_data_title = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("grp_nm"))); //기관명
					
					//첨부파일 등록
					param.put("rpcode", "000138");
					param.put("ikey_datas", user_seqno);
					param.put("imenu_data_title", "[회원정보]"+imenu_data_title);
					param.put("iuploadseq", "");
					cmMtmDAO01.InsertFile(param); //첨부파일 등록 실행					
					
					if(result > 0){
						result_map.put("result", true);
						result_map.put("TRS_MSG", "수정되었습니다.");
					}
					
//				}else{
//					result_map.put("result", false);
//					result_map.put("TRS_MSG", "패스워드를 확인해주세요.");
//				}
			}else if(pstate.equals("DUSER")){
				
				int result = delete("JiMyMyp.deleteUserWithdraw", param);
				String user_seqno = HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("user_seqno")));
				log.debug("DUSER result==>"+result);
				param.put("rpcode", "000138");
				param.put("ikey_datas", user_seqno);	
				param.put("iuploadseq", "");
				cmMtmDAO01.deleteFileGroup(param);
				log.debug("DUSER deleteFileGroup==>");
				if(result > 0){
					result_map.put("result", true);
					result_map.put("TRS_MSG", "회원탈퇴 되었습니다.");
				}else{
					result_map.put("result", false);
					result_map.put("TRS_MSG", "회원탈퇴 중 오류가 발생했습니다.");					
				}
			}
			
			result_map.put("param", param);
			
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  "+q);	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
		log.debug("==== MyMypDAO01 ctlCMS End ====");
		
		return result_map;
		
    }
}
