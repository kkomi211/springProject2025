<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 등록 - RUNNERS HOUSE</title>
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
                <h2>상품 등록</h2>

                <!-- 로딩 스피너 -->
                <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                    <div class="loading-spinner"></div>
                    <div class="loading-text">처리 중...</div>
                </div>

                <div class="text-left" v-if="!loading">
                    <table class="newtable addtable">
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
                            <td><input type="file" id="file1" name="file1" accept=".jpg, .png, .glb"></td>
                        </tr>
                    </table>
                </div>
                <div class="button">
                    <button class="margin30 height40 redbutton rightbutton" @click="fnAddSystem">등록하기</button>
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
                    productName: "",
                    brand: "",
                    price: "",
                    productSize: [""],
                    quantity: [""],
                    gender: "",
                    typeNo: "",
                    productDetail: "",
                    sizeNum: 1,
                    sessionId: "${sessionId}",
                    loading: false // 로딩 상태
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
                fnAddProduct(i, fileObject) {
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
                    console.log(param);


                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data.productNo);
                            var form = new FormData();
                            form.append("file1", fileObject);
                            form.append("productNo", data.productNo); // 임시 pk
                            self.upload(form);
                            //setTimeout(function () {
                            //    alert("form 내용확인 " + JSON.stringify(form));
                            //    self.upload(form);
                            //}, 100);


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
                            console.log("사진 == >");

                            console.log(data);

                        }
                    });
                },
                fnSizeNum(num) {
                    let self = this;
                    if (self.sizeNum + num < 1 || self.sizeNum + num > 7) {
                        return;
                    }
                    self.sizeNum = self.sizeNum + num;
                },
                fnAddSystem() {
                    let self = this;

                    // 이미지 파일이 선택되었는지 확인
                    if (!self.fnimgexist()) {
                        alert("이미지 파일을 선택해 주세요.");
                        return;
                    }

                    // ★ 1. 로딩 시작 전에 파일 객체를 미리 변수에 저장해둡니다.
                    let fileObject = $("#file1")[0].files[0];

                    self.loading = true; // 로딩 시작 (이제 태그가 사라져도 상관없음)

                    for (let i = 0; i < self.sizeNum; i++) {
                        // ★ 2. 저장해둔 fileObject를 함수에 전달합니다.
                        self.fnAddProduct(i + 1, fileObject);
                    }

                    setTimeout(function () {
                        alert("작성이 완료되었습니다!");
                        self.loading = false; // 로딩 종료
                        // self.fnBack();
                    }, 850);
                },
                //이미지정보 존재하나 확인하는 함수 추가 251107
                fnimgexist() {
                    // jQuery를 사용하여 'file1' ID를 가진 input 요소에서 파일 목록을 가져옵니다.
                    let fileInput = $("#file1")[0];
                    if (fileInput && fileInput.files && fileInput.files.length > 0) {
                        let fileName = fileInput.files[0].name;
                        let ext = fileName.split('.').pop().toLowerCase();
                        // 허용할 확장자 목록에 glb 추가
                        return ['jpg', 'jpeg', 'png', 'glb'].includes(ext);
                    }
                    return false;
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>