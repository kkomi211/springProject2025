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
            background-color: #f9f9f9;
        }

        input[readonly],
        textarea[readonly] {
            background-color: #f9f9f9;
            cursor: default;
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
            transform: scale(1.02);
            /* 살짝 커지는 느낌 */
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
                                    <li @click="moveToOrder">
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
                                    <li @click="mvInfo">
                                        <span class="icon">👤</span>
                                        <a href="#">나의 정보</a>
                                    </li>
                                    <li @click="moveToReview" class="active">
                                        <span class="icon">⭐️</span>
                                        <a href="#">상품 리뷰</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="main-content">
                            <h1 class="main-title">상품 리뷰 보기</h1>

                            <div class="review-write-box"
                                style="border: 1px solid #ccc; padding: 20px; margin-top: 20px; background-color: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">

                                <h2
                                    style="text-align: center; margin-bottom: 25px; font-size: 1.5rem; color: #333; letter-spacing: 1px;">
                                    **MY REVIEW**
                                </h2>

                                <table class="product-info-table"
                                    style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
                                    <tr>
                                        <td rowspan="2" style="width: 200px; padding-right: 20px; vertical-align: top;">
                                            <div
                                                style="width: 150px; height: 150px; overflow: hidden; background: #f0f0f0; display: flex; align-items: center; justify-content: center; border: 1px solid #ddd;">
                                                <img :src="review.imgPath + '/' + review.imgName" alt="상품 이미지"
                                                    style="width: 100%; height: 100%; object-fit: cover;"
                                                    v-if="review.imgPath && review.imgName">
                                                <span v-else>
                                                    이미지 없음
                                                </span>
                                            </div>
                                        </td>
                                        <td style="font-size: 1.1rem;  padding: 0 0 5px 0;">
                                            상품명 : <span style="font-weight: normal;">{{review.productName}}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top; padding: 0;">
                                            <p style="margin: 5px 0;">
                                                브랜드 : {{review.brand}}
                                            </p>
                                            <p style="margin: 5px 0;">
                                                가격 : <span style=" color: #333;">{{
                                                    formatCurrency(review.paymentAmount) }}원</span>
                                            </p>
                                            <p style="margin: 5px 0;">
                                                수량 : {{ review.quantity }}개
                                            </p>

                                            <div class="star-rating-display" style="margin-top: 10px;">
                                                <span v-for="n in 5" :key="n"
                                                    style="font-size: 2rem; color: #ccc; margin-right: 3px;"
                                                    :style="{ color: n <= review.rating ? 'gold' : '#ccc' }">
                                                    &#9733;
                                                </span>
                                                <span style="margin-left: 10px; font-size: 1rem; color: #666;">
                                                    ({{ review.rating }}/5)
                                                </span>
                                            </div>

                                        </td>
                                    </tr>
                                </table>

                                <div style="margin-top: 30px;">
                                    <div style="margin-bottom: 15px;">
                                        <label for="reviewTitle"
                                            style="display: block; font-weight: bold; margin-bottom: 5px; color: #555;">리뷰
                                            제목</label>
                                        <input type="text" id="reviewTitle" :value="review.title" readonly
                                            style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 0.95rem; background-color: #f9f9f9;">
                                    </div>

                                    <div style="margin-bottom: 15px;">
                                        <label for="reviewContent"
                                            style="display: block; font-weight: bold; margin-bottom: 5px; color: #555;">리뷰
                                            내용</label>
                                        <div v-html="review.content"
                                            style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 0.95rem; background-color: #f9f9f9; min-height: 200px; white-space: pre-wrap;">
                                        </div>
                                    </div>

                                    <div style="margin-bottom: 10px; color: #666; font-size: 0.9rem;">
                                        작성일 : {{ review.cdate }}
                                    </div>

                                    <div style="text-align: right;">
                                        <button type="button" class="back-button"
                                            style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: background-color 0.2s;"
                                            @click="moveToReview">
                                            목록으로 돌아가기
                                        </button>
                                    </div>
                                </div>

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



        </div><!--app끝-->

    </body>

    </html>

    <script>
        // Vue 인스턴스를 전역에서 접근 가능하도록 'app' 변수로 선언
        const app = Vue.createApp({
            data() {
                return {
                    userName: "로딩중...",

                    sessionId: '${sessionId}',
                    orderNo: '${orderNo}',
                    productNo: '${productNo}',
                    review: {}
                };
            },
            methods: {
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
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

                fnReviewInfo: function () {
                    let self = this;
                    let param = {
                        orderNo: self.orderNo,
                        productNo: self.productNo,
                        sessionId: self.sessionId
                    };
                    $.ajax({
                        url: "/home/mypage/review-view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("리뷰 정보:", data);
                            if (data.result == "success" && data.review) {
                                self.review = data.review;
                            } else {
                                alert("리뷰 정보를 불러올 수 없습니다.");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("리뷰 정보 조회 실패:", error);
                            alert("리뷰 정보 조회 중 오류가 발생했습니다.");
                        }
                    });
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
                }

            }, // methods
            mounted() {
                let self = this;
                self.fnGetUserInfo(); // 사용자 정보 조회
                self.fnReviewInfo(); // 리뷰 정보 조회
            }
        });

        app.mount('#app');
    </script>