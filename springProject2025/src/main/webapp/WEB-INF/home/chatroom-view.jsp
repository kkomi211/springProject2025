<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/chat-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Community</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <style>



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
                                <input type="text" placeholder="검색어를 입력해 주세요.">
                            </div>
                            <div>
                                <a href="/home/login.do">로그인</a>
                            </div>
                            <div>
                                <a href="/home/signup.do">가입하기</a>
                            </div>
                            <div><a href="/home/mypage/inquiry.do">문의</a></div>
                            <div><a href="/home/cart.do">장바구니</a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <div>
                            <a href="/home/product.do">제품</a>
                        </div>
                        <div>
                            <a href="/home/product.do">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header>

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
                                        <a href="#">게시판</a>
                                    </li>
                                    <li @click="">
                                        <span class="icon">📦</span>
                                        <a href="javascript:;">크루 찾기</a>
                                    </li>
                                    <li>
                                        <span class="icon">💬</span>
                                        <a href="#">대회정보</a>
                                    </li>
                                    <li class="active" @click="fnChat">
                                        <span class="icon">👤</span>
                                        <a href="javascript:;">채팅방</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>
                        <main class="main-content">
                            <div class="board-header">
                                <h1 class="main-title">
                                    {{chatInfo.name}} 채팅방
                                </h1>
                            </div>
                            <div id="chatBox">
                                <div v-for="item in messageList" class="margin30">
                                    <a class="bold">{{item.nickname}}</a> : 
                                    {{item.message}}
                                    <button class="red" v-if="item.senderId == sessionId || sessionId == ownerId" @click="fndeleteMessage(item.chatId)">삭제</button>
                                    <div class="text-right">{{item.cdate}}</div>
                                </div>
                            </div>
                            <input type="text" id="message" placeholder="메시지를 입력하세요..."
                                @keyup.enter="sendMessage">
                            <button @click="sendMessage">전송</button>
                            <div>
                                <button class="margin30" @click="fnChat">돌아가기</button>
                                <button class="margin30" @click="fnDeleteMember(sessionId)">탈퇴하기</button>
                            </div>
                        </main>
                        <aside class="sidebar" v-if="!directFlg">
                            <h2 class="sidebar-heading"> 채팅방 유저 목록</h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li v-for="item in memberList">
                                        <a :class="{bold: item.userId == ownerId}" @click="fnDirectChat(item.userId)">{{item.nickname}}</a>
                                        <button class="red" v-if="sessionId == ownerId && item.userId != ownerId" @click="fnDeleteMember(item.userId)">x</button>
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
                            <span>회사소개</span>
                            <span>매장안내</span>
                            <span>공지사항</span>
                            <span>이용약관</span>
                            <span>개인정보처리방침</span>
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
                    messageList : [],
                    memberList : [],
                    ownerId : "",
                    directFlg : false
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
                            if(self.chatInfo.roomType == 'DIRECT'){
                                self.directFlg = true;
                            }
                        }
                    });
                },
                fnMessageList(){
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
                    // if (self.stompClient && messageContent.trim() !== "") {
                    //     let chatMessage = { content: messageContent };
                    //     self.stompClient.send('/app/sendMessage', {}, JSON.stringify(chatMessage));
                    //     document.getElementById("message").value = "";
                    // }

                    let param = {
                        chatroomNo: self.chatroomNo,
                        senderId : self.sessionId,
                        message : messageContent
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
                fndeleteMessage(chatId){
                    let self = this;
                    let chatBox = document.getElementById("chatBox");
                    let messageContent = document.getElementById("message").value;

                    let param = {
                        chatId : chatId
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
                fnMemberList(){
                    let self = this;
                    let param = {
                        chatroomNo : self.chatroomNo
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
                fnDeleteMember(userId){
                    let self = this;
                    let param = {
                        userId : userId,
                        chatroomNo : self.chatroomNo
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
                        }
                    });
                },
                fnDirectChat(userId){
                    let self = this;
                    if(userId == self.sessionId){
                        return;
                    }
                    if(!confirm("1ㄷ1 채팅을 하시겠습니까?")){
                        return
                    }
                    let param = {
                        userId : userId,
                        sessionId : self.sessionId
                    }
                    $.ajax({
                        url: "/home/mypage/member/chat.dox",
                        dataType: "json",
                        type: "POST",
                        data: param, 
                        success: function (data) {
                            console.log(data);
                            if(data.result != "fail"){
                                pageChange("/home/community/chat/show.do", {sessionId : self.sessionId, chatroomNo: data.chatroomNo});
                            }
                        }
                    });
                }
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
            }
        });

        app.mount('#app');
    </script>