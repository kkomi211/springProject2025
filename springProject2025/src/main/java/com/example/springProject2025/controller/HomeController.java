package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	@RequestMapping("home.do")
	public String userList(Model model) throws Exception {
		return "home/home"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/chat.do")
	public String chat(Model model) throws Exception {
		return "home/chat"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/board.do")
	public String board(Model model) throws Exception {
		return "home/board"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/crew.do")
	public String crew(Model model) throws Exception {
		return "home/crew"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/inquiry.do")
	public String inquery(Model model) throws Exception {
		return "home/inquiry"; // .jsp빠진형태
	}
	
	
	@RequestMapping("home/mypage/information.do")
	public String information(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/information"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/information/change.do")
	public String informationChange(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/information-change"; // .jsp빠진형태
	}
	
	@RequestMapping("home/login.do")
	public String iogin(Model model) throws Exception {
		return "home/login"; // .jsp빠진형태
	}
	
	@RequestMapping("home/cart.do")
	public String cart(Model model) throws Exception {
		return "home/cart"; // .jsp빠진형태
	}
	
	@RequestMapping("home/signup.do")
	public String signup(Model model) throws Exception {
		return "home/signup"; // .jsp빠진형태
	}
	
	@RequestMapping("home/product.do")
	public String product(Model model) throws Exception {
		return "home/product"; // .jsp빠진형태
	}
	
	@RequestMapping("home/sales.do")
	public String sales(Model model) throws Exception {
		return "home/sales"; // .jsp빠진형태
	}
	
	@RequestMapping("home/product-info.do")
    public String productInfo(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        request.setAttribute("productNo", map.get("productNo"));
        return "home/product-info"; // .jsp 빠진 형태
    }

}
