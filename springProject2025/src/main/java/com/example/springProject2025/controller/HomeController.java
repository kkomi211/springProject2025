package com.example.springProject2025.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.model.Model;

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
	
	@RequestMapping("home/mypage/inquery.do")
	public String inquery(Model model) throws Exception {
		return "home/inquery"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/orders.do")
	public String orders(Model model) throws Exception {
		System.out.println("home/mypage/orders.do진입");
		return "home/mypage/orders"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/refund-return.do")
	public String refundReturn(Model model) throws Exception {
		return "home/refund-return"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/information.do")
	public String information(Model model) throws Exception {
		return "home/information"; // .jsp빠진형태
	}
	
	@RequestMapping("home/mypage/review.do")
	public String review(Model model) throws Exception {
		return "home/review"; // .jsp빠진형태
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
	

}
