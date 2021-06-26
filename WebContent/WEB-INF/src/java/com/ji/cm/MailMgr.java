/*===================================================================================
 * System             : 유틸리티 시스템
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.jrcms.cm.MailMgr
 * Description        : 메일과  관련된 다수의 기능을 제공하는 클래스.
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2006-10-23
 * Updated Date       : 2006-10-23
 * Last modifier      : 이금용
 * Updated content    : 
 * License            : 
 *==================================================================================*/
package com.ji.cm;


import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import javax.mail.internet.MimeUtility;
import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("mailMgr")
public class MailMgr implements Serializable {
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;		
	/**
	 * 현재 클래스에 대한 로그를 처리하는 변수
	 *
	 * @see org.apache.commons.logging.Log
	 * @see org.apache.commons.logging.LogFactory
	 */
    protected Logger log = Logger.getLogger(MailMgr.class); //현재 클래스 이름을 Logger에 등록
    
	private  Socket smtp;               //SMTP서버에 접속하기 위한것 
	private  BufferedReader input;      //서버의 응답을 저장하기 위한것 
	private  PrintStream output;        // 
	private  String smtpServer= "";     //SMTP서버 주소 
	private  String serverReply="";     // 
	private  int port = 25;             // Default SMTP Port 
	private String SMTP_DOMAIN="";
	private String SYS_ENCODING="";
	private String SMTP_DEV_MODE="";
	private String SMTP_AUTH_MODE="";
	private String SMTP_AUTH_USER="";
	private String SMTP_AUTH_PW="";	
	private String SMTP_STARTTLS="";
	
	   
	public MailMgr() throws NullPointerException, Exception{
		try{
			log.debug("============== MailMgr : START ==============");
			if(propertiesService!=null){
				if(propertiesService.getString("DEV_MODE")!=null){
					if(propertiesService.getString("DEV_MODE").equals("R")){
						if(propertiesService.getString("SMTP_SERVER")!=null){
							smtpServer =  propertiesService.getString("SMTP_SERVER");
						}
		            	
						if(propertiesService.getString("SMTP_PORT")!=null){
							port = Integer.parseInt(propertiesService.getString("SMTP_PORT"),10);
						}
		            	
						if(propertiesService.getString("SMTP_DOMAIN")!=null){
							SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN");
						}
			   		 	
						if(propertiesService.getString("SYS_ENCODING")!=null){
							SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
						}
			   		 	
						if(propertiesService.getString("DEV_MODE")!=null){
							SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");
						}
			   		 	

			   			
					}else{
						if(propertiesService.getString("SMTP_SERVER_D")!=null){
							smtpServer =  propertiesService.getString("SMTP_SERVER_D");
						}
		            	
						if(propertiesService.getString("SMTP_PORT_D")!=null){
							port = Integer.parseInt(propertiesService.getString("SMTP_PORT_D"),10);
						}					

						if(propertiesService.getString("SMTP_DOMAIN_D")!=null){
							SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN_D");
						}	            	

						if(propertiesService.getString("SYS_ENCODING")!=null){
							SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
						}
			   		 	
						if(propertiesService.getString("DEV_MODE")!=null){
							SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");
						}
			   						
					}				
				}				
			}


   		 	SMTP_AUTH_MODE="false";
   			SMTP_AUTH_USER="";
   			SMTP_AUTH_PW="";
   			SMTP_STARTTLS="";
   			
			log.debug("smtpServer::"+smtpServer+"::port::"+port+"::SMTP_DOMAIN::"+SMTP_DOMAIN+"::SYS_ENCODING::"+SYS_ENCODING); 
			
		}catch(NullPointerException e){
			log.debug("NullPointerException Error occurred during MailMgr"); 
		}catch(Exception e){
			log.debug("Error occurred during MailMgr"); 
		}
	}
	
	/**
	 *  메일전송
	 *
	 * @param param 조건
	 *     <li>attribute mailFrom (보내는사람) </li><br>
	 *     <li>attribute mailTo (받는사람) </li><br>
	 *     <li>attribute mailTitle (제목) </li><br>  
	 *     <li>attribute mailContents (내용) </li><br>         
	 * @return void <br>
	 */
	
	public boolean sendMail(Map param ) throws IOException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		// TODO sendMail
		log.error("============== sendMail : START ==============");
		boolean success_yn = true;
		if(propertiesService!=null){
			if(propertiesService.getString("DEV_MODE")!=null){
				if(propertiesService.getString("DEV_MODE").equals("R")){
					if(propertiesService.getString("SMTP_SERVER")!=null){
						smtpServer =  propertiesService.getString("SMTP_SERVER");
					}
	            	
					if(propertiesService.getString("SMTP_PORT")!=null){
						port = Integer.parseInt(propertiesService.getString("SMTP_PORT"),10);
					}
	            	
					if(propertiesService.getString("SMTP_DOMAIN")!=null){
						SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN");
					}
		   		 	
					if(propertiesService.getString("SYS_ENCODING")!=null){
						SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
					}
		   		 	
					if(propertiesService.getString("DEV_MODE")!=null){
						SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");
					}
		   		 	

		   			
				}else{
					if(propertiesService.getString("SMTP_SERVER_D")!=null){
						smtpServer =  propertiesService.getString("SMTP_SERVER_D");
					}
	            	
					if(propertiesService.getString("SMTP_PORT_D")!=null){
						port = Integer.parseInt(propertiesService.getString("SMTP_PORT_D"),10);
					}					

					if(propertiesService.getString("SMTP_DOMAIN_D")!=null){
						SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN_D");
					}	            	

					if(propertiesService.getString("SYS_ENCODING")!=null){
						SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
					}
		   		 	
					if(propertiesService.getString("DEV_MODE")!=null){
						SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");
					}
		   						
				}				
			}				
		}
		 	SMTP_AUTH_MODE="false";
			SMTP_AUTH_USER="";
			SMTP_AUTH_PW="";
			SMTP_STARTTLS="";
    	
		String mailFrom  = (String)param.get("mailFrom");
		String mailFromName  = (String)param.get("mailFromName");


		log.error("SMTP_DOMAIN::"+SMTP_DOMAIN);
		log.error("smtpServer::"+smtpServer);
		log.error("port::"+port);
		int i = 0;
		String mailTo  = returnString((String)param.get("mailTo"),"");
		String mailToName  = returnString((String)param.get("mailToName"),"");
		String mailTitle  = returnString((String)param.get("mailTitle"),"");
		String mailContents  = returnString((String)param.get("mailContents"),"");
	    Date ldate_today = new Date(System.currentTimeMillis()); 

	    java.text.SimpleDateFormat lgmt_date = new java.text.SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss z",Locale.KOREA); 
	    
	    
	    		
	      try { 
		      smtp = new Socket(smtpServer, port); 
		      input = new BufferedReader(new InputStreamReader(smtp.getInputStream(),SYS_ENCODING)); 

		      //접속된 메일서버에게 출력을 보내기위한 스트림을 생성한다.   
		      output = new PrintStream(smtp.getOutputStream());   
		      serverReply = input.readLine(); 
		      if(serverReply != null){
		          if (serverReply.charAt(0) == '2' || serverReply.charAt(0) == '3') { 
		        	  log.error("connecting to SMTP server " + smtpServer + " on port " + port);
		        	  success_yn = false;
		          }else { 
		        	  log.error("Error connecting to SMTP server " + smtpServer + " on port " + port);
		        	  success_yn = false;
	 	          }
		      }
		  }catch(IOException e){
			  log.error("sendMail IOException ERROR");
			  success_yn = false;
		  }catch(NullPointerException e){
			  log.error("sendMail NullPointerException ERROR");
			  success_yn = false;
		  }catch(ArrayIndexOutOfBoundsException e){
			  log.error("sendMail ArrayIndexOutOfBoundsException ERROR");
			  success_yn = false;
		  }catch(Exception e) { 
			  log.error("sendMail Exception ERROR");
			  success_yn = false;
		  } 
	      
		  if (submitCommand("HELO "+smtpServer)){ 
			  log.error("Error occurred during HELO command."); 
			  success_yn = false;
		  }
		  /*if (submitCommand("VRFY "+mailFrom)) {
			  log.error("Error during VRFY command.");  
		  }*/		  
		  if (submitCommand("MAIL FROM: " + mailFrom)){ 
			  log.error("Error during MAIL FROM command."); 
			  success_yn = false;
		  }

		  if (submitCommand("RCPT TO: " + mailTo)){ 
			  log.error("Error during RCPT TO command."); 
			  success_yn = false;
		  }	


	          	    

	      try {	    
	    	  if (submitCommand("DATA")){
	    		  log.error("Error during DATA command."); 
	    		  success_yn = false;
	    	  }
	    	  //MimeUtility.encodeText(mailTitle,SYS_ENCODING,"B");
	    	  /*String header = "From: "+ mailFromName.getBytes(SYS_ENCODING)+ "<"+ mailFrom +">\r\n"; 
	    	  header += "To: "+ mailToName.getBytes(SYS_ENCODING)+"<"+ mailTo + ">\r\n"; 
	    	  header += "MIME-Version: 1.0\r\n"; 
	    	  header += "Content-Type: text/html; charset="+SYS_ENCODING+"\r\n";
	    	  //header += "Content-Transfer-Encoding: 7bit\r\n";
	    	  header += "X-Mailer: miplus\r\n";
	    	  header += "Date: " + (new java.util.Date()) + "\r\n"; 
	    	  //“=?문자셋?인코딩 방식?인코드된 데이터?=”.
	    	  header += "Subject: " + mailTitle.getBytes(SYS_ENCODING) + "\r\n";*/
	    	  
	    	  String header = "From: \"=?"+SYS_ENCODING+"?B?"+ new String(Base64.encodeBase64(mailFromName.getBytes(SYS_ENCODING)))+ "?=\"<"+ mailFrom +">\r\n"; 
	    	  header += "To: \"=?"+SYS_ENCODING+"?B?"+ new String(Base64.encodeBase64(mailToName.getBytes(SYS_ENCODING)))+"?=\"<"+ mailTo + ">\r\n"; 
	    	  header += "MIME-Version: 1.0\r\n"; 
	    	  header += "Content-Type: text/html; charset="+SYS_ENCODING+"\r\n";
	    	  //header += "Content-Transfer-Encoding: 7bit\r\n";
	    	  header += "X-Mailer: miplus\r\n";
	    	  header += "Date: " + (new java.util.Date()) + "\r\n"; 
	    	  //“=?문자셋?인코딩 방식?인코드된 데이터?=”.
	    	  header += "Subject: =?"+SYS_ENCODING+"?B?"+ new String(Base64.encodeBase64(mailTitle.getBytes(SYS_ENCODING))) + "?=\r\n";
	    	  
	    	  /*String header = "From: "+new String(mailFromName.getBytes(SYS_ENCODING))+"<"+ mailFrom +">\r\n"; 
	    	  header += "To: "+new String(mailToName.getBytes(SYS_ENCODING))+"<"+ mailTo + ">\r\n"; 
	    	  header += "MIME-Version: 1.0\r\n"; 
	    	  header += "Content-Type: text/html; charset="+SYS_ENCODING+"\r\n";
	    	  //header += "Content-Transfer-Encoding: 7bit\r\n";
	    	  header += "X-Mailer: miplus\r\n";
	    	  header += "Date: " + (new java.util.Date()) + "\r\n"; 
	    	  //“=?문자셋?인코딩 방식?인코드된 데이터?=”.
	    	  header += "Subject:" + new String(mailTitle.getBytes(SYS_ENCODING)) + "\r\n"; */
	    	  
	    	  /*String header = "From: "+new String(mailFromName.getBytes("8859_1"))+"<"+ mailFrom +">\r\n"; 
	    	  header += "To: "+new String(mailToName.getBytes("8859_1"))+"<"+ mailTo + ">\r\n"; 
	    	  header += "MIME-Version: 1.0\r\n"; 
	    	  header += "Content-Type: text/html; charset="+SYS_ENCODING+"\r\n";
	    	  //header += "Content-Transfer-Encoding: 7bit\r\n";
	    	  header += "X-Mailer: miplus\r\n";
	    	  header += "Date: " + (new java.util.Date()) + "\r\n"; 
	    	  //“=?문자셋?인코딩 방식?인코드된 데이터?=”.
	    	  header += "Subject:" + new String(mailTitle.getBytes("8859_1")) + "\r\n";	   
	    	  */ 	  
	    	  
	    	  
	    	 // header += "Subject:" + new String(mailTitle.getBytes(SYS_ENCODING)) + "\r\n";
	    	  //header += "Subject: " + new String(mailTitle.getBytes("UTF-8"),"EUC-KR") + "\r\n"; 
	    	  //header += "Subject:" + mailTitle + "\r\n";
	    	  
	    	  if (submitCommand(header + "\n"+ new String(mailContents.getBytes(SYS_ENCODING)) + "\r\n.")){ 
	    		  log.error("Error during mail transmission.");
	    		  success_yn = false;
	    	  }
		  }catch(IOException e){
			  log.error("sendMail IOException ERROR");
			  success_yn = false;
		  }catch(NullPointerException e){
			  log.error("sendMail NullPointerException ERROR");
			  success_yn = false;
		  }catch(ArrayIndexOutOfBoundsException e){
			  log.error("sendMail ArrayIndexOutOfBoundsException ERROR");
			  success_yn = false;
		  }catch(Exception e) { 
			  log.error("sendMail Exception ERROR");
			  success_yn = false;
		  } 
		  
	    //logout();
	      try { 
		      if (submitCommand("Quit")){ 
		          log.error("Error during QUIT command");
		          success_yn = false;
		      }else{
		    	  success_yn = true;
		      }
		      input.close(); 
		      output.flush(); 
		      output.close(); 
		      smtp.close(); 
	      }catch(IOException e){
			  log.error("sendMail IOException ERROR");
			  success_yn = false;
		  }catch(NullPointerException e){
			  log.error("sendMail NullPointerException ERROR");
			  success_yn = false;
		  }catch(ArrayIndexOutOfBoundsException e){
			  log.error("sendMail ArrayIndexOutOfBoundsException ERROR");
			  success_yn = false;
		  }catch(Exception e) { 
			  log.error("sendMail Exception ERROR");
			  success_yn = false;
		  }	    
		log.error("============== sendMail : END ==============");	
		return success_yn;
	}
	

	
	public boolean sendJavaMail(Map param) { 
		log.debug("============== sendJavaMail : START ==============");
		boolean success_yn = true;

		if(propertiesService.getString("DEV_MODE").equals("R")){
        	smtpServer =  propertiesService.getString("SMTP_SERVER");
        	port = Integer.parseInt(propertiesService.getString("SMTP_PORT"),10);
   		 	SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN");
   		 	SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
   		 	SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");

   			
		}else{
			
        	smtpServer =  propertiesService.getString("SMTP_SERVER_D");
        	port = Integer.parseInt(propertiesService.getString("SMTP_PORT_D"),10);
   		 	SMTP_DOMAIN = propertiesService.getString("SMTP_DOMAIN_D");
   		 	SYS_ENCODING = propertiesService.getString("SYS_ENCODING");
   		 	SMTP_DEV_MODE = propertiesService.getString("DEV_MODE");
   						
		}
		 	SMTP_AUTH_MODE="false";
			SMTP_AUTH_USER="";
			SMTP_AUTH_PW="";
			SMTP_STARTTLS="";
			
		String mailFrom  = (String)param.get("mailFrom");
		String mailFromName  = (String)param.get("mailFromName");


		log.debug("SMTP_DOMAIN::"+SMTP_DOMAIN);
		log.debug("smtpServer::"+smtpServer);
		log.debug("port::"+port);
		int i = 0;
		String mailTo  = returnString((String)param.get("mailTo"),"");
		String mailToName  = returnString((String)param.get("mailToName"),"");
		String mailTitle  = returnString((String)param.get("mailTitle"),"");
		String mailContents  = returnString((String)param.get("mailContents"),"");
	    Date ldate_today = new Date(System.currentTimeMillis()); 		
			
		    try { 
		    	
		        Properties props = new Properties(); 
		        
		        props.put("mail.transport.protocol", "smtp"); 
		        props.put("mail.smtp.host", smtpServer); 
		        props.put("mail.smtp.port", port); 
		        Authenticator authenticator = null; 
		        props.put("mail.smtp.auth", SMTP_AUTH_MODE); 
		        
		        if (SMTP_AUTH_MODE.equals("true")) {
		            
		            props.put("mail.smtp.starttls.enable", SMTP_STARTTLS);
		            authenticator = new Authenticator(){
		            	protected PasswordAuthentication getPasswordAuthentication(){
		            		return new PasswordAuthentication(SMTP_AUTH_USER,SMTP_AUTH_PW);
		            	}
		            };

		        }

		        
		        
		        Session session = Session.getInstance(props, authenticator); 

		        MimeMessage message = new MimeMessage(session);
		        // 실운영모드일경우
		        if(propertiesService.getString("DEV_MODE")!=null){
			        if(propertiesService.getString("DEV_MODE").equals("R")){
				        message.setFrom(new InternetAddress(mailFrom, mailFromName, SYS_ENCODING)); 
				        message.setSentDate(new Date());
				        message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo, mailToName, SYS_ENCODING) ); 

				        message.setSubject(MimeUtility.encodeText(mailTitle, SYS_ENCODING, "B"));
				       

				        message.setContent(mailContents, "text/html; charset="+SYS_ENCODING+"");
				        	        	
			        	
			        }else{
				        message.setFrom(new InternetAddress(mailFrom, mailFromName, SYS_ENCODING)); 
				        message.setSentDate(new Date());
				        message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo, mailToName, SYS_ENCODING) ); 

				        message.setSubject(MimeUtility.encodeText(mailTitle, SYS_ENCODING, "B"));
				       

				        message.setContent(mailContents, "text/html; charset="+SYS_ENCODING+"");
		        	
			        }		        	
		        }else{
			        message.setFrom(new InternetAddress(mailFrom, mailFromName, SYS_ENCODING)); 
			        message.setSentDate(new Date());
			        message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailTo, mailToName, SYS_ENCODING) ); 

			        message.setSubject(MimeUtility.encodeText(mailTitle, SYS_ENCODING, "B"));
			       
	
			        message.setContent(mailContents, "text/html; charset="+SYS_ENCODING+"");		        	
		        }


		        Transport.send(message); 
		        success_yn = true;
		        log.debug("메일 발송 성공"); 
		    } catch (UnsupportedEncodingException e) { 

		        log.debug("메일 발송 실패1:============="); 
		        success_yn = false;
		    } catch (MessagingException e) { 
		    	log.debug("메일 발송 실패2:============="); 
		    	success_yn = false;
		         
		    } 
		    
		    log.debug("============== sendJavaMail : END ==============");
		    return success_yn;
		} 


	   //서버에 명령을 보낸후 응답을 반다 Boolean값을 return, true인 경우 에러 
	   private boolean submitCommand(String command) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception { 
	      try { 
	    	  log.debug(command);
	    	  output.print(command + "\r\n");
	    	  serverReply = input.readLine(); 
	    	  log.debug("submitCommand:"+serverReply+":"); 
	    	  if(serverReply!=null){
			      if (serverReply.charAt(0) == '4' || serverReply.charAt(0) == '5'){ //전송실패등.. 
			          return true; 
			      }else{ 
			          return false; 
			      } 	    		  
	    	  }else{
	    		  return true; 
	    	  }

	      }catch(NullPointerException e){
	    	  log.debug("submitCommand:"+serverReply+":");		
		  }catch(ArrayIndexOutOfBoundsException e){
			  log.debug("submitCommand:"+serverReply+":");		
		  }catch(Exception e) { 
	          log.debug("submitCommand:"+serverReply+":"); 
	      } 
	      return false;
	  } 


	   public String han(String Unicodestr) throws UnsupportedEncodingException{       
	      if( Unicodestr == null)   return null;    
	      return new String(Unicodestr.getBytes("8859_1"),"KSC5601");    
	   }
	   
	   public String convert(String str, String encoding) throws IOException {
		   ByteArrayOutputStream requestOutputStream = new ByteArrayOutputStream();
		   requestOutputStream.write(str.getBytes(encoding));
		   return requestOutputStream.toString(encoding);
	   }
	   
	    public String returnString(String str,String replace){
	    	// TODO returnString
	   	 if (str == null || str.equals("")) 
	   	 	return replace; 
	   	 else 
	   	 	return str;
	    }

}