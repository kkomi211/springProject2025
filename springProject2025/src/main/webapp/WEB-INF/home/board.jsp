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
        <title>Community</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <style>

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
                    height: 400px; /* adjust to your design */
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
                                        <div class="swiper-slide"
                                            >
                                            
                                                <img src="https://as2.ftcdn.net/v2/jpg/02/34/65/76/1000_F_234657662_jQjqcHFWIh3oVh9DTXAXzKAXVZ5Zf6ko.jpg"  >
                                            
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
                                    <div class="search-wrapper">
                                        <select v-model="type" @change="fnBoardList">
                                            <option value="">전체</option>
                                            <option value="B">공지사항</option>
                                            <option value="Q">문의게시판</option>
                                            <option value="F">자유게시판</option>
                                            <option value="R">대회게시판</option>
                                        </select>
                                        <input type="text" placeholder="검색어" v-model="keyword"
                                            @keyup.enter="fnBoardList">
                                        <button class="search-btn" @click="fnBoardList">🔍</button>
                                    </div>
                                </div>
                            </div>
                            <select class="btn" v-model="pageSize" @change="fnBoardList">
                                <option class="btn" value="5">5개씩</option>
                                <option class="btn" value="10">10개씩</option>
                                <option class="btn" value="20">20개씩</option>
                            </select>
                            <table>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>댓글</th>
                                    <th>작정자</th>
                                    <th>작성일</th>
                                    <th id="view-cnt">조회수</th>
                                </tr>
                                <tr v-for="item in boardList">
                                    <td>{{item.boardNo}}</td>
                                    <td>
                                        <a href="javascript:;" @click="fnPostView(item.boardNo)">
                                            {{item.title}}
                                            <span v-if="item.pwd && item.pwd > 0" title="비밀글 🔒">🔒</span>
                                        </a>

                                    </td>
                                    <td>💬 {{item.commentCnt}} </td>
                                    <td>{{item.userId}}</td>
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
                                <button @click="moveToPost" class="btn">글쓰기</button>
                            </div>

                            <!-- Popup asking for the user post's password -->

                            <div v-if="pwdCorrect" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>비밀글로 보호된 게시물입니다.</h2>
                                    <p>비밀번호를 입력해야 내용을 확인할 수 있습니다.</p>
                                    <input class="btn" type="password" @keyup.enter="fnKeylock" placeholder="비밀번호 입력"
                                        v-model="keylock" id="keylock">
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
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    userName: "",
                    boardList: [],
                    postInfo: {},
                    keyword: "",
                    type: "${type}",

                    // pagination
                    cnt: 0,
                    page: 1,
                    pageSize: 10,
                    index: 0,

                    // modal popup 
                    isLoggedOut : false, // logout popup 
                    pwdCorrect: false,
                    selectedPost: null,  // store the post object being clicked
                    keylock: ""
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
                            } else {
                                console.log("오류");
                            }

                        }
                    });
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

                    if (post.pwd && post.pwd.length > 0) {
                        // Show password modal
                        self.selectedPost = post;
                        self.pwdCorrect = true;
                        self.keylock = ""; // reset input
                    } else {
                        // No lock, go directly to the post
                        pageChange("board/view.do", { boardNo: boardNo });
                    }

                    // pageChange("board/view.do", {boardNo : boardNo});
                },
                fnKeylock: function () {
                    let self = this;
                    if (!self.selectedPost) return; // safety check

                    let param = {
                        boardNo: self.selectedPost.boardNo, // send the post ID
                        keylock: self.keylock               // send the password entered
                    };

                    $.ajax({
                        url: "/board/keylock.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result === "success") {
                                // alert("Password correct");
                                self.pwdCorrect = false; // close modal
                                // redirect to the post
                                pageChange("board/view.do", { boardNo: self.selectedPost.boardNo });
                            } else if (data.result === "fail") {
                                alert("비밀번호가 올바르지 않습니다."); // wrong password
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
                fnNotice(){
                let self = this;
                pageChange("/home/community/board.do", {type : "B"});
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
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnBoardList();   //보드리스트정보게시판정보 가져오기
                self.fnGetUserInfo(); //유저정보가져오기
            }
        });

        app.mount('#app');
    </script>