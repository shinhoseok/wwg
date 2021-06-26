package com.ji.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ji.service.BoardMngService;
import com.ji.service.FileService;
import com.ji.vo.BoardVO;
import com.ji.vo.FileVO;

@Controller
public class BoardMngController {
	
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "boardMngService")
	private BoardMngService boardMngService;
	
	//게시판 등록
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/admin/board/insertBoardProc.do")
	public String insertBoardProc(MultipartHttpServletRequest multiRequest, @ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, SessionStatus status) throws Exception {
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		String pcode = boardVO.getMenuCd();
		String message = "";
		String redirectUrl = "";
		FileVO fileVO = new FileVO();
		if(null != SITE_SESS) {
			fileVO.setRegId(String.valueOf(SITE_SESS.get("USER_ID")));
			List<MultipartFile> multiFileList = multiRequest.getFiles("files");
			fileVO.setMenuCd(boardVO.getMenuCd());
			fileVO.setFileGroup("1");
			//파일 저장
			List<FileVO> fileList = fileService.commonFileUpload(multiFileList, fileVO);
			
			boardVO.setRegId(String.valueOf(SITE_SESS.get("USER_ID")));
			boardVO.setRegNm(String.valueOf(SITE_SESS.get("USER_NM")));
			boardMngService.insertBoardProc(boardVO, fileList);
			status.setComplete();//중복서브밋 방지
			
			redirectUrl = "/KomipoWwg/cmsmain.do?scode=sysadm&pcode="+pcode+"&pstate=L";
			message = "정상적으로 등록되었습니다.";
		} else {
			redirectUrl = "/KomipoWwg/cmsmain.do?scode=sysadm&pcode=loginF";
			message = "로그인 후 이용 가능합니다.";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("redirectUrl", redirectUrl);
	
		return "jsonView";
	}
	
	//게시판 수정
	@RequestMapping(value = "/admin/board/updateBoardProc.do")
	public String updateBoardProc(MultipartHttpServletRequest multiRequest, @ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request, SessionStatus status) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		String pcode = boardVO.getMenuCd();
		String message = "";
		String redirectUrl = "";
		boardVO.setModId(String.valueOf(SITE_SESS.get("USER_ID")));
		List<MultipartFile> multiFileList = multiRequest.getFiles("files");
		FileVO paramVO = new FileVO();
		paramVO.setMenuCd(boardVO.getMenuCd());
		paramVO.setRegId(boardVO.getModId());
		paramVO.setFileGroup("1");
		List<FileVO> fileList = fileService.commonFileUpload(multiFileList, paramVO);
		boardMngService.updateBoardProc(boardVO, fileList);
		status.setComplete(); //중복서브밋 방지
		
		redirectUrl = "/KomipoWwg/cmsmain.do?scode=sysadm&pcode="+pcode+"&pstate=R&dataSeqno="+boardVO.getDataSeqno();
		message = "정상적으로 수정되었습니다.";
		
		model.addAttribute("message", message);
		model.addAttribute("redirectUrl", redirectUrl);
		
		return "jsonView";
	}
	
	//댓글 목록 ajax
	@RequestMapping(value = "/admin/board/selectBoardReviewList.do")
	public String selectBoardReviewList(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		
		List<BoardVO> commentList = boardMngService.selectBoardReviewList(boardVO);
		model.addAttribute("commentList", commentList);
		
		return "/cmsadmin/cm/abd/jicm_abd_010_r1_ajax";
	}
	
	//댓글 등록 ajax
	@RequestMapping(value = "/admin/board/insertBoardReviewProc.do")
	public String insertBoardReviewProc(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, SessionStatus status) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		boardVO.setRegId(String.valueOf(SITE_SESS.get("USER_ID")));
		boardVO.setRegNm(String.valueOf(SITE_SESS.get("USER_NM")));
		boardMngService.insertBoardReviewProc(boardVO);
		status.setComplete(); //중복 서브밋 방지
		return "jsonView";
	}
	
	//댓글 수정 ajax
	@RequestMapping(value = "/admin/board/updateBoardReviewProc.do")
	public String updateBoardReviewProc(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, SessionStatus status) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		boardVO.setModId(String.valueOf(SITE_SESS.get("USER_ID")));
		boardMngService.updateBoardReviewProc(boardVO);
		status.setComplete(); //중복 서브밋 방지
		return "jsonView";
	}
	
	//댓글  삭제 ajax
	@RequestMapping(value = "/admin/board/deleteBoardReviewProc.do")
	public String deleteBoardReviewProc(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request, ModelMap model, SessionStatus status) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, Object> SITE_SESS = (Map<String, Object>) request.getSession().getAttribute("SITE_ADM_SESS");
		boardVO.setDelId(String.valueOf(SITE_SESS.get("USER_ID")));
		boardMngService.deleteBoardReviewProc(boardVO);
		status.setComplete(); //중복 서브밋 방지
		return "jsonView";
	}
	
	//공고리스트
	@RequestMapping(value = "/admin/board/selectGongGoList.do")
	public String selectGongGoList(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		
		List<BoardVO> gongGoList = boardMngService.selectBoardReviewList(boardVO);
		model.addAttribute("gongGoList", gongGoList);
		
		return "/cmsadmin/cm/abd/jicm_abd_010_r1_ajax2";
	}
}
