package com.example.springProject2025.model;

import java.util.List;

import lombok.Data;

@Data
public class Cart {

	private String cartNo;
	private String userId;
	private String productNo;
	private String quantity;
	private String cdate;
	private String brand;
	private String productName;
	private String price;
	private String productSize;
	private String productDetail;
	private String sellCount;
	private String gender;
	private String typeNo;
	private String udate;
	private String productImgNo;
	private String imgPath;
	private String imgName;
	private String imgOrgname;
	private String imgSize;
	private String imgEtc;
	
	
	// PRODUCT 테이블 내용추가
	private String productStock; //숫자인데 일괄적 String으로 받음
	private String productGender;
	
}
