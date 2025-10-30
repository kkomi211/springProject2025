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

import com.example.springProject2025.dao.OrderService;
import com.example.springProject2025.model.Order;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {

	
	@Autowired
	OrderService orderService;
	
	@RequestMapping("home/mypage/orders.do")
	public String orders(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
//		System.out.println("home/mypage/orders.do진입");
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/orders"; // .jsp빠진형태
	}
	
	
	@RequestMapping("home/mypage/refund-return.do")
	public String refundreturn(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/refund-return.do 진입");
		System.out.println("들어온 map값" + map);
		request.setAttribute("orderNo", map.get("orderNo"));
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/refund-return"; // .jsp빠진형태
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
	
	
	@RequestMapping(value = "home/mypage/refund-return.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String refundReturnList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/refund-return.dox 진입");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = orderService.getRefundList(map);
		
		return new Gson().toJson(resultMap); // [{},{}]
	}
	
	
	
	@RequestMapping(value = "home/mypage/refund-return-appli.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String refundReturnListAppli(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    
	    System.out.println("home/mypage/refund-return-appli.dox 진입");
	    
	    // ordersJson 파라미터에서 JSON 문자열을 받아서 파싱
	    String ordersJson = (String) map.get("ordersJson");
	    
	    List<Order> orderList = new ArrayList<>();
	    
	    if (ordersJson != null && !ordersJson.isEmpty()) {
	        // JSON 문자열을 List<Order>로 변환
	        Gson gson = new Gson();
	        Type listType = new TypeToken<List<Order>>(){}.getType();
	        orderList = gson.fromJson(ordersJson, listType);
	    }
	    
	    // HashMap에 담기
	    HashMap<String, Object> paramMap = new HashMap<>();
	    paramMap.put("sessionId", map.get("sessionId"));
	    paramMap.put("orders", orderList);
	    
	    // sysout 테스트
	    System.out.println("들어온 HashMap 형식 데이터-----S");
	    System.out.println("sessionId: " + paramMap.get("sessionId"));
	    System.out.println("Orders List Size: " + orderList.size());
	    if (orderList != null && !orderList.isEmpty()) {
	        for (Order order : orderList) {
	            System.out.println("  > OrderNo: " + order.getOrderNo() + ", ActionType: " + order.getActionType());
	        }
	    }
	    System.out.println("들어온 HashMap 형식 데이터-----E");
	    
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = orderService.processRefundExchange(paramMap);

	    return new Gson().toJson(resultMap);
	}
	
	
	


}
