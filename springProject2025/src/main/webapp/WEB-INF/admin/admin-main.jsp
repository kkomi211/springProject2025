<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
		    <div>관리자 test123 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none" @click="fnLogout">로그오프</a></div>
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
		</div>

		<!-- 본문 -->
		<div class="content">
            <div>
		        <h2>대시보드 요약</h2>
            </div>
            <div class="dashboard-grid">
                <!-- 주문 현황 (막대 그래프) -->
                <div class="dashboard-card" style="grid-column: span 2;">
                    <h3>주문 현황</h3>
                    <div class="dashboard-chart-container">
                        <canvas id="orderStatusChart"></canvas>
                    </div>
                </div>

                <!-- 상품 정보 핵심 요약 표 -->
                <div class="dashboard-card">
                    <h3>상품 요약</h3>
                    <div class="product-summary-section">
                        <div>
                            <h4>일반 요약</h4>
                            <table>
                                <tr>
                                    <th>항목</th>
                                    <th>값</th>
                                </tr>
                                <tr>
                                    <td>총 상품 수</td>
                                    <td>{{ productSummary.totalProducts }} 개</td>
                                </tr>
                                <tr>
                                    <td>재고 있음 상품 수</td>
                                    <td>{{ productSummary.inStockProducts }} 개</td>
                                </tr>
                                <tr>
                                    <td>품절 임박 상품 수</td>
                                    <td>{{ productSummary.lowStockProducts }} 개</td>
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
                                <tr v-if="productSummary.topSellingProducts && productSummary.topSellingProducts.length === 0">
                                    <td colspan="2">데이터 없음</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- 회원 요약 -->
                <div class="dashboard-card">
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
                                    <td>{{ gender.GENDER === 'M' ? '남성' : (gender.GENDER === 'F' ? '여성' : '기타') }}</td>
                                    <td>{{ gender.USER_COUNT }} 명</td>
                                </tr>
                                <tr v-if="userSummary.usersByGender.length === 0">
                                    <td colspan="2">데이터 없음</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- 매출 현황 (월별 라인 그래프) -->
                <div class="dashboard-card" style="grid-column: span 2;">
                    <h3>월별 매출 추이</h3>
                    <div class="dashboard-chart-container">
                        <canvas id="monthlySalesChart"></canvas>
                    </div>
                </div>

                <!-- 총 매출 현황 -->
                <div class="dashboard-card">
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

                <!-- 요청/상태 요약 -->
                <div class="dashboard-card">
                    <h3>요청/상태 요약</h3>
                    <div class="product-summary-section">
                        <div>
                            <h4>미처리 요청</h4>
                            <table>
                                <tr>
                                    <th>항목</th>
                                    <th>대기 수</th>
                                </tr>
                                <tr>
                                    <td>배송 중 주문</td>
                                    <td>{{ requestSummary.deliveryInProgress }} 건</td>
                                </tr>
                                <tr>
                                    <td>신규 신고 게시물</td>
                                    <td>{{ requestSummary.newReports }} 건</td>
                                </tr>
                                <tr>
                                    <td>반품 요청 대기</td>
                                    <td>{{ requestSummary.refundRequests }} 건</td>
                                </tr>
                                <tr>
                                    <td>교환 요청 대기</td>
                                    <td>{{ requestSummary.exchangeRequests }} 건</td>
                                </tr>
                                <tr>
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
                    monthlySalesChartLabels: [],
                    monthlySalesChartData: [],
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
                }
            };
        },
        methods: {
            fnLogout: function () {
                pageChange("/home.do", {sessionId : ""}); // 로그아웃 페이지로 이동
            },
            fetchDashboardData() {
                this.fetchOrderStatusData();
                this.fetchSalesSummaryData();
                this.fetchProductSummaryData();
                this.fetchUserSummaryData();
                this.fetchRequestSummaryData();
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
                this.orderStatusChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: this.orderStatus.labels,
                        datasets: [{
                            label: '건수',
                            data: this.orderStatus.data,
                            backgroundColor: this.orderStatus.colors,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {} // stepSize 제거
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
                    type: 'line', // 라인 차트로 변경
                    data: {
                        labels: this.salesSummary.monthlySalesChartLabels,
                        datasets: [{
                            label: '월별 매출',
                            data: this.salesSummary.monthlySalesChartData,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1,
                            fill: false
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true
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
                            self.salesSummary.monthlySalesChartLabels = response.data.monthlySalesList.map(item => item.SALES_MONTH); // 대문자
                            self.salesSummary.monthlySalesChartData = response.data.monthlySalesList.map(item => item.MONTHLY_SALES);   // 대문자
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
            }
        },
        mounted() {
            this.fetchDashboardData();
        }
    });

    app.mount('#app');
</script>