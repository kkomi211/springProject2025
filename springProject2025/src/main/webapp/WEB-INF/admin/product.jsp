<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 리스트 - RUNNERS HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/jes.css">
        <link rel="stylesheet" href="/css/admin-inquiry.css">
        <script src="/js/page-change.js"></script>
        <script src="/js/admin-notifications.js"></script>
        <style>
            /* 등록하기 버튼 전용 보라색 그라데이션 스타일 */
            .btn-register-main {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 30px;
                border-radius: 30px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                outline: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }

            .btn-register-main:hover {
                filter: brightness(1.1);
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(102, 126, 234, 0.5);
            }

            .btn-register-main:active {
                transform: translateY(0);
            }

            /* 버튼 컨테이너 정렬 보정 */
            .button {
                display: flex;
                justify-content: flex-end;
                /* 우측 정렬 */
                margin-top: 20px;
                padding-right: 10px;
            }
        </style>
    </head>

    <body class="adminbody">
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <!-- 상단 검은색 바 -->
            <div class="topbar">
                <div><strong>관리자 메인화면</strong></div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <!-- 알림 아이콘 -->
                    <div class="notification-icon-wrapper" @click="toggleNotificationPanel">
                        <span class="notification-bell">🔔</span>
                        <span v-if="notificationCounts.totalCount > 0" class="notification-badge">{{
                            notificationCounts.totalCount }}</span>
                    </div>
                    <div style="line-height: 1.2;">관리자 ${sessionId} 님 안녕하세요 &nbsp; <a href="javascript:;"
                            class="text-white text-decoration-none" @click="fnLogout">로그오프</a></div>
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

            <!-- 메뉴 바 (검은색) -->
            <div class="nav-black">
                <a href="/admin.do">MAIN</a>
                <a href="/admin/banner.do">배너 이미지 관리</a>
                <a href="/admin/inquiry.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do" class="active">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
                <a href="/admin/activity-log.do">활동 로그</a>
            </div>

            <!-- 본문 -->
            <div class="content">
                <div>
                    <h2>상품 리스트</h2>
                </div>
                <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnList()" placeholder="검색">
                        <button @click="fnList()">검색</button>
                    </div>

                    <!-- 검색 유형 필터 -->
                    <div class="filter-group">
                        <span>검색 유형:</span>
                        <select v-model="keytype" @change="fnList()">
                            <option value="no">제품번호</option>
                            <option value="name">제품이름</option>
                        </select>
                    </div>

                    <!-- 엑셀 다운로드 버튼 -->
                    <div class="filter-group">
                        <button @click="downloadExcel()"
                            style="background-color: #28a745; color: white; padding: 8px 18px; border: none; border-radius: 5px; cursor: pointer; font-weight: 600;">
                            📥 엑셀 다운로드
                        </button>
                    </div>
                </div>

                <div class="table">
                    <!-- 로딩 스피너 -->
                    <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                        <div class="loading-spinner"></div>
                        <div class="loading-text">데이터를 불러오는 중...</div>
                    </div>

                    <!-- 테이블 -->
                    <table class="newtable" v-if="!loading && list.length > 0">
                        <tr>
                            <th class="sortable-header" @click="sortTable('productNo')"
                                :class="{'sort-asc': sortColumn === 'productNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productNo' && sortDirection === 'desc'}">
                                제품번호</th>
                            <th class="sortable-header" @click="sortTable('productName')"
                                :class="{'sort-asc': sortColumn === 'productName' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productName' && sortDirection === 'desc'}">
                                제품이름</th>
                            <th class="sortable-header" @click="sortTable('price')"
                                :class="{'sort-asc': sortColumn === 'price' && sortDirection === 'asc', 'sort-desc': sortColumn === 'price' && sortDirection === 'desc'}">
                                제품가격</th>
                            <th class="sortable-header" @click="sortTable('quantity')"
                                :class="{'sort-asc': sortColumn === 'quantity' && sortDirection === 'asc', 'sort-desc': sortColumn === 'quantity' && sortDirection === 'desc'}">
                                제품재고
                                <div class="stock-btns" style="display: inline-block; margin-left: 5px;">
                                    <button v-if="orderBy == 'down'" @click.stop="fnOrderBy('up')"
                                        style="background: none; border: none; padding: 0; font-size: 0.8em;">△</button>
                                    <button v-if="orderBy == 'up'" @click.stop="fnOrderBy('down')"
                                        style="background: none; border: none; padding: 0; font-size: 0.8em;">▽</button>
                                </div>
                            </th>
                            <th class="sortable-header" @click="sortTable('productSize')"
                                :class="{'sort-asc': sortColumn === 'productSize' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productSize' && sortDirection === 'desc'}">
                                사이즈</th>
                            <th class="sortable-header" @click="sortTable('udate')"
                                :class="{'sort-asc': sortColumn === 'udate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'udate' && sortDirection === 'desc'}">
                                등록/수정일자</th>
                        </tr>
                        <tr v-for="item in sortedList" :class="getStockClass(item.quantity)">
                            <td>{{item.productNo}}</td>
                            <td><a href="javascript:;" @click="fnInfoProduct(item.productNo)">{{item.productName}}</a>
                            </td>
                            <td>
                                <span v-if="item.saleYN == 'N'">{{item.price.toLocaleString()}}원</span>
                                <span v-else>
                                    <del>{{item.price.toLocaleString()}}원</del>
                                    {{item.salePrice.toLocaleString()}}원
                                </span>
                            </td>
                            <td>
                                <span :class="getStockBadgeClass(item.quantity)">
                                    {{item.quantity}}
                                    <span v-if="item.quantity === 0" class="stock-badge">품절</span>
                                    <span v-else-if="item.quantity < 5" class="stock-badge">품절임박</span>
                                </span>
                            </td>
                            <td>{{item.productSize}}</td>
                            <td>{{item.udate}}</td>
                        </tr>
                    </table>

                    <!-- 빈 데이터 메시지 -->
                    <div v-if="!loading && list.length === 0" class="empty-state-card">
                        <div class="empty-icon">📦</div>
                        <div class="empty-title">상품이 없습니다</div>
                        <div class="empty-description">검색 조건을 변경하거나 새로운 상품을 등록해보세요.</div>
                    </div>
                </div>
                <div class="pagination">
                    <a href="javascript:;" @click="fnPage(1)" :class="{'disabled': page === 1}">&laquo;</a>
                    <a href="javascript:;" @click="fnPage(page - 1)" :class="{'disabled': page === 1}">&lt;</a>

                    <template v-for="num in pageNumbers">
                        <a href="javascript:;" @click="fnPage(num)" :class="{'active': page === num}">{{ num }}</a>
                    </template>

                    <a href="javascript:;" @click="fnPage(page + 1)" :class="{'disabled': page === totalPage}">&gt;</a>
                    <a href="javascript:;" @click="fnPage(totalPage)"
                        :class="{'disabled': page === totalPage}">&raquo;</a>
                </div>
                <div class="button">
                    <button class="btn-register-main" @click="fnAddProduct">
                        <span>+ 상품 등록하기</span>
                    </button>
                </div>
                <div class="bottom200"></div>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "",
                    keyword: "${keyword}",
                    keytype: "name",
                    list: [],
                    pageSize: 15,
                    page: "1",
                    totalPage: "",
                    orderBy: "down",
                    loading: false, // 로딩 상태
                    sortColumn: '', // 정렬 컬럼
                    sortDirection: 'asc', // 정렬 방향
                    // 알림 관련
                    notificationCounts: {
                        newInquiryCount: 0,
                        newOrderCount: 0,
                        newBoardReportCount: 0,
                        totalCount: 0
                    },
                    showNotificationPanel: false,
                    notificationInterval: null
                };
            },
            computed: {
                // 페이지 번호 배열 계산 (최대 5개 페이지 번호만 표시)
                pageNumbers() {
                    const pages = [];
                    let startPage = Math.max(1, this.page - 2);
                    let endPage = Math.min(this.totalPage, startPage + 4);

                    // 끝 페이지가 전체 페이지보다 작으면 시작 페이지를 조정
                    if (endPage < this.totalPage) {
                        startPage = Math.max(1, endPage - 4);
                    }

                    for (let i = startPage; i <= endPage; i++) {
                        pages.push(i);
                    }

                    return pages;
                },
                // 정렬된 리스트
                sortedList() {
                    if (!this.sortColumn) return this.list;

                    const sorted = [...this.list];
                    sorted.sort((a, b) => {
                        let aVal = a[this.sortColumn];
                        let bVal = b[this.sortColumn];

                        // 날짜 정렬
                        if (this.sortColumn === 'udate') {
                            aVal = new Date(aVal);
                            bVal = new Date(bVal);
                        }

                        // 숫자 정렬
                        if (this.sortColumn === 'productNo' || this.sortColumn === 'quantity' || this.sortColumn === 'price') {
                            aVal = parseFloat(aVal);
                            bVal = parseFloat(bVal);
                        }

                        if (aVal < bVal) return this.sortDirection === 'asc' ? -1 : 1;
                        if (aVal > bVal) return this.sortDirection === 'asc' ? 1 : -1;
                        return 0;
                    });

                    return sorted;
                }
            },
            methods: {
                // 함수(메소드) - (key : function())
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
                fnList() {
                    let self = this;
                    self.loading = true; // 로딩 시작

                    let param = {
                        keyword: self.keyword,
                        keytype: self.keytype,
                        page: (self.page - 1) * 15,
                        pageSize: self.pageSize,
                        orderBy: self.orderBy
                    };
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.totalPage = Math.ceil(data.total / self.pageSize);
                        },
                        error: function () {
                            alert("데이터를 불러오는 중 오류가 발생했습니다.");
                        },
                        complete: function () {
                            self.loading = false; // 로딩 종료
                        }
                    });
                },
                sortTable: function (column) {
                    if (this.sortColumn === column) {
                        // 같은 컬럼 클릭 시 정렬 방향 전환
                        this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
                    } else {
                        // 다른 컬럼 클릭 시 오름차순으로 설정
                        this.sortColumn = column;
                        this.sortDirection = 'asc';
                    }
                },
                fnPage(num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
                },
                fnAddProduct() {
                    location.href = "/admin/product-add.do";
                },
                fnInfoProduct(productNo) {
                    pageChange("/admin/product-info.do", { productNo: productNo });
                },
                fnOrderBy(status) {
                    let self = this;
                    self.orderBy = status;
                    self.fnList();
                },
                downloadExcel: function () {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.keytype) params.append('keytype', self.keytype);
                    if (self.orderBy) params.append('orderBy', self.orderBy);

                    window.location.href = '/admin/product/excel.dox?' + params.toString();
                },
                // 재고 상태에 따른 CSS 클래스 반환
                getStockClass: function (quantity) {
                    if (quantity === 0) return 'stock-out-row';
                    if (quantity < 5) return 'stock-low-row';
                    return '';
                },
                // 재고 배지 클래스 반환
                getStockBadgeClass: function (quantity) {
                    if (quantity === 0) return 'stock-badge-out';
                    if (quantity < 5) return 'stock-badge-low';
                    return '';
                },
                goToPage: function (url) {
                    window.location.href = url;
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
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnPage(1);
                AdminNotifications.init(self);
            },
            beforeUnmount() {
                AdminNotifications.cleanup(this);
            }
        });

        app.mount('#app');
    </script>