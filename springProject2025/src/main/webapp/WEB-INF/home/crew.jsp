<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/crew-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <script src="/js/page-change.js"></script>
        <title>커뮤니티 게시판</title>

        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <style>
             /* New CSS from homepage */
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
            /* border-bottom: 1px solid #eee; 하단 경계선 */
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
        </style>
    </head>

    <body>
        <div id="app">
            <div class="container">
                <!--  상단 헤더 -->
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
                            <div><a href="javascript:;" @click="fnSale">세일</a></div>
                            <div><a href="/home/community/board.do">커뮤니티</a></div>
                        </div>
                    </header>

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
                                        <li>
                                            <span class="icon">📝</span>
                                            <a href="/home/community/board.do">게시판</a>
                                        </li>
                                        <li class="active">
                                            <span class="icon">📦</span>
                                            <a href="/home/community/crew.do">크루 찾기</a>
                                        </li>
                                        <li>
                                            <span class="icon">💬</span>
                                            <a href="/home/community/rally.do">대회정보</a>
                                        </li>
                                        <li>
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
                                        게시판 •
                                        {{
                                        type === '' ? '전체 게시판' :
                                        type === 'B' ? '공지사항' :
                                        type === 'Q' ? '문의게시판' :
                                        type === 'F' ? '자유게시판' :
                                        type === 'R' ? '대회게시판' : '게시판'
                                        }}
                                    </h1>

                                    <div class="search-bar">
                                        <div class="search-wrapper">
                                            <select v-model="type" @change="fnList">
                                                <option value="">전체</option>
                                                <option value="B">공지사항</option>
                                                <option value="Q">문의게시판</option>
                                                <option value="F">자유게시판</option>
                                                <option value="R">대회게시판</option>
                                            </select>
                                            <input type="text" placeholder="검색어" v-model="keyword"
                                                @keyup.enter="fnList">
                                            <button class="search-btn" @click="fnList">🔍</button>
                                        </div>
                                    </div>
                                </div>

                                <table>
                                    <tr>
                                        <th>No</th>
                                        <th>제목</th>
                                        <th>채팅방 소개</th>
                                        <th>채널</th>
                                    </tr>
                                    <tr v-for="item in list">
                                        <td>{{item.chatroomNo}}</td>
                                        <td>
                                            <a href="javascript:;" @click="fnPostView(item.chatroomNo)">
                                                {{item.title}}
                                                <span v-if="item.pwd && item.pwd > 0" title="비밀글 🔒">🔒</span>
                                            </a>

                                        </td>
                                        <td>{{item.intro}}</td>
                                        <td class="entry-btn-cell">
                                            <button class="entry-btn"
                                                @click="fnEnterChat(item.chatroomNo)">입장하기</button>
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
                                    <button @click="moveToPost" class="btn">크루생성하기</button>
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
                                } else {
                                    console.log("오류");
                                }
                            }

                        });
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
                        $.ajax({
                            url: "/home/crew/chatMove.dox", // 서버에서 DB에 유저 정보 저장 요청
                            dataType: "json",
                            type: "POST",
                            data: {
                                userId: self.sessionId,
                                chatroomNo: chatroomNo
                            },
                            success: function (response) {
                                if (response.result == 'success') {
                                    // DB 저장 성공 확인 후, 이제 존재하는 채팅방 페이지로 이동!
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
                    fnNotice(){
                        let self = this;
                        pageChange("/home/community/board.do", {type : "B"});
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
                    moveToPost() {
                        alert("글쓰기 페이지로 이동합니다.");
                    },
                    fnSale() {
                        let self = this;
                        self.saleYN = 'Y';
                        pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                    }
                },
                mounted() {
                    let self = this;
                    self.fnList();
                    self.fnGetUserInfo(); //유저정보가져오기
                }
            });

            app.mount('#app');
        </script>
    </body>

    </html>