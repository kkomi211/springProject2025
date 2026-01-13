<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>주문 내역 관리 - RUNNERS HOUSE</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                <div>관리자 ${sessionId} 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none"
                        @click="fnLogout">로그오프</a></div>
            </div>

            <!-- 메뉴 바 (검은색) -->
            <div class="nav-black">
                <a href="/admin.do">MAIN</a>
                <a href="/admin/banner.do">배너 이미지 관리</a>
                <a href="/admin/inquiry.do">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do" class="active">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
            </div>

            <!-- 본문 -->
            <div class="content">
                <div>
                    <h2>주문 내역 관리</h2>
                </div>
                <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnOrdersList()" placeholder="검색">
                        <button @click="fnOrdersList()">검색</button>
                    </div>

                    <!-- 상태 필터 -->
                    <div class="filter-group">
                        <select v-model="statusOption" @change="fnOrdersList()">
                            <option value="">상태 전체</option>
                            <option value="신규주문">신규주문</option>
                            <option value="배송중">배송중</option>
                            <option value="배송완료">배송완료</option>
                        </select>
                    </div>

                    <!-- 기간 검색 필터 -->
                    <div class="filter-group date-filter">
                        <span>기간 검색:</span>
                        <input type="date" v-model="startDate" @change="fnOrdersList()">
                        <span>~</span>
                        <input type="date" v-model="endDate" @change="fnOrdersList()">
                    </div>

                    <!-- 페이지당 표시 개수 선택 옵션 -->
                    <div class="filter-group">
                        <span>표시 개수:</span>
                        <select v-model="pageSize" @change="fnOrdersList()">
                            <option value="5">5개씩</option>
                            <option value="10">10개씩</option>
                            <option value="15">15개씩</option>
                        </select>
                    </div>

                    <!-- 엑셀 다운로드 버튼 -->
                    <div class="filter-group">
                        <button @click="downloadExcel()" style="background-color: #28a745; color: white; padding: 8px 18px; border: none; border-radius: 5px; cursor: pointer; font-weight: 600;">
                            📥 엑셀 다운로드
                        </button>
                    </div>
                </div>

                <div>
                    <!-- 로딩 스피너 -->
                    <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                        <div class="loading-spinner"></div>
                        <div class="loading-text">데이터를 불러오는 중...</div>
                    </div>
                    
                    <!-- 일괄 처리 버튼 -->
                    <div v-if="!loading && list.length > 0 && hasUpdatableOrders" style="margin-bottom: 15px; display: flex; gap: 10px; align-items: center; flex-wrap: wrap;">
                        <button @click="selectAll" style="padding: 8px 15px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            전체 선택
                        </button>
                        <button @click="deselectAll" style="padding: 8px 15px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            전체 해제
                        </button>
                        <select v-model="batchStatus" style="padding: 8px 15px; border: 1px solid #ced4da; border-radius: 5px;">
                            <option value="">상태 선택</option>
                            <option v-if="canChangeToShipping" value="배송중">배송중</option>
                            <option v-if="canChangeToDelivered" value="배송완료">배송완료</option>
                        </select>
                        <button @click="batchUpdateStatus" :disabled="selectedOrders.length === 0 || !batchStatus" 
                            style="padding: 8px 15px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;"
                            :style="{'opacity': (selectedOrders.length === 0 || !batchStatus) ? 0.5 : 1, 'cursor': (selectedOrders.length === 0 || !batchStatus) ? 'not-allowed' : 'pointer'}"
                            :title="getBatchButtonTooltip()">
                            선택 항목 일괄 변경 ({{ selectedOrders.length }})
                        </button>
                        <span v-if="selectedOrders.length === 0 || !batchStatus || (selectedOrdersStatus.hasNew && selectedOrdersStatus.hasShipping)" 
                            style="color: #6c757d; font-size: 0.9em; margin-left: 5px;">
                            {{ getBatchButtonTooltip() }}
                        </span>
                    </div>
                    <div v-else-if="!loading && list.length > 0 && !hasUpdatableOrders" style="margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 5px; color: #6c757d; font-size: 0.9em;">
                        💡 현재 페이지에는 일괄 변경 가능한 주문(신규주문, 배송중)이 없습니다.
                    </div>

                    <!-- 테이블 -->
                    <table id="orders-list-table" v-if="!loading && list.length > 0">
                        <tr>
                            <th style="width: 50px;">
                                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected">
                            </th>
                            <th class="sortable-header" @click="sortTable('orderNo')" :class="{'sort-asc': sortColumn === 'orderNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'orderNo' && sortDirection === 'desc'}">주문번호</th>
                            <th class="sortable-header" @click="sortTable('userId')" :class="{'sort-asc': sortColumn === 'userId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'userId' && sortDirection === 'desc'}">고객ID</th>
                            <th class="sortable-header" @click="sortTable('name')" :class="{'sort-asc': sortColumn === 'name' && sortDirection === 'asc', 'sort-desc': sortColumn === 'name' && sortDirection === 'desc'}">고객명</th>
                            <th class="sortable-header" @click="sortTable('productNo')" :class="{'sort-asc': sortColumn === 'productNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productNo' && sortDirection === 'desc'}">제품번호</th>
                            <th class="sortable-header" @click="sortTable('paymentAmount')" :class="{'sort-asc': sortColumn === 'paymentAmount' && sortDirection === 'asc', 'sort-desc': sortColumn === 'paymentAmount' && sortDirection === 'desc'}">결제금액</th>
                            <th class="sortable-header" @click="sortTable('cDate')" :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">주문일자</th>
                            <th class="sortable-header" @click="sortTable('status')" :class="{'sort-asc': sortColumn === 'status' && sortDirection === 'asc', 'sort-desc': sortColumn === 'status' && sortDirection === 'desc'}">상태</th>
                            <th>상태변경</th>
                        </tr>
                        <tr v-for="item in sortedList" :key="item.orderNo">
                            <td>
                                <input type="checkbox" :value="item.orderNo" v-model="selectedOrders"
                                    v-if="item.status === '신규주문' || item.status === '배송중'">
                            </td>
                            <td>{{item.orderNo}}</td>
                            <td>{{item.userId}}</td>
                            <td>{{item.name}}</td>
                            <td>{{item.productNo}}</td>
                            <td>{{item.paymentAmount.toLocaleString()}}원</td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <span v-if="item.status === '신규주문'" class="status-new">신규주문</span>
                                <span v-else-if="item.status === '배송중'" class="status-shipping">배송중</span>
                                <span v-else-if="item.status === '배송완료'" class="status-delivered">배송완료</span>
                            </td>
                            <td>
                                <button v-if="item.status === '신규주문'" @click="fnUpdateStatus(item.orderNo, '배송중')"
                                    class="btn-update-status">배송중으로 변경</button>
                                <button v-else-if="item.status === '배송중'" @click="fnUpdateStatus(item.orderNo, '배송완료')"
                                    class="btn-update-status">배송완료로 변경</button>
                                <span v-else>-</span>
                            </td>
                        </tr>
                    </table>
                    
                    <!-- 빈 데이터 메시지 -->
                    <div v-if="!loading && list.length === 0" class="empty-state-card">
                        <div class="empty-icon">📦</div>
                        <div class="empty-title">주문 내역이 없습니다</div>
                        <div class="empty-description">검색 조건을 변경하거나 다른 기간을 선택해보세요.</div>
                    </div>

                    <!-- 페이징 컴포넌트 -->
                    <div class="pagination">
                        <a href="javascript:;" @click="fnChangePage(1)"
                            :class="{'disabled': currentPage === 1}">&laquo;</a>
                        <a href="javascript:;" @click="fnChangePage(currentPage - 1)"
                            :class="{'disabled': currentPage === 1}">&lt;</a>

                        <template v-for="page in pageNumbers">
                            <a href="javascript:;" @click="fnChangePage(page)"
                                :class="{'active': currentPage === page}">{{ page }}</a>
                        </template>

                        <a href="javascript:;" @click="fnChangePage(currentPage + 1)"
                            :class="{'disabled': currentPage === totalPages}">&gt;</a>
                        <a href="javascript:;" @click="fnChangePage(totalPages)"
                            :class="{'disabled': currentPage === totalPages}">&raquo;</a>
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
                    // 변수 - (key : value)
                    sessionId: "",
                    list: [],
                    keyword: "",
                    statusOption: "",
                    startDate: "",
                    endDate: "",
                    pageSize: "10", // 기본 페이지 크기 10개로 설정
                    currentPage: 1, // 현재 페이지
                    totalItems: 0,  // 전체 아이템 수
                    totalPages: 1,   // 전체 페이지 수
                    loading: false, // 로딩 상태
                    sortColumn: '', // 정렬 컬럼
                    sortDirection: 'asc', // 정렬 방향
                    selectedOrders: [], // 선택된 주문 번호 리스트
                    batchStatus: '' // 일괄 변경할 상태
                };
            },
            computed: {
                // 페이지 번호 배열 계산 (최대 5개 페이지 번호만 표시)
                pageNumbers() {
                    const pages = [];
                    let startPage = Math.max(1, this.currentPage - 2);
                    let endPage = Math.min(this.totalPages, startPage + 4);

                    // 끝 페이지가 전체 페이지보다 작으면 시작 페이지를 조정
                    if (endPage < this.totalPages) {
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
                        if (this.sortColumn === 'cDate') {
                            aVal = new Date(aVal);
                            bVal = new Date(bVal);
                        }
                        
                        // 숫자 정렬
                        if (this.sortColumn === 'orderNo' || this.sortColumn === 'productNo') {
                            aVal = parseInt(aVal);
                            bVal = parseInt(bVal);
                        }
                        
                        // 금액 정렬
                        if (this.sortColumn === 'paymentAmount') {
                            aVal = parseFloat(aVal);
                            bVal = parseFloat(bVal);
                        }
                        
                        if (aVal < bVal) return this.sortDirection === 'asc' ? -1 : 1;
                        if (aVal > bVal) return this.sortDirection === 'asc' ? 1 : -1;
                        return 0;
                    });
                    
                    return sorted;
                },
                // 전체 선택 여부
                isAllSelected() {
                    const updatableList = this.list.filter(item => 
                        item.status === '신규주문' || item.status === '배송중');
                    return updatableList.length > 0 && updatableList.every(item => 
                        this.selectedOrders.includes(item.orderNo));
                },
                // 일괄 변경 가능한 주문이 있는지 확인
                hasUpdatableOrders() {
                    return this.list.some(item => 
                        item.status === '신규주문' || item.status === '배송중');
                },
                // 선택된 주문들의 상태 정보
                selectedOrdersStatus() {
                    if (this.selectedOrders.length === 0) {
                        return { hasNew: false, hasShipping: false, allNew: false, allShipping: false };
                    }
                    const selectedItems = this.list.filter(item => 
                        this.selectedOrders.includes(item.orderNo));
                    const hasNew = selectedItems.some(item => item.status === '신규주문');
                    const hasShipping = selectedItems.some(item => item.status === '배송중');
                    const allNew = selectedItems.length > 0 && selectedItems.every(item => item.status === '신규주문');
                    const allShipping = selectedItems.length > 0 && selectedItems.every(item => item.status === '배송중');
                    return { hasNew, hasShipping, allNew, allShipping };
                },
                // 배송중으로 변경 가능한지 확인
                canChangeToShipping() {
                    if (this.selectedOrders.length === 0) return false;
                    const status = this.selectedOrdersStatus;
                    // 신규주문만 선택된 경우에만 배송중으로 변경 가능
                    return status.allNew;
                },
                // 배송완료로 변경 가능한지 확인
                canChangeToDelivered() {
                    if (this.selectedOrders.length === 0) return false;
                    const status = this.selectedOrdersStatus;
                    // 배송중만 선택된 경우에만 배송완료로 변경 가능
                    return status.allShipping;
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
                fnOrdersList: function (page) {
                    let self = this;
                    // 페이지 지정이 있으면 해당 페이지로, 없으면 현재 페이지 유지
                    if (page) {
                        self.currentPage = page;
                    }

                    self.loading = true; // 로딩 시작

                    let param = {
                        keyword: self.keyword,
                        statusOption: self.statusOption,
                        startDate: self.startDate,
                        endDate: self.endDate,
                        pageSize: self.pageSize,
                        currentPage: self.currentPage
                    };

                    $.ajax({
                        url: "/admin/orders.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.totalItems = data.totalItems;
                            self.totalPages = data.totalPages;

                            // 현재 페이지가 총 페이지 수보다 크면 첫 페이지로 이동
                            if (self.currentPage > self.totalPages && self.totalPages > 0) {
                                self.fnChangePage(1);
                            }
                        },
                        error: function() {
                            alert("데이터를 불러오는 중 오류가 발생했습니다.");
                        },
                        complete: function() {
                            self.loading = false; // 로딩 종료
                        }
                    });
                },
                sortTable: function(column) {
                    if (this.sortColumn === column) {
                        // 같은 컬럼 클릭 시 정렬 방향 전환
                        this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
                    } else {
                        // 다른 컬럼 클릭 시 오름차순으로 설정
                        this.sortColumn = column;
                        this.sortDirection = 'asc';
                    }
                },
                fnChangePage: function (page) {
                    // 페이지 범위 체크
                    if (page < 1 || page > this.totalPages) {
                        return;
                    }
                    this.fnOrdersList(page);
                },
                fnUpdateStatus: function (orderNo, newStatus) {
                    let self = this;

                    if (!confirm(orderNo + "번 주문을 '" + newStatus + "' 상태로 변경하시겠습니까?")) {
                        return;
                    }

                    let param = {
                        orderNo: orderNo,
                        newStatus: newStatus
                    };

                    $.ajax({
                        url: "/admin/orders/updateStatus.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                alert("상태가 변경되었습니다.");
                                self.fnOrdersList(self.currentPage); // 현재 페이지 유지하며 새로고침
                            } else {
                                alert("상태 변경에 실패했습니다: " + (data.message || "다시 시도해 주세요."));
                            }
                        }
                    });
                },
                downloadExcel: function() {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.statusOption) params.append('statusOption', self.statusOption);
                    if (self.startDate) params.append('startDate', self.startDate);
                    if (self.endDate) params.append('endDate', self.endDate);
                    
                    window.location.href = '/admin/orders/excel.dox?' + params.toString();
                },
                selectAll: function() {
                    const updatableList = this.list.filter(item => 
                        item.status === '신규주문' || item.status === '배송중');
                    this.selectedOrders = updatableList.map(item => item.orderNo);
                    // 선택 변경 시 상태 드롭다운 초기화
                    this.batchStatus = '';
                },
                deselectAll: function() {
                    this.selectedOrders = [];
                    this.batchStatus = '';
                },
                toggleSelectAll: function(event) {
                    if (event.target.checked) {
                        this.selectAll();
                    } else {
                        this.deselectAll();
                    }
                },
                batchUpdateStatus: function() {
                    let self = this;
                    if (self.selectedOrders.length === 0) {
                        alert("선택된 주문이 없습니다.");
                        return;
                    }
                    if (!self.batchStatus) {
                        alert("변경할 상태를 선택해주세요.");
                        return;
                    }
                    
                    // 프론트엔드 유효성 검사
                    const status = self.selectedOrdersStatus;
                    if (self.batchStatus === '배송완료' && status.hasNew) {
                        alert("신규주문은 배송완료로 직접 변경할 수 없습니다. 먼저 배송중으로 변경해주세요.");
                        return;
                    }
                    if (self.batchStatus === '배송중' && status.allShipping) {
                        alert("이미 배송중 상태인 주문은 배송중으로 변경할 수 없습니다.");
                        return;
                    }
                    
                    if (!confirm(self.selectedOrders.length + "개의 주문을 '" + self.batchStatus + "' 상태로 변경하시겠습니까?")) {
                        return;
                    }
                    
                    let param = {
                        orderNos: self.selectedOrders.join(','),
                        newStatus: self.batchStatus
                    };
                    
                    $.ajax({
                        url: "/admin/orders/batchUpdateStatus.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result === "success") {
                                let message = data.message || "일괄 상태 변경이 완료되었습니다.";
                                if (data.failDetails) {
                                    message += "\n\n실패 상세:\n" + data.failDetails;
                                }
                                alert(message);
                                self.selectedOrders = [];
                                self.batchStatus = '';
                                self.fnOrdersList(self.currentPage);
                            } else {
                                alert("일괄 상태 변경 중 오류가 발생했습니다: " + (data.message || ""));
                            }
                        },
                        error: function() {
                            alert("일괄 상태 변경 중 오류가 발생했습니다.");
                        }
                    });
                },
                getBatchButtonTooltip: function() {
                    if (this.selectedOrders.length === 0) {
                        return "주문을 선택해주세요.";
                    }
                    if (!this.batchStatus) {
                        const status = this.selectedOrdersStatus;
                        if (status.hasNew && status.hasShipping) {
                            return "혼합된 상태입니다. 신규주문만 선택하면 배송중으로, 배송중만 선택하면 배송완료로 변경 가능합니다.";
                        }
                        return "변경할 상태를 선택해주세요.";
                    }
                    return "";
                }
            },
            watch: {
                // 선택된 주문이 변경될 때 상태 드롭다운 초기화
                selectedOrders: {
                    handler: function(newVal, oldVal) {
                        // 선택이 변경되면 상태 드롭다운 초기화
                        if (newVal.length !== oldVal.length || 
                            (newVal.length > 0 && JSON.stringify(newVal.sort()) !== JSON.stringify(oldVal.sort()))) {
                            this.batchStatus = '';
                        }
                    },
                    deep: true
                }
            },
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                // 오늘 날짜를 기본 종료일로 설정
                const today = new Date();
                self.endDate = today.toISOString().split('T')[0];

                // 30일 전 날짜를 기본 시작일로 설정
                const thirtyDaysAgo = new Date();
                thirtyDaysAgo.setDate(today.getDate() - 30);
                self.startDate = thirtyDaysAgo.toISOString().split('T')[0];

                // 기본 페이지 크기 설정
                self.pageSize = "10";

                self.fnOrdersList();
            }
        });

        app.mount('#app');
    </script>