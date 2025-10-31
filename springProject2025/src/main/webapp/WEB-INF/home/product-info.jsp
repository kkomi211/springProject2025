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
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
        <script src="/js/page-change.js"></script>
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
                            <div><a href="/home/mypage/inquiry.do">문의</a></div>
                            <div><a href="/home/cart.do">장바구니</a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <div>
                            <a href="javascript:;" @click="fnProduct">제품</a>
                        </div>
                        <div>
                            <a href="javascript:;" @click="fnProduct">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header>

                <main>
                    <div class="content">
                        <h1 class="margintop">제품 상세 </h1>
                        <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword">
                        <button class="height40 bluebutton" @click="fnProductSearch(keyword)">검색</button>
                        <hr>
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
                        <h1 class="margintop">제품 상세 </h1>
                        <div class="img-box"><img :src="imgByProduct[String(productNo)] || '/img/no-image.png'"
                                class="big-img" :alt="info.productName"></div>
                        <div class="infoText-box">
                            <div class="margin80">{{info.productName}}</div>
                            <div class="margin80 font30">{{info.price}} 원</div>
                            <div class="font30 margin30">
                                <!-- 사이즈 -->
                                <select class="select-box" v-model="size" @change="fnMaxQuantityChange"> 
                                    <option v-for="item in sizeList" :value="item.productSize">사이즈 :
                                        {{item.productSize}} 재고 : {{item.quantity}}
                                    </option>
                                </select>
                            </div>
                            <div>
                                <button class="bluebutton height40" @click="fnQuantity(-1)">-</button>
                                <input class="height40" v-model="quantity" disabled>
                                <button class="bluebutton height40" @click="fnQuantity(1)">+</button>
                            </div>

                            <div class="margin30">
                                <button class="bluebutton margin30 height40" @click="fnCart">장바구니</button>
                                <button class="bluebutton margin30 height40">결제하기</button>
                            </div>
                        </div>
                        <div class="detail-box">{{info.productDetail}}</div>
                        <div class="container-foot">
                            <div class="foot-box cursor" @click="status = 1" :class="{active: status == 1} ">상품문의</div>
                            <div class="foot-box cursor" @click="status = 2" :class="{active: status == 2} ">상품리뷰</div>
                            <div v-if="status == 1">
                                <div class="inquirySearch-box">
                                    <input class="search" v-model="inquiryKeyword">
                                    <button class="bluebutton height40 margin30" @click="fnInquiry">검색</button>
                                    <button class="bluebutton height40 margin30"
                                        @click="fnProductInquiryAdd(productNo)">작성하기</button>
                                </div>
                                <div class="table margintop100">
                                    <table>
                                        <tr>
                                            <th>문의 제목</th>
                                            <th>답변 상태</th>
                                        </tr>
                                        <tr v-for="item in inquiryList">
                                            <td class="longTd" @click="openInquiry(item)">
                                                <span class="cursor">{{item.title}}</span>
                                                <span class="material-symbols-outlined"
                                                    v-if="item.pwd != undefined && item.pwd != null">key</span>
                                            </td>
                                            <td class="shortTd">{{item.status}}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="clear text-center margin30">
                                    <span class="margin30 font30 cursor" :class="{bold: inquiryPage == num}"
                                        v-for="num in inquiryTotalPage" @click="fnInquiryPage(num)">{{num}}</span>
                                </div>
                            </div>
                            <div v-if="status == 2">
                                <div class="inquirySearch-box">
                                    <span class="margin30 cursor" :class="{bold: reviewArray == 1}"
                                        @click="fnReviewArray(1)">도움돼요순</span>
                                    <span class="margin30 cursor" :class="{bold: reviewArray == 2}"
                                        @click="fnReviewArray(2)">최신순</span>
                                    <input class="search" v-model="reviewKeyword">
                                    <button class="bluebutton height40" @click="fnReviewList">검색</button>
                                </div>
                                <div class="table margintop100">
                                    <table v-for="item in reviewList">
                                        <tr>
                                            <th>유저</th>
                                            <td>{{item.userId}}</td>
                                        </tr>
                                        <tr>
                                            <th>리뷰날짜</th>
                                            <td>{{item.cdate}}</td>
                                        </tr>
                                        <tr>
                                            <th>도움돼요 수</th>
                                            <td>{{item.helpfulCnt}}
                                                <span class="material-symbols-outlined heart"
                                                    @click="fnHeartUp(item.reviewNo)">
                                                    heart_plus
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰 제목</th>
                                            <td><span class="cursor">{{item.title}}</span></td>
                                        </tr>
                                        <tr>
                                            <th>별점</th>
                                            <td>{{item.rating}}</td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td>{{item.content}}</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="clear text-center margin30">
                                    <span class="margin30 font30 cursor" :class="{bold: reviewPage == num}"
                                        v-for="num in reviewTotalPage" @click="fnReviewPage(num)">{{num}}</span>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- 문의 상세 모달 -->
                    <div v-if="showInquiryModal" class="modal-backdrop" @click.self="closeInquiry">
                        <div class="modal-card">
                            <!-- 잠금 글: 비밀번호 확인 화면 -->
                            <div v-if="needPwd && !authorized">
                                <h3 class="modal-title">비공개 문의</h3>
                                <p class="modal-desc">비밀번호를 입력하세요.</p>
                                <input type="password" v-model="pwdInput" class="modal-input" placeholder="비밀번호"
                                    @keyup.enter="confirmPwd">
                                <div class="modal-actions">
                                    <button class="bluebutton height40" @click="confirmPwd"
                                        :disabled="loading">확인</button>
                                    <button class="height40" @click="closeInquiry">취소</button>
                                </div>
                                <div class="error" v-if="pwdError">{{ pwdError }}</div>
                            </div>

                            <!-- 상세 내용 화면 -->
                            <div v-else>
                                <h3 class="modal-title">{{ inquiryDetail.title }}</h3>
                                <div class="meta">
                                    <span>작성자: {{ inquiryDetail.userId }}</span>
                                    <span>작성일: {{ inquiryDetail.cdate }}</span>
                                    <span>상태: {{ inquiryDetail.status }}</span>
                                    <span v-if="inquiryDetail.answer != null && inquiryDetail.answer != undefined">답변내용:
                                        {{ inquiryDetail.status }}</span>
                                </div>
                                <div class="modal-content" v-html="inquiryDetail.content"></div>
                                <div v-if="inquiryDetail.status == 'Y'">
                                    <br><br>
                                    <div class="modal-content" v-html="inquiryDetail.answer"></div>
                                </div>
                                <div class="modal-actions">
                                    <button class="height40" @click="closeInquiry">닫기</button>
                                </div>
                            </div>
                        </div>
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
                    hoverParent: null,
                    productNo: "${productNo}",
                    category: "",
                    keyword: "",
                    info: {},
                    sizeList: [],
                    rating: "${rating}",
                    status: 1,
                    inquiryList: [],
                    inquiryPage: 1,
                    inquiryPageSize: 6,
                    inquiryTotalPage: 0,
                    showInquiryModal: false,
                    inquiryDetail: {},
                    targetInquiryNo: null,
                    needPwd: false,
                    authorized: false,
                    pwdInput: "",
                    pwdError: "",
                    loading: false,
                    reviewArray: 1,
                    reviewPage: 1,
                    reviewPageSize: 2,
                    reviewTotalPage: 0,
                    reviewKeyword: "",
                    inquiryKeyword: "",
                    quantity: 1,
                    size: "",
                    maxQuantity: 1,
                    sessionId : "${sessionId}"
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
                            self.size = data.sizeList[0].productSize;
                            self.maxQuantity = data.sizeList[0].quantity;
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
                    let param = {
                        productNo: self.productNo,
                        page: (self.reviewPage - 1) * self.reviewPageSize,
                        pageSize: self.reviewPageSize,
                        reviewArray: self.reviewArray,
                        keyword: self.reviewKeyword
                    };
                    $.ajax({
                        url: "/product/review/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.reviewList = data.reviewList;
                            self.reviewTotalPage = Math.ceil(data.cnt / self.reviewPageSize);
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
                fnInquiry() {
                    let self = this;
                    let param = {
                        productNo: self.productNo,
                        page: (self.inquiryPage - 1) * self.inquiryPageSize,
                        pageSize: self.inquiryPageSize,
                        keyword: self.inquiryKeyword
                    };
                    $.ajax({
                        url: "/product/inquiry/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.inquiryList = data.inquiryList;
                            self.inquiryTotalPage = Math.ceil(data.inquiryTotal / self.inquiryPageSize);
                        }
                    });
                },
                openInquiry(item) {
                    this.targetInquiryNo = item.inquiryNo;
                    this.pwdInput = "";
                    this.pwdError = "";
                    this.authorized = false;

                    // pwd 유무로 분기 (널/빈문자 모두 잠금으로 처리)
                    this.needPwd = (item.pwd !== undefined && item.pwd !== null && String(item.pwd).trim() !== "");
                    this.showInquiryModal = true;

                    if (!this.needPwd) {
                        // 공개 글: 바로 상세 호출
                        this.fetchInquiryDetail(null);
                    }
                },

                closeInquiry() {
                    this.showInquiryModal = false;
                    this.inquiryDetail = {};
                    this.targetInquiryNo = null;
                    this.needPwd = false;
                    this.authorized = false;
                    this.pwdInput = "";
                    this.pwdError = "";
                },

                confirmPwd() {
                    if (!this.pwdInput) {
                        this.pwdError = "비밀번호를 입력하세요.";
                        return;
                    }
                    this.fetchInquiryDetail(this.pwdInput);
                },

                fetchInquiryDetail(pwd) {
                    const self = this;
                    self.loading = true;
                    $.ajax({
                        url: "/product/inquiry/view.dox",
                        type: "POST",
                        dataType: "json",
                        data: {
                            inquiryNo: self.targetInquiryNo,
                            pwd: pwd || null     // 공개글이면 빈값
                        },
                        success: function (res) {
                            self.loading = false;
                            // 서버 응답 예시 가정:
                            // { success: true, inquiry: { title, content, userId, cdate, status } }
                            // { success: false, code: 'BAD_PWD', message: '비밀번호가 일치하지 않습니다.' }
                            if (res.success == "true") {
                                self.inquiryDetail = res.inquiry || {};
                                self.authorized = true;   // 잠금 글도 통과됨
                                self.pwdError = "";
                            } else {
                                if (res.code === "BAD_PWD") {
                                    self.pwdError = "비밀번호가 일치하지 않습니다.";
                                } else if (res && res.code === 'LOCKED') {
                                    self.pwdError = "비밀번호가 필요한 게시글입니다.";
                                } else {
                                    self.pwdError = "조회 중 오류가 발생했습니다.";
                                }
                            }
                        },
                        error: function () {
                            self.loading = false;
                            self.pwdError = "네트워크 오류가 발생했습니다.";
                        }
                    });
                },
                fnReviewPage(num) {
                    let self = this;
                    self.reviewPage = num;
                    self.fnReviewList();
                },
                fnInquiryPage(num) {
                    let self = this;
                    self.inquiryPage = num;
                    self.fnInquiry();
                },
                fnReviewArray(num) {
                    let self = this;
                    self.reviewArray = num;
                    self.fnReviewList();
                },
                fnHeartUp(reviewNo) {
                    let self = this;
                    let param = {
                        reviewNo: reviewNo
                    };
                    $.ajax({
                        url: "/product/review/1up.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.fnReviewList();
                        }
                    });
                },
                fnCategoryProduct(category) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: category, sessionId : self.sessionId });
                },
                fnProduct() {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: "", sessionId : self.sessionId });
                },
                fnProductSearch(key) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: key, category: "", sessionId : self.sessionId });
                },
                fnProductInquiryAdd(proNo) {
                    let self = this;
                    pageChange("/home/product/inquiry/add.do", { productNo: proNo, sessionId : self.sessionId });
                },
                fnCart() {
                    let self = this;
                    let param = {
                        productNo: self.productNo,
                        size: self.size,
                        userId: self.sessionId,
                        quantity: self.quantity
                    };
                    $.ajax({
                        url: "/product/cart/insert.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if(confirm("장바구니로 이동하시겠습니까?")){
                                pageChange("/home/cart.do", {sessionId : self.sessionId});
                            } else {
                                self.fnProduct();
                            }
                            
                        }
                    });
                },
                fnQuantity(num) {
                    let self = this;
                    if (self.quantity + num <= 0 || self.quantity + num > self.maxQuantity) {
                        return;
                    }
                    self.quantity = self.quantity + num;
                },
                fnMaxQuantityChange() {
                    const found = this.sizeList.find(
                        s => String(s.productSize) === String(this.size)
                    );
                    this.maxQuantity = found ? Number(found.quantity) : 0;
                }


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnInfo();
                self.fnImgList();
                self.fnReviewList();
                self.fnInquiry();
            }
        });

        app.mount('#app');
    </script>