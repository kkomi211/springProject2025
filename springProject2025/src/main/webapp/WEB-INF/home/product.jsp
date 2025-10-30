<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/jes.css">
        <script src="/js/page-change.js"></script>
        <style>

        </style>
    </head>


    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/jes.css">
        <style>

        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
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
                                <a href="/home/login.do">로그인</a>
                            </div>
                            <div>
                                <a href="/home/signup.do">가입하기</a>
                            </div>
                            <div><a href="/home/mypage/inquery.do">문의</a></div>
                            <div><a href="/home/cart.do">장바구니</a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <div>
                            <a href="/home/product.do">제품</a>
                        </div>
                        <div>
                            <a href="/home/product.do">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header>

                <main>
                    <div class="content">
                        <h1 class="margintop">제품</h1>
                        <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword">
                        <button class="height40 bluebutton" @click="fnList">검색</button>
                        <hr>
                    </div>
                    <div class="side-bar">
                        <div class="category-box">
                            <div class="category">카테고리</div>
                            <div class="subcategory" :class="{active: category == ''}" @click="selectCategory('')">전체</div>
                            <div v-for="p in parents" :key="p.typeNo" class="subcategory-wrapper"
                                @mouseenter="hoverParent = String(p.typeNo)" @mouseleave="hoverParent = null">
                                <div class="subcategory"
                                    :class="{active: category === p.typeNo || category === p.typePart}" @click="selectCategory(p.typeNo)">
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
                    <div class="main-container">
                        <span v-for="item in list" class="product-box" @click="fnProductView(item.productNo)">
                            <div><img :src="imgByProduct[String(item.productNo)] || '/img/no-image.png'"
                                    class="small-img" :alt="item.productName"></div>
                            <div>{{item.productName}}</div>
                            <div>{{item.price}} 원</div>
                            <div v-if="ratingByName[item.productName]" class="stars">
                                <span v-for="n in 5" :key="n" class="star"
                                    :class="{ filled: n <= ratingByName[item.productName].rounded }">★</span>
                                <span class="avg"> {{ ratingByName[item.productName].avg.toFixed(1) }}</span>
                                <span class="cnt"> ({{ ratingByName[item.productName].cnt }})</span>
                            </div>
                            <div v-else class="no-review">리뷰 없음</div>
                        </span>
                    </div>
                    <div class="clear text-center">
                        <span class="margin30 font30" :class="{bold: page == num}" v-for="num in totalPage"
                            @click="fnPage(num)">{{num}}</span>
                    </div>
                </main>

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
                            <span>회사소개</span>
                            <span>매장안내</span>
                            <span>공지사항</span>
                            <span>이용약관</span>
                            <span>개인정보처리방침</span>
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
                    keyword: "",
                    category: "",
                    hoverParent: null
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
                        category: self.category
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
                selectCategory(typeNo) {
                    let self = this;
                    self.category = typeNo;
                    console.log(" == > " + self.category);
                    
                    self.fnList();
                },
                fnProductView(productNo, rating){
                    pageChange("/home/product-info.do", {productNo : productNo});
                }
                
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnImgList();
                self.fnReviewList();
            }
        });

        app.mount('#app');
    </script>