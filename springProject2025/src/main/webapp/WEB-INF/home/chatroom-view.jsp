<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/chat-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <title>Community</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <script src="/js/header-component.js"></script>

        <style>
            /* 기본 레이아웃 및 폰트 설정 */
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

            a {
                text-decoration: none;
                color: inherit;
            }

            a:hover {
                text-decoration: underline;
            }

            /* Header & Footer 공통 영역 */
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

            .top-header input {
                height: 25px;
                border-radius: 8px;
                width: 200px;
            }

            .brand-name div {
                font-family: 'Jost', sans-serif;
                font-size: 60px;
                font-weight: 900;
                letter-spacing: 3px;
                display: block;
                color: white;
            }

            #right-items {
                display: flex;
                align-items: center;
                gap: 20px;
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
                text-align: center;
            }

            .bottom-header a {
                color: black;
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

            /* 메인 배너 슬라이더 */
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
                position: relative;
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

            .main-hero-slider .swiper-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                display: block;
            }

            /* 채팅창 메인 컨테이너 (최하단 설정 기준) */
            #chatBox {
                flex: 1;
                overflow-y: auto;
                padding: 20px;
                background-color: #f3f2f2;
                /* 회색 배경 적용 */
                border-radius: 8px;
                display: flex;
                flex-direction: column;
                gap: 20px;
                height: 600px;
                width: 800px;
            }

            /* 날짜 구분선 */
            .date-divider {
                display: flex;
                justify-content: center;
                margin: 10px 0;
            }

            .date-label {
                background-color: rgba(0, 0, 0, 0.1);
                color: #fff;
                padding: 4px 15px;
                border-radius: 20px;
                font-size: 13px;
            }

            /* 메시지 그룹 레이아웃 */
            .message-group {
                display: flex;
                flex-direction: column;
                max-width: 85%;
            }

            .my-message {
                align-self: flex-end;
                align-items: flex-end;
            }

            .other-message {
                align-self: flex-start;
                align-items: flex-start;
            }

            .nickname-label {
                font-size: 13px;
                font-weight: bold;
                margin-bottom: 5px;
                color: #333;
            }

            .bubble-container {
                display: flex;
                align-items: flex-end;
                gap: 6px;
            }

            .my-message .bubble-container {
                flex-direction: row-reverse;
                /* 내 메시지는 시간이 왼쪽 */
            }

            /* 말풍선 디자인 */
            .chat-bubble {
                padding: 10px 14px;
                border-radius: 15px;
                font-size: 14px;
                line-height: 1.4;
                word-break: break-all;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);

                /* ★★★ 이 줄을 추가하세요! ★★★ */
                white-space: pre-wrap;
            }

            .my-message .chat-bubble {
                background-color: #DCCCFF;
                /* 연보라색 적용 */
                color: #000;
            }

            .other-message .chat-bubble {
                background-color: #fff;
                color: #000;
            }

            .time-label {
                font-size: 11px;
                color: #555;
                white-space: nowrap;
            }

            /* 버튼 및 기타 요소 */
            .bot-buttons {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(70px, 1fr));
                gap: 8px;
                margin-bottom: 15px;
                background: white;
                padding: 15px;
                border-radius: 12px;
                border: 1px dashed #007bff;
            }

            .bot-buttons button {
                background-color: #f0f7ff;
                border: 1px solid #b3d7ff;
                color: #0056b3;
                padding: 5px;
                border-radius: 6px;
                font-size: 12px;
                cursor: pointer;
            }

            button:hover {
                background-color: rgb(53, 54, 54);
            }

            .delete-link {
                font-size: 11px;
                color: #e74c3c;
                cursor: pointer;
                margin-top: 2px;
                text-decoration: none;
            }

            /* 드롭다운 메뉴 컨테이너 */
            .menu-container {
                position: relative;
                display: inline-block;
            }

            /* 드롭다운 박스 */
            .dropdown-menu {
                position: absolute;
                top: 100%;
                right: 0;
                width: 150px;
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                z-index: 100;
                display: flex;
                flex-direction: column;
                margin-top: 5px;
                overflow: hidden;
            }

            /* 메뉴 아이템 */
            .dropdown-item {
                padding: 10px 15px;
                font-size: 14px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
                text-align: left;
            }

            .dropdown-item:hover {
                background-color: #f7f9fc;
                color: #007bff;
                font-weight: bold;
            }

            .dropdown-item:last-child {
                border-bottom: none;
            }

            /* 방장 위임 모드일 때 사이드바 깜빡임 효과 */
            .transfer-mode li {
                border: 2px dashed #007bff;
                background-color: #e3f2fd;
                animation: blink 1.5s infinite;
            }

            @keyframes blink {
                50% {
                    border-color: transparent;
                }
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                /* 반투명 배경 */
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 2000;
            }

            .modal-content {
                background: white;
                padding: 30px 40px;
                /* 내부 여백 */
                border: 3px solid #555;
                /* 진한 회색 테두리 */
                border-radius: 30px;
                /* 둥근 모서리 */
                width: 400px;
                /* 너비 고정 */
                text-align: center;
                position: relative;
                box-shadow: none;
                /* 그림자 제거 */
            }

            /* 모달 메시지 (본문) */
            .modal-body {
                margin-bottom: 30px;
                font-size: 20px;
                /* 큰 글씨 */
                font-weight: bold;
                color: #333;
            }

            /* 입력창 스타일 (필요한 경우) */
            .modal-input {
                width: 100%;
                padding: 12px;
                border: 2px solid #555;
                border-radius: 15px;
                font-size: 16px;
                margin-top: 10px;
                box-sizing: border-box;
                text-align: center;
            }

            /* 버튼 영역 */
            .modal-actions {
                display: flex;
                justify-content: center;
                gap: 20px;
                /* 버튼 사이 간격 */
            }

            /* 공통 버튼 스타일 */
            .btn-modal {
                padding: 12px 40px;
                border-radius: 30px;
                /* 둥근 버튼 */
                border: 2px solid #555;
                background-color: #fff;
                color: #555;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                /* 부드러운 전환 효과 */
            }

            /* 마우스 오버 시 강조 효과 (검정 배경, 흰색 글씨) */
            .btn-modal:hover {
                background-color: #000;
                color: #fff;
                border-color: #000;
            }

            .modal-select {
                width: 100%;
                padding: 12px;
                border: 2px solid #555;
                border-radius: 15px;
                font-size: 16px;
                margin-top: 10px;
                box-sizing: border-box;
                text-align: center;
                background-color: #fff;
                cursor: pointer;
            }

            .modal-select:focus {
                outline: none;
                border-color: #007bff;
            }

            /* 유저 목록 아이템 (position 기준점) */
            .user-list-item {
                position: relative;
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }

            /* 유저 클릭 시 뜨는 드롭다운 메뉴 */
            .user-dropdown-menu {
                position: absolute;
                top: 100%;
                left: 0;
                /* 또는 right: 0 */
                width: 120px;
                background: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                z-index: 50;
                overflow: hidden;
            }

            .user-dropdown-item {
                padding: 8px 12px;
                font-size: 13px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
            }

            .user-dropdown-item:hover {
                background-color: #f7f9fc;
                color: #007bff;
            }

            .user-dropdown-item.delete {
                color: #e74c3c;
            }

            .user-dropdown-item.delete:hover {
                background-color: #fff5f5;
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
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .company-info div {
                margin-bottom: 5px;
                /* 줄 간격 */
            }

            .copyright {
                margin-top: 10px;
                color: #888;
                /* 약간 흐린 색상 */
            }

            .footer-right {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: flex-end;
                /* 오른쪽 정렬 */
                gap: 15px;
                /* 위아래 요소 간격 */
            }

            .other {
                display: flex;
                gap: 20px;
                /* 링크 사이 간격 */
            }

            .other span a {
                color: #ccc;
                text-decoration: none;
                cursor: pointer;
            }

            .other span a:hover {
                color: white;
                text-decoration: underline;
            }

            .socials {
                display: flex;
                gap: 15px;
                font-weight: bold;
                color: #ccc;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <%-- 공통 헤더 컴포넌트 --%>
                <jsp:include page="/WEB-INF/header/header.jsp" />
                <div class="container">
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
                                            <span class="icon">📝</span>
                                            <a href="/home/community/board.do">게시판</a>
                                        </li>
                                        <li @click="moveToCrew">
                                            <span class="icon">📦</span>
                                            <a href="/home/community/crew.do">크루 찾기</a>
                                        </li>
                                        <li @click="moveToRally">
                                            <span class="icon">💬</span>
                                            <a href="/home/community/rally.do">대회정보</a>
                                        </li>
                                        <li @click="moveToChat" class="active">
                                            <span class="icon">👤</span>
                                            <a href="/home/community/chat.do">채팅방</a>
                                        </li>
                                    </ul>
                                </nav>
                            </aside>
                            <main class="main-content">
                                <div class="board-header">
                                    <h1 class="main-title">
                                        {{chatInfo.name}} <span style="font-size: 0.5em; color: #666;">Chat Room</span>
                                    </h1>

                                    <div class="menu-container">
                                        <button class="icon-btn" @click.stop="toggleMenu" title="설정">
                                            <i data-lucide="align-justify"></i>
                                        </button>

                                        <div class="dropdown-menu" v-if="showMenu">
                                            <template v-if="ownerId == sessionId">
                                                <div class="dropdown-item" @click="fnUpdateChatName">방 이름 변경</div>
                                                <div class="dropdown-item" @click="fnTransferOwnerMode">방장 위임</div>
                                                <div class="dropdown-item" @click="fnDeleteChatRoom" style="color:red;">
                                                    방 삭제
                                                </div>
                                            </template>

                                            <template v-else>
                                                <div class="dropdown-item" @click="fnDeleteMember(sessionId)"
                                                    style="color:red;">채팅방 탈퇴</div>
                                            </template>
                                        </div>
                                    </div>
                                </div>

                                <div id="chatBox">
                                    <template v-for="(item, index) in messageList" :key="item.chatId">
                                        <div class="date-divider"
                                            v-if="index === 0 || (item.cdate.split(' ')[0] !== messageList[index-1].cdate.split(' ')[0])">
                                            <span class="date-label">{{ item.cdate.split(' ')[0] }}</span>
                                        </div>

                                        <div
                                            :class="['message-group', item.senderId == sessionId ? 'my-message' : 'other-message']">
                                            <div class="nickname-label" v-if="item.senderId != sessionId">{{
                                                item.nickname
                                                }}</div>

                                            <div class="bubble-container">
                                                <div class="chat-bubble">
                                                    {{ item.message }}
                                                </div>
                                                <div class="time-label">
                                                    {{ item.cdate.split(' ')[1].substring(0, 5) }}
                                                </div>
                                            </div>

                                            <a v-if="item.senderId == sessionId || sessionId == ownerId"
                                                class="delete-link" @click="fndeleteMessage(item.chatId)">삭제</a>
                                        </div>
                                    </template>

                                    <div v-if="chatbotFlg" class="bot-section"
                                        style="margin-top:20px; display: flex; flex-direction: column; width: 100%; gap: 20px;">
                                        <div class="date-divider"><span class="date-label">코스 추천 서비스</span></div>
                                        <div class="bot-buttons"
                                            style="display: flex; flex-wrap: wrap; gap: 5px; justify-content: center;">
                                            <button v-for="city in ['서울','인천','부산','대구','대전','광주','울산']"
                                                @click="fnRunRoute(city)"
                                                style="padding:5px 10px; border-radius:15px; border:none; background:#fff; cursor:pointer;">
                                                {{city}}
                                            </button>
                                        </div>
                                        <div v-for="msg in messages"
                                            :class="['message-group', msg.type == 'user' ? 'my-message' : 'other-message']">
                                            <div class="chat-bubble"
                                                :style="msg.type == 'bot' ? 'background:#e1f5fe' : ''">
                                                {{ msg.text }}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="button-box" style="display: flex; gap: 10px;">
                                    <input type="text" id="message" placeholder="메시지를 입력하세요... (/코스추천, /종료)"
                                        @keyup.enter="sendMessage" class="chatInput"
                                        style="flex: 1; padding: 12px; border-radius: 8px; border: 1px solid #ddd;">
                                    <button @click="sendMessage"
                                        style="padding: 0 25px; border-radius: 8px; background: #000; color: #fff; cursor: pointer;">전송</button>
                                </div>
                            </main>
                            <aside :class="['sidebar', { 'transfer-mode': isTransferring }]" v-if="!directFlg">
                                <h2 class="sidebar-heading">
                                    채팅방 유저 목록
                                    <span v-if="isTransferring" style="font-size:12px; color:red; display:block;">(위임할
                                        유저
                                        선택)</span>
                                </h2>
                                <nav class="mypage-menu">
                                    <ul>
                                        <li v-for="item in memberList" :key="item.userId" class="user-list-item">

                                            <a :class="{bold: item.userId == ownerId}"
                                                @click.stop="handleUserClick(item.userId)"
                                                style="cursor: pointer; flex-grow: 1;">
                                                {{item.nickname}}
                                                <span v-if="item.userId == ownerId" style="font-size:12px">👑</span>
                                            </a>

                                            <div v-if="activeUserMenu === item.userId" class="user-dropdown-menu">
                                                <div class="user-dropdown-item" @click.stop="fnDirectChat(item.userId)">
                                                    1:1
                                                    채팅</div>
                                                <div class="user-dropdown-item delete"
                                                    @click.stop="fnDeleteMember(item.userId)">강퇴하기</div>
                                            </div>

                                        </li>
                                    </ul>
                                </nav>
                            </aside>
                        </div>
                    </main>

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
                    <div class="modal-overlay" v-if="modal.show">
                        <div class="modal-content">
                            <div class="modal-title" v-if="modal.title"
                                style="font-weight:bold; font-size:18px; margin-bottom:10px;">
                                {{ modal.title }}
                            </div>
                            <div class="modal-body">
                                <div v-if="!modal.inputMode && !modal.selectMode">{{ modal.message }}</div>

                                <div v-else-if="modal.inputMode">
                                    <label style="display:block; margin-bottom:10px;">{{ modal.message }}</label>
                                    <input type="text" v-model="modal.inputValue" class="modal-input"
                                        @keyup.enter="modalConfirm" autofocus>
                                </div>

                                <div v-else-if="modal.selectMode">
                                    <label style="display:block; margin-bottom:10px;">{{ modal.message }}</label>
                                    <select v-model="modal.inputValue" class="modal-select">
                                        <option v-for="user in modal.options" :key="user.userId" :value="user.userId">
                                            {{ user.nickname }}
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="modal-actions">
                                <button class="btn-modal" @click="closeModal">{{ modal.cancelText || '뒤로가기' }}</button>
                                <button class="btn-modal" @click="modalConfirm">{{ modal.confirmText || '확인' }}</button>
                            </div>
                        </div>
                    </div>
                </div>

        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    userName: "",
                    keyword: "",
                    chatInfo: {},
                    chatroomNo: "${chatroomNo}",
                    stompClient: null,
                    messageList: [],
                    memberList: [],
                    ownerId: "",
                    directFlg: false,
                    chatbotFlg: false,
                    userInput: "",
                    messages: [],
                    showMenu: false,      // 메뉴 보임/숨김 상태
                    isTransferring: false, // 방장 위임 모드 상태
                    userType: '${userType}',
                    modal: {
                        show: false,
                        title: '',        // 제목 추가
                        message: '',
                        inputMode: false,
                        selectMode: false, // [NEW] 셀렉트 모드 플래그
                        options: [],       // [NEW] 셀렉트 박스 옵션 리스트
                        inputValue: '',
                        callback: null,
                        confirmText: '확인',
                        cancelText: '취소'
                    },
                    activeUserMenu: null
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
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
                        chatroomNo: self.chatroomNo
                    }
                    $.ajax({
                        url: "/home/mypage/chatroom/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.chatInfo = data.chatlist[0];
                            if (self.chatInfo.roomType == 'DIRECT') {
                                self.directFlg = true;
                            }
                        }
                    });
                },
                fnMessageList() {
                    let self = this;
                    let chatBox = document.getElementById("chatBox");
                    let param = {
                        chatroomNo: self.chatroomNo
                    }

                    // [추가] 현재 스크롤이 맨 아래인지 확인 (오차 범위 10px 허용)
                    let isAtBottom = false;
                    if (chatBox) {
                        isAtBottom = (chatBox.scrollTop + chatBox.clientHeight >= chatBox.scrollHeight - 10);
                    }

                    $.ajax({
                        url: "/home/mypage/message/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // 메시지 개수가 다를 때만 갱신하거나, Vue가 알아서 처리하므로 데이터만 교체
                            let oldLength = self.messageList.length;
                            self.messageList = data.messagelist;
                            let newLength = self.messageList.length;

                            // [수정] 스크롤 조건 처리
                            // 1. 새로운 메시지가 추가되었거나 (개수 증가)
                            // 2. 사용자가 이미 스크롤을 맨 아래에 두고 있었다면
                            // => 스크롤을 다시 맨 아래로 내림
                            if (newLength > oldLength || isAtBottom) {
                                self.$nextTick(() => {
                                    chatBox.scrollTop = chatBox.scrollHeight;
                                });
                            }
                        }
                    });
                },
                // WebSocket 연결 함수
                connect() {
                    let self = this;
                    let socket = new SockJS('/ws-chat'); // WebSocket 엔드포인트
                    self.stompClient = Stomp.over(socket);
                    self.stompClient.connect({}, function (frame) {
                        console.log("WebSocket 연결 성공: " + frame);

                        // 서버에서 메시지를 받을 구독 설정
                        self.stompClient.subscribe('/topic/public', function (message) {
                            self.showMessage(JSON.parse(message.body));
                        });
                    }, function (error) {
                        console.error("WebSocket 연결 실패: ", error);
                    });
                },
                // 메시지 전송 함수
                sendMessage() {
                    let self = this;
                    let chatBox = document.getElementById("chatBox");
                    let messageContent = document.getElementById("message").value;
                    if (messageContent == "/코스추천") {
                        chatBox.scrollTop = chatBox.scrollHeight;
                        self.chatbotFlg = true;
                        document.getElementById("message").value = "";
                        return;
                    }
                    if (messageContent == "/종료") {
                        chatBox.scrollTop = chatBox.scrollHeight;
                        self.chatbotFlg = false;
                        document.getElementById("message").value = "";
                        return;
                    }
                    // if (self.stompClient && messageContent.trim() !== "") {
                    //     let chatMessage = { content: messageContent };
                    //     self.stompClient.send('/app/sendMessage', {}, JSON.stringify(chatMessage));
                    //     document.getElementById("message").value = "";
                    // }

                    let param = {
                        chatroomNo: self.chatroomNo,
                        senderId: self.sessionId,
                        message: messageContent
                    }
                    $.ajax({
                        url: "/home/mypage/message/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);

                            document.getElementById("message").value = "";


                            let chatMessage = { content: "" };
                            self.stompClient.send('/app/sendMessage', {}, JSON.stringify(chatMessage));
                        }
                    });
                },
                fndeleteMessage(chatId) {
                    let self = this;
                    let chatBox = document.getElementById("chatBox");
                    let messageContent = document.getElementById("message").value;

                    let param = {
                        chatId: chatId
                    }
                    $.ajax({
                        url: "/home/mypage/message/delete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.fnMessageList();
                        }
                    });
                },

                // 메시지 출력 함수
                showMessage(message) {
                    let self = this;
                    self.fnMessageList();
                },
                fnMemberList() {
                    let self = this;
                    let param = {
                        chatroomNo: self.chatroomNo
                    }
                    $.ajax({
                        url: "/home/mypage/member/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("==>");

                            console.log(data);
                            self.memberList = data.memberList;
                            self.ownerId = data.owner.userId;
                        }
                    });
                },
                fnDeleteMember(userId) {
                    let isSelf = (userId == this.sessionId);
                    let msg = isSelf ? "정말 채팅방을 나가시겠습니까?" : "유저를 강퇴시키겠습니까?"; // 이미지 문구 적용
                    let confirmBtnText = isSelf ? "나가기" : "유저 강퇴"; // 이미지 버튼 텍스트 적용

                    this.openModal({
                        message: msg,
                        confirmText: confirmBtnText,
                        callback: () => {
                            let param = { userId: userId, chatroomNo: this.chatroomNo };
                            $.ajax({
                                url: "/home/mypage/member/delete.dox",
                                dataType: "json", type: "POST", data: param,
                                success: (data) => {
                                    if (isSelf) this.fnChat();
                                    else this.fnMemberList();
                                }
                            });
                        }
                    });
                },
                fnDirectChat(userId) {
                    let self = this;
                    if (userId == self.sessionId) {
                        return;
                    }
                    let param = {
                        userId: userId,
                        sessionId: self.sessionId
                    }
                    $.ajax({
                        url: "/home/mypage/member/chat.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result != "fail") {
                                pageChange("/home/community/chat/show.do", { sessionId: self.sessionId, chatroomNo: data.chatroomNo });
                            }
                        }
                    });
                },
                sendMessageChatbot() {
                    let chatBox = document.getElementById("chatBox");
                    this.messages.push({ text: this.userInput, type: 'user' });
                    let inputText = this.userInput;
                    this.userInput = "";
                    chatBox.scrollTop = chatBox.scrollHeight;

                    $.ajax({
                        url: "/gemini/chat",
                        type: "GET",
                        data: { input: inputText },
                        success: (response) => {
                            this.messages.push({ text: response, type: 'bot' });
                            chatBox.scrollTop = chatBox.scrollHeight;
                        },
                        error: (xhr) => {
                            this.messages.push({ text: "오류 발생: " + xhr.responseText, type: 'bot' });
                            chatBox.scrollTop = chatBox.scrollHeight;
                        }
                    });
                },
                fnRunRoute(local) {
                    let self = this;
                    self.userInput = local + "지역의 러닝코스 알려줘";
                    self.sendMessageChatbot();
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
                fnDeleteChatRoom() {
                    this.showMenu = false;
                    this.openModal({
                        message: '정말 방을 삭제하시겠습니까?\n모든 대화 내용이 사라집니다.',
                        confirmText: '방 삭제',
                        callback: () => {
                            let param = { chatroomNo: this.chatroomNo };
                            $.ajax({
                                url: "/home/mypage/chat/delete.dox",
                                dataType: "json", type: "POST", data: param,
                                success: (data) => {
                                    this.fnChat();
                                }
                            });
                        }
                    });
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
                toggleMenu() {
                    this.showMenu = !this.showMenu;
                },

                // [추가] 방 이름 변경
                fnUpdateChatName() {
                    this.showMenu = false;
                    this.openModal({
                        message: '새로운 방 이름을 입력해주세요.',
                        inputMode: true,
                        inputValue: this.chatInfo.name,
                        confirmText: '변경',
                        callback: (newName) => {
                            if (!newName || newName.trim() === "") return;
                            $.ajax({
                                url: "/home/mypage/chat/rename.dox",
                                type: "POST",
                                data: { chatroomNo: this.chatroomNo, name: newName },
                                success: (data) => {
                                    console.log("이름 변경");

                                    this.fnGetUserChatList(); // 정보 갱신
                                }
                            });
                        }
                    });
                },

                // [추가] 방장 위임 모드 시작
                fnTransferOwnerMode() {
                    this.showMenu = false;

                    // 나(방장)를 제외한 멤버 리스트 생성
                    let candidates = this.memberList.filter(member => member.userId !== this.sessionId);

                    if (candidates.length === 0) {
                        this.openModal({ message: '위임할 다른 유저가 없습니다.', confirmText: '확인', cancelText: '닫기' });
                        return;
                    }

                    // 모달 열기 (Select Mode)
                    this.openModal({
                        title: '방장 권한 위임',
                        message: '방장 권한을 넘길 유저를 선택하세요.',
                        selectMode: true,                 // 셀렉트 박스 활성화
                        options: candidates,              // 후보 리스트 전달
                        inputValue: candidates[0].userId, // 첫 번째 유저 기본 선택
                        confirmText: '위임하기',
                        callback: (targetUserId) => {
                            // AJAX 실행
                            $.ajax({
                                url: "/home/mypage/chat/transfer.dox",
                                type: "POST",
                                data: { chatroomNo: this.chatroomNo, newOwnerId: targetUserId },
                                success: (data) => {
                                    this.fnMemberList();
                                    this.fnGetUserChatList();
                                }
                            });
                        }
                    });
                },

                // [추가] 유저 클릭 핸들러 (위임 모드인지 1:1 채팅인지 구분)
                handleUserClick(targetUserId) {
                    if (targetUserId == this.sessionId) return; // 나 자신 클릭 무시

                    // 1. 내가 방장(Owner)인 경우 -> 드롭다운 메뉴 토글
                    if (this.sessionId == this.ownerId) {
                        if (this.activeUserMenu === targetUserId) {
                            this.activeUserMenu = null; // 이미 열려있으면 닫기
                        } else {
                            this.activeUserMenu = targetUserId; // 해당 유저 메뉴 열기
                        }
                    }
                    // 2. 일반 유저인 경우 -> 바로 1:1 채팅 모달 띄우기
                    else {
                        this.openModal({
                            message: '1:1 채팅을 하시겠습니까?',
                            confirmText: '채팅하기',
                            callback: () => {
                                this.fnDirectChat(targetUserId);
                            }
                        });
                    }
                },
                openModal(options) {
                    this.modal = {
                        show: true,
                        title: options.title || '',
                        message: options.message || '',
                        inputMode: options.inputMode || false,
                        selectMode: options.selectMode || false, // [NEW]
                        options: options.options || [],          // [NEW]
                        inputValue: options.inputValue || '',
                        callback: options.callback || null,
                        confirmText: options.confirmText || '확인',
                        cancelText: options.cancelText || '뒤로가기'
                    };

                    // 입력창 포커스
                    if (this.modal.inputMode) {
                        setTimeout(() => {
                            const input = document.querySelector('.modal-input');
                            if (input) input.focus();
                        }, 100);
                    }
                },
                // [추가] 모달 닫기
                closeModal() {
                    this.modal.show = false;
                },

                // [추가] 모달 확인 버튼 클릭 시 실행
                modalConfirm() {
                    if (this.modal.callback) {
                        this.modal.callback(this.modal.inputValue);
                    }
                    this.closeModal();
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

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.directFlg = false;
                self.fnGetUserInfo();
                self.fnGetUserChatList();
                self.fnMessageList();
                self.fnMemberList();
                self.connect();
                // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
                // --- 새로 추가: 3초마다 메시지 갱신 (사용자가 로그인해서 채팅방에 있을 때만 실행)
                // sessionId가 비어있지 않으면 폴링 시작
                if (self.sessionId && self.sessionId !== '') {
                    // 이미 타이머가 있으면 없애고 새로 설정
                    if (self.pollTimer) clearInterval(self.pollTimer);
                    self.pollTimer = setInterval(function () {
                        self.fnMessageList();
                    }, 3000); // 3000ms = 3초
                }

                // 페이지 닫거나 이동할 때 타이머 정리
                window.addEventListener('beforeunload', function () {
                    if (self.pollTimer) {
                        clearInterval(self.pollTimer);
                        self.pollTimer = null;
                    }
                });


                document.addEventListener('click', (e) => {
                    // 1. 상단 햄버거 메뉴 닫기
                    if (!e.target.closest('.menu-container')) {
                        this.showMenu = false;
                    }
                    // 2. [추가] 유저 목록 드롭다운 메뉴 닫기
                    if (!e.target.closest('.user-list-item')) {
                        this.activeUserMenu = null;
                    }
                });
            }
        });

        app.mount('#app');
    </script>