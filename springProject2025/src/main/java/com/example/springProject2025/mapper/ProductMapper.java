package com.example.springProject2025.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Admin;
import com.example.springProject2025.model.Product;

@Mapper
public interface ProductMapper {
	
	// 목록
//	List<Admin> selectList(HashMap<String, Object> map);
	
	int selectProductPage(HashMap<String, Object> map);
	
	int selectProductPageUser(HashMap<String, Object> map);
	
	List<Product> selectProductList(HashMap<String, Object> map);

	Product selectProductInfo(HashMap<String, Object> map);

	int editProduct(HashMap<String, Object> map);
	
	int deleteProduct(HashMap<String, Object> map);

	int insertProduct(HashMap<String, Object> map);

	int insertProductImg(HashMap<String, Object> map);
	
	int deleteProductImg(HashMap<String, Object> map);
	
	Product selectProductImg(HashMap<String, Object> map);

	List<Product> selectProductImgList(HashMap<String, Object> map);

	List<Product> selectReviewList(HashMap<String, Object> map);
	
	List<Product> selectReviewAvg(HashMap<String, Object> map);
	
	List<Product> selectProductListUser(HashMap<String, Object> map);
	
	List<Product> selectProductTypeList(HashMap<String, Object> map);

	Product selectProductInfoUser(HashMap<String, Object> map);

	List<Product> selectSizeAndQuantity(HashMap<String, Object> map);

	List<Product> selectInquiryList(HashMap<String, Object> map);
	

}
