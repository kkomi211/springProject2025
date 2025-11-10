package com.example.springProject2025.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws-chat") 
                .setAllowedOriginPatterns("*") 
                .withSockJS(); // SockJS 지원
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
    	
//        registry.enableSimpleBroker("/topic"); // 주소 설정 //251107 전경환 주석처리
//        registry.setApplicationDestinationPrefixes("/app"); // 클라이언트가 보낼 주소 설정 //251107전경환주석처리
    	config.enableSimpleBroker("/topic");      // 간단히 내부 브로커 사용
        config.setApplicationDestinationPrefixes("/app");
    	
    }
}

