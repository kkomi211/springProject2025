package com.example.springProject2025.model;

import lombok.Data;

@Data
public class Admin {

	// default
	private String userId;
	private String name;

	// banner model 테이블 컬럼명
	private int bannerId;
	private String title;
	private String imageDir;
	private String linkUrl;
	private int displayOrder;
	private String cDate;
}
