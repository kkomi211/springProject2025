package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;

@Mapper
public interface AdminMapper {
	
	// 목록
//	List<Admin> selectList(HashMap<String, Object> map);
	
	// banner 목록
	List<Admin>selectbannerList(HashMap<String, Object> map);
	
	// banner 수정/저장/삭제/추가 (update)
	int updateBannerModify(HashMap<String, Object> map);
	
	// banner 삭제
	int deleteBanner(HashMap<String, Object> map);
	
	// banner 추가
	int insertBanner(HashMap<String, Object> map);
}
