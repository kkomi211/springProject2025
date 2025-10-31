package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.ChatService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;

@Controller
public class ChatController {

	@Autowired
	ChatService chatService;
	
	@RequestMapping(value = "/home/mypage/chatroom/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String chatroomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.getChatroomList(map);
		return new Gson().toJson(resultMap);
	}
}
