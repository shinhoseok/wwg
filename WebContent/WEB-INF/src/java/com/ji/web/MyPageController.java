package com.ji.web;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ji.service.MyPageService;
import com.ji.user.service.UserVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class MyPageController {
	protected Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "myPageService")
	private MyPageService myPageService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	public static final String BIZNUM_SESSION_KEY = "biznum";
	
	@RequestMapping(value = "/mypage/selectCurrentPwdChk.do")
	public String selectCurrentPwdChk(UserVO userVO, ModelMap model, HttpServletRequest request) throws Exception {
		//세션정보 빼야함
		Map<String, Object> sessionMap = (Map<String, Object>) request.getSession().getAttribute("SITE_SESS");
		log.debug("현재 패스워드 >>>> "+userVO.getUserPwd());
		log.debug("사용자아이디 세션 >>> "+sessionMap.get("USER_ID"));
		String userId = (String) sessionMap.get("USER_ID");
		userVO.setUserId(userId);
		int cnt = myPageService.selectCurrentPwdChk(userVO);
		log.debug("패스워드 카운트 >>>>>>> "+cnt);
		model.addAttribute("result", cnt);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/mypage/bizNumberSessionAdd.do")
	public String bizNumberSessionAdd(@RequestParam("bizNum") String bizNum, HttpServletRequest request) throws Exception {
		request.getSession().setAttribute(BIZNUM_SESSION_KEY, bizNum);
		return "jsonView";
	}
	
	//개구멍업로드
	@RequestMapping(value = "/mypage/biz.do")
	public String biz(ModelMap model) {
		model.addAttribute("result", "N");
		return "/ji/my/myp/myInsert";
	}
	
	//개구멍업로드
	@RequestMapping(value = "/mypage/insertBiz.do")
	public String insertBiz(MultipartHttpServletRequest multiRequest, ModelMap model) {
		try {
			String webRoot = propertiesService.getString("CONTEXTROOT_REALPATH");
			webRoot = webRoot+File.separator+"upfiles";
			MultipartFile multiFile = multiRequest.getFile("molFile");
			multiFile.transferTo(new File(webRoot+File.separator+multiFile.getOriginalFilename()));
			model.addAttribute("result", "Y");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/ji/my/myp/myInsert";
	}
}
