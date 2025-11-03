<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/post-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <title>Community</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <script src="/js/page-change.js"></script>
    <style>
        textarea {
            /* !important를 사용하여 다른 CSS보다 우선순위를 높입니다. */
            resize: none !important;
            background-color: #f9f9f9;
        }

        input[readonly], textarea[readonly] {
            background-color: #f9f9f9;
            cursor: default;
        }

        .main-content {
            position: relative;
            /* 버튼 기준점을 주기 위해 필요 */
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
                            <h2 class="sidebar-heading"> COMMUNITY ></h2>
                            <nav class="mypage-menu">
                                <ul>
                                    <li class="active">
                                        <span class="icon">📝</span>
                                        <a href="#">게시판</a>
                                    </li>
                                    <li @click="moveToRefund">
                                        <span class="icon">📦</span>
                                        <a href="javascript:;">크루 찾기</a>
                                    </li>
                                    <li>
                                        <span class="icon">💬</span>
                                        <a href="#">대회정보</a>
                                    </li>
                                    <li @click="moveToInfo">
                                        <span class="icon">👤</span>
                                        <a href="#">채팅방</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>
                        <main class="main-content">
                            <div class="board-header">
                                <h1 class="main-title">
                                    게시판 • 수정하기
                                </h1>
                            </div>
                            <table class="edit-table">
                                <tr>
                                    <th>아이디</th>
                                    <td>{{sessionId}}</td>
                                </tr>
                                <tr>
                                    <th>카테고리</th>
                                    <td>
                                    <input type="radio" value="B" v-model="type">공지
                                    <input type="radio" value="Q" v-model="type">문의
                                    <input type="radio" value="F" v-model="type">자유
                                    <input type="radio" value="R" v-model="type">대회
                                    </td>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <td>
                                        <div class="title-input">
                                            <label for=""><input id="title" type="text" v-model="boardInfo.title"></label>
                                            <label for=""><input id="keylock" type="password" placeholder="잠금설정" v-model="boardInfo.pwd"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <td>
                                        <div id="editor"></div>
                                    </td>
                                </tr>
                            </table>
                            <div class="bottom-btn">
                                <button @click="fnEditPost">저장</button>
                                <button @click="fnMoveToBoard">목록</button>
                            </div>

                            <!-- If the user is not logged in -->
                             
                            <div v-if="!isLoggedIn " class="modal-overlay">
                                <div class="modal-content">
                                    <h2>로그인 후 이용해주세요.</h2>
                                    <div class="modal-btn">
                                        <button @click="fnMoveToLogin">로그인</button>
                                        <button @click="fnCloseModal">닫기</button>
                                    </div>
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
                sessionId : "${sessionId}",
                userName : "",
                boardList : [],
                boardInfo : {},
                boardNo : "${boardNo}",
                keyword : "",
                type : "",
                title : "",
                keylock : "",
                content : "",

                // pagination
                cnt: 0,
                page: 1,
                pageSize: 10,
                index: 0,

                // popup modal
                isLoggedIn : true

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
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
            fnEditPost : function (){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    type : self.type,
                    boardNo : self.boardNo,
                    title : self.boardInfo.title,
                    keylock : self.boardInfo.pwd,
                    contents : self.content
                };
                console.log("updated type == > ", self.type);
                console.log("updated title == > ", self.boardInfo.title);
                console.log("updated keylock == > ", self.boardInfo.pwd);
                console.log("updated content == > ", self.content);
                console.log("user ID == > ", self.sessionId);
                console.log("board NO == > ", self.boardNo);
                // console.log("updated title == > ", self.title);

                $.ajax({
                    url: "/board/post-edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("게시글이 수정되었습니다.");
                            pageChange("/home/community/board/view.do", { boardNo: self.boardInfo.boardNo });
                        } else {
                            alert("수정 중 오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnBoardInfo: function () {
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                console.log("boardNo ==>" + self.boardNo)
                $.ajax({
                    url: "/board/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            console.log(data);
                            self.boardInfo = data.info;
                            self.type = self.boardInfo.type;
                            self.keylock = self.boardInfo.pwd;
                            self.content = self.boardInfo.contents;

                            if (self.quill) {
                                self.quill.root.innerHTML = self.boardInfo.contents || "";
                            }
                        } else {
                            console.log("오류");
                        }

                    }
                });
            },
            fnMoveToBoard : function(){
                let self = this;
                // make a modal here
                if(!confirm("게시글이 저장되지 않습니다. 계속 진행하시겠습니까?")){
                    return;
                }
                location.href="/home/community/board.do";
            },
            fnMoveToLogin : function(){
                let self = this;
                location.href="/home/login.do";
            },
            fnCloseModal:function(){
                let self = this;
                self.isLoggedIn = true;

            }
        }, // methods
        mounted() {
            let self = this;
            
            self.fnGetUserInfo();

            if(self.sessionId == ""){
                self.isLoggedIn = false;
            } else {
                self.isLoggedIn = true;
            }

            // text editor
            self.quill = new Quill('#editor', {
                theme: 'snow',
                modules: {
                    toolbar: [
                        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                        ['bold', 'italic', 'underline'],
                        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            });

            self.quill.on('text-change', function () {
                self.content = self.quill.root.innerHTML;
            });
            self.fnBoardInfo();
        }
    });

    app.mount('#app');
</script>
