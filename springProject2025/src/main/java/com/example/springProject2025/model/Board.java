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

}
