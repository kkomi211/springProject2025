package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.BoardMapper;
import com.example.springProject2025.model.Board;
import com.example.springProject2025.model.Comment;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	// rally board list 목록
	public HashMap<String, Object> getRallyBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardMapper.selectRallyBoardList(map);
		
		resultMap.put("list", list);
    resultMap.put("result", "success");
		return resultMap;
	}
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Board> list = boardMapper.boardList(map);
		int cnt = boardMapper.boardCnt(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> addBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.boardAdd(map);
		
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> boardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Board info = boardMapper.boardInfo(map);
		
		resultMap.put("result", "success");
		resultMap.put("info", info);
		return resultMap;
	}
	
	public HashMap<String, Object> commentInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List <Comment> list = boardMapper.commentInfo(map);
		
		resultMap.put("result", "success");
		resultMap.put("list", list);
		return resultMap;
	}
	
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.commentAdd(map);
		
		if(cnt > 0) {
			resultMap.put("boardNo", map.get("boardNo"));
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> checkKeylock(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.checkKeylock(map);
		
		if(cnt > 0) {
			resultMap.put("boardNo", map.get("boardNo"));
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> changePost(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.changePost(map);
		
		if(cnt > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

}
