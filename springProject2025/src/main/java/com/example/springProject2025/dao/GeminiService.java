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
        String finalPrompt = "사용자가 지역을 말하면 해당 지역의 러닝 코스 3개를 추천해줘. " +
                "서론, 본론, 결론, 인사말, 미사여구는 절대 포함하지 마. " +
                "오직 아래 형식으로만 간결하게 답변하는데 아이콘을 넣어서 살짝 산뜻함도 줘.\n\n" +
                "형식:\n" +
                "1. [코스 이름]\n" +
                "- 특징: [코스의 지형, 거리, 장점 등 핵심 정보]\n" +
                "- 주의사항: [안전 관련 주의점]\n\n" +
                "(2번, 3번도 같은 형식으로 작성)\n\n" +
                "사용자 요청 지역: " + prompt;
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