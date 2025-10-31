package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Board;

@Mapper
public interface BoardMapper {
	
	// rally-board(대회정보) 목록
		List<Board>selectRallyBoardList(HashMap<String, Object> map);
	
}
 