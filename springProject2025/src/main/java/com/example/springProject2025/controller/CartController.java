package com.example.springProject2025.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.CartService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CartController {

	
	@Autowired
	CartService cartService;
	
	@RequestMapping("home/cart.do")
	public String orders(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
	//		System.out.println("home/mypage/orders.do진입");
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/cart"; // .jsp빠진형태
	}
	
	
	@RequestMapping(value = "home/cart.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderslist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/cart.dox 진입 집");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = cartService.getCartList(map);
		System.out.println("프론트로 돌려주기직전 resultMap " + resultMap);
		return new Gson().toJson(resultMap); // [{},{}]
	}
	
	@RequestMapping(value = "home/cartItemDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String cartItemDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

	    System.out.println("home/cartItemDelete.dox임 들어온 map은 " + map); 

	    // 1. 프론트에서 전송한 JSON 문자열을 "selectedCartNosJson" 키로 받습니다.
	    String jsonString = (String) map.get("selectedCartNosJson");

	    // 2. JSON 문자열을 List<Object> 형태로 파싱합니다.
	    List<Object> cartNoList = new ArrayList<>();
	    if (jsonString != null) {
	        ObjectMapper mapper = new ObjectMapper();
	        // JSON 문자열을 List<Object> (혹은 List<String>)으로 변환
	        cartNoList = mapper.readValue(jsonString, new TypeReference<List<Object>>() {});
	    }
	    
	    // 3. 서비스로 전달할 paramMap을 구성합니다.
	    // 기존 map에는 sessionId와 jsonString이 들어있습니다.
	    map.put("list", cartNoList); // 삭제할 cartNo 목록을 'list' 키로 서비스에 전달

	    System.out.println("cartItemDelete.dox임 파싱된 cartNoList: " + cartNoList); 

	    // 4. 서비스 호출 (삭제 실행)
	    resultMap = cartService.removeCartItemList(map); 
	    System.out.println("프론트로 되돌려주기 직전 " + resultMap);

	    return new Gson().toJson(resultMap);
	
	}

}
