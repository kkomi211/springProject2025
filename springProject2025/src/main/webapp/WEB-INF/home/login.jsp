<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/login-style.css">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
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
                            <a href="javascript:;" @click="fnSale">세일</a>
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
                                    <input id="id" type="text" placeholder="아이디" v-model="userId" @keyup.enter="fnLogin">
                                </div>
                                <div class="form-row">
                                    <input type="password" placeholder="비밀번호" v-model="pwd" @keyup.enter="fnLogin">
                                </div>

                                <div class="form-submit">
                                    <button @click="fnLogin" class="submit-btn">로그인</button>
                                </div>
                                <div class="form-submit">
                                    <!-- <a href="javascript:void(0)" @click="openKakaoPopup">  -->
                                    <a href="${location}">
                                        <img src="/img/kakao.png">
                                    </a>
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

                        <!-- Modals -->

                            <!-- Login fail or success  -->
                            <div v-if="isLoginModal" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>로그인 성공했습니다</h2>
                                    <a href="/home.do"><button>메인 화면 가기</button></a>
                                    <a href="/home/mypage/information.do"><button>마이페이지 가기</button></a>
                                </div>
                            </div>
                            <div v-if="noLoginModal" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>로그인에 실패했습니다</h2>
                                    <p>다시 시도해보세요</p>
                                    <button @click="closeModal">돌아가기</button>
                                </div>
                            </div>

                            <!-- Require to enter fields -->
                             <div v-if="emptyFields" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>아이디와 비밀벌호를 입력해주세요.</h2>
                                    <button @click="closeModal">닫기</button>
                                </div>
                            </div>

                            <div v-if="showSessionWarning" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>세션 만료 경고</h2>
                                    <p>비활동으로 인해 2분 후 세션이 만료됩니다.</p>
                                    <p>계속하시겠습니까?</p>
                                    <div style="display: flex; gap: 10px; justify-content: center; margin-top: 20px;">
                                        <button @click="extendSession">세션 연장</button>
                                        <button @click="fnLogout">로그아웃</button>
                                    </div>
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
        console.log("client_id =", "${client_id}");
        console.log("redirect_uri =", "${redirect_uri}");
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    userId: "",
                    pwd: "",
                    isLoginModal: false,
                    noLoginModal: false,
                    emptyFields: false,
                    sessionId: "${sessionId}",

                    //kakao login
                    // location : "${location}"
                    client_id: "${client_id}",
                    redirect_uri: "${redirect_uri}",

                    userType : '${userType}',

                    // 세션 타임아웃 관련 변수 추가
                    showSessionWarning: false,
                    sessionTimeoutId: null,
                    sessionWarningTimeoutId: null,
                    timeoutMinutes: 3,
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnLogin: function () {
                    let self = this;
                    // 유효성 검사
                    if (!self.userId || !self.pwd) {
                        self.emptyFields = true;
                        return;
                    }
                    let param = {
                        userId: self.userId,
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/home/login.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result === "success") {
                                if (data.userType == "A") {
                                    pageChange("/admin.do", { sessionId: self.userId });
                                }
                                // 로그인 성공 시 페이지 전환
                                self.isLoginModal = true;

                                // 로그인 성공 시 세션 타이머 시작
                                self.startSessionTimer();
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
                    self.emptyFields = false;
                    document.querySelector("#id").focus();
                },

                // Kakao Popup window
                openKakaoPopup() {
                    let self = this;
                    let kakaoUrl = "https://kauth.kakao.com/oauth/authorize?response_type=code"
                        + "&client_id=" + self.client_id
                        + "&redirect_uri=" + self.redirect_uri
                        + "&prompt=login";

                    // Use local variables
                    let width = 850;
                    let height = 950;
                    let left = (window.innerWidth / 2) - (width / 2);
                    let top = (window.innerHeight / 2) - (height / 2);

                    // Debugging
                    console.log("Popup URL:", kakaoUrl);
                    console.log(`width=${width},height=${height},left=${left},top=${top}`);

                    window.open(
                        kakaoUrl, // use local variable
                        "KakaoLogin",
                        `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`
                    );
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
                fnLogout: function () {
                    let self = this;

                    // 세션 타이머 정리
                    self.clearSessionTimers();

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
                startSessionTimer() {
                    let self = this;
                    
                    // 기존 타이머가 있으면 정리
                    self.clearSessionTimers();
                    
                    const timeoutDuration = self.timeoutMinutes * 60 * 1000; // 밀리초로 변환
                    const warningDuration = timeoutDuration - (2 * 60 * 1000); // 2분 전 경고
                    
                    // 경고 타이머 설정
                    self.sessionWarningTimeoutId = setTimeout(() => {
                        self.showSessionWarning = true;
                    }, warningDuration);
                    
                    // 로그아웃 타이머 설정
                    self.sessionTimeoutId = setTimeout(() => {
                        self.autoLogout();
                    }, timeoutDuration);
                    
                    console.log('세션 타이머 시작:', self.timeoutMinutes + '분');
                },
                
                resetSessionTimer() {
                    let self = this;
                    
                    // 로그인된 상태에서만 타이머 재설정
                    if (self.sessionId && self.sessionId !== '') {
                        self.showSessionWarning = false;
                        self.startSessionTimer();
                    }
                },
                
                clearSessionTimers() {
                    let self = this;
                    
                    if (self.sessionTimeoutId) {
                        clearTimeout(self.sessionTimeoutId);
                        self.sessionTimeoutId = null;
                    }
                    
                    if (self.sessionWarningTimeoutId) {
                        clearTimeout(self.sessionWarningTimeoutId);
                        self.sessionWarningTimeoutId = null;
                    }
                },
                
                extendSession() {
                    let self = this;
                    self.resetSessionTimer();
                    self.showSessionWarning = false;
                    console.log('세션 연장됨');
                },
                
                autoLogout() {
                    let self = this;
                    console.log('자동 로그아웃');
                    self.fnLogout();
                },
                
                setupActivityListeners() {
                    let self = this;
                    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
                    
                    events.forEach(event => {
                        document.addEventListener(event, self.resetSessionTimer);
                    });
                },
                
                removeActivityListeners() {
                    let self = this;
                    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
                    
                    events.forEach(event => {
                        document.removeEventListener(event, self.resetSessionTimer);
                    });
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;

                // 로그인된 상태면 세션 타이머 시작
                if (self.sessionId && self.sessionId !== '') {
                    self.setupActivityListeners();
                    self.startSessionTimer();
                }

            },
            beforeUnmount() {
                let self = this;
                self.removeActivityListeners();
                self.clearSessionTimers();
            }
        });

        app.mount('#app');
    </script>