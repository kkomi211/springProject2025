package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.CartService;
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
	


}
