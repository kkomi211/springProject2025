package com.example.springProject2025.model;

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

}
