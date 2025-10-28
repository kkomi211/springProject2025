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

}
