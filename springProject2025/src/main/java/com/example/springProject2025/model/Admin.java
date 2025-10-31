package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Admin {

	private String userId; // ORDERS, PRODUCT, USERS 테이블 등 여러 곳에서 사용되는 userId
	private String name; // USERS 테이블 name (ex: 유저이름)
	private String cDate; // 여러 테이블에서 공통으로 사용되는 생성/신고/작성 날짜
	private String uDate; // 여러 테이블에서 공통으로 사용되는 수정/처리 날짜
	private String status; // ORDERS 테이블 상태, REPORT_BOARD 테이블 상태 등 여러 곳에서 사용
	// private String title; // PRODUCT_INQUIRY, BOARD 에서 사용될 수 있음
	// private String content; // PRODUCT_INQUIRY, BOARD 에서 사용될 수 있음

	// PRODUCT_INQUIRY 테이블
	private int inquiryNo;
	private String productNo;
	private String content; // inquiry_content
	// private String cDate; // inquiry_cDate
	// private String uDate; // inquiry_uDate
	// default
//	private String userId;
//	private String name;

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
//	private int price;
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
//	private int inquiryNo;
//	private String productNo;
//	private String content;
//	private String cDate;
//	private String uDate;
	private String pwd;
	// private String status; // inquiry_status
	private String answer;
	private String answerDate;
	
	// ORDERS 테이블
	private int orderNo;
	private int quantity;
	private int paymentAmount;
	private String addr;
	private String paymentMethod;
	private String because;
	private String orderRequest;
	
	// USERS 테이블
	private String nickName;
	private String gender;
	private String email;
	private String phone;
	private String userType;
	private String birth;
	
	// PRODUCT 테이블
	private String brand;
	private String productName;
	private int price;
	private String productSize;
	private int productStock;
	private String typeNo;
	private String productDetail;
	private int sellCount;
	private String productGender;
	
	// REPORT_BOARD 테이블
	private int reportBoardNo; // 신고 게시물 식별번호
	private int reportedBoardNo; // 신고된 게시물 번호 (BOARD_NO와 구분)
	private String reporterId; // 신고자 아이디 (USER_ID와 구분)
	private String reportStatus; // 신고 확인 상태 (status와 구분)

	// BOARD 테이블
	private String boardType; // 게시판 유형 (Q, F, B, R)
	private String boardTitle; // 게시글 제목 (title과 구분)
	private String boardContent; // 게시글 내용 (content와 구분)
	private String boardUserId; // 게시글 작성자 ID (userId와 구분)
	private int viewCnt; // 조회수
	private String boardPwd; // 잠금 비밀번호

	private String reporterName; // 조회를 위한 USERS 테이블의 신고자 이름
	private String boardAuthorName; // 조회를 위한 USERS 테이블의 게시글 작성자 이름
	
}
