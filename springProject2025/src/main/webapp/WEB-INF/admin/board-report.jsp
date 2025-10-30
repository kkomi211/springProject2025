<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
		        <h2>신고 게시물 관리</h2>
            </div>
            <div class="search-filters">
                    <!-- 키워드 검색 -->
                    <div class="filter-group">
                        <input type="text" v-model="keyword" @keyup.enter="fnGetBoardReportList()" placeholder="제목, 내용, 작성자ID, 신고자ID 검색">
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
                </div>
                
                <div>
                    <table id="board-report-list-table">
                        <tr>
                            <th>신고식별번호</th>
                            <th>신고게시물번호</th>
                            <th>신고자 아이디 (이름)</th>
                            <th>신고 날짜</th>
                            <th>신고확인상태</th>
                        </tr>
                        <tr v-for="item in list" :key="item.reportBoardNo">
                            <td>{{item.reportBoardNo}}</td>
                            <td>{{item.reportedBoardNo}} <br> ({{item.boardTitle}})</td>
                            <td>{{item.reporterId}} <br> ({{item.reporterName}})</td>
                            <td>{{item.cDate}}</td>
                            <td>
                                <button
                                    class="status-button"
                                    :class="{'n': item.reportStatus === 'N', 'y': item.reportStatus === 'Y'}"
                                    :disabled="item.reportStatus === 'Y'"
                                    @click="goToDetail(item.reportBoardNo)">
                                    {{item.reportStatus === 'N' ? '처리요망' : '처리완료'}}
                                </button>
                            </td>
                        </tr>
                    </table>
                    
                    <!-- 페이징 컴포넌트 -->
                    <div class="pagination">
                        <a href="javascript:;" @click="fnChangePage(1)" :class="{'disabled': currentPage === 1}">&laquo;</a>
                        <a href="javascript:;" @click="fnChangePage(currentPage - 1)" :class="{'disabled': currentPage === 1}">&lt;</a>
                        
                        <template v-for="page in pageNumbers" :key="page">
                            <a href="javascript:;" @click="fnChangePage(page)" :class="{'active': currentPage === page}">{{ page }}</a>
                        </template>
                        
                        <a href="javascript:;" @click="fnChangePage(currentPage + 1)" :class="{'disabled': currentPage === totalPages}">&gt;</a>
                        <a href="javascript:;" @click="fnChangePage(totalPages)" :class="{'disabled': currentPage === totalPages}">&raquo;</a>
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
                sessionId : "",
                list : [],
                keyword : "",
                reportStatus : "N", // 기본값 '처리 요망'
                startDate: "",
                endDate: "",
                pageSize: "5",
                currentPage: 1,
                totalItems: 0,
                totalPages: 1
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
            }
        },
        methods: {
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnGetBoardReportList : function(page) {
                let self = this;
                if (page) {
                    self.currentPage = page;
                }
                
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
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error, xhr.responseText);
                        alert("신고 게시물 리스트 로드 중 오류가 발생했습니다.");
                    }
                });
            },
            fnChangePage: function(page) {
                if (page < 1 || page > this.totalPages) {
                    return;
                }
                this.fnGetBoardReportList(page);
            },
            goToDetail(reportBoardNo) {
                pageChange("/admin/board-report-view.do", { reportBoardNo: reportBoardNo });
            }
        },
        mounted() {
            let self = this;
            const today = new Date();
            self.endDate = today.toISOString().split('T')[0];
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(today.getDate() - 30);
            self.startDate = thirtyDaysAgo.toISOString().split('T')[0];
            
            self.pageSize = "5";
            self.fnGetBoardReportList();
        }
    });

    app.mount('#app');
</script>
