<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/crew-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>커뮤니티 게시판</title>

        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                            <div><a href="/home/product.do">세일</a></div>
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

                                <!-- 글쓰기 버튼-->
                                <div class="write-btn-wrapper">
                                    <button @click="moveToPost" class="btn">글쓰기</button>
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

                    fnEnterChat(chatroomNo) {
                        alert("채팅방 번호 " + chatroomNo + "에 입장합니다.");
                        location.href = "/home/community/chat/show.do?chatroomNo=" + chatroomNo;

                    },

                    moveToPost() {
                        alert("글쓰기 페이지로 이동합니다.");
                        window.location.href = "/home/community/crew/post.do?sessionId=" + this.sessionId;
                    },

                    fnNotice() {
                        let self = this;
                        pageChange("/home/community/board.do", { type: "B" });
                    },

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