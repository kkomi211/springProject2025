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
import com.example.springProject2025.dao.ReviewService;
import com.example.springProject2025.model.Order;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReviewController {

	@Autowired
	ReviewService reviewService;

	@Autowired
	OrderService orderService;
	
	@RequestMapping("home/mypage/review.do")  //본인이 산 배송완료 물건 리스트 보임
	public String mypagereview(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/review.do 진입");
		System.out.println("들어온 map값" + map);
		request.setAttribute("orderNo", map.get("orderNo"));
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/review"; // .jsp빠진형태
	}
	

	
	@RequestMapping("home/mypage/review-write.do")  //마이페이지에서 제품리뷰쓸수 있음
	public String mypageReviewWrite(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/review-write.do 진입");
		System.out.println("들어온 map값" + map);
		request.setAttribute("orderNo", map.get("orderNo"));
		request.setAttribute("productNo", map.get("productNo"));
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("quantity", map.get("quantity"));
		request.setAttribute("paymentAmount", map.get("paymentAmount"));
		request.setAttribute("udate", map.get("udate"));
		request.setAttribute("imgPath", map.get("imgPath"));
		request.setAttribute("imgName", map.get("imgName"));
		request.setAttribute("status", map.get("status"));
		request.setAttribute("productName", map.get("productName"));
		return "home/mypage/review-write"; // .jsp빠진형태
	}
	
	
	@RequestMapping(value = "home/mypage/reviewlist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewlist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/reviewList.dox 진입");
		System.out.println("들어온 map값 "  + map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = orderService.getReviewList(map);
		
		return new Gson().toJson(resultMap); // [{},{}]
	}
	
	
	@RequestMapping("home/mypage/review-write.dox")  //리뷰쓰기 버튼 누르면 동작
	@ResponseBody
	public String mypageReviewWritedox(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("home/mypage/review-write.dox 진입");
		System.out.println("들어온 map값" + map);
		
		resultMap = reviewService.addReview(map);
//		System.out.println("resultMap은 " + resultMap);
		return new Gson().toJson(resultMap);
	}
	
	
	

}
