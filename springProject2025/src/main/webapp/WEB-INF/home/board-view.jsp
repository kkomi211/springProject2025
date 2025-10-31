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
            background-color: rgb(233, 233, 233);
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95rem;
            /* font-weight: 600; */
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        /*  hover 효과 */
        .main-content button:hover {
            background-color: gray;
            transform: scale(1.02);
            /* 살짝 커지는 느낌 */
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
                                    게시판 • 상세보기
                                </h1>
                            </div>
                           
                            <div class="post-container">
                                <div class="post-header">
                                    <div class="post-meta">
                                    <span class="post-category">
                                        {{
                                        type === 'B' ? '공지사항' :
                                        type === 'Q' ? '문의게시판' :
                                        type === 'F' ? '자유게시판' :
                                        type === 'R' ? '대회게시판' :
                                        '게시판'
                                        }}
                                    </span>
                                    <span class="post-date">{{ boardInfo.chardate }}</span>
                                    </div>
                                    <h2 class="post-title">{{ boardInfo.title }}</h2>
                                    <div class="post-author">
                                    <strong>{{ sessionId }}</strong> 님의 게시글
                                    </div>
                                </div>

                                <div class="post-content" v-html="boardInfo.contents"></div>
                            </div>

                            <div class="comments-section">
                                <h3 class="comment-title">
                                    💬 {{ commentList.length }} Comments
                                </h3>

                                <div class="comment-view" v-if="commentList.length > 0">
                                    <div v-for="item in commentList" :key="item.commentNo" class="comment-card">
                                    <div class="comment-header">
                                        <div class="comment-author">{{ item.userId }}</div>
                                        <div class="comment-date">{{ item.chardate }}</div>
                                    </div>
                                    <div class="comment-body">
                                        {{ item.contents }}
                                    </div>
                                    </div>
                                </div>

                                <div v-else class="no-comments">
                                    아직 댓글이 없습니다. 첫 번째로 댓글을 남겨보세요!
                                </div>
                            </div>


                            <div class="comment-box">
                                <div class="comment-header">
                                    <strong>{{userName}}</strong>
                                </div>
                                <div class="comment-input">
                                    <textarea placeholder="댓글을 남겨보세요" v-model="commentContent"></textarea>
                                    <button @click="fnPostComment">등록</button>
                                </div>
                                </div>
                            <div >
                                <button @click="fnMoveToBoard">목록</button>
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
                boardInfo : {},
                boardNo : "${boardNo}",
                commentList : [],

                keyword : "",
                type : "B",
                title : "",
                keylock : "",
                content : "",

                // pagination
                cnt: 0,
                page: 1,
                pageSize: 10,
                index: 0,

                // popup modal
                isLoggedIn : true,

                // post comment
                commentContent : ""

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
                        } else {
                            console.log("오류");
                        }

                    }
                });
            },
            fnMoveToBoard : function(){
                let self = this;
                // make a modal here
                location.href="/home/community/board.do";
            },
            moveToLogin : function(){
                let self = this;
                location.href="/home/login.do";
            },
            moveToBoard : function(){
                let self = this;
                location.href="/home/community/board.do";
            },
            fnViewComment:function(){
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                console.log("boardNo ==>" + self.boardNo);
                $.ajax({
                    url: "/board/comment.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            console.log("comment data == > ", data);
                            self.commentList = data.list;
                        } else {
                            console.log("오류");
                        }

                    }
                });
            },
            fnPostComment : function(){
                let self = this;
                let param = {
                    userId : self.sessionId,
                    contents : self.commentContent,
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "/board/comment-post.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("Your post have been uploaded");
                            self.fnViewComment();
                            self.commentContent = "";
                        } else {
                            alert(error);
                        }

                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBoardInfo();
            self.fnGetUserInfo();
            self.fnViewComment();
        }
    });

    app.mount('#app');
</script>
