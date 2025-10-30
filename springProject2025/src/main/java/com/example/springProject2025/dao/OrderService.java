package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.model.Order;

@Service
public class OrderService {

	@Autowired
	OrderMapper orderMapper;

	public HashMap<String, Object> getOrderList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectOrderListCount(map);
			List<Order> list = orderMapper.selectOrderList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}

		return resultMap;
	}

	public String getUserName(String userId) {
		try {
			return orderMapper.selectUserName(userId);
		} catch (Exception e) {
			System.out.println("getUserName 에러: " + e.getMessage());
			return "Guest";
		}
	}

	public HashMap<String, Object> cancelOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.updateOrderCancel(map);

			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("주문취소 요청 완료 - 주문번호: " + map.get("orderNo"));

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("주문취소 에러: " + e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> getRefundList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectRefundListCount(map);
			List<Order> list = orderMapper.selectRefundList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}


		return resultMap;
	}

	public HashMap<String, Object> processRefundExchange(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			@SuppressWarnings("unchecked")
			List<Order> orderList = (List<Order>) map.get("orders");
			
			if (orderList == null || orderList.isEmpty()) {
				resultMap.put("result", "fail");
				resultMap.put("message", "처리할 주문이 없습니다.");
				return resultMap;
			}

			int totalUpdated = 0;
			
			for (Order order : orderList) {
				HashMap<String, Object> updateMap = new HashMap<String, Object>();
				updateMap.put("orderNo", order.getOrderNo());
				updateMap.put("reason", order.getReason());
				
				// actionType에 따라 STATUS 설정: 'R' = 반품요청, 'C' = 교환요청
				if ("R".equals(order.getActionType())) {
					updateMap.put("status", "반품요청");
				} else if ("C".equals(order.getActionType())) {
					updateMap.put("status", "교환요청");
				} else {
					// 기본값은 반품요청
					updateMap.put("status", "반품요청");
				}
				
				int cnt = orderMapper.updateRefundExchange(updateMap);
				totalUpdated += cnt;
				
				System.out.println("반품/교환 신청 처리 - 주문번호: " + order.getOrderNo() + 
				                  ", 상태: " + updateMap.get("status") + ", 처리 건수: " + cnt);
			}

			resultMap.put("cnt", totalUpdated);
			resultMap.put("result", "success");
			resultMap.put("message", "정상적으로 신청이 접수되었습니다.");

		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "처리 중 오류가 발생했습니다: " + e.getMessage());
			System.out.println("반품/교환 신청 처리 에러: " + e.getMessage());
			e.printStackTrace();
		}

		return resultMap;
	}

	public HashMap<String, Object> getReviewList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectReviewListCount(map);
			List<Order> list = orderMapper.selectReviewList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}

		return resultMap;
	}

}
