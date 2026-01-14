<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>관리자 대시보드 - RUNNERS HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="/css/style.css">
        <link rel="stylesheet" href="/css/admin-inquiry.css">
        <script src="/js/page-change.js"></script>

    </head>

    <body class="adminbody">
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <!-- 상단 검은색 바 -->
            <div class="topbar">
                <div><strong>관리자 메인화면</strong></div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <div style="line-height: 1.2;">관리자 ${sessionId} 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none"
                            @click="fnLogout">로그오프</a></div>
                </div>
            </div>
            
            <!-- 메뉴 바 (검은색) -->
            <div class="nav-black">
                <a href="/admin.do" class="active">MAIN</a>
                <a href="/admin/banner.do">배너 이미지 관리</a>
                <a href="/admin/inquiry.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
                <a href="/admin/activity-log.do">활동 로그</a>
            </div>

            <!-- 본문 -->
            <div class="content">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h2 style="margin: 0;">대시보드 요약</h2>
                    <div class="auto-refresh-toggle" :class="{'active': autoRefresh}" @click="toggleAutoRefresh">
                        <span class="auto-refresh-indicator" v-if="autoRefresh"></span>
                        <span>{{ autoRefresh ? '자동 새로고침 ON' : '자동 새로고침 OFF' }}</span>
                    </div>
                </div>
                <div class="dashboard-grid">
                    <!-- 주문 현황 (가로 막대 그래프) -->
                    <div class="dashboard-card">
                        <h3>주문 현황</h3>
                        <div class="dashboard-chart-container">
                            <canvas id="orderStatusChart"></canvas>
                        </div>
                    </div>

                    <!-- 상품 정보 핵심 요약 표 -->
                    <div class="dashboard-card clickable" @click="goToPage('/admin/product.do')">
                        <h3>상품 요약</h3>
                        <div class="product-summary-section">
                            <div>
                                <table>
                                    <tr>
                                        <th>총 상품 수</th>
                                        <td>{{ productSummary.totalProducts }} 개</td>
                                    </tr>
                                </table>
                            </div>

                            <div>
                                <h4>판매량 Top 5 상품</h4>
                                <table>
                                    <tr>
                                        <th>상품명</th>
                                        <th>판매량</th>
                                    </tr>
                                    <tr v-for="product in productSummary.topSellingProducts" :key="product.productNo">
                                        <td>{{ product.productName }}</td>
                                        <td>{{ product.sellCount }} 개</td>
                                    </tr>
                                    <tr
                                        v-if="productSummary.topSellingProducts && productSummary.topSellingProducts.length === 0">
                                        <td colspan="2" class="empty-state-message">판매 데이터가 없습니다</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- 품절 임박 상품 알림 카드 -->
                    <div class="dashboard-card clickable" @click="goToPage('/admin/product.do')" :class="{'stock-alert-card': lowStockProductsList.length > 0}">
                        <h3>
                            ⚠️ 품절 임박 상품
                            <span v-if="lowStockProductsList.length > 0" style="color: #dc3545; font-size: 0.9em;">
                                ({{ lowStockProductsList.length }}개)
                            </span>
                        </h3>
                        <div v-if="lowStockProductsList.length > 0" class="low-stock-list-full">
                            <table style="width: 100%; font-size: 0.9em;" class="low-stock-table">
                                <tr>
                                    <th>상품명</th>
                                    <th class="size-col">사이즈</th>
                                    <th class="stock-col">재고</th>
                                </tr>
                                <tr v-for="product in lowStockProductsList" :key="product.PRODUCT_NO" 
                                    :class="product.QUANTITY === 0 ? 'stock-out-row' : 'stock-low-row'">
                                    <td>{{ product.PRODUCT_NAME }}</td>
                                    <td class="size-col">{{ product.PRODUCT_SIZE || '-' }}</td>
                                    <td class="stock-col">
                                        <span :class="product.QUANTITY === 0 ? 'stock-badge-out' : 'stock-badge-low'">
                                            {{ product.QUANTITY }}
                                            <span class="stock-badge">{{ product.QUANTITY === 0 ? '품절' : '품절임박' }}</span>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div v-else class="empty-state-message" style="padding: 20px; text-align: center;">
                            품절 임박 상품이 없습니다.
                        </div>
                    </div>

                    <!-- 미처리 요청 -->
                    <div class="dashboard-card request-alert-card" :class="{'request-alert-card-active': requestSummary.totalPendingRequestsCount > 0}">
                        <h3>
                            ⚠️ 미처리 요청
                            <span v-if="requestSummary.totalPendingRequestsCount > 0" style="color: #dc3545; font-size: 0.9em;">
                                ({{ requestSummary.totalPendingRequestsCount }}건 대기)
                            </span>
                        </h3>
                        <div class="product-summary-section">
                            <div>
                                <table>
                                    <tr>
                                        <th>항목</th>
                                        <th>대기 수</th>
                                    </tr>
                                    <tr class="clickable-row" @click.stop="goToPage('/admin/orders.do')">
                                        <td>배송 중 주문</td>
                                        <td>{{ requestSummary.deliveryInProgress }} 건</td>
                                    </tr>
                                    <tr class="clickable-row" @click.stop="goToPage('/admin/board-report.do')">
                                        <td>신규 신고 게시물</td>
                                        <td>{{ requestSummary.newReports }} 건</td>
                                    </tr>
                                    <tr class="clickable-row" @click.stop="goToPage('/admin/orders.do')">
                                        <td>반품 요청 대기</td>
                                        <td>{{ requestSummary.refundRequests }} 건</td>
                                    </tr>
                                    <tr class="clickable-row" @click.stop="goToPage('/admin/orders.do')">
                                        <td>교환 요청 대기</td>
                                        <td>{{ requestSummary.exchangeRequests }} 건</td>
                                    </tr>
                                    <tr class="clickable-row" @click.stop="goToPage('/admin/inquiry.do')">
                                        <td>상품 문의 대기</td>
                                        <td>{{ requestSummary.newProductInquiries }} 건</td>
                                    </tr>
                                    <tr>
                                        <th>총 미처리 요청</th>
                                        <th>{{ requestSummary.totalPendingRequestsCount }} 건</th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- 매출 현황 (월별 라인 그래프 - 전년 대비) -->
                    <div class="dashboard-card">
                        <h3>월별 매출 추이 (전년 대비)</h3>
                        <div class="dashboard-chart-container">
                            <canvas id="monthlySalesChart"></canvas>
                        </div>
                    </div>

                    <!-- 카테고리별 매출 비율 -->
                    <div class="dashboard-card">
                        <h3>카테고리별 매출 비율</h3>
                        <div class="dashboard-chart-container">
                            <canvas id="salesByCategoryChart"></canvas>
                        </div>
                    </div>

                    <!-- 총 매출 현황 -->
                    <div class="dashboard-card clickable" @click="goToPage('/admin/orders.do')">
                        <h3>총 매출 현황</h3>
                        <div class="product-summary-section">
                            <div>
                                <h4>주요 지표</h4>
                                <table>
                                    <tr>
                                        <th>항목</th>
                                        <th>값</th>
                                    </tr>
                                    <tr>
                                        <td>총 매출</td>
                                        <td>{{ formatCurrency(salesSummary.totalSales) }}</td>
                                    </tr>
                                    <tr>
                                        <td>월간 매출</td>
                                        <td>{{ formatCurrency(salesSummary.monthlySales) }}</td>
                                    </tr>
                                    <tr>
                                        <td>전월 대비</td>
                                        <td>
                                            <span :style="getComparisonStyle(salesSummary.monthlySales, salesSummary.previousMonthSales)">
                                                {{ getComparisonText(salesSummary.monthlySales, salesSummary.previousMonthSales) }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>전년 동월 대비</td>
                                        <td>
                                            <span :style="getComparisonStyle(salesSummary.monthlySales, salesSummary.previousYearSameMonthSales)">
                                                {{ getComparisonText(salesSummary.monthlySales, salesSummary.previousYearSameMonthSales) }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>연간 매출</td>
                                        <td>{{ formatCurrency(salesSummary.annualSales) }}</td>
                                    </tr>
                                    <tr>
                                        <td>전년 대비</td>
                                        <td>
                                            <span :style="getComparisonStyle(salesSummary.annualSales, salesSummary.previousYearAnnualSales)">
                                                {{ getComparisonText(salesSummary.annualSales, salesSummary.previousYearAnnualSales) }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>총 주문 건수</td>
                                        <td>{{ salesSummary.totalOrdersCount }} 건</td>
                                    </tr>
                                    <tr>
                                        <td>월간 주문 건수</td>
                                        <td>{{ salesSummary.monthlyOrdersCount }} 건</td>
                                    </tr>
                                </table>
                            </div>
                            <!-- <div>
                            <h4>결제 방법별 매출</h4>
                            <table>
                                <tr>
                                    <th>방법</th>
                                    <th>매출액</th>
                                </tr>
                                <tr v-for="method in salesSummary.salesByPaymentMethod" :key="method.PAYMENT_METHOD">
                                    <td>{{ method.PAYMENT_METHOD }}</td>
                                    <td>{{ formatCurrency(method.TOTAL_SALES) }}</td>
                                </tr>
                                <tr v-if="salesSummary.salesByPaymentMethod.length === 0">
                                    <td colspan="2">데이터 없음</td>
                                </tr>
                            </table>
                        </div> -->
                        </div>
                    </div>

                    <!-- 회원 요약 -->
                    <div class="dashboard-card clickable" @click="goToPage('/admin/user-list.do')">
                        <h3>회원 요약</h3>
                        <div class="product-summary-section">
                            <div>
                                <h4>회원 통계</h4>
                                <table>
                                    <tr>
                                        <th>항목</th>
                                        <th>값</th>
                                    </tr>
                                    <tr>
                                        <td>총 회원 수</td>
                                        <td>{{ userSummary.totalUsers }} 명</td>
                                    </tr>
                                    <tr>
                                        <td>오늘 가입한 회원</td>
                                        <td>{{ userSummary.newUsersToday }} 명</td>
                                    </tr>
                                    <tr>
                                        <td>이번 달 가입한 회원</td>
                                        <td>{{ userSummary.newUsersMonth }} 명</td>
                                    </tr>
                                    <tr>
                                        <td>주문 이력 회원 수</td>
                                        <td>{{ userSummary.usersWithOrdersCount }} 명</td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <h4>성별 회원 분포</h4>
                                <table>
                                    <tr>
                                        <th>성별</th>
                                        <th>회원 수</th>
                                    </tr>
                                    <tr v-for="gender in userSummary.usersByGender" :key="gender.GENDER">
                                        <td>{{ gender.GENDER === 'M' ? '남성' : (gender.GENDER === 'F' ? '여성' : '기타') }}
                                        </td>
                                        <td>{{ gender.USER_COUNT }} 명</td>
                                    </tr>
                                    <tr v-if="userSummary.usersByGender.length === 0">
                                        <td colspan="2" class="empty-state-message">회원 데이터가 없습니다</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    adminName: "", // 관리자 이름은 로그인 정보에서 가져오기
                    orderStatus: { // 주문 현황 그래프 데이터
                        labels: [],
                        data: [],
                        colors: []
                    },
                    salesSummary: { // 매출 현황 데이터
                        totalSales: 0,
                        monthlySales: 0,
                        previousMonthSales: 0,
                        previousYearSameMonthSales: 0,
                        annualSales: 0,
                        previousYearAnnualSales: 0,
                        monthlySalesChartLabels: [],
                        monthlySalesChartData: [],
                        previousYearMonthlySalesChartData: [],
                        // salesByPaymentMethod: [], 
                        totalOrdersCount: 0,
                        monthlyOrdersCount: 0
                    },
                    productSummary: { // 상품 요약 데이터
                        totalProducts: 0,
                        inStockProducts: 0,
                        lowStockProducts: 0,
                        topSellingProducts: []
                    },
                    userSummary: { // 회원 요약 데이터
                        totalUsers: 0,
                        newUsersToday: 0,
                        newUsersMonth: 0,
                        usersByGender: [],
                        usersWithOrdersCount: 0
                    },
                    requestSummary: { // 요청/상태 요약 데이터
                        deliveryInProgress: 0,
                        newReports: 0,
                        refundRequests: 0,
                        exchangeRequests: 0,
                        newProductInquiries: 0,
                        totalPendingRequestsCount: 0,
                        lowStockProductsCount: 0      // (상품 요약에도 있지만 여기에 다시 배치)
                    },
                    salesByCategory: { // 카테고리별 매출 비율
                        labels: [],
                        data: []
                    },
                    lowStockProductsList: [], // 품절 임박 상품 목록
                    autoRefresh: false, // 자동 새로고침 상태
                    autoRefreshInterval: null // 자동 새로고침 인터벌
                };
            },
            methods: {
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
                fetchDashboardData() {
                    this.fetchOrderStatusData();
                    this.fetchSalesSummaryData();
                    this.fetchProductSummaryData();
                    this.fetchUserSummaryData();
                    this.fetchRequestSummaryData();
                    this.fetchSalesByCategoryData();
                    this.fetchLowStockProductsData();
                },
                fetchOrderStatusData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/orderStatus.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.orderStatus.labels = response.data.map(item => item.STATUS);
                                self.orderStatus.data = response.data.map(item => item.COUNT);
                                self.orderStatus.colors = response.data.map(item => self.getOrderStatusColor(item.STATUS));
                                self.renderOrderStatusChart();
                            } else {
                                console.error('주문 현황 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('주문 현황 AJAX 오류:', error);
                        }
                    });
                },
                renderOrderStatusChart() {
                    const ctx = document.getElementById('orderStatusChart').getContext('2d');
                    if (this.orderStatusChart) {
                        this.orderStatusChart.destroy();
                    }
                    // 가로 막대 그래프로 변경 (항목이 많을 때 더 적합)
                    this.orderStatusChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: this.orderStatus.labels,
                            datasets: [{
                                label: '건수',
                                data: this.orderStatus.data,
                                backgroundColor: this.orderStatus.colors,
                                borderColor: this.orderStatus.colors,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            indexAxis: 'y', // 가로 막대 그래프로 변경
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                x: {
                                    beginAtZero: true,
                                    ticks: {
                                        stepSize: 1
                                    }
                                },
                                y: {
                                    ticks: {
                                        font: {
                                            size: 11
                                        }
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false // 범례 숨김 (색상이 각 막대에 표시되므로)
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            return context.parsed.x + '건';
                                        }
                                    }
                                }
                            }
                        }
                    });
                },
                renderMonthlySalesChart() {
                    const ctx = document.getElementById('monthlySalesChart').getContext('2d');
                    if (this.monthlySalesChart) {
                        this.monthlySalesChart.destroy(); // 기존 차트 파괴 후 재생성
                    }
                    this.monthlySalesChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: this.salesSummary.monthlySalesChartLabels,
                            datasets: [
                                {
                                    label: '올해 매출',
                                    data: this.salesSummary.monthlySalesChartData,
                                    borderColor: 'rgb(75, 192, 192)',
                                    backgroundColor: 'rgba(75, 192, 192, 0.1)',
                                    tension: 0.1,
                                    fill: true
                                },
                                {
                                    label: '전년도 매출',
                                    data: this.salesSummary.previousYearMonthlySalesChartData,
                                    borderColor: 'rgb(255, 99, 132)',
                                    backgroundColor: 'rgba(255, 99, 132, 0.1)',
                                    tension: 0.1,
                                    fill: true,
                                    borderDash: [5, 5] // 점선으로 표시
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return value.toLocaleString('ko-KR') + '원';
                                        }
                                    }
                                }
                            },
                            plugins: {
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            return context.dataset.label + ': ' + context.parsed.y.toLocaleString('ko-KR') + '원';
                                        }
                                    }
                                }
                            }
                        }
                    });
                },
                getOrderStatusColor(status) {
                    switch (status) {
                        case '신규주문': return '#FFC107'; // Warning (Yellow)
                        case '배송중': return '#17A2B8';  // Info (Teal)
                        case '배송완료': return '#28A745'; // Success (Green)
                        case '교환요청': return '#DC3545'; // Danger (Red)
                        case '교환완료': return '#6F42C1'; // Purple
                        case '취소요청': return '#6C757D'; // Secondary (Gray)
                        case '취소완료': return '#000000'; // Black
                        case '반품요청': return '#FD7E14'; // Orange
                        case '반품완료': return '#20C997'; // Emerald
                        default: return '#6C757D';
                    }
                },

                // 매출 요약 데이터 가져오기 및 그래프 그리기
                fetchSalesSummaryData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/salesSummary.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            console.log("Response for Sales Summary:", response); // 응답 데이터 확인
                            console.log("self object:", self); // self가 Vue 인스턴스를 잘 가리키는지 확인
                            console.log("renderMonthlySalesChart in self:", self.renderMonthlySalesChart); // 해당 함수가 존재하는지 확인
                            if (response.result === 'success') {
                                self.salesSummary.totalSales = response.data.totalSales;
                                self.salesSummary.monthlySales = response.data.monthlySales; // 이번 달 매출
                                self.salesSummary.previousMonthSales = response.data.previousMonthSales || 0; // 전월 매출
                                self.salesSummary.previousYearSameMonthSales = response.data.previousYearSameMonthSales || 0; // 전년 동월 매출
                                self.salesSummary.annualSales = response.data.annualSales || 0; // 연간 매출
                                self.salesSummary.previousYearAnnualSales = response.data.previousYearAnnualSales || 0; // 전년 연간 매출
                                self.salesSummary.monthlySalesChartLabels = response.data.monthlySalesList.map(item => item.SALES_MONTH); // 대문자
                                self.salesSummary.monthlySalesChartData = response.data.monthlySalesList.map(item => item.MONTHLY_SALES);   // 대문자
                                self.salesSummary.previousYearMonthlySalesChartData = (response.data.previousYearMonthlySalesList || []).map(item => item.MONTHLY_SALES); // 전년도 월별 매출
                                // self.salesSummary.salesByPaymentMethod = response.data.salesByPaymentMethod;
                                self.salesSummary.totalOrdersCount = response.data.totalOrdersCount;
                                self.salesSummary.monthlyOrdersCount = response.data.monthlyOrdersCount;
                                self.renderMonthlySalesChart();
                            } else {
                                console.error('매출 요약 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('매출 요약 AJAX 오류:', error);
                        }
                    });
                },

                // 상품 요약 데이터 가져오기 (기존 내용 그대로)
                fetchProductSummaryData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/productSummary.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.productSummary.totalProducts = response.data.totalProducts;
                                self.productSummary.inStockProducts = response.data.inStockProducts;
                                self.productSummary.lowStockProducts = response.data.lowStockProducts;
                                self.productSummary.topSellingProducts = response.data.topSellingProducts;
                            } else {
                                console.error('상품 요약 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('상품 요약 AJAX 오류:', error);
                        }
                    });
                },

                // 회원 요약 데이터 가져오기
                fetchUserSummaryData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/userSummary.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.userSummary.totalUsers = response.data.totalUsers;
                                self.userSummary.newUsersToday = response.data.newUsersToday;
                                self.userSummary.newUsersMonth = response.data.newUsersMonth;
                                self.userSummary.usersByGender = response.data.usersByGender; // 추가
                                self.userSummary.usersWithOrdersCount = response.data.usersWithOrdersCount; // 추가
                            } else {
                                console.error('회원 요약 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('회원 요약 AJAX 오류:', error);
                        }
                    });
                },

                // 요청/상태 요약 데이터 가져오기
                fetchRequestSummaryData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/requestSummary.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.requestSummary.deliveryInProgress = response.data.deliveryInProgress;
                                self.requestSummary.newReports = response.data.newReports;
                                self.requestSummary.refundRequests = response.data.refundRequests;
                                self.requestSummary.exchangeRequests = response.data.exchangeRequests;
                                self.requestSummary.newProductInquiries = response.data.newProductInquiries;
                                self.requestSummary.totalPendingRequestsCount = response.data.totalPendingRequestsCount; // 추가
                                self.requestSummary.lowStockProductsCount = response.data.lowStockProductsCount; // 추가 (재사용)
                            } else {
                                console.error('요청 요약 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('요청 요약 AJAX 오류:', error);
                        }
                    });
                },
                formatCurrency(value) {
                    if (value === null || value === undefined) return '0 원';
                    return value.toLocaleString('ko-KR') + ' 원';
                },
                // 비교 텍스트 생성 (증감률)
                getComparisonText(current, previous) {
                    if (!previous || previous === 0) {
                        return current > 0 ? '신규' : '0%';
                    }
                    const change = ((current - previous) / previous * 100).toFixed(1);
                    const sign = change >= 0 ? '+' : '';
                    return sign + change + '%';
                },
                // 비교 스타일 (증가: 초록색, 감소: 빨간색)
                getComparisonStyle(current, previous) {
                    if (!previous || previous === 0) {
                        return current > 0 ? 'color: #28a745; font-weight: bold;' : 'color: #6c757d;';
                    }
                    const change = ((current - previous) / previous * 100);
                    if (change > 0) {
                        return 'color: #28a745; font-weight: bold;';
                    } else if (change < 0) {
                        return 'color: #dc3545; font-weight: bold;';
                    } else {
                        return 'color: #6c757d;';
                    }
                },
                toggleAutoRefresh() {
                    this.autoRefresh = !this.autoRefresh;
                    if (this.autoRefresh) {
                        // 자동 새로고침 시작 (30초마다)
                        this.autoRefreshInterval = setInterval(() => {
                            this.fetchDashboardData();
                        }, 30000); // 30초
                    } else {
                        // 자동 새로고침 중지
                        if (this.autoRefreshInterval) {
                            clearInterval(this.autoRefreshInterval);
                            this.autoRefreshInterval = null;
                        }
                    }
                },
                goToPage(url) {
                    // 페이지 전환 전에 알림 읽음 처리가 완료되도록 약간의 지연 후 이동
                    // (markNotificationAsRead가 먼저 실행되도록)
                    setTimeout(() => {
                        window.location.href = url;
                    }, 100);
                },
                // 카테고리별 매출 비율 데이터 가져오기
                fetchSalesByCategoryData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/salesByCategory.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.salesByCategory.labels = response.data.map(item => item.CATEGORY_NAME);
                                self.salesByCategory.data = response.data.map(item => item.TOTAL_SALES);
                                self.renderSalesByCategoryChart();
                            } else {
                                console.error('카테고리별 매출 비율 데이터 로드 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('카테고리별 매출 비율 AJAX 오류:', error);
                        }
                    });
                },
                renderSalesByCategoryChart() {
                    const ctx = document.getElementById('salesByCategoryChart').getContext('2d');
                    if (this.salesByCategoryChart) {
                        this.salesByCategoryChart.destroy();
                    }
                    
                    // 파이 차트용 색상 생성 (다양한 색상)
                    const colors = this.generateCategoryColors(this.salesByCategory.labels.length);
                    
                    this.salesByCategoryChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: this.salesByCategory.labels,
                            datasets: [{
                                label: '매출액',
                                data: this.salesByCategory.data,
                                backgroundColor: colors,
                                borderColor: colors.map(color => color.replace('0.8', '1')),
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 15,
                                        font: {
                                            size: 12
                                        }
                                    }
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            let label = context.label || '';
                                            let value = context.parsed || 0;
                                            let total = context.dataset.data.reduce((a, b) => a + b, 0);
                                            let percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                            return label + ': ' + value.toLocaleString('ko-KR') + '원 (' + percentage + '%)';
                                        }
                                    }
                                }
                            }
                        }
                    });
                },
                generateColors(count) {
                    const colors = [];
                    const hueStep = 360 / count;
                    for (let i = 0; i < count; i++) {
                        const hue = i * hueStep;
                        colors.push(`hsla(${hue}, 70%, 50%, 0.7)`);
                    }
                    return colors;
                },
                // 카테고리별 매출 비율용 색상 생성 (더 선명한 색상)
                generateCategoryColors(count) {
                    // 미리 정의된 색상 팔레트 (카테고리별로 구분하기 쉽게)
                    const colorPalette = [
                        'rgba(54, 162, 235, 0.8)',   // 파란색
                        'rgba(255, 99, 132, 0.8)',   // 빨간색
                        'rgba(75, 192, 192, 0.8)',   // 청록색
                        'rgba(255, 206, 86, 0.8)',   // 노란색
                        'rgba(153, 102, 255, 0.8)',  // 보라색
                        'rgba(255, 159, 64, 0.8)',   // 주황색
                        'rgba(199, 199, 199, 0.8)',  // 회색
                        'rgba(83, 102, 255, 0.8)',   // 남색
                        'rgba(255, 99, 255, 0.8)',   // 자홍색
                        'rgba(99, 255, 132, 0.8)'    // 연두색
                    ];
                    
                    const colors = [];
                    for (let i = 0; i < count; i++) {
                        if (i < colorPalette.length) {
                            colors.push(colorPalette[i]);
                        } else {
                            // 색상이 부족하면 HSL로 생성
                            const hue = (i * 137.508) % 360; // 황금각을 이용한 색상 분산
                            colors.push(`hsla(${hue}, 70%, 50%, 0.8)`);
                        }
                    }
                    return colors;
                },
                // 품절 임박 상품 목록 데이터 가져오기
                fetchLowStockProductsData() {
                    let self = this;
                    $.ajax({
                        url: '/admin/dashboard/lowStockProducts.dox',
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response.result === 'success') {
                                self.lowStockProductsList = response.data;
                            } else {
                                console.error('품절 임박 상품 조회 실패:', response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('품절 임박 상품 AJAX 오류:', error);
                        }
                    });
                }
            },
            mounted() {
                this.fetchDashboardData();
            },
            beforeUnmount() {
                // 컴포넌트가 언마운트될 때 자동 새로고침 중지
                if (this.autoRefreshInterval) {
                    clearInterval(this.autoRefreshInterval);
                }
            }
        });

        app.mount('#app');
    </script>