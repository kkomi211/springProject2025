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
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
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
                        <h1 class="margintop">제품 문의 작성 </h1>
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
                        <h1>제품 문의 작성 </h1>
                        <div class="img-box"><img :src="imgByProduct[String(productNo)] || '/img/no-image.png'"
                                class="big-img" :alt="info.productName"></div>
                        <div class="infoText-box">
                            <div class="margin80 font20">상품명 : {{info.productName}}</div>
                            <div class="margin80 font20">브랜드 : {{info.brand}}</div>
                            <div class="margin80 font20">가격 : {{info.price}} 원</div>

                        </div>
                        <div class="container-foot">
                            <div class="editor-box">
                                <div class="margin30 fontGray">문의 제목</div>
                                <div><input v-model="title"></div>
                                <div class="margin30 fontGray">잠금 설정</div>
                                <div><input v-model="pwd" placeholder="값을 입력하면 글이 잠깁니다"></div>
                                <div class="margin30 fontGray">문의 내용</div>
                                <div id="editor"></div>
                                <div class="text-right">
                                    <button class="bluebutton height40 margin30" @click="fnBack">돌아가기</button>
                                    <button class="redbutton height40 margin30" @click="fnAddInquiry">작성하기</button>
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
                    title: "",
                    content: "",
                    pwd: "",
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
                fnBack(){
                    let self = this;
                    pageChange("/home/product-info.do", {productNo : self.productNo, sessionId : self.sessionId});
                },
                fnAddInquiry(){
                    let self = this;
                    if(self.title == ""){
                        alert("제목이 비어있습니다!");
                        return;
                    }
                    if(self.content == ""){
                        alert("내용이 비어있습니다!");
                        return;
                    }
                    let param = {
                        productNo : self.productNo,
                        title : self.title,
                        content : self.content,
                        userId : self.sessionId,
                        pwd : self.pwd
                    };
                    $.ajax({
                        url: "/product/inquiry/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            alert("작성 완료!");
                            self.fnBack();
                        }
                    });
                }



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
            }
        });

        app.mount('#app');
    </script>