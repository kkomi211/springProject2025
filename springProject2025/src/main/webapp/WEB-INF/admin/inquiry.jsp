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
                <a href="/admin/inquiry.do" class="active">문의/리스트</a>
                <a href="/admin/refund-return.do">교환/환불</a>
                <a href="/admin/product.do">상품 리스트</a>
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do">회원 관리 화면</a>
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
                    <div v-if="!loading && list.length > 0" style="margin-bottom: 15px; display: flex; gap: 10px; align-items: center;">
                        <button @click="selectAll" style="padding: 8px 15px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            전체 선택
                        </button>
                        <button @click="deselectAll" style="padding: 8px 15px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            전체 해제
                        </button>
                        <button @click="batchAnswer" :disabled="selectedInquiries.length === 0" 
                            style="padding: 8px 15px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;"
                            :style="{'opacity': selectedInquiries.length === 0 ? 0.5 : 1, 'cursor': selectedInquiries.length === 0 ? 'not-allowed' : 'pointer'}">
                            선택 항목 일괄 답변 ({{ selectedInquiries.length }})
                        </button>
                    </div>

                    <!-- 테이블 -->
                    <table id="inquiry-list-table" v-if="!loading && list.length > 0">
                        <tr>
                            <th style="width: 50px;">
                                <input type="checkbox" @change="toggleSelectAll" :checked="isAllSelected">
                            </th>
                            <th class="sortable-header" @click="sortTable('inquiryNo')" :class="{'sort-asc': sortColumn === 'inquiryNo' && sortDirection === 'asc', 'sort-desc': sortColumn === 'inquiryNo' && sortDirection === 'desc'}">문의번호</th>
                            <th class="sortable-header" @click="sortTable('productName')" :class="{'sort-asc': sortColumn === 'productName' && sortDirection === 'asc', 'sort-desc': sortColumn === 'productName' && sortDirection === 'desc'}">상품명</th>
                            <th class="sortable-header" @click="sortTable('title')" :class="{'sort-asc': sortColumn === 'title' && sortDirection === 'asc', 'sort-desc': sortColumn === 'title' && sortDirection === 'desc'}">문의제목</th>
                            <th class="sortable-header" @click="sortTable('userId')" :class="{'sort-asc': sortColumn === 'userId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'userId' && sortDirection === 'desc'}">ID</th>
                            <th class="sortable-header" @click="sortTable('name')" :class="{'sort-asc': sortColumn === 'name' && sortDirection === 'asc', 'sort-desc': sortColumn === 'name' && sortDirection === 'desc'}">이름</th>
                            <th class="sortable-header" @click="sortTable('cDate')" :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">등록일</th>
                            <th class="sortable-header" @click="sortTable('status')" :class="{'sort-asc': sortColumn === 'status' && sortDirection === 'asc', 'sort-desc': sortColumn === 'status' && sortDirection === 'desc'}">상태</th>
                        </tr>
                        <tr v-for="item in sortedList" :key="item.inquiryNo">
                            <td>
                                <input type="checkbox" :value="item.inquiryNo" v-model="selectedInquiries" 
                                    v-if="item.status === 'N'">
                            </td>
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
                    selectedInquiries: [] // 선택된 문의 번호 리스트
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
                },
                // 전체 선택 여부
                isAllSelected() {
                    const unansweredList = this.list.filter(item => item.status === 'N');
                    return unansweredList.length > 0 && unansweredList.every(item => 
                        this.selectedInquiries.includes(item.inquiryNo));
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
                    this.fnInquiryList(page);
                },
                fnInquiryView: function (inquiryNo) {
                    pageChange("/admin/inquiry/view.do", { inquiryNo: inquiryNo });
                },
                downloadExcel: function() {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.statusOption) params.append('statusOption', self.statusOption);
                    if (self.startDate) params.append('startDate', self.startDate);
                    if (self.endDate) params.append('endDate', self.endDate);
                    
                    window.location.href = '/admin/inquiry/excel.dox?' + params.toString();
                },
                selectAll: function() {
                    const unansweredList = this.list.filter(item => item.status === 'N');
                    this.selectedInquiries = unansweredList.map(item => item.inquiryNo);
                },
                deselectAll: function() {
                    this.selectedInquiries = [];
                },
                toggleSelectAll: function(event) {
                    if (event.target.checked) {
                        this.selectAll();
                    } else {
                        this.deselectAll();
                    }
                },
                batchAnswer: function() {
                    let self = this;
                    if (self.selectedInquiries.length === 0) {
                        alert("선택된 문의가 없습니다.");
                        return;
                    }
                    
                    let answer = prompt("일괄 답변 내용을 입력하세요:");
                    if (!answer || answer.trim() === "") {
                        alert("답변 내용을 입력해주세요.");
                        return;
                    }
                    
                    if (!confirm(self.selectedInquiries.length + "개의 문의에 동일한 답변을 등록하시겠습니까?")) {
                        return;
                    }
                    
                    let param = {
                        inquiryNos: self.selectedInquiries.join(','),
                        answer: answer
                    };
                    
                    $.ajax({
                        url: "/admin/inquiry/batchAnswer.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result === "success") {
                                alert("일괄 답변이 완료되었습니다.");
                                self.selectedInquiries = [];
                                self.fnInquiryList(self.currentPage);
                            } else {
                                alert("일괄 답변 처리 중 오류가 발생했습니다: " + (data.message || ""));
                            }
                        },
                        error: function() {
                            alert("일괄 답변 처리 중 오류가 발생했습니다.");
                        }
                    });
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
            }
        });

        app.mount('#app');
    </script>