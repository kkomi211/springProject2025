package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.ChatMapper;
import com.example.springProject2025.model.Chat;

@Service
public class ChatService {
	
	@Autowired
	ChatMapper chatMapper;

	public HashMap<String, Object> getChatroomList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Chat> list = chatMapper.selectChatroomList(map);
			resultMap.put("list", list);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	

}
