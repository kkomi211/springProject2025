package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.OrderService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {

	
	@Autowired
	OrderService orderService;
	
	@RequestMapping("home/mypage/orders.do")
	public String orders(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/orders.do진입");
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/orders"; // .jsp빠진형태
	}
	
	@RequestMapping(value = "home/mypage/orders.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderslist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/orders.dox 진입 집");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = orderService.getOrderList(map);
		
		return new Gson().toJson(resultMap); // [{},{}]
	}
	
	@RequestMapping(value = "home/mypage/userInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getUserInfo(Model model, @RequestParam String userId) throws Exception {
		System.out.println("home/mypage/userInfo.dox 진입: " + userId);
		String userName = orderService.getUserName(userId);
		if (userName == null) {
			userName = "Guest";
		}
		return new Gson().toJson(userName);
	}
	
	@RequestMapping(value = "home/mypage/cancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String cancelOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/cancel.dox 진입: " + map);
		HashMap<String, Object> resultMap = orderService.cancelOrder(map);
		return new Gson().toJson(resultMap);
	}
	
}
