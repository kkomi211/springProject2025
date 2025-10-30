package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Board;

@Mapper
public interface BoardMapper {
	
	// 게시판 리스트
	List <Board>boardList(HashMap<String, Object> map);
	
	// 게시글 전체 개수
	int boardCnt(HashMap<String, Object> map);
}
