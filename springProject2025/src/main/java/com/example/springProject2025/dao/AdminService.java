package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.AdminMapper;
import com.example.springProject2025.model.Admin;

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
	
	// banner List 
	public HashMap<String, Object> getbannerList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminMapper.selectbannerList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	// banner update 수정/저장 
	public HashMap<String, Object> bannerModify(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int list = adminMapper.updateBannerModify(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> removeBanner(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int delet = adminMapper.deleteBanner(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> addBanner(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int add = adminMapper.insertBanner(map);

		resultMap.put("result", "success");
		return resultMap;
	}

}
