// com.example.springProject2025.service.HomeService.java

package com.example.springProject2025.dao;

import com.example.springProject2025.mapper.HomeMapper;
import com.example.springProject2025.model.Home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;


@Service
public class HomeService {

    @Autowired
    private HomeMapper homeMapper;

    // 메인 슬라이드 이미지 목록 조회
    public List<Home> getMainSlideImages() {
        return homeMapper.selectMainSlideImages();
    }

    // 추천 상품 목록 조회 (예: 6개)
    public List<Home> getRecommendedProducts(int limit) {
        return homeMapper.selectTopSellingProducts(limit);
    }

    // 최신 대회 목록 조회 (예: 4개)
    public List<Home> getLatestRallies(int limit) {
        return homeMapper.selectLatestRallies(limit);
    }

    // 예산 기반 상품 추천
    //251117
    public List<HashMap<String, Object>> getBudgetRecommendations(int budget) {
        // 카테고리 정의: 러닝화, 보호대, 러닝복 상의, 러닝복 하의
        String[] categories = {"러닝화", "보호대", "러닝복 상의", "러닝복 하의"};
        List<HashMap<String, Object>> result = new ArrayList<>();
        
        // 각 카테고리별로 예산을 균등하게 분배 (또는 전체 예산 기준으로 조회)
        // 일단 각 카테고리별로 전체 예산을 기준으로 상품을 조회하되, 
        // 각 카테고리당 예산의 25%를 기본 할당
        int categoryBudget = budget / categories.length;
        
        for (String categoryName : categories) {
            HashMap<String, Object> categoryMap = new HashMap<>();
            categoryMap.put("categoryName", categoryName);
            
            // 각 카테고리별로 예산 내 상품 조회 (전체 예산 기준)
            HashMap<String, Object> paramMap = new HashMap<>();
            paramMap.put("categoryName", categoryName);
            paramMap.put("budget", budget); // 전체 예산을 기준으로 조회
            
            List<Home> products = homeMapper.selectBudgetProductsByCategory(paramMap);
            System.out.println("카테고리: " + categoryName + ", 조회된 상품 수: " + (products != null ? products.size() : 0));
            
            List<HashMap<String, Object>> recommendedProducts = new ArrayList<>();
            int categoryTotal = 0;
            
            if (products != null && !products.isEmpty()) {
                // 가장 비싼 제품 1개만 선택 (1세트 개념)
                // ORDER BY DESC로 정렬되어 있으므로 첫 번째가 가장 비싼 제품
                Home mostExpensiveProduct = products.get(0);
                int finalPrice;
                if (mostExpensiveProduct.getSaleYN() != null && "Y".equals(mostExpensiveProduct.getSaleYN()) && mostExpensiveProduct.getSalePrice() > 0) {
                    finalPrice = mostExpensiveProduct.getSalePrice();
                } else {
                    finalPrice = mostExpensiveProduct.getProductPrice();
                }
                
                // 예산을 초과하더라도 최소 1개는 추천
                if (finalPrice <= categoryBudget * 2) {
                    HashMap<String, Object> productMap = new HashMap<>();
                    productMap.put("productNo", mostExpensiveProduct.getProductNo());
                    productMap.put("productName", mostExpensiveProduct.getProductName());
                    productMap.put("finalPrice", finalPrice);
                    productMap.put("imgPath", mostExpensiveProduct.getImgPath());
                    productMap.put("brand", mostExpensiveProduct.getBrand());
                    recommendedProducts.add(productMap);
                    categoryTotal = finalPrice;
                }
            }
            
            // 상품이 하나도 없으면, 예산 범위를 늘려서 최소 1개라도 추천
            if (recommendedProducts.isEmpty() && categoryBudget > 0) {
                // 예산을 2배로 늘려서 다시 조회
                paramMap.put("budget", categoryBudget * 2);
                List<Home> fallbackProducts = homeMapper.selectBudgetProductsByCategory(paramMap);
                
                if (fallbackProducts != null && !fallbackProducts.isEmpty()) {
                    // 가장 비싼 상품 1개라도 추천 (가격 내림차순 정렬이므로 첫 번째가 가장 비쌈)
                    Home mostExpensiveProduct = fallbackProducts.get(0);
                    int finalPrice;
                    if (mostExpensiveProduct.getSaleYN() != null && "Y".equals(mostExpensiveProduct.getSaleYN()) && mostExpensiveProduct.getSalePrice() > 0) {
                        finalPrice = mostExpensiveProduct.getSalePrice();
                    } else {
                        finalPrice = mostExpensiveProduct.getProductPrice();
                    }
                    
                    // 예산을 초과하더라도 최소 1개는 추천
                    if (finalPrice <= categoryBudget * 2) {
                        HashMap<String, Object> productMap = new HashMap<>();
                        productMap.put("productNo", mostExpensiveProduct.getProductNo());
                        productMap.put("productName", mostExpensiveProduct.getProductName());
                        productMap.put("finalPrice", finalPrice);
                        productMap.put("imgPath", mostExpensiveProduct.getImgPath());
                        productMap.put("brand", mostExpensiveProduct.getBrand());
                        recommendedProducts.add(productMap);
                        categoryTotal = finalPrice;
                    }
                }
            }
            
            categoryMap.put("products", recommendedProducts);
            categoryMap.put("totalPrice", categoryTotal);
            categoryMap.put("percentage", budget > 0 ? (categoryTotal * 100.0 / budget) : 0);
            
            result.add(categoryMap);
        }
        
        return result;
    }

    //251117
    // 단일 카테고리별 예산 기반 상품 추천
    public List<HashMap<String, Object>> getBudgetRecommendationsByCategory(int budget, String categoryName) {
        List<HashMap<String, Object>> result = new ArrayList<>();
        
        HashMap<String, Object> categoryMap = new HashMap<>();
        categoryMap.put("categoryName", categoryName);
        
        // 카테고리별로 예산 내 상품 조회
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("categoryName", categoryName);
        paramMap.put("budget", budget);
        
        List<Home> products = homeMapper.selectBudgetProductsByCategory(paramMap);
        System.out.println("단일 카테고리 조회 - 카테고리: " + categoryName + ", 조회된 상품 수: " + (products != null ? products.size() : 0));
        
        List<HashMap<String, Object>> recommendedProducts = new ArrayList<>();
        int categoryTotal = 0;
        
        if (products != null && !products.isEmpty()) {
            // 가장 비싼 제품 1개만 선택 (1세트 개념)
            // ORDER BY DESC로 정렬되어 있으므로 첫 번째가 가장 비싼 제품
            Home mostExpensiveProduct = products.get(0);
            int finalPrice;
            if (mostExpensiveProduct.getSaleYN() != null && "Y".equals(mostExpensiveProduct.getSaleYN()) && mostExpensiveProduct.getSalePrice() > 0) {
                finalPrice = mostExpensiveProduct.getSalePrice();
            } else {
                finalPrice = mostExpensiveProduct.getProductPrice();
            }
            
            // 예산을 초과하더라도 최소 1개는 추천
            if (finalPrice <= budget * 2) {
                HashMap<String, Object> productMap = new HashMap<>();
                productMap.put("productNo", mostExpensiveProduct.getProductNo());
                productMap.put("productName", mostExpensiveProduct.getProductName());
                productMap.put("finalPrice", finalPrice);
                productMap.put("imgPath", mostExpensiveProduct.getImgPath());
                productMap.put("brand", mostExpensiveProduct.getBrand());
                recommendedProducts.add(productMap);
                categoryTotal = finalPrice;
            }
        }
        
        // 상품이 하나도 없으면, 예산 범위를 늘려서 최소 1개라도 추천
        if (recommendedProducts.isEmpty() && budget > 0) {
            // 예산을 2배로 늘려서 다시 조회
            paramMap.put("budget", budget * 2);
            List<Home> fallbackProducts = homeMapper.selectBudgetProductsByCategory(paramMap);
            
            if (fallbackProducts != null && !fallbackProducts.isEmpty()) {
                // 가장 비싼 상품 1개라도 추천 (가격 내림차순 정렬이므로 첫 번째가 가장 비쌈)
                Home mostExpensiveProduct = fallbackProducts.get(0);
                int finalPrice;
                if (mostExpensiveProduct.getSaleYN() != null && "Y".equals(mostExpensiveProduct.getSaleYN()) && mostExpensiveProduct.getSalePrice() > 0) {
                    finalPrice = mostExpensiveProduct.getSalePrice();
                } else {
                    finalPrice = mostExpensiveProduct.getProductPrice();
                }
                
                // 예산을 초과하더라도 최소 1개는 추천
                if (finalPrice <= budget * 2) {
                    HashMap<String, Object> productMap = new HashMap<>();
                    productMap.put("productNo", mostExpensiveProduct.getProductNo());
                    productMap.put("productName", mostExpensiveProduct.getProductName());
                    productMap.put("finalPrice", finalPrice);
                    productMap.put("imgPath", mostExpensiveProduct.getImgPath());
                    productMap.put("brand", mostExpensiveProduct.getBrand());
                    recommendedProducts.add(productMap);
                    categoryTotal = finalPrice;
                }
            }
        }
        
        categoryMap.put("products", recommendedProducts);
        categoryMap.put("totalPrice", categoryTotal);
        // percentage는 프론트엔드에서 전체 예산 기준으로 계산하므로 여기서는 반환하지 않음
        // categoryMap.put("percentage", budget > 0 ? (categoryTotal * 100.0 / budget) : 0);
        
        result.add(categoryMap);
        return result;
    }
}