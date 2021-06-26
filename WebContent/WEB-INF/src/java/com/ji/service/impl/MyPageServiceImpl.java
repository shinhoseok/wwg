package com.ji.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ji.dao.UserDao;
import com.ji.service.MyPageService;
import com.ji.user.service.UserVO;

@Service("myPageService")
public class MyPageServiceImpl implements MyPageService {
	
	@Resource(name="userDao")
	private UserDao userDao;
	
	//사용자 패스워드 변경시 자신의 패스워드인지 확인한다.
	public Integer selectCurrentPwdChk(UserVO userVO) throws Exception {
		return userDao.selectUserDetail(userVO);
	}
}
