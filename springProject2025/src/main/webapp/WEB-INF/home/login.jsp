<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/login-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <title>Homepage</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                    <div><a href="/home/mypage/inquiry.do">문의</a></div>
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
                <div>
                    <div class="login-container">
                        <h2>로그인</h2>
                        <div class="signup-form">
                            <div class="form-row">
                                <input type="text" placeholder="아이디" v-model="userId" @keyup.enter="fnLogin">
                            </div>
                            <div class="form-row">
                                <input type="password" placeholder="비밀번호" v-model="pwd" @keyup.enter="fnLogin">
                            </div>
                            
                            <div class="form-submit">
                                <button @click="fnLogin" class="submit-btn">로그인</button>
                            </div>
                            <div class="form-submit">
                                <button class="submit-btn" style="background-color: yellow; color: black;">카카오 로그인</button>
                            </div>
                        </div>
                        <div id="other">
                            <div>
                                <a href="/home/signup.do">회원가입</a>
                            </div>
                            <div>
                                <a href="/home/login/search.do">아이디 비밀번호 찾기</a>
                            </div>
                        </div>
                    </div>
                    <!-- v-if="loginModal"  -->
                    <div v-if="isLoginModal" class="modal-overlay">
                        <div class="modal-content">
                            <h2>로그인 성공했습니다</h2>
                            <a href="/home.do"><button>메인 화면 가기</button></a>
                            <a href="javascript:;"><button>마이페이지 가기</button></a>
                        </div>
                    </div>
                    <div v-if="noLoginModal" class="modal-overlay">
                        <div class="modal-content">
                            <h2>로그인 실패했습니다</h2>
                            <p>로그인 다시 시도해보세요</p>
                            <button @click="closeModal">돌아가기</button>
                        </div>
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
                userId : "",
                pwd : "",
                isLoginModal : false,
                noLoginModal : false
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogin: function () {
                let self = this;
                // 유효성 검사
                if (!self.userId || !self.pwd) {
                    alert("아이디와 비밀번호를 입력하세요.");
                    return;
                }
                let param = {
                    userId : self.userId,
                    pwd : self.pwd
                };
                $.ajax({
                    url: "/home/login.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if (data.result === "success") {
                            // 로그인 성공 시 페이지 전환
                            self.isLoginModal = true;
                        } else {
                            // 로그인 실패 시 경고 메시지 출력
                            self.noLoginModal = true;
                        }
                    }
                });
            },
            closeModal() {
                let self = this;
                self.noLoginModal = false;
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>
