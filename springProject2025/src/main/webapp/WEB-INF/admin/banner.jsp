<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>배너 이미지 관리</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/banner-style.css">
        <script src="/js/page-change.js"></script>
        <style>
            
        </style>
    </head>

    <body class="adminbody">
        <div id="app">
            <div class="topbar">
                <div><strong>관리자 메인화면</strong></div>
                <div>관리자 test123 님 안녕하세요 &nbsp;
                    <a href="javascript:;" class="text-white text-decoration-none" @click="fnLogout">로그오프</a>
                </div>
            </div>

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

            <!-- 메인 슬라이드 광고-->
            <h2 id="main-slide-banner-section">메인 슬라이드 배너 관리</h2>
            <div>
                <button @click="openMainAddModal" style="background-color:rgb(60,173,255);">
                    메인 배너 추가
                </button>
            </div>
            <div class="content-wrapper">
                <div class="left-ad-area">
                    <div class="ad-box" onclick="scrollToSection('main-slide-banner-section')">메인 슬라이드 배너</div>
                    <div class="ad-box" onclick="scrollToSection('product-banner-section')">제품 배너</div>
                    <div class="ad-box" onclick="scrollToSection('contest-banner-section')">서브 슬라이드 배너</div>
                </div>

                <table>
                    <tr>
                        <th>배너 ID</th>
                        <th>배너 제목</th>
                        <th>이미지 경로</th>
                        <th>URL</th>
                        <th>등록 날짜</th>
                        <th>수정 하기</th>
                    </tr>

                    <template v-for="(item, index) in list" :key="item.bannerId">
                        <tr>
                            <template v-if="!item.isEditing">
                                <td>{{item.bannerId}}</td>
                                <td @click="toggleImage(index)"
                                    style="cursor:pointer; color:rgb(60,173,255); text-decoration:underline;">
                                    {{item.title}}
                                </td>
                                <td>{{item.imageDir}}</td>
                                <td>{{item.linkUrl}}</td>
                                <td>{{item.cDate}}</td>
                                <td>
                                    <button @click="item.isEditing = true"
                                        style="background-color: rgb(60,173,255);">수정하기</button>
                                </td>
                            </template>

                            <template v-else>
                                <td>{{item.bannerId}}</td>
                                <td><input style="height: 78px;" v-model="item.title"></td>
                                <td><input style="height: 78px;" v-model="item.imageDir"></td>
                                <td><input style="height: 78px;" v-model="item.linkUrl"></td>
                                <td>{{item.cDate}}</td>
                                <td>
                                    <button @click="saveMainBanner(index)"
                                        style="background-color: rgb(60,173,255);">저장하기</button>
                                    <button @click="item.isEditing = false"
                                        style="background-color: #7e7e7e;">취소하기</button>
                                    <button @click="openMainDeleteModal(item)"
                                        style="background-color: #F24822;">삭제</button>
                                </td>
                            </template>
                        </tr>

                        <tr v-if="item.showImage">
                            <td colspan="6" style="text-align:center; background-color:#f9f9f9;">
                                <img :src="item.imageDir" alt="배너 이미지" style="max-width:600px; border-radius:6px;">
                            </td>
                        </tr>
                    </template>

                </table>
            </div>

            <div v-if="showMainDeleteModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>삭제 확인</h3>
                    <p>"{{ mainDeleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmMainDelete()" style="background-color:#F24822;">삭제</button>
                        <button @click="closeMainDeleteModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <div v-if="showMainAddModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>배너 추가</h3>
                    <div class="modal-input">
                        <input v-model="newMainBanner.title" placeholder="배너 제목 입력">
                        <input v-model="newMainBanner.imageDir" placeholder="이미지 경로 입력">
                        <input v-model="newMainBanner.linkUrl" placeholder="링크 URL 입력">
                    </div>
                    <div class="modal-buttons">
                        <button @click="confirmMainAdd" style="background-color:rgb(60,173,255);">등록</button>
                        <button @click="closeMainAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>


            <div class="preview-box" v-if="selectedImage">
                <h3>이미지 보기</h3>
                <img :src="selectedImage" alt="배너 이미지">
            </div>


            <!-- 제품 광고-->
            <h2 id="product-banner-section">제품 배너 관리</h2>

            <div class="product-banner-controls">
                <button @click="openProductAddModal" style="background-color:rgb(60,173,255);">
                    제품 배너 추가
                </button>
            </div>

            <table>
                <tr>
                    <th>이미지 번호</th>
                    <th>배너 제목</th>
                    <th>상품 번호</th>
                    <th>등록 날짜</th>
                    <th>삭제</th>
                </tr>

                <template v-for="(item, index) in list1" :key="item.pBannerImgNo">
                    <tr>
                        <td>{{item.pBannerImgNo}}</td>
                        <td @click="toggleProductImage(index)"
                            style="cursor:pointer; color:rgb(60,173,255); text-decoration:underline;">
                            {{item.title}}
                        </td>
                        <td>{{item.productNo}}</td>
                        <td>{{item.cDate}}</td>
                        <td>
                            <button @click="openProductDeleteModal(item)" style="background-color: #F24822;">삭제</button>
                        </td>
                    </tr>

                    <tr v-if="item.showImage">
                        <td colspan="5" style="text-align:center; background-color:#f9f9f9;">
                            <img :src="item.imgPath" alt="제품 배너 이미지" style="max-width:600px; border-radius:6px;">
                        </td>
                    </tr>
                </template>

            </table>

            <div v-if="showProductDeleteModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>삭제 확인</h3>
                    <p>"{{ productDeleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmProductDelete()" style="background-color:#F24822;">삭제</button>
                        <button @click="closeProductDeleteModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <div v-if="showProductAddModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>제품 배너 추가</h3>
                    <div class="modal-input">
                        <input v-model="newProductBanner.title" placeholder="배너 제목 입력">
                        <input v-model="newProductBanner.productImgNo" placeholder="이미지 경로 또는 상품 이미지 번호 입력">
                        <input v-model="newProductBanner.productNo" placeholder="상품 번호 입력">
                    </div>
                    <div class="modal-buttons">
                        <button @click="confirmProductAdd" style="background-color:rgb(60,173,255);">등록</button>
                        <button @click="closeProductAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>


            <!-- 대회 광고-->
            <h2 id="contest-banner-section">대회 배너 관리</h2>

            <div class="product-banner-controls">
                <button @click="openRallyAddModal" style="background-color:rgb(60,173,255);">
                    광고 배너 추가
                </button>
            </div>

            <table>
                <tr>
                    <th>대회 번호</th>
                    <th>대회 이름</th>
                    <th>대회 일시</th>
                    <th>접수 기간</th>
                    <th>가격</th>
                    <th>문의 번호</th>
                    <th>참가부문</th>
                    <th>주최</th>
                    <th>등록날 짜</th>
                    <th>삭제</th>
                </tr>

                <template v-for="(item, index) in list2" :key="item.rallyNo">
                    <tr>
                        <td>{{item.rallyNo}}</td>
                        <td @click="toggleRallyImage(index)"
                            style="cursor:pointer; color:rgb(60,173,255); text-decoration:underline;">
                            {{item.rallyName}}
                        </td>
                        <td>{{item.rallyDate}}</td>
                        <td>{{item.applicationPeriod}}</td>
                        <td>{{item.price}}</td>
                        <td>{{item.phone}}</td>
                        <td>{{item.type}}</td>
                        <td>{{item.host}}</td>
                        <td>{{item.cDate}}</td>
                        <td>
                            <button @click="openRallyDeleteModal(item)" style="background-color: #F24822;">삭제</button>
                        </td>
                    </tr>

                    <tr v-if="item.showImage">
                        <td colspan="10" style="text-align:center; background-color:#f9f9f9;">
                            <img :src="item.imgPath" alt="대회 배너 이미지" style="max-width:600px; border-radius:6px;">
                        </td>
                    </tr>
                </template>

            </table>

            <!-- 대회 배너 삭제 모달 -->
            <div v-if="showRallyDeleteModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>삭제 확인</h3>
                    <p>"{{ rallyDeleteItem.rallyName }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmRallyDelete()" style="background-color:#F24822;">삭제</button>
                        <button @click="closeRallyDeleteModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <!-- 대회 배너 추가 모달 -->
            <div v-if="showRallyAddModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>대회 배너 추가</h3>
                    <div class="modal-input">
                        <input v-model="newRallyBanner.rallyName" placeholder="대회 이름 입력">
                        <input v-model="newRallyBanner.rallyDate" placeholder="대회 날짜 입력">
                        <input v-model="newRallyBanner.applicationPeriod" placeholder="접수 기간 입력">
                        <input v-model="newRallyBanner.price" placeholder="가격 입력">
                        <input v-model="newRallyBanner.phone" placeholder="문의 번호 입력">
                        <input v-model="newRallyBanner.type" placeholder="참가부문 입력">
                        <input v-model="newRallyBanner.host" placeholder="주최 입력">
                        <input type="file" id="file1" name="file1" accept=".jpg, .png">


                    </div>
                    <div class="modal-buttons">
                        <button @click="confirmRallyAdd" style="background-color:rgb(60,173,255);">등록</button>
                        <button @click="closeRallyAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>

        // [가장 중요한 수정] 전역 함수로 분리하여 HTML에서 직접 호출 가능하게 함
        function scrollToSection(sectionId) {
            const target = $('#' + sectionId);
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top - 50
                }, 800);
            }
        }

        const app = Vue.createApp({
            data() {
                return {
                    list: [], // 메인 슬라이드 배너
                    list1: [], // 제품 배너
                    list2: [], // 대회 배너
                    editFlg: false,
                    selectedImage: "", // 클릭된 이미지 저장 변수

                    // 메인 슬라이드 배너 (list)
                    showMainDeleteModal: false,
                    showMainAddModal: false,
                    mainDeleteItem: null,
                    newMainBanner: {
                        title: "",
                        imageDir: "",
                        linkUrl: ""
                    },

                    // 제품 배너 (list1)
                    showProductDeleteModal: false,
                    showProductAddModal: false,
                    productDeleteItem: null,
                    newProductBanner: {
                        title: "",
                        productImgNo: "", // 이미지 경로 대신 번호를 쓰는 경우를 고려
                        productNo: "",

                    },

                    // 대회 배너 (list2)
                    showRallyDeleteModal: false,
                    showRallyAddModal: false,
                    rallyDeleteItem: null,
                    newRallyBanner: {
                        rallyNo: "",
                        rallyName: "",
                        rallyDate: "",
                        applicationPeriod: "",
                        price: "",
                        phone: "",
                        phone: "",
                        host: "",

                    }
                };
            },
            methods: {
                fnLogout: function () {
                    pageChange("home.do", { sessionId: "" });
                },
                fnList: function () {
                    let self = this;
                    $.ajax({
                        url: "/admin/slidebanner.dox",
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            console.log(data);
                            // list (메인 슬라이드 배너) 초기화 및 isEditing, showImage 속성 추가
                            self.list = data.list.map(item => ({
                                ...item,
                                isEditing: false,
                                showImage: false // 이미지 토글을 위한 속성 추가
                            }));
                            // list1 (제품 배너) 초기화 및 isEditing, showImage 속성 추가
                            self.list1 = data.list1.map(item => ({
                                ...item,
                                isEditing: false,
                                showImage: false // 이미지 토글을 위한 속성 추가
                            }));
                            // list2 (대회 배너) 초기화 및 isEditing, showImage 속성 추가
                            self.list2 = data.list2.map(item => ({
                                ...item,
                                isEditing: false,
                                showImage: false // 이미지 토글을 위한 속성 추가

                            }));
                        }
                    });
                },

                // 메인 슬라이드 배너 기능 (list)
                saveMainBanner(index) {
                    let item = this.list[index];
                    $.ajax({
                        url: "/admin/bannerUpdate.dox",
                        type: "POST",
                        dataType: "json",
                        data: {
                            bannerId: item.bannerId,
                            title: item.title,
                            imageDir: item.imageDir,
                            linkUrl: item.linkUrl
                        },
                        success: (res) => {
                            alert("메인 배너 저장 완료!");
                            this.list[index].isEditing = false; // 수정모드 해제
                            this.fnList();
                        },
                        error: () => {
                            alert("메인 배너 저장 오류 발생!");
                        }
                    });
                },
                toggleImage(index) { // 메인 슬라이드 배너 이미지 토글
                    this.list.forEach((item, i) => {
                        if (i !== index) item.showImage = false;
                    });
                    this.list[index].showImage = !this.list[index].showImage;
                },
                openMainDeleteModal(item) {
                    this.mainDeleteItem = item;
                    this.showMainDeleteModal = true;
                },
                closeMainDeleteModal() {
                    this.showMainDeleteModal = false;
                    this.mainDeleteItem = null;
                },
                confirmMainDelete() {
                    if (!this.mainDeleteItem) return;
                    $.ajax({
                        url: "/admin/bannerSlideDelete.dox",
                        type: "POST",
                        dataType: "json",
                        data: { bannerId: this.mainDeleteItem.bannerId },
                        success: (res) => {
                            alert("메인 배너 삭제 완료!");
                            this.closeMainDeleteModal();
                            this.fnList(); // 리스트 갱신
                        },
                        error: () => {
                            alert("메인 배너 삭제 중 오류 발생!");
                        }
                    });
                },
                openMainAddModal() {
                    this.showMainAddModal = true;
                    // 모달 열 때 입력값 초기화
                    this.newMainBanner = { title: "", imageDir: "", linkUrl: "" };
                },
                closeMainAddModal() {
                    this.showMainAddModal = false;
                    this.newMainBanner = { title: "", imageDir: "", linkUrl: "" };
                },
                confirmMainAdd() {
                    let item = this.newMainBanner;
                    if (!item.title || !item.imageDir) {
                        alert("모든 항목을 입력해주세요!");
                        return;
                    }
                    $.ajax({
                        url: "/admin/slideBannerInsert.dox",
                        type: "POST",
                        dataType: "json",
                        data: item,
                        success: (res) => {
                            alert("메인 배너 등록 완료!");
                            this.closeMainAddModal();
                            this.fnList();
                        },
                        error: () => alert("메인 배너 등록 오류 발생!")
                    });
                },

                // 제품 배너 기능 (list1)
                toggleProductImage(index) { // 제품 배너 이미지 토글
                    // list의 이미지 토글은 유지
                    this.list.forEach(item => item.showImage = false);

                    // list1 아이템만 토글
                    this.list1.forEach((item, i) => {
                        if (i !== index) item.showImage = false;
                    });
                    this.list1[index].showImage = !this.list1[index].showImage;
                },
                openProductDeleteModal(item) {
                    this.productDeleteItem = item;
                    this.showProductDeleteModal = true;
                },
                closeProductDeleteModal() {
                    this.showProductDeleteModal = false;
                    this.productDeleteItem = null;
                },
                confirmProductDelete() {
                    if (!this.productDeleteItem) return;
                    // 제품 배너 삭제는 pBannerImgNo를 사용한다고 가정하고 URL을 변경합니다.
                    $.ajax({
                        url: "/admin/productBannerDelete.dox", // 이 URL은 가정입니다. 실제 API URL로 수정하세요.
                        type: "POST",
                        dataType: "json",
                        data: { pBannerImgNo: this.productDeleteItem.pBannerImgNo },
                        success: (res) => {
                            alert("제품 배너 삭제 완료!");
                            this.closeProductDeleteModal();
                            this.fnList(); // 리스트 갱신
                        },
                        error: () => {
                            alert("제품 배너 삭제 중 오류 발생!");
                        }
                    });
                },
                openProductAddModal() {
                    this.showProductAddModal = true;
                    // 모달 열 때 입력값 초기화
                    this.newProductBanner = { title: "", productImgNo: "", productNo: "" };
                },
                closeProductAddModal() {
                    this.showProductAddModal = false;
                    this.newProductBanner = { title: "", productImgNo: "", productNo: "" };
                },
                confirmProductAdd() {
                    let item = this.newProductBanner;
                    if (!item.title || !item.productImgNo || !item.productNo) {
                        alert("모든 항목을 입력해주세요!");
                        return;
                    }
                    // 제품 배너 추가는 새로운 API URL을 사용한다고 가정합니다.
                    $.ajax({
                        url: "/admin/productBannerInsert.dox", // 이 URL은 가정입니다. 실제 API URL로 수정하세요.
                        type: "POST",
                        dataType: "json",
                        data: item,
                        success: (res) => {
                            alert("제품 배너 등록 완료!");
                            this.closeProductAddModal();
                            this.fnList();
                        },
                        error: () => alert("제품 배너 등록 오류 발생!")
                    });
                },

                // 대회 광고 (list2)
                toggleRallyImage(index) {
                    // 대회 배너 이미지 토글
                    this.list2.forEach((item, i) => {
                        if (i !== index) item.showImage = false;
                    });
                    this.list2[index].showImage = !this.list2[index].showImage;
                },
                openRallyDeleteModal(item) {
                    this.rallyDeleteItem = item;
                    this.showRallyDeleteModal = true;
                },
                closeRallyDeleteModal() {
                    this.showRallyDeleteModal = false;
                    this.rallyDeleteItem = null;
                },
                confirmRallyDelete() {
                    if (!this.rallyDeleteItem) return;
                    // 대회 배너 삭제를 위한 API 호출
                    $.ajax({
                        url: "/admin/rallyBannerDelete.dox", // 실제 API URL을 사용해야 합니다.
                        type: "POST",
                        dataType: "json",
                        data: { rallyNo: this.rallyDeleteItem.rallyNo },
                        success: (res) => {
                            alert("대회 배너 삭제 완료!");
                            this.closeRallyDeleteModal();
                            this.fnList(); // 리스트 갱신
                        },
                        error: () => {
                            alert("대회 배너 삭제 중 오류 발생!");
                        }
                    });
                },
                openRallyAddModal() {
                    this.showRallyAddModal = true;
                    // 모달 열 때 입력값 초기화
                    this.newRallyBanner = {
                        rallyName: "",
                        rallyDate: "",
                        applicationPeriod: "",
                        price: "",
                        phone: "",
                        type: "",
                        host: ""
                    };
                },
                closeRallyAddModal() {
                    this.showRallyAddModal = false;
                    this.newRallyBanner = {
                        rallyName: "",
                        rallyDate: "",
                        applicationPeriod: "",
                        price: "",
                        phone: "",
                        type: "",
                        host: ""
                    };
                },
                confirmRallyAdd() {
                    let self = this;
                    let item = this.newRallyBanner;
                    if (!item.rallyName || !item.applicationPeriod || !item.price || !item.phone) {
                        alert("모든 항목을 입력해주세요!");
                        return;
                    }
                    // 대회 배너 추가를 위한 API 호출
                    $.ajax({
                        url: "/admin/rallyBannerInsert.dox", // 실제 API URL을 사용해야 합니다.
                        type: "POST",
                        dataType: "json",
                        data: item,
                        success: (data) => {
                            var form = new FormData();
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("rallyNo", data.rallyNo); // 임시 pk
                            self.upload(form);
                           
                            alert("대회 배너 등록 완료!");
                            this.closeRallyAddModal();
                            this.fnList();
                        },
                        error: () => alert("대회 배너 등록 오류 발생!")
                    });
                },

                // 파일 업로드
                upload: function (form) {
                    console.log(form);

                    var self = this;
                    console.log("파일 업로드 실행");

                    $.ajax({
                        url: "/rally/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {

                        }
                    });
                }


            },
            mounted() {
                this.fnList();
            }
        });
        app.mount('#app');



    </script>

    </body>

    </html>