/*===================================================================================
 * System             : Jrinfo Library 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.XmlUtil.java
 * Description        : XML처리에 관련된 다수의 기능을 제공하는 클래스.
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : 이금용
 * Updated content    : 패키지명 변경
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.InputSource;
import org.apache.log4j.Logger;
import org.w3c.dom.*;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;





/**
 * XmlUtil
 *     
 */
 
public class XmlUtil {
	protected static Logger log = Logger.getLogger(StringUtil.class); //현재 클래스 이름을 Logger에 등록
 
    /**
     * Xml SAX Document 객체를 리턴한다
     */
    public static Document getXmlDocu(String url) throws NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
    	Document doc = null;
    	InputStreamReader isr = null;
    	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    	DocumentBuilder b = null;
    	try{
    		
 
			URL g_url = new URL(url);
			isr = new InputStreamReader(g_url.openStream(),"utf-8");
	
			StringBuffer sb = new StringBuffer(); 
		      int c;
		      while ((c = isr.read()) != -1) {sb.append((char) c);}
		     
	
		      
		      b = factory.newDocumentBuilder();
		      //System.out.println("getXmlDocu:"+sb.toString());
		      
		      doc = b.parse(new InputSource(new StringReader(sb.toString())));
		}catch(NullPointerException q){	
			throw new JSysException("getXmlDocu NullPointerException:");
		}catch(ArrayIndexOutOfBoundsException q){	
			throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");
		}catch(Exception q){
			throw new JSysException("getXmlDocu Exception:");
		}finally{
			
			try {
				
				if(isr!=null){isr.close();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return doc;
    }
 
    /**
     * Xml DOM Document 객체를 리턴한다
     */
    public static String getXmlDocuString(String url) throws NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
    	String rt_str="";
    	InputStreamReader isr = null;
    	ByteArrayInputStream is = null;
    	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    	DocumentBuilder b = null;    			
    	try{
    		
 
			URL g_url = new URL(url);
			isr = new InputStreamReader(g_url.openStream(),"utf-8");
	
			StringBuffer sb = new StringBuffer(); 
		      int c;
		      while ((c = isr.read()) != -1) {sb.append((char) c);}

	
		      is = new ByteArrayInputStream(sb.toString().getBytes("utf-8"));
		      factory = DocumentBuilderFactory.newInstance();
		      b = factory.newDocumentBuilder();

		      
		      rt_str = sb.toString();
		}catch(NullPointerException q){	
			throw new JSysException("getXmlDocu NullPointerException:");
		}catch(ArrayIndexOutOfBoundsException q){	
			throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");
		}catch(Exception q){
			throw new JSysException("getXmlDocu Exception:");
		}finally{
			
			try {
				if(is!=null){is.close();}
				if(isr!=null){isr.close();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return rt_str;
    }
    
    /**
     * Xml DOM Document 접속인코딩 셋팅
     */
    public static String getXmlDocuString(String url, String encode_str) throws NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
    	String rt_str="";
    	InputStreamReader isr = null;
    	try{
    		
 
			URL g_url = new URL(url);
			isr = new InputStreamReader(g_url.openStream(),encode_str);
	
			StringBuffer sb = new StringBuffer(); 
		      int c;
		      while ((c = isr.read()) != -1) {sb.append((char) c);}
		     
	
	      
		      rt_str = sb.toString();
		}catch(NullPointerException q){
			throw new JSysException("getXmlDocu NullPointerException:");		
		}catch(ArrayIndexOutOfBoundsException q){
			throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");		
		}catch(Exception q){
			throw new JSysException("getXmlDocu Exception:");
		}finally{
			
			try {

				if(isr!=null){isr.close();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return rt_str;
    }  
    
    /**
     * Xml DOM Document 접속인코딩 셋팅
     */
    public static String getXmlDocuStringHttps(String url, String encode_str) throws NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
    	String rt_str="";

    	HttpsURLConnection conn = null;
    	InputStream in = null;
    	BufferedReader reader = null;
    	try{
    		
    		StringBuffer sb = new StringBuffer(); 
			URL g_url = new URL(url);

			conn = (HttpsURLConnection)g_url.openConnection(); 
			conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // https를 호출시 user-agent 필요
			// Set Hostname verification
		     // Set Hostname verification
		     conn.setHostnameVerifier(new HostnameVerifier() {
		      @Override
		      public boolean verify(String hostname, SSLSession session) {
		       // Ignore host name verification. It always returns true.
		       return true;
		      }
		      
		     });
			  
			  // SSL setting
			  SSLContext context = SSLContext.getInstance("TLS");
			  context.init(null, null, null);  // No validation for now
			  conn.setSSLSocketFactory(context.getSocketFactory());
			  
			  // Connect to host
			  conn.connect();
			  conn.setInstanceFollowRedirects(true);
			  
			  // Print response from host
			  in = conn.getInputStream();
			  reader = new BufferedReader(new InputStreamReader(in));
			  String line = null;
			  while ((line = reader.readLine()) != null) {
			   //System.out.printf("%s\n", line);
			   sb.append(line);
			  }
      
		      rt_str = sb.toString();
		}catch(NullPointerException q){
			log.error("NullPointerException:"+q);
			//throw new JSysException("getXmlDocu NullPointerException:");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:"+q);
			//throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");		
		}catch(Exception q){
			log.error("Exception:"+q);
			//throw new JSysException("getXmlDocu Exception:");
		}finally{
			
			try {
				if(in!=null){in.close();}
				if(reader!=null){reader.close();}
				if(conn!=null){conn.disconnect();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return rt_str;
    }     

    /**
     * Xml DOM Document 객체를 리턴한다
     * @throws IOException 
     */
    public static String getXmlDocuPost(String url, String incharset, String outcharset, String xmlpa2) throws JSysException, IOException {
    	String rt_str="";
    	URL g_url = null;
    	HttpURLConnection hcon = null;
    	OutputStreamWriter sw = null;
    	InputStreamReader isr = null;
    	try{
    		
 
			g_url = new URL(url);
			hcon = (HttpURLConnection)g_url.openConnection();
			if(hcon != null){
				hcon.setConnectTimeout(3000);
				hcon.setRequestMethod("POST");
				hcon.setDoOutput(true);
				//hcon.setRequestProperty("Accept-Charset", charset); 
				//hcon.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				//hcon.setInstanceFollowRedirects(false);

				// Make Body Data
				
				String body = URLEncoder.encode("pa1", incharset) + "=";
				body += "&" + URLEncoder.encode("pa2", incharset) + "=" + URLEncoder.encode(xmlpa2, incharset);
				//String body = "pa1" + "=";
				//body += "&" + "pa2" + "=" + xmlpa2;
				
				sw = new OutputStreamWriter(hcon.getOutputStream());
				sw.write(body);
				sw.flush();
				
				
				isr = new InputStreamReader(hcon.getInputStream(),outcharset);
		
				StringBuffer sb = new StringBuffer(); 
			      int c;
			      while ((c = isr.read()) != -1) {sb.append((char) c);}

		
			      //ByteArrayInputStream is = new ByteArrayInputStream(sb.toString().getBytes(outcharset));
			      //DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			      //DocumentBuilder b = factory.newDocumentBuilder();

			      //Document document     =  b.parse(new InputSource(new StringReader(sb.toString())));		
			      
			      rt_str = sb.toString();
			}

		      
		      
		}catch(NullPointerException q){
			
			throw new JSysException("getXmlDocu NullPointerException:");		
		}catch(ArrayIndexOutOfBoundsException q){
				
			throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");		
		}catch(Exception q){
				
			throw new JSysException("getXmlDocu Exception:");

		}finally{
			
			try {
				if(isr!=null){isr.close();}
				if(sw!=null){sw.close();}
				if(hcon!=null){hcon.disconnect();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return rt_str;
    }
    
    /**
     * Xml DOM Document 객체를 리턴한다
     * @throws IOException 
     */
    public static String getXmlDocuPost2(String url, String incharset, String outcharset, String bodystr) throws JSysException, IOException {
    	String rt_str="";
    	URL g_url = null;
    	HttpURLConnection hcon = null;
    	OutputStreamWriter sw = null;
    	InputStreamReader isr = null;    	
    	try{
    		
 
			g_url = new URL(url);
			hcon = (HttpURLConnection)g_url.openConnection();
			if(hcon != null){
				hcon.setConnectTimeout(3000);
				hcon.setRequestMethod("POST");
				hcon.setDoOutput(true);
				//hcon.setRequestProperty("Accept-Charset", charset); 
				//hcon.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				//hcon.setInstanceFollowRedirects(false);

				// Make Body Data
				
				//String body = URLEncoder.encode("pa1", incharset) + "=";
				//body += "&" + URLEncoder.encode("pa2", incharset) + "=" + URLEncoder.encode(xmlpa2, incharset);
				String body = bodystr;
				//String body = "pa1" + "=";
				//body += "&" + "pa2" + "=" + xmlpa2;
				if(!body.equals("")){
					sw = new OutputStreamWriter(hcon.getOutputStream());
					sw.write(body);
					sw.flush();				
				}

				
				
				isr = new InputStreamReader(hcon.getInputStream(),outcharset);
		
				StringBuffer sb = new StringBuffer(); 
			      int c;
			      while ((c = isr.read()) != -1) {sb.append((char) c);}

		
			      //ByteArrayInputStream is = new ByteArrayInputStream(sb.toString().getBytes(outcharset));
			      //DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			      //DocumentBuilder b = factory.newDocumentBuilder();

			      //Document document     =  b.parse(new InputSource(new StringReader(sb.toString())));
			      
			      rt_str = sb.toString();				
			}

		}catch(NullPointerException q){
			
			throw new JSysException("getXmlDocu NullPointerException:");		
		}catch(ArrayIndexOutOfBoundsException q){
				
			throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");		
		}catch(Exception q){
				
			throw new JSysException("getXmlDocu Exception:");

		}finally{
			
			try {
				if(isr!=null){isr.close();}
				if(sw!=null){sw.close();}
				if(hcon!=null){hcon.disconnect();}
			} catch (IOException e) {
				log.error("IOException");
			} 
		}
	      return rt_str;
    }
    
    /**
     * 
     * @param urlString
     * @throws IOException
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */
    public static String getHttps(String urlString) throws IOException, NoSuchAlgorithmException, KeyManagementException {
     
    	String rt_str = "";
    	StringBuffer sb = new StringBuffer(); 
	     // Get HTTPS URL connection
	     URL url = new URL(urlString);  
	     HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
	     InputStream in = null;
	     BufferedReader reader = null;
	     //conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // https를 호출시 user-agent 필요

	     // Set Hostname verification
	     conn.setHostnameVerifier(new HostnameVerifier() {
	      @Override
	      public boolean verify(String hostname, SSLSession session) {
	       // Ignore host name verification. It always returns true.
	       return true;
	      }
	      
	     });
	     
	     // SSL setting
	     SSLContext context = SSLContext.getInstance("TLS");
	     context.init(null, new TrustManager[] { new X509TrustManager() {

	    	 @Override
	    	 public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
	    		 // client certification check
	    	 }
	
	    	 @Override
	    	 public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
	       
	    		 // Server certification check
	       
	    		 	try {
	        
				        // Get trust store
				        KeyStore trustStore = KeyStore.getInstance("JKS");
				        trustStore.load(new FileInputStream("C:/apache-tomcat-7.0.82/conf/tomcat.keystore"), "changeit".toCharArray()); // Use default certification validation
				        
				        // Get Trust Manager
				        TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
				        tmf.init(trustStore);
				        TrustManager[] tms = tmf.getTrustManagers();
				        ((X509TrustManager)tms[0]).checkServerTrusted(chain, authType);
	        
			       } catch (KeyStoreException e) {
			    	   throw new JSysException("XmlUtil.getHttps NullPointerException:");
			       } catch (NoSuchAlgorithmException e) {
			    	   throw new JSysException("XmlUtil.getHttps NullPointerException:");
			       } catch (IOException e) {
			    	   throw new JSysException("XmlUtil.getHttps NullPointerException:");
			       }
	       
	    	 }
	
		      @Override
		      public X509Certificate[] getAcceptedIssuers() {
		       return null;
		      }
	     } }, null);
	     conn.setSSLSocketFactory(context.getSocketFactory());
	     
	     
	     try{
		     // Connect to host
		     conn.connect();
		     conn.setInstanceFollowRedirects(true);
		     String headerType = conn.getContentType();
		     String encodetype = "";
		     if(headerType.toUpperCase().indexOf("EUC-KR") != -1){
		    	 encodetype = "euc-kr";
		     }else if(headerType.toUpperCase().indexOf("UTF-8") != -1){
		    	 encodetype = "utf-8";
		     }

		     // Print response from host
		     in = conn.getInputStream();
		     //InputStreamReader isr = new InputStreamReader(url.openStream(),encodetype);
		     reader = new BufferedReader(new InputStreamReader(in, encodetype));
		     //BufferedReader reader = new BufferedReader(isr);
		     String line = null;
			  while ((line = reader.readLine()) != null) {
			   //System.out.printf("%s\n", line);
			   sb.append(line);
			  }
			  
			  reader.close();
			  conn.disconnect();
		 
		     rt_str = sb.toString();	    	 
			}catch(NullPointerException q){
				
				throw new JSysException("getXmlDocu NullPointerException:");		
			}catch(ArrayIndexOutOfBoundsException q){
					
				throw new JSysException("getXmlDocu ArrayIndexOutOfBoundsException:");		
			}catch(Exception q){
					
				throw new JSysException("getXmlDocu Exception:");

			}finally{
				
				try {
					if(in!=null){in.close();}
					if(reader!=null){reader.close();}
					if(conn!=null){conn.disconnect();}
				} catch (IOException e) {
					log.error("IOException");
				} 
			}

	     return rt_str;
    }
    
    /**
     * 
     * @param urlString
     * @throws IOException
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */
    public static String getHttpsCertNone(String urlString)  {
     
    	String rt_str = "";
    	StringBuffer sb = new StringBuffer();
    	InputStreamReader in = null;
    	BufferedReader br = null;
    	HttpURLConnection conn = null;
    	try { 
    		
    		trustAllHttpsCertificates();            
  
    		URL url = new URL(urlString); 
    		conn = (HttpURLConnection) url.openConnection();
            //conn.setUseCaches(true);            
            //conn.setInstanceFollowRedirects(false);
            //conn.setRequestMethod("POST");
            //conn.setRequestProperty("Content-Type", "text/xml;charset=EUC-KR");
	   	     conn.setInstanceFollowRedirects(true);
	   	     
	   	     if(conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
		   	     String headerType = conn.getContentType();
		   	     String encodetype = "";
		   	     if(headerType.toUpperCase().indexOf("EUC-KR") != -1){
		   	    	 encodetype = "euc-kr";
		   	     }else if(headerType.toUpperCase().indexOf("UTF-8") != -1){
		   	    	 encodetype = "utf-8";
		   	     }            
	            
	    		in = new InputStreamReader( (InputStream) conn.getContent(),encodetype);
	    		
	    		br = new BufferedReader(in); 
	    		String line; 
	    		
	    		while ((line = br.readLine()) != null) {
	    			sb.append(line).append("\n"); 
	    		} 
	    		
	    		//System.out.println(sb.toString()); 
	    		br.close(); 
	    		in.close(); 
	    		conn.disconnect();
	    		rt_str = sb.toString();	   	    	 
	   	     }else{
	   	    	rt_str = rt_str+"::getResponseCode:"+conn.getResponseCode();
	   	     }
 	   } catch(NullPointerException e){
 		   rt_str = rt_str+":NullPointerException::";
		   

	   } catch(ArrayIndexOutOfBoundsException e){
		   rt_str = rt_str+":ArrayIndexOutOfBoundsException::";
		   
		   
    	} catch (Exception e) { 
    		rt_str = rt_str+":Exception::";
    	} finally{
    		
				try {
					if(br!=null)br.close();
		    		if(in!=null)in.close(); 
		    		if(conn!=null)conn.disconnect(); 					
				} catch (IOException e) {
					rt_str = rt_str+":Exception::";
				} 
   		
    	}
	     
	     return rt_str;
    } 
    
    private static void trustAllHttpsCertificates() throws Exception {
    	TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return null;
            }

            @Override
            public void checkClientTrusted(
                    java.security.cert.X509Certificate[] arg0,
                    String arg1) throws CertificateException {
                // TODO Auto-generated method stub
            }
            @Override
            public void checkServerTrusted(
                    java.security.cert.X509Certificate[] arg0,
                    String arg1) throws CertificateException {
                // TODO Auto-generated method stub
            }
        } };

        javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("TLS");
        sc.init(null, trustAllCerts, null);
        javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
  	      @Override
  	      public boolean verify(String hostname, SSLSession session) {
  	       // Ignore host name verification. It always returns true.
  	       return true;
  	      }
  	      
  	     });
    }

    
    /*
     * 없으면 SAP서버에 다시 입력해준다
     * 웹상에서 결의서 버튼을 클릭해서 호출한경우 해당 parameter를 받아서 입력처리를 한다
     * 
     */
    // TODO : Hr30Chk_Sapin()
	/*public static String[] Hr30Chk_Sapin(Map param) throws Exception {
		//DateUtility.sysLogMessage("==== Hr30Chk_Sapin() Start ====");
		int ret_cnt = 0;
		List result_list_gw= new ArrayList();
		Map result_tmp_map_gw = new HashMap();
    	// SAP DI 서버에 연결한다
		String url = "http://xmlurl";
		String incharset = "UTF-8";
		String outcharset = "UTF-8";
		String xmlpa2 = (String)param.get("xmlpa2");
		String ret_msg = "";
		String [] ret_msg_arr = new String[3]; 
        // SAP MSSQL 서버에 연결한다
    	//DBHelper DbHelperSap = new DBHelper(DSSAP);
    	
    	try{
    		String doc_xml = XmlUtil.getXmlDocuPost(url, incharset,outcharset, xmlpa2);
    		//doc_xml = new String(doc_xml.getBytes("utf-16"),"8859_1");//KSC5601
    		if(!doc_xml.equals("")){
	    		DateUtility.sysLogMessage("Hr30Chk_Sapin() DI RETURN:"+doc_xml);
			    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			    DocumentBuilder b = factory.newDocumentBuilder();    		
	    		Document document     =  b.parse(new InputSource(new StringReader(doc_xml)));
	    		//document.getElementsByTagName(tagname)
	    		
	    		//NodeList nodelist     =  document.getElementsByTagName("string");
	    		Element root = document.getDocumentElement();
	    		//DateUtility.sysLogMessage("Hr30Chk_Sapin() DI RETURN nodelist:"+nodelist.getLength());
	    		//Node node       	  =  nodelist.item(0);//첫번째 element 얻기
	    		//Node textNode      	  =  nodelist.item(0).getChildNodes().item(0);
	    		ret_msg = root.getTextContent();
	    		
	    		DateUtility.sysLogMessage("Hr30Chk_Sapin() DI RETURN ret_msg:"+ret_msg);
	    		//   String charset[] = {"KSC5601","8859_1", "ascii", "UTF-8", "EUC-KR", "MS949"};
	
	    		   
	    		//   for(int i=0; i<charset.length ; i++){
	    		//       for(int j=0 ; j<charset.length ; j++){
	    		//           if(i==j){ continue;}
	    		//           else{
	    		//        	   DateUtility.sysLogMessage("Hr30Chk_Sapin() DI RETURN ret_msg:"+charset[i]+" : "+charset[j]+" :"+new String(ret_msg.getBytes(charset[i]),charset[j]));
	    		//               
	    		//           }
	    		//       }
	    		//   }     		
	    		
	    		ret_msg_arr = HtmlText.split(ret_msg, "/");
	    		//DateUtility.sysLogMessage("Hr30Chk_Sapin():ret_msg_arr[0]"+ret_msg_arr[0]);
	    		//DateUtility.sysLogMessage("Hr30Chk_Sapin():ret_msg_arr[1]"+ret_msg_arr[1]);
	    		//DateUtility.sysLogMessage("Hr30Chk_Sapin():ret_msg_arr[2]"+Unicode.decode(ret_msg_arr[2]));
				// SAP쪽 연계를 마무리하고 결과값을 저장한다
				ret_cnt = 1;
    		}else{
        		ret_msg_arr[0] = "N";
        		ret_msg_arr[1] = "0";
        		ret_msg_arr[2] = "SAP DI SERVER CONNECT FAIL";
        		ret_cnt = 0;    			
    		}
    	}catch(Exception e){
    		ret_msg_arr[0] = "N";
    		ret_msg_arr[1] = "0";
    		ret_msg_arr[2] = "";
    		ret_cnt = 0;
    		DateUtility.sysLogMessage("Hr30Chk_Sapin():");
    		//throw new JSysException("Hr30Chk():");
		}finally{
			//DbHelperSap.closeConnection();
			//company.disconnect();
			DateUtility.sysLogMessage("==== Hr30Chk_Sapin() End ====");
		}		
		return ret_msg_arr;
	} */   

}
