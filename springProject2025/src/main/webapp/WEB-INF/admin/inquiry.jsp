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
            </div>
		    <div>
                <table id="inquiry-list-table">
                    <tr>
                        <th>문의번호</th>
                        <th>ID</th>
                        <th>이름</th>
                        <th>문의제목</th>
                        <th>등록일</th>
                        <th>상태</th>
                    </tr>
                    <tr v-for="item in list">
                        <td>{{item.inquiryNo}}</td>
                        <td>{{item.userId}}</td>
                        <td>{{item.name}}</td>
                        <td>
                            <a href="javascript:;" @click="fnInquiryView(item.inquiryNo)">
                                {{item.title}}
                            </a>
                        </td>
                        <td>{{item.cDate}}</td>
                        <td>
                            <span v-if="item.status === 'N'" class="status-waiting">답변 대기</span>
                            <span v-else-if="item.status === 'Y'" class="status-completed">답변 완료</span>
                        </td>
                    </tr>
                </table>

                <!-- 페이징 컴포넌트 -->
                <div class="pagination">
                    <a href="javascript:;" @click="fnChangePage(1)" :class="{'disabled': currentPage === 1}">&laquo;</a>
                    <a href="javascript:;" @click="fnChangePage(currentPage - 1)" :class="{'disabled': currentPage === 1}">&lt;</a>
                    
                    <template v-for="page in pageNumbers">
                        <a href="javascript:;" @click="fnChangePage(page)" :class="{'active': currentPage === page}">{{ page }}</a>
                    </template>
                    
                    <a href="javascript:;" @click="fnChangePage(currentPage + 1)" :class="{'disabled': currentPage === totalPages}">&gt;</a>
                    <a href="javascript:;" @click="fnChangePage(totalPages)" :class="{'disabled': currentPage === totalPages}">&raquo;</a>
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
                sessionId : "",
                list : [],
                keyword : "", // 검색 키워드
                statusOption : "", // 상태 옵션 (N : 답변대기, Y : 답변완료)
                startDate: "", // 시작 날짜
                endDate: "",    // 종료 날짜
                pageSize: "5", // 기본 페이지 크기 5개로 설정
                currentPage: 1, // 현재 페이지
                totalItems: 0,  // 전체 아이템 수
                totalPages: 1   // 전체 페이지 수
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
            }
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnInquiryList : function(page) {
                let self = this;
                // 페이지 지정이 있으면 해당 페이지로, 없으면 현재 페이지 유지
                if (page) {
                    self.currentPage = page;
                }

                let param = {
                    keyword : self.keyword,
                    statusOption : self.statusOption,
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
                    }
                });
            },
            fnChangePage: function(page) {
                // 페이지 범위 체크
                if (page < 1 || page > this.totalPages) {
                    return;
                }
                this.fnInquiryList(page);
            },
            fnInquiryView : function(inquiryNo) {
                pageChange("/admin/inquiry/view.do", {inquiryNo : inquiryNo});
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
            self.pageSize = "5";

            self.fnInquiryList();
        }
    });

    app.mount('#app');
</script>