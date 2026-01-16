<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/board-style.css">
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
        <script src="https://unpkg.com/lucide@latest"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

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

            /* ========== 게시글 목록 NEW 배지 스타일 ========== */
            .new-post-badge {
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

            /* 신규 게시글 행 강조 */
            table tr.new-post {
                background-color: #fff5f5;
                border-left: 3px solid #ff6b6b;
            }

            table tr.new-post:hover {
                background-color: #ffe8e8;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
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
                            <span class="crew-overlay-text">COMMUNITY</span> <!-- 텍스트는 항상 보임, 중앙 위치 -->
                        </section>
                    </div>

                    <main class="below-header">


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
                                        <li class="active" @click="moveToBoard">
                                            <span class="icon">📝</span>
                                            <a href="javascript:void(0)">
                                                게시판
                                                <span v-if="hasNewPost" class="sidebar-new-badge">NEW</span>
                                            </a>
                                        </li>
                                        <li @click="moveToCrew">
                                            <span class="icon">📦</span>
                                            <a href="/home/community/crew.do">크루 찾기</a>
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

                            <main class="main-content">
                                <div class="board-header">
                                    <h1 class="main-title">
                                        게시판 •
                                        {{
                                        type === '' ? '전체 게시판' :
                                        type === 'B' ? '공지사항' :
                                        type === 'Q' ? '문의게시판' :
                                        type === 'F' ? '자유게시판' :
                                        type === 'R' ? '대회게시판' :
                                        '게시판'
                                        }}
                                    </h1>
                                    <div class="search-bar">
                                        <div class="search-box">
                                            <select v-model="type" @change="fnBoardList" class="board-select">
                                                <option value="">전체</option>
                                                <option value="B">공지사항</option>
                                                <option value="Q">문의게시판</option>
                                                <option value="F">자유게시판</option>
                                                <option value="R">대회게시판</option>
                                            </select>
                                            <input class="search" type="text" placeholder="검색어를 입력하세요" v-model="keyword"
                                                @keyup.enter="fnBoardList">
                                            <a href="javascript:;" @click="fnBoardList">
                                                <div><i data-lucide="search" stroke-width="1.5"></i></div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <select class="page-size-select" v-model="pageSize" @change="fnBoardList">
                                    <option value="5">5개씩</option>
                                    <option value="10">10개씩</option>
                                    <option value="20">20개씩</option>
                                </select>
                                <table>
                                    <tr style="background-color: #f7f7f7;">
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>댓글</th>
                                        <!-- <th>작정자</th> -->
                                        <th>작성일</th>
                                        <th id="view-cnt">조회수</th>
                                    </tr>
                                    <tr v-for="item in boardList" :class="{ 'new-post': isNewPost(item.boardNo) }">
                                        <td>{{item.boardNo}}</td>
                                        <td class="title-cell">
                                            <a href="javascript:;" @click="fnPostView(item.boardNo)">
                                                <div class="title-row">
                                                    <span class="post-title">{{ item.title }}</span>
                                                    <span v-if="item.pwd" class="material-symbols-outlined lock-icon"
                                                        title="비밀글">
                                                        lock
                                                    </span>
                                                </div>
                                                <div class="sub-meta">
                                                    <span>{{ item.userId }}</span>
                                                </div>
                                            </a>
                                        </td>
                                        <td>
                                            <div class="comment-column">
                                                <span class="material-icons-outlined" style="font-size: 18px;">
                                                    comment
                                                </span>
                                                <span>{{item.commentCnt}}</span>
                                            </div>
                                        </td>
                                        <!-- <td>{{item.userId}}</td> -->
                                        <td>{{item.chardate}}</td>
                                        <td id="view-cnt">{{item.viewCnt}}</td>
                                    </tr>
                                </table>
                                <div v-if="index > 0" class="pagination">
                                    <!-- <a v-if="page != 1" @click="fnMove(1)" href="javascript:void(0)">←</a> -->
                                    <a v-if="page != 1" @click="fnMove(page - 1)" href="javascript:void(0)">◀</a>
                                    <a @click="fnMove(num)" id="index" href="javascript:void(0)" v-for="num in index"
                                        :key="num">
                                        <span :class="{ active: page == num }">{{ num }}</span>
                                    </a>
                                    <a v-if="page != index" @click="fnMove(page + 1)" href="javascript:void(0)">▶</a>
                                    <!-- <a v-if="page != index" @click="fnMove(index)" href="javascript:void(0)">→</a> -->
                                </div>

                                <div class="write-btn-wrapper">
                                    <button @click="moveToPost" class="write-btn">글쓰기</button>
                                </div>

                                <!-- Popup asking for the user post's password -->

                                <div v-if="pwdCorrect" class="modal-overlay">
                                    <div class="modal-content">
                                        <h2>비밀글로 보호된 게시물입니다.</h2>
                                        <p>비밀번호를 입력해야 내용을 확인할 수 있습니다.</p>
                                        <input class="btn" type="password" @keyup.enter="fnKeylock"
                                            placeholder="비밀번호 입력" v-model="keylock" id="keylock">
                                        <div>
                                            <button style="margin-right: 10px;" class="btn"
                                                @click="pwdCorrect = false">닫기</button>
                                            <button class="btn" @click="fnKeylock">확인</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Logout popup -->
                                <div v-if="isLoggedOut" class="modal-overlay">
                                    <div class="modal-content">
                                        <h2>{{userName}} 님, 로그아웃 되었습니다.</h2>
                                        <a href="/home.do"><button class="btn">메인 화면으로 가기</button></a>
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
        lucide.createIcons();
        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    userName: "",
                    boardList: [],
                    postInfo: {},
                    keyword: "",
                    type: "${type}",
                    userType: "${userType}",

                    // pagination
                    cnt: 0,
                    page: 1,
                    pageSize: 10,
                    index: 0,

                    // modal popup 
                    isLoggedOut: false,
                    pwdCorrect: false,
                    selectedPost: null,
                    keylock: "",

                    // NEW 배지 관련
                    hasNewPost: false,
                    checkedPosts: [], // 확인한 게시글 목록
                    newReplyCount: 0 // 새 답변 개수
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

                fnBoardList: function () {
                    let self = this;
                    let startRow = (self.page - 1) * self.pageSize + 1;
                    let endRow = self.page * self.pageSize;
                    let param = {
                        type: self.type,
                        keyword: self.keyword.trim(),
                        page: (self.page - 1) * self.pageSize,
                        pageSize: self.pageSize,
                        startRow: startRow,
                        endRow: endRow
                    };
                    console.log("type ==>" + self.type, "keyword ==>" + self.keyword);
                    $.ajax({
                        url: "/board/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log(data);
                                self.boardList = data.list;
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);

                                // 확인한 게시글 목록 로드
                                self.loadCheckedPosts();

                                // NEW 게시글 체크
                                self.checkNewPost();
                            } else {
                                console.log("오류");
                            }
                        }
                    });
                },

                // localStorage에서 확인한 게시글 목록 불러오기
                loadCheckedPosts() {
                    const self = this;
                    const storageKey = `checkedPosts_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);

                    if (saved) {
                        try {
                            self.checkedPosts = JSON.parse(saved);
                            console.log("확인한 게시글 목록:", self.checkedPosts);
                        } catch (e) {
                            self.checkedPosts = [];
                        }
                    } else {
                        self.checkedPosts = [];
                    }
                },

                // 확인한 게시글 목록 저장
                saveCheckedPosts() {
                    const self = this;
                    const storageKey = `checkedPosts_${self.sessionId}`;
                    localStorage.setItem(storageKey, JSON.stringify(self.checkedPosts));
                    console.log("확인한 게시글 저장 완료:", self.checkedPosts);
                },

                // 신규 게시글 체크 (24시간 이내 작성 + 확인하지 않은 게시글)
                checkNewPost() {
                    const self = this;

                    if (self.boardList.length === 0) {
                        self.hasNewPost = false;
                        return;
                    }

                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);

                    // 24시간 이내 작성되고 확인하지 않은 게시글이 있는지 체크
                    const hasNew = self.boardList.some(post => {
                        const postDate = new Date(post.chardate);
                        const isRecent = postDate > oneDayAgo;
                        const isNotChecked = !self.checkedPosts.includes(post.boardNo);

                        return isRecent && isNotChecked;
                    });

                    self.hasNewPost = hasNew;
                    console.log("NEW 배지 표시 여부:", hasNew);
                },

                // 개별 게시글이 신규인지 체크 (24시간 이내 작성 + 확인하지 않음)
                isNewPost(boardNo) {
                    const self = this;

                    // 이미 확인한 게시글이면 NEW 표시 안함
                    if (self.checkedPosts.includes(boardNo)) {
                        return false;
                    }

                    // 해당 게시글 찾기
                    const post = self.boardList.find(p => p.boardNo === boardNo);
                    if (!post) {
                        return false;
                    }

                    // 24시간 이내에 작성되었는지 확인
                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);
                    const postDate = new Date(post.chardate);

                    return postDate > oneDayAgo;
                },

                // 게시글 확인 처리 (NEW 배지 업데이트)
                updateLastCheckedPost: function (boardNo) {
                    let self = this;

                    // 확인한 게시글로 표시
                    if (!self.checkedPosts.includes(boardNo)) {
                        self.checkedPosts.push(boardNo);
                        self.saveCheckedPosts();

                        // NEW 배지 상태 업데이트
                        self.checkNewPost();
                    }
                },

                fnMove: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnBoardList();
                },

                fnPage: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnBoardList();
                },

                moveToPost: function () {
                    let self = this;
                    pageChange("/home/community/board/post.do", { sessionId: self.sessionId });
                },

                fnPostView: function (boardNo) {
                    let self = this;
                    let param = {
                        boardNo: boardNo
                    };
                    let post = self.boardList.find(item => item.boardNo === boardNo);

                    // 게시글 클릭 시 NEW 배지 확인 처리
                    self.updateLastCheckedPost(boardNo);

                    if (post.pwd && post.pwd.length > 0) {
                        // Show password modal
                        self.selectedPost = post;
                        self.pwdCorrect = true;
                        self.keylock = "";
                    } else {
                        // No lock, go directly to the post
                        pageChange("board/view.do", { boardNo: boardNo });
                    }
                },

                fnKeylock: function () {
                    let self = this;
                    if (!self.selectedPost) return;

                    let param = {
                        boardNo: self.selectedPost.boardNo,
                        keylock: self.keylock
                    };

                    $.ajax({
                        url: "/board/keylock.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result === "success") {
                                self.pwdCorrect = false;
                                pageChange("board/view.do", { boardNo: self.selectedPost.boardNo });
                            } else if (data.result === "fail") {
                                alert("비밀번호가 올바르지 않습니다.");
                                document.querySelector("#keylock").focus();
                                self.keylock = "";
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Keylock check failed:", error);
                        }
                    });
                },

                fnChat() {
                    let self = this;
                    pageChange("/home/community/chat.do", { sessionId: self.sessionId });
                },

                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
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

                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },

                // 사이드바 게시판 메뉴 클릭 시 - 모든 게시글 확인 처리
                moveToBoard: function () {
                    let self = this;

                    // 현재 표시된 모든 게시글을 확인 처리
                    self.boardList.forEach(post => {
                        if (!self.checkedPosts.includes(post.boardNo)) {
                            self.checkedPosts.push(post.boardNo);
                        }
                    });

                    self.saveCheckedPosts();
                    self.hasNewPost = false;

                    pageChange("/home/community/board.do", {});
                },

                moveToCrew: function () {
                    pageChange("/home/community/crew.do", {});
                },

                moveToRally: function () {
                    pageChange("/home/community/rally.do", {});
                },

                moveToChat: function () {
                    pageChange("/home/community/chat.do", {});
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
                checkNewReplyCount: function() {
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
                                data.list.forEach(function(item) {
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
                        error: function() {
                            self.newReplyCount = 0;
                        }
                    });
                },

            },
            mounted() {
                let self = this;
                self.fnBoardList();
                self.fnGetUserInfo();

                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkNewReplyCount(); // 새 답변 개수 체크
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
                
                // 주기적으로 새 답변 체크 (30초마다)
                setInterval(function() {
                    if (self.sessionId && self.sessionId !== '') {
                        self.checkNewReplyCount();
                    }
                }, 30000);
            }
        });

        app.mount('#app');
    </script>