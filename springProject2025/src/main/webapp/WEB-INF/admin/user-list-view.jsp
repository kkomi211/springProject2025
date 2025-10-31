<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/admin-inquiry.css">
    <script src="/js/page-change.js"></script>

</head>
<body class="adminbody">
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
		<!-- 상단 검은색 바 -->
		<div class="topbar">
		    <div><strong>관리자 메인화면</strong></div>
		    <div>관리자 test123 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none" @click="fnLogout">로그오프</a></div>
		</div>
		<!-- 메뉴 바 (검은색) -->
		<div class="nav-black">
		    <a href="/admin.do">MAIN</a>
		    <a href="/admin/banner.do">배너 이미지 관리</a>
		    <a href="/admin/inquiry.do">문의/리스트</a>
		    <a href="/admin/refund-return.do">교환/환불</a>
		    <a href="/admin/product.do">상품 리스트</a>
		    <a href="/admin/orders.do">주문 내역</a>
		    <a href="/admin/board-report.do">게시판 신고 리스트</a>
		    <a href="/admin/user-list.do" class="active">회원 관리 화면</a>
		</div>
		<!-- 본문 -->
		<div class="content">
            <div>
		        <h2>ghldnjs </h2>
            </div>
            <div>
                <table class="detail-table">
                    <tr>
                        <th>유저아이디</th>
                        <td>{{detail.userId}}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>{{detail.name}}</td>
                    </tr>
                    <tr>
                        <th>닉네임</th>
                        <td>{{detail.nickName}}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>
                            <span v-if="detail.gender === 'M'">남자</span>
                            <span v-else-if="detail.gender === 'F'">여자</span>
                            <span v-else>알 수 없음</span>
                        </td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>{{detail.email}}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>{{detail.addr}}</td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>{{detail.birth}}</td>
                    </tr>
                    <tr>
                        <th>휴대폰번호</th>
                        <td>{{detail.phone}}</td>
                    </tr>
                    <tr>
                        <th>가입날짜</th>
                        <td>{{detail.cDate}}</td>
                    </tr>
                    <tr>
                        <th>정보수정날짜</th>
                        <td>{{detail.uDate}}</td>
                    </tr>
                    <tr>
                        <th>유저타입</th>
                        <td>
                            <span v-if="detail.userType === 'U'">일반 유저</span>
                            <span v-else-if="detail.userType === 'A'">관리자</span>
                            <span v-else>알 수 없음</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="button-group">
                <button @click="fnDeleteUser()" class="btn-delete">삭제하기</button>
                <button @click="fnBack()" class="btn-back">목록으로</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                sessionId : "",
                userId : "${userId}", // 컨트롤러에서 전달받은 userId
                detail : {} // 상세 정보 객체
            };
        },
        methods: {
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnUserDetailInfo : function() {
                let self = this;
                let param = {
                    userId: self.userId
                };
                $.ajax({
                    url: "/admin/user-list/detail.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if (data.result === "success") {
                            self.detail = data.detail;
                        } else {
                            alert("회원 정보를 불러오는데 실패했습니다.");
                            self.fnBack();
                        }
                    }
                });
            },
            fnBack: function() {
                location.href = "/admin/user-list.do";
            },
            fnDeleteUser: function() {
                let self = this;

                console.log("현재 self.userId:", self.userId);
                console.log("현재 self.detail.name:", self.detail.name);
                
                var confirmMessage = "'" + self.detail.name + "' 회원(" + self.userId + ")을 정말로 삭제하시겠습니까?";
                if(!confirm(confirmMessage)) {
                    return; // 사용자가 '아니오'를 누르면 함수 종료
                }

                // AJAX 요청으로 회원 삭제
                $.ajax({
                    url: "/admin/user-list/delete.dox", // 삭제 요청 URL
                    dataType: "json",
                    type: "POST", // 삭제는 POST 요청
                    data: { userId: self.userId }, // 삭제할 회원 ID 전달
                    success: function (data) {
                        if(data.result === "success") {
                            alert("회원 삭제가 완료되었습니다.");
                            self.fnBack(); // 삭제 성공 시 목록 페이지로 이동
                        } else {
                            alert("회원 삭제에 실패했습니다.\n" + data.message); // 실패 메시지 표시
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("회원 삭제 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                        console.error("AJAX Error:", status, error, xhr.responseText);
                    }
                });
            }
        },
        mounted() {
            let self = this;
            self.fnUserDetailInfo();
        }
    });

    app.mount('#app');
</script>