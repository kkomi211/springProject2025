<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/post-style.css">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Community</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <style>
            textarea {
                /* !important를 사용하여 다른 CSS보다 우선순위를 높입니다. */
                resize: none !important;
                background-color: #f9f9f9;
            }

            input[readonly],
            textarea[readonly] {
                background-color: #f9f9f9;
                cursor: default;
            }

            .main-content {
                position: relative;
                /* 버튼 기준점을 주기 위해 필요 */
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
                                    <li class="active">
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
                                    <li>
                                        <span class="icon">👤</span>
                                        <a href="/home/community/chat.do">채팅방</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>
                        <main class="main-content">
                            <div class="board-header">
                                <h1 class="main-title">
                                    게시판 • 글쓰기
                                </h1>
                            </div>

                            <!-- 글쓰기 다른 디자인 테스트 -->
                            <div class="comments-section">
                                <div class="sub-section">
                                    <h3 class="comment-title">
                                        아이디
                                    </h3>
                                    <div class="post-author">
                                        <strong>{{ userName }}</strong>
                                    </div>
                                </div>

                                <div class="sub-section">
                                    <h3 class="comment-title">
                                        제목
                                    </h3>
                                    <div class="title-input">
                                        <label for="">
                                            <input type="text" v-model="title" id="title">
                                        </label>
                                    </div>
                                </div>

                                <!-- 내용 입력 부분 -->
                                <div class="sub-section">
                                    <h3 class="comment-title">내용</h3>
                                    <div>
                                        <textarea v-model="intro" id="intro" rows="10" placeholder="내용을 입력해주세요."
                                            style="width: 100%; resize: vertical; padding: 10px; font-size: 14px;"></textarea>
                                    </div>
                                </div>


                                <div class="bottom-btn">
                                    <button @click="fnPost">등록</button>
                                    <button @click="fnMoveToBoard">목록</button>
                                </div>

                                <!-- If the user is not logged in -->

                                <div v-if="!isLoggedIn" class="modal-overlay">
                                    <div class="modal-content">
                                        <h2>로그인 후 이용해주세요.</h2>
                                        <div class="modal-btn">
                                            <button @click="moveToLogin">로그인</button>
                                            <button @click="moveToBoard">닫기</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
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
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    userName: "",
                    list: [],
                    keyword: "",
                    type: "B",
                    title: "",
                    keylock: "",
                    intro: "",
                    cnt: 0,
                    page: 1,
                    pageSize: 10,
                    index: 0,
                    isLoggedIn: true
                };
            },
            methods: {
                fnGetUserInfo() {
                    let self = this;
                    $.ajax({
                        url: "/home/mypage/userInfo.dox",
                        dataType: "json",
                        type: "POST",
                        data: { userId: self.sessionId },
                        success: function (data) {
                            self.userName = data;
                        },
                        error: function () {
                            self.userName = "Guest";
                        }
                    });
                },
                fnList() {
                    let self = this;
                    let startRow = (self.page - 1) * self.pageSize + 1;
                    let endRow = self.page * self.pageSize;
                    let param = {
                        keyword: self.keyword.trim(),
                        page: self.page,
                        pageSize: self.pageSize,


                    };
                    $.ajax({
                        url: "/board/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.list = data.list;
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);
                            }
                        }
                    });
                },
                fnMoveToBoard() {
                    if (!confirm("게시글이 저장되지 않습니다. 계속 진행하시겠습니까?")) return;
                    location.href = "/home/community/board.do";
                },
                fnPost() {
                    let self = this;
                    if (self.title.trim() === "") {
                        alert("제목을 입력해주세요.");
                        document.querySelector("#title").focus();
                        return;
                    }
                    if (self.intro.trim() === "") {
                        alert("내용을 입력해주세요.");
                        document.querySelector("#intro").focus();
                        return;
                    }

                    let param = {
                        userId: self.sessionId,
                        title: self.title,
                        intro: self.intro,
                        name: self.title,

                    };

                    $.ajax({
                        // url: "/board/post.dox",
                        url: "/crew/chatInsert.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                alert("채팅방이 개설되었습니다!");
                                location.href = "/home/community/chat.do";
                            } else {
                                alert("채팅방 개설에 실패했습니다.");
                            }
                        }
                    });
                },
                moveToLogin() {
                    location.href = "/home/login.do";
                },
                moveToBoard() {
                    location.href = "/home/community/board.do";
                },
                moveToCrew() {
                    location.href = "/home/community/crew.do";
                },
                fnNotice() {
                    location.href = "/home/community/board.do?type=B";
                }
            },
            mounted() {
                let self = this;
                self.fnList();
                self.fnGetUserInfo();

                console.log("Session ID : " + self.sessionId);

                if (!self.sessionId || self.sessionId.trim() === "") {
                    self.isLoggedIn = false;
                }
            }
        });

        app.mount('#app');
    </script>