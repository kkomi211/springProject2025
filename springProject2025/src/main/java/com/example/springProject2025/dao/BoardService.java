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
		int cnt = boardMapper.selectRallyBoardCnt(map);
		System.out.println("여기는 서비스고cnt는 이거야" + cnt);

		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	// ★★★ 새로 추가: 채팅방 멤버 목록 조회 ★★★
	public HashMap<String, Object> getChatMembers(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    
	    try {
	        System.out.println("Service - getChatMembers 호출됨");
	        System.out.println("Service - chatroomNo: " + map.get("chatroomNo"));
	        
	        List<HashMap<String, Object>> memberList = boardMapper.selectChatMembers(map);
	        
	        System.out.println("Service - 조회된 멤버 수: " + (memberList != null ? memberList.size() : 0));
	        if (memberList != null && !memberList.isEmpty()) {
	            System.out.println("Service - 첫 번째 멤버: " + memberList.get(0));
	        }
	        
	        resultMap.put("result", "success");
	        resultMap.put("memberList", memberList);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("Service - 에러 발생: " + e.getMessage());
	        resultMap.put("result", "fail");
	        resultMap.put("message", e.getMessage());
	    }
	    
	    return resultMap;
	}

	// crew board list 목록
	public HashMap<String, Object> getCrewBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardMapper.selectCrewBoardList(map);
		int cnt = boardMapper.selectCrewBoardCnt(map);

		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");
		return resultMap;
	}

	// crew 채팅방입장 insert
	public HashMap<String, Object> crewChatInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		int check = boardMapper.selectCrewCheck(map);
		if (check > 0) {
			resultMap.put("result", "success");
		} else {
			int cnt = boardMapper.crewCatInsertMember(map);

			if (cnt > 0) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
		}
		return resultMap;
	}

	// crew 게시판 등록 insert
	public HashMap<String, Object> InsertCrewBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		int room = boardMapper.crewChatInsert(map);
		int oner = boardMapper.crewChatInsertOner(map);

		if (room > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardMapper.boardList(map);
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
		int cnt = boardMapper.viewCnt(map);

		resultMap.put("result", "success");
		resultMap.put("info", info);
		return resultMap;
	}

	public HashMap<String, Object> commentInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Comment> list = boardMapper.commentInfo(map);

		resultMap.put("result", "success");
		resultMap.put("list", list);
		return resultMap;
	}

	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.commentAdd(map);

		if (cnt > 0) {
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

		if (cnt > 0) {
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

		if (cnt > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> deletePost(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.deletePost(map);
		int cnt2 = boardMapper.deleteComment(map);
		if (cnt > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> reportBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardMapper.reportBoard(map);
		
		if(cnt > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> countReport(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cntReport = boardMapper.reportCnt(map);
		
		if(cntReport > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> commentDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt2 = boardMapper.deleteComment(map);
		if (cnt2 > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	
	
	// 좋아요 toggle
	public HashMap<String, Object> toggleLike(HashMap<String, Object> map) {

	    HashMap<String, Object> resultMap = new HashMap<>();

	    // Check if already liked
	    int count = boardMapper.checkBoardLike(map);

	    if (count == 0) {
	        // Not liked → INSERT
	        int insertCnt = boardMapper.likeBoard(map);

	        if (insertCnt > 0) {
	            resultMap.put("result", "liked");
	        } else {
	            resultMap.put("result", "fail");
	        }

	    } else {
	        // 3️⃣ Already liked → DELETE
	        int deleteCnt = boardMapper.unlikeBoard(map);

	        if (deleteCnt > 0) {
	            resultMap.put("result", "unliked");
	        } else {
	            resultMap.put("result", "fail");
	        }
	    }

	    return resultMap;
	}
	
	public HashMap<String, Object> getLikeCnt(HashMap<String, Object> map) {

	    HashMap<String, Object> resultMap = new HashMap<>();

	    // Check if already liked
	    int count = boardMapper.checkBoardLike(map);

	    if (count == 0) {
	        // Not liked → INSERT
	        int insertCnt = boardMapper.likeBoard(map);

	        if (insertCnt > 0) {
	            resultMap.put("result", "liked");
	        } else {
	            resultMap.put("result", "fail");
	        }

	    } else {
	        // 3️⃣ Already liked → DELETE
	        int deleteCnt = boardMapper.unlikeBoard(map);

	        if (deleteCnt > 0) {
	            resultMap.put("result", "unliked");
	        } else {
	            resultMap.put("result", "fail");
	        }
	    }

	    return resultMap;
	}
	
	public HashMap<String, Object> getBoardLike(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    
	    // Get total like count
	    int likeCnt = boardMapper.likeCnt(map);
	    
	    // Check if current user has liked this post
	    int isLikedCount = 0;
	    if (map.containsKey("userId") && map.get("userId") != null && !map.get("userId").toString().isEmpty()) {
	        isLikedCount = boardMapper.checkBoardLike(map);  // Uses your existing checkBoardLike query
	    }
	    
	    resultMap.put("result", "success");
	    resultMap.put("likeCnt", likeCnt);
	    resultMap.put("isLiked", isLikedCount > 0);  // true if user has liked, false otherwise
	    
	    return resultMap;
	}
	
	public HashMap<String, Object> toggleCommentLike(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    
	    // Check if already liked
	    int count = boardMapper.checkCommentLike(map);
	    
	    if (count == 0) {
	        // Not liked → INSERT
	        int insertCnt = boardMapper.likeComment(map);
	        
	        if (insertCnt > 0) {
	            resultMap.put("result", "liked");
	        } else {
	            resultMap.put("result", "fail");
	        }
	    } else {
	        // Already liked → DELETE
	        int deleteCnt = boardMapper.unlikeComment(map);
	        
	        if (deleteCnt > 0) {
	            resultMap.put("result", "unliked");
	        } else {
	            resultMap.put("result", "fail");
	        }
	    }
	    
	    return resultMap;
	}

	public HashMap<String, Object> getCommentLikeInfo(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    
	    // Get like count
	    int likeCnt = boardMapper.getCommentLikeCnt(map);
	    
	    // Check if current user liked it
	    int isLikedCount = 0;
	    if (map.containsKey("userId") && map.get("userId") != null && !map.get("userId").toString().isEmpty()) {
	        isLikedCount = boardMapper.checkCommentLike(map);
	    }
	    
	    resultMap.put("result", "success");
	    resultMap.put("likeCnt", likeCnt);
	    resultMap.put("isLiked", isLikedCount > 0);
	    
	    return resultMap;
	}

}
