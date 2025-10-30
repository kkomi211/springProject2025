package com.example.springProject2025.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springProject2025.dao.AdminService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping("admin.do")
	public String login(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/admin-main-default"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/banner.do")
	public String banner(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/banner"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/inquiry.do")
	public String inquery(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/inquiry"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/inquiry/view.do") 
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map.get("inquiryNo"));
		request.setAttribute("inquiryNo", map.get("inquiryNo"));
        return "admin/inquiry-view";
    }
	
	@RequestMapping("admin/refund-return.do")
	public String refundReturn(Model model) throws Exception {
		return "admin/refund-return"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/product.do")
	public String product(Model model) throws Exception {
		return "admin/product"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/orders.do")
	public String orders(Model model) throws Exception {
		return "admin/orders"; // .jsp빠진형태
	}
	@RequestMapping("admin/board-report.do")
	public String boardReport(Model model) throws Exception {
		return "admin/board-report"; // .jsp빠진형태
	}
	
	@RequestMapping("admin/user-list.do")
	public String userList(Model model) throws Exception {
		return "admin/user-list"; // .jsp빠진형태
	}
	
	// banner(메인 슬라이드 광고) list
	@RequestMapping(value = "/admin/slidebanner.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String slideList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.getSlidebannerList(map);
		return new Gson().toJson(resultMap);
	}
	
	// banner(제품 광고) list
	@RequestMapping(value = "/admin/productbanner.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.getSlidebannerList(map);
		return new Gson().toJson(resultMap);
	}
	
	// banner(제품 광고) list
	@RequestMapping(value = "/admin/rallybanner.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rallyList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.getSlidebannerList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("admin/user-list/view.do")
	public String userDetailView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception { // HttpServletRequest 추가
	    request.setAttribute("userId", map.get("userId")); // model.addAttribute 대신 request.setAttribute 사용
	    // model.addAttribute("userId", map.get("userId")); // 이 줄은 제거하거나 주석 처리
	    return "admin/user-list-view"; // admin/user-list/view.jsp 로 이동
	}
	
	// 상품 문의내역 리스트 불러오기 메소드
	@RequestMapping(value = "admin/inquiry.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.getInquiryList(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 상품 문의내역 상세보기 메소드
	@RequestMapping(value = "admin/inquiry/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.getInquiry(map);
		
		return new Gson().toJson(resultMap);
	}
	
	// 상품 문의내역 관리자 답변 등록 메소드
	@RequestMapping(value = "admin/inquiry/registerAnswer.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String registerAnswer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    
	    resultMap = adminService.registerInquiryAnswer(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	// 주문내역 리스트 불러오기 메소드
	@RequestMapping(value = "admin/orders.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String ordersList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.getOrdersList(map);
	    return new Gson().toJson(resultMap);
	}
	
	// slide banner update 수정
	@RequestMapping(value = "/admin/bannerUpdate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String update(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.bannerModify(map);
		
		return new Gson().toJson(resultMap);
	}
	// 주문내역 상태 변경(신규주문->배송중, 배송중->배송완료) 메소드
	@RequestMapping(value = "admin/orders/updateStatus.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateOrderStatus(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.updateOrderStatus(map);
	    return new Gson().toJson(resultMap);
	}
	
	
	// 회원 리스트 불러오기
	@RequestMapping(value = "admin/user-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userListAjax(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.getUserList(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 회원 정보 상세보기
	@RequestMapping(value = "admin/user-list/detail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userDetailAjax(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.getUserDetail(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 회원 삭제
	@RequestMapping(value = "admin/user-list/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap = adminService.deleteUser(map);
	    return new Gson().toJson(resultMap);
	}


	
	
	// slide banner delete 삭제
	@RequestMapping(value = "/admin/bannerSlideDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String slidedelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("--------------------------"+ map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.removeSlideBanner(map);
		
		return new Gson().toJson(resultMap);
	}
	
	// product banner delete 삭제
		@RequestMapping(value = "/admin/productBannerDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String productdelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.removeProductBanner(map);
			
			return new Gson().toJson(resultMap);
		}
		
	// rally banner delete 삭제
		@RequestMapping(value = "/admin/rallyBannerDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String rallydelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.removeRallyBanner(map);
					
			return new Gson().toJson(resultMap);
		}
	
	// slide banner insert 추가
		@RequestMapping(value = "/admin/slideBannerInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String slideadd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.addSlideBanner(map);
			
			return new Gson().toJson(resultMap);
		}
		
	// product banner insert 추가
			@RequestMapping(value = "/admin/productBannerInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
			@ResponseBody
			public String productadd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				HashMap<String, Object> resultMap = new HashMap<String, Object>();
				resultMap = adminService.addProductBanner(map);
					
				return new Gson().toJson(resultMap);
			}
			
		// rally banner insert 추가
				@RequestMapping(value = "/admin/rallyBannerInsert.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
				@ResponseBody
			public String rallyadd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				HashMap<String, Object> resultMap = new HashMap<String, Object>();
				resultMap = adminService.addRallyBanner(map);
								
				return new Gson().toJson(resultMap);
			}	
	}
