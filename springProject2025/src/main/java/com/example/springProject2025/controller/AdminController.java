package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.AdminService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping("admin.do")
	public String login(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/admin-main-default"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/banner.do")
	public String banner(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/banner"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/inquery.do")
	public String inquery(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/inquery"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/refund-return.do")
	public String refundReturn(Model model) throws Exception {
		return "admin/refund-return"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/product.do")
	public String product(Model model) throws Exception {
		return "admin/product"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/orders.do")
	public String orders(Model model) throws Exception {
		return "admin/orders"; // .jsp빠진형태
	}
	@RequestMapping("admin/board-report.do")
	public String boardReport(Model model) throws Exception {
		return "admin/board-report"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/user-list.do")
	public String userList(Model model) throws Exception {
		return "admin/user-list"; // .jsp빠진형태
	}
	
	// banner(메인 슬라이드 광고) list
	@RequestMapping(value = "/admin/banner1.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String banner1List(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.getbanner1List(map);

		return new Gson().toJson(resultMap);
	}
	
	
	
	// banner update 수정
	@RequestMapping(value = "/admin/bannerUpdate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String update(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.bannerModify(map);

		return new Gson().toJson(resultMap);
	}
	
	// banner delete 삭제
	@RequestMapping(value = "/admin/bannerDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String delete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.removeBanner(map);
		
		return new Gson().toJson(resultMap);
	}
	
	// banner insert 추가
		@RequestMapping(value = "/admin/bannerInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.addBanner(map);
			
			return new Gson().toJson(resultMap);
		}
}
