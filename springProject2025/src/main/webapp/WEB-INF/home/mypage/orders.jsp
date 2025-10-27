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
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

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
                                <input type="text" placeholder="검색어를 입력해 주세요.">
                            </div>
                            <div>
                                <a href="/home/login.do">로그인</a>
                            </div>
                            <div>
                                <a href="/home/signup.do">가입하기</a>
                            </div>
                            <div><a href="/home/mypage/inquery.do">문의</a></div>
                            <div><a href="/home/cart.do">장바구니</a></div>
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
                            Harry Potter
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
                                    <li>
                                        <span class="icon">📦</span>
                                        <a href="#">반품•교환 내역</a>
                                    </li>
                                    <li>
                                        <span class="icon">💬</span>
                                        <a href="#">문의 내역</a>
                                    </li>
                                    <li>
                                        <span class="icon">👤</span>
                                        <a href="#">나의 정보</a>
                                    </li>
                                    <li>
                                        <span class="icon">⭐️</span>
                                        <a href="#">상품 리뷰</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="main-content">
                            <h1 class="main-title">주문•배송 내역</h1>

                            <template v-for="(order, index) in orderList.slice(0, 4)" :key="order.orderNo">
                                <section class="order-item">
                                    <div class="order-status-header" :class="getStatusClass(order.status)">
                                        ORDER STATUS :
                                        <span class="status-text">{{ order.status }}</span>
                                    </div>
                                    <div class="order-details">
                                        <img v-if="order.imgPath" :src="order.imgPath + '/' + order.imgName" :alt="order.productName" class="product-image" style="width: 150px; height: 150px; object-fit: cover;">
                                        <div v-else class="product-image" style="background: #f0f0f0; min-width: 150px; height: 150px; display: flex; align-items: center; justify-content: center;">
                                            이미지 없음
                                        </div>
                                        <div class="product-info" style="flex: 1; margin-left: 20px;">
                                            <p class="product-name" style="font-size: 18px; font-weight: bold;">상품명 : {{ order.productName || order.productNo }}</p>
                                            <p>수량 : {{ order.quantity }}</p>
                                            <p>주문번호 : {{ order.orderNo }}</p>
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


                            <div class="pagination">
                                <a href="#" class="arrow">&lt;</a>
                                <a href="#" class="page-num active">1</a>
                                <a href="#" class="page-num">2</a>
                                <a href="#" class="page-num">3</a>
                                <a href="#" class="page-num">4</a>
                                <a href="#" class="arrow">&gt;</a>
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
        </div>
    </body>

    </html>

    <script>
        // Vue 인스턴스를 전역에서 접근 가능하도록 'app' 변수로 선언
        const app = Vue.createApp({
            data() {
                return {
                    // Mybatis 연결 전, ORDERS 테이블 데이터를 기반으로 더미 목록 설정
                    orderList: [
                        { ORDER_NO: 101, USER_ID: 'user123', C_DATE: '25/10/26', PRODUCT_NO: 1002, QUANTITY: 2, PAYMENT_AMOUNT: 378000, ADDR: '서울시 강남구...', STATUS: '신규주문', PRODUCT_NAME: '울트라부스트 22', PRODUCT_IMAGE: 'running-shoes-men.jpg' }, // 취소 가능 (규칙 19, 20)
                        { ORDER_NO: 102, USER_ID: 'testuser1', C_DATE: '25/10/27', PRODUCT_NO: 1004, QUANTITY: 1, PAYMENT_AMOUNT: 229000, ADDR: '경기도 성남시...', STATUS: '배송중', PRODUCT_NAME: '엔드로핀 스피드 3', PRODUCT_IMAGE: 'energy-gel.jpg' }, // 교환/반품 가능 (규칙 21)
                        { ORDER_NO: 103, USER_ID: 'user123', C_DATE: '25/10/20', PRODUCT_NO: 1001, QUANTITY: 1, PAYMENT_AMOUNT: 139000, ADDR: '인천광역시 부평구...', STATUS: '배송완료', PRODUCT_NAME: '에어 줌 페가수스 40', PRODUCT_IMAGE: 'running-shoes-women.jpg' }, // 교환/반품 및 후기 작성 가능 (규칙 21)
                        { ORDER_NO: 104, USER_ID: 'testuser2', C_DATE: '25/10/17', PRODUCT_NO: 1007, QUANTITY: 3, PAYMENT_AMOUNT: 117000, ADDR: '부산광역시 해운대구...', STATUS: '교환요청', PRODUCT_NAME: '드라이핏 러닝 티셔츠', PRODUCT_IMAGE: 'running-top-women.jpg' }, // 버튼 없음
                        { ORDER_NO: 107, USER_ID: 'testuser1', C_DATE: '25/09/07', PRODUCT_NO: 1008, QUANTITY: 1, PAYMENT_AMOUNT: 49000, ADDR: '대전광역시 유성구...', STATUS: '취소완료', PRODUCT_NAME: '러닝 5인치 팬츠', PRODUCT_IMAGE: 'running-top-women.jpg' }, // 버튼 없음
                        { ORDER_NO: 115, USER_ID: 'testuser2', C_DATE: '25/10/24', PRODUCT_NO: 1006, QUANTITY: 1, PAYMENT_AMOUNT: 259000, ADDR: '경기도 성남시...', STATUS: '취소요청', PRODUCT_NAME: 'NEW BALANCE 990v6', PRODUCT_IMAGE: 'running-shoes-men.jpg' }, // 버튼 없음
                    ],
                    currentCancelOrderNo: null, // 취소할 주문 번호를 저장
                    //sessionId: "${sessionId}",
                    sessionId: "user_john",
                };
            },
            methods: {
                formatCurrency: function(value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                fnList: function () {
                    let self = this;
                    let param = {
                        sessionId : self.sessionId,
                        // kind: self.kind,
                        // order: self.order,
                        // keyword: self.keyword,
                        // searchOption: self.searchOption,

                        // pageSize: self.pageSize,
                        // page: (self.page - 1) * self.pageSize,
                    };
                    $.ajax({
                        url: "/home/mypage/orders.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("리스트 뭐 어쩃든 성공~~~~~");
                            console.log(data);
                            if (data.list && data.list.length > 0) {
                                self.orderList = data.list;
                                console.log("주문 리스트 업데이트 완료:", self.orderList);
                            } else {
                                console.log("주문 내역이 없습니다.");
                                self.orderList = [];
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX 요청 실패:", error);
                            console.error("상태:", status);
                        }
                    });
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
                    if (actionType === 'RETURN') {
                        console.log(`ORDER_NO ${orderNo}: 교환/반품 페이지로 이동 요청`);
                        alert(`ORDER_NO ${orderNo}에 대해 교환/반품 페이지로 이동합니다. (규칙 21)`);

                    } else if (actionType === 'REVIEW') {
                        console.log(`ORDER_NO ${orderNo}: 상품 후기 작성 페이지로 이동 요청`);
                        alert(`ORDER_NO ${orderNo}에 대해 상품 후기 작성 페이지로 이동합니다.`);
                    }
                },

                /** 주문 취소 처리 (팝업 내 '주문 취소' 버튼 클릭 시) */
                processCancel: function () {
                    const orderNo = this.currentCancelOrderNo;
                    const reason = $('#cancelReasonInput').val();

                    if (!reason.trim()) {
                        alert('취소 사유를 반드시 입력해주세요.');
                        return;
                    }

                    console.log(`ORDER_NO ${orderNo} 주문 취소 요청. 사유: ${reason}`);

                    // TODO: 여기에 실제 주문 취소 AJAX (Mybatis) 호출 로직 작성

                    alert(`[${orderNo}] 주문이 취소 요청되었습니다. (사유: ${reason})\n*DB 업데이트 로직 필요*`);

                    // 팝업 닫기 및 필드 초기화
                    // Vue 내부에서 전역 함수 호출
                    window.closeCancelModal();
                    // 성공 시: 목록 새로고침 로직 호출 (fnList() 등)
                }
            }, // methods
            mounted() {
                let self = this;
                self.fnList(); // 실제 데이터 조회 시작
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
        $(document).ready(function () {
            $('#cancelModal').on('click', function (e) {
                if ($(e.target).is('#cancelModal')) {
                    window.closeCancelModal();
                }
            });
        });
    </script>