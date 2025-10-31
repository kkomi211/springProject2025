package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Board {

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
 