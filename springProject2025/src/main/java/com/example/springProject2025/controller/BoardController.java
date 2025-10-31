package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.BoardService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;

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
		
}
