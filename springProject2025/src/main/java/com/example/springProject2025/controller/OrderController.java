package com.example.springProject2025.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.OrderService;
import com.example.springProject2025.model.Order;
import com.example.springProject2025.model.RefundList;
import com.google.gson.Gson;

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
	// @RequestBody RequestContainer를 사용해 JSON을 받고, 내부에서 HashMap으로 변환
	public String refundReturnListAppli(Model model, @RequestBody RefundList refundList) throws Exception {
	    
	    System.out.println("home/mypage/efund-return-appli.dox 진입");
	    
	    // ----------------------------------------------------
	    // DTO(RequestContainer)를 HashMap으로 변환하여 기존 map 변수를 대체
	    // ----------------------------------------------------
	    
	    // 기존 @RequestParam map을 대체할 새로운 HashMap 생성
	    HashMap<String, Object> map = new HashMap<>(); 
	    
	    // sessionId와 orders 리스트를 HashMap에 담습니다.
	    map.put("sessionId", refundList.getSessionId());
	    map.put("orders", refundList.getOrders()); // List<Order> 타입이 담김
	    
	    // ----------------------------------------------------
	    
	    // sysout 테스트 (기존 방식 유지)
	    System.out.println("들어온 HashMap 형식 데이터-----S");
	    System.out.println(map); 
	    System.out.println("들어온 HashMap 형식 데이터-----E");
	    // 데이터가 잘 왔는지 확인
	    List<Order> orderList = (List<Order>) map.get("orders");
	    if (orderList != null) {
	        System.out.println("Orders List Size: " + orderList.size());
	        for (Order order : orderList) {
	            System.out.println("  > OrderNo: " + order.getOrderNo() + ", ActionType: " + order.getActionType());
	        }
	    }
	    
	    // ... 나머지 기존 로직 유지
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
//	    resultMap = orderService.getRefundListAppli(map); // <--- map 변수를 사용하여 서비스 호출

	    return new Gson().toJson(resultMap);
	}
	
}
