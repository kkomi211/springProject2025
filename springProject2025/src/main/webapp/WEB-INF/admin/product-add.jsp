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
        <style>
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            /* 모달 박스 */
            .modal-content {
                background: white;
                padding: 30px;
                border-radius: 15px;
                text-align: center;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            }

            .modal-body {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .modal-actions {
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            /* 통합 알림 모달 스타일 */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                backdrop-filter: blur(3px);
                /* 배경 블러 효과 */
            }

            .modal-content {
                background: white;
                padding: 40px 60px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
                min-width: 380px;
                border-top: 8px solid #667eea;
                /* 상단 포인트 컬러 */
            }

            .modal-body {
                font-size: 19px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 30px;
                line-height: 1.5;
                word-break: keep-all;
            }

            /* 메인 보라색 그라데이션 버튼 (페이징 버튼 스타일) */
            .btn-purple-grad {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                outline: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin: 5px;
            }

            .btn-purple-grad:hover {
                filter: brightness(1.1);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(102, 126, 234, 0.5);
            }

            /* 추가 등록용 붉은색 계열 그라데이션 (선택사항) */
            .btn-red-grad {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5253 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(238, 82, 83, 0.3);
            }

            .btn-red-grad:hover {
                filter: brightness(1.1);
                transform: translateY(-2px);
            }

            /* 돌아가기 버튼용 아웃라인 스타일 */
            .btn-purple-outline {
                background: white;
                color: #667eea;
                border: 2px solid #667eea;
                padding: 10px 28px;
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                margin: 5px;
            }

            .btn-purple-outline:hover {
                background: #f7fafc;
                transform: translateY(-1px);
            }

            /* 페이지 하단 버튼 컨테이너 */
            .button {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 40px;
            }
        </style>
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
                            <td><input v-model="gender" placeholder="남녀 공용 : A, 남성 : M, 여성 : F"></td>
                        </tr>
                        <tr>
                            <th>제품분류</th>
                            <td>
                                <select v-model="typeNo" id="type-menu">
                                    <option value="10">러닝화</option>
                                    <option value="20">보호대</option>
                                    <option value="30">모자</option>
                                    <option value="40">건강보조식품</option>
                                    <option value="50">러닝복</option>
                                    <option value="101">일반러닝화</option>
                                    <option value="102">트레일러닝화</option>
                                    <option value="103">카본화</option>
                                    <option value="201">무릎보호대</option>
                                    <option value="202">허리보호대</option>
                                    <option value="301">일반모자</option>
                                    <option value="401">에너지젤</option>
                                    <option value="501">상의</option>
                                    <option value="502">하의</option>
                                </select>
                            </td>
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
                    <button class="btn-purple-grad" @click="fnAddSystem">등록하기</button>
                    <button class="btn-purple-outline" @click="fnBack">돌아가기</button>
                </div>
                <div class="bottom200"></div>
                <div class="modal-overlay" v-if="showSuccessModal" @click.self="fnCloseModal">
                    <div class="modal-content">
                        <div class="modal-body" v-html="modalMessage"></div>
                        <div class="modal-actions">
                            <template v-if="isSuccess">
                                <button class="btn-purple-grad" @click="fnBack">목록으로 돌아가기</button>
                                <button class="btn-red-grad" @click="fnReset">추가 등록하기</button>
                            </template>

                            <template v-else>
                                <button class="btn-purple-grad" @click="fnCloseModal">확인</button>
                            </template>
                        </div>
                    </div>
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
                    loading: false, // 로딩 상태
                    showSuccessModal: false,
                    modalMessage: "", // 모달에 띄울 메시지
                    isSuccess: false  // 성공 여부 (버튼 구성을 위해)
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
                            self.fnBack();


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
                        self.fnOpenModal("이미지 파일을 선택해 주세요.", false);
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
                        self.fnOpenModal("상품 등록이 완료되었습니다!", true);
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
                },
                fnOpenModal(msg, success = false) {
                    this.modalMessage = msg;
                    this.isSuccess = success;
                    this.showSuccessModal = true;
                },
                fnCloseModal() {
                    this.showSuccessModal = false;
                },
                // 추가 등록을 위해 상태 초기화
                fnReset() {
                    this.showSuccessModal = false;
                    // 필요한 경우 입력값 초기화 로직 추가 가능
                },
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>