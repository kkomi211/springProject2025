package com.example.springProject2025.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.OrderService;
import com.example.springProject2025.dao.CartService;
import com.example.springProject2025.model.Order;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.lang.reflect.Type;
import java.text.SimpleDateFormat;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;

	@Autowired
	CartService cartService;

	@RequestMapping("home/mypage/orders.do")
	public String orders(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
//		System.out.println("home/mypage/orders.do진입");
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/orders"; // .jsp빠진형태
	}

	@RequestMapping("home/mypage/refund-return.do")
	public String refundreturn(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
		System.out.println("home/mypage/refund-return.do 진입");
		System.out.println("들어온 map값" + map);
		request.setAttribute("orderNo", map.get("orderNo"));
		request.setAttribute("sessionId", map.get("sessionId"));
		return "home/mypage/refund-return"; // .jsp빠진형태
	}

	@RequestMapping("home/payment/paybefore.do")
	public String paybefore(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map,
			HttpSession session) throws Exception {
		System.out.println("home/payment/paybefore.do 진입");
		System.out.println("들어온 map값" + map);

		// 브라우저 세션에서 sessionId 가져오기 (파라미터 대신 사용)
		Object sessionId = session.getAttribute("sessionId");
		if (sessionId != null) {
			request.setAttribute("sessionId", sessionId);
			System.out.println("세션에서 가져온 sessionId: " + sessionId);
		} else {
			// 세션이 없으면 파라미터로부터 가져오기 (폴백)
			request.setAttribute("sessionId", map.get("sessionId"));
			System.out.println("세션에 없음. 파라미터에서 가져온 sessionId: " + map.get("sessionId"));
		}

		// 선택된 cartNo 목록 전달 (장바구니에서 온 경우)
		// pageChange가 JSON.stringify로 변환한 문자열이 selectedCartNos 파라미터로 전달됨
		Object selectedCartNos = map.get("selectedCartNos");
		if (selectedCartNos != null) {
			// 배열이거나 문자열 모두 그대로 전달 (JSP에서 사용)
			request.setAttribute("selectedCartNos", selectedCartNos.toString());
		}

		// 제품 상세에서 직접 구매로 넘어온 경우 (제품번호, 수량, 사이즈가 있는 경우)
		Object productNo = map.get("productNo");
		Object quantity = map.get("quantity");
		Object productSize = map.get("productSize");
		if (productNo != null && quantity != null && productSize != null) {
			request.setAttribute("directProductNo", productNo.toString());
			request.setAttribute("directQuantity", quantity.toString());
			request.setAttribute("directProductSize", productSize.toString());
			System.out.println("제품 상세에서 직접 구매: productNo=" + productNo + ", quantity=" + quantity + ", size=" + productSize);
		}

		return "home/payment/paybefore"; // .jsp빠진형태
	}

//	@RequestMapping("payment/paybefore.do")
//	public String paybeforeAlt(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception {
//		System.out.println("payment/paybefore.do 진입 (대체 경로)");
//		System.out.println("들어온 map값" + map);
//		request.setAttribute("sessionId", map.get("sessionId"));
//		// 체크된 상품 데이터가 JSON 문자열로 전달될 경우를 위해 처리
//		if (map.get("selectedItemsJson") != null) {
//			request.setAttribute("selectedItemsJson", map.get("selectedItemsJson"));
//		}
//		return "home/payment/paybefore"; // .jsp빠진형태
//	}

	@RequestMapping("home/payment/payafter.do")
	public String payafter(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map,
			HttpSession session) throws Exception {
		System.out.println("home/payment/payafter.do 진입");
		System.out.println("들어온 map값" + map);

		// 브라우저 세션에서 sessionId 가져오기 (파라미터 대신 사용)
		Object sessionId = session.getAttribute("sessionId");
		if (sessionId != null) {
			request.setAttribute("sessionId", sessionId);
			System.out.println("세션에서 가져온 sessionId: " + sessionId);
		} else {
			// 세션이 없으면 파라미터로부터 가져오기 (폴백)
			request.setAttribute("sessionId", map.get("sessionId"));
			System.out.println("세션에 없음. 파라미터에서 가져온 sessionId: " + map.get("sessionId"));
		}

		// 주문 정보 전달
		request.setAttribute("orderItems", map.get("orderItems"));
		request.setAttribute("totalAmount", map.get("totalAmount"));
		request.setAttribute("paymentMethod", map.get("paymentMethod"));
		request.setAttribute("productName", map.get("productName"));
		request.setAttribute("orderDate", map.get("orderDate"));

		return "home/payment/payafter"; // .jsp빠진형태
	}

	@RequestMapping(value = "home/mypage/orders.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderslist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/orders.dox 진입 집");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = orderService.getOrderList(map);

		return new Gson().toJson(resultMap); // [{},{}]
	}

	@RequestMapping(value = "home/mypage/userInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getUserInfo(Model model, @RequestParam String userId) throws Exception {
		System.out.println("home/mypage/userInfo.dox 진입: " + userId);
		String userName = orderService.getUserName(userId);
		if (userName == null) {
			userName = "Guest";
		}
		return new Gson().toJson(userName);
	}

	@RequestMapping(value = "home/mypage/cancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String cancelOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/cancel.dox 진입: " + map);
		HashMap<String, Object> resultMap = orderService.cancelOrder(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "home/mypage/refund-return.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String refundReturnList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/mypage/refund-return.dox 진입");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = orderService.getRefundList(map);

		return new Gson().toJson(resultMap); // [{},{}]
	}

	@RequestMapping(value = "home/mypage/refund-return-appli.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String refundReturnListAppli(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		System.out.println("home/mypage/refund-return-appli.dox 진입");

		// ordersJson 파라미터에서 JSON 문자열을 받아서 파싱
		String ordersJson = (String) map.get("ordersJson");

		List<Order> orderList = new ArrayList<>();

		if (ordersJson != null && !ordersJson.isEmpty()) {
			// JSON 문자열을 List<Order>로 변환
			Gson gson = new Gson();
			Type listType = new TypeToken<List<Order>>() {
			}.getType();
			orderList = gson.fromJson(ordersJson, listType);
		}

		// HashMap에 담기
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("sessionId", map.get("sessionId"));
		paramMap.put("orders", orderList);

		// sysout 테스트
		System.out.println("들어온 HashMap 형식 데이터-----S");
		System.out.println("sessionId: " + paramMap.get("sessionId"));
		System.out.println("Orders List Size: " + orderList.size());
		if (orderList != null && !orderList.isEmpty()) {
			for (Order order : orderList) {
				System.out.println("  > OrderNo: " + order.getOrderNo() + ", ActionType: " + order.getActionType());
			}
		}
		System.out.println("들어온 HashMap 형식 데이터-----E");

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = orderService.processRefundExchange(paramMap);

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "home/payment/selectedCartItems.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getSelectedCartItems(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("home/payment/selectedCartItems.dox 진입");
		System.out.println("들어온 map값: " + map);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		// 1. 프론트에서 전송한 JSON 문자열을 "selectedCartNosJson" 키로 받습니다 (cartItemDelete와 동일한 방식)
		String jsonString = (String) map.get("selectedCartNosJson");

		// 2. JSON 문자열을 List<Object> 형태로 파싱합니다.
		List<Object> cartNoList = new ArrayList<>();
		if (jsonString != null) {
			ObjectMapper mapper = new ObjectMapper();
			cartNoList = mapper.readValue(jsonString, new TypeReference<List<Object>>() {
			});
		}

		// 3. 서비스로 전달할 paramMap을 구성합니다.
		map.put("list", cartNoList); // cartNo 목록을 'list' 키로 서비스에 전달

		System.out.println("파싱된 cartNoList: " + cartNoList);

		// 4. 서비스 호출 (선택된 상품 정보 조회)
		resultMap = cartService.getSelectedCartItems(map);

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "home/payment/payOrderI.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editpayOrderI(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("home/payment/payOrderI.dox 진입 " + map);
		// 1. **"orderItemsJson"** 키에 담긴 JSON 문자열을 받습니다.
		String orderItemsJsonString = (String) map.get("orderItemsJson");

		// 2. 배운 방식대로 List<Object> 형태로 파싱합니다.
		List<Object> orderItemList = new ArrayList<>();
		if (orderItemsJsonString != null && !orderItemsJsonString.isEmpty()) {
			ObjectMapper mapper = new ObjectMapper();
			// **List<Object>를 사용하여 파싱** (학원 방식과 동일)
			orderItemList = mapper.readValue(orderItemsJsonString, new TypeReference<List<Object>>() {
			});
		}

		// 3. 서비스로 전달할 paramMap에 'list' 키로 이 리스트를 담습니다.
		// list 안의 각 Object는 JSON 파싱에 의해 **LinkedHashMap (Map의 한 종류)** 타입이 됩니다.
		map.put("list", orderItemList);

		System.out.println("파싱된 orderItemList (MyBatis 전달용): " + orderItemList);

		// 4. 서비스 호출 및 결과 받기
		String userId = (String) map.get("userId");
		HashMap<String, Object> insertResult = orderService.processNewOrder(map);

		// 5. 주문 처리 결과를 resultMap에 복사
		resultMap.putAll(insertResult);

		// 6. DB에서 주문일자 조회 후 resultMap에 추가 (Model 사용 안함)
		if ("success".equals(insertResult.get("result"))) {
			String orderDate = orderService.getRecentOrderDate(userId);

			if (orderDate != null) {
				// 조회된 orderDate를 resultMap에 추가 (프론트 전달용)
				resultMap.put("orderDate", orderDate);
			} else {
				// 혹시 조회 실패 시 현재 시간을 resultMap에 추가
				resultMap.put("orderDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			}

		}
		System.out.println("리턴직전의 resultMap" + resultMap);
		// 7. Gson을 사용하여 JSON 문자열로 변환하여 리턴합니다.
		return new Gson().toJson(resultMap);
	}

}
