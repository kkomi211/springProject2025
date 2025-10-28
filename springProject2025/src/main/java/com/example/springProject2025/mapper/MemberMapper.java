package com.example.springProject2025.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.User;

@Mapper
public interface MemberMapper {
	
	// 로그인
	User userLogin(HashMap<String, Object> map);
	
	// 회원가입
	int userSignup(HashMap<String, Object> map);
	
	// 아이디 중복 확인
	User idCheck(HashMap<String, Object> map);
	
	// 닉네임 중복 확인
	User nicknameCheck(HashMap<String, Object> map);
	
	// 아이디 찾기
	int idSearch(HashMap<String, Object> map);
	
	// 비밀먼호 찾기
	int pwdSearch(HashMap<String, Object> map);
	
	// 아이디 뽑기
	User idRetrieve(HashMap<String, Object> map);
	
	//비밀번호 변경
	int pwdChange(HashMap<String, Object> map);
	
}
