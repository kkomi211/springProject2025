package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Order;

@Mapper
public interface ReviewMapper {

	int insertReview(HashMap<String, Object> map);
	
	

	

}
