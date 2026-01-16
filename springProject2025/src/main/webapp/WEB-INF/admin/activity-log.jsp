<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 활동 로그 - RUNNERS HOUSE</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/admin-inquiry.css">
    <script src="/js/page-change.js"></script>
    <script src="/js/admin-notifications.js"></script>
</head>

<body class="adminbody">
    <div id="app">
        <!-- 상단 검은색 바 -->
        <div class="topbar">
            <div><strong>관리자 메인화면</strong></div>
            <div style="display: flex; align-items: center; gap: 15px;">
                <!-- 알림 아이콘 -->
                <div class="notification-icon-wrapper" @click="toggleNotificationPanel">
                    <span class="notification-bell">🔔</span>
                    <span v-if="notificationCounts.totalCount > 0" class="notification-badge">{{ notificationCounts.totalCount }}</span>
                </div>
                <div style="line-height: 1.2;">관리자 ${sessionId} 님 안녕하세요 &nbsp; <a href="javascript:;" class="text-white text-decoration-none"
                        @click="fnLogout">로그오프</a></div>
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
            <a href="/admin/product.do">상품 리스트</a>
            <a href="/admin/orders.do">주문 내역</a>
            <a href="/admin/board-report.do">게시판 신고 리스트</a>
            <a href="/admin/user-list.do">회원 관리 화면</a>
            <a href="/admin/activity-log.do" class="active">활동 로그</a>
        </div>
        <!-- 본문 -->
        <div class="content">
            <div>
                <h2>관리자 활동 로그</h2>
            </div>
            <div class="search-filters">
                <!-- 관리자 ID 검색 -->
                <div class="filter-group">
                    <input type="text" v-model="adminId" @keyup.enter="fnActivityLogList()" placeholder="관리자 ID 검색">
                    <button @click="fnActivityLogList()">검색</button>
                </div>

                <!-- 작업 유형 필터 -->
                <div class="filter-group">
                    <select v-model="actionType" @change="fnActivityLogList()">
                        <option value="">작업 유형 전체</option>
                        <option value="ORDER_UPDATE">주문 상태 변경</option>
                        <option value="ORDER_BATCH_UPDATE">주문 일괄 변경</option>
                        <option value="INQUIRY_ANSWER">문의 답변</option>
                        <option value="BOARD_DELETE">게시물 삭제</option>
                        <option value="BOARD_REPORT_PROCESS">신고 처리</option>
                        <option value="USER_DELETE">회원 삭제</option>
                        <option value="BANNER_UPDATE">배너 수정</option>
                    </select>
                </div>

                <!-- 대상 타입 필터 -->
                <div class="filter-group">
                    <select v-model="targetType" @change="fnActivityLogList()">
                        <option value="">대상 타입 전체</option>
                        <option value="ORDER">주문</option>
                        <option value="INQUIRY">문의</option>
                        <option value="BOARD">게시물</option>
                        <option value="BOARD_REPORT">신고</option>
                        <option value="USER">회원</option>
                    </select>
                </div>

                <!-- 기간 검색 필터 -->
                <div class="filter-group date-filter">
                    <span>기간 검색:</span>
                    <input type="date" v-model="startDate" @change="fnActivityLogList()">
                    <span>~</span>
                    <input type="date" v-model="endDate" @change="fnActivityLogList()">
                </div>

                <!-- 페이지당 표시 개수 선택 옵션 -->
                <div class="filter-group">
                    <span>표시 개수:</span>
                    <select v-model="pageSize" @change="fnActivityLogList()">
                        <option value="10">10개씩</option>
                        <option value="20">20개씩</option>
                        <option value="30">30개씩</option>
                    </select>
                </div>
            </div>

            <div>
                <!-- 로딩 스피너 -->
                <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                    <div class="loading-spinner"></div>
                    <div class="loading-text">데이터를 불러오는 중...</div>
                </div>
                
                <!-- 테이블 -->
                <table id="activity-log-table" v-if="!loading && list.length > 0">
                    <tr>
                        <th class="sortable-header" @click="sortTable('cDate')" :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">작업 시간</th>
                        <th class="sortable-header" @click="sortTable('adminId')" :class="{'sort-asc': sortColumn === 'adminId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'adminId' && sortDirection === 'desc'}">관리자 ID</th>
                        <th class="sortable-header" @click="sortTable('actionType')" :class="{'sort-asc': sortColumn === 'actionType' && sortDirection === 'asc', 'sort-desc': sortColumn === 'actionType' && sortDirection === 'desc'}">작업 유형</th>
                        <th>작업 내용</th>
                        <th>대상 타입</th>
                        <th>대상 ID</th>
                        <th>IP 주소</th>
                    </tr>
                    <tr v-for="item in sortedList" :key="item.logNo">
                        <td>{{item.cDate}}</td>
                        <td>{{item.adminId}}</td>
                        <td>
                            <span class="action-type-badge" :class="getActionTypeClass(item.actionType)">
                                {{getActionTypeLabel(item.actionType)}}
                            </span>
                        </td>
                        <td>{{item.actionDescription}}</td>
                        <td>{{item.targetType}}</td>
                        <td>{{item.targetId}}</td>
                        <td>{{item.ipAddress}}</td>
                    </tr>
                </table>
                
                <!-- 빈 데이터 메시지 -->
                <div v-if="!loading && list.length === 0" class="empty-state-card">
                    <div class="empty-icon">📋</div>
                    <div class="empty-title">활동 로그가 없습니다</div>
                    <div class="empty-description">검색 조건을 변경해보세요.</div>
                </div>

                <!-- 페이징 컴포넌트 -->
                <div class="pagination">
                    <a href="javascript:;" @click="fnChangePage(1)"
                        :class="{'disabled': currentPage === 1}">&laquo;</a>
                    <a href="javascript:;" @click="fnChangePage(currentPage - 1)"
                        :class="{'disabled': currentPage === 1}">&lt;</a>

                    <template v-for="page in pageNumbers" :key="page">
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
                sessionId: "",
                list: [],
                adminId: "",
                actionType: "",
                targetType: "",
                startDate: "",
                endDate: "",
                pageSize: "20",
                currentPage: 1,
                totalItems: 0,
                totalPages: 1,
                loading: false,
                sortColumn: '',
                sortDirection: 'asc',
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
            pageNumbers() {
                const pages = [];
                let startPage = Math.max(1, this.currentPage - 2);
                let endPage = Math.min(this.totalPages, startPage + 4);

                if (endPage < this.totalPages) {
                    startPage = Math.max(1, endPage - 4);
                }

                for (let i = startPage; i <= endPage; i++) {
                    pages.push(i);
                }
                return pages;
            },
            sortedList() {
                if (!this.sortColumn) return this.list;
                
                const sorted = [...this.list];
                sorted.sort((a, b) => {
                    let aVal = a[this.sortColumn];
                    let bVal = b[this.sortColumn];
                    
                    if (this.sortColumn === 'cDate') {
                        aVal = new Date(aVal);
                        bVal = new Date(bVal);
                    }
                    
                    if (aVal < bVal) return this.sortDirection === 'asc' ? -1 : 1;
                    if (aVal > bVal) return this.sortDirection === 'asc' ? 1 : -1;
                    return 0;
                });
                
                return sorted;
            }
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
            fnActivityLogList: function (page) {
                let self = this;
                if (page) {
                    self.currentPage = page;
                }

                self.loading = true;

                let param = {
                    adminId: self.adminId,
                    actionType: self.actionType,
                    targetType: self.targetType,
                    startDate: self.startDate,
                    endDate: self.endDate,
                    pageSize: self.pageSize,
                    currentPage: self.currentPage
                };

                $.ajax({
                    url: "/admin/activity-log.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.totalItems = data.totalItems;
                        self.totalPages = data.totalPages;

                        if (self.currentPage > self.totalPages && self.totalPages > 0) {
                            self.fnChangePage(1);
                        }
                    },
                    error: function() {
                        alert("데이터를 불러오는 중 오류가 발생했습니다.");
                    },
                    complete: function() {
                        self.loading = false;
                    }
                });
            },
            sortTable: function(column) {
                if (this.sortColumn === column) {
                    this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
                } else {
                    this.sortColumn = column;
                    this.sortDirection = 'asc';
                }
            },
            // 알림 관련 메서드
            fetchNotifications: function() {
                AdminNotifications.fetchNotifications(this);
            },
            toggleNotificationPanel: function() {
                AdminNotifications.toggleNotificationPanel(this);
            },
            markAsReadAndGo: function(type, url) {
                AdminNotifications.markAsReadAndGo(this, type, url);
            },
            fnChangePage: function (page) {
                if (page < 1 || page > this.totalPages) {
                    return;
                }
                this.fnActivityLogList(page);
            },
            getActionTypeLabel: function(actionType) {
                const labels = {
                    'ORDER_UPDATE': '주문 상태 변경',
                    'ORDER_BATCH_UPDATE': '주문 일괄 변경',
                    'INQUIRY_ANSWER': '문의 답변',
                    'BOARD_DELETE': '게시물 삭제',
                    'BOARD_REPORT_PROCESS': '신고 처리',
                    'USER_DELETE': '회원 삭제',
                    'BANNER_UPDATE': '배너 수정'
                };
                return labels[actionType] || actionType;
            },
            getActionTypeClass: function(actionType) {
                const classes = {
                    'ORDER_UPDATE': 'action-order',
                    'ORDER_BATCH_UPDATE': 'action-order',
                    'INQUIRY_ANSWER': 'action-inquiry',
                    'BOARD_DELETE': 'action-board',
                    'BOARD_REPORT_PROCESS': 'action-report',
                    'USER_DELETE': 'action-user',
                    'BANNER_UPDATE': 'action-banner'
                };
                return classes[actionType] || '';
            }
        },
        mounted() {
            let self = this;
            const today = new Date();
            self.endDate = today.toISOString().split('T')[0];
            const sevenDaysAgo = new Date();
            sevenDaysAgo.setDate(today.getDate() - 7);
            self.startDate = sevenDaysAgo.toISOString().split('T')[0];

            self.pageSize = "20";
            self.fnActivityLogList();
            AdminNotifications.init(self);
        },
        beforeUnmount() {
            AdminNotifications.cleanup(this);
        }
    });

    app.mount('#app');
</script>

<style>
    .action-type-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 0.85rem;
        font-weight: 600;
    }
    
    .action-order {
        background-color: #e3f2fd;
        color: #1976d2;
    }
    
    .action-inquiry {
        background-color: #f3e5f5;
        color: #7b1fa2;
    }
    
    .action-board {
        background-color: #fff3e0;
        color: #e65100;
    }
    
    .action-report {
        background-color: #ffebee;
        color: #c62828;
    }
    
    .action-user {
        background-color: #e8f5e9;
        color: #2e7d32;
    }
    
    .action-banner {
        background-color: #f1f8e9;
        color: #558b2f;
    }
</style>

