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
                                    <li @click="moveToOrder">
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
                                회원가입정보 수정
                            </h3>
                            <section class="check-info">
                                <table>
                                    <tr>
                                        <th>
                                            이메일
                                        </th>
                                        <td>
                                            <template v-if="!emailFlg">{{info.email}}</template>
                                            <template v-else><input type="text" v-model="info.email" id="email"></template>
                                        </td>
                                        <td>
                                            <template v-if="!emailFlg">
                                                <button class="btn" @click="fnEmailChange">이메일 수정 </button>
                                            </template>
                                            <template v-else>
                                                <button class="btn" @click="fnEmailCheck">중복확인 </button>
                                                <button class="btn" v-if="saveBtn" @click="fnEmailSave">저장</button>
                                            </template>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>이름</th>
                                        <td>
                                            <template v-if="!nameFlg">{{info.name}}</template>
                                            <template v-else><input type="text" v-model="info.name"></template>
                                        </td>
                                        <td>
                                            <button class="btn" v-if="!nameFlg" @click="fnNameChange">이름 수정 </button>
                                            <button class="btn" v-if="nameFlg" @click="fnNameSave">저장</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>휴대폰번호</th>
                                        <td>
                                            <template v-if="!phoneFlg ">{{info.phone}}</template>
                                            <template v-else><input type="text" v-model="info.phone" id="phone"></template>
                                        </td>
                                        <td>
                                            <button class="btn" v-if="!phoneFlg" @click="fnPhoneChange">휴대폰번호 수정 </button>
                                            <button class="btn" v-if="phoneFlg" @click="fnPhoneSave">저장</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>비밀번호 변경</th>
                                        <td>
                                            <template v-if="!pwdFlg">
                                                <div>
                                                    현재 비밀번호 
                                                    <div><label for=""><input type="password" v-model="pwd" id="pwd"></label></div>
                                                </div>
                                                <div>
                                                    새 비밀번호
                                                    <div>
                                                        <label for=""><input type="password" v-model="newPwd1" id="newPwd1"></label>
                                                    </div></div>
                                                <div>
                                                    비밀번호 재확인
                                                    <div>
                                                        <label for=""><input type="password" v-model="newPwd2" id="newPwd2"></label>
                                                    </div>
                                                </div>
                                            </template>
                                            <template v-else>
                                                <div>비밀번호 변경되었습니다.</div>
                                            </template>
                                        </td>
                                        <td>
                                            <button class="btn" @click="fnPwdChange">비밀번호 변경</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>배송지</th>
                                        <td>
                                            <div v-if="!addrFlg">{{info.addr}}</div>
                                            <div v-if="addrFlg"><input type="text" v-model="addr" id="addr" disabled></div>
                                        </td>
                                        <td>
                                            <button class="btn" v-if="!addrFlg" @click="fnAddr">주소 수정</button>
                                            <button class="btn" v-if="addrFlg" @click="fnAddrSave">저장</button>
                                        </td>
                                    </tr>
                                </table>
                            </section>
                            <div class="bottom-btn">
                                <button class="btn" @click="fnConfirmDelete">탈퇴하기</button>
                            </div>

                            <!-- Popup asking the user really wants to delete their account -->
                             
                            <div v-if="confirmDelete" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>정말로 이 계정을 삭제하시겠습니까?</h2>
                                    <button class="btn" @click="closeModal">돌아가기</button>
                                    <button class="btn" @click="fnDeleteAccount">삭제하기</button>
                                </div>
                            </div>

                            <!-- Popup confirming the user deleted their account -->
                             
                            <div v-if="accountDeleted" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>회원님의 계정이 삭제되었습니다.</h2>
                                    <button class="btn" @click="moveMainPage">닫기</button>
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
                pwd : "",
                sessionId : "${sessionId}",
                info : {},
                email : "",
                addr : "",
                pwd : "",
                newPwd1 : "",
                newPwd2 : "",

                // Flags
                emailFlg : false,
                nameFlg : false,
                phoneFlg : false,
                saveBtn : false,
                pwdFlg : false,
                addrFlg : false,

                // Popup Modal
                confirmDelete : false,
                accountDeleted : false

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
                            alert("info checked successfully !");
                        } else {
                            alert("error");
                        }

                    }
                });
            },
            moveToRefund: function() {
                let self = this;
                console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");
                
                // 1. Vue의 sessionId 데이터에 접근
                // const sessionIdParam = self.sessionId;

                // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장)
                pageChange("/home/mypage/refund-return.do", { sessionId: self.sessionId });
            },
            moveToOrder: function () {
                let self = this;
                console.log("반품•교환 내역 메뉴 클릭. pageChange 호출");

                // 1. Vue의 sessionId 데이터에 접근
                // const sessionIdParam = self.sessionId;

                // 2. pageChange 함수 호출 (전역 함수이므로 window.pageChange 사용 권장?)
                pageChange("/home/mypage/orders.do", { sessionId: self.sessionId });
            },
            fnAddr: function (){
                let self = this;
                window.open("/addr.do", "addr", "width=500, height = 500");
                self.addrFlg = true;
            },
            fnResult: function(roadFullAddr, addrDetail, zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnEmailChange : function(){
                let self = this;
                self.emailFlg = true;
            },
            fnNameChange : function(){
                let self = this;
                self.nameFlg = true;
            },
            fnPhoneChange : function(){
                let self = this;
                self.phoneFlg = true;
            },
            fnEmailCheck : function(){
                let self = this;
                let param = {
                    email : self.info.email
                };
                console.log(self.info.email);
                $.ajax({
                    url: "/home/mypage/emailCheck.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("사용가능한 이메일 입니다.");
                            self.saveBtn = true;
                        } else {
                            alert("이미 사용 중인 이메일 입니다.");
                            document.querySelector("#email").focus();
                            self.saveBtn = false;
                        }

                    }
                });
            },
            fnEmailSave : function(){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    email : self.info.email
                };
                $.ajax({
                    url: "/home/mypage/emailSave.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("이메일이 수정되었습니다.");
                            self.emailFlg = false;
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnNameSave : function(){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    name : self.info.name
                };
                console.log(self.info.name);
                $.ajax({
                    url: "/home/mypage/nameSave.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("이름이 수정되었습니다.");
                            self.nameFlg = false;
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnPhoneSave: function (){
                let self = this;
                if (self.info.phone.length < 11 || !/^[0-9]+$/.test(self.info.phone)) {
                    alert("전화번호를 다시 확인해주세요.");
                    document.querySelector("#phone").focus();
                    return;
                }
                let param = {
                    userId : self.sessionId,
                    phone : self.info.phone
                };
                $.ajax({
                    url: "/home/mypage/phoneSave.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("전화번호가 수정되었습니다.");
                            self.phoneFlg = false;
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnPwdChange:function(){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    pwd : self.pwd
                };
                // GOTTA CHECK IF THE ENCODED PASSWORD IS MATCHING
                $.ajax({
                    url: "/home/login.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            self.fnPwdSave();
                        } else {
                            alert("입력하신 비밀번호가 현재 비밀번호와 일치하지 않습니다.");
                            document.querySelector("#pwd").focus();
                        }
                    }
                });
            },
            fnPwdSave:function(){
                let self = this;
                let speChar = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])/;

                if(self.newPwd1 == ""){
                    alert("새 비밀번호를 입력하세요.");
                    document.querySelector("#newPwd1").focus();
                    return;
                }
                if (self.newPwd1.length < 6 || !speChar.test(self.newPwd1)) {
                    alert("비밀번호는 공백 없이 6자 이상의 영문자, 숫자, 특수문자 조합으로 지정해주세요.");
                    document.querySelector("#newPwd1").focus();
                    return; 
                }
                if (self.newPwd1 !== self.newPwd2) {
                    alert("비밀번호가 서로 다릅니다. 다시 확인해주세요.");
                    document.querySelector("#newPwd2").focus();
                    return; 
                }
                let param = {
                    userId : self.sessionId,
                    newPwd1: self.newPwd1
                };
                $.ajax({
                    url: "/home/changePwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if (data.result === "success") {
                            // 로그인 성공 시 페이지 전환
                            alert("비밀번호 변경이 완료되었습니다!");
                            self.pwdFlg = true;
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnAddrSave:function(){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    addr : self.addr
                };
                // GOTTA CHECK IF THE ENCODED PASSWORD IS MATCHING
                $.ajax({
                    url: "/home/mypage/addrSave.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("주소가 수정되었습니다.");
                            self.addrFlg = false;
                            self.fnInfo();
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnConfirmDelete: function(){
                let self = this;
                self.confirmDelete = true; // Modal Popup
            },
            fnDeleteAccount : function () {
                let self = this;
                let param = {
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/home/mypage/deleteAccount.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            self.confirmDelete = false;
                            self.accountDeleted = true;
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
                
            },
            moveMainPage : function(){
                let self = this;
                location.href="/home.do";
            },
            closeModal() {
                let self = this;
                self.confirmDelete = false;
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>