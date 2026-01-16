<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/crew-style.css">
        <link rel="stylesheet" href="/css/board-style.css">
        <link rel="stylesheet" href="/css/modal-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <script src="/js/page-change.js"></script>
        <title>커뮤니티 게시판</title>

        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <!-- session timeout modal -->
        <script src="/js/session-timeout.js"></script>

        <style>
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

            /* Main Hero Slider styles (메인 상단 배너) */
            .main-hero-slider .crew-overlay-text {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 5em;
                font-weight: 600;
                color: #fff;
                text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
                letter-spacing: 0.2em;
                text-align: center;
                white-space: nowrap;
                z-index: 10;
            }

            .main-hero-slider img {
                width: 100%;
                height: 400px;
                /* adjust to your design */
                object-fit: cover;
            }

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
                height: 300px;
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

            /* ========== 사이드바 메뉴 NEW 배지 스타일 ========== */
            .mypage-menu li {
                position: relative;
            }

            .sidebar-new-badge {
                display: inline-block;
                background: linear-gradient(135deg, #ff4444, #ff6b6b);
                color: white;
                padding: 2px 8px;
                border-radius: 10px;
                font-size: 0.7em;
                font-weight: bold;
                margin-left: 8px;
                box-shadow: 0 2px 6px rgba(255, 68, 68, 0.5);
                animation: badgePulse 2s infinite;
                vertical-align: middle;
            }

            @keyframes badgePulse {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.1);
                }
            }

            /* ========== 크루 목록 NEW 배지 스타일 ========== */
            .new-crew-badge {
                display: inline-block;
                background: linear-gradient(135deg, #ff4444, #ff6b6b);
                color: white;
                padding: 2px 8px;
                border-radius: 10px;
                font-size: 0.75em;
                font-weight: bold;
                margin-left: 6px;
                box-shadow: 0 2px 6px rgba(255, 68, 68, 0.5);
                animation: pulse 2s infinite;
                vertical-align: middle;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                    box-shadow: 0 2px 8px rgba(255, 68, 68, 0.4);
                }

                50% {
                    transform: scale(1.05);
                    box-shadow: 0 4px 12px rgba(255, 68, 68, 0.6);
                }
            }

            /* 신규 크루 행 강조 */
            table tr.new-crew {
                background-color: #fff5f5;
                border-left: 3px solid #ff6b6b;
            }

            table tr.new-crew:hover {
                background-color: #ffe8e8;
            }

            /* New CSS from homepage */

            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                color: #333;
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
                text-decoration: underline;
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

            .brand-name a:hover {
                text-decoration: none;
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
                color: white;
                /* default top-header의 글자색 */
            }

            #right-items div a:hover {
                color: #eee;
            }

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

            .bottom-header a:hover {
                text-decoration: none;
                transform: scale(1.1);
                transition: transform 0.3s ease-out;
                /* faster ease-out */
            }

            .bottom-header a {
                color: black;
                transition: transform 0.2s ease-in;
                /* slower ease-in */
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

            .bottom-header div:last-child {
                margin-right: 0;
            }

            .bottom-header a {
                color: black;
                /* default bottom-header 링크색 */
            }

            /* 
        .bottom-header a:hover {
            color: #007bff;
        } */

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

            .container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #fff;
            }

            main {
                flex: 1;
                /* makes main take up all remaining vertical space */
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
            }

            .modal-content {
                background: white;
                padding: 30px;
                border-radius: 8px;
                max-width: 500px;
                width: 90%;
                max-height: 80vh;
                overflow-y: auto;
            }

            .modal-content h2 {
                margin-top: 0;
                margin-bottom: 20px;
            }

            .modal-content .btn {
                margin-top: 10px;
                padding: 10px 20px;
                border-radius: 8px;
                background: #000;
                color: #fff;
                cursor: pointer;
                border: none;
            }

            .modal-content input.btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .modal-content table {
                width: 100%;
                border-collapse: collapse;
            }

            .modal-content table th,
            .modal-content table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .modal-content table th {
                background-color: #f5f5f5;
            }
        </style>
    </head>


    <body>
        <div id="app">
            <div class="container">
                <!--  상단 헤더 -->
                <%-- 공통 헤더 컴포넌트 --%>
                    <jsp:include page="/WEB-INF/header/header.jsp" />

                    <div class="main-hero-slider-area">
                        <section class="main-hero-slider">
                            <div class="swiper-container mySwiper">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">

                                        <img
                                            src="https://as2.ftcdn.net/v2/jpg/02/34/65/76/1000_F_234657662_jQjqcHFWIh3oVh9DTXAXzKAXVZ5Zf6ko.jpg">

                                    </div>
                                </div>
                                <div class="swiper-pagination"></div>
                            </div>
                            <span class="crew-overlay-text">COMMUNITY</span> <!-- 텍스트는 항상 보임, 중앙 위치 -->
                        </section>
                    </div>

                    <!--  본문 -->
                    <main>
                        <div class="header">
                            <div class="header-welcome">Welcome,</div>
                            <div class="header-user">{{ userName }}</div>
                        </div>

                        <div class="page-container">
                            <!--  왼쪽 사이드바 -->
                            <aside class="sidebar">
                                <h2 class="sidebar-heading"> COMMUNITY ></h2>
                                <nav class="mypage-menu">
                                    <ul>
                                        <li @click="moveToBoard">
                                            <span class="icon">📝</span>
                                            <a href="/home/community/board.do">게시판</a>
                                        </li>
                                        <li @click="moveToCrew" class="active">
                                            <span class="icon">📦</span>
                                            <a href="javascript:void(0)">
                                                크루 찾기
                                                <span v-if="hasNewCrew" class="sidebar-new-badge">NEW</span>
                                            </a>
                                        </li>
                                        <li @click="moveToRally">
                                            <span class="icon">💬</span>
                                            <a href="/home/community/rally.do">대회정보</a>
                                        </li>
                                        <li @click="moveToChat">
                                            <span class="icon">👤</span>
                                            <a href="/home/community/chat.do">채팅방</a>
                                        </li>
                                    </ul>
                                </nav>
                            </aside>

                            <!--  게시판 영역 -->
                            <main class="main-content">
                                <div class="board-header">
                                    <h1 class="main-title">
                                        크루 찾기
                                    </h1>

                                    <div class="search-bar">
                                        <div class="search-box">
                                            <input class="search" type="text" placeholder="검색어를 입력하세요" v-model="keyword"
                                                @keyup.enter="fnList">
                                            <a href="javascript:;" @click="fnBoardList">
                                                <div><i data-lucide="search" stroke-width="1.5"></i></div>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <table>
                                    <tr style="background-color: #f7f7f7;">
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>채팅방 소개</th>
                                        <th>채널</th>
                                    </tr>
                                    <tr v-for="item in list" :key="item.chatroomNo"
                                        :class="{ 'new-crew': isNewCrew(item.chatroomNo) }">
                                        <td>{{item.chatroomNo}}</td>
                                        <td>
                                            <!-- ★★★ 제목 클릭 시 멤버 모달 표시 ★★★ -->
                                            <a href="javascript:;" @click="fnShowMembers(item.chatroomNo)">
                                                {{item.title}}
                                                <span v-if="item.pwd && item.pwd > 0" title="비밀글 🔒">🔒</span>
                                                <span v-if="isNewCrew(item.chatroomNo)"
                                                    class="new-crew-badge">NEW</span>
                                            </a>
                                        </td>
                                        <td>{{item.intro}}</td>
                                        <td class="entry-btn-cell">
                                            <button class="entry-btn" @click="fnEnterChat(item.chatroomNo)"
                                                style="padding: 5px 25px; border-radius: 8px; background: #000; color: #fff; cursor: pointer; border: none;">
                                                입장하기
                                            </button>
                                        </td>
                                    </tr>
                                </table>

                                <!-- ★★★ 멤버 목록 모달 추가 ★★★ -->
                                <div v-if="showMembersModal" class="modal-overlay"
                                    @click.self="showMembersModal = false">
                                    <div class="modal-content">
                                        <h2>채팅방 멤버 목록</h2>
                                        <div style="max-height: 400px; overflow-y: auto; margin: 20px 0;">
                                            <table>
                                                <tr>
                                                    <th>역할</th>
                                                    <th>아이디</th>
                                                </tr>
                                                <tr v-for="member in memberList" :key="member.userId">
                                                    <td>{{ member.memberRole === 'O' ? '👑 크루장' : '멤버' }}</td>
                                                    <td>{{ member.userId }}</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div>
                                            <button class="btn" @click="showMembersModal = false">닫기</button>
                                        </div>
                                    </div>
                                </div>

                                <div v-if="index > 0" class="pagination">
                                    <a v-if="page != 1" @click="fnMove(page - 1)" href="javascript:void(0)">◀</a>
                                    <a @click="fnMove(num)" id="index" href="javascript:void(0)" v-for="num in index"
                                        :key="num">
                                        <span :class="{ active: page == num }">{{ num }}</span>
                                    </a>
                                    <a v-if="page != index" @click="fnMove(page + 1)" href="javascript:void(0)">▶</a>
                                </div>

                                <div class="write-btn-wrapper">
                                    <button @click="moveToPost"
                                        style="padding: 12px; border-radius: 8px; background: #000; color: #fff; cursor: pointer;">크루
                                        생성</button>
                                </div>


                                <!--  비밀번호 모달 -->
                                <div v-if="pwdCorrect" class="modal-overlay">
                                    <div class="modal-content">
                                        <h2>비밀글로 보호된 게시물입니다.</h2>
                                        <p>비밀번호를 입력해야 내용을 확인할 수 있습니다.</p>
                                        <input class="btn" type="password" v-model="inputPwd" @keyup.enter="fnKeylock"
                                            placeholder="비밀번호 입력">
                                        <div>
                                            <button class="btn" @click="pwdCorrect = false">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </main>
                        </div>
                        <!-- session time out modal -->
                        <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>

                    </main>

                    <!--  푸터 -->
                    <footer>
                        <div class="footer-left">
                            <div class="company-info">
                                <div><strong>회사명:</strong> 러너스 하우스 주식회사</div>
                                <div><strong>대표:</strong> 김재</div>
                                <div><strong>사업자등록번호:</strong> 123-45-67890</div>
                                <div><strong>통신판매업 신고번호:</strong> 2025-서울-00987</div>
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
        </div>
        </div>

        <!-- crew.jsp의 스크립트 부분 전체 (기존 코드에 추가) -->

        <script>
            lucide.createIcons();
            const app = Vue.createApp({
                mixins: [sessionTimeoutMixin],
                data() {
                    return {
                        list: [],
                        userName: "",
                        keyword: "",
                        type: "",
                        totalCount: 0,
                        pageCount: 0,
                        pwdCorrect: false,
                        inputPwd: "",
                        sessionId: "${sessionId}",
                        status: "${sessionStatus}",
                        chatroomNo: "",
                        cnt: 0,
                        page: 1,
                        pageSize: 10,
                        index: 0,
                        userType: '${userType}',
                        selectedPost: null,
                        cartCount: 0,
                        saleYN: '',
                        // NEW 배지 관련
                        hasNewCrew: false,
                        lastCheckedCrewNo: null,
                        // ★★★ 멤버 모달 관련 추가 ★★★
                        showMembersModal: false,
                        memberList: [],

                        newReplyCount: 0,  // 이 줄 추가

                    };
                },
                methods: {
                    fnList() {
                        let self = this;
                        const param = {
                            keyword: self.keyword,
                            type: self.type,
                            page: self.page,
                            pageSize: self.pageSize
                        };

                        $.ajax({
                            url: "/home/crew/board.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success(data) {
                                console.log(data);
                                if (data.result == "success") {
                                    self.list = data.list;
                                    self.cnt = data.cnt;
                                    self.index = Math.ceil(self.cnt / self.pageSize);
                                    self.checkNewCrew();
                                } else {
                                    console.log("오류");
                                }
                            }
                        });
                    },

                    fnGetUserInfo() {
                        let self = this;
                        $.ajax({
                            url: "/home/mypage/userInfo.dox",
                            dataType: "json",
                            type: "POST",
                            data: { userId: self.sessionId },
                            success(data) {
                                console.log("사용자 이름:", data);
                                self.userName = data;
                            },
                            error(xhr, status, error) {
                                console.error("사용자 정보 조회 실패:", error);
                                self.userName = "Guest";
                            }
                        });
                    },

                    fnMove(num) {
                        let self = this;
                        self.page = num;
                        self.fnList();
                    },

                    fnEnterChat(chatroomNo) {
                        let self = this;
                        self.updateLastCheckedCrew(chatroomNo);

                        $.ajax({
                            url: "/home/crew/chatMove.dox",
                            dataType: "json",
                            type: "POST",
                            data: {
                                userId: self.sessionId,
                                chatroomNo: chatroomNo
                            },
                            success(response) {
                                if (response.result == 'success') {
                                    location.href = "/home/community/chat/show.do?chatroomNo=" + chatroomNo;
                                } else {
                                    alert("채팅방 입장 실패: " + (response.message || "권한이 없거나 오류 발생"));
                                }
                            },
                            error(xhr, status, error) {
                                alert("서버 통신 중 오류가 발생했습니다.");
                                console.error(xhr.responseText);
                            }
                        });
                    },

                    //  멤버 목록 조회 메서드 - 배지 비활성화 추가 
                    fnShowMembers(chatroomNo) {
                        let self = this;

                        //  타이틀 클릭 시에도 크루 확인 처리 
                        self.updateLastCheckedCrew(chatroomNo);

                        console.log("fnShowMembers 호출 - chatroomNo:", chatroomNo);

                        $.ajax({
                            url: "/home/crew/members.dox",
                            dataType: "json",
                            type: "POST",
                            data: { chatroomNo: chatroomNo },
                            success(data) {
                                console.log("서버 응답:", data);
                                console.log("멤버 리스트:", data.memberList);

                                if (data.result === "success") {
                                    self.memberList = data.memberList;
                                    console.log("Vue memberList 설정됨:", self.memberList);
                                    self.showMembersModal = true;
                                } else {
                                    alert("멤버 목록을 불러올 수 없습니다.");
                                }
                            },
                            error(xhr, status, error) {
                                console.error("멤버 목록 조회 실패:", error);
                                console.error("응답 텍스트:", xhr.responseText);
                                alert("서버 오류가 발생했습니다.");
                            }
                        });
                    },

                    checkNewCrew() {
                        const self = this;
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");

                        if (self.list.length > 0) {
                            const latestCrewNo = self.list[0].chatroomNo;
                            console.log("최신 크루 번호:", latestCrewNo);
                            console.log("마지막 확인 크루 번호:", savedCrewNo);

                            if (!savedCrewNo || parseInt(latestCrewNo) > parseInt(savedCrewNo)) {
                                self.hasNewCrew = true;
                                console.log("NEW 배지 표시!");
                            } else {
                                self.hasNewCrew = false;
                            }
                        }
                    },

                    isNewCrew(chatroomNo) {
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");
                        if (!savedCrewNo) {
                            return true;
                        }
                        return parseInt(chatroomNo) > parseInt(savedCrewNo);
                    },

                    updateLastCheckedCrew(chatroomNo) {
                        let self = this;
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");

                        if (!savedCrewNo || parseInt(chatroomNo) > parseInt(savedCrewNo)) {
                            localStorage.setItem("lastCheckedCrewNo", chatroomNo);
                            console.log("크루 확인 완료, 저장된 번호:", chatroomNo);
                            self.checkNewCrew();
                        }
                    },

                    fnLogout() {
                        let self = this;
                        self.clearSessionTimers();
                        $.ajax({
                            url: "/member/logout.dox",
                            dataType: "json",
                            type: "POST",
                            data: {},
                            success(data) {
                                if (data.result == "success") {
                                    location.href = "/home.do";
                                }
                            }
                        });
                    },

                    fnKeylock() {
                        let self = this;
                        if (!self.selectedPost) return;

                        let param = {
                            boardNo: self.selectedPost.boardNo,
                            keylock: self.inputPwd
                        };

                        $.ajax({
                            url: "/board/keylock.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success(data) {
                                if (data.result === "success") {
                                    self.pwdCorrect = false;
                                    pageChange("board/view.do", { boardNo: self.selectedPost.boardNo });
                                } else if (data.result === "fail") {
                                    alert("비밀번호가 올바르지 않습니다.");
                                    self.inputPwd = "";
                                }
                            },
                            error(xhr, status, error) {
                                console.error("Keylock check failed:", error);
                            }
                        });
                    },

                    moveToBoard() {
                        pageChange("/home/community/board.do", {});
                    },

                    moveToCrew() {
                        let self = this;
                        if (self.list.length > 0) {
                            const latestCrewNo = self.list[0].chatroomNo;
                            self.updateLastCheckedCrew(latestCrewNo);
                        }
                        pageChange("/home/community/crew.do", {});
                    },

                    moveToRally() {
                        pageChange("/home/community/rally.do", {});
                    },

                    moveToChat() {
                        pageChange("/home/community/chat.do", {});
                    },

                    moveToPost() {
                        let self = this;
                        pageChange("/home/community/crew/post.do", { sessionId: self.sessionId });
                    },

                    fnNotice() {
                        pageChange("/home/community/board.do", { type: "B" });
                    },

                    fnPostView(chatroomNo) {
                        const post = this.list.find(i => i.chatroomNo === chatroomNo);
                        if (post && post.pwd) {
                            this.selectedPost = post;
                            this.pwdCorrect = true;
                        } else {
                            location.href = `/home/community/crew/view.do?chatroomNo=${chatroomNo}`;
                        }
                    },

                    fnSale() {
                        let self = this;
                        self.saleYN = 'Y';
                        pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                    },

                    fetchCartCount() {
                        if (this.sessionId == '' || this.sessionId == null) return;

                        let self = this;
                        $.ajax({
                            url: '/api/cartCount.dox',
                            method: 'GET',
                            data: {
                                sessionId: self.sessionId
                            },
                            dataType: 'json',
                            success: (response) => {
                                console.log("서버 응답 데이터:", response);
                                if (response.result === 'success') {
                                    self.cartCount = response.count;
                                }
                            },
                            error: (err) => {
                                console.error("AJAX 호출 중 오류 발생:", err);
                            }
                        });
                    },

                    // 새 답변 개수 체크 (localStorage 기반)
                    checkNewReplyCount: function () {
                        // alert("메롱");
                        let self = this;
                        if (!self.sessionId || self.sessionId === '') {
                            self.newReplyCount = 0;
                            return;
                        }

                        // localStorage에서 확인한 답변 목록 불러오기
                        const storageKey = `checkedReplies_${self.sessionId}`;
                        const saved = localStorage.getItem(storageKey);
                        let checkedReplies = [];
                        if (saved) {
                            try {
                                checkedReplies = JSON.parse(saved);
                            } catch (e) {
                                checkedReplies = [];
                            }
                        }

                        // 서버에서 답변 완료된 문의 목록 가져오기
                        $.ajax({
                            url: "/home/mypage/my-inquiry.dox",
                            dataType: "json",
                            type: "POST",
                            data: {
                                sessionId: self.sessionId,
                                page: 1,
                                pageSize: 1000 // 모든 문의 가져오기
                            },
                            success: function (data) {
                                if (data.result == "success" && data.list) {
                                    let uncheckedCount = 0;
                                    data.list.forEach(function (item) {
                                        if (item.status === 'Y' && !checkedReplies.includes(item.inquiryNo)) {
                                            uncheckedCount++;
                                        }
                                    });
                                    self.newReplyCount = uncheckedCount;
                                    console.log("새 답변 개수:", uncheckedCount);
                                } else {
                                    self.newReplyCount = 0;
                                }
                            },
                            error: function () {
                                self.newReplyCount = 0;
                            }
                        });
                    },

                },
                mounted() {
                    let self = this;
                    self.fnList();
                    self.fnGetUserInfo();

                    if (self.sessionId && self.sessionId !== '') {
                        console.log("장바구니 수량 조회를 시작합니다.");
                        self.fetchCartCount();
                        self.setupActivityListeners();
                        self.startSessionTimer();
                    } else {
                        console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                    }

                    self.checkNewReplyCount();      

                },
                beforeUnmount() {
                    let self = this;
                    self.removeActivityListeners();
                    self.clearSessionTimers();
                }
            });

            app.mount('#app');
        </script>
    </body>

    </html>