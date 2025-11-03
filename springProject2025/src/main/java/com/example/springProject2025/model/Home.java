package com.example.springProject2025.model;

import java.sql.Clob;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Home {
	// === 메인 슬라이드 관련 필드 (selectMainSlideImages에서 사용) ===
    private int bannerId;
    private String title;
    private String imageDir; // 메인 슬라이드 이미지 경로
    private String linkUrl;
    private int displayOrder;
    private Date cdate; // 생성일
    private Date udate; // 수정일

    // === 상품 관련 필드 (selectTopSellingProducts에서 사용) ===
    private String productNo;
    private String productName;
    private int productPrice; // 매퍼의 'AS productPrice'에 맞춰 int 타입으로
    private String brand;
    private int sellCount;

    // === 대회 관련 필드 (selectLatestRallies에서 사용) ===
    private String rallyNo;
    private String rallyName;
    private Date rallyDate;
    private String applicationPeriod;
    private int rallyPrice; // 매퍼의 'AS rallyPrice'에 맞춰 int 타입으로
    private String host;

    // ★★★ 모든 이미지 경로를 담을 이 필드가 꼭 있어야 합니다! ★★★
    // 상품 이미지 경로, 대회 이미지 경로 등 이 imgPath 필드로 매핑됩니다.
    private String imgPath;

    // --- (Lombok의 @Data 사용 시 getter/setter/toString 등은 자동으로 생성됨) ---
    // 만약 Lombok을 사용하지 않는다면, 위 필드들에 대한 getter와 setter 메서드를
    // 모두 수동으로 작성해주셔야 합니다. 예:
    /*
    public String getImgPath() { return imgPath; }
    public void setImgPath(String imgPath) { this.imgPath = imgPath; }
    // ... 다른 필드들의 getter/setter도 모두 작성
    */

}
