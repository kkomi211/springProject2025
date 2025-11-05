package com.example.springProject2025.controller;	

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.example.springProject2025.dao.MemberService;
import com.example.springProject2025.mapper.MemberMapper;
import com.example.springProject2025.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	@Value("${client_id}") // the name should be the same as the one in application.properties
	private String client_id;

    @Value("${redirect_uri}")
    private String redirect_uri;

    @RequestMapping(value = "/kakao.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String kakaoLogin(@RequestParam HashMap<String, Object> map) throws Exception {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", client_id);
        params.add("redirect_uri", redirect_uri);
        params.add("code", (String) map.get("code"));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(tokenUrl, request, Map.class);

        Map<String, Object> kakaoUser = getUserInfo((String) response.getBody().get("access_token"));

        HashMap<String, Object> resultMap = memberService.memberKakaoLogin(kakaoUser);
        
     // 3️⃣ Retrieve the Kakao user from DB to set session info
        String kakaoId = "kakao_" + kakaoUser.get("id");
        HashMap<String, Object> userMap = new HashMap<>();
        userMap.put("userId", kakaoId);

        User user = memberMapper.userLogin(userMap); // 🔹 Directly fetch from DB

        // 4️⃣ Store DB user data in the session
        if (user != null) {
            session.setAttribute("sessionId", user.getUserId());
            session.setAttribute("sessionName", user.getName());
            session.setAttribute("userType", user.getUsertype());
            session.setAttribute("nickname", user.getNickname());
        }
        
        return new Gson().toJson(resultMap);
    }

    private Map<String, Object> getUserInfo(String accessToken) {
        String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, entity, String.class);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(response.getBody(), Map.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}