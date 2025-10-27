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
		List<Order> orderList = orderMapper.selectOrderList(map);
		resultMap.put("list", orderList);
		System.out.println("주문 리스트 크기: " + orderList.size()); //페이징할때 대비
		return resultMap;
	}

}
