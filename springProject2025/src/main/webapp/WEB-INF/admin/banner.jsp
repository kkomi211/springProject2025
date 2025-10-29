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
        <script src="/js/page-change.js"></script>

        <style>
            body {
                font-family: "Noto Sans KR", sans-serif;
                background-color: #fbeff3;
                text-align: center;
                margin: 0;
                padding: 0;
            }

            h2 {
                margin-top: 30px;
                font-size: 50px;
            }

            table {
                border-collapse: collapse;
                width: 80%;
                max-width: 1100px;
                background-color: white;
                margin: 0 auto;
                table-layout: fixed;
                text-align: center;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            th,
            td {
                border: 1px solid #ddd;
                padding: 10px;
                word-break: break-all;
            }

            th {
                background-color: #222;
                color: white;
                font-weight: bold;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            /* 버튼 스타일 유지 */
            button {
                background-color: #555;
                color: white;
                border: none;
                padding: 5px 12px;
                cursor: pointer;
                border-radius: 4px;
            }

            button:hover {
                background-color: #8e44ad;
            }

            /* 반응형 (화면이 좁을 때) */
            @media (max-width: 1200px) {
                .left-ad-area {
                    position: static;
                    /* 모바일에서는 고정 해제 */
                    width: 100%;
                    flex-direction: row;
                    justify-content: center;
                    margin-bottom: 20px;
                }

                .ad-box {
                    flex: 1;
                    height: auto;
                    font-size: 1.1em;
                }

                table {
                    width: 85%;
                }
            }

            /* 이미지 미리보기 스타일 */
            .preview-box {
                margin-top: 40px;
                padding: 20px;
                background-color: #fff;
                border: 2px solid #ddd;
                display: inline-block;
                border-radius: 8px;
            }

            .preview-box img {
                max-width: 600px;
                border-radius: 6px;
            }

            table img {
                max-width: 600px;
                border-radius: 6px;
                margin: 10px 0;
            }

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
                z-index: 999;
            }

            .modal-content {
                background: white;
                padding: 30px;
                border-radius: 8px;
                width: 400px;
                text-align: center;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            }

            .modal-input input {
                display: block;
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .modal-buttons button {
                margin: 2 10px;
                padding: 8px 20px;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 4px;
            }

            /* 1. 테이블과 좌측 영역을 감싸는 컨테이너 추가 */
            /* 전체 영역 기본 구조 */
            .content-wrapper {
                position: relative;
                width: 100%;
                display: flex;
                justify-content: center;
                /* 테이블을 화면 정중앙에 위치시킴 */
                align-items: flex-start;
                padding-top: 40px;
            }

            /* 2. 좌측 광고 영역 스타일 */
            .left-ad-area {
                position: fixed;
                /* 스크롤 시 화면에 고정 */
                top: 300px;
                /* 화면 상단으로부터 거리 */
                left: 60px;
                /* 화면 왼쪽으로부터 거리 */
                width: 200px;
                display: flex;
                flex-direction: column;
                gap: 10px;
                z-index: 1000;
                /* 다른 요소보다 위에 표시 */
            }

            /* 3. 각 광고 박스 스타일 */

            .ad-box {
                background-color: #f3f3f3;
                border: 3px solid #000000;
                padding: 40px;
                height: 80px;
                border-radius: 12px;
                font-size: 1.2em;
                font-weight: bold;
                color: #3b3b3b;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.05);
                background: rgba(231, 231, 231, 0.25);
                /* 반투명 흰색 */
                backdrop-filter: blur(1px);
                /* 유리 효과 */
                -webkit-backdrop-filter: blur(1px);
                /* 사파리 호환 */
            }
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
                <a href="/admin/inquery.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
            </div>

            <!-- 메인 슬라이드 광고 -->
            <h2>메인 슬라이드 배너 관리</h2>

            <button @click="openAddModal" style="background-color:rgb(60,173,255);" style="text-align: right;">
                메인 배너 추가
            </button>

            <div class="content-wrapper">
                <div class="left-ad-area">
                    <div class="ad-box">메인 슬라이드 배너</div>
                    <div class="ad-box">제품 배너</div>
                    <div class="ad-box">서브 슬라이드 배너</div>
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
                        <!-- 기본 row -->
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

                            <!-- 삭제 모달 -->
                            <div v-if="showDeleteModal" class="modal-overlay">
                                <div class="modal-content">
                                    <h3>삭제 확인</h3>
                                    <p>"{{ deleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                                    <div class="modal-buttons">
                                        <button @click="confirmDelete" style="background-color:#F24822;">삭제</button>
                                        <button @click="closeDeleteModal" style="background-color:#7e7e7e;">취소</button>
                                    </div>
                                </div>
                            </div>

                            <!-- 추가 모달-->
                            <div v-if="showAddModal" class="modal-overlay">
                                <div class="modal-content">
                                    <h3>배너 추가</h3>
                                    <div class="modal-input">
                                        <input v-model="newBanner.title" placeholder="배너 제목 입력">
                                        <input v-model="newBanner.imageDir" placeholder="이미지 경로 입력">
                                        <input v-model="newBanner.linkUrl" placeholder="링크 URL 입력">
                                    </div>
                                    <div class="modal-buttons">
                                        <button @click="confirmAdd"
                                            style="background-color:rgb(60,173,255);;">등록</button>
                                        <button @click="closeAddModal" style="background-color:#7e7e7e;">취소</button>
                                    </div>
                                </div>
                            </div>

                            <template v-else>
                                <td>{{item.bannerId}}</td>
                                <td><input style="height: 78px;" v-model="item.title"></td>
                                <td><input style="height: 78px;" v-model="item.imageDir"></td>
                                <td><input style="height: 78px;" v-model="item.linkUrl"></td>
                                <td>{{item.cDate}}</td>
                                <td>
                                    <button @click="saveItem(index)"
                                        style="background-color: rgb(60,173,255);">저장하기</button>
                                    <button @click="item.isEditing = false"
                                        style="background-color: #7e7e7e;">취소하기</button>
                                    <button @click="openDeleteModal(item)"
                                        style="background-color: #F24822;">삭제</button>
                                </td>
                            </template>
                        </tr>

                        <!-- 이미지 row -->
                        <tr v-if="item.showImage">
                            <td colspan="6" style="text-align:center; background-color:#f9f9f9;">
                                <img :src="item.imageDir" alt="배너 이미지" style="max-width:600px; border-radius:6px;">
                            </td>
                        </tr>
                    </template>

                </table>
            </div>

            <div class="preview-box" v-if="selectedImage">
                <h3>이미지 보기</h3>
                <img :src="selectedImage" alt="배너 이미지">
            </div>

            <!-- 제품 광고 -->
            <h2>제품 배너 관리</h2>

            <button @click="openAddModal" style="background-color:rgb(60,173,255);" style="text-align: right;">
                제품 배너 추가
            </button>

            <table>
                <tr>
                    <th>이미지 번호</th>
                    <th>배너 제목</th>
                    <th>상품 번호</th>
                    <th>이미지 경로</th>
                    <th>등록 날짜</th>
                    <th>수정 하기</th>
                </tr>

                <template v-for="(item, index) in list" :key="item.bannerId">
                    <!-- 기본 row -->
                    <tr>
                        <template v-if="!item.isEditing">
                            <td>{{item.pBannerImgNo}}</td>
                            <td @click="toggleImage(index)"
                                style="cursor:pointer; color:rgb(60,173,255); text-decoration:underline;">
                                {{item.title}}
                            </td>
                            <td>{{item.productNo}}</td>
                            <td>{{item.productImgNo}}</td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <button @click="item.isEditing = true"
                                    style="background-color: rgb(60,173,255);">수정하기</button>
                            </td>
                        </template>

                        <!-- 삭제 모달 -->
                        <div v-if="showDeleteModal" class="modal-overlay">
                            <div class="modal-content">
                                <h3>삭제 확인</h3>
                                <p>"{{ deleteItem.title }}" 배너를 정말 삭제하시겠습니까?</p>
                                <div class="modal-buttons">
                                    <button @click="confirmDelete" style="background-color:#F24822;">삭제</button>
                                    <button @click="closeDeleteModal" style="background-color:#7e7e7e;">취소</button>
                                </div>
                            </div>
                        </div>

                        <!-- 추가 모달-->
                        <div v-if="showAddModal" class="modal-overlay">
                            <div class="modal-content">
                                <h3>배너 추가</h3>
                                <div class="modal-input">
                                    <input v-model="newBanner.title" placeholder="배너 제목 입력">
                                    <input v-model="newBanner.imageDir" placeholder="이미지 경로 입력">
                                    <input v-model="newBanner.linkUrl" placeholder="링크 URL 입력">
                                </div>
                                <div class="modal-buttons">
                                    <button @click="confirmAdd" style="background-color:rgb(60,173,255);;">등록</button>
                                    <button @click="closeAddModal" style="background-color:#7e7e7e;">취소</button>
                                </div>
                            </div>
                        </div>

                        <template v-else>
                            <td>{{item.pBannerImgNo}}</td>
                            <td><input style="height: 78px;" v-model="item.title"></td>
                            <td><input style="height: 78px;" v-model="item.imageDir"></td>
                            <td><input style="height: 78px;" v-model="item.linkUrl"></td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <button @click="saveItem(index)"
                                    style="background-color: rgb(60,173,255);">저장하기</button>
                                <button @click="item.isEditing = false" style="background-color: #7e7e7e;">취소하기</button>
                                <button @click="openDeleteModal(item)" style="background-color: #F24822;">삭제</button>
                            </td>
                        </template>
                    </tr>

                    <!-- 이미지 row -->
                    <tr v-if="item.showImage">
                        <td colspan="6" style="text-align:center; background-color:#f9f9f9;">
                            <img :src="item.imageDir" alt="배너 이미지" style="max-width:600px; border-radius:6px;">
                        </td>
                    </tr>
                </template>

            </table>
        </div>


        <h2>대회 배너 관리</h2>

        </div>

        <script>
            const app = Vue.createApp({
                data() {
                    return {
                        list: [],
                        editFlg: false,
                        selectedImage: "", // 클릭된 이미지 저장 변수
                        showDeleteModal: false,  // 모달 표시 여부
                        showAddModal: false,
                        deleteItem: null, // 삭제 대상 아이템
                        newBanner: {
                            title: "",
                            imageDir: "",
                            linkUrl: ""
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
                            url: "/admin/banner1.dox",
                            dataType: "json",
                            type: "POST",
                            success: function (data) {
                                // 각 항목에 isEditing 속성 추가
                                console.log(data);

                                self.list = data.list.map(item => ({
                                    ...item,
                                    isEditing: false

                                }));
                            }

                        });

                    },


                    // 제목 클릭 시 이미지 표시
                    showImage(imageUrl) {
                        this.selectedImage = imageUrl;
                    },
                    // 저장 버튼 눌렀을 때
                    saveItem(index) {
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
                                alert("저장 완료!");
                                this.list[index].isEditing = false; // 수정모드 해제
                                this.fnList();
                            },
                            error: () => {
                                alert("오류 발생!");
                            }
                        });
                    },
                    // 제목 클릭 시 이미지 토글
                    toggleImage(index) {
                        // 다른 아이템들은 이미지 숨김
                        this.list.forEach((item, i) => {
                            if (i !== index) item.showImage = false;
                        });
                        // 클릭한 아이템만 토글
                        this.list[index].showImage = !this.list[index].showImage;
                    },
                    openDeleteModal(item) {
                        this.deleteItem = item;
                        this.showDeleteModal = true;
                    },
                    closeDeleteModal() {
                        this.showDeleteModal = false;
                        this.deleteItem = null;
                    },
                    confirmDelete() {
                        if (!this.deleteItem) return;

                        // 실제 삭제 요청 (AJAX 예시)
                        $.ajax({
                            url: "/admin/bannerDelete.dox",
                            type: "POST",
                            dataType: "json",
                            data: { bannerId: this.deleteItem.bannerId },
                            success: (res) => {
                                alert("삭제 완료!");
                                this.closeDeleteModal();
                                this.fnList(); // 리스트 갱신
                            },
                            error: () => {
                                alert("삭제 중 오류 발생!");
                            }
                        });
                    },

                    openAddModal() {
                        this.showAddModal = true;
                    },
                    closeAddModal() {
                        this.showAddModal = false;
                        this.newBanner = { title: "", imageDir: "", linkUrl: "" };
                    },
                    confirmAdd() {
                        let item = this.newBanner;
                        if (!item.title || !item.imageDir) {
                            alert("모든 항목을 입력해주세요!");
                            return;
                        }
                        $.ajax({
                            url: "/admin/bannerInsert.dox",
                            type: "POST",
                            dataType: "json",
                            data: item,
                            success: (res) => {
                                alert("등록 완료!");
                                this.closeAddModal();
                                this.fnList();
                            },
                            error: () => alert("등록 오류 발생!")
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
