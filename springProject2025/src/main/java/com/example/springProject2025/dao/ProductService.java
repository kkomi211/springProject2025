package com.example.springProject2025.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springProject2025.mapper.ProductMapper;
import com.example.springProject2025.model.Product;

@Service
public class ProductService {
	
	@Autowired
	ProductMapper productmapper;
	
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

	
}
