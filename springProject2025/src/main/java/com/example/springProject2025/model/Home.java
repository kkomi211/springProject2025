package com.example.springProject2025.model;


import lombok.Data;

@Data
public class Home {
	// === 메인 슬라이드 관련 필드 (selectMainSlideImages에서 사용) ===
    private int bannerId;
    private String title;
    private String imageDir; // 메인 슬라이드 이미지 경로
    private String linkUrl;
    private int displayOrder;
    private String cdate; // 생성일
    private String udate; // 수정일

    // === 상품 관련 필드 (selectTopSellingProducts에서 사용) ===
    private String productNo;
    private String productName;
    private int productPrice; // 매퍼의 'AS productPrice'에 맞춰 int 타입으로
    private String brand;
    private int sellCount;
    private String imgPath;
    private String saleYN;
    private int salePrice;

    // === 대회 관련 필드 (selectLatestRallies에서 사용) ===
    private String rallyNo;
    private String rallyName;
    private String rallyDate;
    private String applicationPeriod;
    private int rallyPrice; // 매퍼의 'AS rallyPrice'에 맞춰 int 타입으로
    private String host;
    
}
