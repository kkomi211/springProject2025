package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.MyInquiry;
import com.example.springProject2025.model.Review;
import com.example.springProject2025.model.User;

@Mapper
public interface MypageMapper {

//	int insertMyInquiry(HashMap<String, Object> map);
	
	int selectMyInquiryListCnt(HashMap<String, Object> map);
	
	List<MyInquiry> selectMyInquiryList(HashMap<String, Object> map);

	MyInquiry selectMyInquiry(HashMap<String, Object> map);

	






	
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
	
	// 계정 삭제
	int deleteAccount(HashMap<String, Object> map);
	
}
