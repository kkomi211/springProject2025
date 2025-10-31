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
		    <a href="/admin/refund-return.do" class="active">교환/환불</a>
		    <a href="/admin/product.do">상품 리스트</a>
		    <a href="/admin/orders.do">주문 내역</a>
		    <a href="/admin/board-report.do">게시판 신고 리스트</a>
		    <a href="/admin/user-list.do">회원 관리 화면</a>
		</div>
		<!-- 본문 -->
		<div class="content">
            <div>
		        <h2>교환/반품/주문취소 관리</h2>
            </div>
            <div class="search-filters">
                <!-- 키워드 검색 -->
                <div class="filter-group">
                    <input type="text" v-model="keyword" @keyup.enter="fnGetRefundReturnList()" placeholder="상품명, 유저ID, 유저이름 검색">
                    <button @click="fnGetRefundReturnList()">검색</button>
                </div>
                
                <!-- 상태 필터 -->
                <div class="filter-group">
                    <select v-model="statusOption" @change="fnGetRefundReturnList()">
                        <option value="">상태 전체</option>
                        <option value="교환요청">교환요청</option>
                        <option value="교환완료">교환완료</option>
                        <option value="취소요청">취소요청</option>
                        <option value="취소완료">취소완료</option>
                        <option value="반품요청">반품요청</option>
                        <option value="반품완료">반품완료</option>
                    </select>
                </div>
                
                <!-- 기간 검색 필터 (UDATE 기준) -->
                <div class="filter-group date-filter">
                    <span>신청일 기준:</span>
                    <input type="date" v-model="startDate" @change="fnGetRefundReturnList()">
                    <span>~</span>
                    <input type="date" v-model="endDate" @change="fnGetRefundReturnList()">
                </div>
                
                <!-- 페이지당 표시 개수 선택 옵션 -->
                <div class="filter-group">
                    <span>표시 개수:</span>
                    <select v-model="pageSize" @change="fnGetRefundReturnList()">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="15">15개씩</option>
                    </select>
                </div>
            </div>
            
            <div>
                <table id="refund-return-list-table">
                    <tr>
                        <th>주문번호</th>
                        <th>상품명</th>
                        <th>유저ID</th>
                        <th>유저이름</th>
                        <th>연락처</th>
                        <th>신청일</th>
                        <th>상태</th>
                    </tr>
                    <tr v-for="item in list" :key="item.orderNo">
                        <td>{{item.orderNo}}</td>
                        <td>{{item.productName}}</td>
                        <td>{{item.userId}}</td>
                        <td>{{item.name}}</td>
                        <td>{{item.phone}}</td>
                        <td>{{item.uDate}}</td>
                        <td>
                            <button 
                                :class="getStatusButtonClass(item.status)"
                                @click="openModal(item)"
                                :disabled="!isUpdatableStatus(item.status)">
                                {{item.status}}
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

        <!-- 모달 -->
        <div id="refundReturnModal" class="modal" v-if="showModal">
            <div class="modal-content">
                <span class="close-button" @click="closeModal()">&times;</span>
                <h3 class="modal-title">{{ modalTitle }}</h3>

                <div class="modal-body">
                    <div class="modal-section-title">주문 정보</div>
                    <p class="modal-info-item"><strong>주문번호:</strong> {{ selectedOrder.orderNo }}</p>
                    <p class="modal-info-item"><strong>상품명:</strong> {{ selectedOrder.productName }}</p>
                    <p class="modal-info-item"><strong>수량:</strong> {{ selectedOrder.quantity }}</p>
                    <p class="modal-info-item"><strong>신청자:</strong> {{ selectedOrder.name }} ({{ selectedOrder.userId }})</p>
                    <p class="modal-info-item"><strong>연락처:</strong> {{ selectedOrder.phone }}</p>
                    <p class="modal-info-item"><strong>신청일:</strong> {{ selectedOrder.udate }}</p>
                    <p class="modal-info-item"><strong>사유:</strong> {{ selectedOrder.because }}</p>
                    <p class="modal-info-item" v-if="selectedOrder.orderRequest"><strong>요청사항:</strong> {{ selectedOrder.orderRequest }}</p>


                    <div v-if="selectedOrder.status === '교환요청'">
                        <div class="modal-section-title">교환할 제품 선택</div>
                        <p style="color:red; font-size:0.9rem;">(재고가 있는 상품만 표시됩니다.)</p>
                        <select v-model="selectedNewProductNo" @change="updateNewProductDetails()">
                            <option value="">교환할 옵션 선택</option>
                            <option v-for="option in productOptions" :value="option.productNo" :key="option.productNo" 
                                    :disabled="option.quantity === 0">
                                {{ option.productName }} / {{ option.productSize }} (재고: {{ option.quantity }}) - {{ option.price.toLocaleString() }}원
                            </option>
                        </select>
                        
                        <div v-if="newProductDetails">
                            <table class="product-option-table">
                                <tr>
                                    <th>새 제품명</th>
                                    <th>새 사이즈</th>
                                    <th>새 가격</th>
                                    <th>재고</th>
                                </tr>
                                <tr :class="{'selected-option': selectedNewProductNo}">
                                    <td>{{ newProductDetails.productName }}</td>
                                    <td>{{ newProductDetails.productSize }}</td>
                                    <td>{{ newProductDetails.price.toLocaleString() }}원</td>
                                    <td>{{ newProductDetails.quantity }}</td>
                                </tr>
                            </table>

                            <label for="exchangeQuantity">교환 수량:</label>
                            <input type="number" id="exchangeQuantity" v-model.number="exchangeQuantity" min="1" 
                                   :max="newProductDetails.quantity" placeholder="수량">
                            <p v-if="exchangeQuantity > newProductDetails.quantity" style="color:red; font-size:0.8rem;">재고가 부족합니다.</p>
                        </div>
                    </div>

                    <div class="btn-group">
                        <button class="btn-cancel" @click="closeModal()">취소</button>
                        <button class="btn-process" @click="processStatusChange()">{{ processButtonText }}</button>
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
                statusOption : "",
                startDate: "",
                endDate: "",
                pageSize: "5",
                currentPage: 1,
                totalItems: 0,
                totalPages: 1,

                // 모달 관련 데이터
                showModal: false,
                selectedOrder: {},
                modalTitle: "",
                processButtonText: "",
                
                // 교환 관련
                productOptions: [],      // 교환 가능한 동일 제품의 옵션 리스트
                selectedNewProductNo: "", // 선택된 새로운 제품의 productNo
                newProductDetails: null,  // 선택된 새 제품의 상세 정보 (가격, 재고 등)
                exchangeQuantity: 1       // 교환 수량
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
            fnGetRefundReturnList : function(page) {
                let self = this;
                if (page) {
                    self.currentPage = page;
                }
                
                let param = {
                    keyword: self.keyword,
                    statusOption: self.statusOption,
                    startDate: self.startDate,
                    endDate: self.endDate,
                    pageSize: self.pageSize,
                    currentPage: self.currentPage
                };
                
                $.ajax({
                    url: "/admin/refund-return.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log("리스트 데이터:", data);
                        self.list = data.list;
                        self.totalItems = data.totalItems;
                        self.totalPages = data.totalPages;
                        
                        if (self.currentPage > self.totalPages && self.totalPages > 0) {
                            self.fnChangePage(1);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error, xhr.responseText);
                        alert("데이터 로드 중 오류가 발생했습니다.");
                    }
                });
            },
            fnChangePage: function(page) {
                if (page < 1 || page > this.totalPages) {
                    return;
                }
                this.fnGetRefundReturnList(page);
            },
            getStatusButtonClass(status) {
                switch(status) {
                    case '교환요청': return 'status-exchange-req';
                    case '교환완료': return 'status-exchange-comp';
                    case '취소요청': return 'status-cancel-req';
                    case '취소완료': return 'status-cancel-comp';
                    case '반품요청': return 'status-return-req';
                    case '반품완료': return 'status-return-comp';
                    default: return 'status-default';
                }
            },
            isUpdatableStatus(status) {
                return status.endsWith('요청'); // '요청' 상태일 때만 클릭 가능
            },

            // 모달 열기
            openModal(item) {
                console.log("openModal 함수 호출됨. 클릭된 아이템:", item);

                this.selectedOrder = item;
                this.selectedNewProductNo = "";
                this.newProductDetails = null;
                this.exchangeQuantity = item.quantity || 1; // 기본 수량은 기존 주문 수량으로

                console.log("1. selectedOrder 설정 후:", this.selectedOrder);

                switch(item.status) {
                    case '취소요청':
                        this.modalTitle = "주문 취소 처리";
                        this.processButtonText = "취소완료 처리";
                        this.showModal = true;
                        console.log("2. 취소요청 케이스 진입, showModal 설정:", this.showModal);
                        break;
                    case '반품요청':
                        this.modalTitle = "반품 처리";
                        this.processButtonText = "반품완료 처리";
                        this.showModal = true;
                        console.log("2. 반품요청 케이스 진입, showModal 설정:", this.showModal);
                        break;
                    case '교환요청':
                        this.modalTitle = "교환 처리";
                        this.processButtonText = "교환완료 처리";
                        this.showModal = true;
                        this.getExchangeProductOptions(item.productNo); // 교환할 옵션 가져오기
                        console.log("2. 교환요청 케이스 진입, showModal 설정:", this.showModal);
                        break;
                    default:
                        alert('이미 처리되었거나 처리할 수 없는 상태입니다.');
                        console.log("2. Default 케이스 진입 (모달 열리지 않음):", this.showModal);
                        return;
                }
                console.log("3. openModal 함수 종료 직전, 최종 showModal 상태:", this.showModal);
            },
            // 모달 닫기
            closeModal() {
                this.showModal = false;
                this.selectedOrder = {};
                this.productOptions = [];
                this.selectedNewProductNo = "";
                this.newProductDetails = null;
                this.exchangeQuantity = 1;
            },

            // 교환 가능한 제품 옵션 가져오기
            getExchangeProductOptions(productNo) {
                let self = this;
                $.ajax({
                    url: "/admin/refund-return/getProductOptions.dox",
                    dataType: "json",
                    type: "POST",
                    data: { productNo: productNo },
                    success: function (data) {
                        if (data.result === "success") {
                            self.productOptions = data.options;
                            //console.log("교환 옵션:", self.productOptions);
                        } else {
                            alert("제품 옵션을 불러오는데 실패했습니다: " + data.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("제품 옵션 AJAX 오류:", status, error, xhr.responseText);
                        alert("제품 옵션 로드 중 오류가 발생했습니다.");
                    }
                });
            },

            // 선택된 교환 제품 상세 정보 업데이트
            updateNewProductDetails() {
                if (this.selectedNewProductNo) {
                    this.newProductDetails = this.productOptions.find(opt => opt.productNo == this.selectedNewProductNo);
                    this.exchangeQuantity = this.selectedOrder.quantity || 1; // 새 제품 선택 시 기존 주문 수량으로 초기화
                } else {
                    this.newProductDetails = null;
                    this.exchangeQuantity = 1;
                }
            },

            // 상태 변경 처리 (모달에서 실행)
            processStatusChange() {
                let self = this;
                let url = "";
                let param = {
                    orderNo: self.selectedOrder.orderNo,
                    currentStatus: self.selectedOrder.status,
                    newStatus: ""
                };

                let confirmMsg = "";

                switch(self.selectedOrder.status) {
                    case '취소요청':
                        param.newStatus = '취소완료';
                        confirmMsg =  self.selectedOrder.orderNo + "번 주문을 취소완료 처리하시겠습니까?";
                        url = "/admin/refund-return/updateStatus.dox";
                        break;
                    case '반품요청':
                        param.newStatus = '반품완료';
                        confirmMsg = self.selectedOrder.orderNo + "번 주문을 반품완료 처리하고 재고를 복원하시겠습니까?";
                        url = "/admin/refund-return/updateStatus.dox";
                        break;
                    case '교환요청':
                        if (!self.selectedNewProductNo) {
                            alert("교환할 제품 옵션을 선택해주세요.");
                            return;
                        }
                        if (self.exchangeQuantity <= 0) {
                            alert("교환 수량은 1개 이상이어야 합니다.");
                            return;
                        }
                        if (self.exchangeQuantity > self.newProductDetails.quantity) {
                            alert("선택한 제품의 재고가 부족하여 교환 수량을 처리할 수 없습니다.");
                            return;
                        }

                        param.newProductNo = self.selectedNewProductNo;
                        param.newQuantity = self.exchangeQuantity;
                        param.newPrice = self.newProductDetails.price; // 새 제품의 가격
                        confirmMsg = self.selectedOrder.orderNo + "번 주문을 교환완료 처리하고, 새로운 주문 " + self.newProductDetails.productName + "(" + self.exchangeQuantity + "개)을 생성하시겠습니까?";
                        url = "/admin/refund-return/completeExchange.dox"; // 교환 전용 API
                        break;
                    default:
                        alert('잘못된 상태 변경 요청입니다.');
                        return;
                }

                if(!confirm(confirmMsg)) {
                    return;
                }

                $.ajax({
                    url: url,
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result === "success") {
                            alert(data.message);
                            self.closeModal();
                            self.fnGetRefundReturnList(self.currentPage); // 리스트 새로고침
                        } else {
                            alert("처리 실패: " + data.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("처리 AJAX 오류:", status, error, xhr.responseText);
                        alert("요청 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                    }
                });
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
            self.fnGetRefundReturnList();
        }
    });

    app.mount('#app');
</script>
