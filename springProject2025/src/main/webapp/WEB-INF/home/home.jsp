<%-- src/main/webapp/WEB-INF/home/home.jsp --%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>RUNNERS HOUSE</title>
            <!-- jQuery, Vue.js, Font Awesome (아이콘용) -->
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
            <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

            <!-- Swiper.js CDN -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
            <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

            <!-- 사용자 정의 스타일시트 -->
            <link rel="stylesheet" href="/css/style.css">
            <link rel="stylesheet" href="/css/home.css">

            <!-- Google Fonts (Fugaz One) -->
            <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">

             <!-- Google Fonts (Jost)  -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

            <!-- Icons -->
            <script src="https://unpkg.com/lucide@latest"></script>

            <!-- ApexCharts for budget recommendation chart -->
            <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.44.0/dist/apexcharts.min.js"></script>

            <script src="/js/page-change.js"></script>

            <!-- 최근 본 상품 컴포넌트 스크립트 -->
            <script src="/js/recent-products.js"></script>
            
            <!-- 위젯 위치 동적 조정 스크립트 -->
            <script src="/js/widget-position.js"></script>
        </head>

        <body>
            <div id="app">
                <%-- 공통 헤더 컴포넌트 --%>
                <jsp:include page="/WEB-INF/header/header.jsp" />
                <div class="container">
                    <main>
                        <!-- 메인 슬라이드 배너 -->
                        <div class="main-hero-slider-area">
                            <section class="main-hero-slider">
                                <div class="swiper-container mySwiper">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" v-for="slide in mainSlideImages"
                                            :key="slide.BANNER_ID">
                                            <a :href="slide.linkUrl">
                                                <img :src="slide.imageDir" :alt="slide.title">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="swiper-pagination"></div>
                                </div>
                            </section>
                        </div>


                        <!-- 추천 상품 영역 -->
                        <section class="products-showcase">
                            <h2>추천 상품</h2>
                            <div class="products-main-content-wrapper"> <!-- ASICS 스타일을 위한 새로운 래퍼 추가 -->

                                <!-- 왼쪽 고정 이미지 및 소개 영역 -->
                                <div class="fixed-image-area">
                                    <a href="/home/product-info.do?productNo=282">
                                        <img src="/img/productmain.jpg">
                                        <div class="image-text-overlay">
                                            <h3>GEL-CUMULUS 16</h3>
                                            <p>혁신적인 쿠셔닝과 최적의 안정성을 자랑합니다. <br>매일의 러닝에 최적화된 편안함.</p>
                                        </div>
                                    </a>
                                </div>

                                <!-- 오른쪽에 상품 4개 그리드 -->
                                <div class="recommended-products-grid">
                                    <div class="product-card" v-for="product in recommendedProducts"
                                        :key="product.productNo">
                                        <a :href="'/home/product-info.do?productNo=' + product.productNo">
                                            <div class="product-image-container"> <!-- 이미지 컨테이너 추가 -->
                                                <img :src="product.imgPath" :alt="product.productName">
                                            </div>
                                            <div class="product-info-text"> <!-- 텍스트 정보 컨테이너 추가 -->
                                                <h4>{{ product.brand }}</h4>
                                                <h3>{{ product.productName }}</h3>
                                                <p class="product-price" v-if="product.saleYN == 'N'">{{ formatCurrency(product.productPrice) }}</p>
                                                <p class="product-price" v-else><del>{{ formatCurrency(product.productPrice) }}</del> {{formatCurrency(product.salePrice)}}</p>
                                            </div>
                                        </a>
                                    </div>
                                    <p v-if="recommendedProducts.length === 0" class="no-products-message">추천 상품이 없습니다.
                                    </p>
                                </div>
                            </div>
                        </section>

                        <!-- 최신 대회 영역 -->
                        <section class="rally-showcase">
                            <h2>대회 정보</h2>
                            <div class="swiper-container rallySwiper">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide" v-for="rally in latestRallies" :key="rally.rallyNo">
                                        <a :href="'/home/community/rally.do'">
                                            <img :src="rally.imgPath" :alt="rally.rallyName">
                                            <div class="rally-info-text"> <!-- 텍스트 정보를 감싸는 div 추가 -->
                                                <h3>{{ rally.rallyName }}</h3>
                                                <h3>대회 일자 : {{ formatDate(rally.rallyDate) }}</h3>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- Swiper 페이지네이션은 ASICS Shop By Sports에서 잘 보이지 않으므로 주석 처리된 상태로 둡니다. -->
                                <!-- <div class="swiper-pagination"></div> -->
                                <div class="swiper-button-next"></div>
                                <div class="swiper-button-prev"></div>
                            </div>
                        </section>

                        <!-- 크루 가입 영역 -->
                         <a href="/home/community/crew.do" style="display: block;">
                        <section class="crew-join-section">
                            <div class="crew-images-wrapper">
                                <div class="crew-image-container"> <!-- 이미지 두 개를 담는 컨테이너 -->
                                    <div class="crew-image-item" style="width: 100%; overflow: hidden;">
                                        <!-- <a href="/home/community/crew.do" style="display: block;"> -->
                                            <img 
                                            src="/img/crew_join_banner3.jpg"
                                            alt="크루 가입 배너 1"
                                            style="width: 100%; height: auto; display: block; border-radius: 10px; object-fit: contain;">
                                        <!-- </a> -->
                                    </div>
                                </div>
                                <span class="crew-overlay-text">JOIN A CREW</span> <!-- 텍스트는 항상 보임, 중앙 위치 -->
                            </div>
                        </section>
                        </a>
                        <!-- <section class="crew-join-section">
                            <div class="crew-images-wrapper">
                                <div class="crew-image-container"> 이미지 두 개를 담는 컨테이너
                                    <div class="crew-image-item">
                                        <a href="/home/community/crew.do"> 각 이미지가 자체 링크를 가짐
                                            <img src="/img/crew_join_banner.jpg" alt="크루 가입 배너 1">
                                        </a>
                                    </div>
                                    <div class="crew-image-item">
                                        <a href="/home/community/crew.do"> 각 이미지가 자체 링크를 가짐
                                            <img src="/img/crew_join_banner2.jpg" alt="크루 가입 배너 2">
                                        </a>
                                    </div>
                                </div>
                                <a href="/home/community/crew.do">
                                    <span class="crew-overlay-text">JOIN A CREW</span> 텍스트는 항상 보임, 중앙 위치
                                </a>    
                            </div>
                        </section> -->

                    </main>
                </div>

                <!-- 예산 추천 고정 버튼 -->
                <!--251117-->
                <button class="budget-recommend-btn" @click="openBudgetModal" title="예산 기반 상품 추천">
                    <span>예산 기반<br>상품 추천 받기</span>
                </button>

                <!-- 예산 추천 모달 -->
                <div id="budgetModal" class="budget-modal" v-if="showBudgetModal" @click.self="closeBudgetModal" style="display: block;">
                    <div class="budget-modal-content">
                        <span class="budget-modal-close" @click="closeBudgetModal">&times;</span>
                        <div class="budget-input-section">
                            <h2>예산 기반 상품 추천</h2>
                            <div class="budget-input-wrapper">
                                <input type="number" v-model="budgetAmount" placeholder="예산을 입력하세요 (원)" min="0" @keyup.enter="searchBudgetProducts">
                                <button @click="searchBudgetProducts">추천받기</button>
                            </div>
                        </div>
                        <div v-if="budgetRecommendations.length > 0" class="budget-chart-section">
                            <div class="budget-chart-container">
                                <div id="budgetChart"></div>
                            </div>
                            <div class="budget-category-bars">
                                <div v-for="(category, index) in budgetRecommendations" :key="index" class="budget-category-bar">
                                    <div class="budget-bar-info">
                                        <span class="budget-bar-label">{{ category.categoryName }}</span>
                                        <span class="budget-bar-value">
                                            {{ (category.adjustedPrice !== undefined ? category.adjustedPrice : (category.totalPrice || 0)).toLocaleString() }}원 
                                            ({{ (category.adjustedPercentage !== undefined ? category.adjustedPercentage : (category.percentage || 0)).toFixed(1) }}%)
                                        </span>
                                    </div>
                                    <div class="budget-bar-progress" 
                                         @mousedown="startDrag($event, index)"
                                         @touchstart="startDrag($event, index)">
                                        <div class="budget-bar-fill" 
                                             :class="'category-' + index"
                                             :style="{ width: (category.adjustedPercentage !== undefined ? category.adjustedPercentage : (category.percentage || 0)) + '%' }">
                                            <span style="margin-right: 15px;">
                                                {{ (category.adjustedPrice !== undefined ? category.adjustedPrice : (category.totalPrice || 0)).toLocaleString() }}원
                                            </span>
                                            <div class="budget-bar-handle"></div>
                                        </div>
                                    </div>
                                    <div class="budget-recommended-products" v-if="category.products && category.products.length > 0">
                                        <h4>추천 상품</h4>
                                        <div v-for="product in category.products" :key="product.productNo" 
                                             class="budget-product-item" 
                                             @click="goToProduct(product.productNo)">
                                            <img :src="product.imgPath || '/img/no-image.jpg'" :alt="product.productName" @error="handleImageError($event)">
                                            <div class="budget-product-info">
                                                <div class="product-name">{{ product.productName }}</div>
                                                <div class="product-price">{{ formatCurrency(product.finalPrice) }}</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div v-else class="budget-no-products">예산 내 추천 상품이 없습니다.</div>
                                </div>
                            </div>
                            <div style="text-align: center; margin-top: 20px;">
                                <button class="budget-recommend-btn-update" @click="updateRecommendationsByRatio">비율 조정 후 다시 추천받기</button>
                            </div>
                        </div>
                        <div v-else-if="budgetSearched && budgetRecommendations.length === 0" style="text-align: center; padding: 40px; color: #999;">
                            예산 내에서 추천할 수 있는 상품이 없습니다. 예산을 늘려서 다시 시도해주세요.
                        </div>
                        <div v-else style="text-align: center; padding: 40px; color: #999;">
                            예산을 입력하고 추천받기를 클릭해주세요.
                        </div>
                    </div>
                </div>

                <!-- 최근 본 상품 컴포넌트 -->
                <div id="recent-products-widget"></div>

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
            lucide.createIcons();
            const app = Vue.createApp({
                data() {
                    return {
                        mainSlideImages: [],
                        recommendedProducts: [],
                        latestRallies: [],
                        sessionId: '${sessionId}',
                        isLoggedOut: false,
                        userType: '${userType}',
                        //251117
                        showBudgetModal: false,
                        budgetAmount: '',
                        budgetRecommendations: [],
                        budgetSearched: false,
                        budgetChart: null,
                        isDragging: false,
                        dragIndex: -1,
                        originalBudget: 0,
                        dragHandlersInitialized: false,
                        updateChartTimer: null,
                        dragUpdateTimer: null,
                        cartCount: 0, // 장바구니 수량 변수 추가
                        newReplyCount: 0, // 새 답변 개수
                    };
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

                    // (이전과 동일한 fetchMainSlideImages, fetchRecommendedProducts, fetchLatestRallies, initMainSwiper, initRallySwiper)
                    fetchMainSlideImages() {
                        let self = this;
                        $.ajax({
                            url: '/api/mainSlideImages.dox',
                            method: 'GET',
                            dataType: 'json',
                            success: (response) => {
                                if (response.result === 'success') {
                                    self.mainSlideImages = response.data;
                                    self.$nextTick(() => { self.initMainSwiper(); });
                                } else { console.error("메인 슬라이드 이미지 로드 실패:", response.message); }
                            },
                            error: (error) => { console.error("메인 슬라이드 AJAX 오류:", error); }
                        });
                    },
                    fetchRecommendedProducts() {
                        let self = this;
                        $.ajax({
                            url: '/api/recommendedProducts.dox',
                            method: 'GET',
                            dataType: 'json',
                            data: { limit: 4 },
                            success: (response) => {
                                console.log("Recommended Products Data (from backend):", response.data);
                                if (response.result === 'success') {
                                    self.recommendedProducts = response.data.slice(0, 4);
                                    console.log("Recommended Products Data (after slice, assigned to Vue):", self.recommendedProducts);
                                } else { console.error("추천 상품 로드 실패:", response.message); }
                            },
                            error: (error) => { console.error("추천 상품 AJAX 오류:", error); }
                        });
                    },
                    fetchLatestRallies() {
                        let self = this;
                        $.ajax({
                            url: '/api/latestRallies.dox',
                            method: 'GET',
                            dataType: 'json',
                            data: { limit: 8 },
                            success: (response) => {
                                console.log("Latest Rallies Data:", response.data);
                                if (response.result === 'success') {
                                    self.latestRallies = response.data;
                                    this.$nextTick(() => {
                                        self.initRallySwiper();
                                    });
                                } else {
                                    console.error("최신 대회 로드 실패:", response.message);
                                }
                            },
                            error: (error) => {
                                console.error("최신 대회 AJAX 오류:", error);
                            }
                        });
                    },
                    initMainSwiper() {
                        if (this.mainSlideImages.length > 0) {
                            if (this.mainSwiperInstance) {
                                this.mainSwiperInstance.destroy(true, true);
                            }

                            const swiperEl = document.querySelector('.mySwiper');
                            if (!swiperEl) {
                                console.error("Swiper container '.mySwiper' not found.");
                                return;
                            }

                            this.mainSwiperInstance = new Swiper(swiperEl, {
                                loop: true, // 무한 루프
                                autoplay: {
                                    delay: 3000,
                                    disableOnInteraction: false,
                                },
                                pagination: {
                                    el: '.swiper-pagination',
                                    clickable: true,
                                },
                                slidesPerView: 1,           // 한 번에 하나의 슬라이드 표시
                                spaceBetween: 0,
                                centeredSlides: false,
                                slidesPerGroup: 1,
                                watchOverflow: true,
                                observer: true,
                                observeParents: true,
                                preventInteractionOnTransition: true,
                                // on: {} /* 디버깅 로그는 필요 시에만 추가 */
                            });
                        }
                    },
                    initRallySwiper() {
                        if (this.latestRallies.length > 0) {
                            // ... (기존 로그 및 인스턴스 파괴 로직 유지) ...

                            const swiperEl = document.querySelector('.rallySwiper');
                            if (!swiperEl) {
                                console.error("Rally Swiper container '.rallySwiper' not found.");
                                return;
                            }

                            this.rallySwiperInstance = new Swiper(swiperEl, {
                                loop: true, // ASICS처럼 끊김 없는 슬라이딩을 위해 true로 변경
                                // 5개 데이터와 slidesPerView: 4 라면, 이제 loop 경고가 사라지거나 덜해질 것입니다.
                                autoplay: {
                                    delay: 3000,
                                    disableOnInteraction: false,
                                },
                                navigation: { // 네비게이션 활성화
                                    nextEl: '.swiper-button-next',
                                    prevEl: '.swiper-button-prev',
                                },

                                // ★★★ 기본값 설정 (가장 큰 화면에서 3개 보임) ★★★
                                slidesPerView: 3,
                                spaceBetween: 30,      // 슬라이드 간 간격

                                centeredSlides: false,
                                slidesPerGroup: 1,
                                watchOverflow: true,
                                observer: true,
                                observeParents: true,
                                preventInteractionOnTransition: true,

                                // ★★★ 반응형 설정 (최소 화면 너비 기준) ★★★
                                breakpoints: {
                                    0: { // 가장 작은 화면 (모바일)
                                        slidesPerView: 1,
                                        slidesPerGroup: 1, // 한 번에 하나씩 이동
                                        spaceBetween: 15,
                                    },
                                    480: { // 스마트폰 가로
                                        slidesPerView: 2,
                                        slidesPerGroup: 1, // 한 번에 하나씩 이동
                                        spaceBetween: 20,
                                    },
                                    768: { // 태블릿
                                        slidesPerView: 2, // 태블릿에서는 2개 유지 (3개는 너무 작아질 수 있음)
                                        slidesPerGroup: 1, // 한 번에 하나씩 이동
                                        spaceBetween: 25,
                                    },
                                    1024: { // 데스크탑 (1024px 이상일 때 3개 보임)
                                        slidesPerView: 3,
                                        slidesPerGroup: 1, // 한 번에 하나씩 이동
                                        spaceBetween: 30, // 1024px 이상에서는 spaceBetween 30px 적용
                                    }
                                }
                            });
                        } else {
                            console.warn("Rally Swiper: No rally data available to initialize Swiper.");
                        }
                    },
                    formatDate(dateString) { // 날짜 형식 포맷 함수
                        if (!dateString) return '';
                        const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
                        return new Date(dateString).toLocaleDateString('ko-KR', options);
                    },
                    //251117
                    handleImageError(event) {
                        // 이미지 로딩 실패 시 기본 이미지로 변경 (무한 루프 방지)
                        if (event.target.src && !event.target.src.includes('no-image.jpg')) {
                            event.target.src = '/img/no-image.jpg';
                        }
                    },
                    formatCurrency(value) { // 통화 형식 포맷 함수
                        if (value === null || value === undefined) return '0 원';
                        return value.toLocaleString('ko-KR') + ' 원';
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
                                    location.href = "home.do";
                                }
                            }
                        });

                    },
                    initRallySwiper() {
                        if (this.latestRallies.length > 0) {
                            console.log('Number of rally slides:', this.latestRallies.length);
                            new Swiper('.rallySwiper', {
                                slidesPerView: 1, spaceBetween: 10, loop: false, slidesPerGroup: 1,
                                navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev', },
                                breakpoints: { 640: { slidesPerView: 2, spaceBetween: 20, slidesPerGroup: 1, }, 1024: { slidesPerView: 3, spaceBetween: 30, slidesPerGroup: 1, }, },
                            });
                        }
                    },

                    fnKakao: function () {
                        let self = this;
                        let param = {
                            code: self.code
                        };
                        $.ajax({
                            url: "/kakao.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success: function (data) {
                                console.log(data);
                                if (data.properties && data.properties.nickname) {
                                    self.sessionName = data.properties.nickname;
                                }

                                // ✅ Remove the ?code=... from the URL (no reload)
                                window.history.replaceState({}, document.title, '/home.do');
                                // ✅ Then reload the page so Vue picks up the session
                                location.reload();
                            }
                        });
                    },
                    fnNotice() {
                        let self = this;
                        pageChange("/home/community/board.do", { type: "B" });
                    },
                    fnSale() {
                        let self = this;
                        self.saleYN = 'Y';
                        pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN });
                    },
                    //251117
                    openBudgetModal() {
                        this.showBudgetModal = true;
                        this.$nextTick(() => {
                            lucide.createIcons();
                        });
                    },
                    //251117
                    closeBudgetModal() {
                        this.showBudgetModal = false;
                        this.budgetRecommendations = [];
                        this.budgetSearched = false;
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            this.budgetChart = null;
                            const chartElement = document.getElementById('budgetChart');
                            if (chartElement) {
                                chartElement.innerHTML = '';
                            }
                        }
                    },
                    searchBudgetProducts() {
                        if (!this.budgetAmount || this.budgetAmount <= 0) {
                            alert('올바른 예산을 입력해주세요.');
                            return;
                        }

                        let self = this;
                        $.ajax({
                            url: '/api/budgetRecommendations.dox',
                            method: 'POST',
                            dataType: 'json',
                            data: { budget: parseInt(this.budgetAmount) },
                            success: (response) => {
                                if (response.result === 'success' && response.data && Array.isArray(response.data)) {
                                    // adjustedPrice와 adjustedPercentage 초기화
                                    self.budgetRecommendations = response.data.map((cat, idx) => {
                                        // 모든 가능한 키 이름 확인
                                        const categoryName = cat.categoryName || cat['categoryName'] || '';
                                        const totalPrice = cat.totalPrice !== undefined && cat.totalPrice !== null 
                                            ? Number(cat.totalPrice) 
                                            : (cat['totalPrice'] !== undefined && cat['totalPrice'] !== null ? Number(cat['totalPrice']) : 0);
                                        const percentage = cat.percentage !== undefined && cat.percentage !== null 
                                            ? Number(cat.percentage) 
                                            : (cat['percentage'] !== undefined && cat['percentage'] !== null ? Number(cat['percentage']) : 0);
                                        const products = Array.isArray(cat.products) ? cat.products : (Array.isArray(cat['products']) ? cat['products'] : []);
                                        
                                        return {
                                            categoryName: categoryName,
                                            totalPrice: totalPrice,
                                            percentage: percentage,
                                            products: products,
                                            adjustedPrice: totalPrice,
                                            adjustedPercentage: percentage
                                        };
                                    });
                                    
                                    self.originalBudget = parseInt(self.budgetAmount);
                                    self.budgetSearched = true;
                                    self.$nextTick(() => {
                                        self.drawDonutChart(); // 도넛 차트 초기 생성
                                        self.initDragHandlers();
                                    });
                                } else {
                                    console.error('응답 데이터 형식 오류:', response);
                                    alert('추천 상품을 불러오는 중 오류가 발생했습니다: ' + (response.message || '데이터 형식 오류'));
                                }
                            },
                            error: (error) => {
                                console.error("예산 추천 AJAX 오류:", error);
                                alert('추천 상품을 불러오는 중 오류가 발생했습니다.');
                            }
                        });
                    },
                    //251117 - (사용 안 함, drawDonutChart로 대체됨)
                    drawBudgetChart_OLD() {
                        if (this.budgetRecommendations.length === 0) return;

                        const chartElement = document.getElementById('budgetChart');
                        if (!chartElement) return;

                        // 기존 차트가 있으면 제거
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            chartElement.innerHTML = '';
                        }

                        const categories = this.budgetRecommendations.map(cat => cat.categoryName);
                        // 차트는 adjustedPrice가 있으면 그것을, 없으면 totalPrice를 사용
                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        // 모든 데이터를 포함 (0원이어도 표시)
                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }));

                        // 필터링된 데이터가 없으면 경고
                        if (filteredData.length === 0) {
                            return;
                        }
                        
                        const series = filteredData.map(item => item.price);
                        const filteredCategories = filteredData.map(item => item.category);
                        
                        // ApexCharts가 로드되었는지 확인
                        if (typeof ApexCharts === 'undefined') {
                            console.error('ApexCharts가 로드되지 않았습니다!');
                            alert('차트 라이브러리를 불러오는 중 오류가 발생했습니다. 페이지를 새로고침해주세요.');
                            return;
                        }
                        
                        // 카테고리별 색상 매핑 (정확한 순서대로)
                        const categoryColorMap = {
                            '러닝화': '#008FFB',      // 파란색
                            '보호대': '#00E396',      // 초록색
                            '러닝복 상의': '#FEB019',  // 주황색
                            '러닝복 하의': '#FF4560'   // 빨간색
                        };
                        
                        // 카테고리 이름으로 색상 매핑
                        const mappedColors = filteredCategories.map(cat => {
                            return categoryColorMap[cat] || '#008FFB'; // 기본값 파란색
                        });

                        const options = {
                            series: series,
                            chart: {
                                type: 'donut',
                                width: '100%',
                                height: 400,
                                animations: {
                                    enabled: true,
                                    animateGradually: {
                                        enabled: true,
                                        delay: 150
                                    },
                                    dynamicAnimation: {
                                        enabled: true,
                                        speed: 350
                                    }
                                }
                            },
                            labels: filteredCategories,
                            colors: mappedColors,
                            stroke: {
                                show: true,
                                width: 2,
                                colors: ['#fff']
                            },
                            legend: {
                                position: 'bottom',
                                fontSize: '14px',
                                fontFamily: 'Arial, sans-serif',
                                itemMargin: {
                                    horizontal: 10,
                                    vertical: 5
                                }
                            },
                            dataLabels: {
                                enabled: true,
                                formatter: function (val, opts) {
                                    const value = series[opts.seriesIndex];
                                    return value.toLocaleString() + '원';
                                },
                                style: {
                                    fontSize: '12px',
                                    fontWeight: 'bold',
                                    colors: ['#fff']
                                }
                            },
                            tooltip: {
                                y: {
                                    formatter: function (val, opts) {
                                        const value = series[opts.seriesIndex];
                                        const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                        return value.toLocaleString() + '원 (' + percentage + '%)';
                                    }
                                }
                            },
                            plotOptions: {
                                pie: {
                                    donut: {
                                        size: '65%',
                                        labels: {
                                            show: true,
                                            name: {
                                                show: true,
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                color: '#373d3f'
                                            },
                                            value: {
                                                show: true,
                                                fontSize: '20px',
                                                fontWeight: 700,
                                                color: '#373d3f',
                                                formatter: function (val) {
                                                    return val.toLocaleString() + '원';
                                                }
                                            },
                                            total: {
                                                show: true,
                                                label: '사용 예산',
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                color: '#373d3f',
                                                formatter: function (w) {
                                                    return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            responsive: [{
                                breakpoint: 768,
                                options: {
                                    chart: {
                                        width: '100%',
                                        height: 350
                                    },
                                    legend: {
                                        position: 'bottom'
                                    }
                                }
                            }]
                        };

                        // 차트 컨테이너가 비어있는지 확인
                        if (chartElement.innerHTML.trim() !== '') {
                            chartElement.innerHTML = '';
                        }
                        
                        console.log('ApexCharts 옵션:', {
                            series: options.series,
                            labels: options.labels,
                            colors: options.colors,
                            seriesLength: options.series.length
                        });
                        
                        try {
                            // 기존 차트가 있으면 완전히 제거
                            if (this.budgetChart) {
                                this.budgetChart.destroy();
                                this.budgetChart = null;
                            }
                            
                            this.budgetChart = new ApexCharts(chartElement, options);
                            
                            // 약간의 지연 후 렌더링 (DOM이 완전히 준비되도록)
                            setTimeout(() => {
                                this.budgetChart.render().catch((error) => {
                                    console.error('차트 렌더링 오류:', error);
                                    alert('차트를 그리는 중 오류가 발생했습니다: ' + error.message);
                                });
                            }, 100);
                        } catch (error) {
                            console.error('ApexCharts 생성 오류:', error);
                            alert('차트를 생성하는 중 오류가 발생했습니다: ' + error.message);
                        }
                    },
                    //251117
                    initDragHandlers() {
                        // 전역 이벤트 리스너는 한 번만 등록
                        if (this.dragHandlersInitialized) return;
                        this.dragHandlersInitialized = true;

                        const self = this;
                        document.addEventListener('mousemove', (e) => {
                            if (self.isDragging) {
                                self.onDrag(e);
                            }
                        });
                        document.addEventListener('mouseup', () => {
                            if (self.isDragging) {
                                self.endDrag();
                            }
                        });
                        document.addEventListener('touchmove', (e) => {
                            if (self.isDragging) {
                                e.preventDefault();
                                self.onDrag(e.touches[0]);
                            }
                        });
                        document.addEventListener('touchend', () => {
                            if (self.isDragging) {
                                self.endDrag();
                            }
                        });
                    },
                    //251117
                    startDrag(event, index) {
                        event.preventDefault();
                        this.isDragging = true;
                        this.dragIndex = index;
                    },
                    //251117 - 바 차트 업데이트 (DOM 직접 조작) - 균등 분배용
                    updateBars(dragIndex, percentage, newPrice, remainingPercentagePerCategory, remainingPricePerCategory) {
                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        
                        allBars.forEach((bar, index) => {
                            const fillElement = bar.querySelector('.budget-bar-fill');
                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                            
                            if (index === dragIndex) {
                                // 드래그 중인 바
                                if (fillElement) fillElement.style.width = percentage + '%';
                                if (valueElement) valueElement.textContent = newPrice.toLocaleString() + '원 (' + percentage.toFixed(1) + '%)';
                            } else {
                                // 나머지 바들 (균등 분배)
                                if (fillElement) fillElement.style.width = remainingPercentagePerCategory + '%';
                                if (valueElement) valueElement.textContent = remainingPricePerCategory.toLocaleString() + '원 (' + remainingPercentagePerCategory.toFixed(1) + '%)';
                            }
                        });
                    },
                    //251117 - 바 차트 업데이트 (비율 유지하면서 재분배)
                    updateBarsWithRatios(dragIndex, percentage, newPrice, remainingPercentagesPerCategory, remainingPricesPerCategory) {
                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        
                        allBars.forEach((bar, index) => {
                            const fillElement = bar.querySelector('.budget-bar-fill');
                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                            
                            if (index === dragIndex) {
                                // 드래그 중인 바
                                if (fillElement) fillElement.style.width = percentage + '%';
                                if (valueElement) valueElement.textContent = newPrice.toLocaleString() + '원 (' + percentage.toFixed(1) + '%)';
                            } else {
                                // 나머지 바들 (기존 비율 유지하면서 재분배)
                                const catPercentage = remainingPercentagesPerCategory[index] || 0;
                                const catPrice = remainingPricesPerCategory[index] || 0;
                                if (fillElement) fillElement.style.width = catPercentage + '%';
                                if (valueElement) valueElement.textContent = catPrice.toLocaleString() + '원 (' + catPercentage.toFixed(1) + '%)';
                            }
                        });
                    },
                    //251117 - 도넛 차트 업데이트 (Vue 데이터 기반)
                    updateDonutChart() {
                        if (this.budgetRecommendations.length === 0) return;
                        if (!this.budgetChart) return;

                        // adjustedPrice를 우선 사용, 없으면 totalPrice 사용
                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        try {
                            if (this.budgetChart && typeof this.budgetChart.updateSeries === 'function') {
                                this.budgetChart.updateSeries(series, false); // false = no animate (빠른 업데이트)
                                this.budgetChart.updateOptions({
                                    labels: labels,
                                    colors: mappedColors,
                                    plotOptions: {
                                        pie: {
                                            donut: {
                                                labels: {
                                                    total: {
                                                        formatter: function (w) {
                                                            return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }, false, false); // false = redraw, false = no animate
                            }
                        } catch (error) {
                            console.error('도넛 차트 업데이트 오류:', error);
                        }
                    },
                    //251117 - 도넛 차트 즉시 업데이트 (드래그 중 직접 계산된 값 사용) - 균등 분배용
                    updateDonutChartImmediate(dragIndex, newPrice, remainingPricePerCategory) {
                        if (!this.budgetChart) return;

                        // 드래그 중인 값으로 직접 계산
                        const prices = this.budgetRecommendations.map((cat, idx) => {
                            if (idx === dragIndex) {
                                return newPrice;
                            } else {
                                return remainingPricePerCategory;
                            }
                        });
                        
                        this.updateDonutChartWithPrices(prices);
                    },
                    //251117 - 도넛 차트 즉시 업데이트 (비율 유지하면서 재분배)
                    updateDonutChartImmediateWithRatios(dragIndex, newPrice, remainingPricesPerCategory) {
                        if (!this.budgetChart) return;

                        // 드래그 중인 값으로 직접 계산 (비율 유지)
                        const prices = this.budgetRecommendations.map((cat, idx) => {
                            if (idx === dragIndex) {
                                return newPrice;
                            } else {
                                return remainingPricesPerCategory[idx] || 0;
                            }
                        });
                        
                        this.updateDonutChartWithPrices(prices);
                    },
                    //251117 - 도넛 차트 업데이트 공통 로직
                    updateDonutChartWithPrices(prices) {
                        if (!this.budgetChart) return;
                        
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        try {
                            if (this.budgetChart && typeof this.budgetChart.updateSeries === 'function') {
                                this.budgetChart.updateSeries(series, false); // false = no animate
                                this.budgetChart.updateOptions({
                                    labels: labels,
                                    colors: mappedColors,
                                    plotOptions: {
                                        pie: {
                                            donut: {
                                                labels: {
                                                    total: {
                                                        formatter: function (w) {
                                                            return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }, false, false);
                            }
                        } catch (error) {
                            console.error('도넛 차트 즉시 업데이트 오류:', error);
                        }
                    },
                    //251117
                    onDrag(event) {
                        if (this.dragIndex < 0 || !this.isDragging) return;

                        const allBars = document.querySelectorAll('.budget-bar-progress');
                        const barElement = allBars[this.dragIndex];
                        if (!barElement || !this.budgetRecommendations[this.dragIndex]) return;

                        const rect = barElement.getBoundingClientRect();
                        const clientX = event.clientX || (event.touches && event.touches[0] ? event.touches[0].clientX : 0);
                        const x = clientX - rect.left;
                        const percentage = Math.max(0, Math.min(100, (x / rect.width) * 100));
                        const budget = this.originalBudget || parseInt(this.budgetAmount);
                        const newPrice = Math.round((budget * percentage) / 100);

                        // 나머지 바들의 현재 비율 유지하면서 재분배
                        const remainingBudget = budget - newPrice;
                        
                        // 드래그 중인 바를 제외한 나머지 바들의 현재 총 금액 계산
                        // DOM에서 직접 읽어와서 정확한 현재 상태 반영
                        let remainingTotal = 0;
                        const remainingPrices = [];
                        allBars.forEach((bar, index) => {
                            if (index !== this.dragIndex) {
                                const fillElement = bar.querySelector('.budget-bar-fill');
                                const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                                
                                // DOM에서 현재 width를 읽어서 가격 계산
                                let currentPrice = 0;
                                if (fillElement && valueElement) {
                                    const width = parseFloat(fillElement.style.width) || 0;
                                    const currentPercentage = width;
                                    currentPrice = Math.round((budget * currentPercentage) / 100);
                                } else {
                                    // DOM에서 읽을 수 없으면 Vue 데이터 사용
                                    const cat = this.budgetRecommendations[index];
                                    currentPrice = cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 
                                        ? cat.adjustedPrice 
                                        : (cat.totalPrice || 0);
                                }
                                
                                remainingPrices.push({ index: index, price: currentPrice });
                                remainingTotal += currentPrice;
                            }
                        });

                        // 나머지 바들의 비율을 유지하면서 재분배
                        const remainingPricesPerCategory = [];
                        const remainingPercentagesPerCategory = [];
                        
                        if (remainingTotal > 0 && remainingBudget > 0) {
                            // 기존 비율대로 재분배
                            remainingPrices.forEach(item => {
                                const ratio = item.price / remainingTotal; // 기존 비율
                                const newPriceForCategory = Math.round(remainingBudget * ratio);
                                const newPercentageForCategory = (newPriceForCategory / budget) * 100;
                                remainingPricesPerCategory[item.index] = newPriceForCategory;
                                remainingPercentagesPerCategory[item.index] = newPercentageForCategory;
                            });
                        } else {
                            // 처음 드래그하는 경우 균등 분배
                            const remainingCategories = this.budgetRecommendations.length - 1;
                            const equalPrice = remainingCategories > 0 ? Math.round(remainingBudget / remainingCategories) : 0;
                            const equalPercentage = remainingCategories > 0 ? (remainingBudget / budget) * 100 / remainingCategories : 0;
                            this.budgetRecommendations.forEach((cat, index) => {
                                if (index !== this.dragIndex) {
                                    remainingPricesPerCategory[index] = equalPrice;
                                    remainingPercentagesPerCategory[index] = equalPercentage;
                                }
                            });
                        }

                        // 1. 바 차트 즉시 업데이트 (DOM 직접 조작)
                        this.updateBarsWithRatios(this.dragIndex, percentage, newPrice, remainingPercentagesPerCategory, remainingPricesPerCategory);

                        // 2. 도넛 차트 즉시 업데이트 (계산된 값으로 바로 업데이트)
                        this.updateDonutChartImmediateWithRatios(this.dragIndex, newPrice, remainingPricesPerCategory);

                        // 3. Vue 데이터는 throttle로 업데이트 (200ms마다 한 번만)
                        if (!this.dragUpdateTimer) {
                            this.dragUpdateTimer = setTimeout(() => {
                                // Vue 데이터 업데이트 (Vue 3에서는 직접 할당)
                                this.budgetRecommendations[this.dragIndex].adjustedPercentage = percentage;
                                this.budgetRecommendations[this.dragIndex].adjustedPrice = newPrice;
                                
                                this.budgetRecommendations.forEach((cat, index) => {
                                    if (index !== this.dragIndex) {
                                        cat.adjustedPercentage = remainingPercentagesPerCategory[index] || 0;
                                        cat.adjustedPrice = remainingPricesPerCategory[index] || 0;
                                    }
                                });
                                
                                this.dragUpdateTimer = null;
                            }, 200);
                        }
                    },
                    //251117
                    endDrag() {
                        this.isDragging = false;
                        const dragIndex = this.dragIndex;
                        this.dragIndex = -1;
                        
                        // 드래그 업데이트 타이머 정리
                        if (this.dragUpdateTimer) {
                            clearTimeout(this.dragUpdateTimer);
                            this.dragUpdateTimer = null;
                        }
                        
                        // 마지막 값으로 Vue 데이터 업데이트 (비율 유지)
                        if (dragIndex >= 0 && this.budgetRecommendations[dragIndex]) {
                            const allBars = document.querySelectorAll('.budget-bar-progress');
                            const barElement = allBars[dragIndex];
                            if (barElement) {
                                const fillElement = barElement.querySelector('.budget-bar-fill');
                                if (fillElement) {
                                    const width = fillElement.style.width;
                                    const percentage = parseFloat(width) || 0;
                                    const budget = this.originalBudget || parseInt(this.budgetAmount);
                                    const newPrice = Math.round((budget * percentage) / 100);
                                    
                                    // 나머지 바들의 현재 비율 유지하면서 재분배
                                    const remainingBudget = budget - newPrice;
                                    
                                    // 드래그 중인 바를 제외한 나머지 바들의 현재 총 금액 계산
                                    // DOM에서 직접 읽어와서 정확한 현재 상태 반영
                                    const allBars = document.querySelectorAll('.budget-bar-progress');
                                    let remainingTotal = 0;
                                    const remainingPrices = [];
                                    allBars.forEach((bar, index) => {
                                        if (index !== dragIndex) {
                                            const fillElement = bar.querySelector('.budget-bar-fill');
                                            const valueElement = bar.parentElement.querySelector('.budget-bar-value');
                                            
                                            // DOM에서 현재 width를 읽어서 가격 계산
                                            let currentPrice = 0;
                                            if (fillElement && valueElement) {
                                                const width = parseFloat(fillElement.style.width) || 0;
                                                const currentPercentage = width;
                                                currentPrice = Math.round((budget * currentPercentage) / 100);
                                            } else {
                                                // DOM에서 읽을 수 없으면 Vue 데이터 사용
                                                const cat = this.budgetRecommendations[index];
                                                currentPrice = cat.adjustedPrice !== undefined && cat.adjustedPrice > 0 
                                                    ? cat.adjustedPrice 
                                                    : (cat.totalPrice || 0);
                                            }
                                            
                                            remainingPrices.push({ index: index, price: currentPrice });
                                            remainingTotal += currentPrice;
                                        }
                                    });

                                    // 나머지 바들의 비율을 유지하면서 재분배
                                    const remainingPricesPerCategory = [];
                                    const remainingPercentagesPerCategory = [];
                                    
                                    if (remainingTotal > 0 && remainingBudget > 0) {
                                        // 기존 비율대로 재분배
                                        remainingPrices.forEach(item => {
                                            const ratio = item.price / remainingTotal; // 기존 비율
                                            const newPriceForCategory = Math.round(remainingBudget * ratio);
                                            const newPercentageForCategory = (newPriceForCategory / budget) * 100;
                                            remainingPricesPerCategory[item.index] = newPriceForCategory;
                                            remainingPercentagesPerCategory[item.index] = newPercentageForCategory;
                                        });
                                    } else {
                                        // 처음 드래그하는 경우 균등 분배
                                        const remainingCategories = this.budgetRecommendations.length - 1;
                                        const equalPrice = remainingCategories > 0 ? Math.round(remainingBudget / remainingCategories) : 0;
                                        const equalPercentage = remainingCategories > 0 ? (remainingBudget / budget) * 100 / remainingCategories : 0;
                                        this.budgetRecommendations.forEach((cat, index) => {
                                            if (index !== dragIndex) {
                                                remainingPricesPerCategory[index] = equalPrice;
                                                remainingPercentagesPerCategory[index] = equalPercentage;
                                            }
                                        });
                                    }
                                    
                                    // Vue 데이터 업데이트 (Vue 3에서는 직접 할당)
                                    this.budgetRecommendations[dragIndex].adjustedPercentage = percentage;
                                    this.budgetRecommendations[dragIndex].adjustedPrice = newPrice;
                                    
                                    this.budgetRecommendations.forEach((cat, index) => {
                                        if (index !== dragIndex) {
                                            cat.adjustedPercentage = remainingPercentagesPerCategory[index] || 0;
                                            cat.adjustedPrice = remainingPricesPerCategory[index] || 0;
                                        }
                                    });
                                    
                                    console.log('endDrag 완료 - dragIndex: ' + dragIndex + ', adjustedPrice: ' + this.budgetRecommendations[dragIndex].adjustedPrice + ', adjustedPercentage: ' + this.budgetRecommendations[dragIndex].adjustedPercentage);
                                    
                                    // 도넛 차트 최종 업데이트
                                    this.updateDonutChart();
                                }
                            }
                        }
                    },
                    //251117 - 도넛 차트 초기 생성 (처음 한 번만)
                    drawDonutChart() {
                        if (this.budgetRecommendations.length === 0) return;
                        const chartElement = document.getElementById('budgetChart');
                        if (!chartElement) return;

                        // 기존 차트가 있으면 제거
                        if (this.budgetChart) {
                            this.budgetChart.destroy();
                            chartElement.innerHTML = '';
                        }

                        const prices = this.budgetRecommendations.map(cat => {
                            return cat.adjustedPrice !== undefined ? cat.adjustedPrice : (cat.totalPrice || 0);
                        });
                        const total = prices.reduce((a, b) => a + b, 0);
                        const budget = this.originalBudget || parseInt(this.budgetAmount) || 0;

                        const filteredData = this.budgetRecommendations
                            .map((cat, idx) => ({
                                category: cat.categoryName,
                                price: prices[idx] || 0
                            }))
                            .filter(item => item.price > 0);

                        if (filteredData.length === 0) return;

                        const series = filteredData.map(item => item.price);
                        const labels = filteredData.map(item => item.category);
                        
                        const categoryColorMap = {
                            '러닝화': '#008FFB',
                            '보호대': '#00E396',
                            '러닝복 상의': '#FEB019',
                            '러닝복 하의': '#FF4560'
                        };
                        
                        const mappedColors = labels.map(cat => categoryColorMap[cat] || '#008FFB');

                        if (typeof ApexCharts === 'undefined') {
                            console.error('ApexCharts가 로드되지 않았습니다!');
                            return;
                        }

                        const options = {
                            series: series,
                            chart: {
                                type: 'donut',
                                width: '100%',
                                height: 400
                            },
                            labels: labels,
                            colors: mappedColors,
                            plotOptions: {
                                pie: {
                                    donut: {
                                        size: '65%',
                                        labels: {
                                            show: true,
                                            name: {
                                                show: true,
                                                fontSize: '16px',
                                                fontWeight: 600
                                            },
                                            value: {
                                                show: true,
                                                fontSize: '20px',
                                                fontWeight: 700,
                                                formatter: function (val) {
                                                    return val.toLocaleString() + '원';
                                                }
                                            },
                                            total: {
                                                show: true,
                                                label: '사용 예산',
                                                fontSize: '16px',
                                                fontWeight: 600,
                                                formatter: function (w) {
                                                    return total.toLocaleString() + '원 / ' + budget.toLocaleString() + '원';
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        };

                        try {
                            this.budgetChart = new ApexCharts(chartElement, options);
                            setTimeout(() => {
                                this.budgetChart.render().catch((error) => {
                                    console.error('도넛 차트 렌더링 오류:', error);
                                });
                            }, 100);
                        } catch (error) {
                            console.error('도넛 차트 생성 오류:', error);
                        }
                    },
                    //251117
                    updateRecommendationsByRatio() {
                        // 조정된 비율에 따라 각 카테고리별로 예산을 재할당하여 상품 추천
                        const self = this;
                        const vueInstance = this; // Vue 인스턴스 참조 보존
                        const budget = this.originalBudget || parseInt(this.budgetAmount);
                        
                        console.log('비율 조정 후 다시 추천받기 시작');
                        console.log('현재 budgetRecommendations:', JSON.parse(JSON.stringify(this.budgetRecommendations)));
                        
                        // 각 카테고리별로 조정된 예산으로 상품 조회
                        const promises = this.budgetRecommendations.map((category, index) => {
                            // adjustedPrice를 우선 사용, 없으면 totalPrice 사용
                            // adjustedPrice가 0이거나 undefined/null이면 totalPrice 사용
                            let categoryBudget = 0;
                            if (category.adjustedPrice !== undefined && category.adjustedPrice !== null && category.adjustedPrice > 0) {
                                categoryBudget = category.adjustedPrice;
                            } else if (category.totalPrice !== undefined && category.totalPrice !== null && category.totalPrice > 0) {
                                categoryBudget = category.totalPrice;
                            }
                            
                            console.log('카테고리 ' + category.categoryName + ' - adjustedPrice: ' + category.adjustedPrice + ', totalPrice: ' + category.totalPrice + ', adjustedPercentage: ' + category.adjustedPercentage + ', 사용할 예산: ' + categoryBudget);
                            
                            if (categoryBudget <= 0) {
                                console.warn('카테고리 ' + category.categoryName + ' 예산이 0이므로 상품 조회 스킵');
                                return Promise.resolve({ category: category.categoryName, products: [] });
                            }

                            return new Promise((resolve) => {
                                $.ajax({
                                    url: '/api/budgetRecommendations.dox',
                                    method: 'POST',
                                    dataType: 'json',
                                    data: { 
                                        budget: categoryBudget,
                                        categoryName: category.categoryName
                                    },
                                    success: (response) => {
                                        console.log('카테고리 ' + category.categoryName + ' API 응답:', response);
                                        if (response.result === 'success' && response.data && response.data.length > 0) {
                                            const catData = response.data[0]; // 단일 카테고리 조회이므로 첫 번째 요소
                                            console.log('카테고리 ' + category.categoryName + ' 상품 수: ' + (catData.products ? catData.products.length : 0) + ', 상품 목록:', catData.products);
                                            resolve({
                                                category: category.categoryName,
                                                products: catData.products || []
                                            });
                                        } else {
                                            console.warn('카테고리 ' + category.categoryName + ' 응답 데이터 없음 - result: ' + response.result + ', data:', response.data);
                                            resolve({ category: category.categoryName, products: [] });
                                        }
                                    },
                                    error: (error) => {
                                        console.error('카테고리 ' + category.categoryName + ' API 오류:', error);
                                        resolve({ category: category.categoryName, products: [] });
                                    }
                                });
                            });
                        });

                        Promise.all(promises).then((results) => {
                            try {
                                console.log('모든 API 응답 완료:', results);
                                
                                // 결과를 budgetRecommendations에 반영
                                results.forEach((result) => {
                                    try {
                                        // 배열 인덱스를 찾아서 직접 업데이트
                                        const categoryIndex = self.budgetRecommendations.findIndex(c => c.categoryName === result.category);
                                        if (categoryIndex >= 0) {
                                            const category = self.budgetRecommendations[categoryIndex];
                                            console.log('카테고리 ' + result.category + ' 업데이트 전 상품 수: ' + (category.products ? category.products.length : 0));
                                            console.log('카테고리 ' + result.category + ' 업데이트 후 상품 수: ' + (result.products ? result.products.length : 0));
                                            
                                            // 조정된 예산(adjustedPrice)은 유지 (사용자가 조정한 비율 보존)
                                            // adjustedPrice가 있으면 사용, 없으면 현재 totalPrice를 adjustedPrice로 설정
                                            let currentAdjustedPrice = category.adjustedPrice;
                                            let currentAdjustedPercentage = category.adjustedPercentage;
                                            
                                            // adjustedPrice가 없거나 0이면, 현재 totalPrice를 adjustedPrice로 사용
                                            if (currentAdjustedPrice === undefined || currentAdjustedPrice === null || currentAdjustedPrice === 0) {
                                                currentAdjustedPrice = category.totalPrice || 0;
                                                currentAdjustedPercentage = category.percentage || 0;
                                            }
                                            
                                            // adjustedPercentage가 없으면 계산
                                            if (currentAdjustedPercentage === undefined || currentAdjustedPercentage === null) {
                                                currentAdjustedPercentage = budget > 0 ? (currentAdjustedPrice * 100.0 / budget) : 0;
                                            }
                                            
                                            console.log('카테고리 ' + result.category + ' 조정된 예산 유지 - adjustedPrice: ' + currentAdjustedPrice + ', adjustedPercentage: ' + currentAdjustedPercentage + '%, totalPrice: ' + category.totalPrice + ', percentage: ' + category.percentage + '%');
                                            
                                            // 조정된 예산에 맞게 실제 사용된 금액 계산
                                            let actualTotal = 0;
                                            
                                            if (result.products && result.products.length > 0) {
                                                // 가장 비싼 제품 1개만 사용 (1세트 개념)
                                                // 백엔드에서 이미 가장 비싼 제품 1개만 반환하므로 첫 번째 제품 사용
                                                actualTotal = result.products[0].finalPrice || 0;
                                            }
                                            
                                            // 실제 사용된 금액이 조정된 예산보다 크면 조정된 예산으로 제한
                                            actualTotal = Math.min(actualTotal, currentAdjustedPrice);
                                            
                                            // 객체 속성을 직접 수정하여 Vue 반응성 보장 (Vue 3)
                                            category.products = result.products || [];
                                            category.totalPrice = actualTotal;
                                            // percentage는 실제 사용된 금액 기준으로 계산 (도넛 차트용)
                                            category.percentage = budget > 0 ? (actualTotal * 100.0 / budget) : 0;
                                            // adjustedPrice와 adjustedPercentage는 사용자가 조정한 값 유지 (바 차트용)
                                            category.adjustedPrice = currentAdjustedPrice;
                                            category.adjustedPercentage = currentAdjustedPercentage;
                                            
                                            console.log('카테고리 ' + result.category + ' 업데이트 - products: ' + category.products.length + '개, totalPrice: ' + category.totalPrice + ', percentage: ' + category.percentage + '%, adjustedPrice: ' + category.adjustedPrice + ', adjustedPercentage: ' + category.adjustedPercentage + '%');
                                            
                                            console.log('카테고리 ' + result.category + ' 최종 업데이트 완료 - 상품: ' + category.products.length + '개, 실제금액: ' + actualTotal + ', 조정예산: ' + currentAdjustedPrice);
                                        } else {
                                            console.warn('카테고리 ' + result.category + '를 찾을 수 없음');
                                        }
                                    } catch (err) {
                                        console.error('카테고리 ' + result.category + ' 업데이트 중 오류:', err);
                                    }
                                });
                                
                                try {
                                    console.log('업데이트 후 budgetRecommendations:', JSON.parse(JSON.stringify(self.budgetRecommendations)));
                                } catch (jsonErr) {
                                    console.warn('JSON 직렬화 오류 (무시 가능):', jsonErr);
                                }
                                
                                // 도넛 차트 업데이트 (Vue 반응성 업데이트 완료 후)
                                self.$nextTick(() => {
                                    try {
                                        self.updateDonutChart();
                                    } catch (chartErr) {
                                        console.error('도넛 차트 업데이트 오류:', chartErr);
                                    }
                                });
                            } catch (err) {
                                console.error('Promise.all 처리 중 오류:', err);
                                throw err; // catch 블록으로 전달
                            }
                        }).catch((error) => {
                            console.error('비율 조정 후 추천받기 오류:', error);
                            console.error('에러 상세:', error.message, error.stack);
                            alert('추천 상품을 불러오는 중 오류가 발생했습니다: ' + (error.message || '알 수 없는 오류'));
                        });
                    },
                    //251117
                    goToProduct(productNo) {
                        window.location.href = '/home/product-info.do?productNo=' + productNo;
                    }
                },
                mounted() {
                    // 처음 시작할 때 실행되는 부분
                    let self = this;

                    // 1. 세션 아이디가 진짜 있는지 콘솔에 찍어보세요
                    console.log("현재 세션 아이디:", self.sessionId);

                    const queryParams = new URLSearchParams(window.location.search);
                    self.code = queryParams.get('code') || '';
                    if (self.code != "") {
                        self.fnKakao();
                    }
                    this.fetchMainSlideImages();
                    this.fetchRecommendedProducts();
                    this.fetchLatestRallies();
                    lucide.createIcons();


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
        
        <!-- 위젯 위치 동적 조정 스크립트 -->
        <script src="/js/widget-position.js"></script>