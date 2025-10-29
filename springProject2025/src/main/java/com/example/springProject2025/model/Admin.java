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
	
	
	
}
