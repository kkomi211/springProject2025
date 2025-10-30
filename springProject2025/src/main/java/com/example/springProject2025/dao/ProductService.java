package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.springProject2025.controller.OrderController;
import com.example.springProject2025.mapper.ProductMapper;
import com.example.springProject2025.model.Admin;
import com.example.springProject2025.model.Product;

@Service
public class ProductService {

    private final OrderController orderController;
	
	@Autowired
	ProductMapper productmapper;

    ProductService(OrderController orderController) {
        this.orderController = orderController;
    }
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		List<Product> list =  productmapper.selectProductList(map);
		int cnt = productmapper.selectProductPage(map);
		
		resultMap.put("total", cnt);
		resultMap.put("list", list);
		
		return resultMap;
	}

	public HashMap<String, Object> getProductInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Product product = productmapper.selectProductInfo(map);
		Product img = productmapper.selectProductImg(map);
		resultMap.put("info", product);
		resultMap.put("img", img);
		
			
		return resultMap;
	}

	public HashMap<String, Object> EditProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productmapper.editProduct(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> DeleteProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productmapper.deleteProduct(map);
			int cnt2 = productmapper.deleteProductImg(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> InsertProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productmapper.insertProduct(map);
			resultMap.put("result", "success");
			resultMap.put("productNo", map.get("productNo"));
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public void addProductImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = productmapper.insertProductImg(map);
	}

	public HashMap<String, Object> getProductImgList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> imgList = productmapper.selectProductImgList(map);
			resultMap.put("imgList", imgList);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getReviewList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> reviewList = productmapper.selectReviewList(map);
			List<Product> avgRating = productmapper.selectReviewAvg(map);
			resultMap.put("reviewList", reviewList);
			resultMap.put("avgRating", avgRating);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getUserProductList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list = productmapper.selectProductListUser(map);
			int total = productmapper.selectProductPageUser(map);
			List<Product> typeList = productmapper.selectProductTypeList(map);
			System.out.println(map);
			resultMap.put("list", list);
			resultMap.put("typeList", typeList);
			resultMap.put("total", total);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getProductUserInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product info = productmapper.selectProductInfoUser(map);
			List<Product> sizeList = productmapper.selectSizeAndQuantity(map);
			resultMap.put("info", info);
			resultMap.put("sizeList", sizeList);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getInquiryList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> inquiryList = productmapper.selectInquiryList(map);
			int cnt = productmapper.selectInquiryCount(map);
			resultMap.put("inquiryList", inquiryList);
			resultMap.put("inquiryTotal", cnt);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getInquiryView(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("dfddddddddddddddd");
		System.out.println(map);
		try {
			int cnt = productmapper.selectInquiryPwd(map);
			if(cnt < 1) {
				resultMap.put("success", "false");
				resultMap.put("code", "BAD_PWD");
				resultMap.put("message", "비밀번호가 일치하지 않습니다.");
			} else {
				Product inquiry = productmapper.selectInquiryView(map);
				resultMap.put("success", "true");
				resultMap.put("inquiry", inquiry);

			}
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		System.out.println(resultMap);
		return resultMap;
	}
	
	public HashMap<String, Object> getProductReviewList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		try {
			List<Product> reviewList = productmapper.selectReviewList(map);
			int cnt = productmapper.selectReviewListCnt(map);
			resultMap.put("reviewList", reviewList);
			resultMap.put("cnt", cnt);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getheartUp(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productmapper.updateReviewHeart(map);
			resultMap.put("result", "success");
		} catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	
}
