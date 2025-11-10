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

            button:hover {
                background-color: rgb(53, 54, 54);
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

            .bottom-header div {
                display: inline-block;
                margin-right: 100px;
                /* default bottom-header div의 마진 */
                margin-top: 0;
                /* flex-align으로 중앙 정렬 */
                text-align: center;
            }

            .bottom-header a:hover {
                text-decoration: none;
            }

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
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
                <header>
                    <div class="top-header">
                        <div class="brand-name">
                            <div><a href="/home.do">RUNNERS' HOUSE</a></div>
                        </div>
                        <div id="right-items">
                            <div>
                                <!-- <template > -->
                                <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i
                                            data-lucide="log-out" stroke-width="1.5"></i></a></div>
                                <!-- </template> -->
                                <!-- <template > -->
                                <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a>
                                </div>
                                <!-- </template> -->
                            </div>
                            <div v-if="sessionId == ''">
                                <a href="/home/signup.do"><i data-lucide="user-plus" stroke-width="1.5"></i></a>
                            </div>
                            <div v-if="sessionId != '' && userType != 'K'"><a href="/home/mypage/information.do"><i
                                        data-lucide="user" stroke-width="1.5"></i></a></div>
                            <div v-else-if="sessionId != '' && userType == 'K'"><a
                                    href="home/mypage/information/change.do"><i data-lucide="user"
                                        stroke-width="1.5"></i></a></div>
                            <div v-if="sessionId != ''"><a href="/home/cart.do"><i data-lucide="shopping-cart"
                                        stroke-width="1.5"></i></a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <div>
                            <a href="/home/product.do">제품</a>
                        </div>
                        <div>
                            <a href="javascript:;" @click="fnSale">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header>

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
                                    <li>
                                        <span class="icon">📝</span>
                                        <a href="/home/community/board.do">게시판</a>
                                    </li>
                                    <li>
                                        <span class="icon">📦</span>
                                        <a href="/home/community/crew.do">크루 찾기</a>
                                    </li>
                                    <li>
                                        <span class="icon">💬</span>
                                        <a href="/home/community/rally.do">대회정보</a>
                                    </li>
                                    <li class="active">
                                        <span class="icon">👤</span>
                                        <a href="/home/community/chat.do">채팅방</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>
                        <main class="main-content">
                            <div class="board-header">
                                <h1 class="main-title">
                                    {{chatInfo.name}} 채팅방
                                </h1>
                                <button v-if="ownerId == sessionId" class="redbutton" @click="fnDeleteChatRoom">채팅방
                                    삭제</button>
                            </div>
                            <div id="chatBox">
                                <div v-for="item in messageList" class="margin30">
                                    <a class="bold">{{item.nickname}}</a> :
                                    {{item.message}}
                                    <button class="red" v-if="item.senderId == sessionId || sessionId == ownerId"
                                        @click="fndeleteMessage(item.chatId)">삭제</button>
                                    <div class="text-right">{{item.cdate}}</div>
                                </div>
                                <div v-if="chatbotFlg" class="margin30">
                                    <button @click="fnRunRoute('서울')">서울</button>
                                    <button @click="fnRunRoute('인천')">인천</button>
                                    <button @click="fnRunRoute('부산')">부산</button>
                                    <button @click="fnRunRoute('대구')">대구</button>
                                    <button @click="fnRunRoute('대전')">대전</button>
                                    <button @click="fnRunRoute('광주')">광주</button>
                                    <button @click="fnRunRoute('울산')">울산</button>
                                    <button @click="fnRunRoute('경기도')">경기도</button>
                                    <button @click="fnRunRoute('충청도')">충청도</button>
                                    <button @click="fnRunRoute('경상도')">경상도</button>
                                    <button @click="fnRunRoute('전라도')">전라도</button>
                                    <button @click="fnRunRoute('강원도')">강원도</button>
                                    <button @click="fnRunRoute('제주도')">제주도</button>
                                    <div v-for="msg in messages" :class="['message', msg.type]" class="margin30">
                                        <a class="bold" v-if="msg.type == 'user'">사용자 : </a>
                                        <a class="bold" v-if="msg.type == 'bot'">코스추천봇 : </a>
                                        <a>{{ msg.text }}</a>
                                    </div>
                                </div>
                            </div>
                            <div class="button-box">
                                <input type="text" id="message" placeholder="/코스추천을 입력하면 코스추천봇이 나오고 /종료를 누르면 종료됩니다."
                                    @keyup.enter="sendMessage" class="chatInput">
                                <button @click="sendMessage">전송</button>
                            </div>
                            <div class="button-box">
                                <button class="margin30" @click="fnChat">돌아가기</button>
                                <button class="margin30 redbutton" @click="fnDeleteMember(sessionId)">탈퇴하기</button>
                            </div>
                        </main>
                        <aside class="sidebar" v-if="!directFlg">
                            <h2 class="sidebar-heading"> 채팅방 유저 목록</h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li v-for="item in memberList">
                                        <a :class="{bold: item.userId == ownerId}"
                                            @click="fnDirectChat(item.userId)">{{item.nickname}}</a>
                                        <button class="red" v-if="sessionId == ownerId && item.userId != ownerId"
                                            @click="fnDeleteMember(item.userId)">x</button>
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

                    userType: '${userType}',
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
                    $.ajax({
                        url: "/home/mypage/message/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.messageList = data.messagelist;
                            chatBox.scrollTop = chatBox.scrollHeight;
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
                            console.log(data);
                            self.memberList = data.memberList;
                            self.ownerId = data.owner.userId;
                        }
                    });
                },
                fnDeleteMember(userId) {
                    let self = this;
                    let param = {
                        userId: userId,
                        chatroomNo: self.chatroomNo
                    }
                    $.ajax({
                        url: "/home/mypage/member/delete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            alert("삭제되었습니다!");
                            self.fnMemberList();
                            if (userId == self.sessionId) {
                                self.fnChat();
                            }
                        }
                    });
                },
                fnDirectChat(userId) {
                    let self = this;
                    if (userId == self.sessionId) {
                        return;
                    }
                    if (!confirm("1ㄷ1 채팅을 하시겠습니까?")) {
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
                    let self = this;
                    if (!confirm("정말 삭제하시겠습니까?")) {
                        return;
                    }
                    let param = {
                        chatroomNo: self.chatroomNo
                    };
                    $.ajax({
                        url: "/home/mypage/chat/delete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.fnChat();
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
            }
        });

        app.mount('#app');
    </script>