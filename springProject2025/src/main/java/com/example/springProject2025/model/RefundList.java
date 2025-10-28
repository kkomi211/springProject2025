package com.example.springProject2025.model;

import java.util.List;

import lombok.Data;

@Data
public class RefundList {
	private String sessionId;
    private List<Order> orders; // 수정된 Order 모델 클래스의 리스트를 사용
}
