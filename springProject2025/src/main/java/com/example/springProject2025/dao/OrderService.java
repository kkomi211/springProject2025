package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.springProject2025.mapper.CartMapper;
import com.example.springProject2025.mapper.OrderMapper;
import com.example.springProject2025.mapper.ProductMapper;
import com.example.springProject2025.model.Order;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderService {

	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	CartMapper cartMapper;
	
	@Autowired
	ProductMapper productMapper;

	public HashMap<String, Object> getOrderList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectOrderListCount(map);
			List<Order> list = orderMapper.selectOrderList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}

		return resultMap;
	}

	public String getUserName(String userId) {
		try {
			return orderMapper.selectUserName(userId);
		} catch (Exception e) {
			System.out.println("getUserName 에러: " + e.getMessage());
			return "Guest";
		}
	}

	public HashMap<String, Object> cancelOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.updateOrderCancel(map);

			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("주문취소 요청 완료 - 주문번호: " + map.get("orderNo"));

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("주문취소 에러: " + e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> getRefundList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectRefundListCount(map);
			List<Order> list = orderMapper.selectRefundList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}


		return resultMap;
	}

	public HashMap<String, Object> processRefundExchange(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			@SuppressWarnings("unchecked")
			List<Order> orderList = (List<Order>) map.get("orders");
			
			if (orderList == null || orderList.isEmpty()) {
				resultMap.put("result", "fail");
				resultMap.put("message", "처리할 주문이 없습니다.");
				return resultMap;
			}

			int totalUpdated = 0;
			
			for (Order order : orderList) {
				HashMap<String, Object> updateMap = new HashMap<String, Object>();
				updateMap.put("orderNo", order.getOrderNo());
				updateMap.put("reason", order.getReason());
				
				// actionType에 따라 STATUS 설정: 'R' = 반품요청, 'C' = 교환요청
				if ("R".equals(order.getActionType())) {
					updateMap.put("status", "반품요청");
				} else if ("C".equals(order.getActionType())) {
					updateMap.put("status", "교환요청");
				} else {
					// 기본값은 반품요청
					updateMap.put("status", "반품요청");
				}
				
				int cnt = orderMapper.updateRefundExchange(updateMap);
				totalUpdated += cnt;
				
				System.out.println("반품/교환 신청 처리 - 주문번호: " + order.getOrderNo() + 
				                  ", 상태: " + updateMap.get("status") + ", 처리 건수: " + cnt);
			}

			resultMap.put("cnt", totalUpdated);
			resultMap.put("result", "success");
			resultMap.put("message", "정상적으로 신청이 접수되었습니다.");

		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "처리 중 오류가 발생했습니다: " + e.getMessage());
			System.out.println("반품/교환 신청 처리 에러: " + e.getMessage());
			e.printStackTrace();
		}

		return resultMap;
	}

	public HashMap<String, Object> getReviewList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = orderMapper.selectReviewListCount(map);
			List<Order> list = orderMapper.selectReviewList(map);

			resultMap.put("list", list);
			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");

			System.out.println("OrderService - resultMap: " + resultMap);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println("OrderService 에러: " + e.getMessage());
		}

		return resultMap;
	}
	
	/**
	 * 신규 주문 내역을 DB에 일괄 삽입합니다. (다수 제품 동시 주문 처리목적)
	 * @param map 컨트롤러에서 받은 데이터 맵 (필수 키: "list" - 주문 항목 List<HashMap or VO>)
	 * @return 처리 결과를 담은 HashMap (result, cnt)
	 */
	/*
	public HashMap<String, Object> processNewOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			// 1. 맵에서 주문 항목 리스트를 추출합니다.
			//    OrderMapper.xml의 <foreach collection="list">에 맞춰 키는 "list"를 사용합니다.
//			@SuppressWarnings("unchecked")
			List<HashMap<String, Object>> orderList = (List<HashMap<String, Object>>) map.get("list");
			
			if (orderList == null || orderList.isEmpty()) {
				resultMap.put("result", "fail");
				resultMap.put("message", "주문할 상품 목록이 비어 있습니다.");
				return resultMap;
			}
			
			// 2. Mybatis 매퍼의 insertOrderList(List)를 호출하여 일괄 삽입을 실행합니다.
			//    int cnt는 삽입된 총 행의 수입니다.
			int cnt = orderMapper.insertOrderList(orderList); 

			resultMap.put("cnt", cnt);
			resultMap.put("result", "success");
			resultMap.put("message", "총 " + cnt + "개의 주문이 성공적으로 처리되었습니다.");

			System.out.println("신규 주문 처리 완료 - 삽입 건수: " + cnt);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "신규 주문 처리 중 오류가 발생했습니다: " + e.getMessage());
			System.out.println("신규 주문 처리 에러: " + e.getMessage());
			e.printStackTrace();
		}

		return resultMap;
	}
	 */
	
	/**
	 * 신규 주문 내역을 DB에 개별적으로 반복 삽입합니다. (다수 제품 동시 주문 처리목적)
	 * 성능을 위해 MyBatis Batch Executor를 구성할 수도 있으나, 여기서는 트랜잭션 내에서 개별 Insert를 실행합니다.
	 * @param map 컨트롤러에서 받은 데이터 맵 (필수 키: "list" - 주문 항목 List<HashMap>)
	 * @return 처리 결과를 담은 HashMap (result, cnt)
	 */
    // 이 메서드 전체를 하나의 트랜잭션?으로 묶어 안정성을 확보합니다.
	@Transactional 
	public HashMap<String, Object> processNewOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			// 1. 맵에서 주문 항목 리스트를 HashMap 타입으로 추출합니다.
			@SuppressWarnings("unchecked")
			List<HashMap<String, Object>> orderList = (List<HashMap<String, Object>>) map.get("list");
			
			// 1-1. 카트 번호 리스트 추출 (장바구니 삭제에 사용)
	        String selectedCartNosJson = (String) map.get("selectedCartNosJson");
	        List<Object> cartNoList = null;
	        if (selectedCartNosJson != null && !selectedCartNosJson.isEmpty()) {
	            ObjectMapper mapper = new ObjectMapper();
	            // JSON 문자열 ["1012","101"] 형태를 List<String>으로 파싱
	            cartNoList = mapper.readValue(selectedCartNosJson, new TypeReference<List<Object>>() {});
	        }
	        
			if (orderList == null || orderList.isEmpty()) {
				resultMap.put("result", "fail");
				resultMap.put("message", "주문할 상품 목록이 비어 있습니다.");
				return resultMap;
			}
			
			// 2. 주문 항목 리스트를 반복하면서 ORDER INSERT 및 PRODUCT UPDATE를 실행합니다.
	        int totalInserted = 0;
			

	        for (HashMap<String, Object> item : orderList) {
	            
	            // 2-1. ORDERS 테이블에 주문 항목 삽입
	            int orderInsertCnt = orderMapper.insertOrderItem(item); 
	            
	            if (orderInsertCnt > 0) {
	                // 2-2. PRODUCT 테이블 재고/판매량 업데이트 (핵심 추가 로직)
	                // item 맵에는 productNo와 quantity가 모두 들어있어야 합니다.
	                int productUpdateCnt = productMapper.updateProductStockAndSellCount(item);
	                
	                if (productUpdateCnt > 0) {
	                    totalInserted++;
	                } else {
	                    // 재고 부족 등의 이유로 0이 리턴된 경우: 
	                    // RuntimeException을 발생시켜 @Transactional로 전체 롤백을 유도합니다.
	                    throw new RuntimeException("상품 번호 " + item.get("productNo") + "의 재고 업데이트에 실패했습니다.");
	                }
	            } else {
	                throw new RuntimeException("주문 정보 insert에 실패했습니다.");
	            }
	        }

	        // 3. CART 테이블에서 주문한 상품 삭제 (수정할 부분)
	        if (cartNoList != null && !cartNoList.isEmpty()) {
	            
	            // 🚨 해결책: List를 HashMap에 담아 매퍼에 전달
	            HashMap<String, Object> cartParam = new HashMap<>();
	            
	            // 키를 "list"로 사용합니다. (MyBatis <foreach>의 기본 collection 이름)
	            // CartMapper.xml에서 이 "list" 키를 사용하게 됩니다.
	            cartParam.put("list", cartNoList); 
	            
	            // HashMap을 인수로 전달하여 기존 매퍼 메서드를 호출합니다.
	            cartMapper.deleteCartItemList(cartParam); 
	        }
	        
	        
			resultMap.put("cnt", totalInserted);
			resultMap.put("result", "success");
			resultMap.put("message", "총 " + totalInserted + "개의 주문이 성공적으로 처리되었습니다.");

			System.out.println("신규 주문 처리 완료 - 삽입 건수: " + totalInserted);

		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "신규 주문 처리 중 오류가 발생했습니다: " + e.getMessage());
			System.out.println("신규 주문 처리 에러: " + e.getMessage());
			e.printStackTrace();
			// @Transactional 덕분에 예외 발생 시 전체 작업이 롤백됩니다.
		}

		return resultMap;
	}
	
	public String getRecentOrderDate(String userId) {
	    try {
	        return orderMapper.selectRecentOrderDate(userId);
	    } catch (Exception e) {
	        System.out.println("가장 최근 주문 시간 조회 에러: " + e.getMessage());
	        return null;
	    }
	}
}
