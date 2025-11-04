<%-- src/main/webapp/WEB-INF/home/home.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RUNNERS HOUSE</title>
    <!-- jQuery, Vue.js, Font Awesome (아이콘용) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- Swiper.js CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

    <!-- 사용자 정의 스타일시트 -->
    <link rel="stylesheet" href="/css/style.css">
    
    <!-- Google Fonts (Fugaz One) -->
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">

    <script src="/js/page-change.js"></script>

    <style>
        /* style.css */

        /* --- 기본 레이아웃 설정 --- */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #333;
            line-height: 1.6;
        }
        #app { /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        a:hover {
            text-decoration: none;
        }

        /* --- Header Section (화면 전체 너비) --- */
        header { /* default 헤더 스타일이 header 태그에 직접 적용되도록 재구성 */
            width: 100%;
            background-color: black; /* default top-header의 배경색을 header 전체로 */
            color: white; /* default top-header의 글자색을 header 전체로 */
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .top-header { /* default top-header가 header의 유일한 자식이 됨 */
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 150px; /* default top-header의 높이 */
            padding: 0 40px; /* default footer padding과 맞춤 */
            box-sizing: border-box; /* 패딩이 width에 포함되도록 */
        }
        .top-header div {
            display: inline-block;
            text-align: left;
            font-size: 15px;
            margin-right: 0; /* flex gap 사용을 위해 개별 div 마진 제거 */
        }
        .top-header input {
            height: 25px;
            border-radius: 8px;
            width: 200px;
        }

        .brand-name { /* top-header 내 brand-name */
            margin-right: 0; /* top-header div의 default margin-right 상쇄 */
        }
        .brand-name div {
            font-family: 'Fugaz One', sans-serif;
            font-size: 60px;
            letter-spacing: 5px;
            margin-left: 0; /* top-header div의 default margin-left 상쇄 */
            display: block;
            color: white; /* default 유지 */
        }
        .brand-name a {
            color: white;
        }

        #right-items {
            display: flex;
            align-items: center;
            gap: 20px; /* 요소들 간 간격 */
        }
        #right-items div {
            font-size: 15px;
            white-space: nowrap;
        }
        #right-items div a {
            color: white; /* default top-header의 글자색 */
        }
        #right-items div a:hover {
            color: #eee;
        }

        .bottom-header {
            display: flex;
            justify-content: center;
            font-size: 30px; /* default bottom-header 폰트 사이즈 */
            background-color: white; /* bottom-header 배경색 추가 */
            border-bottom: 1px solid #eee; /* 하단 경계선 */
            padding: 20px 0; /* 세로 패딩 */
        }
        .bottom-header div {
            display: inline-block;
            margin-right: 100px; /* default bottom-header div의 마진 */
            margin-top: 0; /* flex-align으로 중앙 정렬 */
            text-align: center;
        }
        .bottom-header div:last-child {
            margin-right: 0;
        }
        .bottom-header a {
            color: black; /* default bottom-header 링크색 */
        }
        .bottom-header a:hover {
            color: #007bff;
        }


        /* --- Main Content Section (콘텐츠 너비 제한) --- */
        .container { /* 전체를 감싸는 컨테이너 */
            /* max-width는 모든 페이지 콘텐츠가 중앙 정렬될 때 사용. 메인 배너는 뚫고 나옴 */
            /* 현재로서는 모든 콘텐츠를 포함하는 div가 어떤 역할을 하는지 알기 어려워 이 컨테이너는
            다른 곳에서 max-width가 적용되어 있을 수 있으므로 여기서는 초기화만. */
            width: 100%;
            margin: 0 auto;
            position: relative; /* 자식 요소 포지셔닝 기준 */
        }

        main {
            width: 100%;
            margin: 0 auto;
            position: relative;
            /* max-width: 1440px; /* 이전에 제안했던 최대 너비 */
        }

        /* 각 섹션별 내부 패딩은 섹션 자체에서 관리하도록 조정 */
        main > section { /* main 바로 아래 섹션에만 적용 */
            padding: 80px 0; /* 각 섹션 상하 여백 */
            position: relative;
            overflow: hidden; /* 섹션 내 오버플로우 방지 */
        }
        main > section h2 {
            font-size: 2.8em; /* 섹션 제목 크게 */
            font-weight: 700;
            text-align: center;
            margin-bottom: 60px; /* 제목 아래 큰 여백 */
            letter-spacing: -0.02em; /* ASICS는 약간 좁은 자간을 쓰는 경향 */
        }

        /* Main Hero Slider styles (메인 상단 배너) */
        .main-hero-slider-area {
            /* 이 영역이 브라우저 너비 전체를 차지하도록 */
            width: 100vw; /* 뷰포트 너비 전체 */
            position: relative;
            left: 50%;
            right: 50%;
            margin-left: -50vw; /* 왼쪽으로 50vw 밀고 */
            margin-right: -50vw; /* 오른쪽으로 50vw 밀어서 풀 너비 확장 */
            overflow: hidden; /* 영역 밖으로 나가는 콘텐츠 숨김 */
            background-color: #f8f8f8; /* 로드 전/후 배경색 */
            height: 650px; /* 이미지 높이를 지정 */
        }

        .main-hero-slider {
            /* 이 section은 풀 브라우저 너비를 차지하도록 만듭니다. */
            width: 100%;
            height: 100%; /* 부모와 동일한 높이 */
            padding: 0; /* 상하 패딩 제거 */
            position: relative;
        }

        .main-hero-slider .swiper-container {
            width: 100%; /* 부모 section의 너비를 꽉 채움 */
            height: 100%; /* 부모 section의 높이를 꽉 채움 */
            margin: 0; /* Swiper 기본 마진 제거 */
        }

        .main-hero-slider .swiper-slide {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative; /* 텍스트 오버레이를 위한 기준점 */
        }

        .main-hero-slider .swiper-slide a {
            display: block; /* 링크 전체 클릭 가능 */
            width: 100%;
            height: 100%;
        }

        .main-hero-slider .swiper-slide img {
            width: 100%; /* 슬라이드 너비를 꽉 채움 */
            height: 100%; /* 슬라이드 높이를 꽉 채움 */
            object-fit: cover; /* 이미지가 잘려도 비율 유지하며 채움 */
            object-position: center; /* 이미지의 중앙이 보이도록 */
            display: block;
        }

        /* Swiper 페이지네이션 (하단 점 스타일) */
        .main-hero-slider .swiper-pagination {
            bottom: 30px !important; /* 이미지 위에 오도록 위치 조정 */
            z-index: 10; /* 이미지 위에 표시되도록 z-index 부여 */
        }
        .main-hero-slider .swiper-pagination-bullet {
            background-color: #fff; /* 흰색 점 */
            opacity: 0.7;
            margin: 0 8px !important;
            width: 12px; /* 점 크기 조절 */
            height: 12px;
            transition: opacity 0.3s ease, background-color 0.3s ease;
        }
        .main-hero-slider .swiper-pagination-bullet-active {
            background-color: #007bff; /* 활성 점은 ASICS스러운 블루 계열 */
            opacity: 1;
        }

        /* ★★★ 양쪽 사이드를 가릴 div 처리 ★★★ */
        /* 메인 슬라이더를 풀 너비로 확장했으므로, 이 div들은 이제 필요 없을 가능성이 높습니다. */
        /* 만약 이 div들이 특정 배경색으로 사이드를 채우는 역할을 한다면 다음과 같이 처리할 수 있습니다. */
        /* 하지만 메인 배너 이미지가 풀 너비라면 이 div들은 보이지 않습니다. */
        .main-hero-slider-area .swiper-side-cover {
            display: none; /* 현재는 풀 너비 배너이므로 숨김 */
            /* 만약 swiper-container에 max-width를 주고 양 옆을 이 div로 채우는 디자인이라면,
            main-hero-slider-area에 position: relative;를 주고,
            left/right 커버에 position: absolute, top/bottom/left/right 0, z-index -1
            같은 스타일을 주어 배경색을 채울 수 있습니다.
            하지만 현재는 스위퍼 이미지 자체가 풀 너비이므로 display: none; 처리 */
        }

        /* 텍스트 오버레이 (선택 사항): ASICS JOG 100S처럼 이미지 위에 텍스트를 올리려면 */
        /* home.jsp의 swiper-slide 내부에 다음 HTML 구조를 추가해주세요.
        <div class="banner-text-overlay">
            <p class="banner-subtitle">새로운 러닝의 시작</p>
            <h3 class="banner-title">{{ slide.title }}</h3>
            <p class="banner-description">가벼움과 안정성, 완벽한 조화를 경험하세요.</p>
            <a :href="slide.LINK_URL" class="banner-button">자세히 보기</a>
        </div>
        */
        .banner-text-overlay {
            position: absolute;
            top: 50%;
            left: 10%; /* 좌측 여백 */
            transform: translateY(-50%);
            color: #fff;
            text-align: left;
            max-width: 500px; /* 텍스트가 너무 길어지지 않도록 */
            z-index: 5; /* 이미지 위에 텍스트가 보이도록 */
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6); /* 어두운 이미지에서 가독성 확보 */
        }
        .banner-text-overlay .banner-subtitle {
            font-size: 1.1em;
            font-weight: 300;
            margin-bottom: 10px;
            letter-spacing: 0.1em;
        }
        .banner-text-overlay .banner-title {
            font-size: 3.2em; /* 메인 제목 크기 */
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.1;
            color: #fff;
        }
        .banner-text-overlay .banner-description {
            font-size: 1em;
            font-weight: 400;
            margin-bottom: 30px;
        }
        .banner-text-overlay .banner-button {
            display: inline-block;
            background-color: #007bff; /* ASICS스러운 블루 */
            color: #fff;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1em;
            font-weight: 500;
            transition: background-color 0.3s ease;
            text-shadow: none;
        }
        .banner-text-overlay .banner-button:hover {
            background-color: #0056b3;
        }


        /* ====== 추천 상품 영역 ====== */
        .products-showcase {
            background-color: #fff; /* 섹션 배경색 */
        }

        .products-showcase .products-main-content-wrapper {
            display: flex; /* Flexbox로 왼쪽/오른쪽 영역 배치 */
            gap: 40px; /* 두 영역 사이의 간격 */
            max-width: 1520px; /* 메인 컨테이너 너비에 맞춤 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 0 40px; /* 좌우 여백 */
            align-items: stretch; /* 자식 요소들의 높이를 동일하게 */
        }

        /* 왼쪽 고정 이미지 영역 */
        .products-showcase .fixed-image-area {
            flex: 1.2; /* 왼쪽 영역이 오른쪽 영역보다 약간 더 넓게 */
            position: relative;
            overflow: hidden;
            border-radius: 0;
            box-shadow: none;
        }
        .products-showcase .fixed-image-area img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 잘려도 컨테이너를 꽉 채움 */
            display: block;
        }
        .products-showcase .image-text-overlay {
            position: absolute;
            bottom: 30px; /* 하단에서부터 위치 */

            right: 30px;
            color: #fff;
            text-align: left;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
            z-index: 2; /* 이미지 위에 오도록 */
        }
        .products-showcase .image-text-overlay h3 {
            font-size: 2.2em;
            font-weight: 700;
            margin-bottom: 10px;
            line-height: 1.2;
            color: #fff; /* 텍스트 흰색 */
        }
        .products-showcase .image-text-overlay p {
            font-size: 1.1em;
            font-weight: 400;
            margin-bottom: 25px;
        }
        .products-showcase .image-text-overlay .cta-button {
            display: inline-block;
            background-color: #007bff; /* ASICS 블루 계열 */
            color: #fff;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1em;
            font-weight: 500;
            transition: background-color 0.3s ease;
            text-shadow: none;
            border: none;
            cursor: pointer;
        }
        .products-showcase .image-text-overlay .cta-button:hover {
            background-color: #0056b3;
        }

        /* 오른쪽 상품 4개 그리드 영역 */
        .products-showcase .recommended-products-grid {
            flex: 1; /* 오른쪽 영역이 왼쪽 영역과 남은 공간을 균등하게 */
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2열 그리드 */
            gap: 30px; /* 상품 카드 사이 간격 */
        }

        /* 개별 상품 카드 스타일 */
        .products-showcase .product-card {
            background-color: #fff;
            border: none;
            border-radius: 0;
            box-shadow: none;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: left; /* 카드 내부 텍스트는 좌측 정렬 */
        }
        .products-showcase .product-card:hover {
            transform: translateY(-5px); /* 호버 효과 */
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .products-showcase .product-card a {
            display: block; /* 링크 영역 확장 */
        }

        .products-showcase .product-image-container {
            width: 100%;
            height: 300px; /* 이미지 높이 고정 */
            overflow: hidden;
            position: relative;
        }
        .products-showcase .product-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 잘려도 컨테이너를 꽉 채움 */
            object-position: center;
            display: block;
        }

        .products-showcase .product-info-text {
            padding: 15px 0; /* 텍스트 정보의 내부 여백 */
            text-align: center;
        }
        .products-showcase .product-card h3 {
            font-size: 1.1em;
            font-weight: 600;
            margin-bottom: 5px;
            color: #222;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis; /* 한 줄 텍스트 넘칠 때 ... */
            text-align: center;
        }
        .products-showcase .product-card p.product-price {
            font-size: 1.05em;
            color: black;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
        }
        .products-showcase .no-products-message {
            grid-column: span 2; /* 2열 그리드 전체 차지 */
            text-align: center;
            color: #777;
            font-size: 1.1em;
            padding: 20px;
        }


        /* ====== 대회 영역 스타일 (SHOP BY SPORTS처럼) ====== */
        .rally-showcase {
            background-color: #fff; /* 섹션 배경색을 밝은 회색으로 변경 */
            /* section{ padding: 80px 0; } - 이전에 정의된 전역 섹션 패딩 유지 */
        }

        .rally-showcase .swiper-container {
            max-width: 1620px; /* 상품 영역과 동일하게 가로 폭 확장 */
            margin: 0 auto;
            padding: 0 60px; /* 네비게이션 버튼을 위한 좌우 여백 */
            box-sizing: border-box;
            position: relative; /* 네비게이션 버튼의 position 기준 */
            overflow: hidden; /* 컨테이너 밖으로 나가는 콘텐츠 숨김 */
        }

        /* 개별 슬라이드 (대회 카드) 스타일 */
        .rally-showcase .swiper-slide {
            background: #fff; /* 카드 배경 흰색 */
            border: none; /* 테두리 제거 */
            border-radius: 0; /* 둥근 테두리 제거 */
            box-shadow: none; /* 그림자 제거 */
            overflow: hidden;
            padding: 0; /* 내부 패딩 제거 */
            text-align: center; /* 내부 텍스트 중앙 정렬 */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* 호버 효과 */
        }
        .rally-showcase .swiper-slide:hover {
            transform: translateY(-5px); /* 호버 시 살짝 위로 뜨는 효과 */
            box-shadow: 0 5px 15px rgba(0,0,0,0.1); /* 호버 시 은은한 그림자 */
        }
        .rally-showcase .swiper-slide a {
            display: block; /* 링크 영역 확장 */
        }
        .rally-showcase .swiper-slide img {
            width: 100%;
            height: 700px; /* 이미지 높이 조절 (SHOP BY SPORTS와 유사하게) */

            object-position: center;
            display: block;
        }

        /* 대회 정보 텍스트 영역 */
        .rally-showcase .rally-info-text {
            padding: 20px 15px 30px 15px; /* 내부 텍스트 여백 */
            text-align: center; /* 중앙 정렬 */
        }
        .rally-showcase .rally-info-text h3 {
            font-size: 1.3em;
            font-weight: 700;
            margin-bottom: 10px;
            color: #222;
            white-space: nowrap; /* 넘치는 텍스트는 한 줄로 처리 */
            overflow: hidden;
            text-overflow: ellipsis; /* ...으로 표시 */
        }
        .rally-showcase .rally-info-text p {
            font-size: 0.95em;
            color: #555;
            font-weight: 400;
        }

        /* Swiper 네비게이션 버튼 스타일 (SHOP BY SPORTS 처럼 미니멀하게) */
        .rallySwiper .swiper-button-next,
        .rallySwiper .swiper-button-prev {
            color: #222; /* 검정색 화살표 */
            border-radius: 50%; /* 둥근 모양 */
            width: 45px;
            height: 45px;
            font-size: 0.9em; /* 화살표 아이콘 크기 */
            top: 50%;
            transform: translateY(-50%); /* 정확한 수직 중앙 정렬 */
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
            opacity: 0; /* 평소에는 숨김 */
            z-index: 10;
        }
        .rallySwiper:hover .swiper-button-next, /* 스와이퍼 컨테이너에 호버 시 버튼 표시 */
        .rallySwiper:hover .swiper-button-prev {
            opacity: 1; /* 호버 시 불투명하게 (보이게) */
        }
        .rallySwiper .swiper-button-next:hover,
        .rallySwiper .swiper-button-prev:hover {
            background-color: #333; /* 호버 시 ASICS 액센트 색상 */
            color: white;
            border-color: white;
        }
        .rallySwiper .swiper-button-prev { left: 10px; } /* 컨테이너 좌측 패딩 안쪽으로 */
        .rallySwiper .swiper-button-next { right: 10px; } /* 컨테이너 우측 패딩 안쪽으로 */

        
        /* ====== 크루 가입 영역 스타일 강화 ====== */

        .crew-join-section {
            padding: 0;
            background-color: #fff; /* 섹션 자체의 배경색 */
            margin-bottom: 70px;
        }

        .crew-join-section .crew-images-wrapper {
            width: 100%;
            max-width: 1520px;
            margin: 0 auto;
            position: relative;
            overflow: hidden;
            border-radius: 0;
            background-color: #fff; /* ★★★ 래퍼 자체에 흰색 배경을 줘서 뒤쪽이 비치지 않게 ★★★ */
        }

        .crew-join-section .crew-image-container {
            display: flex;
            width: 100%;
            height: 400px; /* 컨테이너 높이 */
            align-items: stretch;
            justify-content: center;
            gap: 0;
            margin: 0; /* ★★★ 마진 초기화 ★★★ */
            padding: 0; /* ★★★ 패딩 초기화 ★★★ */
            line-height: 0; /* ★★★ 컨테이너 자체의 line-height 초기화 ★★★ */
            font-size: 0; /* ★★★ Flex 아이템에 인라인 공백이 생기는 것을 방지 ★★★ */
            background-color: #fff; /* ★★★ 이미지 컨테이너 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
        }

        .crew-join-section .crew-image-item {
            flex: 1;
            position: relative;
            overflow: hidden;
            line-height: 0; /* ★★★ 인라인 요소로 인한 공백 제거 ★★★ */
            margin: 0; /* ★★★ 마진 초기화 ★★★ */
            padding: 0; /* ★★★ 패딩 초기화 ★★★ */
            display: block; /* ★★★ 플렉스 아이템도 block으로 명시 ★★★ */
            background-color: #fff; /* ★★★ 아이템 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
        }

        .crew-join-section .crew-image-item a {
            display: block;
            width: 100%;
            height: 100%;
            margin: 0; /* ★★★ 마진 초기화 ★★★ */
            padding: 0; /* ★★★ 패딩 초기화 ★★★ */
            line-height: 0; /* ★★★ 링크 내부의 line-height 초기화 ★★★ */
            font-size: 0; /* ★★★ 링크 내부 폰트 사이즈도 0으로 ★★★ */
            background-color: #fff; /* ★★★ 링크 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
        }

        .crew-join-section .crew-image-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block; /* ★★★ 이미지 하단 공백 제거 ★★★ */
            margin: 0; /* ★★★ 이미지 자체의 마진 초기화 ★★★ */
            padding: 0; /* ★★★ 이미지 자체의 패딩 초기화 ★★★ */
            border: none; /* ★★★ 혹시 모를 이미지 테두리 제거 ★★★ */
        }

        /* 오버레이 텍스트 스타일 (이전과 동일) */
        .crew-join-section .crew-overlay-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 4em;
            font-weight: 800;
            color: #fff;
            text-shadow: 2px 2px 6px rgba(0,0,0,0.7);
            letter-spacing: 0.1em;
            text-align: center;
            white-space: nowrap;
            z-index: 10;
        }


        /* --- Footer Section (화면 전체 너비) --- */
        footer { /* default 푸터 스타일 */
            width: 100%;
            height: 200px;
            background-color: black;
            color: white;
            align-items: center;
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            padding: 0 40px; /* default footer의 padding */
            box-shadow: 0 -2px 4px rgba(0,0,0,0.1);
            margin-top: auto; /* #app이 flex-direction: column일 때 푸터를 아래로 밀어냄 */
            box-sizing: border-box; /* 패딩이 width에 포함되도록 */
        }

        .footer-left {
            margin-left: 0; /* padding이 있으므로 margin-left 제거 */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .footer-left .company-info div {
            margin-bottom: 5px;
            white-space: nowrap;
        }
        .copyright {
            margin-top: 8px;
            font-size: 0.9em;
            color: #bbb;
            white-space: nowrap;
        }

        .footer-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
        }
        .other {
            margin-bottom: 10px;
            white-space: nowrap;
        }
        .other span {
            margin-left: 20px;
            cursor: pointer;
        }
        .other span:hover {
            text-decoration: underline;
        }
        .other span:first-child {
            margin-left: 0;
        }
        .socials span {
            margin-left: 20px;
            cursor: pointer;
        }
        .socials span:hover {
            text-decoration: underline;
        }
        .socials span:first-child {
            margin-left: 0;
        }


        /* --- Responsive Adjustments --- */
        @media (max-width: 1024px) {
            .swiper-side-cover {
                width: 60px; /* 너비를 줄여서 가리는 공간을 줄입니다 */
            }
            .swiper-side-cover.left {
                left: -60px;
            }
            .swiper-side-cover.right {
                right: -60px;
            }
        }
        @media (max-width: 768px) {
            header { /* 모바일에서 header의 padding도 조정 */
                padding: 0 10px;
            }
            .top-header {
                flex-direction: column;
                height: auto;
                padding: 15px 0; /* 좌우 padding은 header가 가짐 */
            }
            .brand-name {
                width: 100%;
                text-align: center;
                margin-bottom: 10px;
            }
            .brand-name div {
                font-size: 40px;
                margin-left: 0;
            }
            #right-items {
                flex-direction: column;
                gap: 10px;
                width: 100%;
                margin-top: 10px;
            }
            #right-items div {
                width: 100%;
                text-align: center;
            }
            .top-header input { /* input 너비 조정 */
                width: calc(100% - 20px);
            }
            .bottom-header {
                flex-wrap: wrap;
                font-size: 20px;
                padding: 10px 0;
            }
            .bottom-header div {
                margin: 10px 15px;
                width: calc(50% - 30px);
            }
            .bottom-header div:nth-child(2n) {
                margin-right: 0;
            }

            .container { /* 모바일에서 main content padding 조정 */
                padding: 0 10px;
            }
            main > section {
                padding: 0; /* container가 패딩을 주므로 섹션 자체 패딩 제거 */
            }

            .main-hero-slider {
                height: 250px;
            }
            .rally-showcase .swiper-container {
                padding: 0 20px;
            }
            .rallySwiper .swiper-button-next,
            .rallySwiper .swiper-button-prev {
                width: 30px;
                height: 30px;
                font-size: 0.6em;
            }

            footer {
                flex-direction: column;
                height: auto;
                padding: 20px 10px;
                text-align: center;
            }
            .footer-left, .footer-right {
                align-items: center;
                margin: 10px 0;
                width: 100%;
            }
            .footer-left .company-info div, .footer-left .copyright {
                white-space: normal;
            }
            .footer-right .other, .footer-right .socials {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 5px;
            }
            .other span, .socials span {
                margin: 5px 10px;
                display: inline-block;
            }
            .crew-join-section .crew-image-container {
                flex-direction: column; /* 세로로 쌓음 */
                height: auto; /* 세로 쌓일 때는 높이 자동 */
            }
            .crew-join-section .crew-image-item {
                height: 250px; /* 각 이미지의 높이 */
            }
            .crew-join-section .crew-overlay-text {
                font-size: 2.5em;
                white-space: normal;
                max-width: 90%;
                line-height: 1.2;
            }
            .crew-images-wrapper {
                flex-direction: column; /* 모바일에서는 이미지를 세로로 쌓음 */
            }
            .crew-image-container { /* 모바일에서는 이미지 컨테이너도 세로로 */
                flex-direction: column;
                gap: 15px; /* 이미지 간 간격 */
            }
            .crew-image-item img {
                height: 200px; /* 모바일에서 이미지 높이 조정 */
            }
            .crew-overlay-text {
                font-size: 1.8em; /* 모바일에서 텍스트 크기 조정 */
                padding: 5px 10px;
            }
            .main > section:not(.main-hero-slider),
            .main > .main-hero-slider-area {
                padding: 0 10px;
            }

            /* 커버 div도 너비에 맞춰 조정 (필요하다면) */
            .swiper-side-cover {
                width: 30px; /* 더 작게 줄여서 모바일 화면에서는 최소한만 가립니다 */
            }
            .swiper-side-cover.left {
                left: -30px;
            }
            .swiper-side-cover.right {
                right: -30px;
            }
        }
    </style>

</head>
<body>
    <div id="app">
        <header>
            <div class="top-header">
                <div class="brand-name">
                    <div><a href="/home.do" style="text-decoration: none;">RUNNERS' HOUSE</a></div>
                </div>
                <div id="right-items">
                    <div class="search-box">
                        <input type="text" placeholder="검색어를 입력해 주세요.">
                    </div>
                    <div>
                        <template v-if="sessionId != ''">
                            <a href="javascript:;" @click="fnLogout">로그아웃</a>
                        </template>
                        <template v-else>
                            <a href="/home/login.do">로그인</a>
                        </template>
                    </div>
                    <div v-if="sessionId == ''">
                        <a href="/home/signup.do">가입하기</a>
                    </div>
                    <div v-if="sessionId != '' && userType != 'K'"><a href="/home/mypage/information.do">마이페이지</a></div>
                    <div v-else-if="sessionId != '' && userType == 'K'"><a href="home/mypage/information/change.do">마이페이지</a></div>
                    <div v-if="sessionId != ''"><a href="/home/cart.do">장바구니</a></div>
                </div>
            </div>
            <div class="bottom-header">
                <div><a href="/home/product.do">제품</a></div>
                <div><a href="/home/product.do">세일</a></div>
                <div><a href="/home/community/board.do">커뮤니티</a></div>
            </div>
        </header>
        <div class="container">
            <main>
                <!-- 메인 슬라이드 배너 -->
                <div class="main-hero-slider-area">
                    <section class="main-hero-slider">
                        <div class="swiper-container mySwiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide" v-for="slide in mainSlideImages" :key="slide.BANNER_ID">
                                    <a :href="slide.LINK_URL" target="_blank">
                                        <img :src="slide.imageDir" :alt="slide.title">
                                    </a>
                                </div>
                            </div>
                            <div class="swiper-pagination"></div>
                        </div>
                    </section>
                </div>

                
                <!-- 추천 상품 영역 -->
                <section class="products-showcase">
                    <h2>추천 상품</h2>
                    <div class="products-main-content-wrapper"> <!-- ASICS 스타일을 위한 새로운 래퍼 추가 -->
                        
                        <!-- 왼쪽 고정 이미지 및 소개 영역 -->
                        <div class="fixed-image-area">
                            <img src="/img/productmain.jpg">
                            <div class="image-text-overlay">
                                <h3>GEL-CUMULUS 16</h3>
                                <p>혁신적인 쿠셔닝과 최적의 안정성을 자랑합니다. <br>매일의 러닝에 최적화된 편안함.</p>
                            </div>
                        </div>

                        <!-- 오른쪽에 상품 4개 그리드 -->
                        <div class="recommended-products-grid">
                            <div class="product-card" v-for="product in recommendedProducts" :key="product.productNo">
                                <a :href="'/home/product-info.do?productNo=' + product.productNo">
                                    <div class="product-image-container"> <!-- 이미지 컨테이너 추가 -->
                                        <img :src="product.imgPath" :alt="product.productName">
                                    </div>
                                    <div class="product-info-text"> <!-- 텍스트 정보 컨테이너 추가 -->
                                        <h3>{{ product.productName }}</h3>
                                        <p class="product-price">{{ formatCurrency(product.productPrice) }}</p>
                                    </div>
                                </a>
                            </div>
                            <p v-if="recommendedProducts.length === 0" class="no-products-message">추천 상품이 없습니다.</p>
                        </div>
                    </div>
                </section>
              
                <!-- 최신 대회 영역 -->
                <section class="rally-showcase">
                    <h2>대회 정보</h2>
                    <div class="swiper-container rallySwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="rally in latestRallies" :key="rally.rallyNo">
                                <a :href="'/home/community/rally.do'">
                                    <img :src="rally.imgPath" :alt="rally.rallyName">
                                    <div class="rally-info-text"> <!-- 텍스트 정보를 감싸는 div 추가 -->
                                        <h3>{{ rally.rallyName }}</h3>
                                        <h3>대회 일자 : {{ formatDate(rally.rallyDate) }}</h3>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <!-- Swiper 페이지네이션은 ASICS Shop By Sports에서 잘 보이지 않으므로 주석 처리된 상태로 둡니다. -->
                        <!-- <div class="swiper-pagination"></div> -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </section>

                <!-- 크루 가입 영역 -->
                <section class="crew-join-section">
                    <div class="crew-images-wrapper">
                        <div class="crew-image-container"> <!-- 이미지 두 개를 담는 컨테이너 -->
                            <div class="crew-image-item">
                                <a href="/home/community/crew.do"> <!-- 각 이미지가 자체 링크를 가짐 -->
                                    <img src="/img/crew_join_banner.jpg" alt="크루 가입 배너 1">
                                </a>
                            </div>
                            <div class="crew-image-item">
                                <a href="/home/community/crew.do"> <!-- 각 이미지가 자체 링크를 가짐 -->
                                    <img src="/img/crew_join_banner2.jpg" alt="크루 가입 배너 2">
                                </a>
                            </div>
                        </div>
                        <span class="crew-overlay-text">JOIN A CREW</span> <!-- 텍스트는 항상 보임, 중앙 위치 -->
                    </div>
                </section>
            </main>
        </div>
        <footer>
            <div class="footer-left">
                <div class="company-info">
                    <div><strong>회사명:</strong> 러너스 하우스 주식회사</div>
                    <div><strong>대표:</strong> 김재</div>
                    <div><strong>사업자등록번호:</strong> 123‑45‑67890</div>
                    <div><strong>통신판매업 신고번호:</strong> 2025‑서울‑00987</div>
                    <div><strong>부가세 번호:</strong> KR123456789</div>
                </div>
                <div class="copyright">
                    COPYRIGHT© 2025 RUNNERS HOUSE COMPANY. ALL RIGHT RESERVED.
                </div>
            </div>
            <div class="footer-right">
                <div class="other">
                    <span><a href="/home/about.do">회사소개</a></span>
                    <span><a @click="fnNotice">공지사항</a></span>
                    <span><a href="/home/terms.do">이용약관</a></span>
                    <span><a href="/home/privacy.do">개인정보처리방침</a></span>
                </div>
                <div class="socials">
                    <span>INSTAGRAM</span>
                    <span>NAVER</span>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>



<script>
    const app = Vue.createApp({
        data() {
            return {
                mainSlideImages: [],
                recommendedProducts: [],
                latestRallies: [],
                sessionId: '${sessionId}',
                isLoggedOut : false,
                userType : '${userType}'
            };
        },
        methods: {
            // (이전과 동일한 fetchMainSlideImages, fetchRecommendedProducts, fetchLatestRallies, initMainSwiper, initRallySwiper)
            fetchMainSlideImages() {
                let self = this;
                $.ajax({
                    url: '/api/mainSlideImages.dox',
                    method: 'GET',
                    dataType: 'json',
                    success: (response) => {
                        if (response.result === 'success') {
                            self.mainSlideImages = response.data;
                            self.$nextTick(() => { self.initMainSwiper(); });
                        } else { console.error("메인 슬라이드 이미지 로드 실패:", response.message); }
                    },
                    error: (error) => { console.error("메인 슬라이드 AJAX 오류:", error); }
                });
            },
            fetchRecommendedProducts() {
                let self = this;
                $.ajax({
                    url: '/api/recommendedProducts.dox',
                    method: 'GET',
                    dataType: 'json',
                    data: { limit: 4 },
                    success: (response) => {
                        console.log("Recommended Products Data (from backend):", response.data);
                        if (response.result === 'success') {
                            self.recommendedProducts = response.data.slice(0, 4);
                            console.log("Recommended Products Data (after slice, assigned to Vue):", self.recommendedProducts);
                        } else { console.error("추천 상품 로드 실패:", response.message); }
                    },
                    error: (error) => { console.error("추천 상품 AJAX 오류:", error); }
                });
            },
            fetchLatestRallies() {
                let self = this;
                $.ajax({
                    url: '/api/latestRallies.dox',
                    method: 'GET',
                    dataType: 'json',
                    data: { limit: 8 },
                    success: (response) => {
                        console.log("Latest Rallies Data:", response.data);
                        if (response.result === 'success') {
                            self.latestRallies = response.data;
                            this.$nextTick(() => {
                                self.initRallySwiper();
                            });
                        } else {
                            console.error("최신 대회 로드 실패:", response.message);
                        }
                    },
                    error: (error) => {
                        console.error("최신 대회 AJAX 오류:", error);
                    }
                });
            },
            initMainSwiper() {
                if (this.mainSlideImages.length > 0) {
                    if (this.mainSwiperInstance) {
                        this.mainSwiperInstance.destroy(true, true);
                    }

                    const swiperEl = document.querySelector('.mySwiper');
                    if (!swiperEl) {
                        console.error("Swiper container '.mySwiper' not found.");
                        return;
                    }

                    this.mainSwiperInstance = new Swiper(swiperEl, {
                        loop: true, // 무한 루프
                        autoplay: {
                            delay: 3000,
                            disableOnInteraction: false,
                        },
                        pagination: {
                            el: '.swiper-pagination',
                            clickable: true,
                        },
                        slidesPerView: 1,           // 한 번에 하나의 슬라이드 표시
                        spaceBetween: 0,
                        centeredSlides: false,
                        slidesPerGroup: 1,
                        watchOverflow: true,
                        observer: true,
                        observeParents: true,
                        preventInteractionOnTransition: true,
                        // on: {} /* 디버깅 로그는 필요 시에만 추가 */
                    });
                }
            },
            initRallySwiper() {
                if (this.latestRallies.length > 0) {
                    // ... (기존 로그 및 인스턴스 파괴 로직 유지) ...

                    const swiperEl = document.querySelector('.rallySwiper');
                    if (!swiperEl) {
                        console.error("Rally Swiper container '.rallySwiper' not found.");
                        return;
                    }

                    this.rallySwiperInstance = new Swiper(swiperEl, {
                        loop: true, // ASICS처럼 끊김 없는 슬라이딩을 위해 true로 변경
                                // 5개 데이터와 slidesPerView: 4 라면, 이제 loop 경고가 사라지거나 덜해질 것입니다.
                        autoplay: {
                            delay: 3000,
                            disableOnInteraction: false,
                        },
                        navigation: { // 네비게이션 활성화
                            nextEl: '.swiper-button-next',
                            prevEl: '.swiper-button-prev',
                        },
                        
                        // ★★★ 기본값 설정 (가장 큰 화면에서 3개 보임) ★★★
                        slidesPerView: 3,      
                        spaceBetween: 30,      // 슬라이드 간 간격
                        
                        centeredSlides: false,
                        slidesPerGroup: 1,
                        watchOverflow: true,
                        observer: true,
                        observeParents: true,
                        preventInteractionOnTransition: true,
                        
                        // ★★★ 반응형 설정 (최소 화면 너비 기준) ★★★
                        breakpoints: {
                            0: { // 가장 작은 화면 (모바일)
                                slidesPerView: 1,
                                spaceBetween: 15,
                            },
                            480: { // 스마트폰 가로
                                slidesPerView: 2,
                                spaceBetween: 20,
                            },
                            768: { // 태블릿
                                slidesPerView: 2, // 태블릿에서는 2개 유지 (3개는 너무 작아질 수 있음)
                                spaceBetween: 25,
                            },
                            1024: { // 데스크탑 (1024px 이상일 때 3개 보임)
                                slidesPerView: 3,
                                spaceBetween: 30, // 1024px 이상에서는 spaceBetween 30px 적용
                            }
                        }
                    });
                } else {
                    console.warn("Rally Swiper: No rally data available to initialize Swiper.");
                }
            },
            formatDate(dateString) { // 날짜 형식 포맷 함수
                if (!dateString) return '';
                const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                return new Date(dateString).toLocaleDateString('ko-KR', options);
            },
            formatCurrency(value) { // 통화 형식 포맷 함수
                if (value === null || value === undefined) return '0 원';
                return value.toLocaleString('ko-KR') + ' 원';
            },
            fnLogout : function(){
                let self = this;
                let param = {};
                $.ajax({
                    url: "/member/logout.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            location.href = "home.do";
                        }
                    }  
                });
            
            },
            initRallySwiper() {
                if (this.latestRallies.length > 0) {
                    console.log('Number of rally slides:', this.latestRallies.length);
                    new Swiper('.rallySwiper', {
                        slidesPerView: 1, spaceBetween: 10, loop: false, slidesPerGroup: 1,
                        navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev', },
                        breakpoints: { 640: { slidesPerView: 2, spaceBetween: 20, slidesPerGroup: 2, }, 1024: { slidesPerView: 3, spaceBetween: 30, slidesPerGroup: 3, }, },
                    });
                }
            },
                
           

            fnNotice(){
                let self = this;
                pageChange("/home/community/board.do", {type : "B"});
            },
            
            fnKakao: function(){
                let self = this;
                let param = {
                    code : self.code
                };
                $.ajax({
                    url: "/kakao.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if (data.properties && data.properties.nickname) {
                            self.sessionName = data.properties.nickname;
                        }

                        // ✅ Remove the ?code=... from the URL (no reload)
                        window.history.replaceState({}, document.title, '/home.do');
                        // ✅ Then reload the page so Vue picks up the session
                        location.reload();
                    }
                });
            },
            fnNotice(){
                let self = this;
                pageChange("/home/community/board.do", {type : "B"});
            }
        },
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            const queryParams = new URLSearchParams(window.location.search);
            self.code = queryParams.get('code') || '';
            if(self.code != ""){
                self.fnKakao();
            }
            this.fetchMainSlideImages();
            this.fetchRecommendedProducts();
            this.fetchLatestRallies();
        }
    });

    app.mount('#app');
</script>