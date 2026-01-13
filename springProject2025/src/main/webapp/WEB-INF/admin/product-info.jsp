<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 수정 - RUNNERS HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/style.css">
        <script src="/js/page-change.js"></script>
        <link rel="stylesheet" href="/css/jes.css">
        <link rel="stylesheet" href="/css/admin-inquiry.css">

    </head>

    <body class="adminbody">
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <!-- 상단 검은색 바 -->
            <div class="topbar">
                <div><strong>관리자 메인화면</strong></div>
                <div>관리자 ${sessionId} 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none"
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
                <h2>상품 수정</h2>

                <!-- 로딩 스피너 -->
                <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                    <div class="loading-spinner"></div>
                    <div class="loading-text">데이터를 불러오는 중...</div>
                </div>

                <div class="table text-left" v-if="!loading">
                    <table class="newtable">
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
                            <td>
                                <input style="width: 30%; margin-right: 50px;" v-model="info.price">
                                할인 : <input style="width: 30%;" v-model="info.salePrice">
                            </td>
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
                                <a v-if="!quantityFlg">
                                    <input v-model="info.quantity" class="smallInput" disabled>
                                    <button @click="quantityFlg = true">재고 변경</button>
                                </a>
                                <a v-else>
                                    <input v-model="info.quantity" class="smallInput">
                                    <button @click="fnQuantity">변경 하기</button>
                                </a>
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
                                <input type="file" id="file1" name="file1" accept=".jpg, .png">
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
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    productNo: "${productNo}",
                    info: {},
                    img: {},
                    salePrice: 0,
                    quantityFlg: false,
                    loading: true // 로딩 상태 (초기값 true)
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnLogout: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/member/logout.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                location.href = "/home.do";
                            }
                        }
                    });

                },
                fnInfo() {
                    let self = this;
                    let param = {
                        productNo: self.productNo
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
                        },
                        complete: function() {
                            self.loading = false; // 로딩 종료
                        }
                    });
                },
                fnEditProduct() {
                    let self = this;
                    if (self.info.salePrice != null && self.info.salePrice != '0') {
                        self.info.saleYN = "Y";
                    }
                    else {
                        self.info.saleYN = "N";
                    }
                    // alert("버튼 확인");
                    // alert("화면에서 데이터를 잘 주낭?" + JSON.stringify(self.info));
                    // alert("화면에서 이미지데이터를 잘 주낭?" + JSON.stringify(self.img));
                    $.ajax({
                        url: "/product/edit.dox",
                        dataType: "json",
                        type: "POST",
                        data: self.info, 
                        success: function (data) {
                            alert("수정되었습니다!");
                            var form = new FormData();
                            // alert("form에 뭐가 들어가나" + JSON.stringify(form));
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("productNo", self.productNo); // 임시 pk
                           
                            self.upload(form);
                            self.fnBack();
                        },
                        error: function() {
                            alert("수정 중 오류가 발생했습니다.");
                        }
                    });
                },
                upload: function (form) {
                    console.log(form);
                    // alert("이미지 업로드 진입");
                    var self = this;
                    $.ajax({
                        url: "/product/update/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (data) {
                            console.log("사진 == >");
                            
                            console.log(data);

                        }
                    });
                },
                fnDeleteProduct() {
                    let self = this;
                    let param = {
                        productNo: self.productNo
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
                fnBack() {
                    location.href = "/admin/product.do";
                },
                fnQuantity() {
                    let self = this;
                    let param = {
                        productNo: self.productNo,
                        quantity: self.info.quantity
                    }
                    $.ajax({
                        url: "/product/quantity/update.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert("수정되었습니다!");
                            self.fnBack();
                        }
                    });
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