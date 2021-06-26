/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ji.dao.cm.mnm;


import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.net.URL;
import java.net.MalformedURLException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import java.security.cert.Certificate;
import java.security.cert.CertificateEncodingException;

import javax.net.ssl.HttpsURLConnection;
import javax.security.cert.CertificateException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.htmlcleaner.CleanerProperties;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.SimpleXmlSerializer;
import org.htmlcleaner.TagNode;
import org.springframework.stereotype.Repository;

import com.ji.dao.cm.CMDAO;
import com.ji.service.CMSService;
import com.ji.util.CmsDsDao;
import com.ji.cm.CM_Util;
import com.ji.common.HtmlTag;
import com.ji.common.JSysException;
import com.ji.common.XmlUtil;

import egovframework.rte.fdl.property.EgovPropertyService;


/**  
 * @Class Name : CmCmMnmDAO.java
 * @Description : CmMnmDAO DAO Class
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

@Repository("cmMnmDAO02")
public class CmMnmDAO02 extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmMnmDAO02.class); //현재 클래스 이름을 Logger에 등록

	/** cmDAO */
    @Resource(name="cmDAO")
    private CMDAO cmDAO;
    
    
    /** cmsService */
    @Resource(name = "cmsService")
    protected CMSService cmsService; 
    
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	

    /**
	 * 메뉴트리를 조회하는 메소드
	 * @param Map
	 * @return 메뉴트리
	 * @exception Exception
	 */
    public Map ctlCMS(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO ctlCMS
		log.debug("==== ctlCMS Start ====");
		Map result_map = new HashMap();
		
		String pstate = HtmlTag.returnString((String)param.get("pstate"),"L");
		
		try{
			
			if(pstate.equals("L")){
				//res_list = list("JiCmMnm.getAlive", param);
				//gridList = cmsService.getGridListScroll(res_list);
				//result_map.put("rows", gridList);
				
				List rtnList = list("JiCmMnm.getAlive",param);
				rtnList = cmsService.getGridListScroll(rtnList);
				result_map.put("rows", rtnList);
				//list("JiCmMnm.getAlive", param);
				
				
				
			}else if(pstate.equals("U")){
				log.debug("==== ctlCMS Start U ====");

				result_map = updateAliveYN (param);
				
			}else if(pstate.equals("UT")){
				log.debug("==== ctlCMS Start UT ====");
				
				
				result_map = testAliveYN (param);
							
		
			}else if(pstate.equals("L2")){
				//외부접속구분
				result_map.put("stconn_type",cmDAO.bizMakeOptionList("000410", "")); 
				
			}else if(pstate.equals("X2")){	
				result_map = cmDAO.selectListGrid(param, "JiCmMnm.getWebProxy");
				
			}else if(pstate.equals("C2")){	
				result_map = updateWebProxy (param);				
				
			}else{
				
			}

		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> :  ");	
			throw q;		
		}catch(NullPointerException q){
			log.debug("ctlCMS NullPointerException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다..
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ctlCMS ArrayIndexOutOfBoundsException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}catch(MalformedURLException q){
			log.debug("ctlCMS MalformedURLException:");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> :  ");	
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
    }
    
    
    
	/**
	* <p> 링크상태를 체크해서 상태값을 업데이트하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  링크Alive 조회결과값을 리턴한다
	* @throws  
	*/
	public Map updateAliveYN (Map param) throws JSysException, Exception {
		//	TODO selectListMenuTree
		log.debug("==== updateAliveYN Start ====");
		
		Map result_map = new HashMap();
		List res_list = new ArrayList();
		Map tmp_map = new HashMap();
		
		try{
		
			HttpURLConnection conn;
			int responseCode = 0;
			URL url;
			
			int i = 0;
			String menu_cd = "";
			String linkPath = "";
			String webtobUrl = "";
			
			res_list = list("JiCmMnm.getAlive", param);
			
			for(i=0;i<res_list.size();i++){
				tmp_map = (Map)res_list.get(i);
				linkPath = HtmlTag.returnString((String)tmp_map.get("linkPath"),"");
				menu_cd = HtmlTag.returnString((String)tmp_map.get("menuCd"),"");
				webtobUrl = HtmlTag.returnString((String)tmp_map.get("webtobUrl"),"");
				param.put("menu_cd", menu_cd);
	
				try{
					// 개발서버에서 처리할경우
					//url = new URL(linkPath.replaceAll("&amp;", "&"));
					// 운영서버에서 처리할경우
					url = new URL(webtobUrl.replaceAll("&amp;", "&"));
					conn = (HttpURLConnection)url.openConnection();
					conn.setConnectTimeout(15000);
					
					//응답코드 구하기
					responseCode = conn.getResponseCode();
					conn.disconnect();
					
					
					if(responseCode == 200){
						param.put("alive_yn", "Y");
					}else if(responseCode >= 300 && responseCode <= 499){
						param.put("alive_yn", "N");
					}else if(responseCode == 503 && linkPath.indexOf("https://") > -1){
						param.put("alive_yn", "Y");						
					}else{
						param.put("alive_yn", "N");
					}
	
					update("JiCmMnm.updateAliveYN", param);
					log.debug(i+"번째 responseCode ===== "+responseCode+" linkPath===== "+linkPath.replaceAll("&amp;", "&"));
	
					
				}catch(IOException q){
					log.debug("updateAliveYN https IOException >>>>> : ");
					
				}catch(Exception q){
					log.debug("updateAliveYN https Exception >>>>> : ");
	
				}
				
				
			}
			
	/*        
	  		url = new URL("https://www.komipo.co.kr/kor/content/36/main.do?mnCd=FN021109");
	        HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setConnectTimeout(3000);
			con.setReadTimeout(3000);
	        //System.out.println("Response Code : " + con.getResponseCode());
	        //System.out.println("Cipher Suite : " + con.getCipherSuite());
	        //System.out.println("\n");
	        Certificate[] certs = con.getServerCertificates();
	        for (Certificate cert : certs) {
	            javax.security.cert.X509Certificate c = javax.security.cert.X509Certificate.getInstance(cert.getEncoded());
	            System.out.println("\tCert Dn : " + c.getSubjectDN());
	            System.out.println("\tIssuer Dn : " + c.getIssuerDN());
	            System.out.println("\n");
	        }
	        con.disconnect();
	*/
			
	        
			result_map.put("result", true);
		
		}catch(JSysException q){	
			log.debug("ctlCMS throw JSysException >>>>> : ");
			result_map.put("TRS_MSG", "에러가 발생하였습니다.");
			throw q;		
			
		}catch(Exception q){
			log.debug("ctlCMS Exception >>>>> : ");
			result_map.put("TRS_MSG", "에러가 발생하였습니다.");
			throw new JSysException(super.getMessage("ji.cm.common.msg.error.syntax"),q);		//구문오류가 발생하였습니다.
	
		}
		
    	log.debug("==== ctlCMS End ====");
		return result_map;
		
	}
	
	/**
	* <p> 링크상태를 체크해서 상태값을 업데이트하는 메소드</p>
	* Precondition : param에 해당 파라메터가 들어 있어야한다 
	* 				 쿼리가 정의되어야한다
	* Postcondition: 조회한 결과 리스트를 받아서 리턴한다
	*
	* @param   param		Map		파라메터
	*
	* @return  링크Alive 조회결과값을 리턴한다
	* @throws  
	*/
	public Map testAliveYN (Map param) throws JSysException, Exception {
		//	TODO testAliveYN
		log.debug("==== testAliveYN Start ====");
		
		Map result_map = new HashMap();
		List res_list = new ArrayList();
		Map tmp_map = new HashMap();
		HttpURLConnection conn;
		int responseCode = 0;
		URL url;
		

		//String linkPath="https://www.kpx.or.kr/www/selectBbsNttList.do?key=21&bbsNo=149";
		//String linkPath="http://www.kpx.or.kr/www/contents.do?key=223";
		//String linkPath="http://125.136.62.141/www/contents.do?key=223";		
		//String linkPath="http://211.179.209.191";
		//String linkPath="http://home.kepco.co.kr:9909/";
		//String linkPath="http://168.78.204.197:11027/";
		String linkPath="http://168.78.204.197:11028/";
		String resultUrlStr = "";
		//String linkPath="http://localhost:7800/manager/WNRun.do?target=common&query=1&convert=fw&charset=utf-8&datatype=json";
		try{
		
			String serverip = "168.78.204.197";
			int serverport = 11028;	
			//SftpUtil sftputil = new SftpUtil("ewpfmsrly", serverip, serverport, "ewpfms0518#$%");
			Socket server= new Socket(serverip, serverport);	

			//sftputil.connect();
			//sftputil.upload("D:/workspace/ewpfmscms/upfiles/000051/20180515/20180515134317_000051_0.jpg", "/000051/");
			//if(sftputil!=null){
			//	sftputil.disconnect();
			//}
			log.debug("Server Conn Test serverip:"+serverip+":::serverport:"+serverport+"::::server:"+server);
			if(server!=null){
				server.close();
			}	
			
			linkPath="http://168.78.204.197:11028/www/selectBbsNttList.do?key=21&bbsNo=149";// https url
			resultUrlStr = XmlUtil.getXmlDocuStringHttps(linkPath, "utf-8");
				log.debug("HTTPS 111111 response result ===== "+resultUrlStr+" ");	
			linkPath="http://168.78.204.197:11028/www/selectBbsNttList.do?key=21&bbsNo=149";// https url
			resultUrlStr = XmlUtil.getHttpsCertNone(linkPath);	
				log.debug("HTTPS 222222 response result ===== "+resultUrlStr+" ");	
			// HTTPS로 호출하면 안됨
			//linkPath="https://168.78.204.197:11028/www/selectBbsNttList.do?key=21&bbsNo=149";// https url
			//	resultUrlStr = XmlUtil.getHttpsCertNone(linkPath);	
			//	log.debug("HTTPS 333333 response result ===== "+resultUrlStr+" ");					

			linkPath="http://168.78.204.197:11027/";// http url
				url = new URL(linkPath.replaceAll("&amp;", "&"));
				conn = (HttpURLConnection)url.openConnection();
				conn.setConnectTimeout(15000);
				
				//응답코드 구하기
				responseCode = conn.getResponseCode();
				conn.disconnect();

				log.debug("HTTP responseCode ===== "+responseCode+" linkPath===== "+linkPath.replaceAll("&amp;", "&"));

			linkPath="http://168.78.204.197:11028/www/selectBbsNttList.do?key=21&bbsNo=149";// https url
				url = new URL(linkPath.replaceAll("&amp;", "&"));
				conn = (HttpURLConnection)url.openConnection();
				conn.setConnectTimeout(15000);
				
				//응답코드 구하기
				responseCode = conn.getResponseCode();
				conn.disconnect();

				log.debug("HTTP responseCode ===== "+responseCode+" linkPath===== "+linkPath.replaceAll("&amp;", "&"));				
			
			/*HtmlCleaner cleaner = new HtmlCleaner();
			CleanerProperties props = cleaner.getProperties();
			TagNode node = null;
			props.setOmitComments(true);		
			
			try {					
//				node = cleaner.clean(new URL("http://eis.kpx.or.kr/kpxmembers.php"));
//				node = cleaner.clean(new URL("http://home.kepco.co.kr:11020/kpxmembers.php"));
				//node = cleaner.clean(new URL("http://168.78.204.197:11020/kpxmembers.php"));
				node = cleaner.clean(new URL("http://168.78.204.197:11028/www/selectBbsNttList.do?key=21&bbsNo=149"));
				
//				node = cleaner.clean(new URL("http://localhost:7800/manager/WNRun.do?target=common&query=1&convert=fw&charset=utf-8&datatype=json"));				
			}catch(Exception q){
				result_map.put("TRS_MSG", "에러가 발생하였습니다.00"+ "::");
				result_map.put("result", false);
			}	
			
			SimpleXmlSerializer se = new SimpleXmlSerializer(props);		
			
			String xml = new String("");
			try {						
				xml = se.getAsString(node,  "UTF-8", false);				
			} catch(IOException e) {
				logger.error(e);
			}	
			log.debug("testAliveYN xml : " + xml);	
			*/		

			result_map.put("result", true);
			result_map.put("TRS_MSG", "");
		}catch(IOException q){
			log.debug("testAliveYN UT https IOException >>>>> : "+q);
			result_map.put("TRS_MSG", "에러가 발생하였습니다.11"+" responseCode ===== "+responseCode+" linkPath===== "+linkPath.replaceAll("&amp;", "&")+"::");
			result_map.put("result", false);
		}catch(Exception q){
			log.debug("testAliveYN UT https Exception >>>>> : "+q);
			result_map.put("TRS_MSG", "에러가 발생하였습니다.12"+" responseCode ===== "+responseCode+" linkPath===== "+linkPath.replaceAll("&amp;", "&")+"::");
			result_map.put("result", false);
		}	
		

		

		
    	log.debug("==== testAliveYN End ====");
		return result_map;
		
	}	
	
	/**
	* <p> ctlCMS(메인Dao컨트롤클래스)에서 해당데이터를 등록하는 메소드</p>
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
	// TODO : updateWebProxy
	public Map updateWebProxy(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== updateWebProxy : START ====");
		Map result_map = new HashMap();
		
	    Map SITE_ADM_SESSION		= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
	    String USER_ID			= HtmlTag.StripStrInXss(HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),""));
	    // 그리드 삭제정보
	    String delkey		= HtmlTag.StripStrInXss(HtmlTag.returnString((String)param.get("delkey"),""));
	    String [] delkey_sp = new String[0];
	    int i = 0;
	    JSONArray jsonArray;
	    Map jsonObjmap = new HashMap();
	    Map tmp_map = new HashMap();
	    Map rtn_map = new HashMap();
	    Iterator iterator;

		String sql = "JiCmMnm.insertWebProxy";	

		int JIT9165_SQ = 0;

		try{
			// 등록자 id 셋팅
			param.put("user_id", USER_ID);

			// 삭제정보가 있을경우
			if(!delkey.equals("")){
				delkey_sp = delkey.split(",");
				sql = "JiCmMnm.deleteWebProxy"; 
				param.put("delkey", delkey);
				param.put("delkey_sp", delkey_sp);
				param.put("user_id", USER_ID);
				update(sql, param);
			}
			
			// WEBPROXY 목록을 저장한다
			jsonArray = JSONArray.fromObject(((String) param.get("JSONDataList")).replaceAll("&amp;quot;", "\""));
			
			for(i=0;i<jsonArray.size();i++){
				jsonObjmap = JSONObject.fromObject(jsonArray.getString(i));
				iterator = jsonObjmap.entrySet().iterator();
			
				  while (iterator.hasNext()) {
					   Entry entry = (Entry)iterator.next();

					   tmp_map.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonObjmap.get(entry.getKey()))); //map 데이터를 그리드 데이터에 맞게 입력
				  }

				  // 등록일경우
				  if(HtmlTag.returnString((String)tmp_map.get("web_proxy_seqno"),"").equals("")){
					  // 등록전에 중복이면 에러 처리한다
					  sql = "JiCmMnm.getWebProxyChk";
					  rtn_map = cmDAO.getformData (tmp_map ,sql);
					  if(Integer.parseInt((String)((Map)rtn_map.get("ViewMap")).get("chkcnt")) > 0){
					
						  throw new JSysException("접속구분, 접속 WEB서버주소, 접속 WEB서버포트가 동일한 데이터는 등록할수 없습니다.");	
					  }
					  
					   sql = "JiCmMnm.insertWebProxy"; 
					  //sequence 추출
					  JIT9165_SQ = cmDAO.getSequence("JIT9165");
					  tmp_map.put("web_proxy_seqno", JIT9165_SQ);
					  tmp_map.put("user_id", USER_ID); 
					  insert(sql, tmp_map);
				  // 수정일경우
				  }else{
					  // 값이 수정된 row만 수정되도록한다.
					  if(HtmlTag.returnString((String)tmp_map.get("row_status"),"").equals("U")){
						  sql = "JiCmMnm.updateWebProxy"; 
						  tmp_map.put("user_id", USER_ID); 
						  insert(sql, tmp_map);						  
					  }

				  }

			}
			
			result_map.put("result", true);
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_SUCCESS"));
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");		

		}catch(NullPointerException q){
			log.debug("NullPointerException:");
			result_map.put("result",false);
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.error("updateWebProxy NullPointerException:"+q);	
			throw q;
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:");
			result_map.put("result",false);
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.error("updateWebProxy ArrayIndexOutOfBoundsException:"+q);	
			throw q;
		}catch(JSysException q){			
			log.debug("JSysException:");	
			log.error("updateWebProxy JSysException:"+q);	
			throw q;
		}catch(Exception q){
			result_map.put("result",false);
			result_map.put(propertiesService.getString("RESULT_URL_R_KEY"),"Y");
			result_map.put(propertiesService.getString("RESULT_STA_KEY"),propertiesService.getString("FORWARD_FAILURE"));			
			log.error("updateWebProxy Exception:"+q);	
			throw new JSysException("등록중에러가 발생했습니다");
		}finally{
			result_map.put(propertiesService.getString("RESULT_URL_T_KEY"),"parent");

		}
		log.debug("==== updateWebProxy : END ====");
		return result_map;	
	}    
}
