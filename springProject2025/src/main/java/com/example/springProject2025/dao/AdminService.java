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
	
	// 상품 문의내역 리스트(검색필터, 페이징 포함)
	public HashMap<String, Object> getInquiryList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
	        // 전체 아이템 수 조회
	        int totalItems = adminMapper.selectInquiryListCount(map);
	        
	        // 페이지 크기와 현재 페이지 파라미터 처리
	        int pageSize = 5; // 기본값
	        int currentPage = 1; // 기본값
	        
	        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
	            pageSize = Integer.parseInt(map.get("pageSize").toString());
	        }
	        
	        if (map.get("currentPage") != null && !map.get("currentPage").equals("")) {
	            currentPage = Integer.parseInt(map.get("currentPage").toString());
	        }
	        
	        // 전체 페이지 수 계산
	        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
	        
	        // 시작 인덱스 계산 (0부터 시작)
	        int startIndex = (currentPage - 1) * pageSize;
	        
	        // 페이징 정보 추가
	        map.put("startIndex", startIndex);
	        map.put("pageSize", pageSize);
	        
	        // 리스트 조회
	        List<Admin> list = adminMapper.selectInquiryList(map);
	        
	        resultMap.put("list", list);
	        resultMap.put("totalItems", totalItems);
	        resultMap.put("totalPages", totalPages);
	        resultMap.put("currentPage", currentPage);
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.out.println(e.getMessage());
	    }
	    
	    return resultMap;
	}
	
	// 상품 문의 상세보기
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
	
	// 관리자 답변 등록 메소드
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
	
	
	// 주문 내역 리스트(검색 필터, 페이징 포함)
	public HashMap<String, Object> getOrdersList(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        // 전체 아이템 수 조회
	        int totalItems = adminMapper.selectOrdersListCount(map);
	        
	        // 페이지 크기와 현재 페이지 파라미터 처리
	        int pageSize = 5; // 기본값
	        int currentPage = 1; // 기본값
	        
	        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
	            pageSize = Integer.parseInt(map.get("pageSize").toString());
	        }
	        
	        if (map.get("currentPage") != null && !map.get("currentPage").equals("")) {
	            currentPage = Integer.parseInt(map.get("currentPage").toString());
	        }
	        
	        // 전체 페이지 수 계산
	        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
	        
	        // 시작 인덱스 계산 (0부터 시작)
	        int startIndex = (currentPage - 1) * pageSize;
	        
	        // 페이징 정보 추가
	        map.put("startIndex", startIndex);
	        map.put("pageSize", pageSize);
	        
	        // 리스트 조회
	        List<Admin> list = adminMapper.selectOrdersList(map);
	        
	        resultMap.put("list", list);
	        resultMap.put("totalItems", totalItems);
	        resultMap.put("totalPages", totalPages);
	        resultMap.put("currentPage", currentPage);
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.out.println(e.getMessage());
	    }
	    
	    return resultMap;
	}
	
	
	// 주문내역 상태 변경
	public HashMap<String, Object> updateOrderStatus(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        int result = adminMapper.updateOrderStatus(map);
	        
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
