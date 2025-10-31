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

            button {
                font-size: 20px;
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
                                                <button @click="openOptionChangeModal(list.productNo, list.cartNo)"
                                                    style="color:#000; border: 1px solid #ccc; padding: 5px 10px; background: #fff; cursor: pointer; font-size: 13px; margin-right: 5px;">
                                                    옵션변경</button>
                                                <button
                                                    style="color:#000; border: 1px solid #ccc; padding: 5px 10px; background: #fff; cursor: pointer; font-size: 13px;">
                                                    쿠폰사용</button>
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
                                    {{ formatCurrency(totalPaymentAmount) }}원 구매하기 ({{ selectedCount }}종류)
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
                                <select v-model="currentSelectedOptionNo" class="custom-select">
                                    <option v-for="opt in availableOptions" :key="opt.productNo" :value="opt.productNo">
                                        {{ opt.productSize }}
                                    </option>
                                </select>
                            </div>

                            <div class="field quantity-field">
                                <label>수량</label>
                                <div class="qty-control">
                                    <button type="button" @click="decreaseQty">-</button>
                                    <input type="text" class="qty-input" v-model.number="currentQty"
                                        @blur="validateQty" /> <!--수량검증추가-->
                                    <button type="button" @click="increaseQty">+</button>
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
                            <button class="btn btn-primary" @click="changeProcess()">변경하기</button>
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

                    // 기존 modal 관련 state 대체
                    currentOptionChangeProductNo: null,   // 원래 카트 항목의 productNo (모달 호출 시 전달되는 식별자)
                    availableOptions: [],                 // 서버에서 받아온 옵션(객체 배열)
                    currentSelectedOptionNo: null,        // 선택된 옵션의 실제 productNo (v-model)
                    currentQty: 1,
                    unitPrice: 156000
                };
            },
            computed: {
                totalPaymentAmount() {
                    return this.totalProductPrice - this.totalDiscount + this.deliveryFee;
                },
                // 선택된 옵션 객체 (productNo로 매칭)
                selectedOption() {
                    if (!this.currentSelectedOptionNo || !this.availableOptions) return null;
                    return this.availableOptions.find(o => String(o.productNo) === String(this.currentSelectedOptionNo)) || null;
                }
            },
            methods: {

                openOptionChangeModal: function (productNo, cartNo) {
                    const self = this;
                    this.currentOptionChangeProductNo = productNo;

                    // 디버그
                    // alert("dox호출하기 직전 productNo=" + productNo);

                    $.ajax({
                        url: "/home/cartItemChange.dox",
                        dataType: "json",
                        type: "POST",
                        data: { productNo: productNo, cartNo: cartNo },
                        success: function (res) {
                            // if (!res) {
                            //     console.warn("옵션 조회: 응답이 없습니다. 기존 데이터 사용");
                            //     openWithFallback();
                            //     return;
                            // }
                            // console.log("모달용 서버에서 돌아온 값" + res);
                            console.log("모달용 서버에서 돌아온 값" + JSON.stringify(res));
                            // 서버가 options 또는 list로 줄 수 있으니 둘 다 검사
                            // const rawList = res.options || res.list || [];
                            let rawList = res.options;
                            // if (!Array.isArray(rawList) || rawList.length === 0) {
                            //     console.warn("옵션 조회: 목록이 비어있음, 기존 데이터 사용");

                            //     openWithFallback();
                            //     return;
                            // }

                            // rawList 항목에서 label(사이즈 텍스트)과 productNo, price, stock을 추출
                            const opts = rawList.map(item => {
                                // item은 이미 JS object일 것으로 가정 (서버가 proper JSON 반환할 때)
                                // 다양한 필드명 커버: productSize, size, productName(숫자 포함), productNo
                                let label = null;
                                if (item.productSize) label = String(item.productSize);
                                else if (item.size) label = String(item.size);
                                else if (item.productName) {
                                    // productName에 사이즈 숫자가 포함된 경우 숫자 부분만 뽑아 라벨로 사용
                                    const m = String(item.productName).match(/(\d{2,3}(?:\.\d)?)/); // 예: 250, 255
                                    label = m ? m[0] : String(item.productName);
                                } else {
                                    label = String(item.productNo || "옵션");
                                }

                                return {
                                    productNo: item.productNo,
                                    label: label,
                                    price: item.price != null ? parseInt(item.price) : null,
                                    stock: item.productStock != null ? item.productStock : null,
                                    raw: item,
                                    productSize: item.productSize,
                                    quantity: item.quantity
                                };
                            });

                            // 중복 label 제거(같은 사이즈가 중복되면 하나만)
                            const unique = [];
                            const seen = new Set();
                            opts.forEach(o => {
                                const key = o.label + '::' + o.productNo; // productNo 포함해 완전 구분
                                if (!seen.has(key)) {
                                    seen.add(key);
                                    unique.push(o);
                                }
                            });

                            // 실제 바인딩
                            self.availableOptions = unique;

                            // unitPrice: 가능한 경우 첫 옵션의 가격 사용, 없으면 cart에 있던 가격
                            const firstOptWithPrice = unique.find(o => o.price);
                            if (firstOptWithPrice) self.unitPrice = firstOptWithPrice.price;
                            else {
                                const cartItem = self.cartList.find(i => i.productNo === productNo || i.cartNo === productNo);
                                if (cartItem) self.unitPrice = parseInt(cartItem.price) || self.unitPrice;
                            }

                            // 초기 선택값: 만약 cartItem이 있고 그 상품의 productSize가 있으면 그 사이즈에 해당하는 option을 찾아 선택
                            const cartItem = self.cartList.find(i => i.productNo === productNo || i.cartNo === productNo);
                            if (cartItem && cartItem.productSize) {
                                // productSize로 일치하는 option 찾기 (label 기준)
                                const match = unique.find(o => String(o.label) === String(cartItem.productSize));
                                self.currentSelectedOptionNo = match ? match.productNo : unique[0].productNo;
                            } else {
                                // 기본은 첫 번째 옵션 선택
                                self.currentSelectedOptionNo = unique[0].productNo;
                            }

                            // 수량 초기화
                            self.currentQty = cartItem ? (parseInt(cartItem.quantity) || 1) : 1;

                            // 모달 오픈
                            $('#optionChangeModal').fadeIn(200);
                            $('body').css('overflow', 'hidden');
                        },
                        error: function (xhr, status, error) {
                            console.error("옵션 목록 조회 실패:", error);
                            openWithFallback();
                        }
                    });

                    function openWithFallback() {
                        const item = self.cartList.find(i => i.productNo === productNo || i.cartNo === productNo);
                        if (item) {
                            // fallback: availableOptions에 현재 항목 하나만 넣기
                            self.availableOptions = [{
                                productNo: item.productNo,
                                label: item.productSize || item.productName || item.productNo,
                                price: item.price,
                                stock: item.productStock,
                                raw: item
                            }];
                            self.currentSelectedOptionNo = self.availableOptions[0].productNo;
                            self.currentQty = parseInt(item.quantity) || 1;
                            self.unitPrice = parseInt(item.price) || self.unitPrice;
                        } else {
                            // 완전 실패
                            self.availableOptions = [];
                            self.currentSelectedOptionNo = null;
                            self.currentQty = 1;
                        }
                        $('#optionChangeModal').fadeIn(200);
                        $('body').css('overflow', 'hidden');
                    }
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

                    // alert("서버로 보내는 param값 : " + JSON.stringify(param));
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

                    // 재고 가져오기 (selectedOption의 quantity 혹은 stock 필드 사용)
                    let stock = this.selectedOption && (this.selectedOption.quantity || this.selectedOption.stock)
                        ? parseInt(this.selectedOption.quantity || this.selectedOption.stock)
                        : 1; // 재고 정보 없으면 넉넉히 허용 또는 1로 바꿀수 있음)

                    if (this.currentQty < stock) {
                        this.currentQty++;
                    } else {
                        // 초과 시 알림 및 고정
                        this.currentQty = stock;
                        alert('재고가 부족합니다. 최대 '+stock+'개 까지 가능합니다.');
                    }
                },

                // --- 수량 감소 (현재 로직 유지)
                decreaseQty: function () {
                    if (!this.currentQty || this.currentQty <= 1) {
                        this.currentQty = 1;
                        return;
                    }
                    this.currentQty--;
                },

                // --- 수동 입력(blur나 기타에서 호출) : 1..stock으로 클램프
                validateQty: function () {
                    let q = parseInt(this.currentQty) || 0;
                    if (q <= 0) q = 1;
                    const stock = this.selectedOption && (this.selectedOption.quantity || this.selectedOption.stock)
                        ? parseInt(this.selectedOption.quantity || this.selectedOption.stock)
                        : null;
                    if (stock !== null) {
                        if (q > stock) {
                            alert(`선택한 옵션의 최대 수량은 ${stock}개 입니다.`);
                            q = stock;
                        }
                    }
                    this.currentQty = q;
                },

                // --- 변경 전송 : 재고 재검사 포함
                changeProcess: function () {
                    const self = this;

                    // 기본 검증
                    if (!this.currentOptionChangeProductNo) {
                        alert("원본 상품 정보가 없습니다.");
                        return;
                    }
                    if (!this.currentSelectedOptionNo) {
                        alert("변경할 옵션을 선택해 주세요.");
                        return;
                    }

                    // 수량 정수화 및 최소값 보정
                    let qty = parseInt(this.currentQty) || 1;
                    if (qty <= 0) {
                        alert("수량은 1 이상이어야 합니다.");
                        return;
                    }

                    // 재고 확인 (selectedOption 활용)
                    const stock = this.selectedOption && (this.selectedOption.quantity || this.selectedOption.stock)
                        ? parseInt(this.selectedOption.quantity || this.selectedOption.stock)
                        : null;
                    if (stock !== null && qty > stock) {
                        alert(`선택한 옵션의 재고가 부족합니다. (최대 ${stock}개)`);
                        this.currentQty = stock;
                        return;
                    }

                    // 원본 cartNo 찾아서 payload 구성
                    const origCart = this.cartList.find(i => i.productNo === this.currentOptionChangeProductNo || i.cartNo === this.currentOptionChangeProductNo);
                    const origCartNo = origCart ? origCart.cartNo : null;

                    const param = {
                        sessionId: this.sessionId,
                        originalCartNo: origCartNo,
                        originalProductNo: this.currentOptionChangeProductNo,
                        newProductNo: this.currentSelectedOptionNo,
                        quantity: qty
                    };

                    console.log("서버로 보내는 changeProcess param : ", param);

                    $.ajax({
                        url: "/home/cartItemEdit.dox",
                        type: "POST",
                        dataType: "json",
                        data: param,
                        success: function (res) {
                            console.log("changeProcess response:", res);
                            if (res && res.result === 'success') {
                                closeModal();
                                alert("옵션이 변경되었습니다.");
                                self.fnList();
                            } else {
                                const msg = (res && res.message) ? res.message : "옵션 변경에 실패했습니다.";
                                alert(msg);
                            }
                        },
                        error: function (xhr, status, err) {
                            console.error("changeProcess error:", err, xhr);
                            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
                        }
                    });
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