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
}
