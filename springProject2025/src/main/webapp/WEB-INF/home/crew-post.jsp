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
                                <!-- <template > -->
                                    <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i data-lucide="log-out" stroke-width="1.5"></i></a></div>
                                <!-- </template> -->
                                <!-- <template > -->
                                    <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a></div>
                                <!-- </template> -->
                            </div>
                            <div v-if="sessionId == ''">
                                <a href="/home/signup.do"><i data-lucide="user-plus" stroke-width="1.5"></i></a>
                            </div>
                            <div v-if="sessionId != '' && userType != 'K'"><a
                                    href="/home/mypage/information.do"><i data-lucide="user" stroke-width="1.5"></i></a></div>
                            <div v-else-if="sessionId != '' && userType == 'K'"><a
                                    href="home/mypage/information/change.do"><i data-lucide="user" stroke-width="1.5"></i></a></div>
                            <div v-if="sessionId != ''"><a href="/home/cart.do"><i data-lucide="shopping-cart" stroke-width="1.5"></i></a></div>
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
        lucide.createIcons();
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
                    isLoggedIn: true,

                    userType : '${userType}',
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