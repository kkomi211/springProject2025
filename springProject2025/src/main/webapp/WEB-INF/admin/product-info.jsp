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
    <link rel="stylesheet" href="/css/jes.css">

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
		   <a href="/admin/product.do"  class="active">상품 리스트</a>
		   <a href="/admin/orders.do">주문 내역</a>
		   <a href="/admin/board-report.do">게시판 신고 리스트</a>
		   <a href="/admin/user-list.do">회원 관리 화면</a>
		 </div>

		<!-- 본문 -->
		<div class="content">
		    <h1>상품 수정</h1>
		</div>

        <div class="table text-left">
            <table>
                <tr>
                    <th>제품이름</th>
                    <td><input v-model="info.productName"></td>
                </tr>
                <tr>
                    <th>브랜드</th>
                    <td><input v-model="info.brand"></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><input v-model="info.price"></td>
                </tr>
                <tr>
                    <th>사이즈</th>
                    <td>
                        {{info.productSize}}
                    </td>
                </tr>
                <tr>
                    <th>재고</th>
                    <td>
                        <input v-model="info.quantity" class="smallInput">
                    </td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td><input v-model="info.gender"></td>
                </tr>
                <tr>
                    <th>제품분류</th>
                    <td><input v-model="info.typeNo"></td>
                </tr>
                <tr>
                    <th>상세설명</th>
                    <td><input v-model="info.productDetail"></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td>
                        <input type="file">
                        <a v-if="img != undefined">
                            <img :src="img.imgPath">
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="button">
            <button class="margin30 height40 redbutton rightbutton" @click="fnDeleteProduct">삭제하기</button>
            <button class="margin30 height40 bluebutton centerbutton" @click="fnEditProduct">수정하기</button>
            <button class="margin30 height40 bluebutton leftbutton" @click="fnBack">돌아가기</button>
        </div>
        <div class="bottom200"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                sessionId : "",
                productNo : "${productNo}",
                info : {},
                img : {}

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnInfo(){
                let self = this;
                let param = {
                    productNo : self.productNo
                };
                $.ajax({
                    url: "/product/info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        self.img = data.img;
                        
                    }
                });
            },
            fnEditProduct(){
                let self = this;
                $.ajax({
                    url: "/product/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: self.info,
                    success: function (data) {
                        alert("수정되었습니다!");                        
                        self.fnBack();
                    }
                });
            },
            fnDeleteProduct(){
                let self = this;
                let param = {
                    productNo : self.productNo
                }
                $.ajax({
                    url: "/product/delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.fnBack();
                    }
                });
            },
            fnBack(){
                location.href="/admin/product.do";
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>