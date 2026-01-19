<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/board-style.css">
        <link rel="stylesheet" href="/css/rally-style.css">
        <link rel="stylesheet" href="/css/modal-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
        <script src="/js/page-change.js"></script>
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <!-- session timeout modal -->
        <script src="/js/session-timeout.js"></script>
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

                0%,
                100% {
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

            .rally-item.new-item {
                border: 2px solid #ff6b6b;
                box-shadow: 0 4px 12px rgba(255, 68, 68, 0.2);
            }

            /* 대회 상세 모달 스타일 */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.7);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
            }

            .modal-content {
                background: white;
                padding: 0;
                border-radius: 12px;
                max-width: 800px;
                width: 90%;
                max-height: 85vh;
                overflow-y: auto;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, #000000 0%, #b9b8b9 100%);
                color: white;
                padding: 25px 30px;
                border-radius: 12px 12px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-header h2 {
                margin: 0;
                font-size: 1.8em;
                font-weight: 600;
            }

            .modal-close {
                background: rgba(255, 255, 255, 0.2);
                border: none;
                color: white;
                font-size: 28px;
                cursor: pointer;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.3s;
            }

            .modal-close:hover {
                background: rgba(255, 255, 255, 0.3);
            }

            .modal-body {
                padding: 30px;
            }

            .modal-image {
                width: 100%;
                height: 450px;
                object-fit: contain;
                background: #f8f9fa;
                border-radius: 8px;
                margin-bottom: 25px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            /* 이미지가 없을 때 대체 스타일 */
            .modal-image-placeholder {
                width: 100%;
                height: 450px;
                background: linear-gradient(135deg, #000000 0%, #b9b8b9 100%);
                border-radius: 8px;
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5em;
                font-weight: 600;
            }

            .modal-info-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
                margin-bottom: 20px;
            }

            .modal-info-item {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 8px;
                border-left: 4px solid #000000;
            }

            .modal-info-item strong {
                display: block;
                color: #000000;
                font-size: 0.9em;
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .modal-info-item p {
                margin: 0;
                font-size: 1.1em;
                color: #333;
                font-weight: 500;
            }

            .modal-footer {
                padding: 20px 30px;
                background: #f8f9fa;
                border-radius: 0 0 12px 12px;
                text-align: center;
            }

            .modal-footer .btn {
                padding: 12px 30px;
                background: linear-gradient(135deg, #000000 0%, #b9b8b9 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1em;
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .modal-footer .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            }

            /* 대회 카드에 클릭 효과 추가 */
            .rally-item {
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .rally-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

            /* 반응형 - 모바일에서는 이미지 높이 조정 */
            @media (max-width: 768px) {

                .modal-image,
                .modal-image-placeholder {
                    height: 300px;
                }

                .modal-header h2 {
                    font-size: 1.3em;
                }
            }

            @media (max-width: 480px) {

                .modal-image,
                .modal-image-placeholder {
                    height: 250px;
                }
            }
        </style>
    </head>

    <body>
        <div id="app">
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
                                            <!-- <span class="icon">📝</span> -->
                                            <span class="material-symbols-outlined icon"> forum </span>
                                            <a href="/home/community/board.do">게시판</a>
                                        </li>
                                        <li @click="moveToCrew">
                                            <!-- <span class="icon">📦</span> -->
                                            <span class="material-symbols-outlined icon"> groups </span>
                                            <a href="/home/community/crew.do">크루 찾기</a>
                                        </li>
                                        <li @click="moveToRally" class="active">
                                            <!-- <span class="icon">💬</span> -->
                                            <span class="material-symbols-outlined icon"> event </span>
                                            <a href="/home/community/rally.do">대회정보</a>
                                        </li>
                                        <li @click="moveToChat">
                                            <!-- <span class="icon">👤</span> -->
                                            <span class="material-symbols-outlined icon"> mobile_chat </span>
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
                                        <div class="search-box">
                                            <input class="search" type="text" placeholder="검색어를 입력하세요" v-model="keyword"
                                                @keyup.enter="fnList">
                                            <a href="javascript:;" @click="fnBoardList">
                                                <div><i data-lucide="search" stroke-width="1.5"></i></div>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <select class="page-size-select" v-model="pageSize" @change="fnList">
                                    <option value="5">5개씩</option>
                                    <option value="10">10개씩</option>
                                    <option value="20">20개씩</option>
                                </select>



                                <div class="rally-item" v-for="item in list" :key="item.rallyNo"
                                    :class="{ 'new-item': isNewRallyItem(item.rallyNo) }" @click="openRallyModal(item)">

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
                        <!-- session time out modal -->
                        <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>
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

                    <!-- 대회 상세 정보 모달 -->
                    <div v-if="showRallyModal" class="modal-overlay" @click.self="closeRallyModal">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2>{{ selectedRally.rallyName }}</h2>
                                <button class="modal-close" @click="closeRallyModal">&times;</button>
                            </div>

                            <div class="modal-body">
                                <!-- 이미지가 있을 때 -->
                                <img v-if="selectedRally.imgPath" :src="selectedRally.imgPath"
                                    :alt="selectedRally.rallyName" class="modal-image" @error="handleImageError">

                                <!-- 이미지가 없을 때 -->
                                <div v-else class="modal-image-placeholder">
                                    📸 대회 포스터
                                </div>

                                <div class="modal-info-grid">
                                    <div class="modal-info-item">
                                        <strong>🗓️ 대회 일시</strong>
                                        <p>{{ selectedRally.rallyDate }}</p>
                                    </div>

                                    <div class="modal-info-item">
                                        <strong>📋 접수 기간</strong>
                                        <p>{{ selectedRally.applicationPeriod }}</p>
                                    </div>

                                    <div class="modal-info-item">
                                        <strong>💰 참가비</strong>
                                        <p>{{ formatPrice(selectedRally.price) }}원</p>
                                    </div>

                                    <div class="modal-info-item">
                                        <strong>📞 문의 번호</strong>
                                        <p>{{ selectedRally.phone }}</p>
                                    </div>

                                    <div class="modal-info-item">
                                        <strong>🏃 참가 부문</strong>
                                        <p>{{ selectedRally.type }}</p>
                                    </div>

                                    <div class="modal-info-item">
                                        <strong>🏢 주최</strong>
                                        <p>{{ selectedRally.host }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button class="btn" @click="closeRallyModal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        </div>
    </body>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
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

                    // NEW 배지 관련
                    hasNewRally: false,
                    checkedRallies: [], // 확인한 대회 목록

                    // 대회 상세 모달 관련
                    showRallyModal: false,
                    selectedRally: {},

                    newReplyCount: 0 // 새 답변 개수
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

                                // 확인한 대회 목록 로드
                                self.loadCheckedRallies();

                                // NEW 대회 체크
                                self.checkNewRally();
                            } else {
                                console.log("오류");
                            }
                        }
                    });
                },

                // localStorage에서 확인한 대회 목록 불러오기
                loadCheckedRallies() {
                    const self = this;
                    const storageKey = `checkedRallies_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);

                    if (saved) {
                        try {
                            self.checkedRallies = JSON.parse(saved);
                            console.log("확인한 대회 목록:", self.checkedRallies);
                        } catch (e) {
                            self.checkedRallies = [];
                        }
                    } else {
                        self.checkedRallies = [];
                    }
                },

                // 확인한 대회 목록 저장
                saveCheckedRallies() {
                    const self = this;
                    const storageKey = `checkedRallies_${self.sessionId}`;
                    localStorage.setItem(storageKey, JSON.stringify(self.checkedRallies));
                    console.log("확인한 대회 저장 완료:", self.checkedRallies);
                },

                // 신규 대회 체크 (24시간 이내 등록 + 확인하지 않은 대회)
                checkNewRally() {
                    const self = this;

                    if (self.list.length === 0) {
                        self.hasNewRally = false;
                        return;
                    }

                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);

                    // 24시간 이내 등록되고 확인하지 않은 대회가 있는지 체크
                    const hasNew = self.list.some(rally => {
                        // cdate가 있는 경우 사용, 없으면 rallyDate 사용
                        const dateStr = rally.cdate || rally.rallyDate;

                        // 날짜 형식 파싱 (YY/MM/DD 또는 YYYY-MM-DD 형식 지원)
                        let rallyDate;
                        if (dateStr && dateStr.includes('/')) {
                            const parts = dateStr.split('/');
                            const year = parts[0].length === 2 ? '20' + parts[0] : parts[0];
                            rallyDate = new Date(year, parseInt(parts[1]) - 1, parseInt(parts[2]));
                        } else if (dateStr && dateStr.includes('-')) {
                            rallyDate = new Date(dateStr);
                        } else {
                            return false;
                        }

                        const isRecent = rallyDate > oneDayAgo;
                        const isNotChecked = !self.checkedRallies.includes(rally.rallyNo);

                        return isRecent && isNotChecked;
                    });

                    self.hasNewRally = hasNew;
                    console.log("NEW 배지 표시 여부:", hasNew);
                },

                // 개별 대회 항목이 신규인지 체크 (24시간 이내 등록 + 확인하지 않음)
                isNewRallyItem(rallyNo) {
                    const self = this;

                    // 이미 확인한 대회면 NEW 표시 안함
                    if (self.checkedRallies.includes(rallyNo)) {
                        return false;
                    }

                    // 해당 대회 찾기
                    const rally = self.list.find(r => r.rallyNo === rallyNo);
                    if (!rally) {
                        return false;
                    }

                    // 24시간 이내에 등록되었는지 확인
                    const now = new Date();
                    const oneDayAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000);

                    // cdate가 있는 경우 사용, 없으면 rallyDate 사용
                    const dateStr = rally.cdate || rally.rallyDate;

                    // 날짜 형식 파싱
                    let rallyDate;
                    if (dateStr && dateStr.includes('/')) {
                        const parts = dateStr.split('/');
                        const year = parts[0].length === 2 ? '20' + parts[0] : parts[0];
                        rallyDate = new Date(year, parseInt(parts[1]) - 1, parseInt(parts[2]));
                    } else if (dateStr && dateStr.includes('-')) {
                        rallyDate = new Date(dateStr);
                    } else {
                        return false;
                    }

                    return rallyDate > oneDayAgo;
                },

                // 대회 클릭 시 확인 처리
                markRallyAsChecked(rallyNo) {
                    const self = this;

                    // 확인한 대회로 표시
                    if (!self.checkedRallies.includes(rallyNo)) {
                        self.checkedRallies.push(rallyNo);
                        self.saveCheckedRallies();

                        // NEW 배지 상태 업데이트
                        self.checkNewRally();
                    }
                },

                fnLogout: function () {
                    let self = this;
                    self.clearSessionTimers();
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
                    pageChange("/home/community/board.do", {});
                },

                moveToCrew: function () {
                    pageChange("/home/community/crew.do", {});
                },

                // 사이드바 대회정보 메뉴 클릭 시 - 모든 대회 확인 처리
                moveToRally: function () {
                    let self = this;

                    // 현재 표시된 모든 대회를 확인 처리
                    self.list.forEach(rally => {
                        if (!self.checkedRallies.includes(rally.rallyNo)) {
                            self.checkedRallies.push(rally.rallyNo);
                        }
                    });

                    self.saveCheckedRallies();
                    self.hasNewRally = false;

                    // 페이지 이동
                    if (window.location.pathname === '/home/community/rally.do') {
                        location.reload();
                    } else {
                        pageChange("/home/community/rally.do", {});
                    }
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
                checkNewReplyCount: function () {
                    // alert("답변개수 확인 진입");
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
                                data.list.forEach(function (item) {
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
                        error: function () {
                            self.newReplyCount = 0;
                        }
                    });
                },

                // 대회 상세 모달 열기
                openRallyModal(rally) {
                    const self = this;
                    self.selectedRally = { ...rally };
                    self.showRallyModal = true;

                    // 대회 확인 처리
                    self.markRallyAsChecked(rally.rallyNo);

                    console.log("대회 상세 모달 열림:", rally);
                },

                // 대회 상세 모달 닫기
                closeRallyModal() {
                    this.showRallyModal = false;
                    this.selectedRally = {};
                },

                // ESC 키로 모달 닫기
                handleKeyDown(event) {
                    if (event.key === 'Escape' && this.showRallyModal) {
                        this.closeRallyModal();
                    }
                },

                // 이미지 로드 실패 시 처리
    handleImageError(event) {
        console.log("이미지 로드 실패");
        event.target.style.display = 'none';
        // 또는 기본 이미지로 교체
        // event.target.src = '/images/default-rally.jpg';
    },

            },
            mounted() {
                let self = this;
                self.fnList();
                self.fnGetUserInfo();

                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }

                self.checkNewReplyCount();

                //  ESC 키 이벤트 리스너 추가 
                window.addEventListener('keydown', self.handleKeyDown);
            },

            // beforeUnmount 추가 (컴포넌트 제거 시 이벤트 리스너 정리) 
            beforeUnmount() {
                let self = this;
                window.removeEventListener('keydown', this.handleKeyDown);
                self.removeActivityListeners();
                self.clearSessionTimers();
            }

        });

        app.mount('#app');
    </script>
    </body>

    </html>