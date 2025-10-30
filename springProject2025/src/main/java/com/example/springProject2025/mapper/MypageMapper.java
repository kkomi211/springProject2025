package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.MyInquiry;
import com.example.springProject2025.model.Review;

@Mapper
public interface MypageMapper {

//	int insertMyInquiry(HashMap<String, Object> map);
	
	int selectMyInquiryListCnt(HashMap<String, Object> map);
	
	List<MyInquiry> selectMyInquiryList(HashMap<String, Object> map);

	MyInquiry selectMyInquiry(HashMap<String, Object> map);

	

}
