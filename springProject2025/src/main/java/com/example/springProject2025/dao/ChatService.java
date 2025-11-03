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
			resultMap.put("chatlist", list);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getMessageList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Chat> list = chatMapper.selectMessageList(map);
			resultMap.put("messagelist", list);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> AddMessage(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			int cnt = chatMapper.insertMessage(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> DeleteMessage(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			int cnt = chatMapper.deleteMessage(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getMemberList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			List<Chat> list = chatMapper.selectMemberList(map);
			Chat owner = chatMapper.selectOwner(map);
			resultMap.put("memberList", list);
			resultMap.put("owner", owner);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> DeleteMember(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			int cnt = chatMapper.deleteMember(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> memberChat(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			Chat cnt = chatMapper.checkMemberChat(map);
			System.out.println(map);
			if(cnt.getCnt() == 0) {
				int chat = chatMapper.createMemberChat(map);
				int chat2 = chatMapper.createMember(map);		
				int chat3 = chatMapper.createMemberOwner(map);
				int chat4 = chatMapper.createMemberPair(map);
				resultMap.put("result", "success");
				resultMap.put("chatroomNo", map.get("chatroomNo"));
			}
			else {
				resultMap.put("result", "이미 있음");
				resultMap.put("chatroomNo", cnt.getChatroomNo());			
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	
	
	
	

}
