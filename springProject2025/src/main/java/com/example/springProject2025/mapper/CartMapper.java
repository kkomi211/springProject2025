package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Cart;
import com.example.springProject2025.model.MyInquiry;

@Mapper
public interface CartMapper {

	
	int selectCartListCnt(HashMap<String, Object> map);
	
	List<Cart> selectCartList(HashMap<String, Object> map);
	

}
