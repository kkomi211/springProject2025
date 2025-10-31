<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/user-style.css">
    <link rel="stylesheet" href="/css/board-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
    <title>Community</title>
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
                                    게시판 •
                                    {{
                                        type === '' ? '전체 게시판' :  
                                        type === 'B' ? '공지사항' :
                                        type === 'Q' ? '문의게시판' :
                                        type === 'F' ? '자유게시판' :
                                        type === 'R' ? '대회게시판' :
                                        '게시판'
                                    }}
                                </h1>
                                <div class="search-bar">
                                    <div class="search-wrapper">
                                        <select v-model="type" @change="fnBoardList">
                                            <option value="">전체</option>
                                            <option value="B">공지사항</option>
                                            <option value="Q">문의게시판</option>
                                            <option value="F">자유게시판</option>
                                            <option value="R">대회게시판</option>
                                        </select>
                                        <input type="text" placeholder="검색어" v-model="keyword" @keyup.enter="fnBoardList">
                                        <button class="search-btn" @click="fnBoardList">🔍</button>
                                    </div>
                                </div>
                            </div>
                            <select class="btn" v-model="pageSize" @change="fnBoardList">
                                <option class="btn" value="5">5개씩</option>
                                <option class="btn" value="10">10개씩</option>
                                <option class="btn" value="20">20개씩</option>
                            </select>
                             <table>
                                <tr>
                                    <th>No</th>
                                    <th>제목</th>
                                    <th>작정자</th>
                                    <th>작성일</th>
                                    <th>조회수</th>
                                </tr>
                                <tr v-for="item in boardList">
                                    <td>{{item.boardNo}}</td>
                                    <td>
                                        <a href="javascript:;" @click="fnPostView(item.boardNo)">
                                            {{item.title}}
                                            <span v-if="item.pwd && item.pwd > 0" title="비밀글 🔒">🔒</span>
                                        </a>
                                        
                                    </td>
                                    <td>{{item.userId}}</td>
                                    <td>{{item.cdate}}</td>
                                    <td>{{item.viewCnt}}</td>
                                </tr>
                            </table>
                            <div v-if="index > 0" class="pagination">
                                <!-- <a v-if="page != 1" @click="fnMove(1)" href="javascript:void(0)">←</a> -->
                                <a v-if="page >= 2" @click="fnMove(page - 1)" href="javascript:void(0)">◀</a>
                                <a @click="fnMove(num)" id="index" href="javascript:void(0)" v-for="num in index"
                                    :key="num" >
                                    <span :class="{ active: page == num }">{{ num }}</span>
                                </a>
                                <a v-if="page != index" @click="fnMove(page + 1)" href="javascript:void(0)">▶</a>
                                <!-- <a v-if="page != index" @click="fnMove(index)" href="javascript:void(0)">→</a> -->
                            </div>
                            <div class="write-btn-wrapper">
                                <button @click="moveToPost" class="btn">글쓰기</button>
                            </div>

                            <!-- Popup asking for the user post's password -->
                             
                            <div v-if="pwdCorrect" class="modal-overlay">
                                <div class="modal-content">
                                    <h2>비밀글로 보호된 게시물입니다.</h2>
                                    <p>비밀번호를 입력해야 내용을 확인할 수 있습니다.</p>
                                    <input class="btn" type="password" @keyup.enter="fnKeylock" placeholder="비밀번호 입력">
                                    <div>
                                        <button class="btn" @click="pwdCorrect = false">닫기</button>
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
                postInfo : {},
                keyword : "",
                type : "",

                // pagination
                cnt: 0,
                page: 1,
                pageSize: 10,
                index: 0,

                // modal popup 
                pwdCorrect : false,
                selectedPost: null,  // store the post object being clicked
                keylock: ""  
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
            fnBoardList: function () {
                let self = this;
                let startRow = (self.page - 1) * self.pageSize + 1;
                let endRow = self.page * self.pageSize;
                let param = {
                    type : self.type,
                    keyword : self.keyword.trim(),
                    page: self.page,
                    pageSize: self.pageSize,
                    startRow: startRow,
                    endRow: endRow
                };
                console.log("type ==>" + self.type, "keyword ==>" + self.keyword);
                $.ajax({
                    url: "/board/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            console.log(data);
                            self.boardList = data.list;
                            self.cnt = data.cnt;
                            self.index = Math.ceil(self.cnt / self.pageSize);
                        } else {
                            console.log("오류");
                        }

                    }
                });
            },
            fnMove: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnBoardList();
            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnBoardList();
            },
            moveToPost : function(){
                let self = this;
                pageChange("/home/community/board/post.do", { sessionId: self.sessionId});
            },
            fnPostView:function(boardNo){
                let self = this;
                let param = {
                    boardNo : boardNo
                };
                let post = self.boardList.find(item => item.boardNo === boardNo);
                    
                if (post.pwd && post.pwd.length > 0) {
                    // Show password modal
                    self.selectedPost = post;
                    self.pwdCorrect = true;
                    self.keylock = ""; // reset input
                } else {
                    // No lock, go directly to the post
                    pageChange("board/view.do", { boardNo: boardNo });
                }

                // pageChange("board/view.do", {boardNo : boardNo});
            },
            fnKeylock : function(){
                let self = this;
                let param = {
                    keylock : self.keylock
                };
                    $.ajax({
                        url: "/home/community/board/keylock.dox",
                        dataType: "json",
                        type: "POST",
                        data : param,
                        success: function (data) {
                            if(data.result == "success"){
                                // location.href="";
                                alert("Correct password.");
                            } else {
                                alert("Wrong password.");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("사용자 정보 조회 실패:", error);
                            self.userName = "Guest";
                        }
                    });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBoardList();
            self.fnGetUserInfo();
        }
    });

    app.mount('#app');
</script>
