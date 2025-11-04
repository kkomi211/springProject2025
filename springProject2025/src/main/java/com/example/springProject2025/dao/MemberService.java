package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.Map;

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
				resultMap.put("userType", member.getUsertype());
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


	public HashMap<String, Object> memberLogout(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// 세션정보 삭제하는 방법은
		// 1개씩 키값을 이용해서 삭제하거나, 전체를 한번에 삭제
		
		String userName = (String) session.getAttribute("sessionName");
		resultMap.put("userName", userName);
		resultMap.put("result", "success");
		
		session.removeAttribute("sessionId");
		session.removeAttribute("userType");// 1개씩 삭제
		
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
	
	public HashMap<String, Object> memberKakaoLogin(Map<String, Object> kakaoUser) {
	    HashMap<String, Object> resultMap = new HashMap<>();

	    String kakaoId = "kakao_" + kakaoUser.get("id");

	    // Safely extract kakao_account (may be null)
	    Map<String, Object> kakaoAccount = null;
	    if (kakaoUser.get("kakao_account") instanceof Map) {
	        kakaoAccount = (Map<String, Object>) kakaoUser.get("kakao_account");
	    }

	    // Try nickname from kakao_account.profile, or fallback to properties.nickname
	    String nickname = "KakaoUser";
	    if (kakaoAccount != null && kakaoAccount.get("profile") instanceof Map) {
	        nickname = (String) ((Map) kakaoAccount.get("profile")).get("nickname");
	    } else if (kakaoUser.get("properties") instanceof Map) {
	        nickname = (String) ((Map) kakaoUser.get("properties")).get("nickname");
	    }

	    // Try email, but handle missing kakao_account safely
	    String email = (kakaoAccount != null && kakaoAccount.get("email") != null)
	            ? (String) kakaoAccount.get("email")
	            : "noemail@kakao.com";

	    HashMap<String, Object> checkMap = new HashMap<>();
	    checkMap.put("userId", kakaoId);
	    User existingUser = memberMapper.userLogin(checkMap);

	    if (existingUser == null) {
	        User newUser = new User();
	        newUser.setUserId(kakaoId);
	        newUser.setPwd("KAKAO_PWD");
	        newUser.setName(nickname);
	        newUser.setNickname(nickname);
	        newUser.setGender("M");
	        newUser.setEmail(email);
	        newUser.setAddr("미입력");
	        newUser.setPhone("000-0000-0000");
	        newUser.setUsertype("K");
	        newUser.setBirth("");

	        memberMapper.addUser(newUser);
	        resultMap.put("message", "New Kakao user created");
	    } else {
	        resultMap.put("message", "Existing user logged in");
	    }

	    session.setAttribute("sessionId", kakaoId);	
	    session.setAttribute("sessionName", nickname);

	    resultMap.put("result", "success");
	    resultMap.put("userName", nickname);

	    return resultMap;
	}


}
