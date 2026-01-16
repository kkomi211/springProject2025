<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <!-- <link rel="stylesheet" href="/css/style.css"> -->
        <!-- Google Fonts (Jost)  -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <!-- <link rel="stylesheet" href="/css/jes.css"> -->
        <script src="/js/page-change.js"></script>
        <link rel="stylesheet" href="/css/home_product_category-style.css">
        <link rel="stylesheet" href="/css/home.css">
        <script src="https://unpkg.com/lucide@latest"></script>
        
        <!-- 최근 본 상품 컴포넌트 스크립트 -->
        <script src="/js/recent-products.js"></script>
        
        <!-- 위젯 위치 동적 조정 스크립트 -->
        <script src="/js/widget-position.js"></script>
        <style>
            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                color: #333;
                line-height: 1.6;
            }

            #app {
                /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* search box */

            .search-box {
                position: relative;
                /* make this the positioning container */
                display: inline-block;
                margin-top: 15px;
                margin-bottom: 15px;
            }

            .newcontent input {
                /* margin-top: 10px; */
                border-radius: 5px;
                border: solid 1px grey;
                padding-left: 15px;
                /* move text and placeholder right */
                padding-top: 5px;
                /* move text and placeholder down */
            }

            .newcontent input:hover {
                border-radius: 5px;
                border: solid 1px rgb(0, 0, 0);
            }

            .search-box div {
                position: absolute;
                top: 8px;
                right: 18px;
            }

            /* NEW 배지 스타일 (게시판과 동일 디자인) */
            .new-product-badge {
                display: inline-block;
                background: linear-gradient(135deg, #ff4444, #ff6b6b);
                color: white;
                padding: 2px 6px;
                border-radius: 10px;
                font-size: 10px;
                font-weight: bold;
                margin-left: 6px;
                box-shadow: 0 2px 6px rgba(255, 68, 68, 0.5);
                animation: pulse 2s infinite;
                vertical-align: middle;
                line-height: 1.2;
            }

            .sidebar .new-product-badge {
                font-size: 9px;
                /* 폰트 더 작게 */
                padding: 1px 5px;
                /* 패딩 줄임 */
                margin-left: auto;
                /* 오른쪽 끝으로 밀기 (Flex일 경우 유용) */
                float: right;
                /* 오른쪽 정렬 */
                margin-top: 4px;
                /* 높이 보정 */
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                    box-shadow: 0 2px 8px rgba(255, 68, 68, 0.4);
                }

                50% {
                    transform: scale(1.1);
                    box-shadow: 0 4px 12px rgba(255, 68, 68, 0.6);
                }

                100% {
                    transform: scale(1);
                    box-shadow: 0 2px 8px rgba(255, 68, 68, 0.4);
                }
            }

            /* 정렬 선택 박스 스타일 */
            .sort-select {
                padding: 10px 15px;
                border-radius: 20px;
                /* 둥글게 */
                border: 1px solid #ddd;
                font-size: 14px;
                background-color: #fff;
                cursor: pointer;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                /* 은은한 그림자 */
                transition: all 0.3s ease;
                outline: none;
                color: #555;
                font-weight: 500;
            }

            .sort-select:hover,
            .sort-select:focus {
                border-color: #a18cd1;
                /* 포커스 시 보라색 톤 */
                box-shadow: 0 4px 10px rgba(161, 140, 209, 0.2);
                /* 떠오르는 효과 */
                transform: translateY(-1px);
            }
        </style>
    </head>

    <body>
        <div id="app">
            <%-- 공통 헤더 컴포넌트 --%>
                <jsp:include page="/WEB-INF/header/header.jsp" />

                <div class="container">
                    <main>
                        <div class="newcontent"
                            style="display: flex; justify-content: flex-end; align-items: center; gap: 10px; margin-bottom: 10px;">

                            <select v-model="orderType" @change="fnList" class="sort-select">
                                <option value="RECENT">최신순</option>
                                <option value="PRICE_DESC">가격비싼순</option>
                                <option value="PRICE_ASC">가격저렴한순</option>
                            </select>

                            <div class="search-box" style="margin: 0;"> <input class="search" placeholder="제품 이름을 입력하세요"
                                    v-model="keyword" @keyup.enter="fnList">
                                <a href="javascript:;" @click="fnList">
                                    <div><i data-lucide="search" stroke-width="1"></i></div>
                                </a>
                            </div>
                        </div>
                        <!-- <div class="header">
                        <div class="header-welcome">
                            Welcome,
                        </div>
                        <div class="header-user">
                            {{ userName }}
                        </div>
                    </div> -->
                        <div class="page-container">
                            <div class="sidebar" @mouseleave="hoverParent = null">
                                <div class="category-box">
                                    <div class="category">카테고리</div>
                                    <!-- ★★★ "전체" 카테고리 active 조건 수정 ★★★ -->
                                    <div class="subcategory"
                                        :class="{ active: category === '' || category === 'undefined' }"
                                        @click="selectCategory('')">전체</div>
                                    <div v-for="p in parents" :key="p.typeNo" class="subcategory-wrapper"
                                        @mouseenter="hoverParent = String(p.typeNo)">
                                        <!-- ★★★ 1차 카테고리 active 조건 수정 ★★★ -->
                                        <div class="subcategory"
                                            :class="{ active: String(p.typeNo) === currentActiveParentNo || String(p.typeNo) === category }"
                                            @click="selectCategory(p.typeNo)">
                                            {{ p.typeName }}
                                            <span v-if="newCategorySet.has(String(p.typeNo))"
                                                class="new-product-badge">N</span>
                                        </div>

                                        <div class="subcategory-children"
                                            v-if="hoverParent === String(p.typeNo) || currentActiveParentNo === String(p.typeNo)">
                                            <div v-for="c in childrenByParent[String(p.typeNo)]" :key="c.typeNo"
                                                class="subcategory child"
                                                :class="{ active: String(c.typeNo) === category }"
                                                @click="selectCategory(c.typeNo)">
                                                {{ c.typeName }}
                                                <span v-if="newCategorySet.has(String(c.typeNo))"
                                                    class="new-product-badge">N</span>
                                            </div>
                                            <div v-if="!childrenByParent[String(p.typeNo)] || childrenByParent[String(p.typeNo)].length === 0"
                                                class="subcategory child empty">
                                                하위 없음
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <main class="main-content">
                                <div class="main-container">
                                    <div class="product-box" v-for="item in list" :key="item.productNo"
                                        @click="fnProductView(item.productNo)">
                                        <a :href="'/home/product-info.do?productNo=' + item.productNo">
                                            <div class="product-image-container">
                                                <img :src="imgByProduct[String(item.productNo)] || '/img/no-image.png'"
                                                    class="small-img" :alt="item.productName">
                                            </div>
                                            <div class="product-info-text">
                                                <div class="brandText product-margin">{{item.brand}}</div>
                                                <div class="product-margin">
                                                    {{item.productName}}
                                                    <span v-if="isNewProduct(item.udate)"
                                                        class="new-product-badge">NEW</span>
                                                </div>
                                                <p class="price product-margin" v-if="item.saleYN == 'N'">
                                                    {{formatCurrency(item.price)}}</p>
                                                <p class="price product-margin" v-else>
                                                    <del>{{formatCurrency(item.price)}}</del>
                                                    {{formatCurrency(item.salePrice)}}
                                                </p>
                                            </div>
                                            <div v-if="ratingByName[item.productName]"
                                                class="stars-review-area product-margin">
                                                <span v-for="n in 5" :key="n" class="star"
                                                    :class="{ filled: n <= ratingByName[item.productName].rounded }">★</span>
                                                <span class="avg"> {{ ratingByName[item.productName].avg.toFixed(1)
                                                    }}</span>
                                                <span class="cnt"> ({{ ratingByName[item.productName].cnt }})</span>
                                            </div>
                                            <div v-else class="no-review product-margin">리뷰 없음</div>
                                        </a>
                                    </div>
                                </div>
                                <div class="clear text-center margin-right">
                                    <span class="margin30 font30 cursor" :class="{bold: page == num}"
                                        v-for="num in totalPage" @click="fnPage(num)">{{num}}</span>
                                </div>
                            </main>
                        </div>
                    </main>
                </div>
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
                
                <!-- 최근 본 상품 컴포넌트 -->
                <div id="recent-products-widget"></div>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    list: [],
                    imgList: [],
                    reviewList: [],
                    typeList: [],
                    page: 1,
                    pageSize: 9,
                    totalPage: "",
                    keyword: "${keyword}",
                    category: "${category}",
                    hoverParent: null,
                    sessionId: "${sessionId}",
                    userName: "",
                    saleYN: "${saleYN}",
                    activeParentNo: null,

                    userType: '${userType}',

                    cartCount: 0, // 장바구니 수량 변수 추가
                    newReplyCount: 0, // 새 답변 개수
                    newCategorySet: new Set(),
                    orderType: "RECENT",
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
                ratingByName() {
                    const m = {};
                    for (const r of this.reviewList || []) {
                        // 컬럼명이 대문자(AVG_RATING/REVIEW_CNT)로 올 수도 있어 둘 다 대응
                        const name = String(r.productName || r.PRODUCT_NAME);
                        const avg = Number(r.avgRating ?? r.AVG_RATING ?? 0);
                        const cnt = Number(r.reviewCnt ?? r.REVIEW_CNT ?? 0);
                        m[name] = { avg, cnt, rounded: Math.round(avg) };
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
                },
                currentActiveParentNo() {
                    if (!this.category || this.category === 'undefined' || this.category === '') {
                        return null; // "전체" 카테고리 또는 정의되지 않은 경우
                    } else if (String(this.category).length === 2) { // 1차 카테고리 (예: '10')
                        return String(this.category);
                    } else if (String(this.category).length === 3) { // 2차 카테고리 (예: '101')
                        return String(this.category).slice(0, 2); // 해당 2차 카테고리의 1차 부모 typeNo 추출
                    }
                    return null; // 기타 예상치 못한 경우
                }
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        page: (self.page - 1) * self.pageSize,
                        pageSize: 9,
                        keyword: self.keyword,
                        keytype: "name",
                        category: self.category,
                        saleYN: self.saleYN,
                        orderType: self.orderType
                    };
                    $.ajax({
                        url: "/product/user/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.totalPage = Math.ceil(data.total / self.pageSize);
                            self.typeList = data.typeList;
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
                fnReviewList() {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/review/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.reviewList = data.avgRating;
                        }
                    });
                },
                fnPage(num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
                },
                selectCategory(selectedTypeNo) {
                    console.log('--- selectCategory 호출 ---');
                    console.log('클릭된 typeNo:', selectedTypeNo);

                    // 1. category 상태 업데이트 (watch 훅 트리거)
                    const newCategory = (selectedTypeNo === '' || selectedTypeNo === 'undefined' || selectedTypeNo === null) ? '' : String(selectedTypeNo);
                    if (this.category !== newCategory) {
                        this.category = newCategory;
                        // page는 watch 훅에서 category 변경 시 1로 초기화됩니다.
                        // fnList도 watch 훅에서 자동으로 호출됩니다.
                    }

                    // 2. activeParentNo 업데이트 (드롭다운 고정 로직)
                    if (newCategory === '') { // "전체" 카테고리 선택 시
                        this.activeParentNo = null; // 어떤 드롭다운도 고정하지 않음
                    } else if (newCategory.length === 2) { // 1차 카테고리 클릭 시
                        this.activeParentNo = newCategory;
                    } else if (newCategory.length === 3) { // 2차 카테고리 클릭 시
                        this.activeParentNo = newCategory.slice(0, 2); // 2차 카테고리의 1차 부모를 고정
                    } else {
                        this.activeParentNo = null;
                    }

                    // 클릭 후에는 hoverParent를 null로 설정하여 마우스가 없을 때 호버 효과가 사라지도록 합니다.
                    this.hoverParent = null;
                    console.log('-> category:', this.category, 'activeParentNo:', this.activeParentNo, 'hoverParent:', this.hoverParent);
                },
                fnProductView(productNo, rating) {
                    let self = this;
                    pageChange("/home/product-info.do", { productNo: productNo, sessionId: self.sessionId });
                },
                fnProduct() {
                    let self = this;
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: "", keyword: "" });
                },
                fnUserInfo() {
                    let self = this;
                    $.ajax({
                        url: "/home/mypage/userInfo.dox",
                        dataType: "json",
                        type: "POST",
                        data: { userId: self.sessionId },
                        success: function (data) {
                            console.log("사용자 이름:", data);
                            self.userName = data;
                        },
                        error: function (xhr, status, error) {
                            console.error("사용자 정보 조회 실패:", error);
                            self.userName = "Guest";
                        }
                    });
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
                    })
                },
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN, keyword: "" });
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },
                formatCurrency(value) {
                    if (value === null || value === undefined || value === '') {
                        return '0 원';
                    }
                    const numberValue = Number(value);
                    if (isNaN(numberValue)) {
                        return value; // 숫자로 변환할 수 없으면 원래 값 반환
                    }
                    return numberValue.toLocaleString('ko-KR') + ' 원';
                },

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
                
                // 새 답변 개수 체크 (localStorage 기반)
                checkNewReplyCount: function() {
                    let self = this;
                    if (!self.sessionId || self.sessionId === '') {
                        self.newReplyCount = 0;
                        return;
                    }
                    
                    // localStorage에서 확인한 답변 목록 불러오기
                    const storageKey = `checkedReplies_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);
                    let checkedReplies = [];
                    if (saved) {
                        try {
                            checkedReplies = JSON.parse(saved);
                        } catch (e) {
                            checkedReplies = [];
                        }
                    }
                    
                    // 서버에서 답변 완료된 문의 목록 가져오기
                    $.ajax({
                        url: "/home/mypage/my-inquiry.dox",
                        dataType: "json",
                        type: "POST",
                        data: {
                            sessionId: self.sessionId,
                            page: 1,
                            pageSize: 1000 // 모든 문의 가져오기
                        },
                        success: function (data) {
                            if (data.result == "success" && data.list) {
                                let uncheckedCount = 0;
                                data.list.forEach(function(item) {
                                    if (item.status === 'Y' && !checkedReplies.includes(item.inquiryNo)) {
                                        uncheckedCount++;
                                    }
                                });
                                self.newReplyCount = uncheckedCount;
                                console.log("새 답변 개수:", uncheckedCount);
                            } else {
                                self.newReplyCount = 0;
                            }
                        },
                        error: function() {
                            self.newReplyCount = 0;
                        }
                    });
                },
                isNewProduct(dateString) {
                    // 1. 데이터가 없으면 무조건 false (에러 방지)
                    if (!dateString || dateString.length < 10) return false;

                    // 2. DB 날짜에서 [월-일]만 추출 (예: "2026-01-14" -> "01-14")
                    // substring(5, 10)은 5번째 글자부터 10번째 글자 앞까지 자릅니다.
                    let dbDate = String(dateString).substring(5, 10);

                    // 3. 내 컴퓨터 날짜에서 [월-일]만 추출
                    let now = new Date();
                    let month = ('0' + (now.getMonth() + 1)).slice(-2);
                    let day = ('0' + now.getDate()).slice(-2);
                    let pcDate = month + '-' + day;

                    // 4. 디버깅 로그 (F12 콘솔에서 값이 제대로 찍히는지 확인해보세요)
                    // console.log("DB날짜:", dbDate, " / 내PC날짜:", pcDate);

                    // 5. 비교 (연도 상관없이 오늘 날짜면 true)
                    return dbDate === pcDate;
                },
                checkNewCategories() {
                    const self = this;
                    self.newCategorySet = new Set(); // 초기화

                    console.log("--- NEW 카테고리 체크 시작 ---");

                    // 현재 페이지에 있는 상품 리스트 순회
                    self.list.forEach(item => {
                        // 이 상품이 NEW라면 (cdate나 udate가 오늘 날짜라면)
                        if (self.isNewProduct(item.cdate) || self.isNewProduct(item.udate)) {
                            console.log(`NEW 상품 발견: ${item.productName} (typeNo: ${item.typeNo})`);

                            // 1. 해당 상품의 카테고리(2차) ID 추가
                            self.newCategorySet.add(String(item.typeNo));

                            // 2. 그 카테고리의 부모(1차) ID도 찾아서 추가
                            // typeList에서 현재 상품의 typeNo와 일치하는 정보를 찾음
                            if (!self.typeList) {
                                console.warn("typeList가 비어있음!");
                                return;
                            }

                            const typeInfo = self.typeList.find(t => String(t.typeNo) === String(item.typeNo));

                            if (typeInfo) {
                                console.log(` -> 카테고리 정보 찾음: ${typeInfo.typeName}, 부모ID(typePart): ${typeInfo.typePart}`);
                                if (typeInfo.typePart) {
                                    self.newCategorySet.add(String(typeInfo.typePart));
                                } else {
                                    console.log(" -> 부모 ID(typePart)가 없음 (1차 카테고리이거나 데이터 누락)");
                                }
                            } else {
                                console.warn(` -> typeList에서 typeNo [${item.typeNo}]를 찾을 수 없음`);
                            }
                        }
                    });

                    console.log("최종 NEW 카테고리 목록:", Array.from(self.newCategorySet));
                },
                fnCheckAllNewCategories() {
                    let self = this;
                    // 배지 확인용으로 최신 상품을 넉넉히 가져옵니다 (예: 100개)
                    // 실제 운영 시에는 '최근 3일간 등록된 상품의 카테고리 ID 목록'만 반환하는 API를 만드는 게 좋습니다.
                    let param = {
                        page: 0,
                        pageSize: 500, // 충분히 많은 수
                        keyword: "",
                        keytype: "",
                        category: "", // 전체 대상
                        saleYN: ""
                    };

                    $.ajax({
                        url: "/product/user/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // 여기서 받아온 리스트는 화면 표시용이 아니라, 배지 확인용입니다.
                            // data.list를 순회하며 NEW 상품이 있는지 확인

                            // typeList 정보도 필요하므로 data.typeList가 있다면 활용, 
                            // 없다면 기존 fnList에서 받아온 typeList를 써야 하는데 비동기 시점 문제가 있을 수 있음.
                            // 보통 list.dox가 typeList도 같이 주므로 그것을 임시로 씁니다.
                            const allTypes = data.typeList || self.typeList;

                            if (!allTypes) return; // 타입 정보 없으면 중단

                            const tempSet = new Set();

                            data.list.forEach(item => {
                                if (self.isNewProduct(item.cdate) || self.isNewProduct(item.udate)) {
                                    // 1. 해당 상품 카테고리(2차)
                                    tempSet.add(String(item.typeNo));

                                    // 2. 부모 카테고리(1차)
                                    const typeInfo = allTypes.find(t => String(t.typeNo) === String(item.typeNo));
                                    if (typeInfo && typeInfo.typePart) {
                                        tempSet.add(String(typeInfo.typePart));
                                    }
                                }
                            });

                            self.newCategorySet = tempSet;
                            console.log("전체 상품 스캔 완료, NEW 카테고리:", Array.from(self.newCategorySet));
                        }
                    });
                },

            }, // methods
            watch: {
                category(newVal, oldVal) {
                    if (newVal !== oldVal) {
                        console.log('watch: Category 변경 감지. 이전:', oldVal, '-> 현재:', newVal);
                        this.page = 1;
                        this.fnList();
                    }
                },
                keyword(newVal, oldVal) {
                    if (newVal !== oldVal) {
                        console.log('watch: Keyword 변경 감지. 이전:', oldVal, '-> 현재:', newVal);
                        this.page = 1;
                        this.fnList();
                    }
                },
                page(newVal, oldVal) {
                    if (newVal !== oldVal) {
                        console.log('watch: Page 변경 감지. 이전:', oldVal, '-> 현재:', newVal);
                        this.fnList();
                    }
                },
                saleYN(newVal, oldVal) {
                    if (newVal !== oldVal) {
                        console.log('watch: SaleYN 변경 감지. 이전:', oldVal, '-> 현재:', newVal);
                        this.page = 1;
                        this.fnList();
                    }
                },
                orderType(newVal, oldVal) {
                    if (newVal !== oldVal) {
                        this.page = 1;
                        this.fnList();
                    }
                },
            },
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnImgList();
                self.fnReviewList();
                self.fnUserInfo();
                self.fnCheckAllNewCategories();

                // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkNewReplyCount(); // 새 답변 개수 체크
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }
                
                // 주기적으로 새 답변 체크 (30초마다)
                setInterval(function() {
                    if (self.sessionId && self.sessionId !== '') {
                        self.checkNewReplyCount();
                    }
                }, 30000);
            }
        });

        app.mount('#app');
    </script>