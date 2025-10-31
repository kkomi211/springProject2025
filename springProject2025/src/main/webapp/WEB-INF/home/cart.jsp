<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/user-style.css">
        <link rel="stylesheet" href="/css/jghstyle.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            /* 모달 오버레이 / 콘텐츠 기본 */
            .modal-overlay {
                position: fixed;
                inset: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(0, 0, 0, 0.35);
                z-index: 1000;
            }

            .modal-content {
                width: 420px;
                background: #fff;
                border-radius: 12px;
                padding: 22px;
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
                position: relative;
                font-family: "Noto Sans KR", sans-serif;
            }

            /* 타이틀 */
            .modal-title {
                margin: 0 0 14px;
                text-align: center;
                font-size: 18px;
                font-weight: 700;
            }

            /* 본문 레이아웃 */
            .option-body {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            /* 각 필드 */
            .field {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
            }

            .field label {
                width: 85px;
                font-size: 13px;
                color: #333;
            }

            /* 콤보박스 스타일 */
            .custom-select {
                width: calc(100% - 95px);
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                background: #fff;
                appearance: none;
            }

            /* 수량 컨트롤 */
            .quantity-field .qty-control {
                width: calc(100% - 95px);
                display: flex;
                align-items: center;
                justify-content: flex-start;
                gap: 8px;
            }

            .qty-btn {
                width: 30px;
                height: 30px;
                border: 1px solid #000000;
                border-radius: 8px;
                background: #fff;
                font-size: 16px;
                cursor: pointer;
            }

            .qty-input {
                width: 70px;
                height: 36px;
                text-align: center;
                border-radius: 8px;
                border: 1px solid #eee;
                font-size: 15px;
                padding: 6px;
            }

            /* 가격 표시 */
            .price-display {
                width: calc(100% - 95px);
                text-align: right;
                font-weight: 600;
                font-size: 15px;
            }

            .price-display.total {
                color: #333;
                font-size: 16px;
            }

            /* 모달 액션(이미 존재) : 버튼 위치/색상 유지 */
            .modal-actions {
                display: flex;
                justify-content: space-between;
                gap: 10px;
                margin-top: 18px;
            }
        </style>
    </head>

    <body style="background-color:white">
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div class="container">
                <header>
                    <div class="top-header">
                        <div class="brand-name">
                            <div><a href="/home.do">RUNNERS' HOUSE</a></div>
                        </div>
                        <div id="right-items">
                            <div>
                                <input type="text" placeholder="검색어를 입력해 주세요.">
                            </div>
                            <div>
                                <a href="/home/login.do">로그인</a>
                            </div>
                            <div>
                                <a href="/home/signup.do">가입하기</a>
                            </div>
                            <div><a href="/home/mypage/inquiry.do">문의</a></div>
                            <div><a href="/home/cart.do">장바구니</a></div>
                        </div>
                    </div>
                    <div class="bottom-header">
                        <div>
                            <a href="/home/product.do">제품</a>
                        </div>
                        <div>
                            <a href="/home/product.do">세일</a>
                        </div>
                        <div>
                            <a href="/home/community/board.do">커뮤니티</a>
                        </div>
                    </div>
                </header>

                <main>
                    <div class="header">
                        <div class="header-welcome">
                            Welcome,
                        </div>
                        <div class="header-user">
                            {{ userName }}
                        </div>
                    </div>
                    <main class="main-content" style="padding: 40px 0; max-width: 1200px; margin: 0 auto;">
                        <h1 class="main-title"
                            style="text-align: center; font-size: 32px; font-weight: 500; margin-bottom: 50px; border-bottom: 1px solid #ccc; padding-bottom: 20px;">
                            장바구니</h1>

                        <div class="cart-layout" style="display: flex; justify-content: space-between; gap: 40px;">
                            <div class="cart-list-container" style="flex: 3; min-width: 60%;">
                                <div class="cart-header-actions"
                                    style="display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
                                    <label style="display: flex; align-items: center; font-weight: bold;">
                                        <input type="checkbox" :checked="isAllSelected" @change="toggleAll($event)"
                                            style="margin-right: 8px; width: 18px; height: 18px;">
                                        전체선택
                                    </label>
                                    <button @click="removeSelected"
                                        style="color:#000; border: 1px solid #ccc; padding: 8px 15px; background: #fff; cursor: pointer;">선택삭제</button>
                                </div>

                                <template v-for="(list, index) in cartList" :key="list.cartNo">
                                    <section class="cart-item"
                                        style="display: flex; padding: 20px 0; border-bottom: 1px solid #eee; align-items: center;">
                                        <input type="checkbox" v-model="list.selected" @change="recomputeSummary"
                                            style="margin-right: 15px; width: 18px; height: 18px; flex-shrink: 0;">

                                        <img v-if="list.imgPath && list.imgName"
                                            :src="list.imgPath + '/' + list.imgName" :alt="list.productName"
                                            style="width: 100px; height: 100px; object-fit: cover; margin-right: 20px; border: 1px solid #eee; flex-shrink: 0;">
                                        <div v-else
                                            style="background: #f0f0f0; width: 100px; height: 100px; display: flex; align-items: center; justify-content: center; margin-right: 20px; flex-shrink: 0; font-size: 12px; color: #666;">
                                            이미지 없음</div>

                                        <div class="product-info" style="flex-grow: 1;">
                                            <p class="product-name"
                                                style="font-size: 16px; font-weight: bold; margin-bottom: 5px;">{{
                                                list.productName || list.productNo }}</p>
                                            <p style="font-size: 14px; color: #666; margin-bottom: 3px;">수량 : {{
                                                list.quantity }} / 사이즈: {{ list.productSize || 'FREE' }}</p>
                                            <p style="font-size: 14px; color: #666; margin-bottom: 3px;">브랜드 : {{
                                                list.brand }}</p>
                                            <p style="font-size: 16px; font-weight: bold;">상품가격 : {{
                                                formatCurrency(list.price) }}원</p>

                                            <div style="margin-top: 10px;">
                                                <button @click="openOptionChangeModal(list.productNo)"
                                                    style="color:#000; border: 1px solid #ccc; padding: 5px 10px; background: #fff; cursor: pointer; font-size: 13px; margin-right: 5px;">옵션
                                                    변경</button>
                                                <button
                                                    style="color:#000; border: 1px solid #ccc; padding: 5px 10px; background: #fff; cursor: pointer; font-size: 13px;">쿠폰
                                                    사용</button>
                                            </div>
                                        </div>
                                    </section>
                                </template>

                                <div v-if="cartList.length === 0"
                                    style="text-align: center; padding: 50px; border-bottom: 1px solid #ccc;">장바구니 안의
                                    내용이 없습니다.</div>
                            </div>

                            <div class="payment-summary"
                                style="flex: 1; min-width: 300px; padding: 20px; border: 1px solid #ccc; height: fit-content; margin-top: 40px;">
                                <h2 style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">구매 금액</h2>
                                <div class="summary-item"
                                    style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                    <span>상품 금액</span>
                                    <span>{{ formatCurrency(totalProductPrice) }}원</span>
                                </div>
                                <div class="summary-item"
                                    style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                    <span>할인 금액</span>
                                    <span style="color: #e74c3c;">{{ formatCurrency(totalDiscount) }}원</span>
                                </div>
                                <div class="summary-item"
                                    style="display: flex; justify-content: space-between; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #eee;">
                                    <span>배송비</span>
                                    <span v-if="deliveryFee === 0" style="color: #27ae60;">무료배송</span>
                                    <span v-else>{{ formatCurrency(deliveryFee) }}원</span>
                                </div>

                                <div class="summary-total"
                                    style="display: flex; justify-content: space-between; font-size: 18px; font-weight: bold; margin-bottom: 20px;">
                                    <span>총 구매 금액</span>
                                    <span style="color: #000;">{{ formatCurrency(totalPaymentAmount) }}원</span>
                                </div>

                                <button :disabled="selectedCount === 0"
                                    style="width: 100%; padding: 15px; background: #000; color: #fff; border: none; font-size: 16px; cursor: pointer;">
                                    {{ formatCurrency(totalPaymentAmount) }}원 구매하기 ({{ selectedCount }}개)
                                </button>
                            </div>
                        </div>

                    </main>
                </main>

                <div id="optionChangeModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3 class="modal-title">옵션 변경</h3>

                        <!-- 옵션(사이즈) 선택 + 수량 컨트롤 -->
                        <div class="option-body">
                            <div class="field">
                                <label>사이즈</label>
                                <select v-model="currentSelectedSize" class="custom-select">
                                    <option v-for="size in availableSizes" :key="size" :value="size">
                                        {{ size }}
                                    </option>
                                </select>
                            </div>

                            <div class="field quantity-field">
                                <label>수량</label>
                                <div class="qty-control">
                                    <button type="button"  @click="decreaseQty">-</button>
                                    <input type="text" class="qty-input" v-model.number="currentQty" />
                                    <button type="button"  @click="increaseQty">+</button>
                                </div>
                            </div>

                            <div class="field price-field">
                                <label>상품가격</label>
                                <div class="price-display">{{ formatCurrency(unitPrice) }}원</div>
                            </div>

                            <div class="field total-field">
                                <label>총 금액</label>
                                <div class="price-display total">{{ formatCurrency(unitPrice * currentQty) }}원</div>
                            </div>
                        </div>

                        <div class="modal-actions">
                            <button class="btn btn-secondary" onclick="closeModal()">돌아가기</button>
                            <button class="btn btn-primary" @click="processCancel()">변경하기</button>
                        </div>
                    </div>
                </div>

                <footer>
                    <div class="footer-left">
                        <div class="company-info">
                            <div><strong>회사명:</strong> 러너스 하우스 주식회사</div>
                            <div><strong>대표:</strong> 김재</div>
                            <div><strong>사업자등록번호:</strong> 123‑45‑67890</div>
                            <div><strong>통신판매업 신고번호:</strong> 2025‑서울‑00987</div>
                            <div><strong>부가세 번호:</strong> KR123456789</div>
                        </div>
                        <div class="copyright">
                            COPYRIGHT© 2025 RUNNERS HOUSE COMPANY. ALL RIGHT RESERVED.
                        </div>
                    </div>
                    <div class="footer-right">
                        <div class="other">
                            <span>회사소개</span>
                            <span>매장안내</span>
                            <span>공지사항</span>
                            <span>이용약관</span>
                            <span>개인정보처리방침</span>
                        </div>
                        <div class="socials">
                            <span>INSTAGRAM</span>
                            <span>NAVER</span>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    userName: "",
                    cartList: [],  //이거배열임
                    // 합계/선택 상태
                    totalProductPrice: 0,
                    totalDiscount: 0,
                    deliveryFee: 0,
                    selectedCount: 0,
                    isAllSelected: false,
                };
            },
            computed: {
                totalPaymentAmount() {
                    return this.totalProductPrice - this.totalDiscount + this.deliveryFee;
                }
            },
            methods: {
                // 함수(메소드) - (key : function())
                openOptionChangeModal: function (productNo) {
                    this.currentOptionChangeProductNo = productNo; // Vue 데이터에 번호 저장
                    $('#optionChangeModal').fadeIn(200); // jQuery로 모달 표시
                    $('body').css('overflow', 'hidden');
                },
                formatCurrency: function (value) {
                    if (!value) return '0';
                    const numValue = typeof value === 'string' ? parseInt(value) : value;
                    return numValue.toLocaleString();
                },
                toggleAll: function (e) {
                    const checked = e.target.checked;
                    this.isAllSelected = checked;
                    this.cartList.forEach(item => { item.selected = checked; });
                    this.recomputeSummary();
                },
                removeSelected: function () {
                    let self = this;
                    // 1. 체크된 상품의 cartNo 목록을 수집합니다.
                    let selectedCartNos = this.cartList       //이거배열임
                        .filter(item => item.selected) // selected: true 인 항목만 필터링
                        .map(item => item.cartNo);     // 해당 항목의 cartNo만 추출하여 배열 생성

                    // 중요 수정 사항: 배열을 "JSON 문자열"로 변환
                    // let selectedCartNosJson = JSON.stringify(selectedCartNos);

                    // 2. 서버로 전송할 param 객체에 sessionId와 selectedCartNos를 포함합니다.
                    let param = {
                        sessionId: self.sessionId,
                        // 배열을 서버로 전송할 때, 같은 이름으로 여러 값을 보내는 일반적인 방식입니다.
                        // 서버에서는 "cartNo"라는 이름으로 배열 또는 리스트 형태로 받게 될 것입니다.
                        // selectedCartNos: selectedCartNos //이거 배열임
                        selectedCartNosJson: JSON.stringify(selectedCartNos)
                    };

                    // 3. 프론트엔드에서만! 빠르게? 먼저 선택된 항목을 제거하여 화면을 업데이트합니다.
                    this.cartList = this.cartList.filter(item => !item.selected);
                    this.recomputeSummary(); // 합계/선택 상태 재계산

                    alert("서버로 보내는 param값 : " + JSON.stringify(param));
                    $.ajax({
                        url: "/home/cartItemDelete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // 서버에서 실제 삭제가 성공적으로 완료되었음을 확인 후 사용자에게 알립니다.
                            if (data.result === 'success') {
                                alert("선택된 상품이 장바구니에서 삭제되었습니다.");
                            } else {
                                // 서버에서 삭제에 실패했을 경우, 사용자에게 알려주고 
                                // 장바구니 목록을 다시 불러오거나 (self.fnList()) 알림을 줍니다.
                                alert("삭제 처리 중 오류가 발생했습니다.");
                            }
                            // 백앤드상태를 다시 맞춰봅니다.(안해도 될듯한데 확실하게 하기위해서)
                            self.fnList();
                        },
                        error: function (xhr, status, error) {
                            alert("서버 통신 오류: 장바구니 삭제에 실패했습니다.");
                            console.error("삭제 실패:", error);
                            // 필요에 따라 목록을 다시 불러와서 프론트엔드와 백엔드 상태를 맞춥니다.
                            self.fnList();
                        }
                    });
                },
                recomputeSummary: function () {
                    let total = 0;
                    let count = 0;
                    this.cartList.forEach(item => {
                        if (item.selected) {
                            const price = parseInt(item.price);
                            const quantity = parseInt(item.quantity || 1);
                            if (!isNaN(price) && !isNaN(quantity)) {
                                total += price * quantity;
                                count += 1;
                            }
                        }
                    });
                    this.totalProductPrice = total;
                    this.totalDiscount = 0;
                    this.deliveryFee = total >= 50000 || total === 0 ? 0 : 3000;
                    this.selectedCount = count;
                    this.isAllSelected = this.cartList.length > 0 && this.cartList.every(i => !!i.selected);
                },
                fnList: function () {
                    let self = this;
                    let param = { sessionId: self.sessionId };
                    // alert("서버로 보내는 param"+ JSON.stringify(param));
                    $.ajax({
                        url: "/home/cart.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert("어쩃든 서버로 돌아옴" + JSON.stringify(data));
                            console.log("어쩃든 서버로 돌아옴 " + JSON.stringify(data))
                            const list = (data && data.list) ? data.list : [];
                            self.cartList = list.map(item => Object.assign({}, item, { selected: true }));
                            self.$nextTick(() => self.recomputeSummary());
                        }
                    });
                },
                fnGetUserInfo: function () {
                    let self = this;
                    $.ajax({
                        url: "/home/mypage/userInfo.dox",
                        dataType: "json",
                        type: "POST",
                        data: { userId: self.sessionId },
                        success: function (data) {
                            console.log("사용자 이름:", data);
                            self.userName = data;
                        },
                        error: function (xhr, status, error) {
                            console.error("사용자 정보 조회 실패:", error);
                            self.userName = "Guest";
                        }
                    });
                },
                increaseQty: function () {
                    if (!this.currentQty || this.currentQty < 1) this.currentQty = 1;
                    // 최대수량 제한이 필요하면 추가 (예: 10)
                    if (this.currentQty < 999) this.currentQty++;
                },
                decreaseQty: function () {
                    if (!this.currentQty || this.currentQty <= 1) {
                        this.currentQty = 1;
                        return;
                    }
                    this.currentQty--;
                },
                openOptionChangeModal: function (productNo) {
                    this.currentOptionChangeProductNo = productNo;
                    // 동적으로 단가/사이즈 목록을 세팅하고 싶을 때 여기에 AJAX로 로드하거나
                    // cartList에서 현재 항목 정보 찾아서 unitPrice, availableSizes, currentSelectedSize 등 설정
                    const item = this.cartList.find(i => i.productNo === productNo || i.cartNo === productNo);
                    if (item) {
                        this.unitPrice = parseInt(item.price) || this.unitPrice;
                        this.availableSizes = item.availableSizes || this.availableSizes; // optional
                        this.currentSelectedSize = item.productSize || this.availableSizes[0];
                        this.currentQty = parseInt(item.quantity) || 1;
                    }

                    $('#optionChangeModal').fadeIn(200);
                    $('body').css('overflow', 'hidden');
                },
                processCancel: function () {
                    // "변경하기" 버튼 클릭 시 실제 처리 로직
                    // 예: AJAX로 옵션/수량 전송 -> 성공 시 모달 닫고 fnList() 호출
                    const payload = {
                        productNo: this.currentOptionChangeProductNo,
                        size: this.currentSelectedSize,
                        quantity: this.currentQty
                    };
                    console.log("옵션 변경 전송:", payload);

                    // TODO: 실제 API 호출로 변경
                    // $.post('/home/updateCartItem.dox', payload, (res) => { ... });

                    // 일단 모달 닫기
                    closeModal();
                },

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnGetUserInfo(); // 사용자 정보 조회
                self.fnList();
            }
        });

        app.mount('#app');

        window.closeModal = function () {
            $('#optionChangeModal').fadeOut(200);
            $('body').css('overflow', 'auto');

            // Vue 데이터 초기화 (app이 전역 변수로 선언되어 있어야 합니다)
            // if (app && app.currentCancelOrderNo !== null) {
            //     app.currentCancelOrderNo = null;
            // }
            // $('#cancelReasonInput').val('');
        }

    </script>