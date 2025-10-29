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
	
	@RequestMapping("admin/inquiry.do")
	public String inquery(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/inquiry"; // .jsp빠진형태
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
	
	
	
	
	
	


}
