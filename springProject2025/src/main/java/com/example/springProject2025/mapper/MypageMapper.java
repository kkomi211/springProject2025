package com.example.springProject2025.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.User;

@Mapper
public interface MypageMapper {
	
	// 사용자 정보
	User userInfo(HashMap<String, Object> map);
	
	// 비밀번호 확인
	User checkPwd(HashMap<String, Object> map);
	
	// 이메일 중복 확인
	int checkEmail(HashMap<String, Object> map);
	
	// 이메일 수장
	int insertNewEmail(HashMap<String, Object> map);
	
	// 이름 수장
	int insertNewName(HashMap<String, Object> map);
	
	// 전화번호 수장
	int insertNewPhone(HashMap<String, Object> map);
	
	// 주소 수장
	int insertNewAddr(HashMap<String, Object> map);
	
}
