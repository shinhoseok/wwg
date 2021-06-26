package com.ji.dao.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ji.dao.UserDao;
import com.ji.user.service.UserVO;

@Repository("userDao")
public class UserDaoJdbc implements UserDao {
	
	protected Logger log = Logger.getLogger(UserDaoJdbc.class);
	
	@Resource(name="sqlMapClient")
	private SqlMapClient sql;
	
	//사용자 패스워드 변경시 자신의 패스워드인지 확인한다.
	public Integer selectUserDetail(UserVO userVO) throws Exception {
		return (Integer) sql.queryForObject("user.selectUserDetail", userVO);
	}
}
