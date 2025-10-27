package com.example.springProject2025.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.User;

@Mapper
public interface MemberMapper {
	// 회원가입
	int userSignup(HashMap<String, Object> map);
	
	// 아이디 중복 확인
	User idCheck(HashMap<String, Object> map);
	
	// 닉네임 중복 확인
	User nicknameCheck(HashMap<String, Object> map);
	
}
