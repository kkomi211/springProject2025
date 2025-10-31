package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.CartMapper;
import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.model.Admin;
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

	public HashMap<String, Object> removeCartItemList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = cartMapper.deleteCartItemList(map);

		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		
		return resultMap;
	}

	public HashMap<String, Object> getProductOptions(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
//	        String originalProductNo = (String) map.get("productNo");
	        Cart productDetails = cartMapper.selectProductByProductNo(map); // productNo로 제품 상세 정보 조회
	        
	        if (productDetails != null) {
	            // 동일 브랜드, 동일 제품명(괄호 전 부분)의 모든 제품 목록 조회
	            // 제품명에서 괄호 부분을 제거한 '제품명_줄기'를 매퍼에 전달
	        	String baseProductName = productDetails.getProductName().replaceAll("\\s*\\(.*\\)", "").trim(); 
	            map.put("baseProductName", baseProductName);
	            map.put("brand", productDetails.getBrand());
	            
	            List<Cart> productOptions = cartMapper.selectRelatedProductOptions(map);
	            resultMap.put("options", productOptions);
	            resultMap.put("result", "success");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "해당 제품을 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "제품 옵션 조회 중 오류: " + e.getMessage());
	        System.err.println("제품 옵션 조회 중 오류: " + e.getMessage());
	    }
	    return resultMap;
	}

	public HashMap<String, Object> editCartItem(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int info = cartMapper.updateCartItem(map);

			resultMap.put("info", info);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

		
		return resultMap;
	}

	

}
