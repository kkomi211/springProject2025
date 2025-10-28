package com.example.springProject2025.dao;

import java.util.HashMap;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.MemberMapper;
import com.example.springProject2025.model.User;

import jakarta.servlet.http.HttpSession;



@Service
public class MemberService {
	
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User member = memberMapper.userLogin(map);
		
		String message = ""; // 로그인 성공 실패 여부 메세지
		String result = "";
		
		if(member != null) {
			boolean loginFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPwd());
			System.out.println(loginFlg);
			
			if(loginFlg == true) {
				message = "로그인 성공했습니다.";
				result = "success";
				session.setAttribute("sessionId", member.getUserId());
				session.setAttribute("sessionName", member.getName());
			} else {
				message = "아이디와 패스워드를 확인해주세요.";	
				result = "fail";
			}
		} else {
			message = "아이디가 존재하지 않습니다.";
			result = "fail";
		}
		resultMap.put("result", result);
	    resultMap.put("message", message);
		return resultMap;
	}
	
	public HashMap<String, Object> memberSignup(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
		map.put("pwd", hashPwd);
		
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
	
	public HashMap<String, Object> idSearch(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		
		int cnt = memberMapper.idSearch(map);
		User info = memberMapper.idRetrieve(map);
		
		if(cnt < 1 ) {
			message = "입력정보를 다시 확인해주세요. 입력하신 정보는 존재하지 않습니다";
			resultMap.put("result", "fail");
			resultMap.put("message", message);
		} else { 
			message = "아이디 찾기 완료";
			resultMap.put("result", "success");
			resultMap.put("message", message);
			resultMap.put("info", info);
		}
		return resultMap;
	}
	
	public HashMap<String, Object> pwdSearch(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int cnt = memberMapper.pwdSearch(map);
		
		if(cnt < 1 ) {
			resultMap.put("result", "fail");
		} else { 
			resultMap.put("result", "success");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> pwdChange(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();

	    String rawPwd = (String) map.get("newPwd1");
	    if (rawPwd == null || rawPwd.trim().isEmpty()) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "비밀번호가 비어 있습니다.");
	        return resultMap;
	    }

	    String hashPwd = passwordEncoder.encode(rawPwd);
	    map.put("newPwd1", hashPwd);

	    int cnt = memberMapper.pwdChange(map);
	    resultMap.put("result", cnt > 0 ? "success" : "fail");

	    return resultMap;
	}

}
