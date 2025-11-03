<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>주문서</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            /* 주문서 페이지 스타일 */
            .paybefore-body {
                background-color: white;
            }

            .main-content-wrapper {
                padding: 40px 0;
                max-width: 1200px;
                margin: 0 auto;
            }

            .main-title {
                text-align: center;
                font-size: 32px;
                font-weight: 500;
                margin-bottom: 50px;
                border-bottom: 1px solid #ccc;
                padding-bottom: 20px;
            }

            .order-layout {
                display: flex;
                justify-content: space-between;
                gap: 40px;
                margin-bottom: 40px;
            }

            .delivery-info {
                flex: 2;
                min-width: 50%;
            }

            .delivery-info-box {
                border: 1px solid #ccc;
                padding: 25px;
                background: #fff;
            }

            .delivery-info-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }

            .delivery-info-title {
                font-size: 20px;
                font-weight: bold;
                margin: 0;
            }

            .btn-change-address {
                color: #000;
                border: 1px solid #ccc;
                padding: 8px 15px;
                background: #fff;
                cursor: pointer;
                font-size: 14px;
            }

            .delivery-info-content {
                margin-bottom: 20px;
            }

            .delivery-info-content label {
                display: block;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 8px;
            }

            .delivery-info-content input {
                width: 100%;
                height: 30px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 20px;
                margin-bottom: 15px;
            }

            .delivery-phone {
                font-size: 20px;
                color: #666;
                margin: 5px 0;
            }

            .delivery-request-section {
                margin-top: 25px;
            }

            .delivery-request-section label {
                display: block;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .delivery-request-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 20px;
            }

            .payment-summary {
                flex: 1;
                min-width: 300px;
                padding: 25px;
                border: 1px solid #ccc;
                height: fit-content;
                background: #fff;
            }

            .payment-summary-title {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .summary-item-border {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }

            .summary-discount {
                color: #e74c3c;
            }

            .summary-delivery-free {
                color: #27ae60;
            }

            .summary-total {
                display: flex;
                justify-content: space-between;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .summary-total-amount {
                color: #000;
            }

            .btn-payment {
                width: 100%;
                padding: 15px;
                background: #000;
                color: #fff;
                border: none;
                font-size: 16px;
                cursor: pointer;
                font-weight: bold;
            }

            .ordered-items {
                border: 1px solid #ccc;
                padding: 25px;
                background: #fff;
                width: 60%;
            }

            .ordered-items-title {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }

            .order-items-list {
                display: flex;
                flex-direction: column;
                gap: 0;
            }

            .order-item {
                display: flex;
                padding: 25px 0;
                align-items: flex-start;
            }

            .order-item:not(:last-child) {
                border-bottom: 1px solid #eee;
            }

            .order-item-image {
                width: 120px;
                height: 120px;
                object-fit: cover;
                margin-right: 20px;
                border: 1px solid #eee;
                flex-shrink: 0;
                border-radius: 4px;
            }

            .order-item-image-placeholder {
                background: #f0f0f0;
                width: 120px;
                height: 120px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 20px;
                flex-shrink: 0;
                font-size: 12px;
                color: #666;
                border: 1px solid #eee;
                border-radius: 4px;
            }

            .product-info {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .product-name {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }

            .product-detail {
                font-size: 14px;
                color: #666;
                margin-bottom: 6px;
            }

            .product-price {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 15px;
                color: #000;
            }

            .btn-coupon {
                color: #000;
                border: 1px solid #ccc;
                padding: 8px 15px;
                background: #fff;
                cursor: pointer;
                font-size: 14px;
                align-self: flex-start;
                margin-top: 5px;
            }

            .empty-order-message {
                text-align: center;
                padding: 50px;
                color: #999;
            }

            /* 주소 변경 모달 스타일 - cart.jsp와 동일한 스타일 */
            .modal-overlay-address {
                position: fixed;
                inset: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(0, 0, 0, 0.35);
                z-index: 1000;
            }

            .modal-content-address {
                width: 420px;
                background: #fff;
                border-radius: 12px;
                padding: 22px;
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
                position: relative;
                font-family: "Noto Sans KR", sans-serif;
            }

            .modal-title-address {
                margin: 0 0 14px;
                text-align: center;
                font-size: 18px;
                font-weight: 700;
            }

            .address-body {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            /* 각 필드 */
            .address-field {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
            }

            .address-field label {
                width: 85px;
                font-size: 13px;
                color: #333;
            }

            .address-input {
                width: calc(100% - 95px);
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                background: #fff;
            }

            .address-field-with-button {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 12px;
            }

            .address-field-with-button label {
                width: 85px;
                font-size: 13px;
                color: #333;
                margin-top: 8px;
            }

            .address-input-group-content {
                width: calc(100% - 95px);
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .address-textarea {
                width: calc(100% - 24px);
                min-height: 60px;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                background: #fff;
                resize: vertical;
                line-height: 1.5;
            }

            .btn-address-search {
                color: #000;
                border: 1px solid #ccc;
                padding: 8px 15px;
                background: #fff;
                cursor: pointer;
                font-size: 14px;
                align-self: flex-start;
            }

            .modal-actions-address {
                display: flex;
                justify-content: space-between;
                gap: 10px;
                margin-top: 18px;
            }
        </style>
    </head>

    <body class="paybefore-body">
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
                    <main class="main-content-wrapper">
                        <h1 class="main-title">주문서</h1>

                        <div class="order-layout">
                            <!-- 배송 정보 (왼쪽) -->
                            <div class="delivery-info">
                                <div class="delivery-info-box">
                                    <div class="delivery-info-header">
                                        <h2 class="delivery-info-title">배송 정보</h2>
                                        <button @click="fnChangeDeliveryAddress" class="btn-change-address">
                                            수신인 배송지 변경</button>
                                    </div>

                                    <div class="delivery-info-content">
                                        <label>수신인</label>
                                        <input type="text" v-model="deliveryInfo.name" placeholder="수신인 이름을 입력하세요"
                                            disabled style="width: 40%;">

                                        <label>주소</label>
                                        <!--<input type="text" v-model="deliveryInfo.addr" placeholder="배송 주소를 입력하세요" disabled style="width: 96%;">-->
                                        <textarea v-model="deliveryInfo.addr" placeholder="배송 주소를 입력하세요"
                                            class="delivery-request-input" disabled style="width: 96%; resize: none;">
                                        </textarea>

                                        <p class="delivery-phone">전화번호: {{ deliveryInfo.phone }}</p>
                                    </div>

                                    <div class="delivery-request-section">
                                        <label>배송 요청 사항</label>
                                        <input type="text" v-model="orderRequest" placeholder="최대 50자까지 입력 가능합니다."
                                            maxlength="50" class="delivery-request-input" style="width: 96%;">
                                        <!--<textarea v-model="orderRequest" placeholder="최대 50자까지 입력 가능합니다." maxlength="50"
                                            class="delivery-request-input" style="width: 96%; resize: none;"></textarea>-->
                                    </div>
                                </div>
                            </div>

                            <!-- 결제 금액 (오른쪽) -->
                            <div class="payment-summary">
                                <h2 class="payment-summary-title">결제 금액</h2>
                                <div class="summary-item">
                                    <span>상품 금액</span>
                                    <span>{{ formatCurrency(totalProductPrice) }}원</span>
                                </div>
                                <div class="summary-item">
                                    <span>할인 금액</span>
                                    <span class="summary-discount">{{ formatCurrency(totalDiscount) }}원</span>
                                </div>
                                <div class="summary-item-border">
                                    <span>배송비</span>
                                    <span v-if="deliveryFee === 0" class="summary-delivery-free">무료배송</span>
                                    <span v-else>{{ formatCurrency(deliveryFee) }}원</span>
                                </div>

                                <div class="summary-total">
                                    <span>총 결제 금액</span>
                                    <span class="summary-total-amount">{{ formatCurrency(totalPaymentAmount) }}원</span>
                                </div>

                                <button @click="fnProceedToPayment" class="btn-payment">
                                    {{ formatCurrency(totalPaymentAmount) }}원 결제하기
                                </button>
                            </div>
                        </div>

                        <!-- 주문 상품 목록 -->
                        <div class="ordered-items">
                            <h2 class="ordered-items-title">주문 상품 {{ selectedItems.length }} 종류</h2>

                            <div class="order-items-list">
                                <template v-for="(item, index) in selectedItems"
                                    :key="item.cartNo || item.productNo || index">
                                    <section class="order-item">
                                        <img v-if="item.imgPath && item.imgName"
                                            :src="item.imgPath + '/' + item.imgName" :alt="item.productName"
                                            class="order-item-image">
                                        <div v-else class="order-item-image-placeholder">
                                            이미지 없음</div>

                                        <div class="product-info">
                                            <div>
                                                <p class="product-name">{{ item.productName }}</p>
                                                <p class="product-detail">수량: {{ item.quantity }} / 사이즈 : {{
                                                    item.productSize || 'FREE' }}</p>
                                                <p class="product-detail">주문번호: {{ fnGenerateOrderNumber(item, index) }}
                                                </p>
                                                <p class="product-price">상품가격 : {{ formatCurrency(parseInt(item.price) *
                                                    parseInt(item.quantity || 1)) }}원</p>
                                            </div>

                                            <button @click="fnUseCoupon(item)" class="btn-coupon">
                                                쿠폰 사용</button>
                                        </div>
                                    </section>
                                </template>

                                <div v-if="selectedItems.length === 0" class="empty-order-message">
                                    주문할 상품이 없습니다.
                                </div>
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
                            <span>회사소개</span>
                            <span>매장안내</span>
                            <span>공지사항</span>
                            <span>이용약관</span>
                            <span>개인정보처리방침</span>
                        </div>
                        <div class="socials">
                            <span>INSTAGRAM</span>
                            <span>NAVER</span>
                        </div>
                    </div>
                </footer>
            </div>

            <!-- 주소 변경 모달 -->
            <div id="addressChangeModal" class="modal-overlay-address" style="display: none;">
                <div class="modal-content-address">
                    <h3 class="modal-title-address">배송지 변경</h3>

                    <div class="address-body">
                        <div class="address-field">
                            <label>수신인</label>
                            <input type="text" v-model="tempDeliveryInfo.name" placeholder="수신인 이름을 입력하세요"
                                class="address-input">
                        </div>

                        <div class="address-field-with-button">
                            <label>주소</label>
                            <div class="address-input-group-content">
                                <textarea v-model="tempDeliveryInfo.addr" placeholder="주소를 검색해주세요" disabled
                                    class="address-textarea" rows="3"></textarea>
                                <button @click="fnAddr" class="btn-address-search">주소 검색</button>
                            </div>
                        </div>

                        <div class="address-field">
                            <label>전화번호</label>
                            <input type="text" v-model="tempDeliveryInfo.phone" placeholder="전화번호를 입력하세요"
                                class="address-input">
                        </div>
                    </div>

                    <div class="modal-actions-address">
                        <button @click="closeAddressModal" class="btn btn-secondary">취소</button>
                        <button @click="confirmAddressChange" class="btn btn-primary">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>
        IMP.init("imp03303441"); // Iamport 가맹점 아이디 초기화
        // Vue 인스턴스를 전역에서 접근 가능하도록 'app' 변수로 선언
        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    userName: "로딩중...",
                    selectedItems: [],
                    deliveryInfo: {
                        name: "",
                        addr: "",
                        phone: "",
                        email: ""
                    },
                    tempDeliveryInfo: {
                        name: "",
                        addr: "",
                        phone: "",
                        email: ""
                    },
                    orderRequest: "",
                    totalProductPrice: 0,
                    totalDiscount: 0,
                    deliveryFee: 0
                };
            },
            computed: {
                totalPaymentAmount() {
                    return this.totalProductPrice - this.totalDiscount + this.deliveryFee;
                }
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                fnGenerateOrderNumber: function (item, index) {
                    // 간단한 주문번호 생성 (실제로는 서버에서 생성)
                    // 각 상품마다 고유한 번호를 생성하기 위해 index 추가
                    const timestamp = Date.now();
                    const random = Math.floor(Math.random() * 10000);
                    const baseNumber = String(timestamp).slice(-8) + String(random).padStart(4, '0');
                    return baseNumber + String(index || 0).padStart(2, '0');
                },
                fnUseCoupon: function (item) {
                    alert("쿠폰 기능은 준비 중입니다.");
                },
                fnChangeDeliveryAddress: function () {
                    // 모달 열기 전 현재 배송지 정보를 임시 변수에 복사
                    this.tempDeliveryInfo = {
                        name: this.deliveryInfo.name,
                        addr: this.deliveryInfo.addr,
                        phone: this.deliveryInfo.phone,
                        email: this.deliveryInfo.email
                    };
                    $('#addressChangeModal').fadeIn(200);
                    $('body').css('overflow', 'hidden');
                },
                closeAddressModal: function () {
                    $('#addressChangeModal').fadeOut(200);
                    $('body').css('overflow', 'auto');
                },
                confirmAddressChange: function () {
                    // 임시 정보를 실제 배송지 정보로 적용
                    this.deliveryInfo = {
                        name: this.tempDeliveryInfo.name,
                        addr: this.tempDeliveryInfo.addr,
                        phone: this.tempDeliveryInfo.phone,
                        email: this.tempDeliveryInfo.email
                    };
                    this.closeAddressModal();
                },
                fnAddr: function () {
                    // 주소 검색 팝업 열기
                    window.open("/home/addr.do", "addr", "left=600, top=200, width=500, height=500");
                },
                fnProceedToPayment: function () {
                    let self = this;

                    // 결제 상품명 생성
                    let productName = "";
                    if (self.selectedItems.length > 0) {
                        if (self.selectedItems.length === 1) {
                            productName = self.selectedItems[0].productName;
                        } else {
                            productName = self.selectedItems[0].productName + " 외 " + (self.selectedItems.length - 1) + "건";
                        }
                    } else {
                        productName = "주문결제";
                    }

                    // 결제 처리
                    IMP.request_pay({
                        pg: "html5_inicis",
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: productName,
                        amount: self.totalPaymentAmount,
                        buyer_name: self.deliveryInfo.name || "",
                        buyer_email: self.deliveryInfo.email || "",
                        buyer_tel: self.deliveryInfo.phone || "000-0000-0000",
                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("결제는 성공");
                            console.log(rsp);
                            alert("결제돌아온 data" + JSON.stringify(rsp));
                            // self.fnPayHistory(rsp.imp_uid, rsp.paid_amount); //order테이블 업데이트 예정
                            self.fnPayOrderI(rsp.imp_uid, rsp.paid_amount //order테이블 인서트 
                                , self.deliveryInfo // 배송 정보 객체 전체
                                , self.orderRequest  // 배송 요청 사항
                            );
                            // self.fnProductU(rsp.imp_uid, rsp.paid_amount //Product테이블 재고량 변경 XX 
                            //     , self.deliveryInfo // 배송 정보 객체 전체
                            //     , self.orderRequest  // 배송 요청 사항
                            // );  
                            // self.fnCartD(rsp.imp_uid, rsp.paid_amount //Cart테이블 인서트 재고량 변경 XX
                            //     , self.deliveryInfo // 배송 정보 객체 전체
                            //     , self.orderRequest  // 배송 요청 사항
                            // );  
                        } else {
                            // 결제 실패 시
                            alert("결제 및 주문 실패");
                        }
                    });
                },
                fnPayOrderI: function (uid, amount, deliveryInfo, orderRequest) { //order테이블 업데이트 예정 amount는 카드사에서 돌아온값
                    alert("fnPayOrderI 진입 " + uid + " " + amount + " " + deliveryInfo + " " + orderRequest);
                    let self = this;


                    // **[추가]** 배송 주소(addr)를 deliveryInfo에서 추출합니다.
                    let deliveryAddress = deliveryInfo.addr; // deliveryInfo의 주소 필드명에 맞게 사용
                    let paymentMethod = "CARD"; // 결제 수단도 인수로 받거나 여기서 명시 가능 다 카드임,

                    // 1. selectedItems를 복사하여 개별 상품의 paymentAmount를 계산합니다.
                    let itemsToOrder = JSON.parse(JSON.stringify(self.selectedItems));

                    // 2. 각 주문 항목에 paymentAmount 필드를 추가 (price * quantity)
                    itemsToOrder.forEach(item => {
                        let price = parseInt(item.price);
                        let quantity = parseInt(item.quantity);

                        // **개별 상품의 최종 결제 금액 (DB ORDERS 테이블에 한 건씩 들어갈 금액)**
                        item.paymentAmount = price * quantity;

                        // 전달받은 주소 정보와 요청 사항을 할당
                        item.addr = deliveryAddress;
                        item.paymentMethod = paymentMethod;
                        item.orderRequest = orderRequest;
                        item.userId = self.sessionId; // self에 남아있는 데이터는 그대로 사용
                    });

                    // 3. 수정된 리스트를 JSON 문자열로 변환합니다.
                    let orderItemsJson = JSON.stringify(itemsToOrder);
                    // alert("서버로 보내줄 orderItemsJson " + orderItemsJson);
                    // alert("서버로 보내줄 값uid " + JSON.stringify(uid));
                    // alert("서버로 보내줄 값amount " + JSON.stringify(amount));
                    // alert("서버로 보내줄 값userId " + JSON.stringify(self.sessionId));
                    let param = {
                        // 기존 카트 번호 리스트 (삭제 처리 등에 사용될 수 있음)
                        selectedCartNosJson: '${selectedCartNos != null ? selectedCartNos : ""}',

                        // **새로 추가할 파라미터**: 주문할 상품들의 상세 정보
                        orderItemsJson: orderItemsJson,

                        // 4. 전체 결제 금액은 결제사에서 받은 'amount'를 사용 (별도의 파라미터 키로 서버에 전달)
                        //    카드사 IMP 응답에서 받은 amount(총 결제 금액)가 param으로 사용의도.
                        uid: uid,
                        amount: amount,
                        userId: self.sessionId,

                    };
                    //console.log("서버에 결제 히스토리 저장(order테이블)을 위한 param: " + JSON.stringify(param));
                    $.ajax({
                        url: "/home/payment/payOrderI.dox", //order테이블 업데이트 예정
                        dataType: "json",
                        type: "POST",
                        // jQuery는 기본적으로 객체를 'application/x-www-form-urlencoded'로 직렬화하여 보냅니다.
                        // Vue 데이터 바인딩된 객체는 자동으로 폼 데이터처럼 전송되지만, 
                        // 배열/객체를 문자열로 JSON.stringify() 했으므로 문제 없음?...
                        data: param,
                        success: function (data) {
                            //console.log("결제 히스토리 저장 결과: " + JSON.stringify(data));
                            if (data.result == "success") {

                                // alert("결제후 주문처리 success응답 옴");
                                // alert("결제후 주문처리 success응답 data"+ JSON.stringify(data));
                                // 주문 상품명 생성 (여러 상품인 경우 첫 번째 상품명 + 외 N건)
                                let productName = "";
                                if (self.selectedItems.length > 0) {
                                    if (self.selectedItems.length === 1) {
                                        productName = self.selectedItems[0].productName;
                                    } else {
                                        productName = self.selectedItems[0].productName + " 외 " + (self.selectedItems.length - 1) + "건";
                                    }
                                } else {
                                    productName = "주문상품";
                                }

                                // alert("결제후 주문처리 완료되었습니다.");
                                // 주문 완료 페이지로 이동 - 주문 정보 전달
                                if (typeof pageChange === 'function') {
                                    pageChange("/home/payment/payafter.do", {
                                        orderItems: JSON.stringify(self.selectedItems),
                                        totalAmount: self.totalPaymentAmount,
                                        paymentMethod: "신용카드",
                                        productName: productName,
                                        orderDate: data.orderDate
                                    });
                                }
                            } else {
                                alert("결제 후 주문 처리에 실패했습니다.");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("결제 히스토리 저장 실패:", error);
                            alert("결제 후 주문 처리 중 오류가 발생했습니다.");
                        }
                    });
                },
                fnGetUserInfo: function () {
                    let self = this;
                    $.ajax({
                        url: "/home/mypage/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: { userId: self.sessionId },  // sessionId를 userId로 전달
                        success: function (data) {
                            console.log("사용자 정보:", data);
                            if (data && data.result === 'success' && data.info) {
                                // 사용자 이름 설정
                                self.userName = data.info.name || "Guest";
                                // 배송 정보 설정
                                self.deliveryInfo.name = data.info.name || "";
                                self.deliveryInfo.addr = data.info.addr || "";
                                self.deliveryInfo.phone = data.info.phone || "";
                                self.deliveryInfo.email = data.info.email || "";
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("사용자 정보 조회 실패:", error);
                            // 에러 발생 시 기본값 설정
                            self.userName = "Guest";
                            self.deliveryInfo.name = "";
                            self.deliveryInfo.addr = "";
                            self.deliveryInfo.phone = "";
                            self.deliveryInfo.email = "";
                        }
                    });
                },
                fnInitSelectedItems: function () {
                    let self = this;
                    // 서버에서 전달받은 cartNo 목록 가져오기 (기존 프로젝트 스타일)
                    // pageChange가 JSON.stringify한 문자열이 파라미터로 전달됨
                    const selectedCartNosJson = '${selectedCartNos != null ? selectedCartNos : ""}';

                    if (!selectedCartNosJson || selectedCartNosJson.trim() === "") {
                        alert("주문할 상품이 없습니다. 장바구니로 이동합니다.");
                        if (typeof pageChange === 'function') {
                            pageChange("/home/cart.do", { sessionId: self.sessionId });
                        }
                        return;
                    }

                    // AJAX로 선택된 상품 정보 조회 (기존 프로젝트 스타일 - cartItemDelete와 동일)
                    let param = {
                        sessionId: self.sessionId,
                        selectedCartNosJson: selectedCartNosJson
                    };

                    $.ajax({
                        url: "/home/payment/selectedCartItems.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("선택된 상품 목록 응답:", data);
                            if (data && data.result === "success") {
                                self.selectedItems = data.list || [];
                                self.fnCalculateTotals();
                            } else {
                                alert("주문 상품 정보를 불러올 수 없습니다. 장바구니에서 다시 선택해주세요.");
                                if (typeof pageChange === 'function') {
                                    pageChange("/home/cart.do", { sessionId: self.sessionId });
                                }
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX 요청 실패:", error);
                            alert("주문 상품 정보를 불러오는 중 오류가 발생했습니다.");
                            if (typeof pageChange === 'function') {
                                pageChange("/home/cart.do", { sessionId: self.sessionId });
                            }
                        }
                    });
                },
                fnCalculateTotals: function () {
                    let self = this;
                    let total = 0;
                    self.selectedItems.forEach(item => {
                        const price = parseInt(item.price) || 0;
                        const quantity = parseInt(item.quantity || 1);
                        total += price * quantity;
                    });
                    self.totalProductPrice = total;
                    self.totalDiscount = 0;
                    self.deliveryFee = total >= 50000 || total === 0 ? 0 : 3000;
                }
            },
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnGetUserInfo(); // 사용자 이름과 배송 정보를 함께 가져옴
                self.fnInitSelectedItems();
                // 전역 변수로 Vue 앱 설정 (주소 검색 콜백에서 접근하기 위함)
                window.paybeforeApp = this;
            }
        });

        app.mount('#app');
    </script>

    <!-- 주소 검색 API 콜백 함수 -->
    <script>
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log("주소 검색 결과:", roadFullAddr);
            console.log("상세 주소:", addrDetail);
            console.log("우편번호:", zipNo);

            // 전역 변수로 저장된 Vue 앱 인스턴스에서 주소 설정
            if (window.paybeforeApp) {
                window.paybeforeApp.tempDeliveryInfo.addr = roadFullAddr;
            }
        }
    </script>