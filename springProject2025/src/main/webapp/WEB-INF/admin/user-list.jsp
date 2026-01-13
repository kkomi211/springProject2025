<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원 관리 - RUNNERS HOUSE</title>
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
                <a href="/admin/orders.do">주문 내역</a>
                <a href="/admin/board-report.do">게시판 신고 리스트</a>
                <a href="/admin/user-list.do" class="active">회원 관리 화면</a>
            </div>
            <!-- 본문 -->
            <div class="content">
                <div>
                    <h2>회원 관리</h2>
                </div>
                <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnUserList()" placeholder="검색어 입력">
                        <button @click="fnUserList()">검색</button>
                    </div>

                    <!-- 정렬 선택 -->
                    <div class="filter-group">
                        <span>정렬 기준:</span>
                        <select v-model="sortColumn" @change="fnUserList()">
                            <option value="CDATE">가입일(최신순)</option>
                            <option value="USER_ID">유저아이디</option>
                            <option value="NAME">이름</option>
                            <option value="NICKNAME">닉네임</option>
                        </select>
                    </div>

                    <!-- 페이지당 표시 개수 선택 옵션 -->
                    <div class="filter-group">
                        <span>표시 개수:</span>
                        <select v-model="pageSize" @change="fnUserList()">
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
                    <table id="user-list-table" v-if="!loading && list.length > 0">
                        <tr>
                            <th class="sortable-header" @click="sortTable('userId')" :class="{'sort-asc': sortColumn === 'userId' && sortDirection === 'asc', 'sort-desc': sortColumn === 'userId' && sortDirection === 'desc'}">유저아이디</th>
                            <th class="sortable-header" @click="sortTable('name')" :class="{'sort-asc': sortColumn === 'name' && sortDirection === 'asc', 'sort-desc': sortColumn === 'name' && sortDirection === 'desc'}">이름</th>
                            <th class="sortable-header" @click="sortTable('nickName')" :class="{'sort-asc': sortColumn === 'nickName' && sortDirection === 'asc', 'sort-desc': sortColumn === 'nickName' && sortDirection === 'desc'}">닉네임</th>
                            <th class="sortable-header" @click="sortTable('email')" :class="{'sort-asc': sortColumn === 'email' && sortDirection === 'asc', 'sort-desc': sortColumn === 'email' && sortDirection === 'desc'}">이메일</th>
                            <th class="sortable-header" @click="sortTable('cDate')" :class="{'sort-asc': sortColumn === 'cDate' && sortDirection === 'asc', 'sort-desc': sortColumn === 'cDate' && sortDirection === 'desc'}">가입날짜</th>
                        </tr>
                        <tr v-for="item in sortedList" :key="item.userId">
                            <td>
                                <a href="javascript:;" @click="fnUserDetail(item.userId)">
                                    {{item.userId}}
                                </a>
                            </td>
                            <td>{{item.name}}</td>
                            <td>{{item.nickName}}</td>
                            <td>{{item.email}}</td>
                            <td>{{item.cDate}}</td>
                        </tr>
                    </table>
                    
                    <!-- 빈 데이터 메시지 -->
                    <div v-if="!loading && list.length === 0" class="empty-state-card">
                        <div class="empty-icon">👤</div>
                        <div class="empty-title">회원이 없습니다</div>
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
                    // 변수 - (key : value)
                    sessionId: "",
                    list: [],
                    keyword: "",
                    sortColumn: "CDATE", // 기본 정렬: 가입일(최신순)
                    pageSize: "10",
                    currentPage: 1,
                    totalItems: 0,
                    totalPages: 1,
                    loading: false, // 로딩 상태
                    sortColumnClient: '', // 클라이언트 측 정렬 컬럼
                    sortDirection: 'asc' // 정렬 방향
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
                    if (!this.sortColumnClient) return this.list;
                    
                    const sorted = [...this.list];
                    sorted.sort((a, b) => {
                        let aVal = a[this.sortColumnClient];
                        let bVal = b[this.sortColumnClient];
                        
                        // 날짜 정렬
                        if (this.sortColumnClient === 'cDate') {
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
                fnUserList: function (page) {
                    let self = this;
                    if (page) {
                        self.currentPage = page;
                    }

                    self.loading = true; // 로딩 시작

                    let param = {
                        keyword: self.keyword,
                        sortColumn: self.sortColumn,
                        pageSize: self.pageSize,
                        currentPage: self.currentPage
                    };

                    $.ajax({
                        url: "/admin/user-list.dox",
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
                            self.loading = false; // 로딩 종료
                        }
                    });
                },
                sortTable: function(column) {
                    if (this.sortColumnClient === column) {
                        // 같은 컬럼 클릭 시 정렬 방향 전환
                        this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
                    } else {
                        // 다른 컬럼 클릭 시 오름차순으로 설정
                        this.sortColumnClient = column;
                        this.sortDirection = 'asc';
                    }
                },
                fnChangePage: function (page) {
                    if (page < 1 || page > this.totalPages) {
                        return;
                    }
                    this.fnUserList(page);
                },
                fnUserDetail: function (userId) {
                    pageChange("/admin/user-list/view.do", { userId: userId });
                },
                downloadExcel: function() {
                    let self = this;
                    let params = new URLSearchParams();
                    if (self.keyword) params.append('keyword', self.keyword);
                    if (self.sortColumn) params.append('sortColumn', self.sortColumn);
                    
                    window.location.href = '/admin/user-list/excel.dox?' + params.toString();
                }
            },
            mounted() {
                let self = this;
                self.fnUserList();
            }
        });

        app.mount('#app');
    </script>