package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Board;
import com.example.springProject2025.model.Comment;

@Mapper
public interface BoardMapper {
	
	// rally-board(대회정보) 목록
	List<Board>selectRallyBoardList(HashMap<String, Object> map);

	// 게시판 리스트
	List <Board>boardList(HashMap<String, Object> map);
	
	// crew 게시판 list
	List <Board>selectCrewBoardList(HashMap<String, Object> map);
	
	// 게시글 전체 개수(rally board)
	int selectRallyBoardCnt(HashMap<String, Object> map);
	
	// 게시글 전체 개수(crew board)
	int selectCrewBoardCnt(HashMap<String, Object> map);
	
	// 게시글 전체개수 (board)
	int boardCnt(HashMap<String, Object> map);
	
	// 게시글 전체개수 (board)
	int insertCrew(HashMap<String, Object> map);
		
	// crew 채팅방 입장하기(insert)
	int crewCatInsertMember(HashMap<String, Object> map);
	
	// cerw 채팅방 유저 체크 (cnt 값)
	int selectCrewCheck(HashMap<String, Object> map);
	
	// crew 게시판 글 추가(insert)
	int crewChatInsert(HashMap<String, Object> map);
	
	// crew 채팅방 oner and member 추가(insert)
	int crewChatInsertOner(HashMap<String, Object> map);
	
	// 게시글 추가
	int boardAdd (HashMap<String, Object> map);
	
	// 게시글 상세보기
	Board boardInfo (HashMap<String, Object> map);
	
	// 댓글 상세보기
	List <Comment> commentInfo (HashMap<String, Object> map);
	
	// 댓글 추가
	int commentAdd (HashMap<String, Object> map);
	
	// 잠금 확인 
	int checkKeylock(HashMap<String, Object> map);
	
	// 게시글 수정
	int changePost(HashMap<String, Object> map);
	
	// 게시글 삭제
	int deletePost(HashMap<String, Object> map);
	
	// 조회수 증가
	int viewCnt (HashMap<String, Object> map);
	
	// 게시글 신고
	int reportBoard (HashMap<String, Object> map);
}



