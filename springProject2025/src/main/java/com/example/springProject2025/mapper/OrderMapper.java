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

	// 교환환불목록
	int selectRefundListCount(HashMap<String, Object> map);

	// 교환환불목록
	List<Order> selectRefundList(HashMap<String, Object> map);
	
	// 반품/교환 신청 처리
	int updateRefundExchange(HashMap<String, Object> map);

	//리뷰리스트 개수
	int selectReviewListCount(HashMap<String, Object> map);
	
	//리뷰리스트
	List<Order> selectReviewList(HashMap<String, Object> map);
	
	//리스트 인서트방식 (중단 상황)
	int insertOrderList(List<HashMap<String, Object>> orderList);

	//단일 인서트 방식
	int insertOrderItem(HashMap<String, Object> item);
	
	// 신규 주문 완료 후, 해당 사용자의 가장 최근 주문 시간을 조회하여 주문하자마자 보여주기 목적
	String selectRecentOrderDate(String userId);
	

}
