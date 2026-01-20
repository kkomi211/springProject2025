<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 문의 관리 - RUNNERS HOUSE</title>
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
                <a href="/admin/inquiry.do" class="active">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
                <a href="/admin/activity-log.do">활동 로그</a>
            </div>

            <!-- 본문 -->
            <div class="content">
                <div>
                    <h2>상품 문의내역 리스트</h2>
                </div>
                <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnInquiryList()" placeholder="검색">
                        <button @click="fnInquiryList()">검색</button>
                    </div>

                    <!-- 상태 필터 -->
                    <div class="filter-group">
                        <select v-model="statusOption" @change="fnInquiryList()">
                            <option value="">상태 전체</option>
                            <option value="N">답변 대기</option>
                            <option value="Y">답변 완료</option>
                        </select>
                    </div>

                    <!-- 기간 검색 필터 -->
                    <div class="filter-group date-filter">
                        <span>기간 검색:</span>
                        <input type="date" v-model="startDate" @change="fnInquiryList()">
                        <span>~</span>
                        <input type="date" v-model="endDate" @change="fnInquiryList()">
                    </div>

                    <!-- 페이지당 표시 개수 선택 옵션 -->
                    <div class="filter-group">
                        <span>표시 개수:</span>
                        <select v-model="pageSize" @change="fnInquiryList()">
                            <option value="5">5개씩</option>
                            <option value="10">10개씩</option>
                            <option value="15">15개씩</option>
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
                <div>
                    <!-- 로딩 스피너 -->
                    <div v-if="loading" class="loading-container" style="text-align: center; padding: 40px;">
                        <div class="loading-spinner"></div>
                        <div class="loading-text">데이터를 불러오는 중...</div>
                    </div>

                    <!-- 테이블 -->
                    <table id="inquiry-list-table" v-if="!loading && list.length > 0">
                        <tr>
                            <th class="sortable-header" @click="sortTable('inquiryNo')"
                                :class="{'sort-asc': sortColumn === 'inquiryNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'inquiryNo' && sortDirection === 'desc'}">
                                문의번호</th>
                            <th class="sortable-header" @click="sortTable('productName')"
                                :class="{'sort-asc': sortColumn === 'productName' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productName' && sortDirection === 'desc'}">
                                상품명</th>
                            <th class="sortable-header" @click="sortTable('title')"
                                :class="{'sort-asc': sortColumn === 'title' && sortDirection === 'asc', 'sort-desc': sortColumn === 'title' && sortDirection === 'desc'}">
                                문의제목</th>
                            <th class="sortable-header" @click="sortTable('userId')"
                                :class="{'sort-asc': sortColumn === 'userId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'userId' && sortDirection === 'desc'}">
                                ID</th>
                            <th class="sortable-header" @click="sortTable('name')"
                                :class="{'sort-asc': sortColumn === 'name' && sortDirection === 'asc', 'sort-desc': sortColumn === 'name' && sortDirection === 'desc'}">
                                이름</th>
                            <th class="sortable-header" @click="sortTable('cDate')"
                                :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">
                                등록일</th>
                            <th class="sortable-header" @click="sortTable('status')"
                                :class="{'sort-asc': sortColumn === 'status' && sortDirection === 'asc', 'sort-desc': sortColumn === 'status' && sortDirection === 'desc'}">
                                상태</th>
                        </tr>
                        <tr v-for="item in sortedList" :key="item.inquiryNo">
                            <td>{{item.inquiryNo}}</td>
                            <td>{{item.productName}}</td>
                            <td>
                                <a href="javascript:;" @click="fnInquiryView(item.inquiryNo)">
                                    {{item.title}}
                                </a>
                            </td>
                            <td>{{item.userId}}</td>
                            <td>{{item.name}}</td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <span v-if="item.status === 'N'" class="status-waiting">답변 대기</span>
                                <span v-else-if="item.status === 'Y'" class="status-completed">답변 완료</span>
                            </td>
                        </tr>
                    </table>

                    <!-- 빈 데이터 메시지 -->
                    <div v-if="!loading && list.length === 0" class="empty-state-card">
                        <div class="empty-icon">📭</div>
                        <div class="empty-title">문의 내역이 없습니다</div>
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

            <!-- 문의 상세보기 모달 -->
            <div v-if="showInquiryModal" class="modal-overlay" @click.self="closeInquiryModal">
                <div class="modal-content inquiry-modal">
                    <div class="modal-header">
                        <h3>상품 문의내역 상세</h3>
                        <button @click="closeInquiryModal" class="modal-close-btn">&times;</button>
                    </div>
                    <div class="modal-body" v-if="inquiryDetail">
                        <table class="detail-table">
                            <tr>
                                <th>문의번호</th>
                                <td>{{inquiryDetail.inquiryNo}}</td>
                            </tr>
                            <tr>
                                <th>상품명</th>
                                <td>{{inquiryDetail.productName}}</td>
                            </tr>
                            <tr>
                                <th>고객명</th>
                                <td>{{inquiryDetail.name}}</td>
                            </tr>
                            <tr>
                                <th>상태</th>
                                <td>
                                    <span v-if="inquiryDetail.status === 'N'" class="status-waiting">답변 대기</span>
                                    <span v-else-if="inquiryDetail.status === 'Y'" class="status-completed">답변 완료</span>
                                </td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td>{{inquiryDetail.userId}}</td>
                            </tr>
                            <tr>
                                <th>제목</th>
                                <td>{{inquiryDetail.title}}</td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td v-html="inquiryDetail.content"></td>
                            </tr>
                        </table>
                        <table class="detail-table">
                            <tr>
                                <th>관리자 답변</th>
                                <td>
                                    <!-- inquiryDetail.status가 'N'일 때만 답변 입력 필드와 버튼 표시 -->
                                    <div v-if="inquiryDetail.status === 'N'">
                                        <textarea v-model="newAnswer" rows="5" cols="50" placeholder="답변을 입력하세요"
                                            style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;"></textarea>
                                    </div>
                                    <!-- inquiryDetail.status가 'Y'일 때는 기존 답변 내용만 표시 -->
                                    <div v-else>
                                        {{inquiryDetail.answer}}
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-overlay" v-if="alertModal.show" @click.self="fnCloseAlert">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>알림</h3>
                                <button @click="fnCloseAlert" class="modal-close-btn">&times;</button>
                            </div>
                            <div class="modal-body" style="padding: 20px 0; font-size: 16px;">
                                {{ alertModal.message }}
                            </div>
                            <div class="modal-footer" style="justify-content: center; border-top: none;">
                                <button class="bluebutton height40" @click="fnConfirmAlert"
                                    style="min-width: 100px;">확인</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <!-- 상태가 'N'일 때만 답변 등록 버튼 표시 -->
                        <button v-if="inquiryDetail && inquiryDetail.status === 'N'" @click="fnRegisterAnswer"
                            class="btn-register-answer">답변 등록</button>
                        <button @click="closeInquiryModal" class="btn-back">닫기</button>
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
                    keyword: "", // 검색 키워드
                    statusOption: "", // 상태 옵션 (N : 답변대기, Y : 답변완료)
                    startDate: "", // 시작 날짜
                    endDate: "",    // 종료 날짜
                    pageSize: "10", // 기본 페이지 크기 10개로 설정
                    loading: false, // 로딩 상태
                    sortColumn: '', // 정렬 컬럼
                    sortDirection: 'asc', // 정렬 방향
                    currentPage: 1, // 현재 페이지
                    totalItems: 0,  // 전체 아이템 수
                    totalPages: 1,   // 전체 페이지 수
                    showInquiryModal: false, // 모달 표시 여부
                    inquiryDetail: null, // 문의 상세 정보
                    newAnswer: "", // 새 답변을 저장할 변수
                    // 알림 관련
                    notificationCounts: {
                        newInquiryCount: 0,
                        newOrderCount: 0,
                        newBoardReportCount: 0,
                        totalCount: 0
                    },
                    showNotificationPanel: false,
                    notificationInterval: null,
                    alertModal: {
                        show: false,
                        message: "",
                        callback: null
                    }
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
                        if (this.sortColumn === 'inquiryNo') {
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
                fnAlert(msg, callback = null) {
                    this.alertModal.message = msg;
                    this.alertModal.callback = callback;
                    this.alertModal.show = true;
                },
                fnCloseAlert() {
                    this.alertModal.show = false;
                },
                fnConfirmAlert() {
                    if (this.alertModal.callback) this.alertModal.callback();
                    this.fnCloseAlert();
                },
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
                fnInquiryList: function (page) {
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
                        url: "/admin/inquiry.dox",
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
                        error: function () {
                            self.fnAlert("데이터를 불러오는 중 오류가 발생했습니다.");
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
                fnChangePage: function (page) {
                    // 페이지 범위 체크
                    if (page < 1 || page > this.totalPages) {
                        return;
                    }
                    this.fnInquiryList(page);
                },
                fnInquiryView: function (inquiryNo) {
                    let self = this;
                    self.showInquiryModal = true;
                    self.newAnswer = "";

                    let param = {
                        inquiryNo: inquiryNo
                    };
                    $.ajax({
                        url: "/admin/inquiry/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.inquiryDetail = data.info;
                        },
                        error: function () {
                            self.fnAlert("문의 상세 정보를 불러오는 중 오류가 발생했습니다.");
                            self.closeInquiryModal();
                        }
                    });
                },
                closeInquiryModal: function () {
                    this.showInquiryModal = false;
                    this.inquiryDetail = null;
                    this.newAnswer = "";
                },
                fnRegisterAnswer: function () {
                    let self = this;
                    if (!self.inquiryDetail) return;

                    // 답변 내용이 비어있는지 확인
                    if (!self.newAnswer.trim()) {
                        self.fnAlert("답변 내용을 입력해주세요.");
                        return;
                    }

                    let param = {
                        inquiryNo: self.inquiryDetail.inquiryNo,
                        answer: self.newAnswer,
                        status: 'Y' // 답변 등록 시 상태를 'Y'로 변경
                    };

                    $.ajax({
                        url: "/admin/inquiry/registerAnswer.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result === "success") {
                                self.fnAlert("답변이 성공적으로 등록되었습니다.", () => {
                                    self.fnInquiryView(self.inquiryDetail.inquiryNo);
                                    self.fnInquiryList(self.currentPage);
                                });
                            } else {
                                self.fnAlert("답변 등록에 실패했습니다.");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("답변 등록 실패:", status, error);
                            self.fnAlert("답변 등록 중 오류가 발생했습니다.");
                        }
                    });
                },
                downloadExcel: function () {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.statusOption) params.append('statusOption', self.statusOption);
                    if (self.startDate) params.append('startDate', self.startDate);
                    if (self.endDate) params.append('endDate', self.endDate);

                    window.location.href = '/admin/inquiry/excel.dox?' + params.toString();
                },
                // 실시간 알림 개수 가져오기
                // 페이지 이동
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

                // 오늘 날짜를 기본 종료일로 설정
                const today = new Date();
                self.endDate = today.toISOString().split('T')[0];

                // 30일 전 날짜를 기본 시작일로 설정
                const thirtyDaysAgo = new Date();
                thirtyDaysAgo.setDate(today.getDate() - 30);
                self.startDate = thirtyDaysAgo.toISOString().split('T')[0];

                // 기본 페이지 크기 설정
                self.pageSize = "10";

                self.fnInquiryList();
                AdminNotifications.init(self);
            },
            beforeUnmount() {
                AdminNotifications.cleanup(this);
            }
        });

        app.mount('#app');
    </script>