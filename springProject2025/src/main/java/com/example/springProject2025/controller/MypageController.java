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

import com.example.springProject2025.dao.MypageService;
import com.example.springProject2025.dao.OrderService;
import com.example.springProject2025.dao.ReviewService;
import com.example.springProject2025.model.Order;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MypageController {

	@Autowired
	MypageService myInquiryService;
		
	@RequestMapping("home/mypage/my-inquiry.do")  
	public String mypageMyInquiry(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println("home/mypage/review-view.do 진입");
		
		
		return "home/mypage/my-inquiry"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/my-inquiry-detail.do")  
	public String mypageMyInquiryDetail(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/my-inquiry-detail.do 진입");
		System.out.println("들어온 map값" + map);
		request.setAttribute("inquiryNo", map.get("inquiryNo"));
		return "home/mypage/my-inquiry-detail"; // .jsp빠진형태
	}
	
	
	
	
	@RequestMapping(value = "home/mypage/my-inquiry.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String mypageMyinquiryList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/my-inquiry.dox 진입 집");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("들어온 map값 " + map);
		resultMap = myInquiryService.getMyInquiryList(map);
		System.out.println("페이지로 돌려줄 resultMap값 " + resultMap);
		return new Gson().toJson(resultMap); // [{},{}]

	}
	
	
	@RequestMapping(value = "home/mypage/my-inquiry-detail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String mypageMyinquiryListDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/my-inquiry-detail.dox 진입");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("들어온 map값 " + map);
		resultMap = myInquiryService.getMyInquiryDetail(map);
		System.out.println("페이지로 돌려줄 resultMap값 " + resultMap);
		return new Gson().toJson(resultMap); // [{},{}]

	}
	
	
	

}
