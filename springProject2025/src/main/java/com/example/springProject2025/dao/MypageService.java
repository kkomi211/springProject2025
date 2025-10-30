package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.MypageMapper;
import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.mapper.ReviewMapper;
import com.example.springProject2025.model.Admin;
import com.example.springProject2025.model.MyInquiry;
import com.example.springProject2025.model.Review;

@Service
public class MypageService {

	@Autowired
	MypageMapper mypageMapper;

	public HashMap<String, Object> getMyInquiryList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// 전체 아이템 수 조회
			int totalItems = mypageMapper.selectMyInquiryListCnt(map);

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
			List<MyInquiry> list = mypageMapper.selectMyInquiryList(map);

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

	public HashMap<String, Object> getMyInquiryDetail(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
//					int cnt = bbsMapper.updateCnt(map); // 일단 조회수부터 올리고 아래(상세내용) 보여주기
			MyInquiry myInquiry = mypageMapper.selectMyInquiry(map);

//					List<Comment> commentList = bbsMapper.selectCommentList(map);
			//
//					List<Board> fileList = bbsMapper.selectFileList(map);

//					System.out.println("서비스에서 fileList에 값 넣기직전 fileList는 " + fileList);
//					resultMap.put("fileList", fileList);
			resultMap.put("info", myInquiry);
//							System.out.println("서비스에서 commentlist에 값 넣기직전 info는 " + board );
//					resultMap.put("commentList", commentList);
			resultMap.put("result", "success");

		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

		return resultMap;

	}

}
