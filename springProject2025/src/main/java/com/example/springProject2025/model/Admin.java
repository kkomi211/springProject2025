package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Admin {

	// default
	private String userId;
	private String name;

	// banner model(slide) 테이블 컬럼명
	private int bannerId;
	private String imageDir;
	private String linkUrl;
	private int displayOrder;
	
	// banner model(product) 테이블 컬럼명
	private int pBannerImgNo;
	private String productImgNo;
	private String imgPath;

	// banner model(rally) 테이블 컬럼명
	private int rallyNo;
	private String rallyName; 
	private String rallyDate;
	private String applicationPeriod;
	private int price;
	private String type;
	private String host;
	private String title;
	
	// banner model(rally_img) 테이블 컬럼명
	private String imgName;
	private int rallyImgNo;
	private String imgOrgName;
	private String imgSize;
	private String imgEtc;
	
	// PRODUCT_INQUIRY 테이블 컬럼
	private int inquiryNo;
	private String productNo;
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
