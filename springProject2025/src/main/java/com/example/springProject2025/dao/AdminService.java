package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	
	// 회원 리스트 불러오기
	public HashMap<String, Object> getUserList(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        // 전체 아이템 수 조회
	        int totalItems = adminMapper.selectUserListCount(map);
	        
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
	        List<Admin> list = adminMapper.selectUserList(map);
	        
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
	
	
	// 회원 정보 상세 보기
	public HashMap<String, Object> getUserDetail(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        Admin userDetail = adminMapper.selectUserDetail(map);
	        if (userDetail != null) {
	            resultMap.put("detail", userDetail);
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
	
	// 회원 삭제
	public HashMap<String, Object> deleteUser(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        // 실제 데이터베이스 삭제
	        int deletedRows = adminMapper.deleteUser(map); 

	        if (deletedRows > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "회원 삭제가 완료되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "삭제할 회원을 찾을 수 없거나 이미 삭제되었습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        // 외래 키 제약 조건 등으로 인해 삭제 실패 시 구체적인 메시지 전달
	        if (e.getMessage() != null && e.getMessage().contains("ORA-02292")) { // 자식 레코드가 발견되었습니다. (FOREIGN KEY CONSTRAINTS)
	             resultMap.put("message", "회원 삭제에 실패했습니다: 해당 회원과 연결된 주문 또는 문의 내역이 존재합니다. 관련 정보를 먼저 삭제해주세요.");
	        } else {
	             resultMap.put("message", "데이터베이스 오류로 회원 삭제에 실패했습니다.");
	        }
	        System.err.println("회원 삭제 중 오류: " + e.getMessage());
	    }
	    return resultMap;
	}
	
	
	// 취소, 교환, 환불 리스트 불러오기
	public HashMap<String, Object> getRefundReturnList(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        int totalItems = adminMapper.selectRefundReturnListCount(map);
	        
	        int pageSize = 5;
	        int currentPage = 1;
	        
	        if (map.get("pageSize") != null && !map.get("pageSize").equals("")) {
	            pageSize = Integer.parseInt(map.get("pageSize").toString());
	        }
	        
	        if (map.get("currentPage") != null && !map.get("currentPage").equals("")) {
	            currentPage = Integer.parseInt(map.get("currentPage").toString());
	        }
	        
	        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
	        int startIndex = (currentPage - 1) * pageSize;
	        
	        map.put("startIndex", startIndex);
	        map.put("pageSize", pageSize);
	        
	        List<Admin> list = adminMapper.selectRefundReturnList(map);
	        
	        resultMap.put("list", list);
	        resultMap.put("totalItems", totalItems);
	        resultMap.put("totalPages", totalPages);
	        resultMap.put("currentPage", currentPage);
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.err.println("교환/반품/취소 리스트 조회 중 오류: " + e.getMessage());
	    }
	    return resultMap;
	}

	// 취소 요청 -> 취소 완료, 반품 요청 -> 반품 완료 (기존 주문 건의 상태만 변경)
	@Transactional // 트랜잭션 관리
	public HashMap<String, Object> updateRefundReturnStatus(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        int updateResult = 0;
	        String currentStatus = (String) map.get("currentStatus"); // 현재 상태
	        String newStatus = (String) map.get("newStatus");       // 변경할 상태
	        String orderNo = (String) map.get("orderNo");           // 주문번호
	        
	        map.put("status", newStatus); // 매퍼에 전달할 상태
	        
	        updateResult = adminMapper.updateRefundReturnStatus(map);
	        
	        // 반품 완료 처리인 경우: 재고 증가, SELL_COUNT 감소
	        if ("반품완료".equals(newStatus)) {
	            HashMap<String, Object> orderInfo = adminMapper.selectOrderProductInfo(map); 
	            if (orderInfo != null && orderInfo.get("PRODUCT_NO") != null && orderInfo.get("QUANTITY") != null) {
	                map.put("productNo", orderInfo.get("PRODUCT_NO"));
	                int quantity = Integer.parseInt(orderInfo.get("QUANTITY").toString());

	                map.put("quantityChange", quantity); // 재고 증가
	                adminMapper.updateProductStock(map); 

	                map.put("quantityChange", -quantity); // SELL_COUNT 감소
	                adminMapper.updateProductSellCount(map);
	            } else {
	                throw new Exception("반품 완료 처리 중 주문/제품 정보를 찾을 수 없습니다.");
	            }
	        } 
	        // ★★★ 취소 완료 처리인 경우: 재고 증가, SELL_COUNT 감소 (이 부분 추가) ★★★
	        else if ("취소완료".equals(newStatus)) {
	            HashMap<String, Object> orderInfo = adminMapper.selectOrderProductInfo(map); 
	            if (orderInfo != null && orderInfo.get("PRODUCT_NO") != null && orderInfo.get("QUANTITY") != null) {
	                map.put("productNo", orderInfo.get("PRODUCT_NO"));
	                int quantity = Integer.parseInt(orderInfo.get("QUANTITY").toString());

	                map.put("quantityChange", quantity); // 재고 증가
	                adminMapper.updateProductStock(map); 

	                map.put("quantityChange", -quantity); // SELL_COUNT 감소
	                adminMapper.updateProductSellCount(map);
	            } else {
	                throw new Exception("취소 완료 처리 중 주문/제품 정보를 찾을 수 없습니다.");
	            }
	        }


	        if(updateResult > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "상태 변경이 완료되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "상태 변경에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "오류 발생: " + e.getMessage());
	        System.err.println("교환/반품/취소 상태 업데이트 중 오류: " + e.getMessage());
	        throw new RuntimeException(e); 
	    }
	    return resultMap;
	}

	// 교환 완료 처리 (새로운 주문 생성 및 재고 관리 로직)
	@Transactional // 트랜잭션 관리
	public HashMap<String, Object> completeExchange(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        // 1. 기존 주문 상태를 '교환완료'로 변경
	        map.put("status", "교환완료");
	        int updateOriginalOrderResult = adminMapper.updateRefundReturnStatus(map);
	        if (updateOriginalOrderResult == 0) {
	            throw new Exception("기존 주문 상태 변경에 실패했습니다.");
	        }

	        // 2. 기존 주문 제품의 재고 원복 및 SELL_COUNT 감소
	        HashMap<String, Object> originalOrderInfo = adminMapper.selectOrderProductInfo(map); // orderNo 기반으로 productNo, quantity 조회
	        if (originalOrderInfo == null || originalOrderInfo.get("PRODUCT_NO") == null || originalOrderInfo.get("QUANTITY") == null) {
	            throw new Exception("기존 주문 제품 정보를 찾을 수 없습니다.");
	        }
	        HashMap<String, Object> stockSellMap = new HashMap<>(); // 재고와 판매량 업데이트를 위한 맵
	        stockSellMap.put("productNo", originalOrderInfo.get("PRODUCT_NO"));
	        int originalQuantity = Integer.parseInt(originalOrderInfo.get("QUANTITY").toString());

	        // 재고 증가 (기존 주문 수량만큼)
	        stockSellMap.put("quantityChange", originalQuantity);
	        adminMapper.updateProductStock(stockSellMap);

	        // SELL_COUNT 감소 (기존 주문 제품 판매량 감소)
	        stockSellMap.put("quantityChange", -originalQuantity);
	        adminMapper.updateProductSellCount(stockSellMap);


	        // 3. 새 PRODUCT_NO로 새로운 '신규주문' 생성
	        // ... (이전 코드와 동일) ...
	        Admin originalOrderDetails = adminMapper.selectOrderDetailsByOrderNo(map); 
	        if (originalOrderDetails == null) {
	            throw new Exception("기존 주문 상세 정보를 찾을 수 없습니다.");
	        }
	        
	        // 새로운 주문 생성에 필요한 정보들을 originalOrderDetails에서 가져오고, productNo만 변경
	        originalOrderDetails.setProductNo((String) map.get("newProductNo")); 
	        originalOrderDetails.setQuantity(Integer.parseInt(map.get("newQuantity").toString())); 
	        originalOrderDetails.setPrice(Integer.parseInt(map.get("newPrice").toString())); 

	        int newOrderNo = adminMapper.getNextOrderNoSequence();
	        originalOrderDetails.setOrderNo(newOrderNo);
	        originalOrderDetails.setStatus("신규주문"); 
	        originalOrderDetails.setBecause(null); 
	        originalOrderDetails.setUDate(null); 

	        int insertNewOrderResult = adminMapper.insertNewOrderForExchange(originalOrderDetails);
	        if (insertNewOrderResult == 0) {
	            throw new Exception("새로운 교환 주문 생성에 실패했습니다.");
	        }
	        
	        // 4. 새로운 주문 제품의 재고 감소 및 SELL_COUNT 증가
	        stockSellMap.put("productNo", map.get("newProductNo"));
	        int newQuantity = Integer.parseInt(map.get("newQuantity").toString());

	        // 재고 감소 (새로운 주문 수량만큼)
	        stockSellMap.put("quantityChange", -newQuantity);
	        adminMapper.updateProductStock(stockSellMap);

	        // SELL_COUNT 증가 (새로운 교환 제품 판매량 증가)
	        stockSellMap.put("quantityChange", newQuantity);
	        adminMapper.updateProductSellCount(stockSellMap);


	        resultMap.put("result", "success");
	        resultMap.put("message", "교환 처리가 완료되었으며, 새로운 주문이 생성되었습니다.");

	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "오류 발생: " + e.getMessage());
	        System.err.println("교환 완료 처리 중 오류: " + e.getMessage());
	        throw new RuntimeException(e); // 트랜잭션 롤백을 위해 런타임 예외 발생
	    }
	    return resultMap;
	}

	// 교환 요청 건에 대한 옵션 변경 입력 가져오기
	public HashMap<String, Object> getProductOptions(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    try {
	        String originalProductNo = (String) map.get("productNo");
	        Admin productDetails = adminMapper.selectProductByProductNo(map); // productNo로 제품 상세 정보 조회
	        
	        if (productDetails != null) {
	            // 동일 브랜드, 동일 제품명(괄호 전 부분)의 모든 제품 목록 조회
	            // 제품명에서 괄호 부분을 제거한 '제품명_줄기'를 매퍼에 전달
	            String baseProductName = productDetails.getProductName().split(" \\(")[0];
	            map.put("baseProductName", baseProductName);
	            map.put("brand", productDetails.getBrand());
	            
	            List<Admin> productOptions = adminMapper.selectRelatedProductOptions(map);
	            resultMap.put("options", productOptions);
	            resultMap.put("result", "success");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "해당 제품을 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "제품 옵션 조회 중 오류: " + e.getMessage());
	        System.err.println("제품 옵션 조회 중 오류: " + e.getMessage());
	    }
	    return resultMap;
	}
	

}
