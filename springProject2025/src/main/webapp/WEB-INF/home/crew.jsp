<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/crew-style.css">
        <link rel="stylesheet" href="/css/board-style.css">
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
                                    <tr v-for="item in list" :class="{ 'new-crew': isNewCrew(item.chatroomNo) }">
                                        <td>{{item.chatroomNo}}</td>
                                        <td class="title-cell">
                                            <a href="javascript:;">
                                                <div class="title-row">
                                                    <span class="post-title">{{item.title}}</span>
                                                    <span v-if="item.pwd && item.pwd > 0" title="비밀글 🔒">🔒</span>
                                                    <span v-if="isNewCrew(item.chatroomNo)"
                                                        class="new-crew-badge">NEW</span>
                                                </div>
                                            </a>

                                        </td>
                                        <td>{{item.intro}}</td>
                                        <td class="entry-btn-cell">
                                            <button class="entry-btn" @click="fnEnterChat(item.chatroomNo)"
                                                style="padding: 50 25px; border-radius: 8px; background: #000; color: #fff; cursor: pointer;">입장하기</button>
                                        </td>
                                    </tr>

                                </table>

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
                                        style="padding: 10px; border-radius: 8px; background: #000; color: #fff; cursor: pointer;">크루
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

        <script>
            lucide.createIcons();
            const app = Vue.createApp({
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

                        // NEW 배지 관련
                        hasNewCrew: false,
                        lastCheckedCrewNo: null,

                        newReplyCount: 0 // 새 답변 개수
                    };
                },
                methods: {
                    fnList() {
                        let self = this;
                        const param = {
                            keyword: self.keyword,
                            type: self.type, // 추가
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
                                    console.log(data);
                                    self.list = data.list;
                                    self.cnt = data.cnt;
                                    self.index = Math.ceil(self.cnt / self.pageSize);

                                    // NEW 크루 체크
                                    self.checkNewCrew();
                                } else {
                                    console.log("오류");
                                }
                            }

                        });
                    },

                    // 신규 크루 체크
                    checkNewCrew() {
                        const self = this;

                        // localStorage에서 마지막 확인한 크루 번호 가져오기
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");

                        if (self.list.length > 0) {
                            const latestCrewNo = self.list[0].chatroomNo;

                            console.log("최신 크루 번호:", latestCrewNo);
                            console.log("마지막 확인 크루 번호:", savedCrewNo);

                            // 저장된 번호가 없거나, 최신 크루 번호가 더 크면 NEW 표시
                            if (!savedCrewNo || parseInt(latestCrewNo) > parseInt(savedCrewNo)) {
                                self.hasNewCrew = true;
                                console.log("NEW 배지 표시!");
                            } else {
                                self.hasNewCrew = false;
                            }
                        }
                    },

                    // 개별 크루가 신규인지 체크 (사용자가 확인하지 않은 크루)
                    isNewCrew(chatroomNo) {
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");

                        // 저장된 번호가 없으면 모든 크루가 신규
                        if (!savedCrewNo) {
                            return true;
                        }

                        // 현재 크루 번호가 저장된 번호보다 크면 신규
                        return parseInt(chatroomNo) > parseInt(savedCrewNo);
                    },

                    // 크루 확인 처리 (NEW 배지 업데이트)
                    updateLastCheckedCrew: function (chatroomNo) {
                        let self = this;
                        const savedCrewNo = localStorage.getItem("lastCheckedCrewNo");

                        // 현재 클릭한 크루가 저장된 번호보다 크면 업데이트
                        if (!savedCrewNo || parseInt(chatroomNo) > parseInt(savedCrewNo)) {
                            localStorage.setItem("lastCheckedCrewNo", chatroomNo);
                            console.log("크루 확인 완료, 저장된 번호:", chatroomNo);

                            // NEW 배지 상태 다시 체크
                            self.checkNewCrew();
                        }
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
                                    location.href = "/home.do";
                                }

                            }
                        })
                    },

                    fnGetUserInfo: function () {
                        let self = this;
                        $.ajax({
                            url: "/home/mypage/userInfo.dox",
                            dataType: "json",
                            type: "POST",
                            data: { userId: self.sessionId },
                            success: function (data) {
                                console.log("사용자 이름:", data);
                                self.userName = data;
                            },
                            error: function (xhr, status, error) {
                                console.error("사용자 정보 조회 실패:", error);
                                self.userName = "Guest";
                            }
                        });
                    },

                    fnMove: function (num) {
                        let self = this;
                        self.page = num;
                        self.fnList();
                    },

                    fnPage: function (num) {
                        let self = this;
                        self.page = num;
                        self.fnList();
                    },

                    // 프론트엔드 - 입장하기 버튼 클릭 시 JavaScript
                    fnEnterChat: function (chatroomNo) {
                        let self = this;

                        // 크루 확인 처리 (NEW 배지 업데이트)
                        self.updateLastCheckedCrew(chatroomNo);

                        $.ajax({
                            url: "/home/crew/chatMove.dox",
                            dataType: "json",
                            type: "POST",
                            data: {
                                userId: self.sessionId,
                                chatroomNo: chatroomNo
                            },
                            success: function (response) {
                                if (response.result == 'success') {
                                    location.href = "/home/community/chat/show.do?chatroomNo=" + chatroomNo;
                                } else {
                                    alert("채팅방 입장 실패: " + (response.message || "권한이 없거나 오류 발생"));
                                }
                            },
                            error: function (xhr, status, error) {
                                alert("서버 통신 중 오류가 발생했습니다. (500 에러 먼저 해결해야 합니다!)");
                                console.error(xhr.responseText);
                            }
                        });
                    },

                    // moveToCrew 메서드 수정 (카테고리 클릭 시)
                    moveToCrew: function () {
                        let self = this;

                        // 크루 페이지 방문 시, 현재 최신 크루를 확인한 것으로 처리
                        if (self.list.length > 0) {
                            const latestCrewNo = self.list[0].chatroomNo;
                            self.updateLastCheckedCrew(latestCrewNo);
                        }

                        pageChange("/home/community/crew.do", {});
                    },
                    fnNotice() {
                        let self = this;
                        pageChange("/home/community/board.do", { type: "B" });
                    },
                    moveToPost: function () {
                        let self = this;
                        pageChange("/home/community/crew/post.do", { sessionId: self.sessionId });
                    },
                    fnPostView: function (chatroomNo) {
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

                    fnKeylock: function () {
                        let self = this;
                        if (!self.selectedPost) return; // safety check

                        let param = {
                            boardNo: self.selectedPost.boardNo, // send the post ID
                            keylock: self.keylock               // send the password entered
                        };

                        $.ajax({
                            url: "/board/keylock.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success: function (data) {
                                if (data.result === "success") {
                                    // alert("Password correct");
                                    self.pwdCorrect = false; // close modal
                                    // redirect to the post
                                    pageChange("board/view.do", { boardNo: self.selectedPost.boardNo });
                                } else if (data.result === "fail") {
                                    alert("비밀번호가 올바르지 않습니다."); // wrong password
                                    document.querySelector("#keylock").focus();
                                    self.keylock = "";
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error("Keylock check failed:", error);
                            }
                        });
                    },
                    fnSale() {
                        let self = this;
                        self.saleYN = 'Y';
                        pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                    },
                    moveToBoard: function () {
                        let self = this;

                        pageChange("/home/community/board.do", {});
                    },
                    moveToCrew: function () {
                        let self = this;

                        pageChange("/home/community/crew.do", {});
                    },
                    moveToRally: function () {
                        let self = this;

                        pageChange("/home/community/rally.do", {});
                    },
                    moveToChat: function () {
                        let self = this;

                        pageChange("/home/community/chat.do", {});
                    },

                    // 장바구니 수량을 서버에서 가져오는 함수
                    fetchCartCount() {
                        // 세션 아이디가 없으면 실행하지 않음
                        if (this.sessionId == '' || this.sessionId == null) return;

                        let self = this;
                        $.ajax({
                            url: '/api/cartCount.dox',
                            method: 'GET',
                            // ★ 서버의 @RequestParam HashMap map으로 전달될 데이터 ★
                            data: {
                                sessionId: self.sessionId
                            },
                            dataType: 'json',
                            success: (response) => {
                                console.log("서버 응답 데이터:", response);
                                if (response.result === 'success') {
                                    self.cartCount = response.count; // 서버에서 보낸 count 값을 Vue 변수에 저장
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
                    self.fnGetUserInfo(); //유저정보가져오기

                    // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                    if (self.sessionId && self.sessionId !== '') {
                        console.log("장바구니 수량 조회를 시작합니다.");
                        self.fetchCartCount();
                    } else {
                        console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                    }

                    self.checkNewReplyCount();

                }
            });

            app.mount('#app');
        </script>
    </body>

    </html>