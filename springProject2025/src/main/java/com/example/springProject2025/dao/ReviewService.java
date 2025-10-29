package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.mapper.ReviewMapper;
import com.example.springProject2025.model.Order;

@Service
public class ReviewService {

	@Autowired
	ReviewMapper reviewMapper;

	public HashMap<String, Object> addReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {

			System.out.println("서버로 들어온 데이터 확인 addReview " + map);
			int cnt = reviewMapper.insertReview(map);

			resultMap.put("reviewNum", map.get("reviewNum"));
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

}
