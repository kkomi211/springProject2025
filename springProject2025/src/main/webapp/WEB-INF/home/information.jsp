<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <title>Homepage</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <style>
        
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
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
                        <a href="/home/login.do">로그인</a></div>
                    <div>
                        <a href="/home/signup.do">가입하기</a></div>
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
                <main>
                    <div class="header">
                        <div class="header-welcome">
                            Welcome,
                        </div>
                        <div class="header-user">
                            {{ info.name }}님
                        </div>
                    </div>

                    <div class="page-container">
                        <aside class="sidebar">
                            <h2 class="sidebar-heading">MY PAGE ></h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li @click="moveToOrder" >
                                        <span class="icon">📝</span>
                                        <a href="#">주문•배송 내역</a>
                                    </li>
                                    <li @click="moveToRefund">
                                        <span class="icon">📦</span>
                                        <a href="javascript:;" >반품•교환 내역</a>
                                    </li>
                                    <li>
                                        <span class="icon">💬</span>
                                        <a href="#">문의 내역</a>
                                    </li>
                                    <li class="active">
                                        <span class="icon" >👤</span>
                                        <a href="">나의 정보</a>
                                    </li>
                                    <li>
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
                                    안전한 정보보호를  위해 비밀번호를 다시 한번 확인합니다. 다시 입력해주세요.
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
                                            <input type="password" v-model="pwd" id="pwd" @keyup.enter="fnMypage(info.userId)">
                                        </td>
                                    </tr>
                                </table>
                            </section>
                            <div class="bottom-btn">
                                <button @click="fnMypage(info.userId)" class="btn">확인</button>
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
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                pwd : "",
                sessionId : "${sessionId}",
                info : {},

                // Modal Popup
                pwdMatch : false,
                pwdCorrect : null
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/home/mypage/info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            console.log(data);
                            self.info = data.info;
                        } else {
                            alert("error");
                        }

                    }
                });
            },
            fnMypage:function(userId){
                let self = this;
                if(self.pwd == ""){
                    alert("비밀번호를 입력해주세요.");
                    document.querySelector("#pwd").focus();
                    return;
                }
                let param = {
                    userId : userId,
                    pwd : self.pwd
                };
                $.ajax({
                    url: "/home/mypage/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            self.pwdMatch = true;
                            self.pwdCorrect = true;
                        } else {
                            self.pwdMatch = true;
                            self.pwdCorrect = false;
                        }

                    }
                });
            },
            moveInfoPage: function(){
                let self = this;
                pageChange("information/change.do", { sessionId: self.sessionId});
            },
            moveToRefund: function() {
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
            }  
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>