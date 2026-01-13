<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 공통 헤더 컴포넌트 (body에 include) --%>
<style>
    /* 장바구니 배찌 스타일 */
    .cart-wrapper {
        position: relative !important;
        display: inline-block !important;
    }
    .cart-badge {
        position: absolute !important;
        top: -8px !important;
        right: -10px !important;
        background-color: #ff0000 !important;
        color: white !important;
        font-size: 11px !important;
        font-weight: bold !important;
        min-width: 18px !important;
        height: 18px !important;
        border-radius: 50% !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        padding: 2px !important;
        box-shadow: 0 0 2px rgba(0,0,0,0.5) !important;
        z-index: 1000 !important;
    }
</style>

<header>
    <div class="top-header">
        <div class="brand-name">
            <div><a href="/home.do" style="text-decoration: none;">RUNNERS' HOUSE</a></div>
        </div>
        <div id="right-items">
            <div>
                <div v-if="sessionId != ''"><a href="javascript:;" @click="fnLogout"><i data-lucide="log-out" stroke-width="1.5"></i></a></div>
                <div v-else><a href="/home/login.do"><i data-lucide="log-in" stroke-width="1.5"></i></a></div>
            </div>
            <div v-if="sessionId == ''">
                <a href="/home/signup.do"><i data-lucide="user-plus" stroke-width="1.5"></i></a>
            </div>
            <div v-if="sessionId != '' && userType != 'K'">
                <a href="/home/mypage/information.do"><i data-lucide="user" stroke-width="1.5"></i></a>
            </div>
            <div v-else-if="sessionId != '' && userType == 'K'">
                <a href="/home/mypage/information/change.do"><i data-lucide="user" stroke-width="1.5"></i></a>
            </div>
            <div v-if="sessionId != ''" class="cart-wrapper" style="position: relative; display: inline-block;">
                <a href="/home/cart.do">
                    <i data-lucide="shopping-cart" stroke-width="1.5"></i>
                    <span class="cart-badge" v-if="cartCount > 0" style="position: absolute; top: -7px; right: -9px; background-color: #ff0000; color: white; font-size: 13px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 0; line-height: 1; box-shadow: 0 0 2px rgba(0,0,0,0.5); z-index: 1000;">{{ cartCount }}</span>
                </a>
            </div>
        </div>
    </div>
    <div class="bottom-header">
        <div><a href="/home/product.do">제품</a></div>
        <div><a href="javascript:;" @click="fnSale">세일</a></div>
        <div><a href="/home/community/board.do">커뮤니티</a></div>
    </div>
</header>

