package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

			if (result > 0) {
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

			if (result > 0) {
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
			if (e.getMessage() != null && e.getMessage().contains("ORA-02292")) { // 자식 레코드가 발견되었습니다. (FOREIGN KEY
																					// CONSTRAINTS)
				resultMap.put("message", "회원 삭제에 실패했습니다: 해당 회원과 연결된 주문 또는 문의 내역이 존재합니다. 관련 정보를 먼저 삭제해주세요.");
			} else {
				resultMap.put("message", "데이터베이스 오류로 회원 삭제에 실패했습니다.");
			}
			System.err.println("회원 삭제 중 오류: " + e.getMessage());
		}
		return resultMap;
	}

	// banner(슬라이드, 제품, 대회 광고) List
	public HashMap<String, Object> getSlidebannerList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminMapper.selectSlideBannerList(map);
		List<Admin> list1 = adminMapper.selectProductBannerList(map);
		List<Admin> list2 = adminMapper.selectRallyBannerList(map);

		resultMap.put("list", list);
		resultMap.put("list1", list1);
		resultMap.put("list2", list2);
		resultMap.put("result", "success");
		return resultMap;
	}

	// slide banner update 수정/저장
	public HashMap<String, Object> bannerModify(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int list = adminMapper.updateBannerModify(map);

		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	// slide banner delect 삭제
	public HashMap<String, Object> removeSlideBanner(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int slidedelet = adminMapper.deleteSlideBanner(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	
	// product banner delect 삭제
		public HashMap<String, Object> removeProductBanner(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int productdelet = adminMapper.deleteProductBanner(map);

			resultMap.put("result", "success");
			return resultMap;
		}
		
	// rally banner delect 삭제
		public HashMap<String, Object> removeRallyBanner(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int rallydelet = adminMapper.deleteRallyBanner(map);

			resultMap.put("result", "success");
			return resultMap;
		}
	
		
	// slide banner insert 추가
	public HashMap<String, Object> addSlideBanner(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int slideadd = adminMapper.insertSlideBanner(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	
	// product banner insert 추가
		public HashMap<String, Object> addProductBanner(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int productadd = adminMapper.insertProductBanner(map);

			resultMap.put("result", "success");
			return resultMap;
		}
		
	// rally banner insert 추가
		public HashMap<String, Object> addRallyBanner(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			int rallyadd = adminMapper.insertRallyBanner(map);
			System.out.println("rallyNo from map: " + map.get("rallyNo"));
			resultMap.put("result", "success");
			resultMap.put("rallyNo", map.get("rallyNo"));
			return resultMap;
		}

		public void addRallyImg(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			int cnt = adminMapper.insertRallyImg(map);
		}

}
