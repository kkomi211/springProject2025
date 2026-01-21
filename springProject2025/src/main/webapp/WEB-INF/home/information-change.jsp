<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/mypage.css">
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="stylesheet" href="/css/modal-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <script src="/js/page-change.js"></script>
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

            .brand-name {
                /* top-header 내 brand-name */
                margin-right: 0;
                /* top-header div의 default margin-right 상쇄 */
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

            .brand-name a:hover {
                text-decoration: none;
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
                                            <li @click="moveToInquiry">
                                                <span class="icon">💬</span>
                                                <a href="#">문의 내역</a>
                                            </li>
                                            <li class="active">
                                                <span class="icon">👤</span>
                                                <a href="">나의 정보</a>
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
                                        회원가입정보 수정
                                    </h3>
                                    <section class="check-info">
                                        <table>
                                            <tr>
                                                <th>
                                                    이메일
                                                </th>
                                                <td>
                                                    <template v-if="!emailFlg">{{info.email}}</template>
                                                    <template v-else>
                                                        <input type="text" v-model="info.email" id="email" :disabled="!isDuplicated && saveBtn">
                                                    </template>
                                                </td>
                                                <td>
                                                    <template v-if="!emailFlg">
                                                        <button class="btn" @click="fnEmailChange">이메일 수정 </button>
                                                    </template>
                                                    <template v-else>
                                                        <button class="btn" @click="fnEmailCheck">중복확인 </button>
                                                        <button class="btn" v-if="saveBtn"
                                                            @click="fnEmailSave">저장</button>
                                                    </template>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>이름</th>
                                                <td>
                                                    <template v-if="!nameFlg">{{info.name}}</template>
                                                    <template v-else><input type="text" v-model="info.name"></template>
                                                </td>
                                                <td>
                                                    <button class="btn" v-if="!nameFlg" @click="fnNameChange">이름 수정
                                                    </button>
                                                    <button class="btn" v-if="nameFlg" @click="fnNameSave">저장</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>휴대폰번호</th>
                                                <td>
                                                    <template v-if="!phoneFlg ">{{info.phone}}</template>
                                                    <template v-else>
                                                        <input v-if="!timerFlg && !authSuccess" type="text"
                                                            v-model="inputNum" id="auth"
                                                            placeholder="하이픈(-) 없이 전화번호를 입력하세요">
                                                        <input v-else-if="timerFlg && !authSuccess" type="text"
                                                            placeholder="인증번호" v-model="authNum">
                                                        <input v-else type="text" v-model="inputNum" disabled>
                                                        <span>{{timer}}</span>
                                                    </template>
                                                </td>
                                                <td>
                                                    <button class="btn" v-if="!phoneFlg" @click="fnPhoneChange">휴대폰번호
                                                        수정</button>
                                                    <template v-if="authConfirm">
                                                        <template v-if="!smsFlg && !flg">
                                                            <button class="btn" @click="fnSms">인증번호 전송</button>
                                                        </template>
                                                        <template v-else-if="smsFlg && !authSuccess">
                                                            <button class="btn" @click="fnSmsAuth">인증</button>
                                                        </template>
                                                    </template>

                                                    <button class="btn" v-if="authSuccess"
                                                        @click="fnPhoneSave">저장</button>
                                                </td>
                                            </tr>
                                            <tr v-if="userType != 'K' ">
                                                <th>비밀번호 변경</th>
                                                <td>
                                                    <template v-if="!pwdFlg">
                                                        <div>
                                                            현재 비밀번호
                                                            <div><label for=""><input type="password" v-model="pwd"
                                                                        id="pwd"></label></div>
                                                        </div>
                                                        <div>
                                                            새 비밀번호
                                                            <div>
                                                                <label for=""><input type="password" v-model="newPwd1"
                                                                        id="newPwd1"></label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            비밀번호 재확인
                                                            <div>
                                                                <label for=""><input type="password" v-model="newPwd2"
                                                                        id="newPwd2"></label>
                                                            </div>
                                                        </div>
                                                    </template>
                                                    <template v-else>
                                                        <div>비밀번호 변경되었습니다.</div>
                                                    </template>
                                                </td>
                                                <td>
                                                    <button class="btn" @click="fnPwdChange">비밀번호 변경</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>배송지</th>
                                                <td>
                                                    <div v-if="!addrFlg">{{info.addr}}</div>
                                                    <div v-if="addrFlg"><input type="text" v-model="addr" id="addr"
                                                            disabled></div>
                                                </td>
                                                <td>
                                                    <button class="btn" v-if="!addrFlg" @click="fnAddr">주소 수정</button>
                                                    <button class="btn" v-if="addrFlg" @click="fnAddrSave">저장</button>
                                                </td>
                                            </tr>
                                        </table>
                                    </section>
                                    <div class="bottom-btn">
                                        <button class="btn" @click="fnConfirmDelete" style="background-color: black;color: white;border-radius: 8px; font-weight: 400;">탈퇴하기</button>
                                    </div>

                                    <!-- Popup asking the user really wants to delete their account -->

                                    <div v-if="confirmDelete" class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>정말로 이 계정을 삭제하시겠습니까?</h2>
                                            <button class="btn" @click="closeModal">돌아가기</button>
                                            <button class="btn" @click="fnDeleteAccount">삭제하기</button>
                                        </div>
                                    </div>

                                    <!-- Popup confirming the user deleted their account -->

                                    <div v-if="accountDeleted" class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>회원님의 계정이 삭제되었습니다.</h2>
                                            <button class="btn" @click="moveMainPage">닫기</button>
                                        </div>
                                    </div>



                                    <!-- If the user is not logged in -->

                                    <div v-if="!isLoggedIn" class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>로그인 후 이용해주세요.</h2>
                                            <div class="modal-btn">
                                                <button @click="moveToLogin">로그인</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Universal modal -->
                                     <div v-if="showModal" class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>{{ modalMessage }}</h2>
                                            <button @click="closeUniversalModal">확인</button>
                                        </div>
                                    </div>

                                    <!-- session time out modal -->
                                    <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>
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
            </div>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
            data() {
                return {
                    // 변수 - (key : value)
                    pwd: "",
                    sessionId: "${sessionId}",
                    userType: "${userType}",
                    info: {},
                    email: "",
                    addr: "",
                    pwd: "",
                    newPwd1: "",
                    newPwd2: "",

                    // Flags
                    emailFlg: false,
                    nameFlg: false,
                    phoneFlg: false,
                    saveBtn: false,
                    pwdFlg: false,
                    addrFlg: false,
                    flg: false,
                    isDuplicated: true,

                    // Popup Modal
                    confirmDelete: false,
                    accountDeleted: false,
                    isLoggedOut: false,
                    isLoggedIn: true,

                    // 인증
                    smsFlg: false,
                    joinFlg: false, // 문자 인증 유무
                    authFlag: false,
                    authConfirm: false,
                    timerFlg: false,
                    authSuccess: false,
                    authNum: "",

                    // HardCoding for test purposes
                    // ranStr: "111", // 문자 인증 번호 

                    ranStr : "",
                    inputNum: "",
                    timer: "",
                    count: 180,
                    interval: null,

                    cartCount: 0, // 장바구니 수량 변수 추가
                    shippingNotificationCount: 0, // 배송 알림 개수

                    // Universal modal
                    showModal: false,
                    modalMessage: '',
                    modalCallback: null,
                    timerInterval: null,
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                openModal: function(message, callback) {
                    this.modalMessage = message;
                    this.modalCallback = callback || null;
                    this.showModal = true;
                },
                
                closeUniversalModal: function() {
                    this.showModal = false;
                    if (this.modalCallback) {
                        this.modalCallback();
                        this.modalCallback = null;
                    }
                },
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
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnMypage: function (userId) {
                    let self = this;
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
                                alert("info checked successfully !");
                            } else {
                                alert("error");
                            }

                        }
                    });
                },
                moveToRefund: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    // const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    pageChange("/home/mypage/refund-return.do", { sessionId: self.sessionId });
                },
                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    // const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("/home/mypage/orders.do", { sessionId: self.sessionId });
                },
                moveToInquiry: function () {
                    let self = this;
                    pageChange("/home/mypage/my-inquiry.do", { sessionId: self.sessionId });
                },
                moveToReview: function () {
                    let self = this;
                    pageChange("/home/mypage/review.do", { sessionId: self.sessionId });
                },
                fnAddr: function () {
                    let self = this;
                    window.open("/addr.do", "addr", "width=500, height = 500");
                    self.addrFlg = true;
                },
                fnResult: function (roadFullAddr, addrDetail, zipNo) {
                    let self = this;
                    self.addr = roadFullAddr;
                },
                fnEmailChange: function () {
                    let self = this;
                    self.emailFlg = true;
                    self.isDuplicated = true;  // Reset to allow typing
                    self.saveBtn = false;      // Reset save button
                },
                fnNameChange: function () {
                    let self = this;
                    self.nameFlg = true;
                },
                fnPhoneChange: function () {
                    let self = this;
                    self.info.phone = "";
                    // document.querySelector("#phone").focus();
                    self.phoneFlg = true;
                    self.authConfirm = true;
                },
                fnEmailCheck: function () {
                    let self = this;
                    let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    
                    if (!emailPattern.test(self.info.email)) {
                        self.openModal("올바른 이메일 형식을 입력해주세요.", function() {
                            document.querySelector("#email").focus();
                        });
                        return;
                    }
                    
                    let param = {
                        email: self.info.email
                    };
                    console.log(self.info.email);
                    $.ajax({
                        url: "/home/mypage/emailCheck.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.openModal("사용가능한 이메일 입니다.", function() {
                                    self.saveBtn = true;
                                    self.isDuplicated = false;  // No duplicate, field gets disabled
                                });
                            } else {
                                self.openModal("이미 사용 중인 이메일 입니다.", function() {
                                    document.querySelector("#email").focus();
                                    self.saveBtn = false;
                                    self.isDuplicated = true;  // Duplicate exists, field stays enabled
                                });
                            }
                        }
                    });
                },
                fnEmailSave: function () {
                    let self = this;
                    if(self.isDuplicated){
                        self.openModal("이메일 중복 확인을 해주세요.");
                        return;
                    }
                    let param = {
                        userId: self.sessionId,
                        email: self.info.email
                    };
                    $.ajax({
                        url: "/home/mypage/emailSave.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.openModal("이메일이 수정되었습니다.", function() {
                                    self.emailFlg = false;
                                });
                            } else {
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnNameSave: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        name: self.info.name
                    };
                    console.log(self.info.name);
                    $.ajax({
                        url: "/home/mypage/nameSave.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.openModal("이름이 수정되었습니다.", function() {
                                    self.nameFlg = false;
                                });
                            } else {
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnPhoneSave: function () {
                    let self = this;
                    if (self.inputNum < 11 || !/^[0-9]+$/.test(self.inputNum)) {
                        self.openModal("전화번호를 다시 확인해주세요.", function() {
                            document.querySelector("#phone").focus();
                        });
                        return;
                    }
                    let param = {
                        userId: self.sessionId,
                        phone: self.inputNum
                    };
                    $.ajax({
                        url: "/home/mypage/phoneSave.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.openModal("전화번호가 수정되었습니다.", function() {
                                    self.authSuccess = false;
                                    self.smsFlg = false;
                                    self.phoneFlg = false;
                                    self.flg = true;
                                    self.info.phone = self.inputNum;
                                    location.reload();
                                });
                            } else {
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnPwdChange: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/home/login.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.fnPwdSave();
                            } else {
                                self.openModal("입력하신 비밀번호가 현재 비밀번호와 일치하지 않습니다.", function() {
                                    document.querySelector("#pwd").focus();
                                });
                            }
                        }
                    });
                },
                fnPwdSave: function () {
                    let self = this;
                    let speChar = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])/;

                    if (self.newPwd1 == "") {
                        self.openModal("새 비밀번호를 입력하세요.", function() {
                            document.querySelector("#newPwd1").focus();
                        });
                        return;
                    } 
                    if (self.newPwd1.length < 6 || !speChar.test(self.newPwd1)) {
                        self.openModal("비밀번호는 공백 없이 6자 이상의 영문자, 숫자, 특수문자 조합으로 지정해주세요.", function() {
                            document.querySelector("#newPwd1").focus();
                        });
                        return;
                    }
                    if (self.newPwd1 !== self.newPwd2) {
                        self.openModal("비밀번호가 서로 다릅니다.", function() {
                            document.querySelector("#newPwd2").focus();
                        });
                        return;
                    }
                    let param = {
                        userId: self.sessionId,
                        newPwd1: self.newPwd1
                    };
                    $.ajax({
                        url: "/home/changePwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result === "success") {
                                self.openModal("비밀번호 변경이 완료되었습니다!", function() {
                                    self.pwdFlg = true;
                                });
                            } else {
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnAddrSave: function () {
                    let self = this;
                    if (self.addr == "") {
                        self.openModal("주소를 입력해주세요.");
                        return;
                    }
                    let param = {
                        userId: self.sessionId,
                        addr: self.addr
                    };
                    $.ajax({
                        url: "/home/mypage/addrSave.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.openModal("주소가 수정되었습니다.", function() {
                                    self.addrFlg = false;
                                    self.fnInfo();
                                });
                            } else {
                                self.openModal("오류가 발생했습니다.");
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
                fnConfirmDelete: function () {
                    let self = this;
                    self.confirmDelete = true; // Modal Popup
                },
                fnDeleteAccount: function () {
                    let self = this;
                    let param = {
                        userId: self.sessionId
                    };
                    $.ajax({
                        url: "/home/mypage/deleteAccount.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                self.confirmDelete = false;
                                self.accountDeleted = true;
                                self.sessionId = "";
                            } else {
                                self.openModal("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                moveToLogin: function () {
                    let self = this;
                    location.href = "/home/login.do";
                },


                moveMainPage: function () {
                    let self = this;
                    location.href = "/home.do";
                },
                closeModal() {
                    let self = this;
                    self.confirmDelete = false;
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
                    });
                },
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
                fnSms: function () {
                    let self = this;
                    if (self.inputNum == "") {
                        self.openModal("인증번호를 입력해주세요.", function() {
                            document.querySelector("#auth").focus();
                        });
                        return;
                    }
                    if (self.inputNum < 11 || !/^[0-9]+$/.test(self.inputNum)) {
                        self.openModal("전화번호를 다시 확인해주세요.", function() {
                            document.querySelector("#auth").focus();
                        });
                        return;
                    }

                    // Hardcoding for test purposes
                    // self.smsFlg = true;
                    // self.timerFlg = true;
                    // self.fnTimer();
                    
                    let param = {
                        phone: self.inputNum
                    };

                    $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.res.statusCode == "2000") {
                                self.openModal("문자 전송 완료");
                                self.ranStr = data.ranStr;
                                self.smsFlg = true;
                                self.timerFlg = true;
                                
                                // Clear existing timer and reset count
                                if (self.timerInterval) {
                                    clearInterval(self.timerInterval);
                                }
                                self.count = 180;
                                self.fnTimer();
                            } else {
                                self.openModal("잠시 후 다시 시도해주세요.");
                            }
                        }
                    });
                },
                fnSmsAuth: function () {
                    let self = this;
                    
                    if (self.ranStr == self.authNum) {
                        self.openModal("문자 인증 완료되었습니다", function() {
                            self.authSuccess = true;
                            self.timerFlg = false;
                            if (self.timerInterval) {
                                clearInterval(self.timerInterval);
                                self.timerInterval = null;
                            }
                            self.joinFlg = true;
                            self.authFlag = true;
                        });
                    } else {
                        self.openModal("문자인증 실패했습니다.", function() {
                            self.joinFlg = false;
                        });
                    }
                },
                fnTimer: function () {
                    let self = this;
                    self.timerInterval = setInterval(function () {
                        if (self.count == 0) {
                            clearInterval(self.timerInterval);
                            self.timerInterval = null;
                            self.openModal("시간이 만료되었습니다!");
                            self.smsFlg = false;
                            self.inputNum = "";
                            self.timerFlg = false;
                        } else {
                            let min = parseInt(self.count / 60);
                            let sec = self.count % 60;

                            min = min < 10 ? "0" + min : min;
                            sec = sec < 10 ? "0" + sec : sec;
                            self.timer = min + " : " + sec;

                            self.count--;
                        }
                    }, 1000);
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                }
            },
            // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;
                self.fnInfo();
                console.log("User ID : " + self.userId);
                if (self.sessionId == "") {
                    self.isLoggedIn = false;
                } else {
                    self.isLoggedIn = true;
                }

                // 장바구니 수량 조회
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkShippingNotificationCount(); // 배송 알림 개수 체크
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
                
                // 주기적으로 배송 알림 체크 (30초마다)
                setInterval(function() {
                    if (self.sessionId && self.sessionId !== '') {
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