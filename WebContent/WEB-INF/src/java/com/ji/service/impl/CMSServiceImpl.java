package com.ji.service.impl;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.JasyptUtil;
import com.ji.common.StringUtil;
/******************** sample START **********************************/ 
import com.ji.dao.JQPLOTDAO;
/******************** 공통 CM START **********************************/  
import com.ji.dao.cm.MADAO;
import com.ji.dao.cm.acs.CmAcsDAO;		// 접근아이피관리
import com.ji.dao.cm.apm.CmApmDAO01;	// 결재업무관리
import com.ji.dao.cm.apm.CmApmDAO02;	// 기본결재선관리
import com.ji.dao.cm.apm.CmApmDAO03;	// 기준정보관리
import com.ji.dao.cm.board.CommonBoardMngDAO;
import com.ji.dao.cm.boi.CmBoiDAO01;	// 기준정보관리
import com.ji.dao.cm.contents.ContentsMngDAO;
import com.ji.dao.cm.mnm.CmMnmDAO01;	// 메뉴관리
import com.ji.dao.cm.mnm.CmMnmDAO02;	// 링크Alive
import com.ji.dao.cm.mtm.CmMtmDAO01;	// 첨부파일관리
import com.ji.dao.cm.oam.CmOamDAO01;	// 조직정보관리
import com.ji.dao.cm.oam.CmOamDAO02;	// 사용자관리
import com.ji.dao.cm.oam.CmOamDAO03;	// 권한그룹관리
import com.ji.dao.cm.oam.CmOamDAO04;	// 로그인, 회원가입, 아이디찾기, 비밀번호찾기
import com.ji.dao.cm.oam.CmOamDAO05;	// 사용자관리
import com.ji.dao.cm.pop.CmPopDAO01;	// 팝업관리

/***************** 공통 CM END ********************/
/********************************* 시스템통계 > 통계 START ****************************/
import com.ji.dao.cm.sta.CmStaDAO; // 관리자 > 통계 > 홈페이지운영실적, 데이터제공요청
import com.ji.dao.cm.sti.SiStiDAO;
/******************************** 시스템통계 > 통계 END *******************************/


/***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 START ******/
import com.ji.dao.mp.msp.MpMspDAO01;// K - shop 중소기업 제품관
import com.ji.dao.mp.msp.MpMspDAO02;// 중부발전 구매담당자
import com.ji.dao.mp.msp.MpMspDAO03;// 중부발전 사업소별 설비분야별담당자
/***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 END ********/

/***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 START *************/
import com.ji.dao.op.opn.OpOpnDAO01; //아이디어 제안사용자
import com.ji.dao.op.opn.OpOpnDAO02; //아이디어 제안관리
/***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 판매통계 END *********/

/***************** 기타 > 회원 ******************************************************/
import com.ji.dao.my.myp.MyMypDAO01; // 회원정보 변경
/***************** 기타 > 회원 ******************************************************/

import com.ji.service.CMSService;
import com.ji.util.Page;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("cmsService")
public class CMSServiceImpl implements CMSService {
	protected Logger log = Logger.getLogger(CMSServiceImpl.class);
	

	/******************** 공통 CM START **********************************/  
                                      
    @Resource(name="maDAO")           
    private MADAO maDAO;			  // 메인
                                      
    @Resource(name="cmMnmDAO01")      
    private CmMnmDAO01 cmMnmDAO01;    // 메뉴관리
                                      
    @Resource(name="cmBoiDAO01")      
    private CmBoiDAO01 cmBoiDAO01;    // 기준정보관리    
                                      
    @Resource(name="cmOamDAO01")      
    private CmOamDAO01 cmOamDAO01;    // 조직정보관리
                                      
    @Resource(name="cmOamDAO02")      
    private CmOamDAO02 cmOamDAO02;    // 관리자관리
                
    @Resource(name="cmOamDAO03")      
    private CmOamDAO03 cmOamDAO03;    // 권한그룹관리
    
    @Resource(name="cmOamDAO04")
    private CmOamDAO04 cmOamDAO04; 	  // 로그인, 회원가입, 아이디찾기, 비밀번호찾기
         
    @Resource(name="cmOamDAO05")
    private CmOamDAO05 cmOamDAO05; 	  // 사용자관리
    
    @Resource(name="siStiDAO")        
    private SiStiDAO siStiDAO;        // 접근통계  
                                
    @Resource(name="cmAcsDAO")        
    private CmAcsDAO cmAcsDAO;        // 접근아이피관리
    
    @Resource(name="cmMtmDAO01")      
    private CmMtmDAO01 cmMtmDAO01;    // 첨부파일관리
                                      
    @Resource(name="cmPopDAO01")      
    private CmPopDAO01 cmPopDAO01;    // 팝업관리
    
 
    @Resource(name="cmMnmDAO02")      
    private CmMnmDAO02 cmMnmDAO02;    // 링크Alive
    
    @Resource(name="cmApmDAO01")
    private CmApmDAO01 cmApmDAO01;   // 결재업무관리
    
    @Resource(name="cmApmDAO02")
    private CmApmDAO02 cmApmDAO02;   // 기본결재선관리
    
    @Resource(name="cmApmDAO03")
    private CmApmDAO03 cmApmDAO03;   // 결재상태관리
    
    @Resource(name="contentsMngDAO")
    private ContentsMngDAO contentsMngDAO; //컨텐츠관리
    
    @Resource(name="commonBoardMngDAO")
    private CommonBoardMngDAO commonBoardMngDAO; //게시물관리
    
    /******************** 공통 CM END **********************************/

 
 
    /******************** sample START **********************************/ 
    @Resource(name="jQPLOTDAO")
    private JQPLOTDAO jQPLOTDAO;  // jqplot 샘플
    
    /******************** sample END **********************************/ 
    

    
    /*************************** 시스템통계 > 통계 START **************************/
    @Resource(name="cmStaDAO")
    private CmStaDAO cmStaDAO;  // 통계 > 홈페이지 운영실적 > 홈페이지 방문
    /*************************** 시스템통계 > 통계 END **************************/
    

    /***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 START ****************/
    @Resource(name="mpMspDAO01")
    private MpMspDAO01 mpMspDAO01; // 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관    
    
    @Resource(name="mpMspDAO02")
    private MpMspDAO02 mpMspDAO02; // 중부발전 구매담당자     
    
    @Resource(name="mpMspDAO03")
    private MpMspDAO03 mpMspDAO03; // 중부발전 사업소별 설비분야별담당자    
 
    /***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 END ****************/   
    
    /***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 START ****************/
    @Resource(name="opOpnDAO01")
    private OpOpnDAO01 opOpnDAO01; // 아이디어 제안 사용자
  
    @Resource(name="opOpnDAO02")
    private OpOpnDAO02 opOpnDAO02; //아이디어 제안관리
    /***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 판매통계 END ******************/   
    
    /***************** 기타 > 회원 ******************************************************/
    @Resource(name="myMypDAO01")
    private MyMypDAO01 myMypDAO01; // 회원정보 변경
    /***************** 기타 > 회원 ******************************************************/    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** jasyptUtil */
    @Resource(name = "jasyptUtil")
    private JasyptUtil JasyptUtil;
   
    //event end
    @Resource(name="txManagerds")
    private PlatformTransactionManager txManagerds;  
    
	// TODO ctlCMS
	@SuppressWarnings("rawtypes")
	@Override
	public Map ctlCMS(Map param, Map MenuCfg) throws JSysException, Exception {
		// TODO Auto-generated method stub
		String dClassName = (String)MenuCfg.get("classPath");
		String classMethod = (String)MenuCfg.get("classMethod");
		Map rtn_map=new HashMap();
		
		DefaultTransactionDefinition txcDefinition = new DefaultTransactionDefinition();
		txcDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus txStatus = txManagerds.getTransaction(txcDefinition);
		log.debug("dClassName:==>"+dClassName);
		log.debug("classMethod:==>"+classMethod);
		
		try{
			/******************** 공통 CM START **********************************/
			String scode = HtmlTag.returnString((String)param.get("scode"),"S01");
			String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
			String pcode = HtmlTag.returnString((String)param.get("pcode"),"main");
	
			if(scode.indexOf("S01") > -1 && pcode.indexOf("main") > -1){	//sample용 
				rtn_map  = maDAO.ctlCMS(param);	
				
			/* 메뉴관리*/
			}else if(dClassName.indexOf("com.ji.dao.cm.mnm.CmMnmDAO01") > -1){
				rtn_map = cmMnmDAO01.ctlCMS(param);	
				
			/* 기준정보관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.boi.CmBoiDAO01") > -1){
				rtn_map = cmBoiDAO01.ctlCMS(param);	
				
			/* 접근아이피관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.acs.CmAcsDAO") > -1){
				rtn_map = cmAcsDAO.ctlCMS(param);	
				
			/* 조직정보관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.oam.CmOamDAO01") > -1){
				rtn_map = cmOamDAO01.ctlCMS(param);	
					
			/* 사용자관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.oam.CmOamDAO02") > -1){
				rtn_map = cmOamDAO02.ctlCMS(param);	
			
			/* 권한그룹관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.oam.CmOamDAO03") > -1){
				rtn_map = cmOamDAO03.ctlCMS(param);	
			
			/* 로그인, 회원가입, 아이디찾기, 비밀번호찾기 */
			}else if(dClassName.indexOf("com.ji.dao.cm.oam.CmOamDAO04") > -1){
				rtn_map = cmOamDAO04.ctlCMS(param);
			
			/* 사용자관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.oam.CmOamDAO05") > -1){
				rtn_map = cmOamDAO05.ctlCMS(param);					
			
			/* 접근통계관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.sti.SiStiDAO") > -1){
				rtn_map = siStiDAO.ctlCMS(param, classMethod);	
			
			/* 첨부파일관리	 */
			}else if(dClassName.indexOf("com.ji.dao.cm.mtm.CmMtmDAO01") > -1){
				rtn_map = cmMtmDAO01.ctlCMS(param);	

			/* 팝업관리		 */
			}else if(dClassName.indexOf("com.ji.dao.cm.pop.CmPopDAO01") > -1){
				rtn_map = cmPopDAO01.ctlCMS(param);
			
			/* 결재업무관리		 */
			}else if(dClassName.indexOf("com.ji.dao.cm.apm.CmApmDAO01") > -1){
				rtn_map = cmApmDAO01.ctlCMS(param);				
			
			/* 기본결재선관리		 */
			}else if(dClassName.indexOf("com.ji.dao.cm.apm.CmApmDAO02") > -1){
				rtn_map = cmApmDAO02.ctlCMS(param);					
			
			/* 결재상태관리		 */
			}else if(dClassName.indexOf("com.ji.dao.cm.apm.CmApmDAO03") > -1){
				rtn_map = cmApmDAO03.ctlCMS(param);		
				
			/* 컨텐츠관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.contents.ContentsMngDAO") > -1){
				rtn_map = contentsMngDAO.ctlCMS(param);		
			
			/* 게시물관리 */
			}else if(dClassName.indexOf("com.ji.dao.cm.board.CommonBoardMngDAO") > -1){
				rtn_map = commonBoardMngDAO.ctlCMS(param);		
				
			/* 링크Alive */
			}else if(dClassName.indexOf("com.ji.dao.cm.mnm.CmMnmDAO02") > -1){
				rtn_map = cmMnmDAO02.ctlCMS(param);	
				

			/******************** 공통관리 CM END **********************************/
			  

			
			/******************** sample START **********************************/
			/* jqplot 샘플 */
			}else if(dClassName.indexOf("com.ji.dao.JQPLOTDAO") > -1){
				rtn_map = jQPLOTDAO.ctlCMS(param);					
			    
		    /******************** sample END **********************************/
				
				

				
				
			/************************************ 시스템통계 s *************************************/	
			/* 홈페이지 방문 */
			}else if(dClassName.indexOf("com.ji.dao.cm.sta.CmStaDAO") > -1){
				
				rtn_map = cmStaDAO.ctlCMS(param); // 관리자 > 통계 > 홈페이지운영실적, 데이터제공요청
			/************************************ 시스템통계 e *************************************/
			
				
	
			/***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 START ****************/
			}else if(dClassName.indexOf("com.ji.dao.mp.msp.MpMspDAO01") > -1){
				
				rtn_map = mpMspDAO01.ctlCMS(param); // 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관    
			}else if(dClassName.indexOf("com.ji.dao.mp.msp.MpMspDAO02") > -1){
				
				rtn_map = mpMspDAO02.ctlCMS(param); // 소통마당 > K - shop 중소기업 제품관 > 중부발전 구매담당자    
				
			}else if(dClassName.indexOf("com.ji.dao.mp.msp.MpMspDAO03") > -1){
				
				rtn_map = mpMspDAO03.ctlCMS(param); // 소통마당 > K - shop 중소기업 제품관 > 사업소별 설비분야별담당자       
   
			/***************** 소통마당 > K - shop 중소기업 제품관 > K - shop 중소기업 제품관 END ****************/
				
			/***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 START ****************/
			}else if(dClassName.indexOf("com.ji.dao.op.opn.OpOpnDAO01") > -1){
				 
				rtn_map = opOpnDAO01.ctlCMS(param); // 아이디어 제안 사용자
			}else if(dClassName.indexOf("com.ji.dao.op.opn.OpOpnDAO02") > -1){
				
				rtn_map = opOpnDAO02.ctlCMS(param); //아이디어 제안관리					
		

			/***************** 소통마당 > 연구개발(R&D)아이디어 제안센터 > 아이디어 제안 판매통계 END ******************/	
				
			/***************** 기타 > 회원 ******************************************************/
			}else if(dClassName.indexOf("com.ji.dao.my.myp.MyMypDAO01") > -1){
				
				rtn_map = myMypDAO01.ctlCMS(param); // 회원정보 변경		
 
			/***************** 기타 > 회원 ******************************************************/				
			}
			
			
			
		}catch(JSysException q){	
			log.debug("throw JSysException >>>>> :  ");	
			txManagerds.rollback(txStatus);
			throw q;	
		}catch(Exception q){				
			log.debug("ctlCMS Exception >>>>> :  ");	
			txManagerds.rollback(txStatus);
			throw q;
		}
		txManagerds.commit(txStatus);
		
		return rtn_map;
	}	
	
	/** 조회된 page 데이터를 그리드 데이터에 맞게 가공*/
	public List getGridList(Page page){
		List gridList = new ArrayList<HashMap<String,Object>>();
		List pageList = page.getList();
		if(pageList!=null){
			for(int i=0; i<pageList.size(); i++){
				Map rtn_row_Map = (Map)(pageList).get(i); //쿼리 data
				Map _m = new HashMap<String,Object>(); //가공된 data
				Iterator iterator = rtn_row_Map.entrySet().iterator();
				  while (iterator.hasNext()) {
				   Entry entry = (Entry)iterator.next();
				   _m.put(entry.getKey().toString().toLowerCase(),rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
				   //log.debug("key: ->"+entry.getKey().toString().toLowerCase()+"| value : ->"+rtn_row_Map.get(entry.getKey()));
				  }
				gridList.add(_m);
			}			
		}

		return gridList;
	}
	
	/** 조회된 page 데이터를 그리드 데이터에 맞게 가공*/
	public List getGridListScroll(List pagelist){
		List gridList = new ArrayList<HashMap<String,Object>>();
		if(pagelist!=null){
			for(int i=0; i<pagelist.size(); i++){
				Map rtn_row_Map = (Map)pagelist.get(i); //쿼리 data
				Map _m = new HashMap<String,Object>(); //가공된 data
				Iterator iterator = rtn_row_Map.entrySet().iterator();
				  while (iterator.hasNext()) {
				   Entry entry = (Entry)iterator.next();
				   // egov map형태의 리턴 데이터를 그리드형식에 맞춰서 변수명을 변환
				   
				   _m.put(StringUtil.egovmapToGrid(entry.getKey().toString()) ,rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
				   //_m.put(entry.getKey().toString().toLowerCase(),rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
				   //log.debug("key: ->"+entry.getKey().toString().toLowerCase()+"| value : ->"+rtn_row_Map.get(entry.getKey()));
				  }
				gridList.add(_m);
			}			
		}

		return gridList;
	}
	
	/** 조회된 page 데이터를 그리드 데이터에 맞게 가공*/
	public List getGridListScrollNotEgov(List pagelist){
		List gridList = new ArrayList<HashMap<String,Object>>();
		for(int i=0; i<pagelist.size(); i++){
			Map rtn_row_Map = (Map)pagelist.get(i); //쿼리 data
			Map _m = new HashMap<String,Object>(); //가공된 data
			Iterator iterator = rtn_row_Map.entrySet().iterator();
			  while (iterator.hasNext()) {
			   Entry entry = (Entry)iterator.next();
			   // egov map형태의 리턴 데이터를 그리드형식에 맞춰서 변수명을 변환
			   
			   _m.put(entry.getKey().toString().toLowerCase() ,rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
			   //_m.put(entry.getKey().toString().toLowerCase(),rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
			   //log.debug("key: ->"+entry.getKey().toString().toLowerCase()+"| value : ->"+rtn_row_Map.get(entry.getKey()));
			  }
			gridList.add(_m);
		}
		return gridList;
	}	
	
	/** 조회된 page 데이터를 암호화 컬럼이 있을경우 복호화후 그리드 데이터에 맞게 가공
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidKeyException */
	public List getGridListScrollDec(List pagelist, String [] dec_col) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
		List gridList = new ArrayList<HashMap<String,Object>>();
		//StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();

        //pbeEnc.setAlgorithm(propertiesService.getString("CMS_ENC_JASYP_AL"));
        //pbeEnc.setPassword(propertiesService.getString("CMS_ENC_JASYP_PW")); // PBE 값(XML PASSWORD설정)
        //log.debug("CMS_ENC_JASYP_AL::"+propertiesService.getString("CMS_ENC_JASYP_AL"));
        //log.debug("CMS_ENC_JASYP_PW::"+propertiesService.getString("CMS_ENC_JASYP_PW"));
        
		for(int i=0; i<pagelist.size(); i++){
			Map rtn_row_Map = (Map)pagelist.get(i); //쿼리 data
			Map _m = new HashMap<String,Object>(); //가공된 data
			Iterator iterator = rtn_row_Map.entrySet().iterator();
			  while (iterator.hasNext()) {
			   Entry entry = (Entry)iterator.next();
			   // egov map형태의 리턴 데이터를 그리드형식에 맞춰서 변수명을 변환
			   // 배열에
			   //log.debug("getGridListScrollDec::entry.getKey():"+entry.getKey()+":::"+StringUtil.searchData(dec_col,(String)entry.getKey()));
			   if(StringUtil.searchData(dec_col,(String)entry.getKey())){
				   //log.debug("getGridListScrollDec::entry.getKey():"+entry.getKey()+":::");
				   //log.debug("getGridListScrollDec::entry.getKey():"+pbeEnc.decrypt((String)rtn_row_Map.get(entry.getKey()))+":::");
				   _m.put(StringUtil.egovmapToGrid(entry.getKey().toString()) ,JasyptUtil.JasyptDecode((String)rtn_row_Map.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
			   }else{
				   _m.put(StringUtil.egovmapToGrid(entry.getKey().toString()) ,rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
			   }
			   
			   //_m.put(entry.getKey().toString().toLowerCase(),rtn_row_Map.get(entry.getKey())); //map 데이터를 그리드 데이터에 맞게 입력
			   //log.debug("key: ->"+entry.getKey().toString().toLowerCase()+"| value : ->"+rtn_row_Map.get(entry.getKey()));
			  }
			gridList.add(_m);
		}
		return gridList;
	}	
	

}
	
