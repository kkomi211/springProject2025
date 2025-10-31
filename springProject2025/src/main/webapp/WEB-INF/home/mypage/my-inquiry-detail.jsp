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
        /* 기본 스타일: 데스크톱에서 테이블 보이기, 모바일에서 카드 보이기 */
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
        }

        .inquiry-table th,
        .inquiry-table td {
            padding: 18px 12px;
            border-bottom: 1px solid #e5e5e5;
            text-align: left;
            font-size: 14px;
        }

        .inquiry-table thead th {
            font-weight: 600;
            letter-spacing: .02em;
        }

        /* 모바일 카드 (기본은 숨김) */
        .inquiry-cards {
            display: none;
        }

        /* 반응형: 화면이 작으면 테이블 숨기고 카드형 보여주기 */
        @media (max-width: 800px) {
            .inquiry-table {
                display: none;
            }

            .inquiry-cards {
                display: block;
            }

            .inquiry-card {
                border: 1px solid #eee;
                padding: 12px;
                margin-bottom: 12px;
                border-radius: 6px;
                background: #fff;
            }

            .card-head {
                display: flex;
                justify-content: space-between;
                margin-bottom: 8px;
                font-size: 13px;
                color: #666;
            }

            .card-title {
                margin: 0 0 6px 0;
                font-size: 16px;
            }

            .card-status {
                font-size: 13px;
                color: #333;
            }
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
                                        <a href="#">주문•배송 내역</a>
                                    </li>
                                    <li @click="moveToRefund">
                                        <span class="icon">📦</span>
                                        <a href="javascript:;">반품•교환 내역</a>
                                    </li>
                                    <li class="active" @click="moveToMyinquiry">
                                        <span class="icon">💬</span>
                                        <a href="#">문의 내역</a>
                                    </li>
                                    <li>
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
                            <h1 class="main-title">나의 상품 문의 내역 > 문의 상세보기 </h1>

                            <section v-if="inquiry" class="mypage-content inquiry-view">
                                <div class="inquiry-detail order-item">
                                    <h2>제목 : {{ inquiry.title }}</h2>
                                    <p>번호 {{ inquiry.inquiryNo }} | 문의 날짜 {{ inquiry.cdate }}</p>
                                    <hr>
                                    <div class="inquiry-content-box">
                                        <p v-html="inquiry.content"></p>
                                    </div>
                                </div>

                                <div v-if="inquiry.answer" class="inquiry-answer-box order-item">
                                    <h3>답변 내용</h3>
                                    <p>답변 날짜 {{ inquiry.udate }}</p>
                                    <hr>
                                    <div class="answer-text">
                                        <p v-html="inquiry.answer"></p>
                                    </div>
                                </div>

                                <div v-else class="no-answer-box order-item">
                                    <p style="color: #858585;">아직 답변이 등록되지 않았습니다.</p>
                                </div>

                            </section>

                            <div v-else class="loading-message">
                                문의 정보를 불러오는 중입니다...
                            </div>

                            <div class="button-area" style="text-align: right; margin-top: 20px;">
                                <button onclick="history.back()">목록으로 돌아가기</button>
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
                    pageSize: 5,
                    // index: 0,
                    totalPages: 0,
                    currentCancelOrderNo: null,
                    sessionId: "${sessionId}",
                    userName: "로딩중...",

                    inquiryNo: "${inquiryNo}",
                    inquiry: null
                };
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },



                fnMove: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
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
                    window.pageChange("refund-return.do", { sessionId: sessionId });
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
                onRowClick(item) {
                    // 상세 페이지 이동, 모달, 또는 페이징 등
                    // e.g. pageChange("inquiry-detail.do", { orderNo: item.orderNo });
                    console.log('row clicked', item);
                },

                moveToOrder: function () {
                    let self = this;
                    console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                    let sessionId = self.sessionId;

                    // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                    pageChange("orders.do", { sessionId: sessionId });
                },

                // fnView: function (inquiryNo) {
                //     // console.log(boardNo);
                //     let self = this;
                //     let sessionId = self.sessionId;
                //     // alert("상세보기로 inquiryNo로 넘겨줌 " + inquiryNo);
                //     pageChange("/home/mypage/my-inquiry-detail.do", { inquiryNo: inquiryNo, sessionId: sessionId });
                // },

                fnGetInquiryDetail() {
                    const self = this;
                    $.ajax({
                        url: "/home/mypage/my-inquiry-detail.dox",
                        type: "POST",
                        data: { inquiryNo: self.inquiryNo },
                        dataType: "json",
                        success(data) {
                            console.log("돌아온 detail관련 data는" + data)
                            if (data.result === "success") {
                                self.inquiry = data.info;
                            } else {
                                alert("문의 정보를 불러오지 못했습니다.");
                            }
                        }
                    });
                },
            }, // methods
            mounted() {
                let self = this;
                self.fnGetInquiryDetail(); // 실제 데이터 조회 시작
                self.fnGetUserInfo(); // 사용자 정보 조회
            }
        });

        app.mount('#app');





    </script>