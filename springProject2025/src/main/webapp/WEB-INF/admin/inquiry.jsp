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
		    <a href="/admin.do" class="active">MAIN</a>
		    <a href="/admin/banner.do">배너 이미지 관리</a>
		    <a href="/admin/inquiry.do">문의/리스트</a>
		    <a href="/admin/refund-return.do">교환/환불</a>
		    <a href="/admin/product.do">상품 리스트</a>
		    <a href="/admin/orders.do">주문 내역</a>
		    <a href="/admin/board-report.do">게시판 신고 리스트</a>
		    <a href="/admin/user-list.do">회원 관리 화면</a>
		</div>

		<!-- 본문 -->
		<div class="content">
            <div>
		        <h2>상품 문의내역 리스트</h2>
            </div>
		    <div>
                <table>
                    <tr>
                        <th>문의번호</th>
                        <th>ID</th>
                        <th>이름</th>
                        <th>문의제목</th>
                        <th>등록일</th>
                        <th>상태</th>
                    </tr>
                    <tr v-for="item in list">
                        <td>{{item.inquiryNo}}</td>
                        <td>{{item.userId}}</td>
                        <td>{{item.name}}</td>
                        <td>
                            <a href="javascript:;" @click="fnInquiryView(item.inquiryNo)">
                                {{item.title}}
                            </a>
                        </td>
                        <td>{{item.cDate}}</td>
                        <td>{{item.status}}</td>
                    </tr>
                </table>
            </div>
		</div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                sessionId : "",
                list : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnInquiryList : function() {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/admin/inquiry.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            },
            fnInquiryView: function(inquiryNo) {
                pageChange("/admin/inquiry/view.do", {inquiryNo : inquiryNo});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInquiryList();
        }
    });

    app.mount('#app');
</script>