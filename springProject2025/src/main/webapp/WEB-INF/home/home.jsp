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

    <style>
        /* style.css */

        /* --- 기본 레이아웃 설정 --- */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #333;
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
            text-decoration: underline;
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
        .container {
            flex: 1;
            max-width: 100%; /* 이 값은 유지하되, Swiper는 이 안에서 유연하게 작동해야 함 */
            margin: 0 auto;
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1; /* .container 내에서 남은 공간 차지 */
            padding: 20px 0; /* 상하 패딩 */
        }

        /* 각 섹션별 내부 패딩은 섹션 자체에서 관리하도록 조정 */
        main > section { /* main 바로 아래 섹션에만 적용 */
            margin-bottom: 40px;
            padding: 0 20px; /* 각 섹션에 좌우 패딩 적용 */
        }
        main > section h2 {
            font-size: 2em;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #007bff;
            display: inline-block;
            padding-bottom: 10px;
        }

        /* Main Hero Slider styles (메인 상단 배너) */
        .main > section:not(.main-hero-slider), /* main-hero-slider가 아닌 다른 섹션들 */
        .main > .main-hero-slider-area {       /* 메인 슬라이더 영역 wrapper */
            margin-bottom: 40px;
            padding: 0 20px; /* 각 섹션에 좌우 패딩 적용 */
        }

        /* 메인 슬라이더 영역 wrapper */
        .main-hero-slider-area {
            position: relative; /* 커버 div의 absolute 포지셔닝 기준 */
            /* 현재는 max-width가 .container에 적용되므로 width: 100%만 있으면 됩니다. */
        }

        .main-hero-slider {
            width: 100%;
            height: 700px;
            position: relative;
            overflow: hidden; /* 슬라이더 자체의 오버플로우는 숨김 */
            padding: 0; /* ★★★ 이제 이 섹션 자체에는 패딩을 주지 않습니다. ★★★ */
        }
        .main-hero-slider .swiper-container {
            width: 100%;
            height: 100%;
        }
        .main-hero-slider .swiper-slide {
            width: 100%; /* ★★★ !important 제거, 이 값은 JavaScript에 의해 재설정될 수 있으나, 가리는 게 주 목적 ★★★ */
            box-sizing: border-box;
            text-align: center;
            font-size: 18px;
            background: #eee;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .main-hero-slider .swiper-slide img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .swiper-slide-duplicate:not(.swiper-slide-active):not(.swiper-slide-next):not(.swiper-slide-prev) {
            visibility: hidden;
        }
        .swiper-pagination-bullet {
            background-color: #fff;
            opacity: 0.8;
        }
        .swiper-pagination-bullet-active {
            background-color: #007bff;
        }
        .swiper-button-next, .swiper-button-prev {
            color: #fff;
            background-color: rgba(0,0,0,0.5);
            border-radius: 50%;
            padding: 20px;
            width: 50px;
            height: 50px;
        }
        .swiper-button-next:hover, .swiper-button-prev:hover {
            background-color: rgba(0,0,0,0.7);
        }
        /* ★★★ 양쪽 사이드를 가리는 div 스타일 추가 ★★★ */
        .swiper-side-cover {
            position: absolute;
            top: 0;
            width: 110px; /* 가릴 영역의 너비 (양옆 이미지 크기에 따라 조정) */
            height: 100%;
            background-color: white; /* 페이지 배경색과 동일하게 설정 */
            z-index: 9999; /* 슬라이더 위에 덮어씌워지도록 */
        }

        .swiper-side-cover.left {
            left: -360px; /* 왼쪽으로 가릴 너비만큼 이동시켜 슬라이더 바깥 영역을 덮습니다. */
        }

        .swiper-side-cover.right {
            right: -360px; /* 오른쪽으로 가릴 너비만큼 이동시켜 슬라이더 바깥 영역을 덮습니다. */
        }


        /* Product Showcase styles (추천 상품 목록) */
        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            justify-content: center;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            text-align: center;
            /* padding: 20px; <--- 이 패딩을 제거하여 이미지가 카드의 시작점에 붙도록 합니다. */
            /* 텍스트 영역에만 패딩을 주고 싶다면, img 태그를 감싸는 div와 텍스트를 감싸는 div를 분리 후 각각 패딩을 주는 것을 고려. */
            /* 지금은 이미지를 꽉 채우는 데 초점을 맞추므로 카드 자체의 padding을 제거 */
            padding: 0; /* 카드의 패딩 제거 */
            transition: transform 0.2s;
            overflow: hidden; /* 자식 요소가 부모 영역을 넘어가지 않도록 */
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        /* ★★★ 이미지 스타일 수정: 꽉 채우고 파란색 테두리 방지 ★★★ */
        .product-card img {
            display: block;     /* 이미지 아래 여백 제거 */
            width: 100%;        /* 부모 (.product-card)의 너비를 꽉 채움 */
            height: 200px;      /* 높이 고정 (기존과 동일), 필요시 조정 */
            object-fit: cover;  /* 비율 유지하며 컨테이너를 꽉 채움 (일부 잘릴 수 있음) */
            margin-top: 10px;
            /* 혹시 모를 테두리나 외곽선 방지 */
            border: none;
            outline: none;
            
            /* 텍스트와 이미지 사이에 마진이 필요하다면 여기에 추가 */
            /* margin-bottom: 15px; 는 텍스트 영역을 감싸는 div에 적용하는 것이 좋음 */
        }

        /* ★★★ 링크 스타일 수정: 이미지 주변 파란색 배경 제거 및 클릭 영역 설정 ★★★ */
        .product-card a {
            display: block; /* 링크 클릭 영역을 카드 전체로 확장 */
            text-decoration: none;
            color: inherit; /* 링크 텍스트 색상을 부모에서 상속 (기본 파란색 제거) */
            
            /* ★★★ 핵심: 링크의 파란색 배경을 투명하게 변경하거나 아예 제거 ★★★ */
            background-color: transparent; /* 링크 자체의 배경을 투명하게 */
            
            outline: none; /* 포커스 시 생기는 외곽선 제거 */
            padding: 20px; /* <--- 이미지 아래 텍스트 영역에 패딩을 다시 줍니다 */
            /* padding-top은 이미지가 꽉 채워지므로 0, 좌우 20px, 아래 20px */
            padding-top: 0;
        }

        /* product-card h3, p 스타일은 기존 유지하되, a 태그의 padding 안에 위치하도록. */
        /* .product-card h3, .product-card p 는 a 태그의 자식이므로 a의 color를 상속받거나 개별 정의 */
        .product-card h3 {
            font-size: 1.3em;
            margin-bottom: 10px;
            color: #333; /* 텍스트 색상 명확히 지정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-top: 15px; /* 이미지와 텍스트 사이에 마진 추가 */
        }
        .product-card p {
            font-size: 1.1em;
            color: black; /* 가격은 파란색 유지 */
            font-weight: bold;
            margin-bottom: 0; /* a 태그의 padding-bottom으로 충분 */
        }


        /* Rally Showcase (최신 대회 목록) */
        .rally-showcase h2 {
            border-bottom: 2px solid #28a745; /* 초록색 강조 */
        }
        .rally-showcase .swiper-container {
            /* 이전에 제거했던 padding을 다시 추가합니다. */
            padding: 0; /* 좌우 50px의 패딩을 주어 네비게이션 버튼 공간 확보 */
            box-sizing: border-box; /* 패딩이 전체 너비에 포함되도록 함 */
            width: 100%; /* 부모 너비를 꽉 채우도록 명시 */
            margin: 0 auto; /* 중앙 정렬 */
            overflow: hidden; /* 슬라이드 밖으로 나가는 요소는 숨김 */
        }
        .rally-showcase .swiper-slide {
            text-align: center;
            background: #fff; /* 상품 카드와 통일성을 위해 흰색 배경 */
            /* border: 1px solid #ddd; */
            border-radius: 8px;
            /* box-shadow: 0 2px 5px rgba(0,0,0,0.05); */
            padding: 0; /* 슬라이드 카드의 패딩 제거 (이미지가 꽉 차도록) */
            overflow: hidden; /* 이미지 오버플로우 방지 */
            transition: transform 0.2s;
            /* Swiper 내부 설정이 너비를 제어하므로, 여기에 width를 직접 주지 않습니다. */
        }
        .rally-showcase .swiper-slide:hover {
            transform: translateY(-5px);
        }
        .rally-showcase .swiper-slide a {
            color: inherit;
            text-decoration: none;
            display: block;
            outline: none;
            background-color: transparent; /* 링크 배경색 투명하게 */
            padding: 15px; /* 텍스트 영역에만 패딩 */
            padding-top: 0; /* 이미지 위쪽 패딩은 없도록 */
        }
        .rally-showcase .swiper-slide img {
            display: block;     /* 이미지 아래 여백 제거 */
            width: 100%;        /* 부모 (.swiper-slide) 너비 꽉 채움 */
            height: 300px;      /* ★ 높이를 상품 이미지보다 더 크게 (예: 300px) ★ */
            object-fit: cover;  /* 비율 유지하며 컨테이너 꽉 채움 (포스터 이미지에 적합) */
            border: none;       /* 혹시 모를 테두리 제거 */
            outline: none;      /* 혹시 모를 외곽선 제거 */
        }
        .rally-showcase .swiper-slide h3 {
            margin-top: 10px; /* 이미지와 텍스트 사이 간격 */
            font-size: 1.2em;
            margin-bottom: 5px;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .rally-showcase .swiper-slide p {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 0; /* a 태그의 패딩으로 충분 */
        }
        .rallySwiper .swiper-button-next,
        .rallySwiper .swiper-button-prev {
            /* 기존 스타일 유지 */
            color: #007bff;
            background-color: rgba(255,255,255,0.8);
            border: 1px solid #007bff;
            border-radius: 50%;
            /* width: 40px;
            height: 40px; */
            transform: translateY(-50%);
            top: 50%;
            font-size: 0.8em;
            
            /* 패딩 내에 위치하도록 left/right 값 조정 */
            left: 10px; /* 왼쪽 버튼 */
            right: 10px; /* 오른쪽 버튼 */
            /* Swiper 기본 스타일에서는 버튼이 컨테이너 끝에 붙지만, 패딩 안쪽으로 10px 들여씁니다. */
            /* 필요시 이 값(10px)을 조절하여 패딩 중앙이나 원하는 위치에 오도록 할 수 있습니다. */
        }
        .rallySwiper .swiper-button-next {
            right: 10px; /* next 버튼은 right 속성으로만 제어 */
            left: auto;  /* 불필요한 left 속성 제거 */
        }
        .rallySwiper .swiper-button-prev {
            left: 10px; /* prev 버튼은 left 속성으로만 제어 */
            right: auto; /* 불필요한 right 속성 제거 */
        }
        .rallySwiper .swiper-button-next:hover,
        .rallySwiper .swiper-button-prev:hover {
            background-color: #007bff;
            color: #fff;
        }

        /* Crew Join Section (크루 가입 배너) */
        .crew-join-section {
            text-align: center; /* 전체 섹션을 가운데 정렬 */
            padding: 0 20px; /* main section padding과 일치하도록 조정 */
            margin-bottom: 40px; /* 아래쪽 마진 유지 */
        }

        .crew-images-wrapper {
            width: 100%;
            position: relative; /* 오버레이 텍스트의 기준점 */
            overflow: hidden; /* 자식 요소가 넘칠 경우 처리 */
            border-radius: 0; /* 둥근 보더라인 제거 */
            /* text-align: center; 내부 텍스트를 위한 정렬 */
            display: flex; /* 내부 컨텐츠를 유연하게 배치하기 위해 */
            justify-content: center; /* 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
        }

        .crew-image-container { /* 두 이미지를 담는 컨테이너 */
            display: flex; /* 내부 이미지를 가로로 배치 */
            flex-grow: 1; /* 가용한 공간을 모두 차지하도록 */
            /* max-width는 이미지들이 너무 커지는 것을 방지 */
            /* width: 100%;  부모의 100% */
        }

        .crew-image-item {
            flex: 1; /* 가로 공간을 동일하게 나눔 */
            min-width: 0; /* flex item 내부 content overflow 방지 */
            position: relative; /* 호버 시 이미지를 어둡게 만들기 위한 기준 */
        }
        .crew-image-item a { /* 각 이미지 링크 */
            display: block; /* 링크가 이미지 전체 영역을 차지하도록 */
            line-height: 0; /* 불필요한 라인 높이 제거 */
            text-decoration: none;
            color: inherit;
        }
        .crew-image-item img {
            display: block;
            width: 100%;
            height: 300px; /* 이미지 높이 고정 (조정 가능) */
            object-fit: cover; /* 이미지가 영역을 채우도록 크롭 */
            border-radius: 0; /* 둥근 모서리 제거 */
            /*vertical-align: middle;  이미지 하단 여백 제거 */
            transition: filter 0.3s ease; /* 호버 효과를 위해 */
        }
        .crew-overlay-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* 정확히 이미지 중앙에 위치 */
            color: white; /* 텍스트 색상 흰색 */
            font-size: 2.5em; /* 텍스트 크기 */
            font-weight: bold;
            text-align: center;
            padding: 5px 15px; /* 약간의 패딩 */
            white-space: nowrap; /* 텍스트 줄바꿈 방지 */
            z-index: 10; /* 이미지 위에 텍스트가 표시되도록 */
            text-shadow: 2px 2px 4px rgba(0,0,0,0.7); /* 어두운 그림자로 가독성 향상 */
            opacity: 1; /* 항상 보이도록 opacity 1 유지 */
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
                    <div><a href="/home.do">RUNNERS' HOUSE</a></div>
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
                    <div v-if="sessionId != ''"><a href="/home/mypage/information.do">마이페이지</a></div>
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
                    <!-- ★★★ 양쪽 사이드를 가릴 div 추가 ★★★ -->
                    <div class="swiper-side-cover left"></div>
                    <div class="swiper-side-cover right"></div>
                </div>

                 <!-- Logout popup -->
                <div v-if="isLoggedOut" class="modal-overlay">
                    <div class="modal-content">
                        <h2>{{userName}} 님, 로그아웃 되었습니다.</h2>
                        <a href="/home.do"><button>메인 화면으로 가기</button></a>
                    </div>
                </div>
                <!-- 추천 상품 영역 -->
                <section class="products-showcase">
                    <h2>추천 상품</h2>
                    <div class="product-list">
                        <div class="product-card" v-for="product in recommendedProducts" :key="product.productNo">
                            <a :href="'/home/product-info.do?productNo=' + product.productNo">
                                <img :src="product.imgPath" :alt="product.productName">
                                <h3>{{ product.productName }}</h3>
                                <p>{{ formatCurrency(product.productPrice) }}</p>
                            </a>
                        </div>
                        <p v-if="recommendedProducts.length === 0">추천 상품이 없습니다.</p>
                    </div>
                </section>
              
                <!-- 최신 대회 영역 -->
                <section class="rally-showcase">
                    <h2>대회 정보</h2>
                    <div class="swiper-container rallySwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" v-for="rally in latestRallies" :key="rally.rallyNo">
                                <a :href="'/home/community/rally.do'"> <!-- TODO: 대회 상세 페이지 URL -->
                                    <img :src="rally.imgPath" :alt="rally.rallyName">
                                    <h3>{{ rally.rallyName }}</h3>
                                    <p>대회 일자 : {{ formatDate(rally.rallyDate) }}</p>
                                </a>
                            </div>
                        </div>
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
                // 1. 이미지가 있을 때만 초기화
                if (this.mainSlideImages.length > 0) {
                    // 2. 기존 Swiper 인스턴스가 있다면 파괴 (메모리 누수 방지 및 재초기화)
                    if (this.mainSwiperInstance) {
                        this.mainSwiperInstance.destroy(true, true);
                    }

                    // 3. Swiper 컨테이너 요소 찾기
                    const swiperEl = document.querySelector('.mySwiper');
                    if (!swiperEl) {
                        console.error("Swiper container '.mySwiper' not found."); // 컨테이너 없으면 에러 로그만 남김
                        return;
                    }

                    // 4. 새로운 Swiper 인스턴스 생성
                    this.mainSwiperInstance = new Swiper(swiperEl, {
                        loop: true, // 무한 루프
                        autoplay: { // 자동 재생 설정
                            delay: 3000,
                            disableOnInteraction: false,
                        },
                        pagination: { // 페이지네이션 설정 (하단 점)
                            el: '.swiper-pagination',
                            clickable: true,
                        },
                        slidesPerView: 1,           // 한 번에 하나의 슬라이드 표시
                        spaceBetween: 0,            // 슬라이드 간 간격 없음
                        centeredSlides: false,      // 슬라이드 중앙 정렬 안 함 (이전 설정 유지)
                        slidesPerGroup: 1,          // 한 번에 한 개의 슬라이드 그룹 이동
                        watchOverflow: true,        // 슬라이드가 부족하여 overflow가 발생하면 비활성화
                        observer: true,             // Swiper 요소 또는 자식 요소의 변화를 감지하여 업데이트
                        observeParents: true,       // Swiper 부모 요소의 변화를 감지하여 업데이트
                        preventInteractionOnTransition: true, // 전환 중 상호작용 방지 (문제 방지)

                        // 'on' 콜백은 대부분 디버깅 및 수동 너비 조정 코드였으므로 제거.
                        // Swiper의 observer/observeParents 옵션이 레이아웃 변경을 처리할 것으로 기대.
                    });
                }
            },
            initRallySwiper() {
                if (this.latestRallies.length > 0) {
                    if (this.rallySwiperInstance) {
                        this.rallySwiperInstance.destroy(true, true);
                    }

                    const swiperEl = document.querySelector('.rallySwiper');
                    if (!swiperEl) {
                        console.error("Rally Swiper container '.rallySwiper' not found.");
                        return;
                    }

                    this.rallySwiperInstance = new Swiper(swiperEl, {
                        loop: true,
                        autoplay: {
                            delay: 3000,
                            disableOnInteraction: false,
                        },
                        pagination: {
                            el: '.swiper-pagination',
                            clickable: true,
                        },
                        navigation: { // 네비게이션 버튼 추가
                            nextEl: '.swiper-button-next',
                            prevEl: '.swiper-button-prev',
                        },
                        // ★★★ 가장 중요한 부분: 슬라이드 개수와 간격 조정 ★★★
                        slidesPerView: 4,           // 한 번에 4개 슬라이드 표시
                        spaceBetween: 30,           // 슬라이드 간 간격 30px (product-list의 gap과 유사하게)
                        
                        centeredSlides: false,
                        slidesPerGroup: 1, // 한 번에 한 개의 슬라이드 그룹 이동
                        watchOverflow: true,
                        observer: true,
                        observeParents: true,
                        preventInteractionOnTransition: true,
                        
                        // 반응형 설정 추가 (선택 사항)
                        breakpoints: {
                            // 0px (모든 화면) 부터 적용되는 기본값은 위에 slidesPerView: 4로 명시
                            // 480px 이상일 때 적용될 설정
                            480: { 
                                slidesPerView: 1, 
                                spaceBetween: 10 
                            },
                            // 768px 이상일 때 적용될 설정
                            768: { 
                                slidesPerView: 2, 
                                spaceBetween: 20 
                            },
                            // 1024px 이상일 때 적용될 설정 (선택적 추가)
                            1024: { 
                                slidesPerView: 3, 
                                spaceBetween: 25 
                            },
                            // 1200px 이상일 때 적용될 설정 (선택적 추가, 여기서는 4개 슬라이드가 목적)
                            1200: { 
                                slidesPerView: 4, 
                                spaceBetween: 30 
                            }
                        },
                        on: {
                            init: function(swiper) { // ★★★ 이 부분이 이번엔 반드시 호출되어야 합니다 ★★★
                                console.log("Rally Swiper: 'init' event fired.");
                                console.log("Rally Swiper: Actual slidesPerView param:", swiper.params.slidesPerView);
                                console.log("Rally Swiper: Actual spaceBetween param:", swiper.params.spaceBetween);
                                if (swiper.slides.length > 0) {
                                    console.log("Rally Swiper: First slide's offsetWidth:", swiper.slides[0].offsetWidth);
                                }
                            },
                        }
                    });
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
                        self.sessionName = data.properties.nickname;
                        // ✅ Remove the ?code=... from the URL (no reload)
                        window.history.replaceState({}, document.title, '/home.do');
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