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
            /* background-color: rgb(194, 194, 194); */
            /* color: black; */
            /* border: none; */
            /* border-radius: 5px; */

            /* cursor: pointer; */
            /* 마우스 올렸을 때 손가락 커서 */
            /* transition: background-color 0.3s ease, transform 0.2s ease; */
            /* 부드러운 변화 */

            padding: 8px 18px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: background-color 0.2s ease, transform 0.1s ease;
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
                                    <li @click="moveToRefund">
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
                                    <li class="active">
                                        <span class="icon">⭐️</span>
                                        <a href="#">상품 리뷰</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="main-content">
                            <h1 class="main-title">상품 리뷰</h1>

                            <template v-for="(order, index) in orderList" :key="order.orderNo">

                                <section class="order-item">

                                    <div class="order-status-header" :class="getStatusClass(order.status)"
                                        :style="isRefundOrExchangeRequested(order.status) ? 'color: red;' : ''">
                                        ORDER STATUS :
                                        <span class="status-text"
                                            :style="isRefundOrExchangeRequested(order.status) ? 'color: red; font-weight: bold;' : ''">{{
                                            order.status }}</span>
                                    </div>

                                    <div class="order-details" style="display: flex; align-items: center;">
                                        <!-- <div v-if="!isRefundOrExchangeRequested(order.status)">
                                
                                            <input type="checkbox" v-model="order.isChecked"
                                                style="transform: scale(1.5); margin-right: 10px; transform-origin: left center;">
                                        </div> -->
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
                                            <p>브랜드 : {{ order.brand }}</p>
                                            <p>상품가격 : {{ formatCurrency(order.paymentAmount) }}원</p>
                                            <p>주문일자 : {{ order.udate }}</p> <!--분명뭔가 요청을했고 그순간의 마지막 날짜를 기준잡았음-->
                                            <!-- <p>별점: {{ order.rating || '평점 없음' }}</p> -->
                                        </div>

                                        <div v-if="!isRefundOrExchangeRequested(order.status)">
                                            <div>
                                                <!-- <label style="margin-right: 10px;">
                                                    <input type="radio" v-model="order.actionType" value="R">반품
                                                </label>
                                                <label>
                                                    <input type="radio" v-model="order.actionType" value="C">교환
                                                </label> -->
                                                <br>
                                                <div v-if="order.rating">
                                                    <button @click="moveToReviewView(order)" style="background-color: gray;">
                                                        리뷰 보기
                                                    </button>
                                                </div>
                                                <div v-else>
                                                    <button @click="moveToReviewWrite(order)">
                                                        리뷰 작성하기
                                                    </button>
                                                </div>
                                                <div class="star-rating" v-if="order.rating">
                                                    {{ displayStars(order.rating) }}
                                                </div>
                                                <div class="star-rating" v-else>
                                                    &#9734; &#9734; &#9734; &#9734; &#9734;
                                                </div>
                                                <!-- <div class="star-rating">
                                                    &#9734;&#9734;&#9734;&#9734;&#9734;
                                                </div> -->
                                                <!-- <div class="star-rating">
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </div>
                                                <div class="star-rating">
                                                    <i v-for="n in 5" :key="n" class="far fa-star"></i>
                                                </div> -->
                                                <!-- <div>
                                                    <textarea type="text" style="height: 80px; width: 250px;"
                                                        placeholder="상세사유입력" v-model="order.reason"></textarea>
                                                </div> -->
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
                    productNo: '${productNo}',
                    // sau : 'R',
                    // because: '',
                    rating: "${rating}"

                };
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                displayStars: function (rating) {
                    // if (!rating) return '별점 없음';
                    const numRating = typeof rating === 'string' ? parseInt(rating) : rating;
                    // if (isNaN(numRating)) return '별점 없음';
                    return '⭐'.repeat(numRating) + '☆'.repeat(5 - numRating); // + ' (' + numRating + '/5)';
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
                    // alert("넘어온 orderNo는" + self.orderNo);
                    // alert("넘어온 rating" + self.rating);
                    $.ajax({
                        url: "/home/mypage/reviewlist.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("리스트 응답 데이터:", data);
                            if (data.result == "success") {
                                self.orderList = data.list;
                                // self.orderList = data.list.map(order => {
                                // URL로 넘어온 orderNo와 현재 목록의 orderNo가 일치하는지 확인
                                // let isTargetOrder = order.orderNo === self.orderNo;
                                // 목록 항목에 체크 상태를 추가합니다.
                                // return {
                                // ...order,
                                // isChecked: isTargetOrder,

                                //  추가: 라디오 버튼의 개별 상태
                                // actionType: 'R', // 'R'(반품)을 기본값으로 설정
                                //  추가: 텍스트 에어리어의 개별 상태
                                // reason: ''
                                // };
                                // });
                                self.cnt = data.cnt;
                                self.index = Math.ceil(self.cnt / self.pageSize);
                                console.log("리뷰리스트 업데이트 완료 - 전체 개수:", self.cnt, "현재 페이지:", self.page);
                            }
                            else {
                                alert(" 내역 조회 실패");
                                self.orderList = [];
                                self.cnt = 0;
                                self.index = 0;
                            }
                        }
                    });
                },

                fnMove: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
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

                /** 반품요청 또는 교환요청 상태인지 확인 */
                isRefundOrExchangeRequested: function (status) {
                    return status === '반품요청' || status === '교환요청' || status === '취소요청';
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

                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("orders.do", { sessionId: sessionId });
                },

                moveToRefund: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    window.pageChange("refund-return.do", { sessionId: sessionId });
                },




                moveToReviewWrite: function (order) {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. 전달받은 order 객체에서 orderNo와 productNo를 가져옵니다.
                    let orderNo = order.orderNo;   // 수정
                    let productNo = order.productNo; // 
                    let quantity = order.quantity;
                    let paymentAmount = order.paymentAmount;
                    let udate = order.udate;
                    let imgPath = order.imgPath;
                    let imgName = order.imgName;
                    let status = order.status;
                    let productName = order.productName;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                    // alert('다른 페이지로 값 보냄' 
                    // + JSON.stringify( { sessionId: sessionId, orderNo:orderNo, productNo:productNo,  
                    //         quantity: quantity, paymentAmount:paymentAmount, udate:udate,
                    //         imgPath : imgPath , imgName : imgName, status: status
                    // })  );
                    pageChange("review-write.do",
                        {
                            sessionId: sessionId, orderNo: orderNo, productNo: productNo,
                            quantity: quantity, paymentAmount: paymentAmount, udate: udate,
                            imgPath: imgPath, imgName: imgName, status: status, productName: productName
                        });
                },

                moveToReviewView: function (order) {
                    let self = this;
                    console.log("리뷰 보기 페이지 이동. pageChange 호출");

                    // 1. Vue의 sessionId 데이터에 접근
                    let sessionId = self.sessionId;

                    // 2. 전달받은 order 객체에서 orderNo와 productNo를 가져옵니다.
                    let orderNo = order.orderNo;
                    let productNo = order.productNo;

                    // 3. pageChange 함수 호출
                    pageChange("review-view.do",
                        {
                            sessionId: sessionId,
                            orderNo: orderNo,
                            productNo: productNo
                        });
                },

            }, // methods
            mounted() {
                let self = this;
                self.fnList(); // 실제 데이터 조회 시작
                self.fnGetUserInfo(); // 사용자 정보 조회
            }
        });

        app.mount('#app');





    </script>