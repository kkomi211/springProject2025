package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Admin {

	private String userId;
	private String name;
	
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
}
