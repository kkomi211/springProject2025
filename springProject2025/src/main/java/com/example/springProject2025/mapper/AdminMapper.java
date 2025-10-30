package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;

@Mapper
public interface AdminMapper {
	
	// 목록
//	List<Admin> selectList(HashMap<String, Object> map);
	
	// banner(메인 슬라이드) 목록
	List<Admin>selectSlideBannerList(HashMap<String, Object> map);
	
	// banner(제품 광고) 목록
	List<Admin>selectProductBannerList(HashMap<String, Object> map);
	
	// banner(대회 광고) 목록
	List<Admin>selectRallyBannerList(HashMap<String, Object> map);
	
	// banner(slide) 수정/저장/삭제/추가 (update)
	int updateBannerModify(HashMap<String, Object> map);
	
	// banner(slide) 삭제
	int deleteSlideBanner(HashMap<String, Object> map);
	
	// banner(product) 삭제
	int deleteProductBanner(HashMap<String, Object> map);
	
	// banner(rally) 삭제
	int deleteRallyBanner(HashMap<String, Object> map);
	
	// banner(slide) 추가
	int insertSlideBanner(HashMap<String, Object> map);
	
	// banner(product) 추가
	int insertProductBanner(HashMap<String, Object> paramMap);
	
	// banner(rally) 추가 
	int insertRallyBanner(HashMap<String, Object> paramMap);
	
	
	
	// 상품 문의 목록 호출
	List<Admin> selectInquiryList(HashMap<String, Object> map);
	
	// 상품 문의글 상세보기
	Admin selectInquiry(HashMap<String, Object> map);
	
	// 관리자 답변 등록/수정
	int updateInquiryAnswer(HashMap<String, Object> map);
	
	// 상품 문의 총 개수 조회
	int selectInquiryListCount(HashMap<String, Object> map);
	
	// 주문 목록 조회
	List<Admin> selectOrdersList(HashMap<String, Object> map);

	// 주문 총 개수 조회
	int selectOrdersListCount(HashMap<String, Object> map);

	// 주문 상태 업데이트
	int updateOrderStatus(HashMap<String, Object> map);
	
	// 회원 목록 조회
	List<Admin> selectUserList(HashMap<String, Object> map);

	// 회원 총 개수 조회
	int selectUserListCount(HashMap<String, Object> map);

	// 회원 상세 정보 조회
	Admin selectUserDetail(HashMap<String, Object> map);
	
	// 회원 삭제
	int deleteUser(HashMap<String, Object> map);

	int insertRallyImg(HashMap<String, Object> map);
}
