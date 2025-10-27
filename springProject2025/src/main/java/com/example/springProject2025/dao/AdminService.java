package com.example.springProject2025.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.AdminMapper;

@Service
public class AdminService {
	
	@Autowired
	AdminMapper adminMapper;
	
	public HashMap<String, Object> getList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		List<Admin> list = adminMapper.selectList(map);
//		int cnt = boardMapper.selectBoardCnt(map);
		
		
//		resultMap.put("list", list);
//		resultMap.put("cnt", cnt);
//		resultMap.put("result", "success");
		
//		System.out.println("프론트에 돌려주기전 resultMap에 머가 들었나~?" + resultMap);
		
		return null;
	}

}
