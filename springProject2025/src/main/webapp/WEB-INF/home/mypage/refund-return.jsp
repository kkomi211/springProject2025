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
        <script src="/js/page-change.js"></script>

    </head>
    <style>
        textarea {
            /* !important를 사용하여 다른 CSS보다 우선순위를 높입니다. */
            resize: none !important;
        }

        .main-content {
            position: relative;
            /* 버튼 기준점을 주기 위해 필요 */
        }

        .main-content button {
            display: block;
            /* 버튼을 블록요소로 만들어 */
            margin-left: auto;
            /* 오른쪽으로 밀어냄 */
            margin-top: 1px;
            /* 위 요소와의 간격 */
            margin-right: 5px;
            /* 오른쪽 여백 (조절 가능) */
            padding: 10px 20px;
            background-color: rgb(194, 194, 194);
            color: black;
            border: none;
            border-radius: 5px;

            cursor: pointer;
            /* 마우스 올렸을 때 손가락 커서 */
            transition: background-color 0.3s ease, transform 0.2s ease;
            /* 부드러운 변화 */
        }

        /*  hover 효과 */
        .main-content button:hover {
            background-color: gray;
            /*  */
            transform: scale(1.02);
            /* 살짝 커지는 느낌 */
        }


        /*포지션픽스는 나중을 위해 주석처리*/
        /* .main-content button {
            position: fixed;
            right: 30px;
            bottom: 30px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
        } */
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
                            {{ userName }}
                        </div>
                    </div>

                    <div class="page-container">
                        <aside class="sidebar">
                            <h2 class="sidebar-heading">MY PAGE ></h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li @click="moveToOrder">
                                        <span class="icon">📝</span>
                                        <a href="javascript:;">주문•배송 내역</a>
                                    </li>
                                    <li class="active">
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
                            <h1 class="main-title">반품•교환 내역</h1>

                            <template v-for="(order, index) in orderList" :key="order.orderNo">

                                <section class="order-item">

                                    <div class="order-status-header" :class="getStatusClass(order.status)">
                                        ORDER STATUS :
                                        <span class="status-text">{{ order.status }}</span>
                                    </div>

                                    <div class="order-details" style="display: flex; align-items: center;">
                                        <div>
                                            <!-- {{index}} -->
                                            <input type="checkbox" v-model="order.isChecked"
                                                style="transform: scale(1.5); margin-right: 10px; transform-origin: left center;">
                                        </div>
                                        <img v-if="order.imgPath && order.imgName"
                                            :src="order.imgPath + '/' + order.imgName" :alt="order.productName"
                                            class="product-image"
                                            style="width: 150px; height: 150px; object-fit: cover;">
                                        <div v-else class="product-image"
                                            style="background: #f0f0f0; min-width: 150px; height: 150px; display: flex; align-items: center; justify-content: center;">
                                            이미지 없음
                                        </div>
                                        <div class="product-info" style="flex: 1; margin-left: 20px;">
                                            <p class="product-name" style="font-size: 18px; font-weight: bold;">상품명 : {{
                                                order.productName || order.productNo }}</p>
                                            <p>수량 : {{ order.quantity }}</p>
                                            <p>주문번호 : {{ order.orderNo }}</p>
                                            <p>상품가격 : {{ formatCurrency(order.paymentAmount) }}원</p>
                                            <p>주문일자 : {{ order.cdate }}</p>
                                        </div>

                                        <div>
                                            <div>
                                                <label style="margin-right: 10px;">
                                                    <input type="radio" v-model="order.actionType" value="R">반품
                                                </label>
                                                <label>
                                                    <input type="radio" v-model="order.actionType" value="C">교환
                                                </label>
                                                <br>
                                                <div>
                                                    반품교환사유
                                                </div>
                                                <div>
                                                    <textarea type="text" style="height: 80px; width: 250px;"
                                                        placeholder="상세사유입력" v-model="order.reason"></textarea>
                                                </div>
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

                            <button @click="submitReturnExchange">
                                반품/교환 신청
                            </button>

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

            <!-- 안내용 모달: 상세사유 비어있을 때 표시 (닫기만 가능) -->
            <div v-if="reasonModalVisible" class="modal-overlay" @click.self="closeReasonModal">
                <div class="modal" role="dialog" aria-modal="true" aria-labelledby="reasonModalTitle">
                    <h3 id="reasonModalTitle">상세사유를 입력해 주세요</h3>
                    <p>선택하신 주문 중 상세사유가 입력되지 않은 항목이 있습니다. 상세사유를 입력한 후 다시 신청해 주세요.</p>

                    <div class="missing-list">
                        <div v-for="m in missingReasons" :key="m.orderNo">
                            주문번호: <strong>{{ m.orderNo }}</strong> — (아직 사유 미입력)
                        </div>
                    </div>

                    <div class="btns">
                        <button class="btn secondary" @click="closeReasonModal">닫기</button>
                    </div>
                </div>
            </div>

        </div><!--app끝-->

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
                    sessionId: "${sessionId}", //다른쪽에서 세션아이디를 넣어야 보임
                    userName: "로딩중...", //초기값 잠시 뜸

                    orderNo: '${orderNo}',

                    // sau : 'R',
                    // because: '',

                    // 모달 관련
                    reasonModalVisible: false,
                    missingReasons: [] // [{ orderNo: 'xxx' }, ...]
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
                    let param = {
                        sessionId: self.sessionId,
                        page: self.page,
                        pageSize: self.pageSize,
                        offset: (self.page - 1) * self.pageSize
                    };
                    // alert("넘어온 orderNo는" + self.orderNo);
                    $.ajax({
                        url: "/home/mypage/refund-return.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("리스트 응답 데이터:", data);
                            if (data.result == "success") {
                                // self.orderList = data.list;
                                self.orderList = data.list.map(order => {
                                    // URL로 넘어온 orderNo와 현재 목록의 orderNo가 일치하는지 확인
                                    let isTargetOrder = order.orderNo === self.orderNo;
                                    // 목록 항목에 체크 상태를 추가합니다.
                                    return {
                                        ...order,
                                        isChecked: isTargetOrder,

                                        //  추가: 라디오 버튼의 개별 상태
                                        actionType: 'R', // 'R'(반품)을 기본값으로 설정
                                        //  추가: 텍스트 에어리어의 개별 상태
                                        reason: ''
                                    };
                                });
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);
                                console.log("교환환불 리스트 업데이트 완료 - 전체 개수:", self.cnt, "현재 페이지:", self.page);
                            } else {
                                console.log(" 내역 조회 실패");
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
                // handleAction: function (actionType, orderNo) {
                //     if (actionType === 'RETURN') {
                //         console.log(`ORDER_NO ${orderNo}: 교환/반품 페이지로 이동 요청`);
                //         alert(`ORDER_NO ${orderNo}에 대해 교환/반품 페이지로 이동합니다. (규칙 21)`);

                //     } else if (actionType === 'REVIEW') {
                //         console.log(`ORDER_NO ${orderNo}: 상품 후기 작성 페이지로 이동 요청`);
                //         alert(`ORDER_NO ${orderNo}에 대해 상품 후기 작성 페이지로 이동합니다.`);
                //     }
                // },


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

                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    const sessionIdParam = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("orders.do", { sessionId: sessionIdParam });
                },

                // 모달 열기/닫기
                showReasonModal: function (missingOrders) {
                    this.missingReasons = missingOrders.map(o => ({ orderNo: o.orderNo }));
                    this.reasonModalVisible = true;
                    // 스크롤 방지
                    document.body.style.overflow = 'hidden';
                },
                closeReasonModal: function () {
                    this.reasonModalVisible = false;
                    this.missingReasons = [];
                    document.body.style.overflow = 'auto';
                },


                /**
                 * 💡 [최종] JSON 전송 방식으로 변경
                 * 서버 오류를 회피하고 안정적인 List/Array 전송을 보장합니다.
                 * (서버 개발자는 @RequestBody로 JSON을 받아 처리해야 합니다.)
                 */
                submitReturnExchange: function () {
                    const self = this;
                    const selected = (self.orderList || []).filter(o => o.isChecked);
                    
                    if (!selected || selected.length === 0) {
                        alert("반품/교환 신청할 주문을 하나 이상 선택해주세요.");
                        return;
                    }
                    
                    // 상세사유 체크 로직 (기존 유지)
                    const missingReasonItems = selected.filter(o => !o.reason || o.reason.trim() === "");
                    if (missingReasonItems.length > 0) {
                        self.showReasonModal(missingReasonItems);
                        return;
                    }

                    // 1. JSON 전송을 위한 데이터 구조 생성
                    const ordersData = selected.map(o => ({
                        orderNo: o.orderNo,
                        actionType: o.actionType || "",
                        reason: o.reason || ""
                    }));

                    const requestData = {
                        sessionId: self.sessionId,
                        orders: ordersData // 서버로 List<OrderDto>로 전달될 배열
                    };
                    
                    console.log("--- 서버로 전송할 JSON 데이터 (추천 방식) ---");
                    console.log(requestData); 
                    console.log("-----------------------------------------");

                    $.ajax({
                        url: "/home/mypage/refund-return-appli.dox",
                        type: "POST",
                        // 2. HTTP 헤더를 JSON 타입으로 설정
                        contentType: "application/json", 
                        dataType: "json", // 서버 응답이 JSON임을 기대
                        // 3. 자바스크립트 객체를 JSON 문자열로 변환하여 전송
                        data: JSON.stringify(requestData), 
                        success: function (res) {
                            if (res && (res.result === "success" || res.success === true)) {
                                alert("정상적으로 신청이 접수되었습니다.");
                                self.fnList();
                            } else {
                                const msg = (res && res.message) ? res.message : "서버에서 처리 중 문제가 발생했습니다.";
                                alert("처리 실패: " + msg);
                            }
                        },
                        error: function (xhr, status, err) {
                            console.error("서버 요청 실패:", status, err, xhr.responseText);
                            alert("서버에 요청을 보내는 중 오류가 발생했습니다. 서버 개발자와 상의하세요.");
                        }
                    });
                }, // submitReturnExchange

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


    </script>