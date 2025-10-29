package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.MemberService;
import com.google.gson.Gson;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/home/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.memberLogin(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/signup.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberJoin(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.memberSignup(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/addr.do") 
    public String addr(Model model) throws Exception{

        return "home/jusoPopup";
    }
	
	@RequestMapping(value = "/home/idCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.checkId(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/pwdCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwdCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.pwdSearch(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/nicknameCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String nicknameCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.nicknameCheck(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("home/login/search.do")
	public String userList(Model model) throws Exception {
		return "home/idPwdSearch"; // .jsp빠진형태
	}
	
	@RequestMapping(value = "/home/login/search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idSearch(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.idSearch(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/changePwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String changePwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = memberService.pwdChange(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
