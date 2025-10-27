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
	
	public HashMap<String, Object> getInquiryList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Admin> list = adminMapper.selectInquiryList(map);
			
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Admin admin = adminMapper.selectInquiry(map);
			
			resultMap.put("info", admin);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		
		return resultMap;
	}
	
	// 관리자 답변 등록 메소드 추가
	public HashMap<String, Object> registerInquiryAnswer(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = adminMapper.updateInquiryAnswer(map);
			
			if(result > 0) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}

}
