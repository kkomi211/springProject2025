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
        <link rel="stylesheet" href="/css/jes.css">
        <script src="/js/page-change.js"></script>

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
                <div>
                    <h1>상품 리스트</h1>
                </div>
                <div class="search-box">
                    <input class="search margin30" placeholder="검색" v-model="keyword">
                    <select class="margin30 height40" v-model="keytype">
                        <option value="no">제품번호</option>
                        <option value="name">제품이름</option>
                    </select>
                    <button class="margin30 height40 bluebutton" @click="fnList">검색</button>
                </div>

                <div class="table">
                    <table>
                        <tr>
                            <th>제품번호</th>
                            <th>제품이름</th>
                            <th>제품가격</th>
                            <th>
                                제품재고
                                <div class="stock-btns">
                                    <button v-if="orderBy == 'down'" @click="fnOrderBy('up')">△</button>
                                    <button v-if="orderBy == 'up'" @click="fnOrderBy('down')">▽</button>
                                </div>
                            </th>
                            <th>사이즈</th>
                            <th>등록/수정일자</th>
                        </tr>
                        <tr v-for="item in list">
                            <td>{{item.productNo}}</td>
                            <td><a href="javascript:;" @click="fnInfoProduct(item.productNo)">{{item.productName}}</a>
                            </td>
                            <td>{{item.price}}</td>
                            <td>{{item.quantity}}</td>
                            <td>{{item.productSize}}</td>
                            <td>{{item.udate}}</td>
                        </tr>
                    </table>
                </div>
                <div class="page">
                    <a v-for="num in totalPage" :key="num" class="margin30" :class="{ red: num === page }"
                        @click="fnPage(num)">{{num}}</a>
                </div>
                <div class="button">
                    <button class="margin30 height40 bluebutton rightbutton" @click="fnAddProduct">등록하기</button>
                </div>
                <div class="bottom200"></div>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "",
                    keyword: "",
                    keytype: "no",
                    list: [],
                    pageSize: 15,
                    page: "1",
                    totalPage: "",
                    orderBy : "down"
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnLogout: function () {
                    pageChange("/home.do", { sessionId: "" });
                },
                fnList() {
                    let self = this;
                    let param = {
                        keyword: self.keyword,
                        keytype: self.keytype,
                        page: (self.page - 1) * 15,
                        pageSize: self.pageSize,
                        orderBy : self.orderBy
                    };
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.totalPage = Math.ceil(data.total / self.pageSize);

                        }
                    });
                },
                fnPage(num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
                },
                fnAddProduct() {
                    location.href = "/admin/product-add.do";
                },
                fnInfoProduct(productNo) {
                    pageChange("/admin/product-info.do", { productNo: productNo });
                },
                fnOrderBy(status){
                    let self = this;
                    self.orderBy = status;
                    self.fnList();
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnPage(1);
            }
        });

        app.mount('#app');
    </script>