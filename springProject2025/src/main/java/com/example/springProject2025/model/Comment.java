package com.example.springProject2025.model;

import lombok.Data;

@Data

//COMMENTS 테이블
public class Comment {
	private String commentNo;
	private String userId;
	private String contents;
	private String boardNo;
	private String cdate;
	private String udate;
	private String chardate;

}
