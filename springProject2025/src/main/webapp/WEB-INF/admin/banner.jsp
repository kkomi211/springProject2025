<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>배너 이미지 관리 - RUNNERS HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/banner-style.css">
        <link rel="stylesheet" href="/css/admin-inquiry.css">
        <script src="/js/page-change.js"></script>
        <script src="/js/admin-notifications.js"></script>
        <style>

        </style>
    </head>

    <body class="adminbody">
        <div id="app">
            <div class="topbar">
                <div><strong>관리자 메인화면</strong></div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <!-- 알림 아이콘 -->
                    <div class="notification-icon-wrapper" @click="toggleNotificationPanel">
                        <span class="notification-bell">🔔</span>
                        <span v-if="notificationCounts.totalCount > 0" class="notification-badge">{{
                            notificationCounts.totalCount }}</span>
                    </div>
                    <div style="line-height: 1.2;">관리자 ${sessionId} 님 안녕하세요 &nbsp;
                        <a href="javascript:;" class="text-white text-decoration-none" @click="fnLogout">로그오프</a>
                    </div>
                </div>
            </div>

            <!-- 알림 패널 -->
            <div v-if="showNotificationPanel" class="notification-panel" @click.stop>
                <div class="notification-header">
                    <h3>실시간 알림</h3>
                    <button @click="toggleNotificationPanel" class="notification-close">×</button>
                </div>
                <div class="notification-content">
                    <div class="notification-item" v-if="notificationCounts.newInquiryCount > 0"
                        @click="markAsReadAndGo('inquiry', '/admin/inquiry.do')">
                        <div class="notification-item-icon">📝</div>
                        <div class="notification-item-text">
                            <strong>새 문의</strong>
                            <span>{{ notificationCounts.newInquiryCount }}건</span>
                        </div>
                    </div>
                    <div class="notification-item" v-if="notificationCounts.newOrderCount > 0"
                        @click="markAsReadAndGo('order', '/admin/orders.do')">
                        <div class="notification-item-icon">📦</div>
                        <div class="notification-item-text">
                            <strong>신규 주문</strong>
                            <span>{{ notificationCounts.newOrderCount }}건</span>
                        </div>
                    </div>
                    <div class="notification-item" v-if="notificationCounts.newBoardReportCount > 0"
                        @click="markAsReadAndGo('report', '/admin/board-report.do')">
                        <div class="notification-item-icon">🚨</div>
                        <div class="notification-item-text">
                            <strong>신고 게시물</strong>
                            <span>{{ notificationCounts.newBoardReportCount }}건</span>
                        </div>
                    </div>
                    <div v-if="notificationCounts.totalCount === 0" class="notification-empty">
                        새로운 알림이 없습니다.
                    </div>
                </div>
            </div>

            <!-- 알림 패널 오버레이 -->
            <div v-if="showNotificationPanel" class="notification-overlay" @click="toggleNotificationPanel"></div>

            <div class="nav-black">
                <a href="/admin.do">MAIN</a>
                <a href="/admin/banner.do" class="active">배너 이미지 관리</a>
                <a href="/admin/inquiry.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
                <a href="/admin/activity-log.do">활동 로그</a>
            </div>

            <div class="banner-layout-container">
                <!-- 왼쪽 영역: 메인 슬라이드 배너 관리 & 제품 배너 관리 -->
                <div class="banner-left-section">
                    <!-- 메인 슬라이드 광고-->
                    <div class="banner-section">
                        <div class="banner-header">
                            <h2 id="main-slide-banner-section">메인 슬라이드 배너 관리</h2>
                            <button @click="openMainAddModal" class="banner-btn-primary">
                                메인 배너 추가
                            </button>
                        </div>
                        <div class="content-wrapper">
                            <table>
                                <tr>
                                    <th>배너 ID</th>
                                    <th>배너 제목</th>
                                    <th>이미지 경로</th>
                                    <th>URL</th>
                                    <th>등록 날짜</th>
                                    <th>수정</th>
                                </tr>

                                <template v-for="(item, index) in list" :key="item.bannerId">
                                    <tr>
                                        <template v-if="!item.isEditing">
                                            <td>{{item.bannerId}}</td>
                                            <td @click="toggleImage(index)"
                                                style="cursor:pointer; color:#007bff; text-decoration:underline;">
                                                <span class="text-clamp">{{item.title}}</span>
                                            </td>
                                            <td><span class="text-clamp">{{item.imageDir}}</span></td>
                                            <td><span class="text-clamp">{{item.linkUrl}}</span></td>
                                            <td>{{item.cDate}}</td>
                                            <td>
                                                <button @click="item.isEditing = true"
                                                    class="banner-btn-primary">수정</button>
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
                                                    class="banner-btn-primary">저장</button>
                                                <button @click="item.isEditing = false"
                                                    class="banner-btn-secondary">취소</button>
                                                <button @click="openMainDeleteModal(item)"
                                                    class="banner-btn-danger">삭제</button>
                                            </td>
                                        </template>
                                    </tr>

                                    <tr v-if="item.showImage">
                                        <td colspan="6" style="text-align:center; background-color:#f9f9f9;">
                                            <img :src="item.imageDir" alt="배너 이미지"
                                                style="max-width:600px; border-radius:6px;">
                                        </td>
                                    </tr>
                                </template>

                            </table>
                        </div>
                    </div>

                    <!-- 제품 광고-->
                    <div class="banner-section">
                        <div class="banner-header">
                            <h2 id="product-banner-section">제품 배너 관리</h2>
                            <button @click="openProductAddModal" class="banner-btn-primary">
                                제품 배너 추가
                            </button>
                        </div>

                        <table>
                            <tr>
                                <th>이미지 번호</th>
                                <th>배너 제목</th>
                                <th>상품 번호</th>
                                <th>등록 날짜</th>
                                <th>수정</th>
                            </tr>

                            <template v-for="(item, index) in list1" :key="item.pBannerImgNo">
                                <tr>
                                    <template v-if="!item.isEditing">
                                        <td>{{item.pBannerImgNo}}</td>
                                        <td @click="toggleProductImage(index)"
                                            style="cursor:pointer; color:#007bff; text-decoration:underline;">
                                            <span class="text-clamp">{{item.title}}</span>
                                        </td>
                                        <td>{{item.productNo}}</td>
                                        <td>{{item.cDate}}</td>
                                        <td>
                                            <button @click="item.isEditing = true"
                                                class="banner-btn-primary">수정</button>
                                        </td>
                                    </template>

                                    <template v-else>
                                        <td>{{item.pBannerImgNo}}</td>
                                        <td><input style="height: 78px;" v-model="item.title"></td>
                                        <td><input style="height: 78px;" v-model="item.productNo"></td>
                                        <td>{{item.cDate}}</td>
                                        <td>
                                            <button @click="saveProductBanner(index)"
                                                class="banner-btn-primary">저장</button>
                                            <button @click="item.isEditing = false"
                                                class="banner-btn-secondary">취소</button>
                                            <button @click="openProductDeleteModal(item)"
                                                class="banner-btn-danger">삭제</button>
                                        </td>
                                    </template>
                                </tr>

                                <tr v-if="item.showImage">
                                    <td colspan="5" style="text-align:center; background-color:#f9f9f9;">
                                        <img :src="item.imgPath" alt="제품 배너 이미지"
                                            style="max-width:600px; border-radius:6px;">
                                    </td>
                                </tr>
                            </template>

                        </table>
                    </div>
                </div>

                <!-- 오른쪽 영역: 대회 배너 관리 -->
                <div class="banner-right-section">
                    <!-- 대회 광고-->
                    <div class="banner-section">
                        <div class="banner-header">
                            <h2 id="contest-banner-section">대회 배너 관리</h2>
                            <button @click="openRallyAddModal" class="banner-btn-primary">
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
                                <th>등록 날짜</th>
                                <th>수정</th>
                            </tr>

                            <template v-for="(item, index) in list2" :key="item.rallyNo">
                                <tr>
                                    <template v-if="!item.isEditing">
                                        <td>{{item.rallyNo}}</td>
                                        <td @click="toggleRallyImage(index)"
                                            style="cursor:pointer; color:#007bff; text-decoration:underline;">
                                            <span class="text-clamp">{{item.rallyName}}</span>
                                        </td>
                                        <td><span class="text-clamp">{{item.rallyDate}}</span></td>
                                        <td><span class="text-clamp">{{item.applicationPeriod}}</span></td>
                                        <td><span class="text-clamp">{{item.price}}</span></td>
                                        <td><span class="text-clamp">{{item.phone}}</span></td>
                                        <td><span class="text-clamp">{{item.type}}</span></td>
                                        <td><span class="text-clamp">{{item.host}}</span></td>
                                        <td><span class="text-clamp">{{item.cDate}}</span></td>
                                        <td>
                                            <button @click="item.isEditing = true"
                                                class="banner-btn-primary">수정</button>
                                        </td>
                                    </template>

                                    <template v-else>
                                        <td>{{item.rallyNo}}</td>
                                        <td><input style="height: 78px;" v-model="item.rallyName"></td>
                                        <td><input style="height: 78px;" v-model="item.rallyDate"></td>
                                        <td><input style="height: 78px;" v-model="item.applicationPeriod"></td>
                                        <td><input style="height: 78px;" v-model="item.price"></td>
                                        <td><input style="height: 78px;" v-model="item.phone"></td>
                                        <td><input style="height: 78px;" v-model="item.type"></td>
                                        <td><input style="height: 78px;" v-model="item.host"></td>
                                        <td>{{item.cDate}}</td>
                                        <td>
                                            <button @click="saveRallyBanner(index)"
                                                class="banner-btn-primary">저장</button>
                                            <button @click="item.isEditing = false"
                                                class="banner-btn-secondary">취소</button>
                                            <button @click="openRallyDeleteModal(item)"
                                                class="banner-btn-danger">삭제</button>
                                        </td>
                                    </template>
                                </tr>

                                <tr v-if="item.showImage">
                                    <td colspan="10" style="text-align:center; background-color:#f9f9f9;">
                                        <img :src="item.imgPath" alt="대회 배너 이미지"
                                            style="max-width:600px; border-radius:6px;">
                                    </td>
                                </tr>
                            </template>

                        </table>
                    </div>
                </div>
            </div>

            <div v-if="showMainDeleteModal" class="modal-overlay">
                <div class="modal-content">
                    <h3>삭제 확인</h3>
                    <p>"{{ mainDeleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmMainDelete()" style="background-color:#dc3545;">삭제</button>
                        <button @click="closeMainDeleteModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <div v-if="showMainAddModal" class="modal-overlay" @click.self="closeMainAddModal">
                <div class="modal-content" @click.stop>
                    <h3>배너 추가</h3>
                    <div class="modal-input">
                        <input v-model="newMainBanner.title" placeholder="배너 제목 입력">
                        <input v-model="newMainBanner.imageDir" placeholder="이미지 경로 입력">
                        <input v-model="newMainBanner.linkUrl" placeholder="링크 URL 입력">
                    </div>
                    <div class="modal-buttons">
                        <button @click="confirmMainAdd" style="background-color:#007bff;">등록</button>
                        <button @click="closeMainAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>


            <div class="preview-box" v-if="selectedImage">
                <h3>이미지 보기</h3>
                <img :src="selectedImage" alt="배너 이미지">
            </div>

            <div v-if="showProductDeleteModal" class="modal-overlay" @click.self="closeProductDeleteModal">
                <div class="modal-content" @click.stop>
                    <h3>삭제 확인</h3>
                    <p>"{{ productDeleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmProductDelete()" style="background-color:#dc3545;">삭제</button>
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
                        <button @click="confirmProductAdd" style="background-color:#007bff;">등록</button>
                        <button @click="closeProductAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <!-- 대회 배너 삭제 모달 -->
            <div v-if="showRallyDeleteModal" class="modal-overlay" @click.self="closeRallyDeleteModal">
                <div class="modal-content" @click.stop>
                    <h3>삭제 확인</h3>
                    <p>"{{ rallyDeleteItem.rallyName }}" 배너를 정말 삭제하시겠습니까?</p>
                    <div class="modal-buttons">
                        <button @click="confirmRallyDelete()" style="background-color:#dc3545;">삭제</button>
                        <button @click="closeRallyDeleteModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <!-- 대회 배너 추가 모달 -->
            <div v-if="showRallyAddModal" class="modal-overlay" @click.self="closeRallyAddModal"
                v-show="showRallyAddModal">
                <div class="modal-content" @click.stop>
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
                        <button @click="confirmRallyAdd" style="background-color:r#007bff;">등록</button>
                        <button @click="closeRallyAddModal" style="background-color:#7e7e7e;">취소</button>
                    </div>
                </div>
            </div>

            <div class="modal-overlay" v-if="alertModal.show" @click.self="fnCloseAlert">
                <div class="modal-content">
                    <h3>알림</h3>
                    <div class="modal-body" v-html="alertModal.message"></div>
                    <div class="modal-actions">
                        <button class="banner-btn-primary height40" @click="fnConfirmAlert">확인</button>
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
                        type: "",
                        host: ""
                    },
                    // 알림 관련
                    notificationCounts: {
                        newInquiryCount: 0,
                        newOrderCount: 0,
                        newBoardReportCount: 0,
                        totalCount: 0
                    },
                    showNotificationPanel: false,
                    notificationInterval: null,
                    alertModal: {
                        show: false,
                        message: "",
                        callback: null
                    }
                };
            },
            methods: {
                fnAlert(msg, callback = null) {
                    this.alertModal.message = msg;
                    this.alertModal.callback = callback;
                    this.alertModal.show = true;
                },
                fnCloseAlert() {
                    this.alertModal.show = false;
                },
                fnConfirmAlert() {
                    if (this.alertModal.callback) this.alertModal.callback();
                    this.fnCloseAlert();
                },
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
                            this.fnAlert("메인 배너 저장 완료!");
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
                },
                toggleImage: function (index) {
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
                            this.fnAlert("메인 배너 삭제 완료!",()=>{
                                this.closeMainDeleteModal();
                                this.fnList(); // 리스트 갱신
                            });
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
                        this.fnAlert("모든 항목을 입력해주세요!");
                        return;
                    }
                    $.ajax({
                        url: "/admin/slideBannerInsert.dox",
                        type: "POST",
                        dataType: "json",
                        data: item,
                        success: (res) => {
                            this.fnAlert("메인 배너 등록 완료!", () => {
                                this.closeMainAddModal();
                                this.fnList();
                            });
                        },
                        error: () => alert("메인 배너 등록 오류 발생!")
                    });
                },

                // 제품 배너 기능 (list1)
                saveProductBanner(index) {
                    let item = this.list1[index];
                    $.ajax({
                        url: "/admin/productBannerUpdate.dox",
                        type: "POST",
                        dataType: "json",
                        data: {
                            pBannerImgNo: item.pBannerImgNo,
                            title: item.title,
                            productNo: item.productNo
                        },
                        success: (res) => {
                            this.fnAlert("제품 배너 저장 완료!", () => {
                                this.list1[index].isEditing = false; // 수정모드 해제
                                this.fnList();
                            });
                        },
                        error: () => {
                            alert("제품 배너 저장 오류 발생!");
                        }
                    });
                },
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
                            this.fnAlert("제품 배너 삭제 완료!", () => {
                                this.closeProductDeleteModal();
                                this.fnList(); // 리스트 갱신
                            });
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
                        this.fnAlert("모든 항목을 입력해주세요!");
                        return;
                    }
                    // 제품 배너 추가는 새로운 API URL을 사용한다고 가정합니다.
                    $.ajax({
                        url: "/admin/productBannerInsert.dox", // 이 URL은 가정입니다. 실제 API URL로 수정하세요.
                        type: "POST",
                        dataType: "json",
                        data: item,
                        success: (res) => {
                            this.fnAlert("제품 배너 등록 완료!", () => {
                                this.closeProductAddModal();
                                this.fnList();
                            });
                        },
                        error: () => alert("제품 배너 등록 오류 발생!")
                    });
                },

                // 대회 광고 (list2)
                saveRallyBanner(index) {
                    let item = this.list2[index];
                    $.ajax({
                        url: "/admin/rallyBannerUpdate.dox",
                        type: "POST",
                        dataType: "json",
                        data: {
                            rallyNo: item.rallyNo,
                            rallyName: item.rallyName,
                            rallyDate: item.rallyDate,
                            applicationPeriod: item.applicationPeriod,
                            price: item.price,
                            phone: item.phone,
                            type: item.type,
                            host: item.host
                        },
                        success: (res) => {
                            this.fnAlert("대회 배너 저장 완료!", () => {
                                this.list2[index].isEditing = false; // 수정모드 해제
                                this.fnList();
                            });
                        },
                        error: () => {
                            alert("대회 배너 저장 오류 발생!");
                        }
                    });
                },
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
                            self.fnAlert("대회 배너 삭제 완료!", ()=>{
                                this.closeRallyDeleteModal();
                                this.fnList(); // 리스트 갱신
                            });
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
                },
                // 알림 관련 메서드
                fetchNotifications: function () {
                    AdminNotifications.fetchNotifications(this);
                },
                toggleNotificationPanel: function () {
                    AdminNotifications.toggleNotificationPanel(this);
                },
                markAsReadAndGo: function (type, url) {
                    AdminNotifications.markAsReadAndGo(this, type, url);
                }
            },
            created() {
                // 컴포넌트 생성 시 즉시 모달 상태 초기화
                this.showMainAddModal = false;
                this.showMainDeleteModal = false;
                this.showProductAddModal = false;
                this.showProductDeleteModal = false;
                this.showRallyAddModal = false;
                this.showRallyDeleteModal = false;
            },
            watch: {
                // showRallyAddModal 값이 변경될 때 로그 출력 (디버깅용)
                showRallyAddModal(newVal) {
                    if (newVal === true) {
                        console.log('showRallyAddModal이 true로 변경됨 - 스택 트레이스:', new Error().stack);
                    }
                }
            },
            mounted() {
                let self = this;
                // 모달 상태 명시적으로 초기화
                self.showMainAddModal = false;
                self.showMainDeleteModal = false;
                self.showProductAddModal = false;
                self.showProductDeleteModal = false;
                self.showRallyAddModal = false;
                self.showRallyDeleteModal = false;

                // DOM 업데이트 후 다시 확인
                self.$nextTick(() => {
                    self.showRallyAddModal = false;
                });

                // 추가 안전장치: 여러 번 확인
                setTimeout(() => {
                    self.showRallyAddModal = false;
                }, 10);
                setTimeout(() => {
                    self.showRallyAddModal = false;
                }, 50);
                setTimeout(() => {
                    if (self.showRallyAddModal === true) {
                        console.warn('showRallyAddModal이 예상치 못하게 true입니다. false로 재설정합니다.');
                        self.showRallyAddModal = false;
                    }
                }, 100);

                self.fnList();
                AdminNotifications.init(self);
            },
            beforeUnmount() {
                AdminNotifications.cleanup(this);
            }
        });
        app.mount('#app');



    </script>

    </body>

    </html>