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
		        <h2>관리자 메인 콘텐츠 영역</h2>
            </div>
            <div>
                <table>
                    <tr>
                        <th>문의번호</th>
                        <td>{{info.inquiryNo}}</td>
                    </tr>
                    <tr>
                        <th>고객명</th>
                        <td>{{info.name}}</td>
                    </tr>
                    <tr>
                        <th>상태</th>
                        <td>{{info.status}}</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>{{info.userId}}</td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>{{info.title}}</td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>{{info.content}}</td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <th>관리자 답변</th>
                        <td>
                            <!-- info.status가 'N'일 때만 답변 입력 필드와 버튼 표시 -->
                            <div v-if="info.status === 'N'">
                                <textarea v-model="newAnswer" rows="5" cols="50" placeholder="답변을 입력하세요"></textarea>
                                <div class="text-center" style="margin-top: 10px;">
                                    <button @click="fnRegisterAnswer">답변 등록</button>
                                </div>
                            </div>
                            <!-- info.status가 'Y'일 때는 기존 답변 내용만 표시 -->
                            <div v-else>
                                {{info.answer}}
                            </div>
                        </td>
                    </tr>
                </table>
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
                inquiryNo : "${inquiryNo}",
                info : {},
                newAnswer: "" // 새 답변을 저장할 변수 추가
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogout: function () {
                pageChange("home.do", {sessionId : ""});
            },
            fnInquiryInfo : function () {
                let self = this;
                let param = {
                    inquiryNo : self.inquiryNo
                };
                $.ajax({
                    url: "/admin/inquiry/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                    }
                });
            },
            fnRegisterAnswer: function() {
                let self = this;
                // 답변 내용이 비어있는지 확인
                if(!self.newAnswer.trim()) {
                    alert("답변 내용을 입력해주세요.");
                    return;
                }
                
                let param = {
                    inquiryNo: self.inquiryNo,
                    answer: self.newAnswer,
                    status: 'Y' // 답변 등록 시 상태를 'Y'로 변경
                };
                
                $.ajax({
                    url: "/admin/inquiry/registerAnswer.dox", // 새로운 URL 사용
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function(data) {
                        if(data.result === "success") {
                            alert("답변이 성공적으로 등록되었습니다.");
                            self.fnInquiryInfo(); // 답변 등록 후 최신 정보로 갱신 (상태 'Y', 답변 내용 반영)
                        } else {
                            alert("답변 등록에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("답변 등록 실패:", status, error);
                        alert("답변 등록 중 오류가 발생했습니다.");
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInquiryInfo();
        }
    });

    app.mount('#app');
</script>