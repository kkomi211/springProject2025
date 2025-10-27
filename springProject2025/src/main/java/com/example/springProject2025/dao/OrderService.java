package com.example.springProject2025.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.OrderMapper;

@Service
public class OrderService {

	@Autowired
	OrderMapper orderMapper;
	
	public HashMap<String, Object> orderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
