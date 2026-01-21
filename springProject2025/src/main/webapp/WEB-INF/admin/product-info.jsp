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
        <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
        <style>
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                /* 배경 조금 더 어둡게 */
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
                min-width: 350px;
                border-top: 8px solid #8e44ad;
                /* 상단 보라색 포인트 */
            }

            .modal-body {
                font-size: 19px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 30px;
                line-height: 1.5;
                word-break: keep-all;
            }

            /* 보라색 그라데이션 버튼 */
            /* 수정된 보라색 그라데이션 버튼 (페이징 active 스타일 적용) */
            .btn-purple-grad {
                /* 보내주신 그라데이션 색상 적용 */
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 35px;
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                /* 폰트 두께 상향 */
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                /* 그림자 색상 동기화 */
                outline: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
            }

            /* 마우스 올렸을 때 효과 (페이징 hover 스타일 참고) */
            .btn-purple-grad:hover {
                filter: brightness(1.1);
                /* 살짝 밝게 */
                transform: translateY(-2px);
                /* 페이징 active 처럼 살짝 위로 */
                box-shadow: 0 6px 15px rgba(102, 126, 234, 0.5);
            }

            /* 돌아가기 버튼용 (보조 버튼 스타일) */
            .btn-purple-outline {
                background: white;
                color: #667eea;
                border: 2px solid #667eea;
                padding: 10px 33px;
                /* 보더 두께만큼 패딩 조정 */
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-purple-outline:hover {
                background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
                transform: translateY(-1px);
            }

            .button {
                display: flex;
                justify-content: space-around;
                /* 버튼 사이 간격을 일정하게 배분 */
                align-items: center;
                max-width: 800px;
                /* 중앙 정렬을 위해 적절한 너비 설정 */
                margin: 40px auto;
                /* 페이지 중앙 정렬 및 위아래 여백 */
                gap: 10px;
                /* 최소 간격 보장 */
            }

            /* 개별 버튼 마진 제거 (Flex가 간격을 조절하므로 기존 마진은 방해가 됨) */
            .button button {
                margin: 0 !important;
                flex: 1;
                /* 모든 버튼의 크기를 동일하게 맞춤 (선택사항) */
                max-width: 200px;
                /* 버튼이 너무 커지는 것 방지 */
            }

            /* 공통 보라색 그라데이션 버튼 (재고변경 등) */
            .btn-purple-sm {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);
                margin-left: 10px;
            }

            .btn-purple-sm:hover {
                filter: brightness(1.1);
                transform: translateY(-1px);
                box-shadow: 0 6px 12px rgba(102, 126, 234, 0.4);
            }

            /* 이미지 선택(파일 업로드) 버튼 커스텀 */
            .file-upload-wrapper {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* 실제 input 파일은 숨김 */
            #file1 {
                display: none;
            }

            /* 커스텀된 파일 선택 버튼 (Label) */
            .custom-file-upload {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 700;
                display: inline-block;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);
            }

            .custom-file-upload:hover {
                filter: brightness(1.1);
                transform: translateY(-1px);
            }

            /* 선택된 파일명을 보여주는 텍스트 */
            .file-name-display {
                font-size: 14px;
                color: #666;
                font-style: italic;
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
                                <a v-if="!quantityFlg" style="display: flex; align-items: center;">
                                    <input v-model="info.quantity" class="smallInput" disabled>
                                    <button class="btn-purple-sm" @click="quantityFlg = true">재고 변경</button>
                                </a>
                                <a v-else style="display: flex; align-items: center;">
                                    <input v-model="info.quantity" class="smallInput">
                                    <button class="btn-purple-sm" @click="fnQuantity">변경 하기</button>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td><select v-model="info.gender" id="gender-menu">
                                    <option value="A">남녀 공용 (A)</option>
                                    <option value="M">남성용 (M)</option>
                                    <option value="F">여성용 (F)</option>
                                </select></td>
                        </tr>
                        <tr>
                            <th>제품분류</th>
                            <td><select v-model="info.typeNo" id="type-menu">
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
                                </select></td>
                        </tr>
                        <tr>
                            <th>상세설명</th>
                            <td><input v-model="info.productDetail"></td>
                        </tr>
                        <tr>
                            <th>이미지</th>
                            <td>
                                <div class="file-upload-wrapper">
                                    <label for="file1" class="custom-file-upload">
                                        📸 이미지 선택하기
                                    </label>
                                    <input type="file" id="file1" name="file1" accept=".jpg, .png, .glb"
                                        @change="fnFileChange">
                                    <span class="file-name-display" id="fileName">파일을 선택해주세요.</span>
                                </div>

                                <div v-if="img != undefined" style="margin-top: 15px;">
                                    <model-viewer v-if="img.imgEtc === '.glb'" :src="img.imgPath" auto-rotate
                                        camera-controls
                                        style="width: 300px; height: 300px; background-color: #f8f9fa; border-radius: 15px; border: 1px solid #ddd;">
                                    </model-viewer>
                                    <img v-else :src="img.imgPath"
                                        style="max-width: 300px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="button">
                    <button class="btn-purple-grad" style="filter: hue-rotate(300deg);"
                        @click="fnDeleteProduct">삭제하기</button>

                    <button class="btn-purple-grad" @click="fnEditProduct">수정하기</button>

                    <button class="btn-purple-outline" @click="fnBack">돌아가기</button>
                </div>
                <div class="bottom200"></div>
                <div class="modal-overlay" v-if="modal.show" @click.self="fnCloseModal">
                    <div class="modal-content">
                        <div class="modal-body" v-html="modal.message"></div>
                        <div class="modal-actions">
                            <button class="btn-purple-grad" @click="fnConfirmModal">확인</button>

                            <button v-if="modal.isConfirm" class="btn-purple-outline" @click="fnCloseModal">취소</button>
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
                    sessionId: "${sessionId}",
                    productNo: "${productNo}",
                    info: {},
                    img: {},
                    salePrice: 0,
                    quantityFlg: false,
                    loading: true, // 로딩 상태 (초기값 true)
                    modal: {
                        show: false,
                        message: "",
                        callback: null
                    }
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
                fnFileChange(event) {
                    const fileName = event.target.files[0] ? event.target.files[0].name : "파일을 선택해주세요.";
                    document.getElementById("fileName").innerText = fileName;
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
                        complete: function () {
                            self.loading = false; // 로딩 종료
                        }
                    });
                },
                fnEditProduct() {
                    let self = this;
                    // 1. 숫자 체크 정규식
                    const numRegex = /^[0-9]+$/;

                    // 2. 필수 입력값 및 숫자 검증 (가격, 성별, 분류 등)
                    if (!self.info.productName || !self.info.brand || !self.info.price || !self.info.gender || !self.info.typeNo) {
                        self.fnAlert("모든 정보를 입력해 주세요.");
                        return;
                    }

                    if (!numRegex.test(String(self.info.price))) {
                        self.fnAlert("가격은 숫자만 입력 가능합니다.");
                        return;
                    }

                    // 할인 가격이 있을 경우 숫자 체크
                    if (self.info.salePrice && !numRegex.test(String(self.info.salePrice))) {
                        self.fnAlert("할인 가격은 숫자만 입력 가능합니다.");
                        return;
                    }

                    // 3. 성별 코드 자동 설정
                    if (self.info.salePrice != null && self.info.salePrice != '0' && self.info.salePrice != "") {
                        self.info.saleYN = "Y";
                    } else {
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
                            self.fnAlert("상품 정보가 수정되었습니다!", () => {
                                var form = new FormData();
                                form.append("file1", $("#file1")[0].files[0]);
                                form.append("productNo", self.productNo);
                                self.upload(form);
                                self.fnBack();
                            });
                        },
                        error: function () {
                            self.fnAlert("수정 중 오류가 발생했습니다.");
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
                            self.fnAlert("상품이 삭제되었습니다.", () => {
                                self.fnBack();
                            });
                        }
                    });
                },
                fnBack() {
                    location.href = "/admin/product.do";
                },
                fnQuantity() {
                    let self = this;
                    const numRegex = /^[0-9]+$/;

                    // 1. 재고 빈칸 및 숫자 체크
                    if (self.info.quantity === "" || self.info.quantity === null || self.info.quantity === undefined) {
                        self.fnAlert("재고 수량을 입력해 주세요.");
                        return;
                    }

                    if (!numRegex.test(String(self.info.quantity))) {
                        self.fnAlert("재고는 숫자만 입력 가능합니다.");
                        return;
                    }
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
                            self.fnAlert("재고 수량이 변경되었습니다.", () => {
                                location.reload(); // 현재 페이지 새로고침
                            });
                        }
                    });
                },
                fnAlert(msg, callback = null) {
                    this.modal.message = msg;
                    this.modal.callback = callback;
                    this.modal.show = true;
                },
                fnCloseModal() {
                    this.modal.show = false;
                },
                fnConfirmModal() {
                    if (this.modal.callback) {
                        this.modal.callback();
                    }
                    this.fnCloseModal();
                },
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnInfo();
            }
        });
        app.config.compilerOptions.isCustomElement = tag => tag === 'model-viewer';
        app.mount('#app');
    </script>