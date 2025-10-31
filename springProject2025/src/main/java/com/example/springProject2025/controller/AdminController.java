package com.example.springProject2025.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Spring MVC Model
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.springProject2025.dao.AdminService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;   // ← jakarta로 통일
import jakarta.servlet.http.HttpServletResponse;  // ← jakarta로 통일

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class AdminController {

	@Autowired
	AdminService adminService;

	@RequestMapping("admin.do")
	public String login(Model model) throws Exception {
		System.out.println("컨트롤러 admin.do진입");
		return "admin/admin-main"; // .jsp빠진형태
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
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
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

	
	@RequestMapping("admin/board-report-view.do")
	public String boardReportDetail(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		request.setAttribute("reportBoardNo", map.get("reportBoardNo"));
		// model.addAttribute("reportBoardNo", reportBoardNo); // 상세보기에 필요한 신고게시물 식별번호 전달
	    return "admin/board-report-view"; // admin/board-report-detail.jsp 로 이동
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
	public String userDetailView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception { // HttpServletRequest 추가
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
	
	
	// 취소, 교환, 환불 리스트 불러오기
	@RequestMapping(value = "admin/refund-return.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getRefundReturnList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.getRefundReturnList(map);
	    return new Gson().toJson(resultMap);
	}

	// 주문 상태를 취소/반품/교환 완료로 업데이트 (일반적인 경우)
	@RequestMapping(value = "admin/refund-return/updateStatus.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateRefundReturnStatus(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.updateRefundReturnStatus(map);
	    return new Gson().toJson(resultMap);
	}

	// 교환 완료 처리 (옵션 변경 및 새 주문 생성 로직 포함)
	@RequestMapping(value = "admin/refund-return/completeExchange.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String completeExchange(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.completeExchange(map);
	    return new Gson().toJson(resultMap);
	}

	// 교환/반품 모달에서 제품 옵션을 가져올 때 (동일 제품의 다른 옵션 리스트)
	@RequestMapping(value = "admin/refund-return/getProductOptions.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getProductOptions(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.getProductOptions(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 신고게시물 리스트 가져오기
	@RequestMapping(value = "admin/board-report.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getBoardReportList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.getBoardReportList(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 신고게시물 상세보기
	@RequestMapping(value = "admin/board-report-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getBoardReportDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.getBoardReportDetail(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 신고게시물 관리자 처리
	@RequestMapping(value = "admin/board-report/process.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String processBoardReport(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.processBoardReport(map);
	    return new Gson().toJson(resultMap);
	}
	
	// 신고게시물 삭제 처리
	@RequestMapping(value = "admin/board-report/deleteBoard.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteBoardReported(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = adminService.deleteBoardReported(map);
	    return new Gson().toJson(resultMap);
	}

	// slide banner delete 삭제
	@RequestMapping(value = "/admin/bannerSlideDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String slidedelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("--------------------------" + map);
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
	
	

	// ===== 파일 업로드(JSON 응답) =====
	@RequestMapping("/rally/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("rallyNo") int rallyNo,
			HttpServletRequest request, HttpServletResponse response, Model model) {

		String url = null;
		String path = "c:\\img";

		try {
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);

//			System.out.println("uploadpath : " + uploadpath);
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
			if (!multi.isEmpty()) {
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
				multi.transferTo(file); 

				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("fileName", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("rallyNo", rallyNo);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);

				// insert 쿼리 실행
				adminService.addRallyImg(map);

				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());

				return "redirect:list.do";
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}

	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}
			
		
				
	/**
     * 주문 현황 데이터 조회 (막대 그래프용)
     */
    @GetMapping("admin/dashboard/orderStatus.dox")
    @ResponseBody
    public String getOrderStatusData() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            List<HashMap<String, Object>> data = adminService.getOrderStatusCounts();
            resultMap.put("result", "success");
            resultMap.put("data", data);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "주문 현황 조회 중 오류: " + e.getMessage());
            System.err.println("주문 현황 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 매출 현황 데이터 조회 (총 매출, 월별 매출 그래프용)
     */
    @GetMapping("admin/dashboard/salesSummary.dox")
    @ResponseBody
    public String getSalesSummaryData() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            HashMap<String, Object> data = adminService.getSalesSummary();
            resultMap.put("result", "success");
            resultMap.put("data", data);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "매출 현황 조회 중 오류: " + e.getMessage());
            System.err.println("매출 현황 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 상품 요약 데이터 조회
     */
    @GetMapping("admin/dashboard/productSummary.dox")
    @ResponseBody
    public String getProductSummaryData() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            HashMap<String, Object> data = adminService.getProductSummary();
            resultMap.put("result", "success");
            resultMap.put("data", data);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "상품 요약 조회 중 오류: " + e.getMessage());
            System.err.println("상품 요약 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 회원 요약 데이터 조회
     */
    @GetMapping("admin/dashboard/userSummary.dox")
    @ResponseBody
    public String getUserSummaryData() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            HashMap<String, Object> data = adminService.getUserSummary();
            resultMap.put("result", "success");
            resultMap.put("data", data);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "회원 요약 조회 중 오류: " + e.getMessage());
            System.err.println("회원 요약 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }

    /**
     * 요청/상태 요약 데이터 조회 (배송, 신고, 반품/교환)
     */
    @GetMapping("admin/dashboard/requestSummary.dox")
    @ResponseBody
    public String getRequestSummaryData() {
        HashMap<String, Object> resultMap = new HashMap<>();
        try {
            HashMap<String, Object> data = adminService.getRequestSummary();
            resultMap.put("result", "success");
            resultMap.put("data", data);
        } catch (Exception e) {
            resultMap.put("result", "fail");
            resultMap.put("message", "요청 요약 조회 중 오류: " + e.getMessage());
            System.err.println("요청 요약 조회 중 오류: " + e.getMessage());
        }
        return new Gson().toJson(resultMap);
    }
}
