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
	 
	@RequestMapping("home/community/rally.do")
	public String rallyList(Model model) throws Exception {
		return "home/rally-board"; // .jsp빠진형태
	}
	
	// rally board list(목록) 
		@RequestMapping(value = "/home/rally/board.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String rallyBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = boardService.getRallyBoardList(map);
			return new Gson().toJson(resultMap);
		}
		
	
	@RequestMapping("home/community/board/post.do")
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
		System.out.println(map);
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
