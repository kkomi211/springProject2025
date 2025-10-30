package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.CartMapper;
import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.model.Cart;
import com.example.springProject2025.model.Order;

@Service
public class CartService {

	@Autowired
	CartMapper cartMapper;

	public HashMap<String, Object> getCartList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = cartMapper.selectCartListCnt(map);
			List<Cart> list = cartMapper.selectCartList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("CartService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("CartService 에러: " + e.getMessage());
		}

		return resultMap;
	}

	

}
