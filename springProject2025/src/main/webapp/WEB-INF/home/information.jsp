<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/mypage.css">
        <link rel="stylesheet" href="/css/modal-style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>

        <!-- Icons -->
        <script src="https://unpkg.com/lucide@latest"></script>
        <!-- session timeout modal -->
        <script src="/js/session-timeout.js"></script>

        <style>
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

            .brand-name div {
                font-family: 'Jost', sans-serif;
                font-size: 60px;
                font-weight: 900;
                letter-spacing: 3px;
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
                font-size: 25px;
                /* default bottom-header 폰트 사이즈 */
                background-color: white;
                /* bottom-header 배경색 추가 */
                border-bottom: 1px solid #eee;
                /* 하단 경계선 */
                padding: 20px 0;
                /* 세로 패딩 */
                letter-spacing: 3px;
            }

            .bottom-header a:hover {
                text-decoration: none;
                transform: scale(1.1);
                transition: transform 0.3s ease-out;
                /* faster ease-out */
            }

            .bottom-header a {
                color: black;
                transition: transform 0.2s ease-in;
                /* slower ease-in */
                display: inline-block;
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

            /* .bottom-header a:hover {
                color: #007bff;
            } */

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

            .container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #fff;
            }

            main {
                flex: 1;
                /* makes main take up all remaining vertical space */
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
                <!-- <header>
                    <div class="top-header">
                        <div class="brand-name">
                            <div><a href="/home.do">RUNNERS' HOUSE</a></div>
                        </div>
                        <div id="right-items">
                            <div>
                                    <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i data-lucide="log-out" stroke-width="1.5"></i></a></div>
                            
                                    <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a></div>
                              
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
                            <a href="javascript:;" @click="fnSale">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header> -->
                <%-- 공통 헤더 컴포넌트 --%>
                    <jsp:include page="/WEB-INF/header/header.jsp" />

                    <main>
                        <main>
                            <div class="header">
                                <div class="header-welcome">
                                    Welcome,
                                </div>
                                <div class="header-user">
                                    {{ info.name }}
                                </div>
                            </div>

                            <div class="page-container">
                                <aside class="sidebar">
                                    <h2 class="sidebar-heading">MY PAGE ></h2>
                                    <nav class="mypage-menu">
                                        <ul>
                                            <li @click="moveToOrder" style="position: relative;">
                                                <span class="icon">📝</span>
                                                <a href="#">주문•배송 내역</a>
                                                <span v-if="shippingNotificationCount > 0" style="position: absolute; top: 50%; transform: translateY(-50%); right: 30px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5);">{{ shippingNotificationCount > 99 ? '99+' : shippingNotificationCount }}</span>
                                            </li>
                                            <li @click="moveToRefund">
                                                <span class="icon">📦</span>
                                                <a href="javascript:;">반품•교환 내역</a>
                                            </li>
                                            <li @click="moveToMyinquiry" style="position: relative;">
                                                <span class="icon">💬</span>
                                                <a href="#">문의 내역</a>
                                                <span v-if="newReplyCount > 0" style="position: absolute; top: 50%; transform: translateY(-50%); right: 30px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5);">{{ newReplyCount > 99 ? '99+' : newReplyCount }}</span>
                                            </li>
                                            <li @click="mvInfo" class="active">
                                                <span class="icon">👤</span>
                                                <a href="#">나의 정보</a>
                                            </li>
                                            <li @click="moveToReview">
                                                <span class="icon">⭐️</span>
                                                <a href="#">상품 리뷰</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </aside>

                                <main class="main-content">
                                    <h1 class="main-title">나의 정보</h1>
                                    <h3 class="sub-title">
                                        회원가입정보 확인
                                        <div>
                                            안전한 정보보호를 위해 비밀번호를 다시 한번 확인합니다. 다시 입력해주세요.
                                        </div>
                                    </h3>
                                    <section class="check-info">
                                        <table>
                                            <tr>
                                                <th>아이디</th>
                                                <td>
                                                    <input type="text" v-model="info.userId" disabled>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>비밀번호</th>
                                                <td>
                                                    <input type="password" v-model="pwd" id="pwd"
                                                        @keyup.enter="fnMypage(info.userId)">
                                                </td>
                                            </tr>
                                        </table>
                                    </section>
                                    <div class="bottom-btn">
                                        <button @click="fnMypage(info.userId)" class="btn" style="background-color: black;color: white;border-radius: 8px; font-weight: 400; width: 100px;">확인</button>
                                    </div>
                                    
                                    <!-- Popup for empty passsword field -->

                                    <div v-if="emptyField" class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>비밀번호를 입력해주세요.</h2>
                                            <button class="btn" @click="closeModal">닫기</button>
                                        </div>
                                    </div>

                                    <!-- Popup message confirming password is correct -->

                                    <div v-if="pwdMatch" class="modal-overlay">
                                        <div class="modal-content">
                                            <template v-if="pwdCorrect == true">
                                                <h2>비밀번호가 확인되었습니다.</h2>
                                                <button class="btn" @click="moveInfoPage">확인</button>
                                            </template>
                                            <template v-else-if="pwdCorrect == false">
                                                <h2>비밀번호가 올바르지 않습니다.</h2>
                                                <button class="btn" @click="closeModal">돌아가기</button>
                                            </template>
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
                        <!-- session time out modal -->
                        <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>
            </div>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
            data() {
                return {
                    // 변수 - (key : value)
                    pwd: "",
                    sessionId: "${sessionId}",
                    info: {},

                    // Modal Popup
                    pwdMatch: false,
                    pwdCorrect: null,
                    isLoggedOut: false,
                    emptyField: false,

                    userType: '${userType}',
                    cartCount: 0, // 장바구니 수량 변수 추가
                    newReplyCount: 0, // 새 답변 개수
                    shippingNotificationCount: 0, // 배송 알림 개수
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId
                    };
                    $.ajax({
                        url: "/home/mypage/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log(data);
                                self.info = data.info;
                            } else {
                                alert("error");
                            }

                        }
                    });
                },
                fnMypage: function (userId) {
                    let self = this;
                    if (self.pwd == "") {
                        self.emptyField = true;
                        document.querySelector("#pwd").focus();
                        return;
                    }
                    let param = {
                        userId: userId,
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/home/mypage/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.pwdMatch = true;
                                self.pwdCorrect = true;
                            } else {
                                self.pwdMatch = true;
                                self.pwdCorrect = false;
                            }

                        }
                    });
                },

                // 장바구니 수량을 서버에서 가져오는 함수
                fetchCartCount() {
                    // 세션 아이디가 없으면 실행하지 않음
                    if (this.sessionId == '' || this.sessionId == null) return;

                    let self = this;
                    $.ajax({
                        url: '/api/cartCount.dox',
                        method: 'GET',
                        // ★ 서버의 @RequestParam HashMap map으로 전달될 데이터 ★
                        data: {
                            sessionId: self.sessionId
                        },
                        dataType: 'json',
                        success: (response) => {
                            console.log("서버 응답 데이터:", response);
                            if (response.result === 'success') {
                                self.cartCount = response.count; // 서버에서 보낸 count 값을 Vue 변수에 저장
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
                
                // 배송 알림 개수 체크 (문의내역 방식과 동일)
                checkShippingNotificationCount: function() {
                    let self = this;
                    if (!self.sessionId || self.sessionId === '') {
                        self.shippingNotificationCount = 0;
                        return;
                    }
                    
                    // localStorage에서 확인한 배송 주문 목록 불러오기
                    const storageKey = `checkedShippingOrders_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);
                    let checkedOrders = [];
                    if (saved) {
                        try {
                            checkedOrders = JSON.parse(saved);
                        } catch (e) {
                            checkedOrders = [];
                        }
                    }
                    
                    // 서버에서 주문 목록 가져오기 (모든 주문)
                    $.ajax({
                        url: "/home/mypage/orders.dox",
                        dataType: "json",
                        type: "POST",
                        data: {
                            sessionId: self.sessionId,
                            page: 1,
                            pageSize: 1000, // 모든 주문 가져오기
                            startRow: 1,
                            endRow: 1000
                        },
                        success: function (data) {
                            if (data.result == "success" && data.list) {
                                let uncheckedCount = 0;
                                data.list.forEach(function(order) {
                                    // 배송중 상태이고 확인하지 않은 주문만 카운트
                                    if (order.status === '배송중' && !checkedOrders.includes(String(order.orderNo))) {
                                        uncheckedCount++;
                                    }
                                });
                                self.shippingNotificationCount = uncheckedCount;
                                console.log("배송 알림 개수:", uncheckedCount);
                            } else {
                                self.shippingNotificationCount = 0;
                            }
                        },
                        error: function() {
                            self.shippingNotificationCount = 0;
                        }
                    });
                },

                moveInfoPage: function () {
                    let self = this;
                    pageChange("information/change.do", { sessionId: self.sessionId });
                },
                moveToRefund: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    // const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    pageChange("refund-return.do", { sessionId: self.sessionId });
                },
                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    // const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("/home/mypage/orders.do", { sessionId: self.sessionId });
                },
                closeModal() {
                    let self = this;
                    self.pwdMatch = false;
                    self.emptyField = false;
                },

                mvInfo: function () {
                    let self = this;
                    // console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");
                    // alert(
                    //     "mvInfo함수 시작"
                    // )
                    // let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("/home/mypage/information.do", {});
                },

                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("orders.do", { sessionId: sessionId });
                },

                moveToMyinquiry: function () {
                    let self = this;

                    let sessionId = self.sessionId;

                    pageChange("my-inquiry.do", { sessionId: sessionId });
                },

                moveToReview: function () {
                    let self = this;

                    let sessionId = self.sessionId;

                    pageChange("review.do", { sessionId: sessionId });
                },
                moveToRefund: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    window.pageChange("refund-return.do", { sessionId: sessionId });
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
                self.fnInfo();

                // 장바구니 수량 조회
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkNewReplyCount(); // 새 답변 개수 체크
                    self.checkShippingNotificationCount(); // 배송 알림 개수 체크
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
                
                // 주기적으로 새 답변 및 배송 알림 체크 (30초마다)
                setInterval(function() {
                    if (self.sessionId && self.sessionId !== '') {
                        self.checkNewReplyCount();
                        self.checkShippingNotificationCount();
                    }
                }, 30000);
            },
            beforeUnmount() {
                let self = this;
                self.removeActivityListeners();
                self.clearSessionTimers();
            }
        });

        app.mount('#app');
    </script>