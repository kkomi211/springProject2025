<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/board-style.css">
        <link rel="stylesheet" href="/css/rally-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <script src="/js/page-change.js"></script>
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                object-fit: cover;
            }

            .main-hero-slider-area {
                width: 100vw;
                position: relative;
                left: 50%;
                right: 50%;
                margin-left: -50vw;
                margin-right: -50vw;
                overflow: hidden;
                background-color: #f8f8f8;
                height: 300px;
            }

            .main-hero-slider {
                width: 100%;
                height: 100%;
                padding: 0;
                position: relative;
            }

            .main-hero-slider .swiper-container {
                width: 100%;
                height: 100%;
                margin: 0;
            }

            .main-hero-slider .swiper-slide {
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
            }

            .main-hero-slider .swiper-slide a {
                display: block;
                width: 100%;
                height: 100%;
            }

            .main-hero-slider .swiper-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                display: block;
            }

            .main-hero-slider .swiper-pagination {
                bottom: 30px !important;
                z-index: 10;
            }

            .main-hero-slider .swiper-pagination-bullet {
                background-color: #fff;
                opacity: 0.7;
                margin: 0 8px !important;
                width: 12px;
                height: 12px;
                transition: opacity 0.3s ease, background-color 0.3s ease;
            }

            .main-hero-slider .swiper-pagination-bullet-active {
                background-color: #007bff;
                opacity: 1;
            }

            .main-hero-slider-area .swiper-side-cover {
                display: none;
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
                0%, 100% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.1);
                }
            }

            /* ========== 대회 목록 NEW 배지 스타일 ========== */
            .rally-item {
                position: relative;
            }

            .new-badge {
                position: absolute;
                top: 10px;
                right: 10px;
                background: linear-gradient(135deg, #ff4444, #ff6b6b);
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.85em;
                font-weight: bold;
                box-shadow: 0 2px 8px rgba(255, 68, 68, 0.4);
                z-index: 5;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                    box-shadow: 0 2px 8px rgba(255, 68, 68, 0.4);
                }
                50% {
                    transform: scale(1.05);
                    box-shadow: 0 4px 12px rgba(255, 68, 68, 0.6);
                }
            }

            .rally-item.new-item {
                border: 2px solid #ff6b6b;
                box-shadow: 0 4px 12px rgba(255, 68, 68, 0.2);
            }
        </style>
    </head>

    <body>
        <div id="app">
            <div class="container">
                <header>
                    <div class="top-header">
                        <div class="brand-name">
                            <div><a href="/home.do">RUNNERS' HOUSE</a></div>
                        </div>
                        <div id="right-items">
                            <div>
                                <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i
                                            data-lucide="log-out" stroke-width="1.5"></i></a></div>
                                <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a>
                                </div>
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
                        <span class="crew-overlay-text">COMMUNITY</span>
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
                                    <li @click="moveToBoard">
                                        <span class="icon">📝</span>
                                        <a href="/home/community/board.do">게시판</a>
                                    </li>
                                    <li @click="moveToCrew">
                                        <span class="icon">📦</span>
                                        <a href="/home/community/crew.do">크루 찾기</a>
                                    </li>
                                    <li @click="moveToRally" class="active">
                                        <span class="icon">💬</span>
                                        <a href="javascript:void(0)">
                                            대회정보
                                            <span v-if="hasNewRally" class="sidebar-new-badge">NEW</span>
                                        </a>
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
                                    대회 정보
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
                                        <input type="text" placeholder="검색어" v-model="keyword" @keyup.enter="fnList">
                                        <button class="search-btn" @click="fnList">🔍</button>
                                    </div>
                                </div>
                            </div>

                            <select class="btn" v-model="pageSize" @change="fnList">
                                <option value="5">5개씩</option>
                                <option value="10">10개씩</option>
                                <option value="20">20개씩</option>
                            </select>

                            <div class="rally-list">
                                <div class="rally-item" v-for="item in list" :key="item.rallyNo"
                                     :class="{ 'new-item': isNewRallyItem(item.rallyNo) }">
                                    
                                    <!-- 신규 대회에 NEW 배지 표시 -->
                                    <span v-if="isNewRallyItem(item.rallyNo)" class="new-badge">NEW</span>
                                    
                                    <div class="rally-img">
                                        <img :src="item.imgPath || '/images/default.jpg'" alt="대회 포스터">
                                    </div>
                                    <div class="rally-info">
                                        <h3 class="rally-title">{{ item.rallyName }}</h3>
                                        <p><strong>일시:</strong> {{ item.rallyDate }}</p>
                                        <p><strong>접수기간:</strong> {{ item.applicationPeriod }}</p>
                                        <p><strong>참가비:</strong> {{ formatPrice(item.price) }}원</p>
                                        <p><strong>문의 번호:</strong> {{ item.phone }}</p>
                                        <p><strong>참가부문:</strong> {{ item.type }}</p>
                                        <p><strong>주최:</strong> {{ item.host }}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- 페이지네이션 -->
                            <div v-if="index > 0" class="pagination">
                                <a v-if="page != 1" @click="fnMove(page - 1)" href="javascript:void(0)">◀</a>
                                <a @click="fnMove(num)" id="index" href="javascript:void(0)" v-for="num in index"
                                    :key="num">
                                    <span :class="{ active: page == num }">{{ num }}</span>
                                </a>
                                <a v-if="page != index" @click="fnMove(page + 1)" href="javascript:void(0)">▶</a>
                            </div>

                            <!-- 비밀번호 확인 모달 -->
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
    </body>

    <script>
        lucide.createIcons();
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
                    userType: '${userType}',
                    hasNewRally: false,
                    lastCheckedRallyNo: null
                };
            },
            methods: {
                fnList() {
                    const self = this;
                    const param = {
                        keyword: self.keyword,
                        type: self.type,
                        page: self.page,
                        pageSize: self.pageSize
                    };
                    $.ajax({
                        url: "/home/rally/board.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log("대회 목록:", data);
                                self.list = data.list;
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);

                                // NEW 대회 체크
                                self.checkNewRally();
                            } else {
                                console.log("오류");
                            }
                        }
                    });
                },

                // 신규 대회 체크
                checkNewRally() {
                    const self = this;
                    
                    // localStorage에서 마지막 확인한 대회 번호 가져오기
                    const savedRallyNo = localStorage.getItem("lastCheckedRallyNo");
                    
                    if (self.list.length > 0) {
                        const latestRallyNo = self.list[0].rallyNo;
                        
                        console.log("최신 대회번호:", latestRallyNo);
                        console.log("마지막 확인 대회번호:", savedRallyNo);
                        
                        // 저장된 번호가 없거나, 최신 대회번호가 더 크면 NEW 표시
                        if (!savedRallyNo || parseInt(latestRallyNo) > parseInt(savedRallyNo)) {
                            self.hasNewRally = true;
                            console.log("NEW 배지 표시!");
                        } else {
                            self.hasNewRally = false;
                        }
                    }
                },

                // 개별 대회 항목이 신규인지 체크 (사용자가 확인하지 않은 대회)
                isNewRallyItem(rallyNo) {
                    const savedRallyNo = localStorage.getItem("lastCheckedRallyNo");
                    
                    // 저장된 번호가 없으면 모든 대회가 신규
                    if (!savedRallyNo) {
                        return true;
                    }
                    
                    // 현재 대회번호가 저장된 번호보다 크면 신규
                    return parseInt(rallyNo) > parseInt(savedRallyNo);
                },

                // 오늘 등록된 대회인지 확인 (날짜 기준)
                isNewItem(cdate) {
                    if (!cdate) return false;
                    
                    const today = new Date();
                    const todayStr = today.getFullYear().toString().substr(2, 2) + '/' + 
                                   String(today.getMonth() + 1).padStart(2, '0') + '/' + 
                                   String(today.getDate()).padStart(2, '0');
                    
                    return cdate === todayStr;
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

                fnKeylock() {
                    if (this.inputPwd === "1234") {
                        alert("비밀번호 확인 완료");
                        this.pwdCorrect = false;
                    } else {
                        alert("비밀번호가 틀렸습니다.");
                    }
                },
                
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },

                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
                
                formatPrice(value) {
                    if (value == null || value === '') return '-';
                    const num = Number(value);
                    if (isNaN(num)) return value;
                    return num.toLocaleString();
                },
                
                moveToBoard: function () {
                    let self = this;
                    pageChange("/home/community/board.do", {});
                },
                
                moveToCrew: function () {
                    let self = this;
                    pageChange("/home/community/crew.do", {});
                },
                
                moveToRally: function () {
                    let self = this;
                    
                    // NEW 배지 클릭 시 확인 처리
                    if (self.list.length > 0) {
                        const latestRallyNo = self.list[0].rallyNo;
                        localStorage.setItem("lastCheckedRallyNo", latestRallyNo);
                        self.hasNewRally = false;
                        console.log("대회정보 확인 완료, 저장된 번호:", latestRallyNo);
                    }
                    
                    pageChange("/home/community/rally.do", {});
                },
                
                moveToChat: function () {
                    let self = this;
                    pageChange("/home/community/chat.do", {});
                }
            },
            mounted() {
                let self = this;
                self.fnList(); // 목록 로드 및 NEW 체크
                self.fnGetUserInfo();
            }
        });

        app.mount('#app');
    </script>
    </body>

    </html>