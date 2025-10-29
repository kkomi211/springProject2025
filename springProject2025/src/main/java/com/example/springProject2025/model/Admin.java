package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Admin {

	// default
	private String userId;
	private String name;

	// banner model(메인) 테이블 컬럼명
	private int bannerId;
	private String title;
	private String imageDir;
	private String linkUrl;
	private int displayOrder;
	private String cDate;
	
	// banner model(제품) 테이블 컬럼명
	private int pBannerImgNo;
	private int productNo;
	private String productImgNo;
	
	
	
	// PRODUCT_INQUIRY 테이블 컬럼
	private int inquiryNo;
	private String productNo;
	private String title;
	private String content;
	private String cDate;
	private String uDate;
	private String pwd;
	private String status;
	private String answer;
	private String answerDate;
	
	// ORDERS 테이블 컬럼
	private int orderNo;
	private int quantity;
	private int paymentAmount;
	private String addr;
	private String paymentMethod;
	private String because;
	private String orderRequest;
	
	// USERS 테이블 컬럼
	private String nickName;
	private String gender;
	private String email;
	private String phone;
	private String userType;
	private String birth;
	
}
