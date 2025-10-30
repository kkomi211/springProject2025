<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/signup-style.css">
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
                    <div class="signup-container">
                        <h2>회원가입</h2>
                        <div class="signup-form">
                            <div class="form-row">
                                <label>아이디</label>
                                <input v-if="!checkFlg" type="text" placeholder="아이디" v-model="userId" id="userId">
                                <input v-else type="text" disabled :placeholder="userId">
                                <button @click="fnIdCheck">중복확인</button>
                            </div>
                            <div class="form-row">
                                <label>이름</label>
                                <input type="text" placeholder="이름" v-model="name" id="name">
                            </div>
                            <div class="form-row">
                                <label>비밀번호</label>
                                <input type="password" placeholder="6자 이상, 영문/숫자/특수문자" v-model="pwd1" id="pwd1">
                            </div>
                            <div class="form-row">
                                <label>비밀번호 확인</label>
                                <input type="password" placeholder="비밀번호 확인" v-model="pwd2" id="pwd2">
                            </div>
                            <div class="form-row">
                                <label>닉네임</label>
                                <input type="text" placeholder="닉네임" v-model="nickname" id="nickname">
                                <button @click="fnNicknameCheck">중복확인</button>
                            </div>
                            <div class="form-row">
                                <label>성별</label>
                                <label>
                                    <input type="radio" v-model="gender" value="F"> F
                                    <input type="radio" v-model="gender" value="M"> M
                                </label>
                            </div>
                            <div class="form-row">
                                <label>이메일</label>
                                <input type="text" placeholder="이메일" v-model="email" id="email">
                            </div>
                            <div class="form-row">
                                <label>주소</label>
                                <input disabled type="text" v-model="addr" id="addr" id="addr">
                                <button @click="fnAddr">주소검색</button>
                            </div>
                            <div class="form-row">
                                <label>생년월일</label>
                                <input type="date" v-model="birthday" id="birth">
                            </div>
                            <div class="form-row">
                                <label>전화번호</label>
                                <input type="text" placeholder="- 없이 전화번호를 입력하세요" v-model="phone" @keyup.enter="fnSignup" id="phone">
                                
                            </div>
                            <!-- 문자인증 일단 뺀다 -->
                             
                            <!-- <div v-if="!joinFlg" class="form-row">
                                <label>문자인증</label>
                                <input type="text" v-model="inputNum" :placeholder="timer" id="auth">
                                <template v-if="!smsFlg">
                                    <button @click="fnSms">인증번호 전송</button>
                                </template> 
                                <template v-else>
                                    <button @click="fnSmsAuth">인증</button>
                                </template>
                            </div>
                            <div v-else style="color : red">
                                문자인증이 완료되었습니다.
                            </div> -->
                            <div class="form-submit">
                                <button @click="fnSignup" class="submit-btn">회원 가입 완료</button>
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
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                userId : "",
                name : "",
                pwd1 : "",
                pwd2 : "",
                nickname : "",
                gender : "",
                email : "",
                addr : "",
                birthday : "",
                phone : "",
                checkFlg : false,
                gender: "F",

                smsFlg : false,
                joinFlg : false, // 문자 인증 유무
                ranStr : "", // 문자 인증 번호 
                inputNum : "",
                timer : "",
                count : 180
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
                if(self.userId == ""){
                    alert("아이디를 입력해주세요.");
                    document.querySelector("#userId").focus();
                    return;
                }
                let param = {
                    userId : self.userId
                };
                $.ajax({
                    url: "/home/idCheck.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "true"){
                            alert("이미 사용 중인 아이디 입니다.");
                        } else {
                            alert("사용가능한 아이디 입니다.");
                            self.checkFlg = true;
                            document.querySelector("#name").focus();
                        }
                    }
                });
            },
            fnNicknameCheck: function (){
                let self = this;
                if(self.nickname == ""){
                    alert("닉네임을 입력해주세요.");
                    return;
                }
                let param = {
                    nickname : self.nickname
                };
                $.ajax({
                    url: "/home/nicknameCheck.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "true"){
                            alert("이미 사용 중인 닉네임 입니다.");
                            document.querySelector("#nickname").focus();
                        } else {
                            alert("사용가능한 닉네임 입니다.");
                            self.checkFlg = true;
                            document.querySelector("#email").focus();
                        }
                    }
                });
            },
            fnAddr: function (){
                let self = this;
                window.open("/addr.do", "addr", "width=500, height = 500");
            },
            fnResult: function(roadFullAddr, addrDetail, zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnSignup: function(){
                let self = this;
                let speChar = /[!@#$%^&*(),.?":{}|<>]/;
                if(self.userId == ""){
                    alert("아이디를 입력해주세요.");
                    document.querySelector("#userId").focus();
                    return;
                }
                if(self.name == ""){
                    alert("이름을 입력해주세요.");
                    document.querySelector("#name").focus();
                    return;
                }
                if (self.pwd1.length < 6) {
                    alert("비밀번호를 입력해주세요.");
                    document.querySelector("#pwd1").focus();
                    return;
                }
                if(!speChar.test(self.pwd1)){
                    alert("비밀번호에는 최소한 하나의 영문, 숫자, 특수문자가 포함되어야 합니다.");
                    document.querySelector("#pwd1").focus();
                    return;
                }
                if(self.pwd1 != self.pwd2){
                    alert("비밀번호를 다시 확인해주세요.");
                    document.querySelector("#pwd2").focus();
                    return;
                }
                if(self.nickname == ""){
                    alert("닉네임을 입력해주세요.");
                    document.querySelector("#nickname").focus();
                    return;
                }
                if(self.email == ""){
                    alert("이메일 입력해주세요.");
                    document.querySelector("#email").focus();
                    return;
                }
                if(self.addr.length == 0){
                    alert("주소를 입력해주세요.");
                    document.querySelector("#addr").focus();
                    return;
                }
                if(self.birthday == ""){
                    alert("생년월일를 입력해주세요.");
                    document.querySelector("#birth").focus();
                    return;
                }
                if(self.phone == ""){
                    alert("전화번호를 입력해주세요.");
                    document.querySelector("#phone").focus();
                    return;
                }
                if (self.phone.length < 11 || !/^[0-9]+$/.test(self.phone)) {
                    alert("전화번호를 다시 확인해주세요.");
                    document.querySelector("#phone").focus();
                    return;
                }
                let param = {
                    userId : self.userId.trim(),
                    pwd : self.pwd1,
                    nickname : self.nickname.trim(),
                    gender : self.gender,
                    email : self.email.trim(),
                    addr : self.addr,
                    birthday : self.birthday,
                    phone : self.phone.trim(),
                    name : self.name.trim()
                };
                $.ajax({
                    url: "/home/signup.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result = "success"){
                            alert("가입되었습니다.");
                            location.href="/home/login.do";
                        } else {
                            alert("오류가 발생했습니다.");
                        } 
                        
                    }
                        
                }); 
            },
            fnSms: function(){
                let self= this;
                let param = {
                };
                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.statusCode == "2000"){
                            alert("문자 전송 완료");
                            self.ranStr = data.ranStr;
                            self.smsFlg = true;
                            self.fnTimer();
                        } else {
                            alert("잠시 후 다시 시도해주세요.");
                        }
                    }
                });
            },
            fnSmsAuth: function(){
                let self = this;
                if(self.ranStr == self.inputNum){
                    alert("문자 인증 완료되았습니다");
                    self.joinFlg = true;
                } else {
                    alert("문자인증 실패했습니다.");
                }
            },
            fnTimer: function(){
                let self = this;
                let interval = setInterval(function(){
                    if(self.count == 0){
                        clearInterval(interval);
                        alert("시간이  만료되었습니다!");
                    } else {
                        let min = parseInt(self.count / 60);
                        let sec = self.count % 60;
                    
                        min = min < 10 ? "0" + min : min;
                        sec = sec < 10 ? "0" + sec : sec;
                        self.timer = min + " : " + sec;

                        self.count--;
                    }
                }, 1000);
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>
