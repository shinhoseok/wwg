package com.ji.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ji.service.FileService;
import com.ji.vo.FileVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class FileController {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	//파일다운로드 (한개씩 다운로드)
	@RequestMapping(value = "/file/fileDownload.do")
	public void fileDownload(FileVO fileVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String contextPath = propertiesService.getString("UPLOADROOTPATH");
		String fileGubun = File.separator;
		String fullPath = "";
		String dateFolder = "";
		
		FileVO resultVO = fileService.selectFileDetail2(fileVO);
		
		if(resultVO.getUpdateFileNm().substring(0, 4).equals("ATCH")) {
			dateFolder = resultVO.getUpdateFileNm().substring(4, 12);
		} else if (resultVO.getUpdateFileNm().substring(0, 4).equals("IMGE")) {
			dateFolder = resultVO.getUpdateFileNm().substring(4, 12);
		} else {
			dateFolder = resultVO.getUpdateFileNm().substring(0, 8);
		}
		
		fullPath = contextPath+fileGubun+resultVO.getMenuCd()+fileGubun+dateFolder+fileGubun+resultVO.getUpdateFileNm();
		log.debug("fullPath>>>>"+fullPath);
		File file = new File(fullPath);
		log.debug(file.exists()+" >>>> "+file.isFile());
		if(file.exists() && file.isFile()) {
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setContentLength((int) file.length());
			String browser = getBrowser(request);
			String disposition = getDisposition(resultVO.getFileNm(), browser); //파일명 바뀔 때 주의
			response.setHeader("Content-Disposition", disposition);
			response.setHeader("Content-Transfer-Encoding", "binary");
			OutputStream out = response.getOutputStream();
			FileInputStream fis = null;
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			if(fis != null) {
				fis.close();
			}
			out.flush();
			out.close();
		}
	}
	
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if(header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
			return "MSIE";
		} else if(header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if(header.indexOf("Opera") > -1) {
			return "Opera";
		} else {
			return "Firefox";
		}
	}
	
	private String getDisposition(String fileName, String browser) throws UnsupportedEncodingException {
		String dispositionPrefix = "attachment;filename=";
		String encodedFileName = null;
		if(browser.equals("MSIE")) {
			encodedFileName = URLEncoder.encode(fileName, "UTF-8").replace("\\+", "%20");
		} else if(browser.equals("Firefox")) {
			encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+"\"";
		} else if(browser.equals("Opera")) {
			encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+"\"";
		} else if(browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for(int i=0; i<fileName.length(); i++) {
				char c = fileName.charAt(i);
				if(c > '~') {
					sb.append(URLEncoder.encode(""+c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFileName = sb.toString();
		}
		return dispositionPrefix+encodedFileName;
	}
}
