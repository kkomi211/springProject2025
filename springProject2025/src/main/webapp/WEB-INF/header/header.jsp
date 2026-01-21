<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 공통 헤더 컴포넌트 (body에 include) --%>
<header>
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
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
            <div v-if="sessionId != '' && userType != 'K'" style="position: relative; display: inline-block;">
                <a href="/home/mypage/information.do">
                    <i data-lucide="user" stroke-width="1.5"></i>
                </a>
                <a v-if="newReplyCount > 0" href="/home/mypage/my-inquiry.do" style="position: absolute; top: -8px; right: -10px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5); z-index: 10; text-decoration: none;">{{ newReplyCount > 99 ? '99+' : newReplyCount }}</a>
            </div>
            <div v-else-if="sessionId != '' && userType == 'K'" style="position: relative; display: inline-block;">
                <a href="/home/mypage/information/change.do">
                    <i data-lucide="user" stroke-width="1.5"></i>
                </a>
                <a v-if="newReplyCount > 0" href="/home/mypage/my-inquiry.do" style="position: absolute; top: -8px; right: -10px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5); z-index: 10; text-decoration: none;">{{ newReplyCount > 99 ? '99+' : newReplyCount }}</a>
            </div>
            <div v-if="sessionId != '' && userType != 'K'" class="shipping-wrapper" style="position: relative; display: inline-block;">
                <a href="/home/mypage/orders.do">
                    <i data-lucide="truck" stroke-width="1.5"></i>
                    <span v-if="shippingNotificationCount > 0" style="position: absolute; top: -8px; right: -10px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5); z-index: 10;">{{ shippingNotificationCount > 99 ? '99+' : shippingNotificationCount }}</span>
                </a>
            </div>
            <div v-if="sessionId != ''" class="cart-wrapper" style="position: relative; display: inline-block;">
                <a href="/home/cart.do">
                    <i data-lucide="shopping-cart" stroke-width="1.5"></i>
                    <span v-if="cartCount > 0" style="position: absolute; top: -8px; right: -10px; background-color: #ff0000; color: white; font-size: 11px; font-weight: bold; min-width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; padding: 2px; box-shadow: 0 0 2px rgba(0,0,0,0.5); z-index: 10;">{{ cartCount }}</span>
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

