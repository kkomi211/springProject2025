package com.example.springProject2025.model;

import lombok.Data;

@Data

//BOARD 테이블
public class Board {
	private String boardNo;
	private String type;
	private String title;
	private String contents;
	private String userId;
	private String cdate;
	private String udate;
	private String viewCnt;
	private int cnt;
	private String pwd;
	private String chardate;

	// rally-board (대회정보) 테이블
	private int rallyNo;
	private String rallyName; 
	private String rallyDate;
	private String applicationPeriod;
	private int price;
	private String phone;
	private String type; 
	private String host;
	private String cDate;
	private String imgPath;
	
	// 
}
 