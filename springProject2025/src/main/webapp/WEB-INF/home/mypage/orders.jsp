<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="stylesheet" href="/css/mypage.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>

    </head>
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
                            <h2 class="sidebar-heading">MY PAGE ></h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li class="active">
                                        <span class="icon">📝</span>
                                        <a href="#">주문•배송 내역</a>
                                    </li>
                                    <li @click="moveToRefund">
                                        <span class="icon">📦</span>
                                        <a href="javascript:;">반품•교환 내역</a>
                                    </li>
                                    <li @click="moveToMyinquiry">
                                        <span class="icon">💬</span>
                                        <a href="#">문의 내역</a>
                                    </li>
                                    <li @click="moveToInfo">
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
                            <h1 class="main-title">주문•배송 내역</h1>

                            <template v-for="(order, index) in orderList" :key="order.orderNo">
                                <section class="order-item">
                                    <div class="order-status-header" :class="getStatusClass(order.status)">
                                        ORDER STATUS :
                                        <span class="status-text">{{ order.status }}</span>
                                    </div>
                                    <div class="order-details">
                                        <!-- <img v-if="order.imgPath && order.imgName"
                                            :src="order.imgPath + '/' + order.imgName" :alt="order.productName"
                                            class="product-image"
                                            style="width: 150px; height: 150px; object-fit: cover;"> -->
                                        <img v-if="order.imgPath" :src="order.imgPath" :alt="order.productName"
                                            class="product-image"
                                            style="width: 150px; height: 150px; object-fit: contain;">
                                        <div v-else class="product-image"
                                            style="background: #f0f0f0; min-width: 150px; height: 150px; display: flex; align-items: center; justify-content: center;">
                                            이미지 없음
                                        </div>
                                        <div class="product-info" style="flex: 1; margin-left: 20px;">
                                            <p class="product-name" style="font-size: 18px; font-weight: bold;">상품명 : {{
                                                order.productName || order.productNo }}</p>
                                            <p>수량 : {{ order.quantity }}</p>
                                            <p>주문번호 : {{ order.orderNo }}</p>
                                            <p>브랜드 : {{ order.brand }}</p>
                                            <p>상품가격 : {{ formatCurrency(order.paymentAmount) }}원</p>
                                            <p>주문일자 : {{ order.cdate }}</p>
                                        </div>

                                        <div class="order-actions">
                                            <button v-if="getButtonState(order.status) === 'CANCEL'"
                                                class="btn btn-cancel" @click="openCancelModal(order.orderNo)">
                                                주문 취소
                                            </button>

                                            <template v-else-if="getButtonState(order.status) === 'RETURN'">
                                                <button class="btn btn-return"
                                                    @click="handleAction('RETURN', order.orderNo)">
                                                    교환•반품
                                                </button>
                                            </template>

                                            <button v-if="order.status === '배송완료'" class="btn btn-review"
                                                @click="handleAction('REVIEW', order.orderNo)">
                                                상품 후기
                                            </button>
                                        </div>
                                    </div>
                                </section>
                            </template>

                            <div v-if="orderList.length === 0" style="text-align: center; padding: 50px;">
                                주문 내역이 없습니다.
                            </div>


                            <div v-if="index > 0" class="pagination">
                                <!-- <a v-if="page != 1" @click="fnMove(1)" href="javascript:void(0)">←</a> -->
                                <a v-if="page >= 2" @click="fnMove(page - 1)" href="javascript:void(0)">◀</a>
                                <a @click="fnMove(num)" id="index" href="javascript:void(0)" v-for="num in index"
                                    :key="num">
                                    <span :class="{ active: page == num }">{{ num }}</span>
                                </a>
                                <a v-if="page != index" @click="fnMove(page + 1)" href="javascript:void(0)">▶</a>
                                <!-- <a v-if="page != index" @click="fnMove(index)" href="javascript:void(0)">→</a> -->
                            </div>
                        </main>
                    </div>
                </main>

                <div id="cancelModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3 class="modal-title">주문 취소 확인</h3>
                        <p>정말 주문을 취소하시겠습니까?</p>
                        <div class="cancel-reason">
                            <label for="cancelReasonInput">취소 사유 입력</label>
                            <textarea id="cancelReasonInput" rows="4"></textarea>
                        </div>
                        <div class="modal-actions">
                            <button class="btn btn-secondary" onclick="closeCancelModal()">돌아가기</button>
                            <button class="btn btn-primary" @click="processCancel()">주문 취소</button>
                        </div>
                    </div>
                </div>


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
        // Vue 인스턴스를 전역에서 접근 가능하도록 'app' 변수로 선언
        const app = Vue.createApp({
            data() {
                return {
                    orderList: [],
                    cnt: 0,
                    page: 1,
                    pageSize: 4,
                    index: 0,
                    currentCancelOrderNo: null,
                    sessionId: "${sessionId}",
                    userName: "로딩중...",
                    userType : '${userType}',
                };
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                fnList: function () {
                    let self = this;
                    let startRow = (self.page - 1) * self.pageSize + 1;
                    let endRow = self.page * self.pageSize;
                    let param = {
                        sessionId: self.sessionId,
                        page: self.page,
                        pageSize: self.pageSize,
                        startRow: startRow,
                        endRow: endRow
                    };
                    $.ajax({
                        url: "/home/mypage/orders.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("리스트 응답 데이터:", data);
                            if (data.result == "success") {
                                self.orderList = data.list;
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);
                                console.log("주문 리스트 업데이트 완료 - 전체 개수:", self.cnt, "현재 페이지:", self.page);
                            } else {
                                console.log("주문 내역 조회 실패");
                                self.orderList = [];
                                self.cnt = 0;
                                self.index = 0;
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX 요청 실패:", error);
                            console.error("상태:", status);
                        }
                    });
                },

                fnMove: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
                },



                /** 주문 취소 팝업을 여는 Vue 메서드 (버튼 클릭 시 호출) */
                // 문제 해결: HTML 템플릿의 @click 이벤트에서 이 Vue 메서드를 호출합니다.
                openCancelModal: function (orderNo) {
                    this.currentCancelOrderNo = orderNo; // Vue 데이터에 주문 번호 저장
                    $('#cancelModal').fadeIn(200); // jQuery로 모달 표시
                    $('body').css('overflow', 'hidden');
                },

                /** 주문 상태에 따른 버튼 표시 결정 (핵심 로직) */
                getButtonState: function (status) {
                    // 규칙 19, 20: '신규주문' 또는 '주문 확인 중'일 때 즉시 취소 가능
                    const cancellableStatuses = ['신규주문', '주문 확인 중'];
                    if (cancellableStatuses.includes(status)) {
                        return 'CANCEL';
                    }

                    // 규칙 21: '배송 준비 중', '배송 중', '배송 완료' 시 반품 절차로 진행
                    const returnableStatuses = ['배송 준비 중', '배송중', '배송완료'];
                    if (returnableStatuses.includes(status)) {
                        return 'RETURN';
                    }

                    // 그 외 상태 (취소요청, 교환요청, 완료된 상태 등)
                    return 'NONE';
                },

                /** 주문 상태별 CSS 클래스 반환 */
                getStatusClass: function (status) {
                    if (['신규주문', '주문 확인 중'].includes(status)) return 'status-confirming';
                    if (status === '배송중') return 'status-shipping';
                    if (status === '배송완료') return 'status-delivered';
                    if (['취소완료', '반품완료', '교환완료', '취소요청', '반품요청', '교환요청'].includes(status)) return 'status-processed';
                    return '';
                },

                /** 교환/반품 또는 리뷰 버튼 클릭 시 처리 */
                handleAction: function (actionType, orderNo) {
                    let self = this;
                    if (actionType === 'RETURN') {
                        console.log(`ORDER_NO ${orderNo}: 교환/반품 페이지로 이동 요청`);
                        // alert(`ORDER_NO ${orderNo}에 대해 교환/반품 페이지로 이동합니다. (규칙 21)`);

                        pageChange("refund-return.do", { orderNo: orderNo, sessionId: self.sessionId });
                    }

                    else if (actionType === 'REVIEW') {
                        console.log(`ORDER_NO ${orderNo}: 상품 후기 작성 페이지로 이동 요청`);
                        // alert(`ORDER_NO ${orderNo}에 대해 상품 후기 작성 페이지로 이동합니다.`);
                        pageChange("review.do", { orderNo: orderNo, sessionId: self.sessionId });
                    }
                },

                /** 주문 취소 처리 (팝업 내 '주문 취소' 버튼 클릭 시) */
                processCancel: function () {
                    let self = this;
                    const orderNo = self.currentCancelOrderNo;
                    const reason = $('#cancelReasonInput').val();

                    if (!reason.trim()) {
                        alert('취소 사유를 반드시 입력해주세요.');
                        return;
                    }

                    console.log(`ORDER_NO ${orderNo} 주문 취소 요청. 사유: ${reason}`);

                    let param = {
                        orderNo: orderNo,
                        because: reason,
                        sessionId: self.sessionId
                    };

                    $.ajax({
                        url: "/home/mypage/cancel.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("주문 취소 응답:", data);
                            if (data.result == "success") {
                                const cancelOrderNo = self.currentCancelOrderNo || orderNo || "주문";
                                alert("[" + cancelOrderNo + "] 주문이 취소 요청되었습니다.");
                                // 팝업 닫기 및 필드 초기화
                                window.closeCancelModal();
                                // 목록 새로고침
                                self.fnList();
                            } else {
                                alert('주문 취소 요청에 실패했습니다. 다시 시도해주세요.');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("주문 취소 AJAX 실패:", error);
                            alert('주문 취소 요청 중 오류가 발생했습니다.');
                        }
                    });
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
                moveToRefund: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    pageChange("refund-return.do", { sessionId: sessionId });
                },
                moveToInfo: function () {
                    let self = this;
                    console.log("나의 정보 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    // const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("/home/mypage/information.do", { sessionId: self.sessionId });
                    // window.pageChange("refund-return.do", { sessionId: sessionId });
                },
                moveToReview: function () {
                    let self = this;

                    let sessionId = self.sessionId;

                    pageChange("review.do", { sessionId: sessionId });
                },
                moveToMyinquiry: function () {
                    let self = this;

                    let sessionId = self.sessionId;

                    pageChange("my-inquiry.do", { sessionId: sessionId });
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
                },
            }, // methods
            mounted() {
                let self = this;
                self.fnList(); // 실제 데이터 조회 시작
                self.fnGetUserInfo(); // 사용자 정보 조회
            }
        });

        app.mount('#app');


        /* 팝업 제어 JavaScript 함수 (Vue 인스턴스 밖, window 스코프) */

        // 주문 취소 팝업 닫기: '돌아가기' 버튼이나 오버레이 클릭 시 호출됩니다.
        // Vue 인스턴스 외부에서 `app` 객체를 사용하여 Vue 데이터를 조작합니다.
        window.closeCancelModal = function () {
            $('#cancelModal').fadeOut(200);
            $('body').css('overflow', 'auto');

            // Vue 데이터 초기화 (app이 전역 변수로 선언되어 있어야 합니다)
            if (app && app.currentCancelOrderNo !== null) {
                app.currentCancelOrderNo = null;
            }
            $('#cancelReasonInput').val('');
        }

        // 오버레이(배경) 클릭 시 팝업 닫기
        // $(document).ready(function () {
        //     $('#cancelModal').on('click', function (e) {
        //         if ($(e.target).is('#cancelModal')) {
        //             window.closeCancelModal();
        //         }
        //     });
        // });
    </script>