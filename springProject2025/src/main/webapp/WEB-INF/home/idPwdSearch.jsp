<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/idSearch-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=check_circle" />
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
                <div v-if="!idFound && !pwdFound" class="search-container">
                    <!-- 🔹 아이디 찾기 / 비밀번호 찾기 폼 -->
                    <div class="id-search-container">
                        <h2>아이디 찾기</h2>
                        <div class="signup-form">
                        <div class="form-row">
                            <input type="text" placeholder="이름" v-model="id_name">
                        </div>
                        <div class="form-row">
                            <input type="text" placeholder="- 없이 전화번호를 입력하세요" v-model="id_phone">
                        </div>
                        <div class="form-row">
                            <input type="text" placeholder="생년월일  YYYY-MM-DD" v-model="id_birth" @keyup.enter="fnSearchId">
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
                                <input type="text" placeholder="아이디" v-model="pwd_userId">
                            </div>
                            <div class="form-row">
                                <input type="text" placeholder="이름" v-model="pwd_name">
                            </div>
                            <div class="form-row">
                                <input type="text" placeholder="- 없이 전화번호를 입력하세요" v-model="pwd_phone">
                            </div>
                            <div class="form-row">
                                <input type="text" placeholder="생년월일  YYYY-MM-DD" v-model="pwd_birth"  @keyup.enter="fnSearchPwd">
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
                
                <div v-else-if="pwdFound"  class="search-container"> 
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

                <!-- When id or password can't be found -->
                <div v-if="showModal" class="modal-overlay">
                    <div class="modal-content">
                        <h2>아이디/비밀번호 찾기 실패</h2>
                        <p>입력정보를 다시 확인해주세요. 입력하신 정보는 존재하지 않습니다.</p>
                        <button @click="closeModal">돌아가기</button>
                    </div>
                </div>

                <!-- When password successfully changed -->
                 <div v-if="pwdChangedModal"  class="modal-overlay">
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
                id_name : "",
                id_phone : "",
                id_birth : "",

                pwd_userId : "",
                pwd_name: "",
                pwd_phone : "",
                pwd_birth : "",

                idFound : false,
                pwdFound : false,
                info : {},
                newPwd1 : "",
                newPwd2 : "",

                showModal: false,
                pwdChangedModal: false,
                pwdFailedModal: false
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnSearchId: function () {
                let self = this;
                // 유효성 검사
                // if (!self.userId || !self.name || !self.phone) {
                //     alert("아이디, 비밀번호와 이메일을 입력하세요.");
                //     return;
                // }
                let param = {
                    name : self.id_name,
                    phone : self.id_phone,
                    birth : self.id_birth
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
            fnSearchPwd:function(){
                let self = this;
                let param = {
                    userId : self.pwd_userId,
                    name : self.pwd_name,
                    phone : self.pwd_phone,
                    birth : self.pwd_birth
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
                        }
                    }
                });
            },
            fnChangePwd:function(){
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
                    alert("비밀번호가 서로 다릅니다."); // alert if mismatch
                    return; // stop function
                }
                let param = {
                    userId : self.pwd_userId,
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
                            // 로그인 성공 시 페이지 전환
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
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>
