package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.BoardService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	 
	// rally board list
	@RequestMapping("/home/community/rally.do")
	public String rallyList(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("rallyNo", map.get("rallyNo"));
		return "home/rally-board"; // .jsp빠진형태
	}
	
	// crew post board list
		@RequestMapping("/home/community/crew/post.do")
		public String crewPostBoardList(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
			request.setAttribute("sessionId", map.get("sessionId"));
			request.setAttribute("chatroomNo", map.get("chatroomNo"));
			return "home/crew-post"; // .jsp빠진형태
		}
	// crew insert board 
		@RequestMapping("/home/community/crew/insert.do")
		public String crewViewBoardList(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
			request.setAttribute("sessionId", map.get("sessionId"));
			request.setAttribute("chatroomNo", map.get("chatroomNo"));
			return "home/crew-view"; // .jsp빠진형태
	}
	
	// crew board list
	@RequestMapping("/home/community/crewBoard.do")
	public String crewBoardList(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("chatroomNo", map.get("chatroomNo"));
		return "home/crew"; // .jsp빠진형태
	}
	
	// rally board list(목록) 
		@RequestMapping(value = "/home/rally/board.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String rallyBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = boardService.getRallyBoardList(map);
			System.out.println("/home/rally/board.dox에서 프론트로 주기직전 값" + map);
			return new Gson().toJson(resultMap);
		}
			
	// crew board list(목록) 
		@RequestMapping(value = "/home/crew/board.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String crewBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = boardService.getCrewBoardList(map);
			return new Gson().toJson(resultMap);
		}
	// crew insert move 채팅방 (CHAT_MEMBER 추가 채티방이동)
		@RequestMapping(value = "/home/crew/chatMove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String crewInsertChat(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = boardService.crewChatInsert(map);
			
			return new Gson().toJson(resultMap);
		}
		
	// crew insert post 크루 채팅방개설 (CHAT, CHAT_MEMBER에 DB저장 밑 게시판 글)
		@RequestMapping(value = "/crew/chatInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String crewinsertPost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			System.out.println("잘 들어왔는지 확인" + map);
			resultMap = boardService.InsertCrewBoard(map);
			
			return new Gson().toJson(resultMap);
		}
		
	@RequestMapping("/home/community/board/post.do")
	public String boardPost(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/board-post"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/board/view.do")
	public String boardView(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("boardNo", map.get("boardNo"));
		return "home/board-view"; // .jsp빠진형태
	}
	
	@RequestMapping("home/community/board/edit.do")
	public String boardEdit(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("sessionId", map.get("sessionId"));
		request.setAttribute("boardNo", map.get("boardNo"));
		return "home/board-edit"; // .jsp빠진형태
	}
	
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("보드/리스트에 들어온값 "+map);
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/post.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("first data " + map);
		resultMap = boardService.addBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("board view data " + map);
		resultMap = boardService.boardInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/comment.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("comment data " + map);
		resultMap = boardService.commentInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/comment-post.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addComment(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("comment data " + map);
		resultMap = boardService.addComment(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/keylock.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkKeylock(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.checkKeylock(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/post-edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String changePost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.changePost(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deletePost(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.deletePost(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
