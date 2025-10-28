package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;

@Mapper
public interface AdminMapper {
	
	// 상품 문의 목록 호출
	List<Admin> selectInquiryList(HashMap<String, Object> map);
	
	// 상품 문의글 상세보기
	Admin selectInquiry(HashMap<String, Object> map);
	
	// 관리자 답변 등록/수정
	int updateInquiryAnswer(HashMap<String, Object> map);
	
	// 상품 문의 총 개수 조회
	int selectInquiryListCount(HashMap<String, Object> map);
	
	// 주문 목록 조회
	List<Admin> selectOrdersList(HashMap<String, Object> map);

	// 주문 총 개수 조회
	int selectOrdersListCount(HashMap<String, Object> map);

	// 주문 상태 업데이트
	int updateOrderStatus(HashMap<String, Object> map);
}
