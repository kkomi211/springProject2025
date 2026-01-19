<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/chat-style.css">
        <link rel="stylesheet" href="/css/modal-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
        <title>Community</title>
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
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

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
                object-fit: cover;
            }

            .main-hero-slider-area {
                width: 100vw;
                position: relative;
                left: 50%;
                right: 50%;
                margin-left: -50vw;
                margin-right: -50vw;
                overflow: hidden;
                background-color: #f8f8f8;
                height: 300px;
            }

            .main-hero-slider {
                width: 100%;
                height: 100%;
                padding: 0;
                position: relative;
            }

            .main-hero-slider .swiper-container {
                width: 100%;
                height: 100%;
                margin: 0;
            }

            .main-hero-slider .swiper-slide {
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
            }

            .main-hero-slider .swiper-slide a {
                display: block;
                width: 100%;
                height: 100%;
            }

            .main-hero-slider .swiper-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                display: block;
            }

            .main-hero-slider .swiper-pagination {
                bottom: 30px !important;
                z-index: 10;
            }

            .main-hero-slider .swiper-pagination-bullet {
                background-color: #fff;
                opacity: 0.7;
                margin: 0 8px !important;
                width: 12px;
                height: 12px;
                transition: opacity 0.3s ease, background-color 0.3s ease;
            }

            .main-hero-slider .swiper-pagination-bullet-active {
                background-color: #007bff;
                opacity: 1;
            }

            .main-hero-slider-area .swiper-side-cover {
                display: none;
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

            /* ========== 채팅방 목록 NEW 배지 스타일 ========== */
            .new-chat-badge {
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

            /* 신규 채팅방 행 강조 */
            table tr.new-chatroom {
                background-color: #fff5f5;
                border-left: 3px solid #ff6b6b;
            }

            table tr.new-chatroom:hover {
                background-color: #ffe8e8;
            }

            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                color: #333;
            }

            #app {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            /* a:hover {
                text-decoration: underline;
            } */

            header {
                width: 100%;
                background-color: black;
                color: white;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .top-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 150px;
                padding: 0 40px;
                box-sizing: border-box;
            }

            .top-header div {
                display: inline-block;
                text-align: left;
                font-size: 15px;
                margin-right: 0;
            }

            .top-header input {
                height: 25px;
                border-radius: 8px;
                width: 200px;
            }

            .brand-name {
                margin-right: 0;
            }

            .brand-name div {
                font-family: 'Jost', sans-serif;
                font-size: 60px;
                font-weight: 900;
                letter-spacing: 3px;
                margin-left: 0;
                display: block;
                color: white;
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
            }

            #right-items div {
                font-size: 15px;
                white-space: nowrap;
            }

            #right-items div a {
                color: white;
            }

            #right-items div a:hover {
                color: #eee;
            }

            .bottom-header {
                display: flex;
                justify-content: center;
                font-size: 25px;
                background-color: white;
                border-bottom: 1px solid #eee;
                padding: 20px 0;
                letter-spacing: 3px;
            }

            .bottom-header div {
                display: inline-block;
                margin-right: 100px;
                margin-top: 0;
                text-align: center;
            }

            .bottom-header div:last-child {
                margin-right: 0;
            }

            .bottom-header div a:hover {
                text-decoration: none;
            }

            .bottom-header a:hover {
                transform: scale(1.1);
                transition: transform 0.3s ease-out;
            }

            .bottom-header a {
                color: black;
                transition: transform 0.2s ease-in;
                display: inline-block;
            }

            footer {
                width: 100%;
                height: 200px;
                background-color: black;
                color: white;
                align-items: center;
                display: flex;
                justify-content: space-between;
                font-size: 12px;
                padding: 0 40px;
                box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
                margin-top: auto;
                box-sizing: border-box;
            }

            .footer-left {
                margin-left: 0;
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

            /* 기본 폰트 및 레이아웃 채팅 리스트와 통일 */
            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: 'Inter', 'Jost', Arial, sans-serif;
                /* Jost 폰트 우선 적용 */
                color: #333;
            }

            #app {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* 히어로 섹션 텍스트 스타일 통일 */
            .main-hero-slider .crew-overlay-text {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-family: 'Jost', sans-serif;
                font-size: 5em;
                font-weight: 900;
                /* 600에서 900으로 상향 */
                color: #fff;
                text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
                letter-spacing: 0.2em;
                z-index: 10;
            }

            /* 사이드바 및 헤더 유저 정보 글씨체 통일 */
            /* .header-user {
                font-family: 'Jost', sans-serif;
                font-weight: 700;
                font-size: 1.2em;
            } */

            /* 테이블 디자인 채팅 리스트와 일치화 */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table th {
                font-family: 'Jost', sans-serif;
                font-weight: 600;
                padding: 15px;
                border-bottom: 2px solid #000;
                /* 채팅 리스트 스타일의 강조선 */
                text-align: left;
            }

            table td {
                padding: 15px;
                border-bottom: 1px solid #eee;
                font-size: 0.95em;
            }

            /* NEW 배지 스타일 채팅 리스트와 완벽 일치 */
            .sidebar-new-badge,
            .new-crew-badge {
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

            /* 행 하이라이트 효과 통일 */
            table tr.new-crew {
                background-color: #fff5f5;
                border-left: 4px solid #ff6b6b;
            }

            table tr:hover {
                background-color: #f9f9f9;
                cursor: pointer;
            }

            /* 버튼 디자인 채팅 리스트 스타일로 깔끔하게 수정 */
            .entry-btn {
                padding: 8px 20px;
                border-radius: 20px;
                /* 더 둥글게 */
                background: #000;
                color: #fff;
                font-family: 'Jost', sans-serif;
                font-weight: 500;
                border: none;
                transition: all 0.3s ease;
            }

            .entry-btn:hover {
                background: #333;
                transform: translateY(-2px);
            }

            .write-btn-wrapper button {
                font-family: 'Jost', sans-serif;
                font-weight: 600;
                letter-spacing: 1px;
            }

            /* 검색바 전체 레이아웃 (우측 정렬 및 여백) */
            .search-bar {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
                /* 테이블과의 간격 */
            }

            /* 검색 박스 디자인 (둥근 테두리 및 내부 레이아웃) */
            .search-box {
                display: flex;
                align-items: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                /* 타원형(25px)에서 네모(4px)로 변경 */
                padding: 2px 10px;
                /* 내부 여백 최적화 */
                background: #fff;
                height: 40px;
                /* 크루 찾기 페이지와 높이 통일 */
                box-sizing: border-box;
            }

            .search-box:focus-within {
                border-color: #000;
                /* 포커스 시 테두리 강조 */
            }

            /* 입력창 스타일 */
            .search-box input.search {
                border: none !important;
                /* 기존 스타일 무력화 */
                outline: none !important;
                padding: 8px;
                width: 250px;
                font-family: 'Jost', sans-serif;
                font-size: 14px;
            }

            /* 돋보기 아이콘 영역 */
            .search-box a div {
                display: flex;
                align-items: center;
                justify-content: center;
                color: #333;
            }

            .search-box a:hover {
                text-decoration: none;
                /* 아이콘 호버 시 밑줄 방지 */
            }
        </style>
    </head>

    <body>
        <div id="app">
            <div class="container">
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
                            <span class="crew-overlay-text">COMMUNITY</span>
                        </section>
                    </div>

                    <main>
                        <div class="header">
                            <div class="header-welcome">
                                Welcome,
                            </div>
                            <div class="header-user">
                                {{ userName }}
                            </div>
                        </div>
                        <div class="page-container">
                            <aside class="sidebar">
                                <h2 class="sidebar-heading"> COMMUNITY ></h2>
                                <nav class="mypage-menu">
                                    <ul>
                                        <li @click="moveToBoard">
                                            <!-- <span class="icon">📝</span> -->
                                            <span class="material-symbols-outlined icon"> forum </span>
                                            <a href="/home/community/board.do">게시판</a>
                                        </li>
                                        <li @click="moveToCrew">
                                            <!-- <span class="icon">📦</span> -->
                                            <span class="material-symbols-outlined icon"> groups </span>
                                            <a href="/home/community/crew.do">크루 찾기</a>
                                        </li>
                                        <li @click="moveToRally">
                                            <!-- <span class="icon">💬</span> -->
                                            <span class="material-symbols-outlined icon"> event </span>
                                            <a href="/home/community/rally.do">대회정보</a>
                                        </li>
                                        <li @click="moveToChat" class="active">
                                            <!-- <span class="icon">👤</span> -->
                                            <span class="material-symbols-outlined icon"> mobile_chat </span>
                                            <a href="/home/community/chat.do">채팅방</a>
                                        </li>
                                    </ul>
                                </nav>
                            </aside>
                            <main class="main-content">
                                <div class="board-header">
                                    <h1 class="main-title">나의 채팅방</h1>

                                    <div class="search-bar">
                                        <div class="search-box">
                                            <input class="search" type="text" placeholder="채팅방 제목을 입력하세요"
                                                v-model="keyword" @keyup.enter="fnSearchChat">
                                            <a href="javascript:;" @click="fnSearchChat">
                                                <div><i data-lucide="search" stroke-width="1.5"></i></div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <table>
                                    <tr style="background-color: #f7f7f7;">
                                        <th>채팅방이름</th>
                                        <th>최근활동날짜</th>
                                    </tr>
                                    <tr v-for="item in chatList" @click="fnShowChat(item.chatroomNo)"
                                        :class="{ 'new-chatroom': isNewChatroom(item.chatroomNo) }">
                                        <td class="post-title">
                                            {{item.name}}
                                            <span v-if="isNewChatroom(item.chatroomNo)"
                                                class="new-chat-badge">NEW</span>
                                        </td>
                                        <td>{{item.udate.split(' ')[0]}}</td>
                                    </tr>
                                </table>
                            </main>
                        </div>
                    </main>

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
                    <!-- session time out modal -->
                    <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>
            </div>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
            data() {
                return {
                    sessionId: "${sessionId}",
                    userName: "",
                    keyword: "",
                    chatList: [],
                    userType: "${userType}",
                    newReplyCount: 0, // 새 답변 개수

                    // NEW 배지 관련
                    hasNewChatroom: false,
                    checkedChatrooms: [] // 확인한 채팅방 목록
                };
            },
            methods: {
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
                fnChat() {
                    let self = this;
                    pageChange("/home/community/chat.do", { sessionId: self.sessionId });
                },
                fnGetUserChatList() {
                    let self = this;
                    let param = {
                        userId: self.sessionId
                    }
                    $.ajax({
                        url: "/home/mypage/chatroom/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.chatList = data.chatlist;

                            // 확인한 채팅방 목록 로드
                            self.loadCheckedChatrooms();

                            // NEW 채팅방 체크
                            self.checkNewChatroom();
                        }
                    });
                },

                // localStorage에서 확인한 채팅방 목록 불러오기
                loadCheckedChatrooms() {
                    const self = this;
                    const storageKey = `checkedChatrooms_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);

                    if (saved) {
                        try {
                            self.checkedChatrooms = JSON.parse(saved);
                            console.log("확인한 채팅방 목록:", self.checkedChatrooms);
                        } catch (e) {
                            self.checkedChatrooms = [];
                        }
                    } else {
                        self.checkedChatrooms = [];
                    }
                },

                // 확인한 채팅방 목록 저장
                saveCheckedChatrooms() {
                    const self = this;
                    const storageKey = `checkedChatrooms_${self.sessionId}`;
                    localStorage.setItem(storageKey, JSON.stringify(self.checkedChatrooms));
                    console.log("확인한 채팅방 저장 완료:", self.checkedChatrooms);
                },

                // 신규 채팅방 체크 (24시간 이내 생성 + 확인하지 않은 채팅방)
                checkNewChatroom() {
                    const self = this;

                    if (self.chatList.length === 0) {
                        self.hasNewChatroom = false;
                        return;
                    }

                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);

                    // 24시간 이내 생성되고 확인하지 않은 채팅방이 있는지 체크
                    const hasNew = self.chatList.some(chat => {
                        const chatDate = new Date(chat.cdate);
                        const isRecent = chatDate > oneDayAgo;
                        const isNotChecked = !self.checkedChatrooms.includes(chat.chatroomNo);

                        return isRecent && isNotChecked;
                    });

                    self.hasNewChatroom = hasNew;
                    console.log("NEW 배지 표시 여부:", hasNew);
                },

                // 개별 채팅방이 신규인지 체크 (24시간 이내 생성 + 확인하지 않음)
                isNewChatroom(chatroomNo) {
                    const self = this;

                    // 이미 확인한 채팅방이면 NEW 표시 안함
                    if (self.checkedChatrooms.includes(chatroomNo)) {
                        return false;
                    }

                    // 해당 채팅방 찾기
                    const chatroom = self.chatList.find(chat => chat.chatroomNo === chatroomNo);
                    if (!chatroom) {
                        return false;
                    }

                    // 24시간 이내에 생성되었는지 확인
                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);
                    const chatDate = new Date(chatroom.cdate);

                    return chatDate > oneDayAgo;
                },

                // 채팅방 클릭 시 확인 처리
                fnShowChat(chatroomNo) {
                    let self = this;

                    // 확인한 채팅방으로 표시
                    if (!self.checkedChatrooms.includes(chatroomNo)) {
                        self.checkedChatrooms.push(chatroomNo);
                        self.saveCheckedChatrooms();

                        // NEW 배지 상태 업데이트
                        self.checkNewChatroom();
                    }

                    pageChange("/home/community/chat/show.do", {
                        sessionId: self.sessionId,
                        chatroomNo: chatroomNo
                    });
                },

                // 사이드바 채팅방 메뉴 클릭 시 - 모든 채팅방 확인 처리
                moveToChat: function () {
                    let self = this;

                    // 현재 표시된 모든 채팅방을 확인 처리
                    self.chatList.forEach(chat => {
                        if (!self.checkedChatrooms.includes(chat.chatroomNo)) {
                            self.checkedChatrooms.push(chat.chatroomNo);
                        }
                    });

                    self.saveCheckedChatrooms();
                    self.hasNewChatroom = false;

                    // 페이지 이동
                    if (window.location.pathname === '/home/community/chat.do') {
                        location.reload();
                    } else {
                        pageChange("/home/community/chat.do", {});
                    }
                },

                fnCheckLogin() {
                    let self = this;
                    if (self.sessionId == "") {
                        alert("로그인해주세요!");
                        location.href = "/home/login.do";
                    }
                },
                fnLogout: function () {
                    let self = this;
                    self.clearSessionTimers();
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
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },
                moveToBoard: function () {
                    pageChange("/home/community/board.do", {});
                },
                moveToCrew: function () {
                    pageChange("/home/community/crew.do", {});
                },
                moveToRally: function () {
                    pageChange("/home/community/rally.do", {});
                },

                // 장바구니 수량을 서버에서 가져오는 함수
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
                fnSearchChat() {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        keyword: self.keyword
                    };

                    $.ajax({
                        url: "/home/mypage/chatroom/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            self.chatList = data.chatlist;
                            self.checkNewChatroom();
                            self.$nextTick(() => {
                                lucide.createIcons(); // 아이콘 재렌더링
                            });
                        }
                    });
                }

            },
            mounted() {
                let self = this;
                self.fnCheckLogin();
                self.fnGetUserInfo();
                self.fnGetUserChatList();

                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkNewReplyCount(); // 새 답변 개수 체크
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }

                // 주기적으로 새 답변 체크 (30초마다)
                setInterval(function () {
                    if (self.sessionId && self.sessionId !== '') {
                        self.checkNewReplyCount();
                    }
                }, 30000);
            },
            beforeUnmount() {
                let self = this;
                self.removeActivityListeners();
                self.clearSessionTimers();
            }
        });

        app.mount('#app');
    </script>