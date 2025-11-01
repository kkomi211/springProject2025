package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.ChatService;
import com.example.springProject2025.model.Chat;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ChatController {

	@Autowired
	ChatService chatService;
	
	@RequestMapping("home/test24.do")
	public String information(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/chat_test"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/chat/show.do")
	public String inChat(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("chatroomNo", map.get("chatroomNo"));
		return "home/chatroom-view"; // .jsp빠진형태
	}

	@RequestMapping(value = "/home/mypage/chatroom/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String chatroomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.getChatroomList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/chatroom/show.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String chatroomShow(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.getChatroomList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/message/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String messageList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.getMessageList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/message/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String messageAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.AddMessage(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/home/mypage/message/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String messageDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = chatService.DeleteMessage(map);
		return new Gson().toJson(resultMap);
	}


	@MessageMapping("/sendMessage") // 클라이언트에서 "/app/sendMessage"로 요청 시 실행
	@SendTo("/topic/public") // 메시지를 "/topic/public"을 구독하는 모든 사용자에게 전송
	public String sendMessage(String message) {
		System.out.println("Received message: " + message); // 로그 확인
		return message;
	}
	
}
