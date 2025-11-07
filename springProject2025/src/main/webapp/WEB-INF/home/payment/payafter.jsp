<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>결제 완료 - RUNNERS' HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            body {
                background-color: white;
            }

            .payment-complete-container {
                max-width: 800px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            .payment-complete-icon {
                width: 120px;
                height: 120px;
                margin: 40px auto 30px;
                position: relative;
            }

            .payment-complete-icon svg {
                width: 100%;
                height: 100%;
            }

            .payment-complete-title {
                text-align: center;
                font-size: 48px;
                font-weight: 300;
                color: #666;
                margin: 20px 0;
            }

            .payment-complete-message {
                text-align: center;
                margin: 30px 0 50px;
            }

            .payment-complete-message p {
                font-size: 18px;
                color: #333;
                margin: 10px 0;
            }

            .payment-complete-message .thank-you {
                font-size: 20px;
                font-weight: 500;
                margin-top: 15px;
            }

            .order-summary-section {
                margin: 50px 0;
            }

            .order-summary-title {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #333;
            }

            .order-summary-table {
                width: 100%;
                border-collapse: collapse;
            }

            .order-summary-table tr {
                border: 1px solid #e0e0e0;
            }

            .order-summary-table td {
                padding: 20px;
            }

            .order-summary-table td:first-child {
                width: 150px;
                background-color: #f5f5f5;
                font-weight: 500;
                text-align: left;
                border-right: 1px solid #e0e0e0;
            }

            .order-summary-table td:last-child {
                background-color: white;
                text-align: left;
            }

            .payment-method-detail {
                display: block;
                margin-top: 8px;
                font-size: 14px;
                color: #666;
            }

            .action-buttons {
                display: flex;
                gap: 20px;
                margin-top: 50px;
                justify-content: center;
            }

            .action-buttons button {
                flex: 1;
                max-width: 200px;
                padding: 15px 30px;
                font-size: 16px;
                font-weight: 500;
                border: 1px solid #000;
                background-color: white;
                color: #000;
                cursor: pointer;
                transition: all 0.3s;
            }

            .action-buttons button:hover {
                background-color: #000;
                color: white;
            }

            .action-buttons button.primary {
                background-color: #000;
                color: white;
            }

            .action-buttons button.primary:hover {
                background-color: #333;
            }
             /* New CSS from homepage */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #333;
        }
        #app { /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
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
        header { /* default 헤더 스타일이 header 태그에 직접 적용되도록 재구성 */
            width: 100%;
            background-color: black; /* default top-header의 배경색을 header 전체로 */
            color: white; /* default top-header의 글자색을 header 전체로 */
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .top-header { /* default top-header가 header의 유일한 자식이 됨 */
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 150px; /* default top-header의 높이 */
            padding: 0 40px; /* default footer padding과 맞춤 */
            box-sizing: border-box; /* 패딩이 width에 포함되도록 */
        }
        .top-header div {
            display: inline-block;
            text-align: left;
            font-size: 15px;
            margin-right: 0; /* flex gap 사용을 위해 개별 div 마진 제거 */
        }
        .top-header input {
            height: 25px;
            border-radius: 8px;
            width: 200px;
        }

        .brand-name { /* top-header 내 brand-name */
            margin-right: 0; /* top-header div의 default margin-right 상쇄 */
        }
        .brand-name div {
            font-family: 'Fugaz One', sans-serif;
            font-size: 60px;
            letter-spacing: 5px;
            margin-left: 0; /* top-header div의 default margin-left 상쇄 */
            display: block;
            color: white; /* default 유지 */
        }
        .brand-name a {
            color: white;
        }

        #right-items {
            display: flex;
            align-items: center;
            gap: 20px; /* 요소들 간 간격 */
        }
        #right-items div {
            font-size: 15px;
            white-space: nowrap;
        }
        #right-items div a {
            color: white; /* default top-header의 글자색 */
        }
        #right-items div a:hover {
            color: #eee;
        }

        .bottom-header {
            display: flex;
            justify-content: center;
            font-size: 30px; /* default bottom-header 폰트 사이즈 */
            background-color: white; /* bottom-header 배경색 추가 */
            /* border-bottom: 1px solid #eee; 하단 경계선 */
            padding: 20px 0; /* 세로 패딩 */
        }
        .bottom-header div {
            display: inline-block;
            margin-right: 100px; /* default bottom-header div의 마진 */
            margin-top: 0; /* flex-align으로 중앙 정렬 */
            text-align: center;
        }
        .bottom-header div:last-child {
            margin-right: 0;
        }
        .bottom-header a {
            color: black; /* default bottom-header 링크색 */
        }
        .bottom-header a:hover {
            color: #007bff;
        }

                /* --- Footer Section (화면 전체 너비) --- */
        footer { /* default 푸터 스타일 */
            width: 100%;
            height: 200px;
            background-color: black;
            color: white;
            align-items: center;
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            padding: 0 40px; /* default footer의 padding */
            box-shadow: 0 -2px 4px rgba(0,0,0,0.1);
            margin-top: auto; /* #app이 flex-direction: column일 때 푸터를 아래로 밀어냄 */
            box-sizing: border-box; /* 패딩이 width에 포함되도록 */
        }

        .footer-left {
            margin-left: 0; /* padding이 있으므로 margin-left 제거 */
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

                <main>
                    <div class="header">
                        <div class="header-welcome">
                            Welcome,
                        </div>
                        <div class="header-user">
                            {{ userName }}
                        </div>
                    </div>

                    <div class="payment-complete-container">
                        <h1 class="payment-complete-title">결제 완료</h1>

                        <div class="payment-complete-icon">
                            <svg viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg">
                                <!-- 쇼핑백 외곽선 -->
                                <path d="M30 30 L30 100 L90 100 L90 30 Z" fill="none" stroke="#d32f2f" stroke-width="4"
                                    stroke-linecap="round" stroke-linejoin="round" />
                                <!-- 쇼핑백 손잡이 -->
                                <path d="M30 30 Q60 20 90 30" fill="none" stroke="#d32f2f" stroke-width="4"
                                    stroke-linecap="round" />
                                <!-- 체크 표시 -->
                                <path d="M40 60 L55 75 L80 50" fill="none" stroke="#d32f2f" stroke-width="6"
                                    stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </div>

                        <div class="payment-complete-message">
                            <p>결제가 완료되었습니다.</p>
                            <p class="thank-you">감사합니다.</p>
                        </div>

                        <div class="order-summary-section">
                            <h2 class="order-summary-title">주문 요약 정보</h2>
                            <table class="order-summary-table">
                                <tr>
                                    <td>결제수단</td>
                                    <td>
                                        {{ orderInfo.paymentMethod || '신용카드' }}
                                        <span class="payment-method-detail">
                                            결제금액 : {{ formatCurrency(orderInfo.paymentAmount) }}원
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>주문일자</td>
                                    <td>{{ orderDate }}</td>
                                </tr>
                                <tr>
                                    <td>주문상품</td>
                                    <td>{{ orderInfo.productName || '상품명' }}</td>
                                </tr>
                            </table>
                        </div>

                        <div class="action-buttons">
                            <button @click="goToMain">메인으로</button>
                            <button class="primary" @click="goToOrderHistory">주문내역 확인</button>
                        </div>
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
                    orderInfo: {
                        paymentMethod: "${paymentMethod != null ? paymentMethod : '신용카드'}",
                        paymentAmount: "${totalAmount != null ? totalAmount : 0}",
                        // orderDate: "",
                        productName: "${productName != null ? productName : '주문상품'}"
                    },
                    orderItems: [],
                    orderDate: "${orderDate}",
                    userType : '${userType}',
                };
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                // getCurrentDate: function () {
                //     const now = new Date();
                //     const year = now.getFullYear();
                //     const month = String(now.getMonth() + 1).padStart(2, '0');
                //     const day = String(now.getDate()).padStart(2, '0');
                //     const hours = String(now.getHours()).padStart(2, '0');
                //     const minutes = String(now.getMinutes()).padStart(2, '0');
                //     const seconds = String(now.getSeconds()).padStart(2, '0');
                //     return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
                // },
                goToMain: function () {
                    // if (typeof pageChange === 'function') {
                    //     pageChange("home.do", { sessionId: this.sessionId });
                    // } else {
                    window.location.href = "/home.do";
                    // }
                },
                goToOrderHistory: function () {
                    // if (typeof pageChange === 'function') {
                    //     pageChange("mypage/orders.do", { sessionId: this.sessionId });
                    // } else {
                    window.location.href = "/home/mypage/orders.do";
                    // }
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
                fnSale(){
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
            },
            mounted() {
                let self = this;
                self.fnGetUserInfo();
                // 주문 날짜 자동 설정
                // self.orderInfo.orderDate = self.getCurrentDate();

                // 주문 상품 목록 파싱 (전달받은 JSON 문자열을 객체로 변환)
                const orderItemsJson = '${orderItems != null ? orderItems : "[]"}';
                try {
                    self.orderItems = JSON.parse(orderItemsJson);
                    console.log("주문 상품 목록:", self.orderItems);
                } catch (e) {
                    console.error("주문 상품 목록 파싱 실패:", e);
                    self.orderItems = [];
                }
            }
        });

        app.mount('#app');
    </script>