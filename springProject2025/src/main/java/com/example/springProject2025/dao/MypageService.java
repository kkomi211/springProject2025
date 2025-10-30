package com.example.springProject2025.dao;

import java.util.HashMap;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.MemberMapper;
import com.example.springProject2025.mapper.MypageMapper;
import com.example.springProject2025.model.User;

import jakarta.servlet.http.HttpSession;

@Service
public class MypageService {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	MypageMapper mypageMapper;
	
	public HashMap<String, Object> getUserInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User info = mypageMapper.userInfo(map);
		
		resultMap.put("result", "success");
		resultMap.put("info", info);
		
		return resultMap;
	}
	
	public HashMap<String, Object> checkPwd(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User member = mypageMapper.checkPwd(map);
		String result = "";
		
		if(member != null) {
			boolean loginFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPwd());
			System.out.println(loginFlg);
			
			if(loginFlg == true) {
				result = "success";
				session.setAttribute("sessionId", member.getUserId());
			} else {
				result = "fail";
			}
		} else {
			result = "fail";
		}
		resultMap.put("result", result);
		return resultMap;
	}
	
	public HashMap<String, Object> emailCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.checkEmail(map);
		
		if(cnt < 1 ) {
			resultMap.put("result", "success"); // No duplicate email => good
		} else { 
			resultMap.put("result", "fail"); // Duplicate email => no
		}
		return resultMap;
	}
	
	public HashMap<String, Object> insertNewEmail(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.insertNewEmail(map);
		
		if(cnt > 0 ) {
			resultMap.put("result", "success"); 
		} else { 
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> insertNewName(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.insertNewName(map);
		
		if(cnt > 0 ) {
			resultMap.put("result", "success"); 
		} else { 
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> insertNewPhone(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.insertNewPhone(map);
		
		if(cnt > 0 ) {
			resultMap.put("result", "success"); 
		} else { 
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> insertNewAddr(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.insertNewAddr(map);
		
		if(cnt > 0 ) {
			resultMap.put("result", "success"); 
		} else { 
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> deleteAccount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = mypageMapper.deleteAccount(map);
		
		if(cnt > 0 ) {
			resultMap.put("result", "success"); 
		} else { 
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

}
