package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//import ch.qos.logback.core.model.Model;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	
	// @value ==> 카카오 록인
	
	@Value("${client_id}") // the name should be the same as the one in application.properties
	private String client_id;

    @Value("${redirect_uri}")
    private String redirect_uri;
	
	@RequestMapping("home.do")
	public String userList(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/home"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/chat.do")
	public String chat(Model model) throws Exception {
		return "home/chat"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/board.do")
	public String board(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
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
		// 카카오 록인
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+client_id+"&redirect_uri="+redirect_uri;
        model.addAttribute("location", location);
		return "home/login"; // .jsp빠진형태
	}
	
//	@RequestMapping("home/cart.do")
//	public String cart(Model model) throws Exception {
//		return "home/cart"; // .jsp빠진형태
//	}
	
	@RequestMapping("home/signup.do")
	public String signup(Model model) throws Exception {
		return "home/signup"; // .jsp빠진형태
	}
	
	@RequestMapping("home/product.do")
	public String product(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("category", map.get("category"));
		request.setAttribute("keyword", map.get("keyword"));
		System.out.println(map);
		return "home/product"; // .jsp빠진형태
	}
	
	@RequestMapping("home/sales.do")
	public String sales(Model model) throws Exception {
		return "home/sales"; // .jsp빠진형태
	}
	
	@RequestMapping("home/product-info.do")
    public String productInfo(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
        request.setAttribute("productNo", map.get("productNo"));
        return "home/product-info"; // .jsp 빠진 형태
    }
	
	@RequestMapping("home/addr.do")
	public String addr(Model model) throws Exception {
		return "home/jusoPopup"; // 주소 검색 팝업 (.jsp빠진형태)
	}

}
