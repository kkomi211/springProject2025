<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <!-- <link rel="stylesheet" href="/css/jes.css"> -->
        <script src="/js/page-change.js"></script>
        <link rel="stylesheet" href="/css/home_product_category-style.css">
        <style>
            
        </style>
    </head>




    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <header>
                <div class="top-header">
                    <div class="brand-name">
                        <div><a href="/home.do">RUNNERS' HOUSE</a></div>
                    </div>
                    <div id="right-items">
                        <div>
                            <input type="text" placeholder="검색어를 입력해 주세요.">
                        </div>
                        <div>
                            <template v-if="sessionId != ''">
                                <a href="javascript:;" @click="fnLogout">로그아웃</a>
                            </template>
                            <template v-else>
                                <a href="/home/login.do">로그인</a>
                            </template>
                        </div>
                        <div v-if="sessionId == ''">
                            <a href="/home/signup.do">가입하기</a>
                        </div>
                        <div v-if="sessionId != ''"><a href="/home/mypage/information.do">마이페이지</a></div>
                        <div v-if="sessionId != ''"><a href="/home/cart.do">장바구니</a></div>
                    </div>
                </div>
                <div class="bottom-header">
                    <div>
                        <a href="javascript:;" @click="fnProduct">제품</a>
                    </div>
                    <div>
                        <a href="javascript:;" @click="fnSale">세일</a>
                    </div>
                    <div>
                        <a href="/home/community/board.do">커뮤니티</a>
                    </div>
                </div>
            </header>
            <div class="container">
                <main>
                    <div class="newcontent">
                        <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword">
                        <button class="height40 bluebutton" @click="fnList">검색</button>
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
                                    </div>

                                    <div class="subcategory-children" v-if="hoverParent === String(p.typeNo) || currentActiveParentNo === String(p.typeNo)">
                                        <div v-for="c in childrenByParent[String(p.typeNo)]" :key="c.typeNo"
                                            class="subcategory child"
                                            :class="{ active: String(c.typeNo) === category }"
                                            @click="selectCategory(c.typeNo)">
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
                        <main class="main-content">
                            <div class="main-container">
                                <div class="product-box" v-for="item in list" :key="item.productNo" @click="fnProductView(item.productNo)">
                                    <a :href="'/home/product-info.do?productNo=' + item.productNo">
                                        <div class="product-image-container">
                                            <img :src="imgByProduct[String(item.productNo)] || '/img/no-image.png'" class="small-img" :alt="item.productName">
                                        </div>
                                        <div class="product-info-text">
                                            <div class="brandText product-margin">{{item.brand}}</div>
                                            <div class="product-margin">{{item.productName}}</div>
                                            <p class="price product-margin" v-if="item.saleYN == 'N'">{{formatCurrency(item.price)}}</p>
                                            <p class="price product-margin" v-else><del>{{formatCurrency(item.price)}}</del> {{formatCurrency(item.salePrice)}}</p>
                                        </div>
                                        <div v-if="ratingByName[item.productName]" class="stars-review-area product-margin">
                                            <span v-for="n in 5" :key="n" class="star" :class="{ filled: n <= ratingByName[item.productName].rounded }">★</span>
                                            <span class="avg"> {{ ratingByName[item.productName].avg.toFixed(1) }}</span>
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
        </div>
    </body>

    </html>

    <script>
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
                    saleYN : "${saleYN}",
                    activeParentNo: null
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
                        saleYN : self.saleYN
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
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: "" });
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
                fnLogout : function(){
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/member/logout.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if(data.result == "success"){
                                location.href="/home.do";
                            }

                        }
                    })
                },
                fnSale(){
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                },
                fnNotice(){
                    let self = this;
                    pageChange("/home/community/board.do", {type : "B"});
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
                }
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
                }
            },
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnImgList();
                self.fnReviewList();
                self.fnUserInfo();
            }
        });

        app.mount('#app');
    </script>