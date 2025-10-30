package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Product {

//	PRODUCT, PRODUCT_IMG 용 
	private String productNo;
	private String userId;
	private String brand;
	private String productName;
	private int price;
	private String productSize;
	private String productDetail;
	private int sellCount;
	private int quantity;
	private String gender;
	private String typeNo;
	private String cdate;
	private String udate;
	private String imgPath;
	private String typeName;
	private String typePart;
	private String depth;
	
//	REVIEW 테이블 용
	private String reviewNo;
	private int rating;
	private String title;
	private String content;
	private int viewCnt;
	private int helpfulCnt;
	private double avgRating;
	private int reviewCnt;
	
// inquiry 용
	private int inquiryNo;
//	private String productNo;
//	private String title;
//	private String content;
	private String cDate;
	private String uDate;
	private String pwd;
	private String status;
	private String answer;
	private String answerDate;
}
