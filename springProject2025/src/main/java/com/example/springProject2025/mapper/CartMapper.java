package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;
import com.example.springProject2025.model.Cart;
import com.example.springProject2025.model.MyInquiry;

@Mapper
public interface CartMapper {

	
	int selectCartListCnt(HashMap<String, Object> map);
	
	List<Cart> selectCartList(HashMap<String, Object> map);

	//카트안에 상품지울때 씀 2개 이상 넘어오기도함
	int deleteCartItemList(HashMap<String, Object> map);

	Cart selectProductByProductNo(HashMap<String, Object> map);

	List<Cart> selectRelatedProductOptions(HashMap<String, Object> map);

	//모달창에서 제품 사이즈 수량 수정
	int updateCartItem(HashMap<String, Object> map);
	

}
