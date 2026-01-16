<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>게시판 신고 관리 - RUNNERS HOUSE</title>
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
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
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
                <a href="/admin/board-report.do" class="active">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
                <a href="/admin/activity-log.do">활동 로그</a>
            </div>
            <!-- 본문 -->
            <div class="content">
                <div>
                    <h2>신고 게시물 관리</h2>
                </div>
                <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnGetBoardReportList()"
                            placeholder="제목, 내용, 작성자ID, 신고자ID 검색">
                        <button @click="fnGetBoardReportList()">검색</button>
                    </div>

                    <!-- 상태 필터 -->
                    <div class="filter-group">
                        <select v-model="reportStatus" @change="fnGetBoardReportList()">
                            <option value="">상태 전체</option>
                            <option value="N">처리 요망</option>
                            <option value="Y">처리 완료</option>
                        </select>
                    </div>

                    <!-- 기간 검색 필터 (신고 날짜 기준) -->
                    <div class="filter-group date-filter">
                        <span>신고일 기준:</span>
                        <input type="date" v-model="startDate" @change="fnGetBoardReportList()">
                        <span>~</span>
                        <input type="date" v-model="endDate" @change="fnGetBoardReportList()">
                    </div>

                    <!-- 페이지당 표시 개수 선택 옵션 -->
                    <div class="filter-group">
                        <span>표시 개수:</span>
                        <select v-model="pageSize" @change="fnGetBoardReportList()">
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
                    
                    <!-- 테이블 -->
                    <table id="board-report-list-table" v-if="!loading && list.length > 0">
                        <tr>
                            <th class="sortable-header" @click="sortTable('reportBoardNo')" :class="{'sort-asc': sortColumn === 'reportBoardNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'reportBoardNo' && sortDirection === 'desc'}">신고식별번호</th>
                            <th class="sortable-header" @click="sortTable('reportedBoardNo')" :class="{'sort-asc': sortColumn === 'reportedBoardNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'reportedBoardNo' && sortDirection === 'desc'}">신고게시물번호</th>
                            <th class="sortable-header" @click="sortTable('reporterId')" :class="{'sort-asc': sortColumn === 'reporterId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'reporterId' && sortDirection === 'desc'}">신고자 아이디 (이름)</th>
                            <th class="sortable-header" @click="sortTable('cDate')" :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">신고 날짜</th>
                            <th class="sortable-header" @click="sortTable('reportStatus')" :class="{'sort-asc': sortColumn === 'reportStatus' && sortDirection === 'asc', 'sort-desc': sortColumn === 'reportStatus' && sortDirection === 'desc'}">신고확인상태</th>
                        </tr>
                        <tr v-for="item in sortedList" :key="item.reportBoardNo">
                            <td>{{item.reportBoardNo}}</td>
                            <td>{{item.reportedBoardNo}} <br> ({{item.boardTitle}})</td>
                            <td>{{item.reporterId}} <br> ({{item.reporterName}})</td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <button class="status-button"
                                    :class="{'n': item.reportStatus === 'N', 'y': item.reportStatus === 'Y'}"
                                    :disabled="item.reportStatus === 'Y'" @click="goToDetail(item.reportBoardNo)">
                                    {{item.reportStatus === 'N' ? '처리요망' : '처리완료'}}
                                </button>
                            </td>
                        </tr>
                    </table>
                    
                    <!-- 빈 데이터 메시지 -->
                    <div v-if="!loading && list.length === 0" class="empty-state-card">
                        <div class="empty-icon">🚨</div>
                        <div class="empty-title">신고된 게시물이 없습니다</div>
                        <div class="empty-description">검색 조건을 변경하거나 다른 기간을 선택해보세요.</div>
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
            
            <!-- 신고 게시물 상세보기 모달 -->
            <div v-if="showDetailModal" class="modal-overlay" @click.self="closeDetailModal">
                <div class="modal-content inquiry-modal">
                    <div class="modal-header">
                        <h3>신고 게시물 상세보기 및 처리</h3>
                        <button @click="closeDetailModal" class="modal-close-btn">&times;</button>
                    </div>
                    <div class="modal-body" v-if="reportDetail">
                        <table class="detail-table">
                            <tr>
                                <th>신고식별번호</th>
                                <td>{{reportDetail.reportBoardNo}}</td>
                            </tr>
                            <tr>
                                <th>게시물 번호</th>
                                <td>{{reportDetail.reportedBoardNo}}</td>
                            </tr>
                            <tr>
                                <th>게시판 유형</th>
                                <td>{{getBoardType(reportDetail.boardType)}}</td>
                            </tr>
                            <tr>
                                <th>게시글 제목</th>
                                <td>{{reportDetail.boardTitle}}</td>
                            </tr>
                            <tr>
                                <th>게시글 작성자</th>
                                <td>{{reportDetail.boardUserId}} ({{reportDetail.boardAuthorName}})</td>
                            </tr>
                            <tr>
                                <th>신고자</th>
                                <td>{{reportDetail.reporterId}} ({{reportDetail.reporterName}})</td>
                            </tr>
                            <tr>
                                <th>신고 날짜</th>
                                <td>{{reportDetail.cDate}}</td>
                            </tr>
                            <tr>
                                <th>처리 상태</th>
                                <td>
                                    <span :class="{'status-button': true, 'n': reportDetail.reportStatus === 'N', 'y': reportDetail.reportStatus === 'Y'}">
                                        {{reportDetail.reportStatus === 'N' ? '처리요망' : '처리완료'}}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>게시글 내용</th>
                                <td>
                                    <div class="detail-content" v-html="reportDetail.boardContent"></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer" v-if="reportDetail">
                        <button @click="fnDeleteBoard" class="btn-register-answer" :disabled="reportDetail.reportStatus === 'Y'">삭제</button>
                        <button @click="fnProcessReport" class="btn-register-answer" :disabled="reportDetail.reportStatus === 'Y'">처리</button>
                        <button @click="closeDetailModal" class="btn-back">닫기</button>
                    </div>
                </div>
            </div>
            
            <!-- 알림 모달 -->
            <div v-if="showAlertModal" class="modal-overlay" @click.self="closeAlertModal">
                <div class="modal-content inquiry-modal">
                    <div class="modal-header">
                        <h3>{{ alertModalTitle }}</h3>
                        <button @click="closeAlertModal" class="modal-close-btn">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p style="font-size: 1rem; line-height: 1.6; color: #2d3748; white-space: pre-line;">{{ alertModalMessage }}</p>
                    </div>
                    <div class="modal-footer">
                        <button @click="closeAlertModal" class="btn-back">확인</button>
                    </div>
                </div>
            </div>
            
            <!-- 확인 모달 -->
            <div v-if="showConfirmModal" class="modal-overlay" @click.self="closeConfirmModal">
                <div class="modal-content inquiry-modal">
                    <div class="modal-header">
                        <h3>{{ confirmModalTitle }}</h3>
                        <button @click="closeConfirmModal" class="modal-close-btn">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p style="font-size: 1rem; line-height: 1.6; color: #2d3748; white-space: pre-line;">{{ confirmModalMessage }}</p>
                    </div>
                    <div class="modal-footer">
                        <button @click="confirmCancel" class="btn-back">취소</button>
                        <button @click="confirmOk" class="btn-register-answer">확인</button>
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
                    sessionId: "",
                    list: [],
                    keyword: "",
                    reportStatus: "N", // 기본값 '처리 요망'
                    startDate: "",
                    endDate: "",
                    pageSize: "10",
                    currentPage: 1,
                    totalItems: 0,
                    totalPages: 1,
                    loading: false, // 로딩 상태
                    sortColumn: '', // 정렬 컬럼
                    sortDirection: 'asc', // 정렬 방향
                    // 모달 관련
                    showDetailModal: false,
                    reportDetail: null,
                    showAlertModal: false,
                    alertModalTitle: '',
                    alertModalMessage: '',
                    showConfirmModal: false,
                    confirmModalTitle: '',
                    confirmModalMessage: '',
                    confirmCallback: null,
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
                        if (this.sortColumn === 'reportBoardNo' || this.sortColumn === 'reportedBoardNo') {
                            aVal = parseInt(aVal);
                            bVal = parseInt(bVal);
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
                fnGetBoardReportList: function (page) {
                    let self = this;
                    if (page) {
                        self.currentPage = page;
                    }

                    self.loading = true; // 로딩 시작

                    let param = {
                        keyword: self.keyword,
                        reportStatus: self.reportStatus,
                        startDate: self.startDate,
                        endDate: self.endDate,
                        pageSize: self.pageSize,
                        currentPage: self.currentPage
                    };

                    $.ajax({
                        url: "/admin/board-report.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("신고 게시물 리스트 데이터:", data);
                            self.list = data.list;
                            self.totalItems = data.totalItems;
                            self.totalPages = data.totalPages;

                            if (self.currentPage > self.totalPages && self.totalPages > 0) {
                                self.fnChangePage(self.totalPages); // 현재 페이지가 총 페이지를 초과하면 마지막 페이지로 이동
                            } else if (self.currentPage > self.totalPages && self.totalPages === 0) {
                                self.currentPage = 1; // 검색 결과 없을 때
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX Error:", status, error, xhr.responseText);
                            self.showAlert("오류", "신고 게시물 리스트 로드 중 오류가 발생했습니다.");
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
                    if (page < 1 || page > this.totalPages) {
                        return;
                    }
                    this.fnGetBoardReportList(page);
                },
                goToDetail(reportBoardNo) {
                    let self = this;
                    self.showDetailModal = true;
                    self.reportDetail = null;
                    
                    let param = {
                        reportBoardNo: reportBoardNo
                    };
                    
                    $.ajax({
                        url: "/admin/board-report-view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log("신고 게시물 상세 데이터:", data);
                            if (data.result === "success") {
                                self.reportDetail = data.detail;
                            } else {
                                self.showAlert("오류", "신고 게시물 정보를 불러오는데 실패했습니다: " + data.message);
                                self.closeDetailModal();
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX Error:", status, error, xhr.responseText);
                            self.showAlert("오류", "신고 게시물 상세 정보를 불러오는 중 오류가 발생했습니다.");
                            self.closeDetailModal();
                        }
                    });
                },
                closeDetailModal() {
                    this.showDetailModal = false;
                    this.reportDetail = null;
                },
                getBoardType(type) {
                    switch (type) {
                        case 'Q': return '일반문의게시판';
                        case 'F': return '자유게시판';
                        case 'B': return '공지게시판';
                        case 'R': return '대회게시판';
                        default: return type;
                    }
                },
                fnDeleteBoard: function () {
                    let self = this;
                    if (!self.reportDetail) return;
                    
                    self.showConfirm(
                        "게시글 삭제 확인",
                        "[" + self.getBoardType(self.reportDetail.boardType) + "] <" + self.reportDetail.boardTitle + "> 게시글을 정말로 삭제하시겠습니까? (삭제 시 신고 확인 상태는 '처리완료'로 변경됩니다.)",
                        function() {
                            let param = {
                                reportBoardNo: self.reportDetail.reportBoardNo,
                                reportedBoardNo: self.reportDetail.reportedBoardNo
                            };

                            $.ajax({
                                url: "/admin/board-report/deleteBoard.dox",
                                dataType: "json",
                                type: "POST",
                                data: param,
                                success: function (data) {
                                    if (data.result === "success") {
                                        self.showAlert("성공", data.message);
                                        self.closeDetailModal();
                                        self.fnGetBoardReportList(self.currentPage);
                                    } else {
                                        self.showAlert("실패", "게시글 삭제에 실패했습니다: " + data.message);
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error("AJAX Error:", status, error, xhr.responseText);
                                    self.showAlert("오류", "게시글 삭제 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                                }
                            });
                        }
                    );
                },
                fnProcessReport: function () {
                    let self = this;
                    if (!self.reportDetail) return;
                    
                    self.showConfirm(
                        "신고 처리 확인",
                        "[" + self.getBoardType(self.reportDetail.boardType) + "] <" + self.reportDetail.boardTitle + "> 게시글에 대한 신고를 '처리완료' 상태로 변경하시겠습니까? (게시글은 삭제되지 않습니다.)",
                        function() {
                            let param = {
                                reportBoardNo: self.reportDetail.reportBoardNo
                            };

                            $.ajax({
                                url: "/admin/board-report/process.dox",
                                dataType: "json",
                                type: "POST",
                                data: param,
                                success: function (data) {
                                    if (data.result === "success") {
                                        self.showAlert("성공", data.message);
                                        self.reportDetail.reportStatus = 'Y';
                                        self.fnGetBoardReportList(self.currentPage);
                                    } else {
                                        self.showAlert("실패", "신고 처리 상태 변경에 실패했습니다: " + data.message);
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error("AJAX Error:", status, error, xhr.responseText);
                                    self.showAlert("오류", "신고 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                                }
                            });
                        }
                    );
                },
                // 알림 모달 표시
                showAlert: function(title, message) {
                    this.alertModalTitle = title;
                    this.alertModalMessage = message;
                    this.showAlertModal = true;
                },
                // 알림 모달 닫기
                closeAlertModal: function() {
                    this.showAlertModal = false;
                    this.alertModalTitle = '';
                    this.alertModalMessage = '';
                },
                // 확인 모달 표시
                showConfirm: function(title, message, callback) {
                    this.confirmModalTitle = title;
                    this.confirmModalMessage = message;
                    this.confirmCallback = callback;
                    this.showConfirmModal = true;
                },
                // 확인 모달 닫기
                closeConfirmModal: function() {
                    this.showConfirmModal = false;
                    this.confirmModalTitle = '';
                    this.confirmModalMessage = '';
                    this.confirmCallback = null;
                },
                // 확인 모달 확인 버튼
                confirmOk: function() {
                    if (this.confirmCallback) {
                        this.confirmCallback();
                    }
                    this.closeConfirmModal();
                },
                // 확인 모달 취소 버튼
                confirmCancel: function() {
                    this.closeConfirmModal();
                },
                downloadExcel: function() {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.reportStatus) params.append('reportStatus', self.reportStatus);
                    if (self.startDate) params.append('startDate', self.startDate);
                    if (self.endDate) params.append('endDate', self.endDate);
                    
                    window.location.href = '/admin/board-report/excel.dox?' + params.toString();
                },
                // 실시간 알림 개수 가져오기
                fetchNotifications: function() {
                    let self = this;
                    
                    // 로컬 스토리지에서 읽음 처리된 알림의 마지막 확인 시간 가져오기
                    const lastCheckInquiry = localStorage.getItem('lastNotificationCheck_inquiry');
                    const lastCheckOrder = localStorage.getItem('lastNotificationCheck_order');
                    const lastCheckReport = localStorage.getItem('lastNotificationCheck_report');
                    
                    // 서버에 마지막 확인 시간 전달 (ISO 8601 형식)
                    let params = {};
                    if (lastCheckInquiry && lastCheckInquiry.trim() !== '' && lastCheckInquiry !== 'null') {
                        try {
                            // ISO 8601 형식을 Oracle DATE 형식으로 변환 (YYYY-MM-DD HH24:MI:SS)
                            const date = new Date(lastCheckInquiry);
                            if (!isNaN(date.getTime())) {
                                const year = date.getFullYear();
                                const month = String(date.getMonth() + 1).padStart(2, '0');
                                const day = String(date.getDate()).padStart(2, '0');
                                const hours = String(date.getHours()).padStart(2, '0');
                                const minutes = String(date.getMinutes()).padStart(2, '0');
                                const seconds = String(date.getSeconds()).padStart(2, '0');
                                params.lastCheckInquiry = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
                            }
                        } catch (e) {
                            console.error('날짜 변환 오류 (inquiry):', e);
                        }
                    }
                    if (lastCheckOrder && lastCheckOrder.trim() !== '' && lastCheckOrder !== 'null') {
                        try {
                            const date = new Date(lastCheckOrder);
                            if (!isNaN(date.getTime())) {
                                const year = date.getFullYear();
                                const month = String(date.getMonth() + 1).padStart(2, '0');
                                const day = String(date.getDate()).padStart(2, '0');
                                const hours = String(date.getHours()).padStart(2, '0');
                                const minutes = String(date.getMinutes()).padStart(2, '0');
                                const seconds = String(date.getSeconds()).padStart(2, '0');
                                params.lastCheckOrder = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
                            }
                        } catch (e) {
                            console.error('날짜 변환 오류 (order):', e);
                        }
                    }
                    if (lastCheckReport && lastCheckReport.trim() !== '' && lastCheckReport !== 'null') {
                        try {
                            const date = new Date(lastCheckReport);
                            if (!isNaN(date.getTime())) {
                                const year = date.getFullYear();
                                const month = String(date.getMonth() + 1).padStart(2, '0');
                                const day = String(date.getDate()).padStart(2, '0');
                                const hours = String(date.getHours()).padStart(2, '0');
                                const minutes = String(date.getMinutes()).padStart(2, '0');
                                const seconds = String(date.getSeconds()).padStart(2, '0');
                                params.lastCheckReport = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
                            }
                        } catch (e) {
                            console.error('날짜 변환 오류 (report):', e);
                        }
                    }
                    
                    $.ajax({
                        url: '/admin/notifications.dox',
                        type: 'GET',
                        dataType: 'json',
                        data: params,
                        success: function (response) {
                            if (response.result === 'success') {
                                // 서버에서 받은 알림 개수 (이미 읽음 처리된 것은 제외됨)
                                self.notificationCounts = {
                                    newInquiryCount: response.newInquiryCount || 0,
                                    newOrderCount: response.newOrderCount || 0,
                                    newBoardReportCount: response.newBoardReportCount || 0,
                                    totalCount: (response.newInquiryCount || 0) + (response.newOrderCount || 0) + (response.newBoardReportCount || 0)
                                };
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('알림 조회 오류:', error);
                        }
                    });
                },
                // 알림 패널 토글
                toggleNotificationPanel: function() {
                    this.showNotificationPanel = !this.showNotificationPanel;
                },
                // 페이지 이동
                goToPage: function(url) {
                    window.location.href = url;
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
                // 개별 알림 항목 클릭 시 읽음 처리
                markNotificationAsRead: function(type) {
                    try {
                        // 로컬 스토리지에 마지막 확인 시간 저장
                        const now = new Date().toISOString();
                        localStorage.setItem('lastNotificationCheck_' + type, now);
                        
                        // 해당 타입의 알림을 읽음 처리 (즉시 UI 업데이트)
                        if (type === 'inquiry') {
                            this.notificationCounts.newInquiryCount = 0;
                        } else if (type === 'order') {
                            this.notificationCounts.newOrderCount = 0;
                        } else if (type === 'report') {
                            this.notificationCounts.newBoardReportCount = 0;
                        }
                        // 전체 개수 재계산
                        this.notificationCounts.totalCount = 
                            this.notificationCounts.newInquiryCount + 
                            this.notificationCounts.newOrderCount + 
                            this.notificationCounts.newBoardReportCount;
                        
                        // 서버에서 필터링된 결과를 즉시 가져와서 동기화
                        this.fetchNotifications();
                    } catch (e) {
                        console.error('알림 읽음 처리 오류:', e);
                    }
                }
            },
            mounted() {
                let self = this;
                const today = new Date();
                self.endDate = today.toISOString().split('T')[0];
                const thirtyDaysAgo = new Date();
                thirtyDaysAgo.setDate(today.getDate() - 30);
                self.startDate = thirtyDaysAgo.toISOString().split('T')[0];

                self.pageSize = "10";
                self.fnGetBoardReportList();
                AdminNotifications.init(self);
            },
            beforeUnmount() {
                AdminNotifications.cleanup(this);
            }
        });

        app.mount('#app');
    </script>