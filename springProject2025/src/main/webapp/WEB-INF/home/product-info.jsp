<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="stylesheet" href="/css/user-style.css"> -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="/css/modal-style.css">
        <link href="https://fonts.googleapis.com/css2?family=Anton&family=Fugaz+One&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
            rel="stylesheet">

        <title>Homepage</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/product-info2.css">
        <link rel="stylesheet" href="/css/home.css">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
        <script src="/js/page-change.js"></script>
        <script src="https://unpkg.com/lucide@latest"></script>

        <!-- 최근 본 상품 컴포넌트 스크립트 -->
        <script src="/js/recent-products.js"></script>

        <!-- 위젯 위치 동적 조정 스크립트 -->
        <script src="/js/widget-position.js"></script>

        <!-- session timeout modal -->
        <script src="/js/session-timeout.js"></script>
        <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
        <style>
            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                color: #333;
                line-height: 1.6;
            }

            #app {
                /* Vue.js root이자 전체 페이지 Flex 컨테이너 */
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* 모달 스타일 (채팅방 모달과 동일) */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                /* 반투명 배경 */
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 2000;
                backdrop-filter: blur(3px);
                /* 배경 블러 효과 */
            }

            .modal-content {
                background: white;
                padding: 30px 40px;
                border: none;
                border-radius: 20px;
                width: 400px;
                text-align: center;
                position: relative;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
                animation: fadeIn 0.3s ease;
            }

            .modal-body {
                margin-bottom: 30px;
                font-size: 18px;
                font-weight: bold;
                color: #333;
                line-height: 1.5;
            }

            .modal-actions {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .btn-modal {
                padding: 10px 35px;
                /* 버튼 크기 */
                border-radius: 30px;
                /* 둥근 모서리 */
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                /* 부드러운 전환 효과 */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                /* 그림자 */

                /* ★★★ [기본 상태] 흰색 배경 + 검은 테두리 + 검은 글씨 ★★★ */
                background-color: #fff;
                color: #333;
                border: 2px solid #333;
            }

            /* ★★★ [마우스 오버 상태] 검은 배경 + 흰 글씨 ★★★ */
            .btn-modal:hover {
                background-color: #000;
                /* 검은색 배경 */
                color: #fff;
                /* 흰색 글씨 */
                border-color: #000;
                /* 테두리도 검게 */
                transform: translateY(-2px);
                /* 살짝 떠오르는 효과 */
            }

            /* 기존 색상 클래스 무력화 (통일) */
            .btn-confirm,
            .btn-cancel {
                background-color: #fff;
                color: #333;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* --- 문의 상세 모달 디자인 개선 --- */
            .modal-backdrop {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 3000;
                backdrop-filter: blur(4px);
            }

            .modal-card {
                position: relative;
                background: #fff;
                width: 600px;
                max-width: 90%;
                border-radius: 16px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                animation: slideUp 0.3s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .modal-header {
                padding: 24px;
                background: #f8f9fa;
                border-bottom: 1px solid #eee;
            }

            .modal-title {
                margin: 0;
                font-size: 20px;
                font-weight: 800;
                color: #111;
            }

            .modal-body-content {
                padding: 24px;
                max-height: 60vh;
                overflow-y: auto;
            }

            /* 비밀번호 입력 화면 스타일 */
            .pwd-section {
                padding: 40px 20px;
                text-align: center;
            }

            .modal-input {
                width: 80% !important;
                padding: 12px 16px;
                border: 2px solid #eee;
                border-radius: 8px;
                margin: 15px 0;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            .modal-input:focus {
                border-color: #000;
                outline: none;
            }

            /* 메타 정보 (작성자, 날짜 등) */
            .meta-info {
                display: flex;
                gap: 15px;
                font-size: 13px;
                color: #888;
                margin-top: 8px;
            }

            /* 본문 디자인 */
            .q-box,
            .a-box {
                position: relative;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 20px;
            }

            .q-box {
                background: #f1f3f5;
                color: #333;
            }

            .a-box {
                background: #e7f5ff;
                border-left: 4px solid #228be6;
            }

            .label-badge {
                display: inline-block;
                padding: 2px 8px;
                border-radius: 4px;
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
                margin-bottom: 10px;
            }

            .q-label {
                background: #adb5bd;
                color: #fff;
            }

            .a-label {
                background: #228be6;
                color: #fff;
            }

            .content-text {
                line-height: 1.7;
                white-space: pre-wrap;
                word-break: break-all;
            }

            .modal-footer {
                padding: 16px 24px;
                background: #f8f9fa;
                display: flex;
                justify-content: flex-end;
                border-top: 1px solid #eee;
            }

            .error-text {
                color: #fa5252;
                font-size: 13px;
                margin-top: 5px;
            }

            .cancel-btn {
                padding: 8px 18px;
                background-color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.95rem;
                font-weight: 600;
                transition: background-color 0.2s ease, transform 0.1s ease;
            }

            .cancel-btn2 {
                padding: 10px 24px;
                border-radius: 6px;
                border: 1px solid #ddd;
                background: #fff;
                cursor: pointer;
                font-weight: bold;
            }

            .cancel-btn:hover {
                background: #f1f3f5;
            }

            .cancel-btn2:hover {
                background: #f1f3f5;
            }

            .modal-close-x {
                position: absolute;
                top: 15px;
                right: 20px;
                background: none;
                border: none;
                font-size: 24px;
                font-weight: bold;
                color: #888;
                cursor: pointer;
                line-height: 1;
                transition: color 0.2s;
            }

            .modal-close-x:hover {
                color: #000;
            }

            /* 확인 버튼 디자인 변경: 흰색 배경 -> 호버 시 검정 */
            .btn-verify {
                padding: 10px 40px;
                background-color: #fff;
                color: #333;
                border: 2px solid #333;
                border-radius: 30px;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-verify:hover {
                background-color: #000;
                color: #fff;
                border-color: #000;
                transform: translateY(-2px);
            }

            .btn-verify:disabled {
                border-color: #ccc;
                color: #ccc;
                cursor: not-allowed;
            }

            /* 장바구니/결제 버튼 컨테이너 */
            .check-out {
                display: flex;
                flex-direction: row;
                justify-content: center;
                gap: 15px;
                margin-bottom: 50px;
            }

            /* 장바구니/결제 버튼 스타일 */
            .check-out button {
                background-color: black;
                color: white;
                border-radius: 8px;
                padding: 10px 15px;
                border: 1px solid #333;
                cursor: pointer;
                font-size: 14px;
                min-width: 100px;
                text-align: center;
                transition: all 0.2s ease;
            }

            /* 호버 효과 - 살짝 커지는 효과만 */
            .check-out button:hover {
                transform: scale(1.05);
                background-color: black !important;
                color: white !important;
            }

            /* bluebutton 클래스의 빨간색 호버 효과 제거 */
            .check-out .bluebutton:hover {
                background-color: black !important;
                color: white !important;
            }

            /* 작성하기 버튼 스타일 (orders.jsp와 동일하게) */
            .write-inquiry button {
                background-color: black;
                color: white;
                border-radius: 8px;
                padding: 10px 15px;
                border: 1px solid #333;
                cursor: pointer;
                font-size: 14px;
                min-width: 100px;
                text-align: center;
                transition: all 0.2s ease;
                border: solid 1px gray;
            }

            /* 작성하기 버튼 호버 효과 */
            .write-inquiry button:hover {
                transform: scale(1.05);
                background-color: black !important;
                color: white !important;
            }

            /* 기존 스타일 오버라이드 제거 */
            .write-inquiry button:hover {
                cursor: pointer;
                background-color: black !important;
                color: white !important;
                font-weight: normal;
            }

            /* text-right 버튼들도 동일하게 적용 */
            .text-right button {
                background-color: black;
                color: white;
                border-radius: 8px;
                padding: 10px 15px;
                border: 1px solid #333;
                cursor: pointer;
                font-size: 14px;
                min-width: 100px;
                text-align: center;
                transition: all 0.2s ease;
            }

            .text-right button:hover {
                transform: scale(1.05);
                background-color: black !important;
                color: white !important;
            }
            /* 테스트 */
        </style>
    </head>

    <body>
        <div id="app">

            <%-- 공통 헤더 컴포넌트 --%>
                <jsp:include page="/WEB-INF/header/header.jsp" />

                <div class="container">
                    <main>
                        <div class="newcontent">
                            <!-- <h1 class="margintop">제품</h1> -->
                            <div class="search-box">
                                <input class="search" placeholder="제품 이름을 입력하세요" v-model="keyword"
                                    @keyup.enter="fnSearch">
                                <a href="javascript:;" @click="fnSearch">
                                    <div><i data-lucide="search" stroke-width="1"></i></div>
                                </a>
                            </div>
                        </div>

                        <div class="side-bar">
                            <div class="category-box">
                                <div class="category">카테고리</div>
                                <div class="subcategory" @click="selectCategory('')">전체
                                </div>
                                <div v-for="p in parents" :key="p.typeNo" class="subcategory-wrapper"
                                    @mouseenter="hoverParent = String(p.typeNo)" @mouseleave="hoverParent = null">
                                    <div class="subcategory" @click="selectCategory(p.typeNo)">
                                        {{ p.typeName }}
                                    </div>

                                    <!-- 호버 시 depth=2 목록 -->
                                    <div class="subcategory-children" v-if="hoverParent === String(p.typeNo)">
                                        <div v-for="c in childrenByParent[String(p.typeNo)]" :key="c.typeNo"
                                            class="subcategory child" @click="selectCategory(c.typeNo)">
                                            {{ c.typeName }}
                                        </div>
                                        <div v-if="!childrenByParent[String(p.typeNo)] || childrenByParent[String(p.typeNo)].length === 0"
                                            class="subcategory child empty">
                                            하위 없음
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="infoMain-container">
                            <!-- 수정 부분 -->
                            <div class="img-box">
                                <model-viewer v-if="imgInfo.imgEtc === '.glb'" :src="imgByProduct[String(productNo)]"
                                    auto-rotate camera-controls shadow-intensity="1" environment-image="neutral"
                                    style="width: 100%; height: 500px; background-color: #f8f8f8; border-radius: 15px;">
                                </model-viewer>

                                <img v-else :src="imgByProduct[String(productNo)] || '/img/no-image.png'"
                                    class="big-img" :alt="info.productName">
                            </div>
                            <!-- 수정 부분 -->
                            <div class="infoText-box">
                                <!-- <div class="margin80">{{info.productName}}</div> -->
                                <div class="product-name">{{info.productName}}</div>
                                <div class="product-type">{{info.typeName}}</div>
                                <!-- <div class="margin80 font30" v-if="info.saleYN == 'N'">{{info.price}} 원</div> -->
                                <div class="product-price" v-if="info.saleYN == 'N'">
                                    {{Number(info.price).toLocaleString()}}
                                    원</div>
                                <!-- <div class="margin80 font30" v-else><del>{{info.price}}</del> {{info.salePrice}} 원</div> -->
                                <div class="product-price" v-else><del
                                        style="font-weight: lighter;">{{Number(info.price).toLocaleString()}}</del>
                                    {{Number(info.salePrice).toLocaleString()}} 원</div>
                                <div class="product-size">
                                    <!-- 사이즈 -->
                                    <div>사이즈</div>
                                    <div>
                                        <select class="select-box" v-model="size" @change="fnMaxQuantityChange"
                                            style="text-align: center;">
                                            <option v-for="item in sizeList" :value="item.productSize">사이즈 :
                                                {{item.productSize}} 재고 : {{item.quantity}}
                                            </option>
                                            <!-- <option value="">사이즈 선택해주세요</option>  -->
                                        </select>
                                    </div>
                                </div>
                                <div class="product-quantity">
                                    <div>구매수량</div>
                                    <div>
                                        <button class="add-btn" @click="fnQuantity(-1)">-</button>
                                        <input class="quantity-input" v-model="quantity" disabled>
                                        <button class="add-btn" @click="fnQuantity(1)">+</button>
                                    </div>
                                </div>
                                <div class="check-out">
                                    <button class="bluebutton margin30 height40" @click="fnCart">장바구니 담기 </button>
                                    <button class="bluebutton margin30 height40" @click="fnPayment">결제하기</button>
                                </div>
                            </div>
                            <!-- <div class="detail-box">{{info.productDetail}}</div> -->
                            <div class="detail-box">
                                {{info.productDetail}}
                                <!-- 가볍고 반응성이 뛰어난 러닝화로, 장거리 달리기부터 일상 트레이닝까지 편안한 착용감을 제공합니다.
                            통기성 좋은 메쉬 소재와 쿠셔닝 중창이 발의 피로를 줄여주며,
                            안정적인 아웃솔이 다양한 지면에서 뛰어난 그립력을 제공합니다. -->
                            </div>
                            <div class="container-foot">
                                <div class="foot-box cursor" @click="status = 1" :class="{active: status == 1} ">상품문의
                                </div>
                                <div class="foot-box cursor" @click="status = 2" :class="{active: status == 2} ">상품리뷰
                                </div>
                                <div v-if="status == 1">
                                    <!-- <div class="inquirySearch-box">
                                    <input class="search" v-model="inquiryKeyword">
                                    <button class="bluebutton height40 margin30" @click="fnInquiry">검색</button>
                                    <button class="bluebutton height40 margin30"
                                        @click="fnProductInquiryAdd(productNo)">작성하기</button>
                                </div> -->
                                    <div class="inquiry-search-box">
                                        <input class="search" placeholder="문의 검색" v-model="inquiryKeyword"
                                            @keyup.enter="fnInquiry">
                                        <a href="javascript:;" @click="fnInquiry">
                                            <div><i data-lucide="search" stroke-width="1"></i></div>
                                        </a>
                                    </div>
                                    <div class="inquiry-table">
                                        <table>
                                            <tr>
                                                <th id="inquiry-title">문의 제목</th>
                                                <th id="inquiry-status">답변 상태</th>
                                            </tr>
                                            <tr v-for="item in inquiryList">
                                                <!-- <td id="inquiry-title">이거 뭐할때 쓰는 물건이에요?</td> -->
                                                <td id="inquiry-title" @click="openInquiry(item)">
                                                    <span class="cursor">{{item.title}}</span>
                                                    <span class="material-symbols-outlined"
                                                        v-if="item.pwd != undefined && item.pwd != null">key</span>
                                                </td>
                                                <!-- <td id="inquiry-status">답변완료</td> -->
                                                <td id="inquiry-status">{{item.status === 'Y' ? '답변완료' : '미답변'}}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="write-inquiry">
                                        <button @click="fnProductInquiryAdd(productNo)">작성하기</button>
                                    </div>
                                    <div class="clear text-center margin30">
                                        <span class="margin30 font15 cursor" :class="{bold: inquiryPage == num}"
                                            v-for="num in inquiryTotalPage" @click="fnInquiryPage(num)">{{num}}</span>
                                    </div>
                                </div>
                                <div v-if="status == 2" class="review-container">
                                    <!-- <div class="inquirySearch-box">
                                    <span class="margin30 cursor" :class="{bold: reviewArray == 1}"
                                        @click="fnReviewArray(1)">도움돼요순</span>
                                    <span class="margin30 cursor" :class="{bold: reviewArray == 2}"
                                        @click="fnReviewArray(2)">최신순</span>
                                    <input class="search" v-model="reviewKeyword">
                                    <button class="bluebutton height40" @click="fnReviewList">검색</button>
                                </div> -->
                                    <div class="review-section">
                                        <div class="review-search-box">
                                            <input class="search" placeholder="리뷰 검색" v-model="reviewKeyword"
                                                @keyup.enter="fnReviewArray(reviewArray)">
                                            <a href="javascript:;" @click="fnReviewArray(reviewArray)">
                                                <div><i data-lucide="search" stroke-width="1"></i></div>
                                            </a>
                                        </div>
                                        <div class="helpful-section">
                                            <span class="margin30 cursor" :class="{bold: reviewArray == 1}"
                                                @click="fnReviewArray(1)">도움돼요순</span>
                                            <span class="margin30 cursor" :class="{bold: reviewArray == 2}"
                                                @click="fnReviewArray(2)">최신순</span>
                                        </div>
                                    </div>
                                    <div class="post-container" v-for="item in reviewList">
                                        <div class="post-header">
                                            <div class="post-meta">
                                                <div>
                                                    <span class="post-category">
                                                        도움돼요 수 :
                                                        <span
                                                            style="font-size: 18px; margin-left: 5px; margin-right: 0px;">{{item.helpfulCnt}}</span>
                                                        <!-- <span class="material-symbols-outlined heart"
                                                        @click="fnHeartUp(item.reviewNo)" style="margin-left: 10px; ">
                                                        heart_plus
                                                    </span> -->
                                                    </span>
                                                    <span class="material-symbols-outlined heart"
                                                        @click="fnHeartUp(item.reviewNo)" style="margin-left: 10px;">
                                                        heart_plus
                                                    </span>
                                                </div>
                                                <div>
                                                    <span v-for="n in 5" :key="n"
                                                        style="font-size: 20px; color: #ccc; margin-right: 2px;"
                                                        :style="{ color: n <= item.rating ? 'gold' : '#ccc' }">
                                                        &#9733;
                                                    </span>
                                                    <span style="margin-left: 10px; font-size: 1rem; color: #666;">
                                                        ({{item.rating}}/5)
                                                    </span>
                                                </div>
                                                <span class="post-date">{{item.cdate.split(' ')[0]}}</span>
                                            </div>
                                            <!-- <div>
                                            <span v-for="n in 5" :key="n"
                                                style="font-size: 1rem; color: #ccc; margin-right: 2px;"
                                                :style="{ color: n <= item.rating ? 'gold' : '#ccc' }">
                                                &#9733;
                                            </span>
                                            <span style="margin-left: 10px; font-size: 1rem; color: #666;">
                                                ({{item.rating}}/5)
                                            </span>
                                        </div> -->
                                            <h2 class="post-title">
                                                {{item.title}}
                                            </h2>
                                            <div class="post-author">
                                                <strong>{{item.userId}}</strong>
                                            </div>
                                        </div>
                                        <div class="post-content" v-html="item.content"></div>
                                    </div>

                                    <!-- <div class="table margintop100">
                                    <table v-for="item in reviewList">
                                        <tr>
                                            <th>유저</th>
                                            <td>{{item.userId}}</td>
                                        </tr>
                                        <tr>
                                            <th>리뷰날짜</th>
                                            <td>{{item.cdate}}</td>
                                        </tr>
                                        <tr>
                                            <th>도움돼요 수</th>
                                            <td>{{item.helpfulCnt}}
                                                <span class="material-symbols-outlined heart"
                                                    @click="fnHeartUp(item.reviewNo)">
                                                    heart_plus
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>리뷰 제목</th>
                                            <td><span class="cursor">{{item.title}}</span></td>
                                        </tr>
                                        <tr>
                                            <th>별점</th>
                                            <td>{{item.rating}}</td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td v-html="item.content"></td>
                                        </tr>
                                    </table>
                                </div> -->
                                    <div class="clear text-center margin30">
                                        <span class="margin30 font15 cursor" :class="{bold: reviewPage == num}"
                                            v-for="num in reviewTotalPage" @click="fnReviewPage(num)">{{num}}</span>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- 문의 상세 모달 -->
                        <div v-if="showInquiryModal" class="modal-backdrop" @click.self="closeInquiry">
                            <div class="modal-card">
                                <button class="modal-close-x" @click="closeInquiry">&times;</button>

                                <div v-if="needPwd && !authorized" class="pwd-section">
                                    <h3 class="modal-title">비공개 문의</h3>
                                    <p style="color: #666; margin-top: 10px;">작성 시 설정한 비밀번호를 입력해주세요.</p>
                                    <input type="password" v-model="pwdInput" class="modal-input" placeholder="Password"
                                        @keyup.enter="confirmPwd">
                                    <div class="error-text" v-if="pwdError">{{ pwdError }}</div>
                                    <div class="modal-actions" style="margin-top: 20px;">
                                        <button class="btn-verify" @click="confirmPwd" :disabled="loading">확인</button>
                                    </div>
                                </div>

                                <div v-else>
                                    <div class="modal-header">
                                        <h3 class="modal-title">{{ inquiryDetail.title }}</h3>
                                        <div class="meta-info">
                                            <span><strong>작성자</strong> {{ inquiryDetail.userId }}</span>
                                            <span><strong>작성일</strong> {{ inquiryDetail.cdate }}</span>
                                        </div>
                                    </div>

                                    <div class="modal-body-content">
                                        <div class="q-box">
                                            <span class="label-badge q-label">Question</span>
                                            <div class="content-text" v-html="inquiryDetail.content"></div>
                                        </div>

                                        <div v-if="inquiryDetail.status == 'Y'" class="a-box">
                                            <span class="label-badge a-label">Answer</span>
                                            <div class="content-text" v-html="inquiryDetail.answer"></div>
                                        </div>
                                        <div v-else class="a-box"
                                            style="background: #fff5f5; border-left: 4px solid #ff8787;">
                                            <span class="label-badge"
                                                style="background: #ff8787; color: #fff;">Status</span>
                                            <div class="content-text" style="color: #fa5252;">담당자가 문의 내용을 확인 중입니다. 조금만
                                                기다려주세요!</div>
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button class="cancel-btn2" @click="closeInquiry">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </main>
                    <div class="modal-overlay" v-if="showCartModal" @click.self="showCartModal = false">
                        <div class="modal-content">
                            <div class="modal-body">
                                장바구니에 상품을 담았습니다.<br>
                                장바구니로 이동하시겠습니까?
                            </div>
                            <div class="modal-actions">
                                <button class="btn-modal btn-cancel" @click="showCartModal = false">계속 쇼핑</button>
                                <button class="btn-modal btn-confirm" @click="moveToCartPage">장바구니 이동</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- session time out modal -->
                <%@ include file="/WEB-INF/home/session-timeout-modal.jsp" %>

                    <!-- 최근 본 상품 컴포넌트 -->
                    <div id="recent-products-widget"></div>

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
                                <span><a href="/home/about.do">회사소개</a></span>
                                <span><a @click="fnNotice">공지사항</a></span>
                                <span><a href="/home/terms.do">이용약관</a></span>
                                <span><a href="/home/privacy.do">개인정보처리방침</a></span>
                            </div>
                            <div class="socials">
                                <span>INSTAGRAM</span>
                                <span>NAVER</span>
                            </div>

                        </div>


                    </footer>
        </div>
    </body>

    </html>

    <script>
        lucide.createIcons();
        const app = Vue.createApp({
            mixins: [sessionTimeoutMixin],
            data() {
                return {
                    // 변수 - (key : value)
                    list: [],
                    imgList: [],
                    reviewList: [],
                    typeList: [],
                    hoverParent: null,
                    productNo: "${productNo}",
                    category: "",
                    keyword: "",
                    info: {},
                    sizeList: [],
                    rating: "${rating}",
                    status: 1,
                    inquiryList: [],
                    inquiryPage: 1,
                    inquiryPageSize: 6,
                    inquiryTotalPage: 0,
                    showInquiryModal: false,
                    inquiryDetail: {},
                    targetInquiryNo: null,
                    needPwd: false,
                    authorized: false,
                    pwdInput: "",
                    pwdError: "",
                    loading: false,
                    reviewArray: 1,
                    reviewPage: 1,
                    reviewPageSize: 2,
                    reviewTotalPage: 0,
                    reviewKeyword: "",
                    inquiryKeyword: "",
                    quantity: 1,
                    size: "",
                    maxQuantity: 1,
                    sessionId: "${sessionId}", // HARDCODING for test purposes 
                    userName: "",
                    imgInfo: {},
                    userType: '${userType}',

                    cartCount: 0, // 장바구니 수량 변수 추가 (jgh260114)
                    newReplyCount: 0, // 새 답변 개수
                    shippingNotificationCount: 0, // 배송 알림 개수
                    showCartModal: false
                };
            },
            computed: {
                imgByProduct() {
                    const m = {};
                    for (const img of this.imgList) {
                        const key = String(img.productNo);
                        // 여러 장이면 첫 장만 사용(원하면 배열로 push해서 썸네일/갤러리 구성 가능)
                        if (!m[key]) m[key] = img.imgPath;
                    }
                    return m;
                },
                parents() {
                    return (this.typeList || []).filter(t => String(t.depth) === '1');
                },
                // 부모 typeNo -> 자식 배열 매핑
                childrenByParent() {
                    const map = {};
                    for (const t of (this.typeList || [])) {
                        if (String(t.depth) !== '2') continue;
                        const parentKey = String(t.typePart);       // 자식의 typePart가 부모 typeNo
                        if (!map[parentKey]) map[parentKey] = [];
                        map[parentKey].push(t);
                    }
                    // 정렬(옵션): 이름순
                    for (const k in map) {
                        map[k].sort((a, b) => String(a.typeName).localeCompare(String(b.typeName), 'ko', { sensitivity: 'base' }));
                    }
                    return map;
                }
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        productNo: self.productNo
                    };
                    $.ajax({
                        url: "/product/user/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                            self.sizeList = data.sizeList;
                            self.category = data.typeNo;
                            self.size = data.sizeList[0].productSize;
                            self.maxQuantity = data.sizeList[0].quantity;
                            self.imgInfo = data.imgInfo;

                            // 최근 본 상품 저장 (Vue.js 데이터 로드 후)
                            // imgByProduct가 로드될 때까지 약간의 지연
                            self.saveProductToRecent = function () {
                                if (!window.RecentProducts || !data.info) return;

                                try {
                                    const productName = data.info.productName || '';
                                    const productPrice = data.info.saleYN === 'Y' && data.info.salePrice
                                        ? data.info.salePrice.toLocaleString() + ' 원'
                                        : data.info.price.toLocaleString() + ' 원';

                                    // imgByProduct가 계산될 때까지 기다림
                                    const productImage = (self.imgByProduct && self.imgByProduct[String(self.productNo)])
                                        ? self.imgByProduct[String(self.productNo)]
                                        : '/img/no-image.png';

                                    let recentProducts = window.RecentProducts.get() || [];
                                    recentProducts = recentProducts.filter(p => p.productNo !== self.productNo);

                                    const productInfo = {
                                        productNo: self.productNo,
                                        productName: productName,
                                        productPrice: productPrice,
                                        productImage: productImage,
                                        viewDate: new Date().toISOString()
                                    };

                                    recentProducts.unshift(productInfo);
                                    if (recentProducts.length > 3) {
                                        recentProducts = recentProducts.slice(0, 3);
                                    }

                                    localStorage.setItem('recentProducts', JSON.stringify(recentProducts));

                                    // 위젯이 있으면 업데이트
                                    window.RecentProducts.render();
                                } catch (error) {
                                    console.error('최근 본 상품 저장 오류:', error);
                                }
                            };

                            // imgByProduct가 로드될 때까지 약간의 지연
                            setTimeout(function () {
                                self.saveProductToRecent();
                            }, 500);
                        }
                    });
                },
                fnImgList() {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/product/img/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.imgList = data.imgList;

                            // 이미지 로드 후 최근 본 상품 저장 (fnInfo가 이미 완료된 경우)
                            if (self.saveProductToRecent && typeof self.saveProductToRecent === 'function') {
                                self.$nextTick(function () {
                                    self.saveProductToRecent();
                                });
                            }
                        }
                    });
                },
                fnReviewList() {
                    let self = this;
                    let param = {
                        productNo: self.productNo,
                        page: (self.reviewPage - 1) * self.reviewPageSize,
                        pageSize: self.reviewPageSize,
                        reviewArray: self.reviewArray,
                        keyword: self.reviewKeyword
                    };
                    $.ajax({
                        url: "/product/review/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.reviewList = data.reviewList;
                            self.reviewTotalPage = Math.ceil(data.cnt / self.reviewPageSize);
                        }
                    });
                },
                selectCategory(typeNo) {
                    let self = this;
                    self.category = typeNo;
                    console.log(" == > " + self.category);
                    self.fnCategoryProduct(typeNo);
                    // 페이지 이동 넣어야함
                },
                fnList() {
                    let self = this;
                    let param = {
                    };
                    $.ajax({
                        url: "/product/user/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.typeList = data.typeList;
                        }
                    });
                },
                fnInquiry() {
                    let self = this;
                    let param = {
                        productNo: self.productNo,
                        page: (self.inquiryPage - 1) * self.inquiryPageSize,
                        pageSize: self.inquiryPageSize,
                        keyword: self.inquiryKeyword
                    };
                    $.ajax({
                        url: "/product/inquiry/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.inquiryList = data.inquiryList;
                            self.inquiryTotalPage = Math.ceil(data.inquiryTotal / self.inquiryPageSize);
                        }
                    });
                },
                openInquiry(item) {
                    this.targetInquiryNo = item.inquiryNo;
                    this.pwdInput = "";
                    this.pwdError = "";
                    this.authorized = false;

                    // pwd 유무로 분기 (널/빈문자 모두 잠금으로 처리)
                    this.needPwd = (item.pwd !== undefined && item.pwd !== null && String(item.pwd).trim() !== "");
                    this.showInquiryModal = true;

                    if (!this.needPwd) {
                        // 공개 글: 바로 상세 호출
                        this.fetchInquiryDetail(null);
                    }
                },

                closeInquiry() {
                    this.showInquiryModal = false;
                    this.inquiryDetail = {};
                    this.targetInquiryNo = null;
                    this.needPwd = false;
                    this.authorized = false;
                    this.pwdInput = "";
                    this.pwdError = "";
                },

                confirmPwd() {
                    if (!this.pwdInput) {
                        this.pwdError = "비밀번호를 입력하세요.";
                        return;
                    }
                    this.fetchInquiryDetail(this.pwdInput);
                },

                fetchInquiryDetail(pwd) {
                    const self = this;
                    self.loading = true;
                    $.ajax({
                        url: "/product/inquiry/view.dox",
                        type: "POST",
                        dataType: "json",
                        data: {
                            inquiryNo: self.targetInquiryNo,
                            pwd: pwd || null     // 공개글이면 빈값
                        },
                        success: function (res) {
                            self.loading = false;
                            // 서버 응답 예시 가정:
                            // { success: true, inquiry: { title, content, userId, cdate, status } }
                            // { success: false, code: 'BAD_PWD', message: '비밀번호가 일치하지 않습니다.' }
                            if (res.success == "true") {
                                self.inquiryDetail = res.inquiry || {};
                                self.authorized = true;   // 잠금 글도 통과됨
                                self.pwdError = "";
                            } else {
                                if (res.code === "BAD_PWD") {
                                    self.pwdError = "비밀번호가 일치하지 않습니다.";
                                } else if (res && res.code === 'LOCKED') {
                                    self.pwdError = "비밀번호가 필요한 게시글입니다.";
                                } else {
                                    self.pwdError = "조회 중 오류가 발생했습니다.";
                                }
                            }
                        },
                        error: function () {
                            self.loading = false;
                            self.pwdError = "네트워크 오류가 발생했습니다.";
                        }
                    });
                },
                fnReviewPage(num) {
                    let self = this;
                    self.reviewPage = num;
                    self.fnReviewList();
                },
                fnInquiryPage(num) {
                    let self = this;
                    self.inquiryPage = num;
                    self.fnInquiry();
                },
                fnReviewArray(num) {
                    let self = this;
                    self.reviewArray = num;
                    self.fnReviewList();
                },
                fnHeartUp(reviewNo) {
                    let self = this;
                    if (!self.fnLoginCheck()) {
                        alert("로그인후 시도해주세요!")
                        location.href = "/home/login.do";
                    }
                    let param = {
                        reviewNo: reviewNo,
                        userId: self.sessionId
                    };
                    $.ajax({
                        url: "/product/review/1up.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "same") {
                                alert("이미 추천한 리뷰입니다!");
                                return;
                            }
                            self.fnReviewList();
                        }
                    });
                },

                // 장바구니 수량을 서버에서 가져오는 함수
                fetchCartCount() {
                    // 세션 아이디가 없으면 실행하지 않음
                    if (this.sessionId == '' || this.sessionId == null) return;

                    let self = this;
                    $.ajax({
                        url: '/api/cartCount.dox',
                        method: 'GET',
                        // ★ 서버의 @RequestParam HashMap map으로 전달될 데이터 ★
                        data: {
                            sessionId: self.sessionId
                        },
                        dataType: 'json',
                        success: (response) => {
                            console.log("서버 응답 데이터:", response);
                            if (response.result === 'success') {
                                self.cartCount = response.count; // 서버에서 보낸 count 값을 Vue 변수에 저장
                            }
                        },
                        error: (err) => {
                            console.error("AJAX 호출 중 오류 발생:", err);
                        }
                    });
                },

                // 새 답변 개수 체크 (localStorage 기반)
                checkNewReplyCount: function () {
                    let self = this;
                    if (!self.sessionId || self.sessionId === '') {
                        self.newReplyCount = 0;
                        return;
                    }

                    // localStorage에서 확인한 답변 목록 불러오기
                    const storageKey = `checkedReplies_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);
                    let checkedReplies = [];
                    if (saved) {
                        try {
                            checkedReplies = JSON.parse(saved);
                        } catch (e) {
                            checkedReplies = [];
                        }
                    }

                    // 서버에서 답변 완료된 문의 목록 가져오기
                    $.ajax({
                        url: "/home/mypage/my-inquiry.dox",
                        dataType: "json",
                        type: "POST",
                        data: {
                            sessionId: self.sessionId,
                            page: 1,
                            pageSize: 1000 // 모든 문의 가져오기
                        },
                        success: function (data) {
                            if (data.result == "success" && data.list) {
                                let uncheckedCount = 0;
                                data.list.forEach(function (item) {
                                    if (item.status === 'Y' && !checkedReplies.includes(item.inquiryNo)) {
                                        uncheckedCount++;
                                    }
                                });
                                self.newReplyCount = uncheckedCount;
                                console.log("새 답변 개수:", uncheckedCount);
                            } else {
                                self.newReplyCount = 0;
                            }
                        },
                        error: function () {
                            self.newReplyCount = 0;
                        }
                    });
                },

                // 배송 알림 개수 체크
                checkShippingNotificationCount: function () {
                    let self = this;
                    if (!self.sessionId || self.sessionId === '') {
                        self.shippingNotificationCount = 0;
                        return;
                    }

                    // localStorage에서 확인한 배송 주문 목록 불러오기
                    const storageKey = `checkedShippingOrders_${self.sessionId}`;
                    const saved = localStorage.getItem(storageKey);
                    let checkedOrders = [];
                    if (saved) {
                        try {
                            checkedOrders = JSON.parse(saved);
                        } catch (e) {
                            checkedOrders = [];
                        }
                    }

                    // 서버에서 주문 목록 가져오기 (모든 주문)
                    $.ajax({
                        url: "/home/mypage/orders.dox",
                        dataType: "json",
                        type: "POST",
                        data: {
                            sessionId: self.sessionId,
                            page: 1,
                            pageSize: 1000, // 모든 주문 가져오기
                            startRow: 1,
                            endRow: 1000
                        },
                        success: function (data) {
                            if (data.result == "success" && data.list) {
                                let uncheckedCount = 0;
                                data.list.forEach(function(order) {
                                    // 배송중 상태이고 확인하지 않은 주문만 카운트
                                    if (order.status === '배송중' && !checkedOrders.includes(String(order.orderNo))) {
                                        uncheckedCount++;
                                    }
                                });
                                self.shippingNotificationCount = uncheckedCount;
                            } else {
                                self.shippingNotificationCount = 0;
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("배송 알림 - API 오류:", error, "상태:", status, "응답:", xhr.responseText);
                            self.shippingNotificationCount = 0;
                        }
                    });
                },

                fnCategoryProduct(category) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: category, sessionId: self.sessionId, keyword: "" });
                },
                fnProduct() {
                    let self = this;
                    pageChange("/home/product.do", { keyword: "", category: "", sessionId: self.sessionId, keyword: "" });
                },
                fnProductSearch(key) {
                    let self = this;
                    pageChange("/home/product.do", { keyword: key, category: "", sessionId: self.sessionId, keyword: "" });
                },
                fnProductInquiryAdd(proNo) {
                    let self = this;
                    if (!self.fnLoginCheck()) {
                        alert("로그인후 시도해주세요!")
                        location.href = "/home/login.do";
                        return;
                    }
                    pageChange("/home/product/inquiry/add.do", { productNo: proNo, sessionId: self.sessionId });
                },
                fnCart() {
                    let self = this;
                    if (!self.fnLoginCheck()) {
                        alert("로그인후 시도해주세요!")
                        location.href = "/home/login.do";
                    }
                    let param = {
                        productNo: self.productNo,
                        size: self.size,
                        userId: self.sessionId,
                        quantity: self.quantity
                    };
                    $.ajax({
                        url: "/product/cart/insert.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            self.showCartModal = true;
                            self.fetchCartCount();
                        }
                    });
                },
                fnQuantity(num) {
                    let self = this;
                    if (self.quantity + num <= 0 || self.quantity + num > self.maxQuantity) {
                        return;
                    }
                    self.quantity = self.quantity + num;
                },
                fnMaxQuantityChange() {
                    const found = this.sizeList.find(
                        s => String(s.productSize) === String(this.size)
                    );
                    this.maxQuantity = found ? Number(found.quantity) : 0;
                    if(this.maxQuantity < this.quantity){
                        this.quantity = this.maxQuantity;
                    }
                },
                fnUserInfo() {
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
                fnPayment() {
                    let self = this;
                    if (!self.fnLoginCheck()) {
                        alert("로그인후 시도해주세요!")
                        location.href = "/home/login.do";
                    }
                    pageChange("/home/payment/paybefore.do", {
                        productNo: self.productNo,
                        quantity: self.quantity,
                        productSize: self.size
                    });
                },
                fnLogout: function () {
                    let self = this;
                    self.clearSessionTimers();
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
                    })
                },
                fnLoginCheck() {
                    let self = this;
                    if (self.sessionId == '' || self.sessionId == 'undefined' || self.sessionId == null) {
                        return false;
                    }
                    return true;
                },
                fnSale() {
                    let self = this;
                    self.saleYN = 'Y';
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN, keyword: "" });
                },
                fnNotice() {
                    let self = this;
                    pageChange("/home/community/board.do", { type: "B" });
                },
                fnSearch() {
                    let self = this;
                    pageChange("/home/product.do", { category: "", sessionId: self.sessionId, saleYN: self.saleYN, keyword: self.keyword });
                },
                moveToCartPage() {
                    let self = this;
                    self.showCartModal = false; // 모달 닫기
                    pageChange("/home/cart.do", { sessionId: self.sessionId });
                },

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnInfo();
                self.fnImgList();
                self.fnReviewList();
                self.fnInquiry();
                self.fnUserInfo();


                // 2. 조건문을 잠시 제거하거나, 로그를 찍어 확인합니다.
                if (self.sessionId && self.sessionId !== '') {
                    console.log("장바구니 수량 조회를 시작합니다.");
                    self.fetchCartCount();
                    self.checkNewReplyCount(); // 새 답변 개수 체크
                    self.checkShippingNotificationCount(); // 배송 알림 개수 체크
                    self.setupActivityListeners();
                    self.startSessionTimer();
                } else {
                    console.warn("로그인 상태가 아니라서 장바구니 수량을 가져오지 않습니다.");
                }

                // 주기적으로 새 답변 체크 (30초마다)
                setInterval(function () {
                    if (self.sessionId && self.sessionId !== '') {
                        self.checkNewReplyCount();
                        self.checkShippingNotificationCount();
                    }
                }, 30000);
            },
            beforeUnmount() {
                let self = this;
                self.removeActivityListeners();
                self.clearSessionTimers();
            }
        });
        app.config.compilerOptions.isCustomElement = tag => tag === 'model-viewer';
        app.mount('#app');
    </script>