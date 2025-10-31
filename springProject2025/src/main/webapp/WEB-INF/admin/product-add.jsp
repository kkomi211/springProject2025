<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
                <div>관리자 test123 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none"
                        @click="fnLogout">로그오프</a></div>
            </div>

            <!-- 메뉴 바 (검은색) -->
            <div class="nav-black">
                <a href="/admin.do">MAIN</a>
                <a href="/admin/banner.do">배너 이미지 관리</a>
                <a href="/admin/inquiry.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do" class="active">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
            </div>

            <!-- 본문 -->
            <div class="content">
                <h1>상품 등록</h1>
            </div>

            <div class="table text-left">
                <table>
                    <tr>
                        <th>제품이름</th>
                        <td><input v-model="productName"></td>
                    </tr>
                    <tr>
                        <th>브랜드</th>
                        <td><input v-model="brand"></td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td><input v-model="price"></td>
                    </tr>
                    <tr>
                        <th>사이즈</th>
                        <td>
                            <input v-for="num in sizeNum" v-model="productSize[num]" class="smallInput">
                            <button class="bluebutton height40" @click="fnSizeNum(1)">+</button>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            재고
                        </th>
                        <td>
                            <input v-for="num in sizeNum" v-model="quantity[num]" class="smallInput">
                            <button class="bluebutton height40" @click="fnSizeNum(-1)">-</button>
                        </td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td><input v-model="gender"></td>
                    </tr>
                    <tr>
                        <th>제품분류</th>
                        <td><input v-model="typeNo"></td>
                    </tr>
                    <tr>
                        <th>상세설명</th>
                        <td><input v-model="productDetail"></td>
                    </tr>
                    <tr>
                        <th>이미지</th>
                        <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                    </tr>
                </table>
            </div>
            <div class="button">
                <button class="margin30 height40 redbutton rightbutton" @click="fnAddSystem">등록하기</button>
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
                    sessionId: "admin",
                    productName: "",
                    brand: "",
                    price: "",
                    productSize: [""],
                    quantity: [""],
                    gender: "",
                    typeNo: "",
                    productDetail: "",
                    sizeNum : 1,
                    sessionId : "${sessionId}"
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnLogout: function () {
                    pageChange("home.do", { sessionId: "" });
                },
                fnAddProduct(i) {
                    let self = this;
                    let param = {
                        userId: self.sessionId,
                        productName: self.productName,
                        brand: self.brand,
                        price: self.price,
                        productSize: self.productSize[i],
                        quantity: self.quantity[i],
                        gender: self.gender,
                        typeNo: self.typeNo,
                        productDetail: self.productDetail
                    };
                    console.log(self.productSize[i]);
                    console.log(self.quantity[i]);
                    
                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            
                            console.log(data.productNo);
                            var form = new FormData();
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("productNo", data.productNo); // 임시 pk
                            self.upload(form);
                            

                        }
                    });
                },
                fnBack() {
                    location.href = "/admin/product.do";
                },
                upload: function (form) {
                    console.log(form);
                    
                    var self = this;
                    $.ajax({
                        url: "/product/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (data) {
                            console.log(data);

                        }
                    });
                },
                fnSizeNum(num){
                    let self = this;
                    if(self.sizeNum + num < 1 || self.sizeNum + num > 7){
                        return;
                    }
                    self.sizeNum = self.sizeNum + num;
                },
                fnAddSystem(){
                    let self = this;
                    for(let i = 0; i < self.sizeNum; i++){
                        self.fnAddProduct(i+1);
                    }
                    alert("작성이 완료되었습니다!");
                    self.fnBack();
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>