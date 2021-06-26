/*===================================================================================
 * System             : Jrinfo Library 
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.FileUtility.java
 * Description        : 파일관리 Utility
 * Author             : 이금용
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : 이금용
 * Updated content    : 
 * License            : 
 *==================================================================================*/
package com.ji.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ji.cm.CM_Util;



/**
 * 파일관리
 *
 */
public final class FileUtility{
	static final int BUFF_SIZE=100000;
	static final byte[] buffer=new byte[BUFF_SIZE];
	/**
	 * 로그설정
	 */
	private static Log log = LogFactory.getLog(FileUtility.class);
	
	/**
	 * 
	 
	 public static void main(String[] args){
		 File file = new File();
		 try{
			file.copyFile(args[0], args[1]);
		 }catch(Exception e){
			 log.debug("Exception:");
		 }
	 }
	 */

    /**
     * 디렉토리에 파일존재여부
     *
     * @param path 
     * @return boolean 
     */
    public static boolean hasFile( String path) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
        java.io.File file = null;
        try {
            int fileLen = 0;
        	
        	file = new java.io.File( path );
            if(file != null){
            	if(file.list()!=null){
            		String [] fileList = file.list();
            		if(fileList!=null){
            			fileLen = fileList.length;
            		}
            		
            	}
            	
            }
            
            if( fileLen == 0 ) return false;
            else return true;
            
        }catch(NullPointerException q){
        	return false;		
		}catch(ArrayIndexOutOfBoundsException q){
			return false;		
		}catch (Exception e) {
            return false;
        }
    }

	/**
	 * 해당파일존재여부
	 *
	 * @param path 
	 * @param fileNM 파일명
	 * @return boolean 
	 */
	public static boolean exists( String path, String fileNM ) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		java.io.File file = null;
		try {
			file = new java.io.File( path + fileNM );
			return file.exists();
		}catch(NullPointerException q){
			return false;	
		}catch(ArrayIndexOutOfBoundsException q){
			return false;		
		}catch (Exception e) {
			return false;
		}
	}

	/**
	 * 해당파일존재여부
	 *
	 * @param path 
	 * @return boolean 
	 */
	public static boolean exists( String path) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		java.io.File file = null;
		try {
			file = new java.io.File( path );
			return file.exists();
		}catch(NullPointerException e){
			return false;		
		}catch(ArrayIndexOutOfBoundsException e){
			return false;		
		}catch (Exception e) {
			return false;
		}
	}

	/**
	 * 파일삭제
	 *
	 * @param path String 
	 * @param fileNM String
	 * @return void 
	 * @throws Exception 
	 */
	/*public static void eraseFileFromDisk( String path, String fileNM )
	  throws Exception{
		java.io.File file = null;
		try {
			file = new java.io.File( path + fileNM );
			if( !file.exists() ) {
       			return;
			}
			if( !file.canWrite() ) {
				throw new Exception("You don't have right remove this File(" + path + fileNM + ")");
			}
			if( !file.delete() ) {
				throw new Exception("Fail to remove File(" + path + fileNM + ")");
			}
		}catch (NullPointerException e) {
			throw new Exception("Path Name(" + path + fileNM + ") is null ");
		}
	}*/

	/**
	 * 파일복사
	 *
	 * @param srcPath String source 
	 * @param destPath String destination 
	 * @return void 
	 * @throws Exception 
	 */
	public void copyFile2(String srcPath, String destPath )
		throws JSysException {
		java.io.BufferedReader br = null;
		java.io.FileOutputStream fos = null;
		try{
			br = new java.io.BufferedReader(
				new java.io.InputStreamReader(new java.io.FileInputStream(srcPath)));
			
			String line = null;
			StringBuffer lines = new StringBuffer();

			while((line = br.readLine()) != null) {
				lines.append(line + "\n");
			}
			byte[] b = lines.toString().getBytes();	
			fos = new java.io.FileOutputStream(destPath);
			fos.write(b);
			fos.flush();
		}catch(java.io.FileNotFoundException e){
			throw new JSysException("Source File( " + srcPath + " ) doesn't exists");
		}catch(SecurityException e){
			throw new JSysException("Cannot Open Source File( " + srcPath + " )");
		} catch (IOException e) {
			throw new JSysException("Cannot Open Source File( " + srcPath + " )");

		}finally{
			try{
				if(fos!=null)fos.close();
				if(br!=null)br.close();
			} catch(java.io.IOException e) {
	        	throw new JSysException("Fail to copy File :copyFile2");
	       	
			}			
		}
		

	}
	

	public static void copyFile(String srcPath, String destPath) throws IOException{
	
		log.debug("================== copyFile START ================== ");
		log.debug("srcPath:"+srcPath);
		log.debug("srcPath:"+destPath);
		InputStream in=null;
		OutputStream out=null;
		try{
			in=new FileInputStream(srcPath);
			out=new FileOutputStream(destPath);
				while(true){
					synchronized(buffer){
						int amountRead=in.read(buffer);
						if(amountRead==-1)
							break;
						out.write(buffer,0,amountRead);
					}
				}
		}catch(java.io.FileNotFoundException e){
			throw new JSysException("Source File( " + srcPath + " ) doesn't exists");
		}catch(SecurityException e){
			throw new JSysException("Cannot Open Source File( " + srcPath + " )");
		} catch (IOException e) {
			throw new JSysException("Cannot Open Source File( " + srcPath + " )");				
		}finally{
			if(in!=null){in.close();}
			if(out!=null){out.close();}
		}
		log.debug("================== copyFile END ================== ");
	}
	

	/**
	 * byte[] 로 파일생성
	 *
	 * @param src data
	 * @param destPath 
	 * @return void 
	 * @throws  
	 * @throws Exception
	 */
	public static void makeFile(byte[] src, String destPath)
	  throws JSysException {

       java.io.FileOutputStream fos = null;
		try {
    		fos= new java.io.FileOutputStream(destPath );
    		fos.write(src);
		} catch(IOException e) {
			throw new JSysException("Cannot Write Destination File( " + destPath + " )");
		}finally{
			try {
			
				if(fos!=null)fos.close();
			} catch(java.io.IOException e) {
				throw new JSysException("Cannot Write Destination File( " + destPath + " )");			
			}			
		}

	}

	/**
	 * destination 
	 *
	 * @param destPath 
	 * @throws Exception 
	 */
	public static void makeDir(String destPath ) throws NullPointerException, ArrayIndexOutOfBoundsException, JSysException{
		log.debug("makeDir(String destPath )method : "+destPath);
		java.io.File newDir=null;

		try {
			if(!exists(destPath)){
	       		newDir = new java.io.File(destPath);
				if (newDir.mkdirs() != true){
					log.debug("디렉토리생성실패!");
				}
			}else{
				log.debug("디렉토리가 존재합니다");
			}
		} catch(NullPointerException e){
			throw new JSysException(e.toString());		
		} catch(ArrayIndexOutOfBoundsException e){
			throw new JSysException(e.toString());		
		} catch(Exception e) {
			throw new JSysException(e.toString());
		}
	 }

	/**
	 * destination 
	 *
	 * @param destPath data
	 * @return byte[] 
	 * @throws  
	 * @throws Exception 
	 */
	public static byte[] getFileData(String destPath ) throws JSysException {
		java.io.File hFile=new java.io.File(destPath);
		java.io.FileInputStream fis = null;
		byte[] buf=null;
		try{
    		fis= new java.io.FileInputStream(hFile );
    		buf=new byte[(int)hFile.length()];

			if(fis!=null){
				for(int i;(i=fis.read(buf))!=-1;)
				{
				}				
			} 
			
			if(buf==null){
				buf = new byte[0];
			}
			
		} catch(IOException e){
			log.debug("Cannot Read Destination File( " + destPath + " )");
       		
		}finally{
    		try {
				if(fis!=null){fis.close();}
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				log.debug("Cannot Read Destination File( " + destPath + " )");
			}			
		}

		return buf;
	}
	/**
	 * 디렉토리삭제(하위디렉토리포함)
	 * @param dir
	 * @return
	 */	
	public static boolean deleteDir(String dir) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception{ 
		java.io.File wfile = null;
		java.io.File file = new java.io.File(dir); 
		String[] files = file.list(); // list() 硫����� File[] ��援ы���遺��
		boolean file_del_yn = false;
		boolean dir_del_yn = false;
		try {		  
			if(files != null){
				for (int i = 0; i < files.length; i++) { 
				   wfile = new java.io.File(dir+"/"+files[i]);  //�щ���� ��볼踰��
				   if(wfile.isDirectory()){   //留�� 洹���� �����━�������━媛���� 洹몄�����������寃쎌�
				    deleteDir(dir+"/"+files[i]);
				   }else{
					   file_del_yn = wfile.delete();
					   if(file_del_yn == true){
						   
					   }else{
						   return false;	
					   }
				    
					   wfile = null;
				   }
				}
			}
			dir_del_yn =  file.delete();
			   if(dir_del_yn == true){
				   
			   }else{
				   return false;	
			   }			
		}catch(NullPointerException e){
			return false;		
		}catch(ArrayIndexOutOfBoundsException e){
			return false;		
		}catch(Exception e) {
			return false;
		}
		  return true;
	}	
	
	/**
	 * 파일삭제
	 * @param filepath
	 * @return
	 */		
	public static boolean deletefile(String filepath) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception { 
		log.debug("================== deletefile START ================== ");
		log.debug("filepath:"+filepath);
	
		java.io.File wfile = null;
		java.io.File file = new java.io.File(filepath); 
		try{
			file.delete();
		}catch(NullPointerException e){
			log.debug("파일삭제실패:");
			return false;	
		}catch(ArrayIndexOutOfBoundsException e){
			log.debug("파일삭제실패:");
			return false;		
		}catch(Exception e) {
			log.debug("파일삭제실패:");
			return false;
		}		
		log.debug("================== deletefile END ================== ");		
		return true;
	}	
	

	/**
	 * 파일명 변경
	 * @param content
	 * @return
	 */		
	public static String changeFileName(String content) {
		//	TODO changeFileName	
		log.debug("============== changeFileName : START ==============");
		// 
		if(content==null){
			content = "";
		}
		String strImgPart = "Content\\-Type: image\\/([jpeg|gif|png|bmp]+);";
		Pattern p = Pattern.compile(strImgPart, Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(content);
		String[] saImgExt = new String[m.groupCount()+1];
		int cnt = 0;
		while(m.find()) {
			saImgExt[cnt] = m.group(1);
			if(saImgExt[cnt].equals("jpeg")) saImgExt[cnt] = "jpg";
			cnt++;
		}
		// ����대� 蹂�꼍
		String newContent = content;
		if( saImgExt != null && saImgExt.length > 0 ) {
			String strNamePart1 = "name=\"=\\?.+\\?.+\\?(.+)\\?=\"";
			String strNamePart2 = "[^a-z|A-Z|0-9]+";
			p = Pattern.compile(strNamePart1, Pattern.CASE_INSENSITIVE);
			m = p.matcher(content);
			String strBeforeName = "";
			String strAfterName = "";
			cnt = 0;
			while(m.find()) {
				strBeforeName = m.group();
				strAfterName = m.group(1);
				strAfterName = strAfterName.replaceAll(strNamePart2, "");
				strAfterName = "name=\""+strAfterName+"."+saImgExt[cnt++]+"\"";
				log.debug(strBeforeName+":::"+strAfterName);
				newContent = HtmlText.replace(newContent, strBeforeName, strAfterName);
			}
		}
		log.debug("============== changeFileName : END ==============");		
		return newContent;
	}	
	
	/**
	 * ������ �������낫瑜�ArrayList���대���
	 * @param files
	 * @return ArrayList
	 */
	/*public static ArrayList UploadInfo(MultipartRequest multi,String curdate
			, String uploadtmppath,String uploadrealpath, String SE_sb_type, String fileKey){
		//	TODO UploadInfo	
		log.debug("============== UploadInfo : START ==============");		
		ArrayList arrdf = new ArrayList();
		ArrayList arrdf2 = null;
		Map mapdf2 = null;
		Map tmpmap = null;
		int i = 0;
		Enumeration files = multi.getFileNames();
		while (files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = multi.getFilesystemName(name);
			String filenameext = file_extstr(filename);
			String type = multi.getContentType(name);
			File f = multi.getFile(name);
			//log.debug("formname1:"+name);
			String [] exp_formname = name.split("_");
			//log.debug("formname2:"+name);
			mapdf2 = new HashMap();
			if (f != null && filename != null && type != null) {
				if(!fileKey.equals("")){
					mapdf2.put("fileKey",fileKey);
				}else{
					mapdf2.put("fileKey",curdate+"_"+SE_sb_type);
				}
				mapdf2.put("fileName",f.getName());
				mapdf2.put("maskName",curdate+"_"+SE_sb_type+"_"+i+"."+filenameext);
				mapdf2.put("fileSize",new Long(f.length()));
				mapdf2.put("cnt",Integer.toString(i));
				if(!((String)mapdf2.get("fileName")).equals("") && !((String)mapdf2.get("maskName")).equals("")){
					try{
						FileUtility.copyFile(uploadtmppath+"/"+mapdf2.get("fileName"),uploadrealpath+"/"+mapdf2.get("maskName"));
						//log.debug(uploadtmppath+"/"+mapdf2.get("fileName")+":::"+uploadpath+"/"+mapdf2.get("maskName"));
						// ���蹂듭�����������������
						FileUtility.deletefile(uploadtmppath+"/"+mapdf2.get("fileName"));
					}catch(Exception q){
						throw new JSysException("������蹂듭�以� ���媛�諛��������");					
					}
				}				
			}else{
				mapdf2.put("fileKey","");
				mapdf2.put("fileName","");
				mapdf2.put("maskName","");
				mapdf2.put("fileSize","");
				mapdf2.put("cnt",Integer.toString(i));				
			}
			//log.debug("fileName:"+mapdf2.get("fileName"));
			//log.debug("maskName:"+mapdf2.get("maskName"));
			//log.debug("fileSize:"+mapdf2.get("fileSize"));
			//log.debug("cnt:"+mapdf2.get("cnt"));
			arrdf.add(mapdf2);
			i++;
		}

		log.debug("============== UploadInfo : END ==============");
		return arrdf;
	}*/
	
	
	/**
	 * ������ �������낫瑜�ArrayList���대���cos.jar�ъ���
	 * @param files
	 * @return List
	 */
	/*public static List UploadInfo2(MultipartRequest multi,String curdate
			, String uploadtmppath,String uploadrealpath,String code){
		//	TODO UploadInfo2	
		log.debug("============== UploadInfo2 : START ==============");		
		ArrayList arrdf = new ArrayList();
		ArrayList arrdf2 = null;
		Map mapdf2 = null;
		Map tmpmap = null;
		int i = 0;

		if(multi.getFileNames()!=null){
			//log.debug("1111111111111111111111111111111111:");
			Enumeration files = multi.getFileNames();
			//multi.getParameterNames()
			//log.debug("2222222222222222222222222222222222:");
			while (files.hasMoreElements()) {
				//log.debug("333333333333333333333333333333333333:");
				String name = (String) files.nextElement();
				//log.debug("444444444444444444444444444444444444:"+name);
				String filename = multi.getFilesystemName(name);
				
				//log.debug("444444444444444444444444444444444444:"+multi.getOriginalFileName(name));
				//log.debug("444444444444444444444444444444444444:"+filename);
				//log.debug("444444444444444444444444444444444444:"+filename);
				if(filename!=null){
					//log.debug("555555555555555555555555555555555555:"+filename);
					String filenameext = file_extstr(filename);
					//log.debug("666666666666666666666666666666666666:");
					String type = multi.getContentType(name);
					//log.debug("777777777777777777777777777777777777:");
					File f = multi.getFile(name);
					//log.debug("formname1:"+name);
					String [] exp_formname = name.split("_");
					//log.debug("formname2:"+name);
					mapdf2 = new HashMap();
					if (f != null && filename != null && type != null) {
						mapdf2.put("fileformName",name);
						mapdf2.put("fileName",f.getName());
						mapdf2.put("maskName",curdate+"_"+code+"_"+i+"."+filenameext);
						mapdf2.put("fileSize",new Long(f.length()));
						mapdf2.put("cnt",Integer.toString(i));
						if(!((String)mapdf2.get("fileName")).equals("") && !((String)mapdf2.get("maskName")).equals("")){
							try{
								FileUtility.copyFile(uploadtmppath+"/"+mapdf2.get("fileName"),uploadrealpath+"/"+mapdf2.get("maskName"));
								//log.debug(uploadtmppath+"/"+mapdf2.get("fileName")+":::"+uploadpath+"/"+mapdf2.get("maskName"));
								// ���蹂듭�����������������
								FileUtility.deletefile(uploadtmppath+"/"+mapdf2.get("fileName"));
							}catch(Exception q){
								log.debug("UploadInfo2 Exception:"+q);
								throw new JSysException("������蹂듭�以� ���媛�諛��������");					
							}
						}				
					}else{
						mapdf2.put("fileformName",name);
						mapdf2.put("fileName","");
						mapdf2.put("maskName","");
						mapdf2.put("fileSize","");
						mapdf2.put("cnt",Integer.toString(i));				
					}
					//log.debug("fileName:"+mapdf2.get("fileName"));
					//log.debug("maskName:"+mapdf2.get("maskName"));
					//log.debug("fileSize:"+mapdf2.get("fileSize"));
					//log.debug("cnt:"+mapdf2.get("cnt"));
					arrdf.add(mapdf2);
					i++;
				}else{
					
					//log.debug("555555555555555555555555555555555555:filename null");
					mapdf2 = new HashMap();
					mapdf2.put("fileformName",name);
					mapdf2.put("fileName","");
					mapdf2.put("maskName","");
					mapdf2.put("fileSize","");
					mapdf2.put("cnt",Integer.toString(i));	
					arrdf.add(mapdf2);
					i++;					
				}
			}			
		}


		log.debug("============== UploadInfo2 : END ==============");
		return arrdf;
	}*/
	
	/**
	 * ������ �������낫瑜�ArrayList���대���common-fileupload.jar�ъ���
	 * @param files
	 * @return List
	 */
	/*public static List UploadInfo2(MultipartHttpServletRequest multi,String curdate
			, String uploadtmppath,String uploadrealpath,String code) throws IOException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO UploadInfo2	
		log.debug("============== UploadInfo2 : START ==============");		
		ArrayList arrdf = new ArrayList();
		ArrayList arrdf2 = null;
		Map mapdf2 = null;
		Map tmpmap = null;
		int i = 0;
		try{
			if(multi.getFileNames()!=null){
				//log.debug("1111111111111111111111111111111111:");
				//Enumeration files = multi.getFileNames();
				Iterator fileIter = multi.getFileNames();
				//multi.getParameterNames()
				//log.debug("2222222222222222222222222222222222:");
				while (fileIter.hasNext()) {
					//log.debug("333333333333333333333333333333333333:");
					String fieldName =(String)fileIter.next();
	
					MultipartFile mFile = multi.getFile(fieldName);
					log.debug("444444444444444444444444444444444444:fieldName:"+fieldName);
					String filename =mFile.getOriginalFilename();
				    long sizeInBytes=mFile.getSize();
				   
				     
					log.debug("444444444444444444444444444444444444:"+mFile.getName());
					log.debug("444444444444444444444444444444444444:filename:"+filename);
					//log.debug("444444444444444444444444444444444444:"+filename);
					if(filename!=null && sizeInBytes > 0){
						//log.debug("555555555555555555555555555555555555:"+filename);
						String filenameext = file_extstr(filename);
						//log.debug("666666666666666666666666666666666666:");
						//log.debug("777777777777777777777777777777777777:");
	
						 
						//log.debug("formname1:"+name);
						String [] exp_formname = fieldName.split("_");
						//log.debug("formname2:"+name);
						mapdf2 = new HashMap();
	
							mapdf2.put("fileformName",fieldName);
							mapdf2.put("fileName",filename);
							mapdf2.put("maskName",curdate+"_"+code+"_"+i+"."+filenameext);
							mapdf2.put("fileSize",sizeInBytes);
							mapdf2.put("cnt",Integer.toString(i));
							if(!((String)mapdf2.get("fileName")).equals("") && !((String)mapdf2.get("maskName")).equals("")){
								mFile.transferTo(new File(uploadrealpath+"/"+mapdf2.get("maskName")));
								//	FileUtility.copyFile(uploadtmppath+"/"+mapdf2.get("fileName"),uploadrealpath+"/"+mapdf2.get("maskName"));
								//	log.debug(uploadtmppath+"/"+mapdf2.get("fileName")+":::"+uploadrealpath+"/"+mapdf2.get("maskName"));
									// ���蹂듭�����������������
									//FileUtility.deletefile(uploadtmppath+"/"+mapdf2.get("fileName"));
	
							}				
	
						arrdf.add(mapdf2);
						i++;
					}else{
						
						//log.debug("555555555555555555555555555555555555:filename null");
						mapdf2 = new HashMap();
						mapdf2.put("fileformName",fieldName);
						mapdf2.put("fileName","");
						mapdf2.put("maskName","");
						mapdf2.put("fileSize","");
						mapdf2.put("cnt",Integer.toString(i));	
						arrdf.add(mapdf2);
						i++;					
					}
				}			
			}
		}catch(IOException q){
			log.debug("IOException:"+q);
			throw new JSysException("������蹂듭�以� ���媛�諛��������");		
		}catch(NullPointerException q){
			log.debug("NullPointerException:"+q);
			throw new JSysException("������蹂듭�以� ���媛�諛��������");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.debug("ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException("������蹂듭�以� ���媛�諛��������");		
		}catch(Exception q){
			log.debug("UploadInfo2 Exception:"+q);
			throw new JSysException("������蹂듭�以� ���媛�諛��������");					
		}		


		log.debug("============== UploadInfo2 : END ==============");
		return arrdf;
	}*/	
	
	/**
	 * 파일업로드 처리 common-fileupload.jar�ъ���
	 * @param files
	 * @return List
	 */
	public static List UploadInfo2(MultipartHttpServletRequest multi,String curdate
			, String uploadtmppath,String uploadrealpath,String code, String [] file_group, String []  file_group_idx) throws IOException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO UploadInfo2	
		log.debug("============== UploadInfo2 : START ==============");		
		ArrayList arrdf = new ArrayList();
		ArrayList arrdf2 = null;
		Map mapdf2 = null;
		Map tmpmap = null;
		int i = 0;
		int j = 0;
		int file_group_cnt = 0;
		String file_group_nm = "";
		String file_group_seq = "";
		String prev_file_group_nm = "";
		String maskName = "";
		try{

			
			if(multi.getFileNames()!=null){
				//log.debug("1111111111111111111111111111111111:");
				//Enumeration files = multi.getFileNames();
				Iterator fileIter = multi.getFileNames();
				//multi.getParameterNames()
				//log.debug("2222222222222222222222222222222222:");
				while (fileIter.hasNext()) {
					//log.debug("333333333333333333333333333333333333:");
					String fieldName =(String)fileIter.next();
	
					MultipartFile mFile = multi.getFile(fieldName);
					log.debug("444444444444444444444444444444444444:fieldName:"+fieldName);
					String filename =mFile.getOriginalFilename();
				    long sizeInBytes=mFile.getSize();
				   
				     
				    log.debug("444444444444444444444444444444444444:"+mFile.getName());
				    log.debug("444444444444444444444444444444444444:filename:"+filename);
					
					file_group_nm = "";
					file_group_seq = "";					
					for(j=0;j<file_group.length;j++){
						if(fieldName.indexOf(file_group[j]+"_") > -1){
							file_group_nm = file_group[j];
							file_group_seq = file_group_idx[j];
							break;
						}						
					}
					
					log.debug("444444444444444444444444444444444444:file_group_nm:"+file_group_nm);
					log.debug("444444444444444444444444444444444444:file_group_seq:"+file_group_seq);
					
					if(prev_file_group_nm.equals("") || !prev_file_group_nm.equals(file_group_nm)){
						file_group_cnt = 1;
					}
					
					log.debug("444444444444444444444444444444444444:sizeInBytes:"+sizeInBytes);
					if(filename!=null && sizeInBytes > 0){
						//log.debug("555555555555555555555555555555555555:"+filename);
						String filenameext = file_extstr(filename);
						//log.debug("666666666666666666666666666666666666:");
						//log.debug("777777777777777777777777777777777777:");
	
						String [] allowExt =("GIF,JPG,BMP,PNG,HWP,XLS,XLSX,ZIP,PDF,TIF,DOC,DOCX,PPT,PPTX,TXT").split(",");
						if(CM_Util.isTargetValInArray(filenameext, allowExt) == false){
							throw new JSysException("파일업로드중 에러가 발생했습니다");
						}
						 
						//log.debug("formname1:"+name);
						String [] exp_formname = fieldName.split("_");
						//log.debug("formname2:"+name);
						mapdf2 = new HashMap();
	
							mapdf2.put("fileformName",fieldName);
							mapdf2.put("fileName",filename);
							mapdf2.put("maskName",curdate+"_"+code+"_"+i+"."+filenameext);
							mapdf2.put("fileSize",sizeInBytes);
							mapdf2.put("cnt",Integer.toString(file_group_cnt));
							
							if(!file_group_nm.equals("")){
								mapdf2.put("file_group_nm",file_group_nm);
								mapdf2.put("file_group_seq",file_group_seq);
							}else{
								mapdf2.put("file_group_nm","cmfile");
								mapdf2.put("file_group_seq","1");								
							}
							
							if(mapdf2.get("maskName")==null){
								maskName = "";
							}else{
								maskName = (String)mapdf2.get("maskName");
							}							

							if(!((String)mapdf2.get("fileName")).equals("") && !((String)mapdf2.get("maskName")).equals("")){
								if(maskName!=null && !"".equals(maskName)){  
									   maskName = maskName.replaceAll("\\.\\.","").replaceAll("/","").replaceAll("[&]","");  
									   //maskName = maskName + "-report";  
									           
								} 
								
								if(uploadrealpath!=null && !"".equals(uploadrealpath)){  
									//uploadrealpath = uploadrealpath.replaceAll("/","");  
									//egov. 왜없앰??
//									uploadrealpath = uploadrealpath.replaceAll("\\.\\.","").replaceAll("[.]","").replaceAll("[&]","");  
									uploadrealpath = uploadrealpath + "/"; 
									   //uploadrealpath = uploadrealpath + "-report";  
									           
								} 								
								log.debug("555555555555555555555555555555555555:uploadrealpath+maskName:"+uploadrealpath+maskName);
								mFile.transferTo(new File(uploadrealpath+maskName));
								//	FileUtility.copyFile(uploadtmppath+"/"+mapdf2.get("fileName"),uploadrealpath+"/"+mapdf2.get("maskName"));
								//	System.out.println(uploadtmppath+"/"+mapdf2.get("fileName")+":::"+uploadrealpath+"/"+mapdf2.get("maskName"));
									// ���蹂듭�����������������
									//FileUtility.deletefile(uploadtmppath+"/"+mapdf2.get("fileName"));
								// 이미지 파일일경우 썸네일 파일을 생성한다
								if(filenameext.toLowerCase().equals("png") 
										|| filenameext.toLowerCase().equals("jpg")
										|| filenameext.toLowerCase().equals("gif")
										|| filenameext.toLowerCase().equals("bmp")
								){
									log.debug("66666666666666666666666666666666:CreateThumbnail:"+uploadrealpath+maskName);
									//CreateThumbnail(uploadrealpath+"/"+maskName, 208, 159);
									CreateThumbnail(uploadrealpath+maskName, 200, 152);
									//208:159=200:x
								// autocad 파일일경우
								}								
								
							}				
	
						arrdf.add(mapdf2);
						i++;
					}else{
						
						log.debug("555555555555555555555555555555555555:filename null");
						mapdf2 = new HashMap();
						mapdf2.put("fileformName",fieldName);
						mapdf2.put("fileName","");
						mapdf2.put("maskName","");
						mapdf2.put("fileSize","");
						mapdf2.put("cnt",Integer.toString(file_group_cnt));
						if(!file_group_nm.equals("")){
							mapdf2.put("file_group_nm",file_group_nm);
							mapdf2.put("file_group_seq",file_group_seq);
						}else{
							mapdf2.put("file_group_nm","cmfile");
							mapdf2.put("file_group_seq","1");								
						}						
						arrdf.add(mapdf2);
						i++;					
					}
					
					prev_file_group_nm = file_group_nm;
					file_group_cnt++;
				}			
			}
		}catch(IOException q){
			log.error("IOException:"+q);
			throw new JSysException("파일업로드중 에러가 발생했습니다");		
		}catch(NullPointerException q){
			log.error("NullPointerException:"+q);
			throw new JSysException("파일업로드중 에러가 발생했습니다");		
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:"+q);
			throw new JSysException("파일업로드중 에러가 발생했습니다");		
		}catch(Exception q){
			log.error("UploadInfo2 Exception:"+q);
			throw new JSysException("파일업로드중 에러가 발생했습니다");					
		}		


		log.debug("============== UploadInfo2 : END ==============");
		return arrdf;
	}	
	
	/**
	 * 파일확장자
	 * @param filestr
	 * @return String
	 */	
	public static String file_extstr(String filestr){	
		if(filestr==null){
			filestr = "";
		}
	 int temp = filestr.lastIndexOf(".");


	 String ext = filestr.substring(temp+1);
	 return ext;
	}
	
	/**
	 * 파일썸네일생성
	 * @param files
	 * @return List
	 */
	public static boolean CreateThumbnail(String orgfile, int wsize, int hsize) throws IOException, NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		//	TODO CreateThumbnail	
		log.error("============== CreateThumbnail : START ==============");		
		boolean rtn_bl = false;
		String file_nm = "";
		String filenameext = ""; // 파일
		String cr_file_nm = "";
		int temp_file_idx = -1;

		try{
			if(orgfile==null){
				log.error("orgfile null");
				rtn_bl = false;
			}else{
				if(orgfile.equals("")){
					log.error("orgfile ''");
					rtn_bl = false;
				}else{
					filenameext = file_extstr(orgfile);
					temp_file_idx = orgfile.lastIndexOf("/");
					if(temp_file_idx > -1){
						file_nm = orgfile.substring(temp_file_idx+1);
						
						if(!filenameext.toLowerCase().equals("png") 
								&& !filenameext.toLowerCase().equals("jpg")
								&& !filenameext.toLowerCase().equals("gif")
								&& !filenameext.toLowerCase().equals("bmp")
								
						){
							log.error("orgfile ext fail");
							rtn_bl = false;
						}else{
							log.error("orgfile "+orgfile);
							log.error("orgfile ext "+filenameext);
							log.error("orgfile ext "+filenameext);
							log.error("orgfile path  "+orgfile.substring(0,temp_file_idx+1));
							cr_file_nm = orgfile.substring(0,temp_file_idx+1)+file_nm.replace("."+filenameext, "")+"_thum.png";
							log.error("cr_file_nm nm  "+cr_file_nm);
							
							// 해당파일이 위치한 곳에 _thum.png 파일생성
							Thumbnails.of(orgfile)
					        .size(wsize, hsize)
					        .outputFormat("png")
					        .toFile(cr_file_nm);	
							
							rtn_bl = true;
						}				
					}else{
						log.error("orgfile path fail");
						rtn_bl = false;
					}					
				}
				
			}

			


		}catch(IOException q){
			log.error("IOException:"+q);
			//throw new JSysException("CreateThumbnail 중 에러가 발생했습니다");	
			rtn_bl = false;
		}catch(NullPointerException q){
			log.error("NullPointerException:"+q);
			//throw new JSysException("CreateThumbnail 중 에러가 발생했습니다");	
			rtn_bl = false;
		}catch(ArrayIndexOutOfBoundsException q){
			log.error("ArrayIndexOutOfBoundsException:"+q);
			//throw new JSysException("CreateThumbnail 중 에러가 발생했습니다");	
			rtn_bl = false;
		}catch(Exception q){
			log.error("UploadInfo2 Exception:"+q);
			//throw new JSysException("CreateThumbnail 중 에러가 발생했습니다");		
			rtn_bl = false;
		}		


		log.error("============== CreateThumbnail : END ==============");
		return rtn_bl;
	}	

	/**
	 * 파일경로 확장자체크
	 * 'gif', 'jpg', 'bmp', 'png', 'hwp', 'xls', 'xlsx', 'zip', 'pdf', 'tif', 'doc', 'docx', 'ppt', 'pptx', 'txt'
	 * @param path 
	 * @return boolean 
	 */
	public static boolean fileExtFilter(String fileExt) {
		if("xls".equalsIgnoreCase(fileExt) 
			|| "xlsx".equalsIgnoreCase(fileExt)
			|| "doc".equalsIgnoreCase(fileExt)
			|| "docx".equalsIgnoreCase(fileExt)
			|| "hwp".equalsIgnoreCase(fileExt)
			|| "ppt".equalsIgnoreCase(fileExt)
			|| "ppts".equalsIgnoreCase(fileExt)
			|| "pptx".equalsIgnoreCase(fileExt)
			|| "txt".equalsIgnoreCase(fileExt)
			|| "gif".equalsIgnoreCase(fileExt)
			|| "jpg".equalsIgnoreCase(fileExt)
			|| "jpeg".equalsIgnoreCase(fileExt)
			|| "png".equalsIgnoreCase(fileExt)
			|| "zip".equalsIgnoreCase(fileExt)
			|| "bmp".equalsIgnoreCase(fileExt)
			|| "pdf".equalsIgnoreCase(fileExt)
			|| "tif".equalsIgnoreCase(fileExt)) {
			return true;
		}
		return false;
	}
}