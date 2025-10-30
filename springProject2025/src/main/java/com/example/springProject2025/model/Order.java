package com.example.springProject2025.model;

import java.util.List;

import lombok.Data;

@Data
public class Order {
	
	private String orderNo;
	private String userId;
	private String cdate;
	private String productNo;
	private String productName;  // PRODUCT 테이블
	private String imgPath;      // PRODUCT_IMG 테이블
	private String imgName;      // PRODUCT_IMG 테이블
	private String quantity;
	private String paymentAmount;
	private String addr;
	private String paymentMethod;
	private String status;
	private String udate;
	private String because;
	private String orderRequest;
	private String sessionId; // 프론트에서 sessionId을 보냄
    private List<Order> orders; // 프론트에서 orders을 보냄
    private String actionType; // 프론트에서 actionType을 보냄
    private String reason;     // 프론트에서 reason을 보냄
    private String brand;
    
    private String rating; // 리뷰테이블에서 조회되서 여기 들어갈 예정...

}
