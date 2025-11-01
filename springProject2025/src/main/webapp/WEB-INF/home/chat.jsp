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
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
                        <a href="/home/login.do">로그인</a></div>
                    <div>
                        <a href="/home/signup.do">가입하기</a></div>
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
                                    <li class="active"  @click="fnChat">
                                        <span class="icon">👤</span>
                                        <a href="javascript:;">채팅방</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>
                        <main class="main-content">
                            <div class="board-header">
                                <h1 class="main-title">
                                    나의 채팅방
                                </h1>
                                <div class="search-bar">
                                    <div class="search-wrapper">
                                        <input type="text" placeholder="검색어" v-model="keyword">
                                        <button class="search-btn">🔍</button>
                                    </div>
                                </div>
                            </div>
                            <table>
                                <tr>
                                    <th>채팅방이름</th>
                                    <th>생성날짜</th>
                                </tr>
                                <tr v-for="item in chatList" @click="fnShowChat(item.chatroomNo)">
                                    <td>{{item.name}}</td>
                                    <td>{{item.cdate}}</td>
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
                sessionId : "${sessionId}",
                userName : "",
                keyword : "",
                chatList : [],
                
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
            fnChat(){
                let self = this;
                pageChange("/home/community/chat.do", {sessionId : self.sessionId});
            },
            fnGetUserChatList(){
                let self = this;
                let param = {
                    userId : self.sessionId
                }
                $.ajax({
                    url: "/home/mypage/chatroom/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.chatList = data.chatlist;
                        
                    }
                });
            },
            fnShowChat(chatroomNo){
               let self = this;
               pageChange("/home/community/chat/show.do", {sessionId : self.sessionId, chatroomNo: chatroomNo});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetUserInfo();
            self.fnGetUserChatList();
        }
    });

    app.mount('#app');
</script>
