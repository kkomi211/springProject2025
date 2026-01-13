package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Chat;

@Mapper
public interface ChatMapper {
	
	List<Chat> selectChatroomList(HashMap<String, Object> map);
	
	List<Chat> selectMessageList(HashMap<String, Object> map);

	int insertMessage(HashMap<String, Object> map);

	int deleteMessage(HashMap<String, Object> map);

	List<Chat> selectMemberList(HashMap<String, Object> map);

	Chat selectOwner(HashMap<String, Object> map);

	int deleteMember(HashMap<String, Object> map);

	Chat checkMemberChat(HashMap<String, Object> map);

	int createMemberChat(HashMap<String, Object> map);

	int createMemberPair(HashMap<String, Object> map);

	int createMember(HashMap<String, Object> map);
	
	int createMemberOwner(HashMap<String, Object> map);

	int deleteChatroom(HashMap<String, Object> map);

	int deleteChatMember(HashMap<String, Object> map);

	int deleteChatPair(HashMap<String, Object> map);

	int deleteChatMessage(HashMap<String, Object> map);

	int deleteChatImg(HashMap<String, Object> map);

	int updateChatroomName(HashMap<String, Object> map);

	int updateChatroomOwner(HashMap<String, Object> map);

	int updateChatMemberToM(HashMap<String, Object> map);

	int updateChatMemberToO(HashMap<String, Object> map);
	
}
