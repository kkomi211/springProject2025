<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="stylesheet" href="/css/idSearch-style.css">
        <link rel="stylesheet" href="/css/style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=check_circle" />
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>

        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
                <%-- 공통 헤더 컴포넌트 --%>
                    <jsp:include page="/WEB-INF/header/header.jsp" />

                    <main>
                        <div v-if="!idFound && !pwdFound" class="search-container">
                            <!-- 🔹 아이디 찾기 / 비밀번호 찾기 폼 -->
                            <div class="id-search-container">
                                <h2>아이디 찾기</h2>
                                <div class="signup-form">
                                    <div class="form-row">
                                        <input type="text" placeholder="이름" v-model="id_name" id="id_name">
                                    </div>
                                    <div class="form-row">
                                        <input type="text" placeholder="- 없이 전화번호를 입력하세요" v-model="id_phone"
                                            id="id_phone">
                                    </div>
                                    <div class="form-row">
                                        <input type="text" placeholder="생년월일  YYYY-MM-DD" v-model="id_birth"
                                            @keyup.enter="fnSearchId" id="id_birth">
                                    </div>
                                    <div class="form-submit">
                                        <button @click="fnSearchId" class="submit-btn">아이디 찾기</button>
                                    </div>
                                </div>
                            </div>

                            <div class="pwd-search-container">
                                <h2>비밀번호 찾기</h2>
                                <div class="signup-form">
                                    <div class="form-row">
                                        <input type="text" placeholder="아이디" v-model="pwd_userId" id="pwd_userId">
                                    </div>
                                    <div class="form-row">
                                        <input type="text" placeholder="이름" v-model="pwd_name" id="pwd_name">
                                    </div>
                                    <div class="form-row">
                                        <input type="text" placeholder="생년월일  YYYY-MM-DD" v-model="pwd_birth"
                                            @keyup.enter="fnSearchPwd" id="pwd_birth">
                                    </div>
                                    <div class="form-row">
                                        <input type="text" placeholder="- 없이 전화번호를 입력하세요" v-model="pwd_phone"
                                            id="pwd_phone">
                                    </div>

                                    <div v-if="!joinFlg" class="form-row">
                                        <input type="text" v-model="inputNum" :placeholder="timer || '문자인증'" id="auth" :disabled="authFlag">
                                        <template v-if="!smsFlg">
                                            <button @click="fnSms">인증번호 전송</button>
                                        </template>
                                        <template v-else>
                                            <button @click="fnSmsAuth">인증</button>
                                        </template>
                                    </div>
                                    <!-- 인증완료 popup -->
                                    <div v-else class="modal-overlay">
                                        <div class="modal-content">
                                            <h2>문자인증이 완료되었습니다.</h2>
                                            <button class="btn" @click="fnAuthChecked">확인</button>
                                        </div>
                                    </div>

                                    <div class="form-submit">
                                        <button @click="fnSearchPwd" class="submit-btn">비밀번호 찾기</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div v-else-if="idFound" class="search-container">
                            <!-- 🔹 아이디 찾기 완료 -->
                            <div class="id-search-container">
                                <h2>아이디 찾기 완료</h2>
                                <span class="material-symbols-outlined" style="font-size: 60px;">check_circle</span>
                                <div class="id-msg">
                                    <div>고객 님의 아이디는 <span style="font-weight: bold;">{{ info.userId }}</span> 입니다.</div>
                                    <div>{{ info.cdate }}에 가입함</div>
                                </div>
                                <div class="form-submit">
                                    <a href="/home/login.do"><button class="submit-btn">로그인 하기</button></a>
                                    <a href="/home/login/search.do"><button class="submit-btn">비밀번호 찾기</button></a>
                                </div>
                            </div>
                        </div>

                        <div v-else-if="pwdFound" class="search-container">
                            <!-- 🔹 비밀번호 변경 -->
                            <div class="id-search-container">
                                <h2>비밀번호 변경하기</h2>
                                <ul>
                                    <li>기존 비밀번호는 이미 암호화되어 있으므로 새 비밀번호로 변경해야 합니다.</li>
                                    <li>비밀번호는 공백 없이 6자 이상의 영문자, 숫자, 특수문자 조합으로 지정해주세요.</li>
                                </ul>
                                <div class="pwd-form-row">
                                    <label>새 비밀번호 입력:</label>
                                    <input type="password" v-model="newPwd1">
                                </div>
                                <div class="pwd-form-row">
                                    <label>새 비밀번호 확인:</label>
                                    <input type="password" v-model="newPwd2">
                                </div>
                                <div class="form-submit">
                                    <button @click="fnChangePwd" class="pwd-submit-btn">비밀번호 변경완료</button>
                                </div>
                            </div>
                        </div>

                        <!-- MODAL POPUP WINDOW -->

                        <!-- When fields are empty -->
                         <div v-if="emptyName" class="modal-overlay">
                            <div class="modal-content">
                                <h2 >이름을 입력해주세요.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>
                        <div v-if="emptyPhone" class="modal-overlay">
                            <div class="modal-content">
                                <h2 >전화번호를 입력해주세요.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>
                        <div v-if="emptyBirth" class="modal-overlay">
                            <div class="modal-content">
                                <h2 >생년월일을 입력해주세요.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>
                        <div v-if="emptyId" class="modal-overlay">
                            <div class="modal-content">
                                <h2 >아이디를 입력해주세요.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>
                        <div v-if="emptyAuthNum" class="modal-overlay">
                            <div class="modal-content">
                                <h2 >인증 절차를 먼저 완료해주세요.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>
                        <!-- When authentication number is wrong -->
                         <div v-if="wrongAuth" class="modal-overlay">
                            <div class="modal-content">
                                <h2>인증 번호가 올바르지 않습니다.</h2>
                                <button @click="fieldCloseModal">닫기</button>
                            </div>
                        </div>

                        <!-- When id or password can't be found -->
                        <div v-if="showModal" class="modal-overlay">
                            <div class="modal-content">
                                <h2>아이디/비밀번호 찾기 실패</h2>
                                <p>입력정보를 다시 확인해주세요. 입력하신 정보는 존재하지 않습니다.</p>
                                <button @click="closeModal">돌아가기</button>
                            </div>
                        </div>

                        <!-- When password successfully changed -->
                         <div v-if="pwdChangedModal" class="modal-overlay">
                            <div class="modal-content">
                                <h2>비밀번호 변경 성공</h2>
                                <p>변경된 암호로 로그인 해보세요</p>
                                <a href="/home/login.do"><button>로그인 화면 가기</button></a>
                                <a href="/home.do"><button>메인 화면 가기</button></a>
                            </div>
                        </div>

                        <!-- When password doesn't meet requirements -->
                        <div v-if="pwdFailedModal" class="modal-overlay">
                            <div class="modal-content">
                                <h2>비밀번호 변경 실패</h2>
                                <p>암호 생성 규칙을 다시 확인해주세요</p>
                                <button @click="closeModal">돌아가기</button>
                            </div>
                        </div>

                        <!-- Password change mismatched -->
                        <div v-if="pwdMismatched" class="modal-overlay">
                            <div class="modal-content">
                                <h2>비밀번호가 서로 다릅니다.</h2>
                                <button @click="pwdClosemodal">돌아가기</button>
                            </div>
                        </div>
                        
                        <!-- Universal Modal -->
                        <div v-if="showUniversalModal" class="modal-overlay">
                            <div class="modal-content">
                                <h2>{{ modalMessage }}</h2>
                                <button class="btn" @click="closeUniversalModal">확인</button>
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
                    // 변수 - (key : value)
                    id_name: "",
                    id_phone: "",
                    id_birth: "",

                    pwd_userId: "",
                    pwd_name: "",
                    pwd_phone: "",
                    pwd_birth: "",

                    idFound: false,
                    pwdFound: false,
                    info: {},
                    newPwd1: "",
                    newPwd2: "",

                    // modals
                    showModal: false,
                    pwdChangedModal: false,
                    pwdFailedModal: false,
                    emptyName : false,
                    emptyPhone : false,
                    emptyBirth : false,
                    emptyId : false,
                    emptyAuthNum : false,
                    wrongAuth : false,
                    authChecked : false,
                    pwdMismatched : false,

                    // Universal modal (ADD THIS)
                    showUniversalModal: false,
                    modalMessage: '',
                    modalCallback: null,

                    // 인증
                    smsFlg: false,
                    joinFlg: false, // 문자 인증 유무
                    authFlag: false,

                    // harcoding for test purposes
                    // ranStr: 111,
                    ranStr: "",
                    inputNum: "",
                    timer: "",
                    timerInterval: null,
                    count: 180,

                    userType: '${userType}',
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                openModal: function(message, callback) {
                    this.modalMessage = message;
                    this.modalCallback = callback || null;
                    this.showUniversalModal = true;
                },
                
                closeUniversalModal: function() {
                    this.showUniversalModal = false;
                    if (this.modalCallback) {
                        this.modalCallback();
                        this.modalCallback = null;
                    }
                },
                fnSearchId: function () {
                    let self = this;
                    if (self.id_name == "") {
                        // alert("이름을 입력해주세요.");
                        self.emptyName = true;
                        document.querySelector("#id_name").focus();
                        return;
                    }
                    if (self.id_phone == "") {
                        // alert("전화번호를 입력해주세요.");
                        self.emptyPhone = true;
                        document.querySelector("#id_phone").focus();
                        return;
                    }
                    if (self.id_birth == "") {
                        // alert("생년월일을 입력해주세요.");
                        self.emptyBirth = true;
                        document.querySelector("#id_birth").focus();
                        return;
                    }
                    let param = {
                        name: self.id_name,
                        phone: self.id_phone,
                        birth: self.id_birth
                    };
                    $.ajax({
                        url: "/home/login/search.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result === "success") {
                                // 로그인 성공 시 페이지 전환
                                self.idFound = true;
                                self.info = data.info;
                                // location.href = "/home.do";
                            } else {
                                self.showModal = true;
                            }
                        }
                    });
                },
                fnSearchPwd: function () {
                    let self = this;
                    if (self.pwd_userId == "") {
                        self.emptyId = true;    
                        document.querySelector("#pwd_userId").focus();
                        return;
                    }
                    if (self.pwd_name == "") {
                        self.emptyName = true;
                        document.querySelector("#pwd_name").focus();
                        return;
                    }
                    if (self.pwd_birth == "") {
                        self.emptyBirth = true;
                        document.querySelector("#pwd_birth").focus();
                        return;
                    }
                    let birthPattern = /^\d{4}-\d{2}-\d{2}$/;
                    if (!birthPattern.test(self.pwd_birth)) {
                        self.openModal("생년월일 형식이 올바르지 않습니다. YYYY-MM-DD 형식으로 입력해주세요.", function() {
                            document.querySelector("#pwd_birth").focus();
                        });
                        return;
                    }
                    if (self.pwd_phone == "") {
                        self.emptyPhone = true;
                        document.querySelector("#pwd_phone").focus();
                        return;
                    }
                    if (self.pwd_phone.length < 11 || !/^[0-9]+$/.test(self.pwd_phone)) {
                        self.openModal("전화번호를 다시 확인해주세요. 11자리 숫자를 입력해주세요.", function() {
                            document.querySelector("#pwd_phone").focus();
                        });
                        return;
                    }
                    if (self.inputNum == "") {
                        self.emptyAuthNum = true;
                        document.querySelector("#auth").focus();
                        return;
                    }
                    if(!self.authChecked){
                        self.emptyAuthNum = true;
                        return;
                    }
                    let param = {
                        userId: self.pwd_userId,
                        name: self.pwd_name,
                        phone: self.pwd_phone,
                        birth: self.pwd_birth
                    };
                    $.ajax({
                        url: "/home/pwdCheck.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result === "success") {
                                // 로그인 성공 시 페이지 전환
                                self.pwdFound = true;
                                self.pwdChanged = true;
                            } else {
                                self.showModal = true;
                                self.smsFlg = false;
                                self.authFlag = false;      
                                self.inputNum = "";         
                                self.authChecked = false; 
                            }
                        }
                    });
                },
                fnChangePwd: function () {
                    let self = this;
                    let speChar = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])/;
                    if (self.newPwd1.length < 6) {
                        self.pwdFailedModal = true;
                        return; // stop function if invalid
                    }
                    if (!speChar.test(self.newPwd1)) {
                        self.pwdFailedModal = true;
                        return; // Stop the function if validation fails
                    }
                    if (self.newPwd1 !== self.newPwd2) {
                        self.pwdMismatched = true;
                        return; // stop function
                    }
                    let param = {
                        userId: self.pwd_userId,
                        newPwd1: self.newPwd1
                    };
                    console.log(self.pwd_userId)
                    $.ajax({
                        url: "/home/changePwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result === "success") {
                                self.pwdChangedModal = true;
                            } else {
                                self.pwdFailedModal = true;
                            }
                        }
                    });
                },
                closeModal() {
                    let self = this;
                    self.showModal = false;
                    self.pwdFailedModal = false;
                    self.id_name = "";
                    self.id_phone = "";
                    self.id_birth = "";
                    self.pwd_userId = "";
                    self.pwd_name = "";
                    self.pwd_phone = "";
                    self.pwd_birth = "";
                    self.newPwd1 = "";
                    self.newPwd2 = "";
                },
                fieldCloseModal() {
                    let self = this;
                    self.emptyId = false;
                    self.emptyPhone = false;
                    self.emptyBirth = false;
                    self.emptyAuthNum = false;
                    self.emptyName = false;
                    self.wrongAuth = false;
                },
                pwdClosemodal(){
                    let self = this;
                    self.pwdMismatched = false;
                },
                fnSms: function () {
                    let self = this;
                    let param = {
                        phone: self.pwd_phone
                    };
                    // Harcoding for test purposes
                    // self.smsFlg = true;
                    // self.fnTimer();
                     $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.res.statusCode == "2000") {
                                self.openModal("문자 전송 완료");
                                self.ranStr = data.ranStr;
                                self.smsFlg = true;
                                
                                // Clear existing timer and reset count
                                if (self.timerInterval) {
                                    clearInterval(self.timerInterval);
                                }
                                self.count = 180;
                                self.fnTimer();
                            } else {
                                self.openModal("잠시 후 다시 시도해주세요.");
                            }
                        }
                    });
                },
                fnSmsAuth: function () {
                    let self = this;
                    if (self.inputNum == "") {
                        self.openModal("인증번호를 입력해주세요.", function() {
                            document.querySelector("#auth").focus();
                        });
                        return;
                    }
                    if (self.ranStr == self.inputNum) {
                        self.joinFlg = true;
                        self.authFlag = true;
                        self.authChecked = true;
                        
                        // Clear the timer
                        if (self.timerInterval) {
                            clearInterval(self.timerInterval);
                            self.timerInterval = null;
                        }
                    } else {
                        self.openModal("인증번호가 올바르지 않습니다.");
                        self.joinFlg = false;
                        self.authChecked = false;
                    }
                },
                fnTimer: function () {
                    let self = this;
                    self.timerInterval = setInterval(function () {
                        if (self.count == 0) {
                            clearInterval(self.timerInterval);
                            self.timerInterval = null;
                            self.openModal("시간이 만료되었습니다!");
                            self.smsFlg = false;
                            self.inputNum = "";
                        } else {
                            let min = parseInt(self.count / 60);
                            let sec = self.count % 60;

                            min = min < 10 ? "0" + min : min;
                            sec = sec < 10 ? "0" + sec : sec;
                            self.timer = min + " : " + sec;

                            self.count--;
                        }
                    }, 1000);
                },
                fnAuthChecked: function () {
                    let self = this;
                    self.joinFlg = false;
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

                // 장바구니 수량을 서버에서 가져오는 함수
                fetchCartCount() {
                    // 세션 아이디가 없으면 실행하지 않음
                    if (this.sessionId == '' || this.sessionId == null) return;

                    let self = this;
                    $.ajax({
                        url: '/api/cartCount.dox',
                        method: 'GET',
                        // ★ 서버의 @RequestParam HashMap map으로 전달될 데이터 ★
                        data: {
                            sessionId: self.sessionId
                        },
                        dataType: 'json',
                        success: (response) => {
                            console.log("서버 응답 데이터:", response);
                            if (response.result === 'success') {
                                self.cartCount = response.count; // 서버에서 보낸 count 값을 Vue 변수에 저장
                            }
                        },
                        error: (err) => {
                            console.error("AJAX 호출 중 오류 발생:", err);
                        }
                    });
                },

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;

                // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
            }
        });

        app.mount('#app');
    </script>