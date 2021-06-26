package com.ji.common;
 
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
 









import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
 









import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.stereotype.Repository;


import egovframework.rte.fdl.property.EgovPropertyService;
 
@Repository("jasyptUtil")
public class JasyptUtil {
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    protected Logger log = Logger.getLogger(JasyptUtil.class); //현재 클래스 이름을 Logger에 등록
    
    private String jasypt_Algorithm="";
    private String jasypt_Password="";
	//private final static String  jasypt_Algorithm = propertiesService.getString("CMS_ENC_JASYP_AL");
	//private final static String  jasypt_Password = propertiesService.getString("CMS_ENC_JASYP_PW");
	public JasyptUtil() throws NullPointerException, Exception{
		try{
			if(propertiesService!=null){
				if(propertiesService.getString("CMS_ENC_JASYP_AL")!=null){
					jasypt_Algorithm = propertiesService.getString("CMS_ENC_JASYP_AL");
				}
				
				if(propertiesService.getString("CMS_ENC_JASYP_PW")!=null){
					jasypt_Password = propertiesService.getString("CMS_ENC_JASYP_PW");
				}				
			}

			
			
		}catch(NullPointerException e){
			log.debug("NullPointerException Error occurred during JasyptUtil"); 
		}catch(Exception e){
			log.debug("Error occurred during JasyptUtil"); 
		}		
	}
    // 암호화
    public String JasyptEncode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, 
                                                     NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, 
                                                     IllegalBlockSizeException, BadPaddingException{
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        String  enc_Algorithm = propertiesService.getString("CMS_ENC_JASYP_AL");
        String  enc_Ipn = propertiesService.getString("CMS_ENC_JASYP_PW");
        
        pbeEnc.setAlgorithm(enc_Algorithm);
        pbeEnc.setPassword(enc_Ipn); // PBE 값
    	String enStr = pbeEnc.encrypt(str);
        return enStr;
    }
 
    //복호화
    public String JasyptDecode(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, 
                                                     NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, 
                                                     IllegalBlockSizeException, BadPaddingException {
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        String  enc_Algorithm = propertiesService.getString("CMS_ENC_JASYP_AL");
        String  enc_Ipn = propertiesService.getString("CMS_ENC_JASYP_PW");
        
        pbeEnc.setAlgorithm(enc_Algorithm);
        pbeEnc.setPassword(enc_Ipn); // PBE 값
    	String deStr = pbeEnc.decrypt(str);
 
        return deStr;
    }
    
    // 단방향암호화
    public String encSHA256(String str){

    	String SHA = ""; 
    	String  CMS_ENC_JASYP_OW = propertiesService.getString("CMS_ENC_JASYP_OW");

    
    	try{

    		MessageDigest sh = MessageDigest.getInstance(CMS_ENC_JASYP_OW); 

    		sh.update(str.getBytes()); 

    		byte byteData[] = sh.digest();

    		StringBuffer sb = new StringBuffer(); 

    		for(int i = 0 ; i < byteData.length ; i++){

    			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

    		}

    		SHA = sb.toString();

    		

    	}catch(NoSuchAlgorithmException e){

    		
    		SHA = null; 

    	}

    	return SHA;

    }
    
    

}
