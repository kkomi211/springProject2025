<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/post-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Community</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <script src="/js/page-change.js"></script>
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
                font-family: 'Fugaz One', sans-serif;
                font-size: 60px;
                letter-spacing: 5px;
                margin-left: 0;
                /* top-header div의 default margin-left 상쇄 */
                display: block;
                color: white;
                /* default 유지 */
            }

            .brand-name a {
                color: white;
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
                font-size: 30px;
                /* default bottom-header 폰트 사이즈 */
                background-color: white;
                /* bottom-header 배경색 추가 */
                /* border-bottom: 1px solid #eee; 하단 경계선 */
                padding: 20px 0;
                /* 세로 패딩 */
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

            .bottom-header a:hover {
                color: #007bff;
            }

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
                                    게시판 • 상세보기
                                </h1>
                            </div>

                            <!-- 게시글 보기 -->
                            <div class="post-container">
                                <div class="post-header">
                                    <div class="post-meta">
                                        <span class="post-category">
                                            {{
                                            type === 'B' ? '공지사항' :
                                            type === 'Q' ? '문의게시판' :
                                            type === 'F' ? '자유게시판' :
                                            type === 'R' ? '대회게시판' :
                                            '게시판'
                                            }}
                                        </span>
                                        <span class="post-date">{{ boardInfo.chardate }}</span>
                                    </div>
                                    <h2 class="post-title">
                                        {{ boardInfo.title }}
                                    </h2>
                                    <div class="post-author">
                                        <strong>{{ boardInfo.userId }}</strong> 님의 게시글
                                    </div>
                                </div>

                                <div class="post-content" v-html="boardInfo.contents"></div>
                                <div class="bottom-btn">
                                    <button v-if="sessionId === boardInfo.userId" class="edit-inline-btn"
                                        @click="fnMoveToEdit">✏️ 수정</button>
                                    <button v-if="sessionId === boardInfo.userId" class="edit-inline-btn"
                                        @click="fnConfirmDelete">🗑️ 삭제</button>
                                    <button v-if="sessionId != boardInfo.userId" class="edit-inline-btn"
                                        @click="fnConfirmReport">🚨 신고</button>
                                </div>
                            </div>

                            <!-- 댓글 보기 -->

                            <div class="comments-section">
                                <h3 class="comment-title">
                                    💬 {{ commentList.length }} Comments
                                </h3>

                                <div class="comment-view" v-if="commentList.length > 0">
                                    <div v-for="item in commentList" :key="item.commentNo" class="comment-card">
                                        <div class="comment-header">
                                            <div class="comment-author">{{ userName }}</div>
                                            <div class="comment-date">{{ item.chardate }}</div>
                                        </div>
                                        <div class="comment-body">
                                            {{ item.contents }}
                                        </div>
                                    </div>
                                </div>

                                <div v-else class="no-comments">
                                    아직 댓글이 없습니다. 첫 번째로 댓글을 남겨보세요!
                                </div>
                            </div>

                            <!-- 댓글 쓰기 -->
                            <div v-if="sessionId != '' " class="comment-box">
                                <div class="comment-header">
                                    <strong>{{userName}}</strong>
                                </div>
                                <div class="comment-input">
                                    <textarea placeholder="댓글을 남겨보세요" v-model="commentContent"
                                        @keyup.enter="fnPostComment"></textarea>
                                    <button @click="fnPostComment">등록</button>
                                </div>
                            </div>

                            <div class="list-btn">
                                <button @click="fnMoveToBoard">목록</button>
                            </div>

                            <!-- Modal Popup -->
                            <!-- v-if="confirmDelete"  -->
                            <div v-if="confirmDelete" class="modal-overlay">

                                <div v-if="!deleted" class="modal-content">
                                    <h2>정말 이 게시글을 삭제하시겠습니까?</h2>
                                    <div>
                                        <button class="btn" @click="fnCancel">취소</button>
                                        <button class="btn" @click="fnDeletePost">삭제</button>
                                    </div>
                                </div>
                                <div v-else class="modal-content">
                                    <h2>게시글이 삭제되었습니다.</h2>
                                    <div>
                                        <button class="btn" @click="fnMoveToBoard">확인</button>
                                    </div>
                                </div>

                            </div>

                            <!-- Report popup -->
                            <div v-if="confirmReport" class="modal-overlay">

                                <div v-if="!postReported" class="modal-content">
                                    <h2>이 댓글을 신고하시겠습니까?</h2>
                                    <div>
                                        <button class="btn" @click="fnCancel">닫기</button>
                                        <button class="btn" @click="fnReportPost">확인</button>
                                    </div>
                                </div>
                                <div v-else class="modal-content">
                                    <h2>이 게시글이 신고되었습니다.</h2>
                                    <div>
                                        <button class="btn" @click="fnCancel">닫기</button>
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
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    userName: "",
                    boardInfo: {},
                    boardNo: "${boardNo}",
                    commentList: [],

                    keyword: "",
                    type: "B",
                    title: "",
                    keylock: "",
                    content: "",

                    // pagination
                    cnt: 0,
                    page: 1,
                    pageSize: 10,
                    index: 0,

                    // popup modal
                    isLoggedIn: true,
                    confirmDelete: false,
                    deleted: false,

                    // post comment
                    commentContent: "",

                    // report
                    confirmReport : false,
                    postReported : false

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
                fnBoardInfo: function () {
                    let self = this;
                    let param = {
                        boardNo: self.boardNo
                    };
                    console.log("boardNo ==>" + self.boardNo)
                    $.ajax({
                        url: "/board/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log(data);
                                self.boardInfo = data.info;
                                self.type = self.boardInfo.type;
                            } else {
                                console.log("오류");
                            }

                        }
                    });
                },
                fnMoveToBoard: function () {
                    let self = this;
                    // make a modal here
                    location.href = "/home/community/board.do";
                },
                moveToLogin: function () {
                    let self = this;
                    location.href = "/home/login.do";
                },
                moveToBoard: function () {
                    let self = this;
                    location.href = "/home/community/board.do";
                },
                fnViewComment: function () {
                    let self = this;
                    let param = {
                        boardNo: self.boardNo
                    };
                    console.log("boardNo ==>" + self.boardNo);
                    $.ajax({
                        url: "/board/comment.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log("comment data == > ", data);
                                self.commentList = data.list;
                            } else {
                                console.log("오류");
                            }

                        }
                    });
                },
                fnPostComment: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        contents: self.commentContent,
                        boardNo: self.boardNo
                    };
                    if (self.commentContent.trim() == "") {
                        alert("빈 댓글은 등록할 수 없습니다.");
                        return;
                    }
                    $.ajax({
                        url: "/board/comment-post.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                alert("등록되었습니다!");
                                self.fnViewComment();
                                self.commentContent = "";
                            } else {
                                alert(error);
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
                    });
                },
                fnMoveToEdit: function () {
                    let self = this;
                    // location.href="/home/community/board/edit.do";
                    pageChange("/home/community/board/edit.do", { boardNo: self.boardNo });
                },
                fnConfirmDelete: function () {
                    let self = this;
                    self.confirmDelete = true;
                },
                fnCancel: function () {
                    let self = this;
                    self.confirmDelete = false;
                    self.confirmReport = false;
                },
                fnDeletePost: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        boardNo: self.boardNo
                    };
                    $.ajax({
                        url: "/board/delete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.deleted = true;
                            } else {
                                alert("error");
                            }
                        }
                    })
                },
                fnCloseModal: function () {
                    let self = this;
                    self.confirmReport = false;

                },
                fnConfirmReport : function(){
                    let self = this;
                    self.confirmReport = true;

                },
                fnReportPost : function () {
                    let self = this;
                    let param = {
                        boardNo : self.boardNo,
                        reporterId : self.sessionId
                    };
                    $.ajax({
                        url: "/board/report.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.postReported = true;
                            } else {
                                alert("error");
                            }
                        }
                    })
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnBoardInfo();
                self.fnGetUserInfo();
                self.fnViewComment();
            }
        });

        app.mount('#app');
    </script>