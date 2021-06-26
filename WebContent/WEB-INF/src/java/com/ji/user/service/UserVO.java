package com.ji.user.service;

public class UserVO {
	//사용자 아이디
	private String userId;
	//사용자 패스워드
	private String userPwd;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
}
