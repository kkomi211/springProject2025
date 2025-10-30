package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;

@Mapper
public interface AdminMapper {
	
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
	
	// 교환/반품/취소 목록 조회
	List<Admin> selectRefundReturnList(HashMap<String, Object> map);

	// 교환/반품/취소 총 개수 조회
	int selectRefundReturnListCount(HashMap<String, Object> map);

	// 교환/반품/취소 상태 업데이트 (일반적인 상태 변경)
	int updateRefundReturnStatus(HashMap<String, Object> map);

	// 특정 주문 번호의 제품 정보(productNo, quantity) 조회
	HashMap<String, Object> selectOrderProductInfo(HashMap<String, Object> map);

	// 제품 재고 업데이트 (+ 또는 -)
	int updateProductStock(HashMap<String, Object> map);
	
	// 제품 판매량(SELL_COUNT) 업데이트 (+ 또는 -)
	int updateProductSellCount(HashMap<String, Object> map);

	// 주문 상세 정보 전체 조회 (새로운 주문 생성에 재활용하기 위함)
	Admin selectOrderDetailsByOrderNo(HashMap<String, Object> map);

	// ORDER_NO 시퀀스에서 다음 값 가져오기 (Oracle)
	int getNextOrderNoSequence();

	// 교환으로 인한 신규 주문 삽입
	int insertNewOrderForExchange(Admin admin);

	// productNo로 제품 상세 정보 조회
	Admin selectProductByProductNo(HashMap<String, Object> map);

	// 동일 브랜드, 제품명(괄호 전 부분)의 모든 관련 제품 옵션 조회 (재고가 0 이상인 것만)
	List<Admin> selectRelatedProductOptions(HashMap<String, Object> map);
	
	// 신고 게시물 리스트 조회
	List<Admin> selectBoardReportList(HashMap<String, Object> map);

	// 신고 게시물 총 개수 조회
	int selectBoardReportListCount(HashMap<String, Object> map);

	// 신고 게시물 상세 조회
	Admin selectBoardReportDetail(HashMap<String, Object> map);

	// 신고 확인 상태 'Y'로 변경 (처리)
	int updateReportStatusToY(HashMap<String, Object> map);

	// 게시글 삭제
	int deleteBoard(HashMap<String, Object> map);
}
