package com.example.springProject2025.controller;

import com.example.springProject2025.dao.GeminiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GeminiController {

    @Autowired
    private GeminiService geminiService;

    // 프론트엔드에서 /gemini/chat 주소로 요청을 보냄
    @GetMapping("/gemini/chat")
    public String chat(@RequestParam("input") String input) {
        
        // 1. 서비스 호출 (Gemini에게 질문)
        String response = geminiService.getContents(input);
        
        // 2. 결과 텍스트 반환
        return response;
    }
}