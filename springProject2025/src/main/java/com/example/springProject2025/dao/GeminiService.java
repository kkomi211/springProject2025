package com.example.springProject2025.dao;

import com.example.springProject2025.dto.GeminiRequest;
import com.example.springProject2025.dto.GeminiResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@Service
public class GeminiService {

    // application.properties에서 설정값 가져오기
    @Value("${google.gemini.api-key}")
    private String apiKey;

    @Value("${google.gemini.url}")
    private String apiUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    public String getContents(String prompt) {
        // 1. 요청 URL 조합 (URL + API Key)
        String requestUrl = apiUrl + apiKey;

        // 2. 봇의 역할(페르소나) 부여 및 사용자 질문 결합
        String finalPrompt = "너는 러닝 코스 추천 전문가야. 사용자가 '[지역] [난이도]' 형태로 질문을 하면, " +
                "해당 지역의 해당 난이도에 맞는 코스 3개를 추천해줘.\n" +
                "초보자: 평탄하고 짧은 코스 위주\n" +
                "중급자: 적당한 거리와 약간의 경사\n" +
                "상급자: 장거리, 고도 변화가 있는 훈련 코스\n\n" +
                "답변 형식은 아래와 같이 딱딱하고 간결하게 작성해 하지만 아이콘 쓰면서 살짝의 산뜻함도 넣어(인사말 금지):\n" +
                "1. [코스 이름]\n" +
                "- 특징: [거리, 지형 등 핵심 요약]\n" +
                "- 주의사항: [안전 관련 내용]\n\n" +
                "(2번, 3번도 동일)\n\n" +
                "사용자 질문: " + prompt;
        // 3. DTO 객체 생성 (계층 구조에 맞춰서 조립)
        // Part -> Content -> Request 순서로 생성
        GeminiRequest.Part part = new GeminiRequest.Part(finalPrompt);
        GeminiRequest.Content content = new GeminiRequest.Content(Collections.singletonList(part));
        GeminiRequest request = new GeminiRequest(Collections.singletonList(content));

        // 4. API 호출 및 응답 받기
        try {
            GeminiResponse response = restTemplate.postForObject(requestUrl, request, GeminiResponse.class);

            // 5. 응답 파싱 (복잡한 JSON 구조에서 텍스트만 쏙 빼내기)
            if (response != null && 
                response.getCandidates() != null && 
                !response.getCandidates().isEmpty()) {
                
                return response.getCandidates().get(0).getContent().getParts().get(0).getText();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "죄송합니다. Gemini API 호출 중 오류가 발생했습니다. (" + e.getMessage() + ")";
        }

        return "답변을 생성하지 못했습니다.";
    }
}