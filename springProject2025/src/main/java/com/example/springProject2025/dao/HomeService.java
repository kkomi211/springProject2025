// com.example.springProject2025.service.HomeService.java

package com.example.springProject2025.dao;

import com.example.springProject2025.mapper.HomeMapper;
import com.example.springProject2025.model.Home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


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
}