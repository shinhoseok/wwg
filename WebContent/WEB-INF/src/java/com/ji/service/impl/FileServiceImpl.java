package com.ji.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ji.common.DateUtility;
import com.ji.common.FileUtility;
import com.ji.common.StringUtil;
import com.ji.dao.inter.FileDao;
import com.ji.service.FileService;
import com.ji.vo.FileVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("fileService")
public class FileServiceImpl implements FileService {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="txManagerds")
	private DataSourceTransactionManager txManager;
	
	@Resource(name="fileDao")
	private FileDao fileDao;
	
	@Resource(name = "propertiesService")
	private EgovPropertyService propertiesService;
	
	//파일 상세보기
	public FileVO selectFileDetail(FileVO fileVO) throws Exception {
		return fileDao.selectFileDetail(fileVO);
	}
	
	//파일 상세보기2
	public FileVO selectFileDetail2(FileVO fileVO) throws Exception {
		return fileDao.selectFileDetail2(fileVO);
	}
	
	//공통파일업로드(실제파일 저장 및 저장쿼리에 필요한 파일리스트 객체 리턴)
	//param
	//1. multiFileList : MultipartHttpServletRequest 로 받은 request객체
	//2. FileVO : 메뉴코드랑 등록자 아이디를 셋팅한 VO객체
	public List<FileVO> commonFileUpload(List<MultipartFile> multiFileList, FileVO paramVO) throws Exception {
		List<FileVO> fileList = new ArrayList<FileVO>();
		String today = DateUtility.getCurrentDateTime("");
		String today1 = DateUtility.getCurrentDateTime("yyyyMMdd");
		String realPath = propertiesService.getString("UPLOADROOTPATH");
		String pcode = paramVO.getMenuCd();
		String regId = paramVO.getRegId();
		String fileGroup = paramVO.getFileGroup();
		
		if(StringUtil.isEmpty(pcode)) { //pcode와 regId를 미리 셋팅해서 넘겨줘야함.
			return fileList;
		}
		
		if(StringUtil.isEmpty(realPath)){ //경로여부 체크
			return fileList;
		}
		
		realPath = realPath + File.separator + pcode + File.separator + today1;
		File dir = new File(realPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		String fileName = today + "_" + pcode;
		if (multiFileList.size() == 1 && multiFileList.get(0).getOriginalFilename().equals("")) {
			//파일이 없으면 할게 없어
		} else {
			for (int i = 0; i < multiFileList.size(); i++) {
				String orgFileNm = multiFileList.get(i).getOriginalFilename();
				orgFileNm = orgFileNm.replaceAll("'", "_");
				int index = orgFileNm.lastIndexOf(".");
				String fileExt = orgFileNm.substring(index + 1);
				if (FileUtility.fileExtFilter(fileExt)) {
					FileVO fileVO = new FileVO();
					fileVO.setMenuCd(pcode);
					fileVO.setFileGroup(fileGroup);
					fileVO.setRegId(regId);
					fileVO.setFileNm(orgFileNm);
					fileVO.setUpdateFileNm(fileName + "_" + i);
					fileVO.setFileOrderNo(i);
					fileVO.setFileSize(String.valueOf(multiFileList.get(i).getSize()));
					multiFileList.get(i).transferTo(new File(realPath + File.separator + fileVO.getUpdateFileNm()));
					fileList.add(fileVO);
				} 
			}
		}
		return fileList;
	}
}
