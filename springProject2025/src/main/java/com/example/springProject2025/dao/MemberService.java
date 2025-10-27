package com.example.springProject2025.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.MemberMapper;
import com.example.springProject2025.model.User;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	public HashMap<String, Object> memberSignup(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("서비스에서의 값111111 " + map);
		int cnt = memberMapper.userSignup(map);
		
		if(cnt < 1 ) {
			resultMap.put("result", "fail");
		} else { 
			resultMap.put("result", "success");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> checkId(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User idCheck = memberMapper.idCheck(map);
		String result = idCheck != null ? "true" : "false";
		
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	public HashMap<String, Object> nicknameCheck(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User nicknameCheck = memberMapper.nicknameCheck(map);
		String result = nicknameCheck != null ? "true" : "false";
		
		resultMap.put("result", result);
		
		return resultMap;
	}

}
