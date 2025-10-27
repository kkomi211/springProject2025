<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <title>Homepage</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        .signup{
        width: 500px;
        height: 600px;
        border: solid 1px black;
        margin: 50px 0;
      } 
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
                <div>
                    <div class="signup">
                        <div>
                            <label for="">
                                아이디 <input v-if="!checkFlg" type="text" v-model="userId" placeholder="아이디">
                                <input v-else type="text" disabled :placeholder="userId">
                            </label>
                            <button @click="fnIdCheck">중복확인</button>
                        </div>
                        <div>
                            <label for="">
                                이름 <input type="text" v-model="name" placeholder="이름">
                            </label>
                        </div>
                        <div>
                            <label for="">
                                비밀번호 <input type="password" v-model="pwd1" placeholder="비밀번호">
                            </label>
                        </div>
                        <div>
                            <label for="">
                                비밀번호 확인 <input type="password" v-model="pwd2" placeholder="비밀번호 확인">
                            </label>
                        </div>
                        <div>
                            <label for="">
                                닉네임 <input type="text" v-model="nickname">
                            </label>
                            <button @click="fnNicknameCheck">중복확인</button>
                        </div>
                        <div>
                            성별
                            <label for=""><input type="radio" v-model="gender" value="M">M</label>
                            <label for=""><input type="radio" v-model="gender" value="F">F</label>
                        </div>
                        <div>
                            <label for="">
                                이메일
                                <input type="text" v-model="email">
                            </label>
                        </div>
                        <div>
                            <label for="">
                                주소 : <input v-model="addr" id="addr" > <button @click="fnAddr">주소검색</button>
                            </label></div>
                        <div>
                            <label for="">
                                생년월일 <input type="text" placeholder="YYYY-MM-DD" v-model="birthday">
                            </label>
                        </div>
                        <div>
                            <label for="">
                                전화번호 <input type="text" v-model="phone">
                            </label>
                            <button @click="fnIdCheck">본인인증</button>
                        </div>
                        <div>
                            <button @click="fnSignup">회원 가입 완료</button>
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
                gender: "M"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
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
                            alert("사용된 아이디 입니다.");
                            document.querySelector("#id").focus();
                        } else {
                            alert("사용가능한 아이다 입니다.");
                            self.checkFlg = true;
                        }
                    }
                });
            },
            fnNicknameCheck: function (){
                let self = this;
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
                            alert("사용된 닉네임 입니다.");
                            // document.querySelector("#id").focus();
                        } else {
                            alert("사용가능한 닉네임 입니다.");
                            self.checkFlg = true;
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
                if(self.name == ""){
                    alert("이름을 입력해주세요.");
                    document.querySelector("#name").focus();
                    return;
                }
                if(self.pwd1.length < 6){
                    alert("비밀먼호는 6글자로 입력해주세요.");
                    // document.querySelector("#pwd1").focus();
                    return;
                }
                if(!speChar.test(self.pwd1)){
                    alert("비밀번호에는 최소한 하나의 특수 문자가 포함되어야 합니다.");
                    return;
                }
                if(self.pwd1 != self.pwd2){
                    alert("비밀번호를 다시 확인해주세요.");
                    // document.querySelector("#pwd2").focus();
                    return;
                }
                if(self.nickname == ""){
                    alert("Please enter nickname.");
                    return;
                }
                if(self.email == ""){
                    alert("Please enter email.");
                }
                if(self.addr.length == 0){
                    alert("주소를 입력해주세요.");
                    return;
                }
                if(self.phone == ""){
                    alert("Please enter phone number.");
                }
                let param = {
                    userId : self.userId,
                    pwd : self.pwd1,
                    nickname : self.nickname,
                    gender : self.gender,
                    email : self.email,
                    addr : self.addr,
                    birthday : self.birthday,
                    phone : self.phone,
                    name : self.name
                };
                $.ajax({
                    url: "/home/signup.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result = "success"){
                            alert("가입되었습니다.");
                        } else {
                            alert("오류가 발생했습니다.");
                            location.href="/home/login.do";
                        } 
                        
                    }
                        
                }); 
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>