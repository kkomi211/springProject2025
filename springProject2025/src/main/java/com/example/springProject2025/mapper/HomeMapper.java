package com.example.springProject2025.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.springProject2025.model.Home;

@Mapper
public interface HomeMapper {
	// 메인 슬라이드 이미지 조회 (BANNER_ID는 오라클 NUMBER(10000)으로 되어있어 NUMBER로 매핑)
    List<Home> selectMainSlideImages();

    // 베스트셀러/추천 상품 (예: SELL_COUNT 높은 상품)
    List<Home> selectTopSellingProducts(@org.apache.ibatis.annotations.Param("limit") int limit);

    // 상품 이미지 (하나의 상품에 여러 이미지가 있을 수 있으므로, 대표 이미지 1개를 가져오는 로직 필요)
    Home selectProductMainImage(int productNo);

    // 최신 대회 정보 조회 (ACTIVE한 대회를 가져와야 합니다.)
    List<Home> selectLatestRallies(@org.apache.ibatis.annotations.Param("limit") int limit);
    
    // 대회 대표 이미지 조회
    Home selectRallyMainImage(int rallyNo);
}
