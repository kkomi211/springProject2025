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
import com.example.springProject2025.dao.MypageService;
import com.google.gson.Gson;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	
	@RequestMapping(value = "/home/mypage/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.getUserInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwdCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.checkPwd(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/emailCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emailCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.emailCheck(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/emailSave.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertNewEmail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.insertNewEmail(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/nameSave.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertNewName(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.insertNewName(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/phoneSave.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertNewPhone(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.insertNewPhone(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/addrSave.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertNewAddr(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.insertNewAddr(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/deleteAccount.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteAccount(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = mypageService.deleteAccount(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
