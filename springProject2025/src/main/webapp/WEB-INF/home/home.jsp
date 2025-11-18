<%-- src/main/webapp/WEB-INF/home/home.jsp --%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>RUNNERS HOUSE</title>
            <!-- jQuery, Vue.js, Font Awesome (아이콘용) -->
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
            <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

            <!-- Swiper.js CDN -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
            <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

            <!-- 사용자 정의 스타일시트 -->
            <link rel="stylesheet" href="/css/style.css">

            <!-- Google Fonts (Fugaz One) -->
            <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">

             <!-- Google Fonts (Jost)  -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

            <!-- Icons -->
            <script src="https://unpkg.com/lucide@latest"></script>

            <!-- ApexCharts for budget recommendation chart -->
            <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.44.0/dist/apexcharts.min.js"></script>

            <script src="/js/page-change.js"></script>

            <style>
                /* style.css */

                /* --- 기본 레이아웃 설정 --- */
                html,
                body {
                    height: 100%;
                    margin: 0;
                    padding: 0;
                    font-family: Arial, sans-serif;
                    color: #333;
                    line-height: 1.6;
                }

                #app {
                    /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
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
                header {
                    /* default 헤더 스타일이 header 태그에 직접 적용되도록 재구성 */
                    width: 100%;
                    background-color: black;
                    /* default top-header의 배경색을 header 전체로 */
                    color: white;
                    /* default top-header의 글자색을 header 전체로 */
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }

                .top-header {
                    /* default top-header가 header의 유일한 자식이 됨 */
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    height: 150px;
                    /* default top-header의 높이 */
                    padding: 0 40px;
                    /* default footer padding과 맞춤 */
                    box-sizing: border-box;
                    /* 패딩이 width에 포함되도록 */
                }

                .top-header div {
                    display: inline-block;
                    text-align: left;
                    font-size: 15px;
                    margin-right: 0;
                    /* flex gap 사용을 위해 개별 div 마진 제거 */
                }

                .top-header input {
                    height: 25px;
                    border-radius: 8px;
                    width: 200px;
                }

                .brand-name {
                    /* top-header 내 brand-name */
                    margin-right: 0;
                    /* top-header div의 default margin-right 상쇄 */
                }

                .brand-name div {
                    font-family: 'Jost', sans-serif;
                    font-size: 60px;
                    font-weight: 900;
                    letter-spacing: 3px;
                    margin-left: 0;
                    /* top-header div의 default margin-left 상쇄 */
                    display: block;
                    color: white;
                    /* default 유지 */
                }

                .brand-name a {
                    color: white;
                }

                #right-items {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                    /* 요소들 간 간격 */
                }

                #right-items div {
                    font-size: 15px;
                    white-space: nowrap;
                }

                #right-items div a {
                    /* color: white; */
                    color: #eee;
                    /* default top-header의 글자색 */
                }

                #right-items div a:hover {
                    /* color: #eee; */
                    color: white;
                }

                /* bottom-header 수정 부분 */

                .bottom-header {
                    display: flex;
                    justify-content: center;
                    font-size: 25px;
                    /* default bottom-header 폰트 사이즈 */
                    background-color: white;
                    /* bottom-header 배경색 추가 */
                    border-bottom: 1px solid #eee;
                    /* 하단 경계선 */
                    padding: 20px 0;
                    /* 세로 패딩 */
                    letter-spacing: 3px;
                }

                .bottom-header-sub{
                    display: flex;
                    flex-direction: column; /* ← makes items go top-to-bottom */
                    justify-content: center; /* centers vertically inside container */
                    align-items: center;
                    width:600px;
                    height: 60px;
                    border-radius: 10px;
                    box-sizing: border-box;
                    line-height: 60px;
                    transition: background-color 0.3s ease-in-out, transform 0.3s ease-in-out;

                }
                /* .bottom-header-sub:hover{
                    background-color: #f1f1f1;
                    /* transition: 0.3s; */
                    /* opacity: 0.5; 0 = fully transparent, 1 = fully opaque */
                
                
                .bottom-header a:hover {
                    transform: scale(1.1);
                    transition: transform 0.3s ease-out; /* faster ease-out */
                }

                .bottom-header a {
                    color: black;
                    transition: transform 0.2s ease-in; /* slower ease-in */
                    display: inline-block;
                }

                .bottom-header div {
                    display: inline-block;
                    margin-right: 100px;
                    /* default bottom-header div의 마진 */
                    margin-top: 0;
                    /* flex-align으로 중앙 정렬 */
                    text-align: center;
                }

                /* bottom-header 수정 부분 */

                .bottom-header div:last-child {
                    margin-right: 0;
                }

                .bottom-header a {
                    color: black;
                    /* default bottom-header 링크색 */
                }

                /* .bottom-header a:hover {
                    color: #007bff;
                } */


                /* --- Main Content Section (콘텐츠 너비 제한) --- */
                .container {
                    /* 전체를 감싸는 컨테이너 */
                    /* max-width는 모든 페이지 콘텐츠가 중앙 정렬될 때 사용. 메인 배너는 뚫고 나옴 */
                    /* 현재로서는 모든 콘텐츠를 포함하는 div가 어떤 역할을 하는지 알기 어려워 이 컨테이너는
            다른 곳에서 max-width가 적용되어 있을 수 있으므로 여기서는 초기화만. */
                    width: 100%;
                    margin: 0 auto;
                    position: relative;
                    /* 자식 요소 포지셔닝 기준 */
                }

                main {
                    width: 100%;
                    margin: 0 auto;
                    position: relative;
                    /* max-width: 1440px; /* 이전에 제안했던 최대 너비 */
                }

                /* 각 섹션별 내부 패딩은 섹션 자체에서 관리하도록 조정 */
                main>section {
                    /* main 바로 아래 섹션에만 적용 */
                    padding: 80px 0;
                    /* 각 섹션 상하 여백 */
                    position: relative;
                    overflow: hidden;
                    /* 섹션 내 오버플로우 방지 */
                }

                main>section h2 {
                    font-size: 2.8em;
                    /* 섹션 제목 크게 */
                    font-weight: 700;
                    text-align: center;
                    margin-bottom: 60px;
                    /* 제목 아래 큰 여백 */
                    letter-spacing: -0.02em;
                    /* ASICS는 약간 좁은 자간을 쓰는 경향 */
                }

                /* Main Hero Slider styles (메인 상단 배너) */
                .main-hero-slider-area {
                    /* 이 영역이 브라우저 너비 전체를 차지하도록 */
                    width: 100vw;
                    /* 뷰포트 너비 전체 */
                    position: relative;
                    left: 50%;
                    right: 50%;
                    margin-left: -50vw;
                    /* 왼쪽으로 50vw 밀고 */
                    margin-right: -50vw;
                    /* 오른쪽으로 50vw 밀어서 풀 너비 확장 */
                    overflow: hidden;
                    /* 영역 밖으로 나가는 콘텐츠 숨김 */
                    background-color: #f8f8f8;
                    /* 로드 전/후 배경색 */
                    height: 650px;
                    /* 이미지 높이를 지정 */
                }

                .main-hero-slider {
                    /* 이 section은 풀 브라우저 너비를 차지하도록 만듭니다. */
                    width: 100%;
                    height: 100%;
                    /* 부모와 동일한 높이 */
                    padding: 0;
                    /* 상하 패딩 제거 */
                    position: relative;
                }

                .main-hero-slider .swiper-container {
                    width: 100%;
                    /* 부모 section의 너비를 꽉 채움 */
                    height: 100%;
                    /* 부모 section의 높이를 꽉 채움 */
                    margin: 0;
                    /* Swiper 기본 마진 제거 */
                }

                .main-hero-slider .swiper-slide {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    position: relative;
                    /* 텍스트 오버레이를 위한 기준점 */
                }

                .main-hero-slider .swiper-slide a {
                    display: block;
                    /* 링크 전체 클릭 가능 */
                    width: 100%;
                    height: 100%;
                }

                .main-hero-slider .swiper-slide img {
                    width: 100%;
                    /* 슬라이드 너비를 꽉 채움 */
                    height: 100%;
                    /* 슬라이드 높이를 꽉 채움 */
                    object-fit: cover;
                    /* 이미지가 잘려도 비율 유지하며 채움 */
                    object-position: center;
                    /* 이미지의 중앙이 보이도록 */
                    display: block;
                }

                /* Swiper 페이지네이션 (하단 점 스타일) */
                .main-hero-slider .swiper-pagination {
                    bottom: 30px !important;
                    /* 이미지 위에 오도록 위치 조정 */
                    z-index: 10;
                    /* 이미지 위에 표시되도록 z-index 부여 */
                }

                .main-hero-slider .swiper-pagination-bullet {
                    background-color: #fff;
                    /* 흰색 점 */
                    opacity: 0.7;
                    margin: 0 8px !important;
                    width: 12px;
                    /* 점 크기 조절 */
                    height: 12px;
                    transition: opacity 0.3s ease, background-color 0.3s ease;
                }

                .main-hero-slider .swiper-pagination-bullet-active {
                    background-color: #007bff;
                    /* 활성 점은 ASICS스러운 블루 계열 */
                    opacity: 1;
                }

                /* ★★★ 양쪽 사이드를 가릴 div 처리 ★★★ */
                /* 메인 슬라이더를 풀 너비로 확장했으므로, 이 div들은 이제 필요 없을 가능성이 높습니다. */
                /* 만약 이 div들이 특정 배경색으로 사이드를 채우는 역할을 한다면 다음과 같이 처리할 수 있습니다. */
                /* 하지만 메인 배너 이미지가 풀 너비라면 이 div들은 보이지 않습니다. */
                .main-hero-slider-area .swiper-side-cover {
                    display: none;
                    /* 현재는 풀 너비 배너이므로 숨김 */
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
                    left: 10%;
                    /* 좌측 여백 */
                    transform: translateY(-50%);
                    color: #fff;
                    text-align: left;
                    max-width: 500px;
                    /* 텍스트가 너무 길어지지 않도록 */
                    z-index: 5;
                    /* 이미지 위에 텍스트가 보이도록 */
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
                    /* 어두운 이미지에서 가독성 확보 */
                }

                .banner-text-overlay .banner-subtitle {
                    font-size: 1.1em;
                    font-weight: 300;
                    margin-bottom: 10px;
                    letter-spacing: 0.1em;
                }

                .banner-text-overlay .banner-title {
                    font-size: 3.2em;
                    /* 메인 제목 크기 */
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
                    background-color: #007bff;
                    /* ASICS스러운 블루 */
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
                    background-color: #fff;
                    /* 섹션 배경색 */
                }

                .products-showcase .products-main-content-wrapper {
                    display: flex;
                    /* Flexbox로 왼쪽/오른쪽 영역 배치 */
                    gap: 40px;
                    /* 두 영역 사이의 간격 */
                    max-width: 1520px;
                    /* 메인 컨테이너 너비에 맞춤 */
                    margin: 0 auto;
                    /* 중앙 정렬 */
                    padding: 0 40px;
                    /* 좌우 여백 */
                    align-items: stretch;
                    /* 자식 요소들의 높이를 동일하게 */
                }

                /* 왼쪽 고정 이미지 영역 */
                .products-showcase .fixed-image-area {
                    flex: 1.2;
                    /* 왼쪽 영역이 오른쪽 영역보다 약간 더 넓게 */
                    position: relative;
                    overflow: hidden;
                    border-radius: 0;
                    box-shadow: none;
                }

                .products-showcase .fixed-image-area img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    /* 이미지가 잘려도 컨테이너를 꽉 채움 */
                    display: block;
                }

                .products-showcase .image-text-overlay {
                    position: absolute;
                    bottom: 30px;
                    /* 하단에서부터 위치 */

                    right: 30px;
                    color: #fff;
                    text-align: left;
                    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
                    z-index: 2;
                    /* 이미지 위에 오도록 */
                }

                .products-showcase .image-text-overlay h3 {
                    font-size: 2.2em;
                    font-weight: 700;
                    margin-bottom: 10px;
                    line-height: 1.2;
                    color: #fff;
                    /* 텍스트 흰색 */
                }

                .products-showcase .image-text-overlay p {
                    font-size: 1.1em;
                    font-weight: 400;
                    margin-bottom: 25px;
                }

                .products-showcase .image-text-overlay .cta-button {
                    display: inline-block;
                    background-color: #007bff;
                    /* ASICS 블루 계열 */
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
                    flex: 1;
                    /* 오른쪽 영역이 왼쪽 영역과 남은 공간을 균등하게 */
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    /* 2열 그리드 */
                    gap: 30px;
                    /* 상품 카드 사이 간격 */
                }

                /* 개별 상품 카드 스타일 */
                .products-showcase .product-card {
                    background-color: #fff;
                    border: none;
                    border-radius: 0;
                    box-shadow: none;
                    overflow: hidden;
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                    text-align: left;
                    /* 카드 내부 텍스트는 좌측 정렬 */
                }

                .products-showcase .product-card:hover {
                    transform: translateY(-5px);
                    /* 호버 효과 */
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                }

                .products-showcase .product-card a {
                    display: block;
                    /* 링크 영역 확장 */
                }

                .products-showcase .product-image-container {
                    width: 100%;
                    height: 300px;
                    /* 이미지 높이 고정 */
                    overflow: hidden;
                    position: relative;
                }

                .products-showcase .product-image-container img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    /* 이미지가 잘려도 컨테이너를 꽉 채움 */
                    object-position: center;
                    display: block;
                }

                .products-showcase .product-info-text {
                    padding: 15px 0;
                    /* 텍스트 정보의 내부 여백 */
                    text-align: center;
                }

                .products-showcase .product-card h3 {
                    font-size: 1.1em;
                    font-weight: 600;
                    margin-bottom: 5px;
                    color: #222;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    /* 한 줄 텍스트 넘칠 때 ... */
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
                    grid-column: span 2;
                    /* 2열 그리드 전체 차지 */
                    text-align: center;
                    color: #777;
                    font-size: 1.1em;
                    padding: 20px;
                }


                /* ====== 대회 영역 스타일 (SHOP BY SPORTS처럼) ====== */
                .rally-showcase {
                    background-color: #fff;
                    /* 섹션 배경색을 밝은 회색으로 변경 */
                    /* section{ padding: 80px 0; } - 이전에 정의된 전역 섹션 패딩 유지 */
                }

                .rally-showcase .swiper-container {
                    max-width: 1620px;
                    /* 상품 영역과 동일하게 가로 폭 확장 */
                    margin: 0 auto;
                    padding: 0 60px;
                    /* 네비게이션 버튼을 위한 좌우 여백 */
                    box-sizing: border-box;
                    position: relative;
                    /* 네비게이션 버튼의 position 기준 */
                    overflow: hidden;
                    /* 컨테이너 밖으로 나가는 콘텐츠 숨김 */
                }

                /* 개별 슬라이드 (대회 카드) 스타일 */
                .rally-showcase .swiper-slide {
                    background: #fff;
                    /* 카드 배경 흰색 */
                    border: none;
                    /* 테두리 제거 */
                    border-radius: 0;
                    /* 둥근 테두리 제거 */
                    box-shadow: none;
                    /* 그림자 제거 */
                    overflow: hidden;
                    padding: 0;
                    /* 내부 패딩 제거 */
                    text-align: center;
                    /* 내부 텍스트 중앙 정렬 */
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                    /* 호버 효과 */
                }

                .rally-showcase .swiper-slide:hover {
                    transform: translateY(-5px);
                    /* 호버 시 살짝 위로 뜨는 효과 */
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    /* 호버 시 은은한 그림자 */
                }

                .rally-showcase .swiper-slide a {
                    display: block;
                    /* 링크 영역 확장 */
                }

                .rally-showcase .swiper-slide img {
                    width: 100%;
                    height: 700px;
                    /* 이미지 높이 조절 (SHOP BY SPORTS와 유사하게) */

                    object-position: center;
                    display: block;
                }

                /* 대회 정보 텍스트 영역 */
                .rally-showcase .rally-info-text {
                    padding: 20px 15px 30px 15px;
                    /* 내부 텍스트 여백 */
                    text-align: center;
                    /* 중앙 정렬 */
                }

                .rally-showcase .rally-info-text h3 {
                    font-size: 1.3em;
                    font-weight: 700;
                    margin-bottom: 10px;
                    color: #222;
                    white-space: nowrap;
                    /* 넘치는 텍스트는 한 줄로 처리 */
                    overflow: hidden;
                    text-overflow: ellipsis;
                    /* ...으로 표시 */
                }

                .rally-showcase .rally-info-text p {
                    font-size: 0.95em;
                    color: #555;
                    font-weight: 400;
                }

                /* Swiper 네비게이션 버튼 스타일 (SHOP BY SPORTS 처럼 미니멀하게) */
                .rallySwiper .swiper-button-next,
                .rallySwiper .swiper-button-prev {
                    color: #222;
                    /* 검정색 화살표 */
                    border-radius: 50%;
                    /* 둥근 모양 */
                    width: 45px;
                    height: 45px;
                    font-size: 0.9em;
                    /* 화살표 아이콘 크기 */
                    top: 50%;
                    transform: translateY(-50%);
                    /* 정확한 수직 중앙 정렬 */
                    transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
                    opacity: 0;
                    /* 평소에는 숨김 */
                    z-index: 10;
                }

                .rallySwiper:hover .swiper-button-next,
                /* 스와이퍼 컨테이너에 호버 시 버튼 표시 */
                .rallySwiper:hover .swiper-button-prev {
                    opacity: 1;
                    /* 호버 시 불투명하게 (보이게) */
                }

                .rallySwiper .swiper-button-next:hover,
                .rallySwiper .swiper-button-prev:hover {
                    background-color: #333;
                    /* 호버 시 ASICS 액센트 색상 */
                    color: white;
                    border-color: white;
                }

                .rallySwiper .swiper-button-prev {
                    left: 10px;
                }

                /* 컨테이너 좌측 패딩 안쪽으로 */
                .rallySwiper .swiper-button-next {
                    right: 10px;
                }

                /* 컨테이너 우측 패딩 안쪽으로 */


                /* ====== 크루 가입 영역 스타일 강화 ====== */

                .crew-join-section {
                    padding: 0;
                    background-color: #fff;
                    /* 섹션 자체의 배경색 */
                    margin-bottom: 70px;
                }

                .crew-join-section .crew-images-wrapper {
                    /* width: 100%; */
                    width: 100vw;
                    /* max-width: 1520px; */
                    margin: 0 auto;
                    position: relative;
                    overflow: hidden;
                    border-radius: 0;
                    background-color: #fff;
                    /* ★★★ 래퍼 자체에 흰색 배경을 줘서 뒤쪽이 비치지 않게 ★★★ */
                }

                .crew-join-section .crew-image-container {
                    display: flex;
                    /* width: 100%; */
                    width: 100vw;
                    height: 400px;
                    /* 컨테이너 높이 */
                    align-items: stretch;
                    justify-content: center;
                    gap: 0;
                    margin: 0;
                    /* ★★★ 마진 초기화 ★★★ */
                    padding: 0;
                    /* ★★★ 패딩 초기화 ★★★ */
                    line-height: 0;
                    /* ★★★ 컨테이너 자체의 line-height 초기화 ★★★ */
                    font-size: 0;
                    /* ★★★ Flex 아이템에 인라인 공백이 생기는 것을 방지 ★★★ */
                    background-color: #fff;
                    /* ★★★ 이미지 컨테이너 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
                }

                .crew-join-section .crew-image-item {
                    flex: 1;
                    position: relative;
                    overflow: hidden;
                    line-height: 0;
                    /* ★★★ 인라인 요소로 인한 공백 제거 ★★★ */
                    margin: 0;
                    /* ★★★ 마진 초기화 ★★★ */
                    padding: 0;
                    /* ★★★ 패딩 초기화 ★★★ */
                    display: block;
                    /* ★★★ 플렉스 아이템도 block으로 명시 ★★★ */
                    background-color: #fff;
                    /* ★★★ 아이템 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
                }

                .crew-join-section .crew-image-item a {
                    display: block;
                    width: 100%;
                    height: 100%;
                    margin: 0;
                    /* ★★★ 마진 초기화 ★★★ */
                    padding: 0;
                    /* ★★★ 패딩 초기화 ★★★ */
                    line-height: 0;
                    /* ★★★ 링크 내부의 line-height 초기화 ★★★ */
                    font-size: 0;
                    /* ★★★ 링크 내부 폰트 사이즈도 0으로 ★★★ */
                    background-color: #fff;
                    /* ★★★ 링크 자체에 흰색 배경을 줘서 비치지 않게 ★★★ */
                }

                .crew-join-section .crew-image-item img {
                    /* width: 100%; */
                    width: 100vw;
                    height: 100%;
                    object-fit: cover;
                    object-position: center;
                    display: block;
                    /* ★★★ 이미지 하단 공백 제거 ★★★ */
                    margin: 0;
                    /* ★★★ 이미지 자체의 마진 초기화 ★★★ */
                    padding: 0;
                    /* ★★★ 이미지 자체의 패딩 초기화 ★★★ */
                    border: none;
                    /* ★★★ 혹시 모를 이미지 테두리 제거 ★★★ */
                }

                /* 오버레이 텍스트 스타일 (이전과 동일) */
                .crew-join-section .crew-overlay-text {
                    width: 100%;
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    font-size: 4em;
                    font-weight: 800;
                    color: #fff;
                    text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
                    letter-spacing: 0.1em;
                    text-align: center;
                    white-space: nowrap;
                    z-index: 10;
                }


                /* --- Footer Section (화면 전체 너비) --- */
                footer {
                    /* default 푸터 스타일 */
                    width: 100%;
                    height: 200px;
                    background-color: black;
                    color: white;
                    align-items: center;
                    display: flex;
                    justify-content: space-between;
                    font-size: 12px;
                    padding: 0 40px;
                    /* default footer의 padding */
                    box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
                    margin-top: auto;
                    /* #app이 flex-direction: column일 때 푸터를 아래로 밀어냄 */
                    box-sizing: border-box;
                    /* 패딩이 width에 포함되도록 */
                }

                .footer-left {
                    margin-left: 0;
                    /* padding이 있으므로 margin-left 제거 */
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
                        width: 60px;
                        /* 너비를 줄여서 가리는 공간을 줄입니다 */
                    }

                    .swiper-side-cover.left {
                        left: -60px;
                    }

                    .swiper-side-cover.right {
                        right: -60px;
                    }
                }

                @media (max-width: 768px) {
                    header {
                        /* 모바일에서 header의 padding도 조정 */
                        padding: 0 10px;
                    }

                    .top-header {
                        flex-direction: column;
                        height: auto;
                        padding: 15px 0;
                        /* 좌우 padding은 header가 가짐 */
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

                    .top-header input {
                        /* input 너비 조정 */
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

                    .container {
                        /* 모바일에서 main content padding 조정 */
                        padding: 0 10px;
                    }

                    main>section {
                        padding: 0;
                        /* container가 패딩을 주므로 섹션 자체 패딩 제거 */
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

                    .footer-left,
                    .footer-right {
                        align-items: center;
                        margin: 10px 0;
                        width: 100%;
                    }

                    .footer-left .company-info div,
                    .footer-left .copyright {
                        white-space: normal;
                    }

                    .footer-right .other,
                    .footer-right .socials {
                        display: flex;
                        flex-wrap: wrap;
                        justify-content: center;
                        margin-bottom: 5px;
                    }

                    .other span,
                    .socials span {
                        margin: 5px 10px;
                        display: inline-block;
                    }

                    .crew-join-section .crew-image-container {
                        flex-direction: column;
                        /* 세로로 쌓음 */
                        height: auto;
                        /* 세로 쌓일 때는 높이 자동 */
                    }

                    .crew-join-section .crew-image-item {
                        height: 250px;
                        /* 각 이미지의 높이 */
                    }

                    .crew-join-section .crew-overlay-text {
                        font-size: 2.5em;
                        white-space: normal;
                        max-width: 90%;
                        line-height: 1.2;
                    }

                    .crew-images-wrapper {
                        flex-direction: column;
                        /* 모바일에서는 이미지를 세로로 쌓음 */
                    }

                    .crew-image-container {
                        /* 모바일에서는 이미지 컨테이너도 세로로 */
                        flex-direction: column;
                        gap: 15px;
                        /* 이미지 간 간격 */
                    }

                    .crew-image-item img {
                        height: 200px;
                        /* 모바일에서 이미지 높이 조정 */
                    }

                    .crew-overlay-text {
                        font-size: 1.8em;
                        /* 모바일에서 텍스트 크기 조정 */
                        padding: 5px 10px;
                    }

                    .main>section:not(.main-hero-slider),
                    .main>.main-hero-slider-area {
                        padding: 0 10px;
                    }

                    /* 커버 div도 너비에 맞춰 조정 (필요하다면) */
                    .swiper-side-cover {
                        width: 30px;
                        /* 더 작게 줄여서 모바일 화면에서는 최소한만 가립니다 */
                    }

                    .swiper-side-cover.left {
                        left: -30px;
                    }

                    .swiper-side-cover.right {
                        right: -30px;
                    }
                }

                /* ====== 예산 추천 버튼 및 모달 ====== */
                .budget-recommend-btn {
                    position: fixed;
                    bottom: 30px;
                    left: 30px;
                    width: 70px;
                    height: 70px;
                    background-color: #007bff;
                    color: white;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.4);
                    z-index: 1000;
                    transition: all 0.3s ease;
                    font-size: 24px;
                    border: none;
                }

                .budget-recommend-btn:hover {
                    background-color: #0056b3;
                    transform: scale(1.1);
                    box-shadow: 0 6px 16px rgba(0, 123, 255, 0.6);
                }

                .budget-modal {
                    position: fixed;
                    z-index: 2000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                    overflow: auto;
                }

                .budget-modal-content {
                    background-color: #fefefe;
                    margin: 5% auto;
                    padding: 30px;
                    border: none;
                    border-radius: 15px;
                    width: 90%;
                    max-width: 1000px;
                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                    position: relative;
                }

                .budget-modal-close {
                    color: #aaa;
                    float: right;
                    font-size: 28px;
                    font-weight: bold;
                    cursor: pointer;
                    position: absolute;
                    right: 20px;
                    top: 15px;
                }

                .budget-modal-close:hover,
                .budget-modal-close:focus {
                    color: #000;
                }

                .budget-input-section {
                    margin-bottom: 30px;
                    text-align: center;
                }

                .budget-input-section h2 {
                    margin-bottom: 20px;
                    color: #333;
                }

                .budget-input-wrapper {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 15px;
                    margin-bottom: 20px;
                }

                .budget-input-wrapper input {
                    padding: 12px 20px;
                    font-size: 18px;
                    border: 2px solid #ddd;
                    border-radius: 8px;
                    width: 200px;
                }

                .budget-input-wrapper button {
                    padding: 12px 30px;
                    font-size: 16px;
                    background-color: #007bff;
                    color: white;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }

                .budget-input-wrapper button:hover {
                    background-color: #0056b3;
                }

                .budget-chart-section {
                    display: flex;
                    gap: 40px;
                    margin-top: 30px;
                    align-items: flex-start;
                }

                .budget-chart-container {
                    flex: 1;
                    max-width: 450px;
                    min-height: 400px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                #budgetChart {
                    width: 100% !important;
                    min-height: 400px;
                }

                .budget-category-bars {
                    flex: 1;
                }

                .budget-category-bar {
                    margin-bottom: 25px;
                    padding: 15px;
                    background-color: #f8f9fa;
                    border-radius: 8px;
                    border-left: 4px solid #007bff;
                }

                .budget-category-bar h4 {
                    margin: 0 0 10px 0;
                    color: #333;
                    font-size: 16px;
                }

                .budget-bar-progress {
                    height: 40px;
                    background-color: #e9ecef;
                    border-radius: 20px;
                    overflow: visible;
                    position: relative;
                    cursor: pointer;
                    margin: 10px 0;
                }

                .budget-bar-fill {
                    height: 100%;
                    border-radius: 20px;
                    transition: width 0.3s ease;
                    display: flex;
                    align-items: center;
                    justify-content: flex-end;
                    padding-right: 10px;
                    color: white;
                    font-weight: bold;
                    font-size: 14px;
                    position: relative;
                    min-width: 50px;
                }

                .budget-bar-fill.category-0 {
                    background: linear-gradient(90deg, #008FFB, #0066CC);
                }

                .budget-bar-fill.category-1 {
                    background: linear-gradient(90deg, #00E396, #00B87A);
                }

                .budget-bar-fill.category-2 {
                    background: linear-gradient(90deg, #FEB019, #CC8E14);
                }

                .budget-bar-fill.category-3 {
                    background: linear-gradient(90deg, #FF4560, #CC364D);
                }

                .budget-bar-handle {
                    position: absolute;
                    right: -10px;
                    top: 50%;
                    transform: translateY(-50%);
                    width: 20px;
                    height: 20px;
                    background-color: #fff;
                    border: 3px solid #007bff;
                    border-radius: 50%;
                    cursor: grab;
                    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
                    z-index: 10;
                }

                .budget-bar-handle:active {
                    cursor: grabbing;
                }

                .budget-bar-info {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 5px;
                }

                .budget-bar-label {
                    font-weight: 600;
                    color: #333;
                }

                .budget-bar-value {
                    font-weight: bold;
                    color: #007bff;
                }

                .budget-recommend-btn-update {
                    margin-top: 20px;
                    padding: 10px 20px;
                    background-color: #28a745;
                    color: white;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 14px;
                    font-weight: 600;
                    transition: background-color 0.3s;
                }

                .budget-recommend-btn-update:hover {
                    background-color: #218838;
                }

                .budget-recommended-products {
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 2px solid #eee;
                }

                .budget-recommended-products h4 {
                    margin-bottom: 15px;
                    color: #333;
                }

                .budget-product-item {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    padding: 10px;
                    margin-bottom: 10px;
                    background-color: #fff;
                    border-radius: 8px;
                    border: 1px solid #ddd;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .budget-product-item:hover {
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                    transform: translateX(5px);
                }

                .budget-product-item img {
                    width: 60px;
                    height: 60px;
                    object-fit: cover;
                    border-radius: 5px;
                }

                .budget-product-info {
                    flex: 1;
                }

                .budget-product-info .product-name {
                    font-weight: bold;
                    margin-bottom: 5px;
                }

                .budget-product-info .product-price {
                    color: #007bff;
                    font-weight: bold;
                }

                .budget-no-products {
                    color: #999;
                    font-style: italic;
                    padding: 10px;
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
                            <div>
                                <!-- <template > -->
                                    <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i data-lucide="log-out" stroke-width="1.5"></i></a></div>
                                <!-- </template> -->
                                <!-- <template > -->
                                    <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a></div>
                                <!-- </template> -->
                            </div>
                            <div v-if="sessionId == ''">
                                <a href="/home/signup.do"><i data-lucide="user-plus" stroke-width="1.5"></i></a>
                            </div>
                            <div v-if="sessionId != '' && userType != 'K'"><a
                                    href="/home/mypage/information.do"><i data-lucide="user" stroke-width="1.5"></i></a></div>
                            <div v-else-if="sessionId != '' && userType == 'K'"><a
                                    href="home/mypage/information/change.do"><i data-lucide="user" stroke-width="1.5"></i></a></div>
                            <div v-if="sessionId != ''"><a href="/home/cart.do"><i data-lucide="shopping-cart" stroke-width="1.5"></i></a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <!-- <div class="bottom-header-sub"> -->
                            <div><a href="/home/product.do">제품</a></div>
                            <div><a href="javascript:;" @click="fnSale">세일</a></div>
                            <div><a href="/home/community/board.do">커뮤니티</a></div>
                        <!-- </div> -->
                    </div>
                </header>
                <div class="container">
                    <main>
                        <!-- 메인 슬라이드 배너 -->
                        <div class="main-hero-slider-area">
                            <section class="main-hero-slider">
                                <div class="swiper-container mySwiper">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" v-for="slide in mainSlideImages"
                                            :key="slide.BANNER_ID">
                                            <a :href="slide.linkUrl">
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
                                    <a href="/home/product-info.do?productNo=282">
                                        <img src="/img/productmain.jpg">
                                        <div class="image-text-overlay">
                                            <h3>GEL-CUMULUS 16</h3>
                                            <p>혁신적인 쿠셔닝과 최적의 안정성을 자랑합니다. <br>매일의 러닝에 최적화된 편안함.</p>
                                        </div>
                                    </a>
                                </div>

                                <!-- 오른쪽에 상품 4개 그리드 -->
                                <div class="recommended-products-grid">
                                    <div class="product-card" v-for="product in recommendedProducts"
                                        :key="product.productNo">
                                        <a :href="'/home/product-info.do?productNo=' + product.productNo">
                                            <div class="product-image-container"> <!-- 이미지 컨테이너 추가 -->
                                                <img :src="product.imgPath" :alt="product.productName">
                                            </div>
                                            <div class="product-info-text"> <!-- 텍스트 정보 컨테이너 추가 -->
                                                <h4>{{ product.brand }}</h4>
                                                <h3>{{ product.productName }}</h3>
                                                <p class="product-price" v-if="product.saleYN == 'N'">{{ formatCurrency(product.productPrice) }}</p>
                                                <p class="product-price" v-else><del>{{ formatCurrency(product.productPrice) }}</del> {{formatCurrency(product.salePrice)}}</p>
                                            </div>
                                        </a>
                                    </div>
                                    <p v-if="recommendedProducts.length === 0" class="no-products-message">추천 상품이 없습니다.
                                    </p>
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
                         <a href="/home/community/crew.do" style="display: block;">
                        <section class="crew-join-section">
                            <div class="crew-images-wrapper">
                                <div class="crew-image-container"> <!-- 이미지 두 개를 담는 컨테이너 -->
                                    <div class="crew-image-item" style="width: 100%; overflow: hidden;">
                                        <!-- <a href="/home/community/crew.do" style="display: block;"> -->
                                            <img 
                                            src="/img/crew_join_banner3.jpg"
                                            alt="크루 가입 배너 1"
                                            style="width: 100%; height: auto; display: block; border-radius: 10px; object-fit: contain;">
                                        <!-- </a> -->
                                    </div>
                                </div>
                                <span class="crew-overlay-text">JOIN A CREW</span> <!-- 텍스트는 항상 보임, 중앙 위치 -->
                            </div>
                        </section>
                        </a>
                        <!-- <section class="crew-join-section">
                            <div class="crew-images-wrapper">
                                <div class="crew-image-container"> 이미지 두 개를 담는 컨테이너
                                    <div class="crew-image-item">
                                        <a href="/home/community/crew.do"> 각 이미지가 자체 링크를 가짐
                                            <img src="/img/crew_join_banner.jpg" alt="크루 가입 배너 1">
                                        </a>
                                    </div>
                                    <div class="crew-image-item">
                                        <a href="/home/community/crew.do"> 각 이미지가 자체 링크를 가짐
                                            <img src="/img/crew_join_banner2.jpg" alt="크루 가입 배너 2">
                                        </a>
                                    </div>
                                </div>
                                <a href="/home/community/crew.do">
                                    <span class="crew-overlay-text">JOIN A CREW</span> 텍스트는 항상 보임, 중앙 위치
                                </a>    
                            </div>
                        </section> -->

                    </main>
                </div>

                <!-- 예산 추천 고정 버튼 -->
                <!--251117-->
                <button class="budget-recommend-btn" @click="openBudgetModal" title="예산 기반 상품 추천">
                    <i data-lucide="dollar-sign" stroke-width="2"></i>
                </button>

                <!-- 예산 추천 모달 -->
                <div id="budgetModal" class="budget-modal" v-if="showBudgetModal" @click.self="closeBudgetModal" style="display: block;">
                    <div class="budget-modal-content">
                        <span class="budget-modal-close" @click="closeBudgetModal">&times;</span>
                        <div class="budget-input-section">
                            <h2>예산 기반 상품 추천</h2>
                            <div class="budget-input-wrapper">
                                <input type="number" v-model="budgetAmount" placeholder="예산을 입력하세요 (원)" min="0" @keyup.enter="searchBudgetProducts">
                                <button @click="searchBudgetProducts">추천받기</button>
                            </div>
                        </div>
                        <div v-if="budgetRecommendations.length > 0" class="budget-chart-section">
                            <div class="budget-chart-container">
                                <div id="budgetChart"></div>
                            </div>
                            <div class="budget-category-bars">
                                <div v-for="(category, index) in budgetRecommendations" :key="index" class="budget-category-bar">
                                    <div class="budget-bar-info">
                                        <span class="budget-bar-label">{{ category.categoryName }}</span>
                                        <span class="budget-bar-value">
                                            {{ (category.adjustedPrice !== undefined ? category.adjustedPrice : (category.totalPrice || 0)).toLocaleString() }}원 
                                            ({{ (category.adjustedPercentage !== undefined ? category.adjustedPercentage : (category.percentage || 0)).toFixed(1) }}%)
                                        </span>
                                    </div>
                                    <div class="budget-bar-progress" 
                                         @mousedown="startDrag($event, index)"
                                         @touchstart="startDrag($event, index)">
                                        <div class="budget-bar-fill" 
                                             :class="'category-' + index"
                                             :style="{ width: (category.adjustedPercentage !== undefined ? category.adjustedPercentage : (category.percentage || 0)) + '%' }">
                                            <span style="margin-right: 15px;">
                                                {{ (category.adjustedPrice !== undefined ? category.adjustedPrice : (category.totalPrice || 0)).toLocaleString() }}원
                                            </span>
                                            <div class="budget-bar-handle"></div>
                                        </div>
                                    </div>
                                    <div class="budget-recommended-products" v-if="category.products && category.products.length > 0">
                                        <h4>추천 상품</h4>
                                        <div v-for="product in category.products" :key="product.productNo" 
                                             class="budget-product-item" 
                                             @click="goToProduct(product.productNo)">
                                            <img :src="product.imgPath || '/img/no-image.jpg'" :alt="product.productName" @error="handleImageError($event)">
                                            <div class="budget-product-info">
                                                <div class="product-name">{{ product.productName }}</div>
                                                <div class="product-price">{{ formatCurrency(product.finalPrice) }}</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div v-else class="budget-no-products">예산 내 추천 상품이 없습니다.</div>
                                </div>
                            </div>
                            <div style="text-align: center; margin-top: 20px;">
                                <button class="budget-recommend-btn-update" @click="updateRecommendationsByRatio">비율 조정 후 다시 추천받기</button>
                            </div>
                        </div>
                        <div v-else-if="budgetSearched && budgetRecommendations.length === 0" style="text-align: center; padding: 40px; color: #999;">
                            예산 내에서 추천할 수 있는 상품이 없습니다. 예산을 늘려서 다시 시도해주세요.
                        </div>
                        <div v-else style="text-align: center; padding: 40px; color: #999;">
                            예산을 입력하고 추천받기를 클릭해주세요.
                        </div>
                    </div>
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
            lucide.createIcons();
            const app = Vue.createApp({
                data() {
                    return {
                        mainSlideImages: [],
                        recommendedProducts: [],
                        latestRallies: [],
                        sessionId: '${sessionId}',
                        isLoggedOut: false,
                        userType: '${userType}',
                        //251117
                        showBudgetModal: false,
                        budgetAmount: '',
                        budgetRecommendations: [],
                        budgetSearched: false,
                        budgetChart: null,
                        isDragging: false,
                        dragIndex: -1,
                        originalBudget: 0,
                        dragHandlersInitialized: false,
                        updateChartTimer: null,
                        dragUpdateTimer: null,
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
                    //251117
                    handleImageError(event) {
                        // 이미지 로딩 실패 시 기본 이미지로 변경 (무한 루프 방지)
                        if (event.target.src && !event.target.src.includes('no-image.jpg')) {
                            event.target.src = '/img/no-image.jpg';
                        }
                    },
                    formatCurrency(value) { // 통화 형식 포맷 함수
                        if (value === null || value === undefined) return '0 원';
                        return value.toLocaleString('ko-KR') + ' 원';
                    },
                    fnLogout: function () {
                        let self = this;
                        let param = {};
                        $.ajax({
                            url: "/member/logout.dox",
                            dataType: "json",   
                            type: "POST",
                            data: param,
                            success: function (data) {
                                if (data.result == "success") {
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

                    fnKakao: function () {
                        let self = this;
                        let param = {
                            code: self.code
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
                    fnNotice() {
                        let self = this;
                        pageChange("/home/community/board.do", { type: "B" });
                    },
                    fnSale() {
                        let self = this;
                        self.saleYN = 'Y';
                        pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                    },
                    //251117
                    openBudgetModal() {
                        this.showBudgetModal = true;
                        this.$nextTick(() => {
                            lucide.createIcons();
                        });
                    },
                    //251117
                    closeBudgetModal() {
                        this.showBudgetModal = false;
                        this.budgetRecommendations = [];
                        this.budgetSearched = false;
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            this.budgetChart = null;
                            const chartElement = document.getElementById('budgetChart');
                            if (chartElement) {
                                chartElement.innerHTML = '';
                            }
                        }
                    },
                    searchBudgetProducts() {
                        if (!this.budgetAmount || this.budgetAmount <= 0) {
                            alert('올바른 예산을 입력해주세요.');
                            return;
                        }

                        let self = this;
                        $.ajax({
                            url: '/api/budgetRecommendations.dox',
                            method: 'POST',
                            dataType: 'json',
                            data: { budget: parseInt(this.budgetAmount) },
                            success: (response) => {
                                if (response.result === 'success' && response.data && Array.isArray(response.data)) {
                                    // adjustedPrice와 adjustedPercentage 초기화
                                    self.budgetRecommendations = response.data.map((cat, idx) => {
                                        // 모든 가능한 키 이름 확인
                                        const categoryName = cat.categoryName || cat['categoryName'] || '';
                                        const totalPrice = cat.totalPrice !== undefined && cat.totalPrice !== null 
                                            ? Number(cat.totalPrice) 
                                            : (cat['totalPrice'] !== undefined && cat['totalPrice'] !== null ? Number(cat['totalPrice']) : 0);
                                        const percentage = cat.percentage !== undefined && cat.percentage !== null 
                                            ? Number(cat.percentage) 
                                            : (cat['percentage'] !== undefined && cat['percentage'] !== null ? Number(cat['percentage']) : 0);
                                        const products = Array.isArray(cat.products) ? cat.products : (Array.isArray(cat['products']) ? cat['products'] : []);
                                        
                                        return {
                                            categoryName: categoryName,
                                            totalPrice: totalPrice,
                                            percentage: percentage,
                                            products: products,
                                            adjustedPrice: totalPrice,
                                            adjustedPercentage: percentage
                                        };
                                    });
                                    
                                    self.originalBudget = parseInt(self.budgetAmount);
                                    self.budgetSearched = true;
                                    self.$nextTick(() => {
                                        self.drawDonutChart(); // 도넛 차트 초기 생성
                                        self.initDragHandlers();
                                    });
                                } else {
                                    console.error('응답 데이터 형식 오류:', response);
                                    alert('추천 상품을 불러오는 중 오류가 발생했습니다: ' + (response.message || '데이터 형식 오류'));
                                }
                            },
                            error: (error) => {
                                console.error("예산 추천 AJAX 오류:", error);
                                alert('추천 상품을 불러오는 중 오류가 발생했습니다.');
                            }
                        });
                    },
                    //251117 - (사용 안 함, drawDonutChart로 대체됨)
                    drawBudgetChart_OLD() {
                        if (this.budgetRecommendations.length === 0) return;

                        const chartElement = document.getElementById('budgetChart');
                        if (!chartElement) return;

                        // 기존 차트가 있으면 제거
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            chartElement.innerHTML = '';
                        }

                        const categories = this.budgetRecommendations.map(cat => cat.categoryName);
                        // 차트는 adjustedPrice가 있으면 그것을, 없으면 totalPrice를 사용
                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        // 모든 데이터를 포함 (0원이어도 표시)
                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }));

                        // 필터링된 데이터가 없으면 경고
                        if (filteredData.length === 0) {
                            return;
                        }
                        
                        const series = filteredData.map(item => item.price);
                        const filteredCategories = filteredData.map(item => item.category);
                        
                        // ApexCharts가 로드되었는지 확인
                        if (typeof ApexCharts === 'undefined') {
                            console.error('ApexCharts가 로드되지 않았습니다!');
                            alert('차트 라이브러리를 불러오는 중 오류가 발생했습니다. 페이지를 새로고침해주세요.');
                            return;
                        }
                        
                        // 카테고리별 색상 매핑 (정확한 순서대로)
                        const categoryColorMap = {
                            '러닝화': '#008FFB',      // 파란색
                            '보호대': '#00E396',      // 초록색
                            '러닝복 상의': '#FEB019',  // 주황색
                            '러닝복 하의': '#FF4560'   // 빨간색
                        };
                        
                        // 카테고리 이름으로 색상 매핑
                        const mappedColors = filteredCategories.map(cat => {
                            return categoryColorMap[cat] || '#008FFB'; // 기본값 파란색
                        });

                        const options = {
                            series: series,
                            chart: {
                                type: 'donut',
                                width: '100%',
                                height: 400,
                                animations: {
                                    enabled: true,
                                    animateGradually: {
                                        enabled: true,
                                        delay: 150
                                    },
                                    dynamicAnimation: {
                                        enabled: true,
                                        speed: 350
                                    }
                                }
                            },
                            labels: filteredCategories,
                            colors: mappedColors,
                            stroke: {
                                show: true,
                                width: 2,
                                colors: ['#fff']
                            },
                            legend: {
                                position: 'bottom',
                                fontSize: '14px',
                                fontFamily: 'Arial, sans-serif',
                                itemMargin: {
                                    horizontal: 10,
                                    vertical: 5
                                }
                            },
                            dataLabels: {
                                enabled: true,
                                formatter: function (val, opts) {
                                    const value = series[opts.seriesIndex];
                                    return value.toLocaleString() + '원';
                                },
                                style: {
                                    fontSize: '12px',
                                    fontWeight: 'bold',
                                    colors: ['#fff']
                                }
                            },
                            tooltip: {
                                y: {
                                    formatter: function (val, opts) {
                                        const value = series[opts.seriesIndex];
                                        const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                        return value.toLocaleString() + '원 (' + percentage + '%)';
                                    }
                                }
                            },
                            plotOptions: {
                                pie: {
                                    donut: {
                                        size: '65%',
                                        labels: {
                                            show: true,
                                            name: {
                                                show: true,
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                color: '#373d3f'
                                            },
                                            value: {
                                                show: true,
                                                fontSize: '20px',
                                                fontWeight: 700,
                                                color: '#373d3f',
                                                formatter: function (val) {
                                                    return val.toLocaleString() + '원';
                                                }
                                            },
                                            total: {
                                                show: true,
                                                label: '사용 예산',
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                color: '#373d3f',
                                                formatter: function (w) {
                                                    return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            responsive: [{
                                breakpoint: 768,
                                options: {
                                    chart: {
                                        width: '100%',
                                        height: 350
                                    },
                                    legend: {
                                        position: 'bottom'
                                    }
                                }
                            }]
                        };

                        // 차트 컨테이너가 비어있는지 확인
                        if (chartElement.innerHTML.trim() !== '') {
                            chartElement.innerHTML = '';
                        }
                        
                        console.log('ApexCharts 옵션:', {
                            series: options.series,
                            labels: options.labels,
                            colors: options.colors,
                            seriesLength: options.series.length
                        });
                        
                        try {
                            // 기존 차트가 있으면 완전히 제거
                            if (this.budgetChart) {
                                this.budgetChart.destroy();
                                this.budgetChart = null;
                            }
                            
                            this.budgetChart = new ApexCharts(chartElement, options);
                            
                            // 약간의 지연 후 렌더링 (DOM이 완전히 준비되도록)
                            setTimeout(() => {
                                this.budgetChart.render().catch((error) => {
                                    console.error('차트 렌더링 오류:', error);
                                    alert('차트를 그리는 중 오류가 발생했습니다: ' + error.message);
                                });
                            }, 100);
                        } catch (error) {
                            console.error('ApexCharts 생성 오류:', error);
                            alert('차트를 생성하는 중 오류가 발생했습니다: ' + error.message);
                        }
                    },
                    //251117
                    initDragHandlers() {
                        // 전역 이벤트 리스너는 한 번만 등록
                        if (this.dragHandlersInitialized) return;
                        this.dragHandlersInitialized = true;

                        const self = this;
                        document.addEventListener('mousemove', (e) => {
                            if (self.isDragging) {
                                self.onDrag(e);
                            }
                        });
                        document.addEventListener('mouseup', () => {
                            if (self.isDragging) {
                                self.endDrag();
                            }
                        });
                        document.addEventListener('touchmove', (e) => {
                            if (self.isDragging) {
                                e.preventDefault();
                                self.onDrag(e.touches[0]);
                            }
                        });
                        document.addEventListener('touchend', () => {
                            if (self.isDragging) {
                                self.endDrag();
                            }
                        });
                    },
                    //251117
                    startDrag(event, index) {
                        event.preventDefault();
                        this.isDragging = true;
                        this.dragIndex = index;
                    },
                    //251117 - 바 차트 업데이트 (DOM 직접 조작) - 균등 분배용
                    updateBars(dragIndex, percentage, newPrice, remainingPercentagePerCategory, remainingPricePerCategory) {
                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        
                        allBars.forEach((bar, index) => {
                            const fillElement = bar.querySelector('.budget-bar-fill');
                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                            
                            if (index === dragIndex) {
                                // 드래그 중인 바
                                if (fillElement) fillElement.style.width = percentage + '%';
                                if (valueElement) valueElement.textContent = newPrice.toLocaleString() + '원 (' + percentage.toFixed(1) + '%)';
                            } else {
                                // 나머지 바들 (균등 분배)
                                if (fillElement) fillElement.style.width = remainingPercentagePerCategory + '%';
                                if (valueElement) valueElement.textContent = remainingPricePerCategory.toLocaleString() + '원 (' + remainingPercentagePerCategory.toFixed(1) + '%)';
                            }
                        });
                    },
                    //251117 - 바 차트 업데이트 (비율 유지하면서 재분배)
                    updateBarsWithRatios(dragIndex, percentage, newPrice, remainingPercentagesPerCategory, remainingPricesPerCategory) {
                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        
                        allBars.forEach((bar, index) => {
                            const fillElement = bar.querySelector('.budget-bar-fill');
                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                            
                            if (index === dragIndex) {
                                // 드래그 중인 바
                                if (fillElement) fillElement.style.width = percentage + '%';
                                if (valueElement) valueElement.textContent = newPrice.toLocaleString() + '원 (' + percentage.toFixed(1) + '%)';
                            } else {
                                // 나머지 바들 (기존 비율 유지하면서 재분배)
                                const catPercentage = remainingPercentagesPerCategory[index] || 0;
                                const catPrice = remainingPricesPerCategory[index] || 0;
                                if (fillElement) fillElement.style.width = catPercentage + '%';
                                if (valueElement) valueElement.textContent = catPrice.toLocaleString() + '원 (' + catPercentage.toFixed(1) + '%)';
                            }
                        });
                    },
                    //251117 - 도넛 차트 업데이트 (Vue 데이터 기반)
                    updateDonutChart() {
                        if (this.budgetRecommendations.length === 0) return;
                        if (!this.budgetChart) return;

                        // adjustedPrice를 우선 사용, 없으면 totalPrice 사용
                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        try {
                            if (this.budgetChart && typeof this.budgetChart.updateSeries === 'function') {
                                this.budgetChart.updateSeries(series, false); // false = no animate (빠른 업데이트)
                                this.budgetChart.updateOptions({
                                    labels: labels,
                                    colors: mappedColors,
                                    plotOptions: {
                                        pie: {
                                            donut: {
                                                labels: {
                                                    total: {
                                                        formatter: function (w) {
                                                            return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }, false, false); // false = redraw, false = no animate
                            }
                        } catch (error) {
                            console.error('도넛 차트 업데이트 오류:', error);
                        }
                    },
                    //251117 - 도넛 차트 즉시 업데이트 (드래그 중 직접 계산된 값 사용) - 균등 분배용
                    updateDonutChartImmediate(dragIndex, newPrice, remainingPricePerCategory) {
                        if (!this.budgetChart) return;

                        // 드래그 중인 값으로 직접 계산
                        const prices = this.budgetRecommendations.map((cat, idx) => {
                            if (idx === dragIndex) {
                                return newPrice;
                            } else {
                                return remainingPricePerCategory;
                            }
                        });
                        
                        this.updateDonutChartWithPrices(prices);
                    },
                    //251117 - 도넛 차트 즉시 업데이트 (비율 유지하면서 재분배)
                    updateDonutChartImmediateWithRatios(dragIndex, newPrice, remainingPricesPerCategory) {
                        if (!this.budgetChart) return;

                        // 드래그 중인 값으로 직접 계산 (비율 유지)
                        const prices = this.budgetRecommendations.map((cat, idx) => {
                            if (idx === dragIndex) {
                                return newPrice;
                            } else {
                                return remainingPricesPerCategory[idx] || 0;
                            }
                        });
                        
                        this.updateDonutChartWithPrices(prices);
                    },
                    //251117 - 도넛 차트 업데이트 공통 로직
                    updateDonutChartWithPrices(prices) {
                        if (!this.budgetChart) return;
                        
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        try {
                            if (this.budgetChart && typeof this.budgetChart.updateSeries === 'function') {
                                this.budgetChart.updateSeries(series, false); // false = no animate
                                this.budgetChart.updateOptions({
                                    labels: labels,
                                    colors: mappedColors,
                                    plotOptions: {
                                        pie: {
                                            donut: {
                                                labels: {
                                                    total: {
                                                        formatter: function (w) {
                                                            return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }, false, false);
                            }
                        } catch (error) {
                            console.error('도넛 차트 즉시 업데이트 오류:', error);
                        }
                    },
                    //251117
                    onDrag(event) {
                        if (this.dragIndex < 0 || !this.isDragging) return;

                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        const barElement = allBars[this.dragIndex];
                        if (!barElement || !this.budgetRecommendations[this.dragIndex]) return;

                        const rect = barElement.getBoundingClientRect();
                        const clientX = event.clientX || (event.touches && event.touches[0] ? event.touches[0].clientX : 0);
                        const x = clientX - rect.left;
                        const percentage = Math.max(0, Math.min(100, (x / rect.width) * 100));
                        const budget = this.originalBudget || parseInt(this.budgetAmount);
                        const newPrice = Math.round((budget * percentage) / 100);

                        // 나머지 바들의 현재 비율 유지하면서 재분배
                        const remainingBudget = budget - newPrice;
                        
                        // 드래그 중인 바를 제외한 나머지 바들의 현재 총 금액 계산
                        // DOM에서 직접 읽어와서 정확한 현재 상태 반영
                        let remainingTotal = 0;
                        const remainingPrices = [];
                        allBars.forEach((bar, index) => {
                            if (index !== this.dragIndex) {
                                const fillElement = bar.querySelector('.budget-bar-fill');
                                const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                                
                                // DOM에서 현재 width를 읽어서 가격 계산
                                let currentPrice = 0;
                                if (fillElement && valueElement) {
                                    const width = parseFloat(fillElement.style.width) || 0;
                                    const currentPercentage = width;
                                    currentPrice = Math.round((budget * currentPercentage) / 100);
                                } else {
                                    // DOM에서 읽을 수 없으면 Vue 데이터 사용
                                    const cat = this.budgetRecommendations[index];
                                    currentPrice = cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 
                                        ? cat.adjustedPrice 
                                        : (cat.totalPrice || 0);
                                }
                                
                                remainingPrices.push({ index: index, price: currentPrice });
                                remainingTotal += currentPrice;
                            }
                        });

                        // 나머지 바들의 비율을 유지하면서 재분배
                        const remainingPricesPerCategory = [];
                        const remainingPercentagesPerCategory = [];
                        
                        if (remainingTotal > 0 && remainingBudget > 0) {
                            // 기존 비율대로 재분배
                            remainingPrices.forEach(item => {
                                const ratio = item.price / remainingTotal; // 기존 비율
                                const newPriceForCategory = Math.round(remainingBudget * ratio);
                                const newPercentageForCategory = (newPriceForCategory / budget) * 100;
                                remainingPricesPerCategory[item.index] = newPriceForCategory;
                                remainingPercentagesPerCategory[item.index] = newPercentageForCategory;
                            });
                        } else {
                            // 처음 드래그하는 경우 균등 분배
                            const remainingCategories = this.budgetRecommendations.length - 1;
                            const equalPrice = remainingCategories > 0 ? Math.round(remainingBudget / remainingCategories) : 0;
                            const equalPercentage = remainingCategories > 0 ? (remainingBudget / budget) * 100 / remainingCategories : 0;
                            this.budgetRecommendations.forEach((cat, index) => {
                                if (index !== this.dragIndex) {
                                    remainingPricesPerCategory[index] = equalPrice;
                                    remainingPercentagesPerCategory[index] = equalPercentage;
                                }
                            });
                        }

                        // 1. 바 차트 즉시 업데이트 (DOM 직접 조작)
                        this.updateBarsWithRatios(this.dragIndex, percentage, newPrice, remainingPercentagesPerCategory, remainingPricesPerCategory);

                        // 2. 도넛 차트 즉시 업데이트 (계산된 값으로 바로 업데이트)
                        this.updateDonutChartImmediateWithRatios(this.dragIndex, newPrice, remainingPricesPerCategory);

                        // 3. Vue 데이터는 throttle로 업데이트 (200ms마다 한 번만)
                        if (!this.dragUpdateTimer) {
                            this.dragUpdateTimer = setTimeout(() => {
                                // Vue 데이터 업데이트 (Vue 3에서는 직접 할당)
                                this.budgetRecommendations[this.dragIndex].adjustedPercentage = percentage;
                                this.budgetRecommendations[this.dragIndex].adjustedPrice = newPrice;
                                
                                this.budgetRecommendations.forEach((cat, index) => {
                                    if (index !== this.dragIndex) {
                                        cat.adjustedPercentage = remainingPercentagesPerCategory[index] || 0;
                                        cat.adjustedPrice = remainingPricesPerCategory[index] || 0;
                                    }
                                });
                                
                                this.dragUpdateTimer = null;
                            }, 200);
                        }
                    },
                    //251117
                    endDrag() {
                        this.isDragging = false;
                        const dragIndex = this.dragIndex;
                        this.dragIndex = -1;
                        
                        // 드래그 업데이트 타이머 정리
                        if (this.dragUpdateTimer) {
                            clearTimeout(this.dragUpdateTimer);
                            this.dragUpdateTimer = null;
                        }
                        
                        // 마지막 값으로 Vue 데이터 업데이트 (비율 유지)
                        if (dragIndex >= 0 && this.budgetRecommendations[dragIndex]) {
                            const allBars = document.querySelectorAll('.budget-bar-progress');
                            const barElement = allBars[dragIndex];
                            if (barElement) {
                                const fillElement = barElement.querySelector('.budget-bar-fill');
                                if (fillElement) {
                                    const width = fillElement.style.width;
                                    const percentage = parseFloat(width) || 0;
                                    const budget = this.originalBudget || parseInt(this.budgetAmount);
                                    const newPrice = Math.round((budget * percentage) / 100);
                                    
                                    // 나머지 바들의 현재 비율 유지하면서 재분배
                                    const remainingBudget = budget - newPrice;
                                    
                                    // 드래그 중인 바를 제외한 나머지 바들의 현재 총 금액 계산
                                    // DOM에서 직접 읽어와서 정확한 현재 상태 반영
                                    const allBars = document.querySelectorAll('.budget-bar-progress');
                                    let remainingTotal = 0;
                                    const remainingPrices = [];
                                    allBars.forEach((bar, index) => {
                                        if (index !== dragIndex) {
                                            const fillElement = bar.querySelector('.budget-bar-fill');
                                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                                            
                                            // DOM에서 현재 width를 읽어서 가격 계산
                                            let currentPrice = 0;
                                            if (fillElement && valueElement) {
                                                const width = parseFloat(fillElement.style.width) || 0;
                                                const currentPercentage = width;
                                                currentPrice = Math.round((budget * currentPercentage) / 100);
                                            } else {
                                                // DOM에서 읽을 수 없으면 Vue 데이터 사용
                                                const cat = this.budgetRecommendations[index];
                                                currentPrice = cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 
                                                    ? cat.adjustedPrice 
                                                    : (cat.totalPrice || 0);
                                            }
                                            
                                            remainingPrices.push({ index: index, price: currentPrice });
                                            remainingTotal += currentPrice;
                                        }
                                    });

                                    // 나머지 바들의 비율을 유지하면서 재분배
                                    const remainingPricesPerCategory = [];
                                    const remainingPercentagesPerCategory = [];
                                    
                                    if (remainingTotal > 0 && remainingBudget > 0) {
                                        // 기존 비율대로 재분배
                                        remainingPrices.forEach(item => {
                                            const ratio = item.price / remainingTotal; // 기존 비율
                                            const newPriceForCategory = Math.round(remainingBudget * ratio);
                                            const newPercentageForCategory = (newPriceForCategory / budget) * 100;
                                            remainingPricesPerCategory[item.index] = newPriceForCategory;
                                            remainingPercentagesPerCategory[item.index] = newPercentageForCategory;
                                        });
                                    } else {
                                        // 처음 드래그하는 경우 균등 분배
                                        const remainingCategories = this.budgetRecommendations.length - 1;
                                        const equalPrice = remainingCategories > 0 ? Math.round(remainingBudget / remainingCategories) : 0;
                                        const equalPercentage = remainingCategories > 0 ? (remainingBudget / budget) * 100 / remainingCategories : 0;
                                        this.budgetRecommendations.forEach((cat, index) => {
                                            if (index !== dragIndex) {
                                                remainingPricesPerCategory[index] = equalPrice;
                                                remainingPercentagesPerCategory[index] = equalPercentage;
                                            }
                                        });
                                    }
                                    
                                    // Vue 데이터 업데이트 (Vue 3에서는 직접 할당)
                                    this.budgetRecommendations[dragIndex].adjustedPercentage = percentage;
                                    this.budgetRecommendations[dragIndex].adjustedPrice = newPrice;
                                    
                                    this.budgetRecommendations.forEach((cat, index) => {
                                        if (index !== dragIndex) {
                                            cat.adjustedPercentage = remainingPercentagesPerCategory[index] || 0;
                                            cat.adjustedPrice = remainingPricesPerCategory[index] || 0;
                                        }
                                    });
                                    
                                    console.log('endDrag 완료 - dragIndex: ' + dragIndex + ', adjustedPrice: ' + this.budgetRecommendations[dragIndex].adjustedPrice + ', adjustedPercentage: ' + this.budgetRecommendations[dragIndex].adjustedPercentage);
                                    
                                    // 도넛 차트 최종 업데이트
                                    this.updateDonutChart();
                                }
                            }
                        }
                    },
                    //251117 - 도넛 차트 초기 생성 (처음 한 번만)
                    drawDonutChart() {
                        if (this.budgetRecommendations.length === 0) return;
                        const chartElement = document.getElementById('budgetChart');
                        if (!chartElement) return;

                        // 기존 차트가 있으면 제거
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            chartElement.innerHTML = '';
                        }

                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        if (typeof ApexCharts === 'undefined') {
                            console.error('ApexCharts가 로드되지 않았습니다!');
                            return;
                        }

                        const options = {
                            series: series,
                            chart: {
                                type: 'donut',
                                width: '100%',
                                height: 400
                            },
                            labels: labels,
                            colors: mappedColors,
                            plotOptions: {
                                pie: {
                                    donut: {
                                        size: '65%',
                                        labels: {
                                            show: true,
                                            name: {
                                                show: true,
                                                fontSize: '16px',
                                                fontWeight: 600
                                            },
                                            value: {
                                                show: true,
                                                fontSize: '20px',
                                                fontWeight: 700,
                                                formatter: function (val) {
                                                    return val.toLocaleString() + '원';
                                                }
                                            },
                                            total: {
                                                show: true,
                                                label: '사용 예산',
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                formatter: function (w) {
                                                    return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        };

                        try {
                            this.budgetChart = new ApexCharts(chartElement, options);
                            setTimeout(() => {
                                this.budgetChart.render().catch((error) => {
                                    console.error('도넛 차트 렌더링 오류:', error);
                                });
                            }, 100);
                        } catch (error) {
                            console.error('도넛 차트 생성 오류:', error);
                        }
                    },
                    //251117
                    updateRecommendationsByRatio() {
                        // 조정된 비율에 따라 각 카테고리별로 예산을 재할당하여 상품 추천
                        const self = this;
                        const vueInstance = this; // Vue 인스턴스 참조 보존
                        const budget = this.originalBudget || parseInt(this.budgetAmount);
                        
                        console.log('비율 조정 후 다시 추천받기 시작');
                        console.log('현재 budgetRecommendations:', JSON.parse(JSON.stringify(this.budgetRecommendations)));
                        
                        // 각 카테고리별로 조정된 예산으로 상품 조회
                        const promises = this.budgetRecommendations.map((category, index) => {
                            // adjustedPrice를 우선 사용, 없으면 totalPrice 사용
                            // adjustedPrice가 0이거나 undefined/null이면 totalPrice 사용
                            let categoryBudget = 0;
                            if (category.adjustedPrice !== undefined && category.adjustedPrice !== null && category.adjustedPrice > 0) {
                                categoryBudget = category.adjustedPrice;
                            } else if (category.totalPrice !== undefined && category.totalPrice !== null && category.totalPrice > 0) {
                                categoryBudget = category.totalPrice;
                            }
                            
                            console.log('카테고리 ' + category.categoryName + ' - adjustedPrice: ' + category.adjustedPrice + ', totalPrice: ' + category.totalPrice + ', adjustedPercentage: ' + category.adjustedPercentage + ', 사용할 예산: ' + categoryBudget);
                            
                            if (categoryBudget <= 0) {
                                console.warn('카테고리 ' + category.categoryName + ' 예산이 0이므로 상품 조회 스킵');
                                return Promise.resolve({ category: category.categoryName, products: [] });
                            }

                            return new Promise((resolve) => {
                                $.ajax({
                                    url: '/api/budgetRecommendations.dox',
                                    method: 'POST',
                                    dataType: 'json',
                                    data: { 
                                        budget: categoryBudget,
                                        categoryName: category.categoryName
                                    },
                                    success: (response) => {
                                        console.log('카테고리 ' + category.categoryName + ' API 응답:', response);
                                        if (response.result === 'success' && response.data && response.data.length > 0) {
                                            const catData = response.data[0]; // 단일 카테고리 조회이므로 첫 번째 요소
                                            console.log('카테고리 ' + category.categoryName + ' 상품 수: ' + (catData.products ? catData.products.length : 0) + ', 상품 목록:', catData.products);
                                            resolve({
                                                category: category.categoryName,
                                                products: catData.products || []
                                            });
                                        } else {
                                            console.warn('카테고리 ' + category.categoryName + ' 응답 데이터 없음 - result: ' + response.result + ', data:', response.data);
                                            resolve({ category: category.categoryName, products: [] });
                                        }
                                    },
                                    error: (error) => {
                                        console.error('카테고리 ' + category.categoryName + ' API 오류:', error);
                                        resolve({ category: category.categoryName, products: [] });
                                    }
                                });
                            });
                        });

                        Promise.all(promises).then((results) => {
                            try {
                                console.log('모든 API 응답 완료:', results);
                                
                                // 결과를 budgetRecommendations에 반영
                                results.forEach((result) => {
                                    try {
                                        // 배열 인덱스를 찾아서 직접 업데이트
                                        const categoryIndex = self.budgetRecommendations.findIndex(c => c.categoryName === result.category);
                                        if (categoryIndex >= 0) {
                                            const category = self.budgetRecommendations[categoryIndex];
                                            console.log('카테고리 ' + result.category + ' 업데이트 전 상품 수: ' + (category.products ? category.products.length : 0));
                                            console.log('카테고리 ' + result.category + ' 업데이트 후 상품 수: ' + (result.products ? result.products.length : 0));
                                            
                                            // 조정된 예산(adjustedPrice)은 유지 (사용자가 조정한 비율 보존)
                                            // adjustedPrice가 있으면 사용, 없으면 현재 totalPrice를 adjustedPrice로 설정
                                            let currentAdjustedPrice = category.adjustedPrice;
                                            let currentAdjustedPercentage = category.adjustedPercentage;
                                            
                                            // adjustedPrice가 없거나 0이면, 현재 totalPrice를 adjustedPrice로 사용
                                            if (currentAdjustedPrice === undefined || currentAdjustedPrice === null || currentAdjustedPrice === 0) {
                                                currentAdjustedPrice = category.totalPrice || 0;
                                                currentAdjustedPercentage = category.percentage || 0;
                                            }
                                            
                                            // adjustedPercentage가 없으면 계산
                                            if (currentAdjustedPercentage === undefined || currentAdjustedPercentage === null) {
                                                currentAdjustedPercentage = budget > 0 ? (currentAdjustedPrice * 100.0 / budget) : 0;
                                            }
                                            
                                            console.log('카테고리 ' + result.category + ' 조정된 예산 유지 - adjustedPrice: ' + currentAdjustedPrice + ', adjustedPercentage: ' + currentAdjustedPercentage + '%, totalPrice: ' + category.totalPrice + ', percentage: ' + category.percentage + '%');
                                            
                                            // 조정된 예산에 맞게 실제 사용된 금액 계산
                                            let actualTotal = 0;
                                            
                                            if (result.products && result.products.length > 0) {
                                                // 가장 비싼 제품 1개만 사용 (1세트 개념)
                                                // 백엔드에서 이미 가장 비싼 제품 1개만 반환하므로 첫 번째 제품 사용
                                                actualTotal = result.products[0].finalPrice || 0;
                                            }
                                            
                                            // 실제 사용된 금액이 조정된 예산보다 크면 조정된 예산으로 제한
                                            actualTotal = Math.min(actualTotal, currentAdjustedPrice);
                                            
                                            // 객체 속성을 직접 수정하여 Vue 반응성 보장 (Vue 3)
                                            category.products = result.products || [];
                                            category.totalPrice = actualTotal;
                                            // percentage는 실제 사용된 금액 기준으로 계산 (도넛 차트용)
                                            category.percentage = budget > 0 ? (actualTotal * 100.0 / budget) : 0;
                                            // adjustedPrice와 adjustedPercentage는 사용자가 조정한 값 유지 (바 차트용)
                                            category.adjustedPrice = currentAdjustedPrice;
                                            category.adjustedPercentage = currentAdjustedPercentage;
                                            
                                            console.log('카테고리 ' + result.category + ' 업데이트 - products: ' + category.products.length + '개, totalPrice: ' + category.totalPrice + ', percentage: ' + category.percentage + '%, adjustedPrice: ' + category.adjustedPrice + ', adjustedPercentage: ' + category.adjustedPercentage + '%');
                                            
                                            console.log('카테고리 ' + result.category + ' 최종 업데이트 완료 - 상품: ' + category.products.length + '개, 실제금액: ' + actualTotal + ', 조정예산: ' + currentAdjustedPrice);
                                        } else {
                                            console.warn('카테고리 ' + result.category + '를 찾을 수 없음');
                                        }
                                    } catch (err) {
                                        console.error('카테고리 ' + result.category + ' 업데이트 중 오류:', err);
                                    }
                                });
                                
                                try {
                                    console.log('업데이트 후 budgetRecommendations:', JSON.parse(JSON.stringify(self.budgetRecommendations)));
                                } catch (jsonErr) {
                                    console.warn('JSON 직렬화 오류 (무시 가능):', jsonErr);
                                }
                                
                                // 도넛 차트 업데이트 (Vue 반응성 업데이트 완료 후)
                                self.$nextTick(() => {
                                    try {
                                        self.updateDonutChart();
                                    } catch (chartErr) {
                                        console.error('도넛 차트 업데이트 오류:', chartErr);
                                    }
                                });
                            } catch (err) {
                                console.error('Promise.all 처리 중 오류:', err);
                                throw err; // catch 블록으로 전달
                            }
                        }).catch((error) => {
                            console.error('비율 조정 후 추천받기 오류:', error);
                            console.error('에러 상세:', error.message, error.stack);
                            alert('추천 상품을 불러오는 중 오류가 발생했습니다: ' + (error.message || '알 수 없는 오류'));
                        });
                    },
                    //251117
                    goToProduct(productNo) {
                        window.location.href = '/home/product-info.do?productNo=' + productNo;
                    }
                },
                mounted() {
                    // 처음 시작할 때 실행되는 부분
                    let self = this;
                    const queryParams = new URLSearchParams(window.location.search);
                    self.code = queryParams.get('code') || '';
                    if (self.code != "") {
                        self.fnKakao();
                    }
                    this.fetchMainSlideImages();
                    this.fetchRecommendedProducts();
                    this.fetchLatestRallies();
                    lucide.createIcons();
                }
            });

            app.mount('#app');
        </script>