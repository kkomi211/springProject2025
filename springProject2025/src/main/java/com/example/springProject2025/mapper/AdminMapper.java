package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	
	
	
	// --- 대시보드 관련 ---

    // 주문 현황 (상태별 건수)
    List<HashMap<String, Object>> selectOrderStatusCounts();

    // 총 매출 (배송완료, 교환완료)
    Long selectTotalSales();

    // 이번 달 매출 (배송완료, 교환완료)
    Long selectMonthlySales();

    // 지난 6개월 간 월별 매출
    List<HashMap<String, Object>> selectLastSixMonthsSales();

    // 총 상품 수
    int selectTotalProductCount();

    // 재고 있음 상품 수
    int selectInStockProductCount();

    // 품절 임박 상품 수 (재고 1~9개)
    int selectLowStockProductCount();

    // 판매량 Top N 상품
    List<Admin> selectTopSellingProducts(@Param("limit") int limit); // @Param 사용

    // 총 회원 수 (일반 회원만)
    int selectTotalUserCount();

    // 오늘 가입한 신규 회원 수
    int selectNewUsersTodayCount();

    // 이번 달 가입한 신규 회원 수
    int selectNewUsersMonthCount();

    // 배송 중인 주문 수
    int selectDeliveryInProgressCount();

    // 신규 신고 게시물 수 (처리요망 상태 'N')
    int selectNewReportsCount();

    // 반품 요청 대기 수
    int selectRefundRequestsCount();

    // 교환 요청 대기 수
    int selectExchangeRequestsCount();

    // 신규 상품 문의 (답변 대기중 'N')
    int selectNewProductInquiriesCount();
    
    // 결제 방법별 매출 (결제 방법이 아직 다양하지 않아서 추후 확장 사항으로 남겨둠)
    // List<HashMap<String, Object>> selectSalesByPaymentMethod();

    // 총 주문 건수
    int selectTotalOrdersCount();

    // 이번 달 주문 건수
    int selectMonthlyOrdersCount();

    // 성별 회원 분포
    List<HashMap<String, Object>> selectUsersByGenderCount();

    // 주문 이력이 있는 회원 수
    int selectUsersWithOrdersCount();

    // 총 미처리 요청 건수 (신고 + 반품요청 + 교환요청 + 상품문의 대기)
    int selectTotalPendingRequestsCount();
}
