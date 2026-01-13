package com.example.springProject2025.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import com.example.springProject2025.dao.ProductService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest; // ← jakarta로 통일
import jakarta.servlet.http.HttpServletResponse; // ← jakarta로 통일

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {

  @Autowired
  AdminService adminService;

  @Autowired
  ProductService productService;

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
  public String boardReportDetail(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
      throws Exception {
    request.setAttribute("reportBoardNo", map.get("reportBoardNo"));
    // model.addAttribute("reportBoardNo", reportBoardNo); // 상세보기에 필요한 신고게시물 식별번호
    // 전달
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

  // 상품 문의내역 일괄 답변 등록 메소드
  @RequestMapping(value = "admin/inquiry/batchAnswer.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  @ResponseBody
  public String batchAnswer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    HashMap<String, Object> resultMap = new HashMap<String, Object>();
    resultMap = adminService.batchRegisterInquiryAnswer(map);
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

  // 주문내역 일괄 상태 변경 메소드
  @RequestMapping(value = "admin/orders/batchUpdateStatus.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  @ResponseBody
  public String batchUpdateOrderStatus(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
    HashMap<String, Object> resultMap = new HashMap<String, Object>();
    resultMap = adminService.batchUpdateOrderStatus(map);
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
    System.out.println("rallyDate = " + map.get("rallyDate"));
    System.out.println("applicationPeriod = " + map.get("applicationPeriod"));
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

      // System.out.println("uploadpath : " + uploadpath);
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
        System.out.println(map);
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

  /**
   * 시간대별 주문 통계 데이터 조회
   */
  @GetMapping("admin/dashboard/ordersByHour.dox")
  @ResponseBody
  public String getOrdersByHourData() {
    HashMap<String, Object> resultMap = new HashMap<>();
    try {
      List<HashMap<String, Object>> data = adminService.getOrdersByHour();
      resultMap.put("result", "success");
      resultMap.put("data", data);
    } catch (Exception e) {
      resultMap.put("result", "fail");
      resultMap.put("message", "시간대별 주문 통계 조회 중 오류: " + e.getMessage());
      System.err.println("시간대별 주문 통계 조회 중 오류: " + e.getMessage());
    }
    return new Gson().toJson(resultMap);
  }

  /**
   * 카테고리별 매출 비율 데이터 조회
   */
  @GetMapping("admin/dashboard/salesByCategory.dox")
  @ResponseBody
  public String getSalesByCategoryData() {
    HashMap<String, Object> resultMap = new HashMap<>();
    try {
      List<HashMap<String, Object>> data = adminService.getSalesByCategory();
      resultMap.put("result", "success");
      resultMap.put("data", data);
    } catch (Exception e) {
      resultMap.put("result", "fail");
      resultMap.put("message", "카테고리별 매출 비율 조회 중 오류: " + e.getMessage());
      System.err.println("카테고리별 매출 비율 조회 중 오류: " + e.getMessage());
    }
    return new Gson().toJson(resultMap);
  }

  /**
   * 회원 가입 추이 데이터 조회
   */
  @GetMapping("admin/dashboard/userRegistrationTrend.dox")
  @ResponseBody
  public String getUserRegistrationTrendData() {
    HashMap<String, Object> resultMap = new HashMap<>();
    try {
      List<HashMap<String, Object>> data = adminService.getUserRegistrationTrend();
      resultMap.put("result", "success");
      resultMap.put("data", data);
    } catch (Exception e) {
      resultMap.put("result", "fail");
      resultMap.put("message", "회원 가입 추이 조회 중 오류: " + e.getMessage());
      System.err.println("회원 가입 추이 조회 중 오류: " + e.getMessage());
    }
    return new Gson().toJson(resultMap);
  }

  /**
   * 품절 임박 상품 목록 데이터 조회
   */
  @GetMapping("admin/dashboard/lowStockProducts.dox")
  @ResponseBody
  public String getLowStockProductsData() {
    HashMap<String, Object> resultMap = new HashMap<>();
    try {
      List<HashMap<String, Object>> data = adminService.getLowStockProducts(10); // 상위 10개
      resultMap.put("result", "success");
      resultMap.put("data", data);
    } catch (Exception e) {
      resultMap.put("result", "fail");
      resultMap.put("message", "품절 임박 상품 조회 중 오류: " + e.getMessage());
      System.err.println("품절 임박 상품 조회 중 오류: " + e.getMessage());
    }
    return new Gson().toJson(resultMap);
  }

  /**
   * 주문 내역 엑셀 다운로드
   */
  @RequestMapping(value = "admin/orders/excel.dox", method = RequestMethod.GET)
  public void downloadOrdersExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 전체 주문 내역 조회 (페이징 없이)
      map.put("pageSize", 10000); // 충분히 큰 값
      map.put("currentPage", 1);
      HashMap<String, Object> resultMap = adminService.getOrdersList(map);
      @SuppressWarnings("unchecked")
      List<HashMap<String, Object>> ordersList = (List<HashMap<String, Object>>) resultMap.get("list");

      // 엑셀 파일 생성
      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("주문 내역");

      // 헤더 스타일
      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      // 헤더 생성
      Row headerRow = sheet.createRow(0);
      String[] headers = { "주문번호", "고객ID", "고객명", "제품번호", "결제금액", "주문일자", "상태" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      // 데이터 행 생성
      int rowNum = 1;
      for (HashMap<String, Object> order : ordersList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(order.get("orderNo") != null ? order.get("orderNo").toString() : "");
        row.createCell(1).setCellValue(order.get("userId") != null ? order.get("userId").toString() : "");
        row.createCell(2).setCellValue(order.get("name") != null ? order.get("name").toString() : "");
        row.createCell(3).setCellValue(order.get("productNo") != null ? order.get("productNo").toString() : "");
        row.createCell(4).setCellValue(order.get("paymentAmount") != null ? order.get("paymentAmount").toString() : "");
        row.createCell(5).setCellValue(order.get("cDate") != null ? order.get("cDate").toString() : "");
        row.createCell(6).setCellValue(order.get("status") != null ? order.get("status").toString() : "");
      }

      // 컬럼 너비 자동 조정
      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      // 응답 헤더 설정
      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition", "attachment; filename=orders_" + System.currentTimeMillis() + ".xlsx");

      // 파일 다운로드
      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }

  /**
   * 회원 리스트 엑셀 다운로드
   */
  @RequestMapping(value = "admin/user-list/excel.dox", method = RequestMethod.GET)
  public void downloadUsersExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 전체 회원 리스트 조회
      map.put("pageSize", 10000);
      map.put("currentPage", 1);
      HashMap<String, Object> resultMap = adminService.getUserList(map);
      @SuppressWarnings("unchecked")
      List<HashMap<String, Object>> usersList = (List<HashMap<String, Object>>) resultMap.get("list");

      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("회원 리스트");

      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      Row headerRow = sheet.createRow(0);
      String[] headers = { "유저아이디", "이름", "닉네임", "이메일", "가입날짜" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      int rowNum = 1;
      for (HashMap<String, Object> user : usersList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(user.get("userId") != null ? user.get("userId").toString() : "");
        row.createCell(1).setCellValue(user.get("name") != null ? user.get("name").toString() : "");
        row.createCell(2).setCellValue(user.get("nickName") != null ? user.get("nickName").toString() : "");
        row.createCell(3).setCellValue(user.get("email") != null ? user.get("email").toString() : "");
        row.createCell(4).setCellValue(user.get("cDate") != null ? user.get("cDate").toString() : "");
      }

      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition", "attachment; filename=users_" + System.currentTimeMillis() + ".xlsx");

      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }

  /**
   * 문의 내역 엑셀 다운로드
   */
  @RequestMapping(value = "admin/inquiry/excel.dox", method = RequestMethod.GET)
  public void downloadInquiryExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 전체 문의 내역 조회
      map.put("pageSize", 10000);
      map.put("currentPage", 1);
      HashMap<String, Object> resultMap = adminService.getInquiryList(map);
      @SuppressWarnings("unchecked")
      List<HashMap<String, Object>> inquiryList = (List<HashMap<String, Object>>) resultMap.get("list");

      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("문의 내역");

      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      Row headerRow = sheet.createRow(0);
      String[] headers = { "문의번호", "상품명", "문의제목", "ID", "이름", "등록일", "상태" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      int rowNum = 1;
      for (HashMap<String, Object> inquiry : inquiryList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(inquiry.get("inquiryNo") != null ? inquiry.get("inquiryNo").toString() : "");
        row.createCell(1).setCellValue(inquiry.get("productName") != null ? inquiry.get("productName").toString() : "");
        row.createCell(2).setCellValue(inquiry.get("title") != null ? inquiry.get("title").toString() : "");
        row.createCell(3).setCellValue(inquiry.get("userId") != null ? inquiry.get("userId").toString() : "");
        row.createCell(4).setCellValue(inquiry.get("name") != null ? inquiry.get("name").toString() : "");
        row.createCell(5).setCellValue(inquiry.get("cDate") != null ? inquiry.get("cDate").toString() : "");
        String status = inquiry.get("status") != null ? inquiry.get("status").toString() : "";
        row.createCell(6).setCellValue("Y".equals(status) ? "답변 완료" : "답변 대기");
      }

      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition",
          "attachment; filename=inquiries_" + System.currentTimeMillis() + ".xlsx");

      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }

  /**
   * 신고 게시물 엑셀 다운로드
   */
  @RequestMapping(value = "admin/board-report/excel.dox", method = RequestMethod.GET)
  public void downloadBoardReportExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 전체 신고 게시물 리스트 조회
      map.put("pageSize", 10000);
      map.put("currentPage", 1);
      HashMap<String, Object> resultMap = adminService.getBoardReportList(map);
      @SuppressWarnings("unchecked")
      List<HashMap<String, Object>> reportList = (List<HashMap<String, Object>>) resultMap.get("list");

      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("신고 게시물");

      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      Row headerRow = sheet.createRow(0);
      String[] headers = { "신고식별번호", "신고게시물번호", "게시물제목", "신고자ID", "신고자이름", "신고날짜", "처리상태" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      int rowNum = 1;
      for (HashMap<String, Object> report : reportList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0)
            .setCellValue(report.get("reportBoardNo") != null ? report.get("reportBoardNo").toString() : "");
        row.createCell(1)
            .setCellValue(report.get("reportedBoardNo") != null ? report.get("reportedBoardNo").toString() : "");
        row.createCell(2).setCellValue(report.get("boardTitle") != null ? report.get("boardTitle").toString() : "");
        row.createCell(3).setCellValue(report.get("reporterId") != null ? report.get("reporterId").toString() : "");
        row.createCell(4).setCellValue(report.get("reporterName") != null ? report.get("reporterName").toString() : "");
        row.createCell(5).setCellValue(report.get("cDate") != null ? report.get("cDate").toString() : "");
        String status = report.get("reportStatus") != null ? report.get("reportStatus").toString() : "";
        row.createCell(6).setCellValue("Y".equals(status) ? "처리완료" : "처리요망");
      }

      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition",
          "attachment; filename=board_reports_" + System.currentTimeMillis() + ".xlsx");

      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }

  /**
   * 교환/반품/취소 엑셀 다운로드
   */
  @RequestMapping(value = "admin/refund-return/excel.dox", method = RequestMethod.GET)
  public void downloadRefundReturnExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 전체 교환/반품/취소 리스트 조회
      map.put("pageSize", 10000);
      map.put("currentPage", 1);
      HashMap<String, Object> resultMap = adminService.getRefundReturnList(map);
      @SuppressWarnings("unchecked")
      List<HashMap<String, Object>> refundReturnList = (List<HashMap<String, Object>>) resultMap.get("list");

      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("교환반품취소");

      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      Row headerRow = sheet.createRow(0);
      String[] headers = { "주문번호", "상품명", "사이즈", "유저ID", "유저이름", "연락처", "신청일", "상태", "사유" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      int rowNum = 1;
      for (HashMap<String, Object> item : refundReturnList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(item.get("orderNo") != null ? item.get("orderNo").toString() : "");
        row.createCell(1).setCellValue(item.get("productName") != null ? item.get("productName").toString() : "");
        row.createCell(2).setCellValue(item.get("productSize") != null ? item.get("productSize").toString() : "");
        row.createCell(3).setCellValue(item.get("userId") != null ? item.get("userId").toString() : "");
        row.createCell(4).setCellValue(item.get("name") != null ? item.get("name").toString() : "");
        row.createCell(5).setCellValue(item.get("phone") != null ? item.get("phone").toString() : "");
        row.createCell(6).setCellValue(item.get("cDate") != null ? item.get("cDate").toString() : "");
        row.createCell(7).setCellValue(item.get("status") != null ? item.get("status").toString() : "");
        row.createCell(8).setCellValue(item.get("because") != null ? item.get("because").toString() : "");
      }

      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition",
          "attachment; filename=refund_return_" + System.currentTimeMillis() + ".xlsx");

      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }

  /**
   * 상품 리스트 엑셀 다운로드
   */
  @RequestMapping(value = "admin/product/excel.dox", method = RequestMethod.GET)
  public void downloadProductExcel(@RequestParam HashMap<String, Object> map, HttpServletResponse response)
      throws Exception {
    try {
      // 상품 리스트는 ProductService를 사용해야 할 수도 있지만,
      // 일단 AdminService에 메서드가 있다고 가정하고 진행
      // 없으면 ProductService를 사용하거나 직접 조회

      // 전체 상품 리스트 조회를 위해 큰 페이지 사이즈 설정
      map.put("pageSize", 10000);
      map.put("page", 0);

      HashMap<String, Object> resultMap = productService.getProductList(map);
      @SuppressWarnings("unchecked")
      List<com.example.springProject2025.model.Product> productList = (List<com.example.springProject2025.model.Product>) resultMap
          .get("list");

      Workbook workbook = new XSSFWorkbook();
      Sheet sheet = workbook.createSheet("상품 리스트");

      CellStyle headerStyle = workbook.createCellStyle();
      headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
      headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      Font headerFont = workbook.createFont();
      headerFont.setBold(true);
      headerFont.setFontHeightInPoints((short) 12);
      headerStyle.setFont(headerFont);

      Row headerRow = sheet.createRow(0);
      String[] headers = { "제품번호", "제품이름", "가격", "할인가격", "재고", "사이즈", "등록/수정일자" };
      for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
        cell.setCellStyle(headerStyle);
      }

      int rowNum = 1;
      for (com.example.springProject2025.model.Product product : productList) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(product.getProductNo() != null ? product.getProductNo().toString() : "");
        row.createCell(1).setCellValue(product.getProductName() != null ? product.getProductName() : "");
        row.createCell(2).setCellValue(product.getPrice()); // int 타입이므로 직접 숫자 값 사용
        row.createCell(3).setCellValue(
            product.getSalePrice() != null && !product.getSalePrice().isEmpty() ? product.getSalePrice() : "");
        row.createCell(4).setCellValue(product.getQuantity()); // int 타입이므로 직접 숫자 값 사용
        row.createCell(5).setCellValue(product.getProductSize() != null ? product.getProductSize() : "");
        row.createCell(6).setCellValue(product.getUdate() != null ? product.getUdate() : "");
      }

      for (int i = 0; i < headers.length; i++) {
        sheet.autoSizeColumn(i);
      }

      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-Disposition",
          "attachment; filename=products_" + System.currentTimeMillis() + ".xlsx");

      workbook.write(response.getOutputStream());
      workbook.close();
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "엑셀 다운로드 중 오류가 발생했습니다.");
    }
  }
}
