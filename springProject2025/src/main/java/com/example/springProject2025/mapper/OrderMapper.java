package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Order;

@Mapper
public interface OrderMapper {
	
	// 전체 개수(페이징)
	int selectOrderListCount(HashMap<String, Object> map);
	
	// 목록(페이징)
	List<Order> selectOrderList(HashMap<String, Object> map);
	
	// 사용자 이름 조회
	String selectUserName(String userId);
	
	// 주문취소 요청
	int updateOrderCancel(HashMap<String, Object> map);

}
