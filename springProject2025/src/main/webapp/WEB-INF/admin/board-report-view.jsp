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
		    <a href="/admin.do">MAIN</a>
		    <a href="/admin/banner.do">배너 이미지 관리</a>
		    <a href="/admin/inquiry.do">문의/리스트</a>
		    <a href="/admin/refund-return.do">교환/환불</a>
		    <a href="/admin/product.do">상품 리스트</a>
		    <a href="/admin/orders.do">주문 내역</a>
		    <a href="/admin/board-report.do" class="active">게시판 신고 리스트</a>
		    <a href="/admin/user-list.do">회원 관리 화면</a>
		</div>

		<!-- 본문 -->
		<div class="content">
            <div>
		        <h2>신고 게시물 상세보기 및 처리</h2>
            </div>
            <div class="detail-card">
                    <div class="detail-item"><strong>신고식별번호:</strong> {{ detail.reportBoardNo }}</div>
                    <div class="detail-item"><strong>게시물 번호:</strong> {{ detail.reportedBoardNo }}</div>
                    <div class="detail-item"><strong>게시판 유형:</strong> {{ getBoardType(detail.boardType) }}</div>
                    <div class="detail-item"><strong>게시글 제목:</strong> {{ detail.boardTitle }}</div>
                    <div class="detail-item"><strong>게시글 작성자:</strong> {{ detail.boardUserId }} ({{ detail.boardAuthorName }})</div>
                    <div class="detail-item"><strong>신고자:</strong> {{ detail.reporterId }} ({{ detail.reporterName }})</div>
                    <div class="detail-item"><strong>신고 날짜:</strong> {{ detail.cDate }}</div>
                    <div class="detail-item"><strong>처리 상태:</strong>
                        <span :class="{'status-button': true, 'n': detail.reportStatus === 'N', 'y': detail.reportStatus === 'Y'}">
                            {{ detail.reportStatus === 'N' ? '처리요망' : '처리완료' }}
                        </span>
                    </div>
                    
                    <hr>
                    <div class="detail-item"><strong>게시글 내용:</strong></div>
                    <div class="detail-content">{{ detail.boardContent }}</div>
                </div>

                <div class="detail-button-group">
                    <button @click="fnDeleteBoard()" class="btn-delete" :disabled="detail.reportStatus === 'Y'">삭제</button>
                    <button @click="fnProcessReport()" class="btn-process-report" :disabled="detail.reportStatus === 'Y'">처리</button>
                    <button @click="fnBack()" class="btn-back">돌아가기</button>
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
                reportBoardNo : "${reportBoardNo}", // 컨트롤러에서 전달받은 reportBoardNo
                detail : {}
            };
        },
        methods: {
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnGetBoardReportDetail : function() {
                let self = this;
                let param = {
                    reportBoardNo: self.reportBoardNo
                };
                
                $.ajax({
                    url: "/admin/board-report-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log("신고 게시물 상세 데이터:", data);
                        if (data.result === "success") {
                            self.detail = data.detail;
                        } else {
                            alert("신고 게시물 정보를 불러오는데 실패했습니다: " + data.message);
                            self.fnBack();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error, xhr.responseText);
                        alert("신고 게시물 상세 정보를 불러오는 중 오류가 발생했습니다.");
                        self.fnBack();
                    }
                });
            },
            getBoardType(type) {
                switch(type) {
                    case 'Q': return '일반문의게시판';
                    case 'F': return '자유게시판';
                    case 'B': return '공지게시판';
                    case 'R': return '대회게시판';
                    default: return type;
                }
            },
            fnDeleteBoard: function() {
                let self = this;
                if(!confirm("[" + self.getBoardType(self.detail.boardType) + "] <" + self.detail.boardTitle + "> 게시글을 정말로 삭제하시겠습니까? (삭제 시 신고 확인 상태는 '처리완료'로 변경됩니다.)")) {
                    return;
                }

                let param = {
                    reportBoardNo: self.detail.reportBoardNo,
                    reportedBoardNo: self.detail.reportedBoardNo
                };

                $.ajax({
                    url: "/admin/board-report/deleteBoard.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result === "success") {
                            alert(data.message);
                            self.fnBack(); // 삭제 성공 시 리스트 페이지로 돌아가기
                        } else {
                            alert("게시글 삭제에 실패했습니다: " + data.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error, xhr.responseText);
                        alert("게시글 삭제 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                    }
                });
            },
            fnProcessReport: function() {
                let self = this;
                if(!confirm("[" + self.getBoardType(self.detail.boardType) +  "] <" + self.detail.boardTitle + "> 게시글에 대한 신고를 '처리완료' 상태로 변경하시겠습니까? (게시글은 삭제되지 않습니다.)")) {
                    return;
                }

                let param = {
                    reportBoardNo: self.detail.reportBoardNo
                };

                $.ajax({
                    url: "/admin/board-report/process.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result === "success") {
                            alert(data.message);
                            self.detail.reportStatus = 'Y'; // 상태를 즉시 업데이트하여 버튼 비활성화
                        } else {
                            alert("신고 처리 상태 변경에 실패했습니다: " + data.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error, xhr.responseText);
                        alert("신고 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                    }
                });
            },
            fnBack: function() {
                pageChange("/admin/board-report.do", {}, "get"); // 리스트 페이지로 돌아가기 (GET 방식)
            }
        },
        mounted() {
            let self = this;
            self.fnGetBoardReportDetail();
        }
    });

    app.mount('#app');
</script>