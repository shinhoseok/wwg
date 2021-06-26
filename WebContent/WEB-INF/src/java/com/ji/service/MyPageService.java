package com.ji.service;

import com.ji.user.service.UserVO;

public interface MyPageService {
	//사용자 패스워드 변경시 자신의 패스워드인지 확인한다.
	public Integer selectCurrentPwdChk(UserVO userVO) throws Exception;
}
