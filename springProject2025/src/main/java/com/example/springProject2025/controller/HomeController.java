package com.example.springProject2025.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.example.springProject2025.dao.HomeService;
import com.example.springProject2025.model.Home;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	
	@Autowired
	HomeService homeService;
	
	@Value("${client_id}")
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
		return "home/login"; // .jsp빠진형태
	}
	
	@RequestMapping("home/testjghlogin.do")
	public String testjghlogin(Model model) throws Exception {
		String location = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=" + client_id
				+ "&redirect_uri=" + redirect_uri;
		model.addAttribute("location", location);
		System.out.println("home/testjghlogin.do 테스트중");
		return "home/testjghlogin"; // .jsp빠진형태
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
	
	/**
     * 메인 슬라이드 이미지 데이터 조회 (AJAX)
     */
    @GetMapping("/api/mainSlideImages.dox")
    @ResponseBody
    public String getMainSlideImages() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<Home> slideImages = homeService.getMainSlideImages();
            resultMap.put("result", "success");
            resultMap.put("data", slideImages);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "메인 슬라이드 이미지 조회 중 오류: " + e.getMessage());
            System.err.println("메인 슬라이드 이미지 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 추천 상품 목록 조회 (AJAX)
     */
    @GetMapping("/api/recommendedProducts.dox")
    @ResponseBody
    public String getRecommendedProducts() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<Home> products = homeService.getRecommendedProducts(8); // 8개 상품 가져오기
            resultMap.put("result", "success");
            resultMap.put("data", products);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "추천 상품 조회 중 오류: " + e.getMessage());
            System.err.println("추천 상품 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 최신 대회 목록 조회 (AJAX)
     */
    @GetMapping("/api/latestRallies.dox")
    @ResponseBody
    public String getLatestRallies() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<Home> rallies = homeService.getLatestRallies(4); // 4개 대회 가져오기
            resultMap.put("result", "success");
            resultMap.put("data", rallies);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "최신 대회 조회 중 오류: " + e.getMessage());
            System.err.println("최신 대회 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

}
