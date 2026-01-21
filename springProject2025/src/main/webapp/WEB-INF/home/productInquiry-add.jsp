<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="/css/modal-style.css">
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <script src="/js/page-change.js"></script>
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/jes.css">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
        <script src="/js/page-change.js"></script>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <!-- session timeout modal -->
        <script src="/js/session-timeout.js"></script>
        <link rel="stylesheet" href="/css/product-info2.css">
        <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
        <style>
            /* New CSS from homepage */
            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                color: #333;
            }

            #app {
                /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            a:hover {
                text-decoration: underline;
            }

            /* --- Header Section (화면 전체 너비) --- */
            header {
                /* default 헤더 스타일이 header 태그에 직접 적용되도록 재구성 */
                width: 100%;
                background-color: black;
                /* default top-header의 배경색을 header 전체로 */
                color: white;
                /* default top-header의 글자색을 header 전체로 */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .top-header {
                /* default top-header가 header의 유일한 자식이 됨 */
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 150px;
                /* default top-header의 높이 */
                padding: 0 40px;
                /* default footer padding과 맞춤 */
                box-sizing: border-box;
                /* 패딩이 width에 포함되도록 */
            }

            .top-header div {
                display: inline-block;
                text-align: left;
                font-size: 15px;
                margin-right: 0;
                /* flex gap 사용을 위해 개별 div 마진 제거 */
            }

            .top-header input {
                height: 25px;
                border-radius: 8px;
                width: 200px;
            }

            .brand-name {
                /* top-header 내 brand-name */
                margin-right: 0;
                /* top-header div의 default margin-right 상쇄 */
            }

            .brand-name a:hover {
                /* top-header 내 brand-name */
                text-decoration: none;
            }

            .brand-name div {
                font-family: 'Jost', sans-serif;
                font-size: 60px;
                font-weight: 900;
                letter-spacing: 3px;
                margin-left: 0;
                /* top-header div의 default margin-left 상쇄 */
                display: block;
                color: white;
                /* default 유지 */
            }

            .brand-name a {
                color: white;
            }

            #right-items {
                display: flex;
                align-items: center;
                gap: 20px;
                /* 요소들 간 간격 */
            }

            #right-items div {
                font-size: 15px;
                white-space: nowrap;
            }

            #right-items div a {
                color: white;
                /* default top-header의 글자색 */
            }

            #right-items div a:hover {
                color: #eee;
            }

            .bottom-header {
                display: flex;
                justify-content: center;
                font-size: 25px;
                /* default bottom-header 폰트 사이즈 */
                background-color: white;
                /* bottom-header 배경색 추가 */
                border-bottom: 1px solid #eee;
                /* 하단 경계선 */
                padding: 20px 0;
                /* 세로 패딩 */
                letter-spacing: 3px;
            }

            .bottom-header a:hover {
                transform: scale(1.1);
                transition: transform 0.3s ease-out;
                /* faster ease-out */
            }

            .bottom-header a {
                color: black;
                transition: transform 0.2s ease-in;
                /* slower ease-in */
                display: inline-block;
            }

            .bottom-header div {
                display: inline-block;
                margin-right: 100px;
                /* default bottom-header div의 마진 */
                margin-top: 0;
                /* flex-align으로 중앙 정렬 */
                text-align: center;
            }

            .bottom-header a:hover {
                text-decoration: none;
            }

            .bottom-header div:last-child {
                margin-right: 0;
            }

            .bottom-header a {
                color: black;
                /* default bottom-header 링크색 */
            }

            /* .bottom-header a:hover {
            color: #007bff;
        } */

            /* --- Footer Section (화면 전체 너비) --- */
            footer {
                /* default 푸터 스타일 */
                width: 100%;
                height: 200px;
                background-color: black;
                color: white;
                align-items: center;
                display: flex;
                justify-content: space-between;
                font-size: 12px;
                padding: 0 40px;
                /* default footer의 padding */
                box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
                margin-top: auto;
                /* #app이 flex-direction: column일 때 푸터를 아래로 밀어냄 */
                box-sizing: border-box;
                /* 패딩이 width에 포함되도록 */
            }

            .footer-left {
                margin-left: 0;
                /* padding이 있으므로 margin-left 제거 */
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .footer-left .company-info div {
                margin-bottom: 5px;
                white-space: nowrap;
            }

            .copyright {
                margin-top: 8px;
                font-size: 0.9em;
                color: #bbb;
                white-space: nowrap;
            }

            .footer-right {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: flex-end;
            }

            .other {
                margin-bottom: 10px;
                white-space: nowrap;
            }

            .other span {
                margin-left: 20px;
                cursor: pointer;
            }

            .other span:hover {
                text-decoration: underline;
            }

            .other span:first-child {
                margin-left: 0;
            }

            .socials span {
                margin-left: 20px;
                cursor: pointer;
            }

            .socials span:hover {
                text-decoration: underline;
            }

            .socials span:first-child {
                margin-left: 0;
            }

            /* 모달 스타일 (채팅/장바구니와 통일) */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 3000;
                /* z-index 높임 */
                backdrop-filter: blur(3px);
            }

            .modal-content {
                background: white;
                padding: 30px 40px;
                border: none;
                border-radius: 20px;
                width: 400px;
                text-align: center;
                position: relative;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
                animation: fadeIn 0.3s ease;
            }

            .modal-body {
                margin-bottom: 30px;
                font-size: 18px;
                font-weight: bold;
                color: #333;
                line-height: 1.5;
            }

            .modal-actions {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            /* 버튼 스타일 (평소 흰색 -> 호버 검은색) */
            .btn-modal {
                padding: 10px 35px;
                border-radius: 30px;
                border: 2px solid #333;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                background-color: #fff;
                color: #333;
            }

            .btn-modal:hover {
                background-color: #000;
                color: #fff;
                border-color: #000;
                transform: translateY(-2px);
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* text-right 버튼들에 product-info와 동일한 스타일 적용 */
            .text-right button {
                background-color: black;
                color: white;
                border-radius: 8px;
                padding: 10px 15px;
                border: 1px solid #333;
                cursor: pointer;
                font-size: 14px;
                min-width: 100px;
                text-align: center;
                transition: all 0.2s ease;
            }

            .text-right button:hover {
                transform: scale(1.05);
                background-color: black !important;
                color: white !important;
            }

            /* inquiry-btn 클래스가 있다면 동일하게 적용 */
            .inquiry-btn {
                background-color: black;
                color: white;
                border-radius: 8px;
                padding: 10px 15px;
                border: 1px solid #333;
                cursor: pointer;
                font-size: 14px;
                min-width: 100px;
                text-align: center;
                transition: all 0.2s ease;
            }

            .inquiry-btn:hover {
                transform: scale(1.05);
                background-color: black !important;
                color: white !important;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
                <%-- 공통 헤더 컴포넌트 --%>
                    <jsp:include page="/WEB-INF/header/header.jsp" />

                    <main>
                        <div class="newcontent">
                            <!-- <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword"> -->
                            <div class="search-box">
                                <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword"
                                    @keyup.enter="fnProductSearch(keyword)">
                                <a href="javascript:;" @click="fnProductSearch(keyword)">
                                    <div><i data-lucide="search" stroke-width="1"></i></div>
                                </a>
                            </div>
                            <!-- <button class="height40 bluebutton" @click="fnProductSearch(keyword)">검색</button> -->
                        </div>
                        <div class="side-bar">
                            <div class="category-box">
                                <div class="category">카테고리</div>
                                <div class="subcategory" @click="selectCategory('')">전체
                                </div>
                                <div v-for="p in parents" :key="p.typeNo" class="subcategory-wrapper"
                                    @mouseenter="hoverParent = String(p.typeNo)" @mouseleave="hoverParent = null">
                                    <div class="subcategory" @click="selectCategory(p.typeNo)">
                                        {{ p.typeName }}
                                    </div>

                                    <!-- 호버 시 depth=2 목록 -->
                                    <div class="subcategory-children" v-if="hoverParent === String(p.typeNo)">
                                        <div v-for="c in childrenByParent[String(p.typeNo)]" :key="c.typeNo"
                                            class="subcategory child" @click="selectCategory(c.typeNo)">
                                            {{ c.typeName }}
                                        </div>
                                        <div v-if="!childrenByParent[String(p.typeNo)] || childrenByParent[String(p.typeNo)].length === 0"
                                            class="subcategory child empty">
                                            하위 없음
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="infoMain-container">
                            <h1>제품 문의 작성 </h1>
                            <div class="img-box">
                                <template
                                    v-if="imgByProduct[String(productNo)] && imgByProduct[String(productNo)].toLowerCase().endsWith('.glb')">
                                    <model-viewer :src="imgByProduct[String(productNo)]" auto-rotate camera-controls
                                        shadow-intensity="1"
                                        style="width: 100%; height: 400px; background-color: #f8f9fa; border-radius: 15px;">
                                    </model-viewer>
                                </template>

                                <template v-else>
                                    <img :src="imgByProduct[String(productNo)] || '/img/no-image.png'" class="big-img"
                                        :alt="info.productName">
                                </template>
                            </div>
                            <div class="infoText-box">
                                <div class="product-name">{{info.productName}}</div>
                                <!-- <div class="margin80 font20">상품명 : {{info.productName}}</div> -->
                                <!-- <div class="margin80 font20">브랜드 : {{info.brand}}</div> -->
                                <div class="product-type">{{info.brand}}</div>
                                <!-- <div class="margin80 font20">가격 : {{info.price}} 원</div> -->
                                <div class="product-price">{{Number(info.price).toLocaleString()}} 원</div>

                            </div>
                            <div class="container-foot">
                                <div class="editor-box">
                                    <div class="margin30 fontGray">문의 제목</div>
                                    <div><input v-model="title" id="title"></div>
                                    <div class="margin30 fontGray">잠금 설정</div>
                                    <div><input v-model="pwd" placeholder="값을 입력하면 글이 잠깁니다"></div>
                                    <div class="margin30 fontGray">문의 내용</div>
                                    <div id="editor"></div>
                                    <div class="text-right">
                                        <button class="inquiry-btn" @click="fnBack">돌아가기</button>
                                        <button @click="fnAddInquiry">작성하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </main>
                    <div class="modal-overlay" v-if="showAlertModal" @click.self="showAlertModal = false">
                        <div class="modal-content">
                            <div class="modal-body">
                                {{ alertMsg }}
                            </div>
                            <div class="modal-actions">
                                <button class="btn-modal" @click="closeAlertModal">확인</button>
                            </div>
                        </div>
                    </div>
                    <!-- session time out modal -->
                    <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>
                        <footer>
                            <div class="footer-left">
                                <div class="company-info">
                                    <div><strong>회사명:</strong> 러너스 하우스 주식회사</div>
                                    <div><strong>대표:</strong> 김재</div>
                                    <div><strong>사업자등록번호:</strong> 123‑45‑67890</div>
                                    <div><strong>통신판매업 신고번호:</strong> 2025‑서울‑00987</div>
                                    <div><strong>부가세 번호:</strong> KR123456789</div>
                                </div>
                                <div class="copyright">
                                    COPYRIGHT© 2025 RUNNERS HOUSE COMPANY. ALL RIGHT RESERVED.
                                </div>
                            </div>
                            <div class="footer-right">
                                <div class="other">
                                    <span><a href="/home/about.do">회사소개</a></span>
                                    <span><a @click="fnNotice">공지사항</a></span>
                                    <span><a href="/home/terms.do">이용약관</a></span>
                                    <span><a href="/home/privacy.do">개인정보처리방침</a></span>
                                </div>
                                <div class="socials">
                                    <span>INSTAGRAM</span>
                                    <span>NAVER</span>
                                </div>
                            </div>
                        </footer>
            </div>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
            data() {
                return {
                    // 변수 - (key : value)
                    list: [],
                    imgList: [],
                    reviewList: [],
                    typeList: [],
                    hoverParent: null,
                    productNo: "${productNo}",
                    category: "",
                    keyword: "",
                    info: {},
                    sizeList: [],
                    title: "",
                    content: "",
                    pwd: "",
                    sessionId: "${sessionId}",

                    userType: '${userType}',
                    showAlertModal: false,
                    alertMsg: "",
                };
            },
            computed: {
                imgByProduct() {
                    const m = {};
                    for (const img of this.imgList) {
                        const key = String(img.productNo);
                        // 여러 장이면 첫 장만 사용(원하면 배열로 push해서 썸네일/갤러리 구성 가능)
                        if (!m[key]) m[key] = img.imgPath;
                    }
                    return m;
                },
                parents() {
                    return (this.typeList || []).filter(t => String(t.depth) === '1');
                },
                // 부모 typeNo -> 자식 배열 매핑
                childrenByParent() {
                    const map = {};
                    for (const t of (this.typeList || [])) {
                        if (String(t.depth) !== '2') continue;
                        const parentKey = String(t.typePart);       // 자식의 typePart가 부모 typeNo
                        if (!map[parentKey]) map[parentKey] = [];
                        map[parentKey].push(t);
                    }
                    // 정렬(옵션): 이름순
                    for (const k in map) {
                        map[k].sort((a, b) => String(a.typeName).localeCompare(String(b.typeName), 'ko', { sensitivity: 'base' }));
                    }
                    return map;
                }
            },
            methods: {
                // 장바구니 수량을 서버에서 가져오는 함수
                fetchCartCount() {
                    // 세션 아이디가 없으면 실행하지 않음
                    if (this.sessionId == '' || this.sessionId == null) return;

                    let self = this;
                    $.ajax({
                        url: '/api/cartCount.dox',
                        method: 'GET',
                        // ★ 서버의 @RequestParam HashMap map으로 전달될 데이터 ★
                        data: {
                            sessionId: self.sessionId
                        },
                        dataType: 'json',
                        success: (response) => {
                            console.log("서버 응답 데이터:", response);
                            if (response.result === 'success') {
                                self.cartCount = response.count; // 서버에서 보낸 count 값을 Vue 변수에 저장
                            }
                        },
                        error: (err) => {
                            console.error("AJAX 호출 중 오류 발생:", err);
                        }
                    });
                },

                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        productNo: self.productNo
                    };
                    $.ajax({
                        url: "/product/user/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                            self.sizeList = data.sizeList;
                            self.category = data.typeNo;
                        }
                    });
                },
                fnImgList() {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/product/img/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.imgList = data.imgList;
                        }
                    });
                },
                selectCategory(typeNo) {
                    let self = this;
                    self.category = typeNo;
                    console.log(" == > " + self.category);
                    self.fnCategoryProduct(typeNo);
                    // 페이지 이동 넣어야함
                },
                fnList() {
                    let self = this;
                    let param = {
                    };
                    $.ajax({
                        url: "/product/user/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.typeList = data.typeList;
                        }
                    });
                },
                fnCategoryProduct(category) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: category, sessionId: self.sessionId });
                },
                fnProduct() {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: "", sessionId: self.sessionId });
                },
                fnProductSearch(key) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: key, category: "", sessionId: self.sessionId });
                },
                fnBack() {
                    let self = this;
                    pageChange("/home/product-info.do", { productNo: self.productNo, sessionId: self.sessionId });
                },
                closeAlertModal() {
                    this.showAlertModal = false;
                    // 제목이 비어서 떴던 거면 제목창에 포커스
                    if (this.alertMsg.includes("제목")) {
                        setTimeout(() => document.querySelector("#title").focus(), 100);
                    }
                },

                // [수정] 문의 작성 함수
                fnAddInquiry() {
                    let self = this;

                    // 1. 제목 체크 -> 모달 띄우기
                    if (self.title == "") {
                        self.alertMsg = "제목이 비어있습니다!";
                        self.showAlertModal = true;
                        return;
                    }

                    // 2. 내용 체크 -> 모달 띄우기
                    // Quill 에디터의 경우 태그가 포함될 수 있어 텍스트만 체크하거나 trim 필요할 수 있음
                    // 여기서는 기존 로직대로 빈 문자열 체크
                    if (self.content == "" || self.content == "<p><br></p>") {
                        self.alertMsg = "내용이 비어있습니다!";
                        self.showAlertModal = true;
                        return;
                    }

                    let param = {
                        productNo: self.productNo,
                        title: self.title,
                        content: self.content,
                        userId: self.sessionId,
                        pwd: self.pwd
                    };

                    $.ajax({
                        url: "/product/inquiry/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            // 3. 성공 시 alert("작성 완료!") 제거함
                            // 바로 목록으로 돌아가기
                            self.fnBack();
                        }
                    });
                },
                fnLogout: function () {
                    let self = this;
                    self.clearSessionTimers();
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
                    })
                },
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },



            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnInfo();
                self.fnImgList();
                var quill = new Quill('#editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                            ['link', 'image'],
                            ['clean']
                        ]
                    }
                });

                // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                quill.on('text-change', function () {
                    self.content = quill.root.innerHTML;
                });

                // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
            },
            beforeUnmount() {
                let self = this;
                self.removeActivityListeners();
                self.clearSessionTimers();
            }
        });
        app.config.compilerOptions.isCustomElement = tag => tag === 'model-viewer';
        app.mount('#app');
    </script>