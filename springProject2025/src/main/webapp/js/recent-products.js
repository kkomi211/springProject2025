/**
 * 최근 본 상품 컴포넌트
 * localStorage를 사용하여 최근 본 상품을 저장하고 표시합니다.
 */

(function() {
    'use strict';

    const STORAGE_KEY = 'recentProducts';
    const MAX_RECENT_PRODUCTS = 3; // 최대 표시 개수

    /**
     * 최근 본 상품 컴포넌트 생성 및 초기화
     */
    function initRecentProducts() {
        let widget = document.getElementById('recent-products-widget');
        let isNewWidget = false;
        
        // 위젯이 없으면 생성
        if (!widget) {
            widget = createWidget();
            document.body.appendChild(widget);
            isNewWidget = true;
        } else {
            // 이미 존재하는 div가 있으면 그 안에 위젯 내용 추가 (비어있는 경우만)
            if (!widget.querySelector('.recent-products-panel')) {
                widget.className = 'recent-products-widget';
                widget.innerHTML = `
                    <div class="recent-products-panel">
                        <div class="recent-products-header">
                            <h3>최근 본 상품</h3>
                        </div>
                        <div class="recent-products-list" id="recent-products-list">
                            <!-- 상품 목록이 여기에 동적으로 추가됩니다 -->
                        </div>
                    </div>
                `;
                isNewWidget = true;
            }
        }
        
        // 최근 본 상품 목록 렌더링
        renderRecentProducts();
        
        // 위젯 위치 조정 함수 호출 (전역 함수가 있으면)
        if (typeof window.adjustWidgetPositions === 'function') {
            setTimeout(window.adjustWidgetPositions, 100);
        }

        // 페이지 이동 감지하여 상품 저장
        if (shouldSaveProduct()) {
            saveProductToRecent();
        }
    }

    /**
     * 위젯 HTML 생성
     */
    function createWidget() {
        const widget = document.createElement('div');
        widget.className = 'recent-products-widget';
        widget.id = 'recent-products-widget';
        widget.innerHTML = `
            <div class="recent-products-panel">
                <div class="recent-products-header">
                    <h3>최근 본 상품</h3>
                </div>
                <div class="recent-products-list" id="recent-products-list">
                    <!-- 상품 목록이 여기에 동적으로 추가됩니다 -->
                </div>
            </div>
        `;
        return widget;
    }

    /**
     * 상품을 최근 본 상품에 저장해야 하는지 확인
     * (product-info.jsp, product.jsp, sale 페이지에서만 저장)
     */
    function shouldSaveProduct() {
        const currentPath = window.location.pathname;
        // 커뮤니티 페이지는 제외
        if (currentPath.includes('/community/')) {
            return false;
        }
        // 상품 관련 페이지에서만 저장
        return currentPath.includes('/product-info.do') || 
               currentPath.includes('/product.do') ||
               currentPath.includes('/sale');
    }

    /**
     * 현재 페이지의 상품 정보를 최근 본 상품에 저장
     */
    function saveProductToRecent() {
        try {
            // URL에서 productNo 추출
            const urlParams = new URLSearchParams(window.location.search);
            const productNo = urlParams.get('productNo');
            
            if (!productNo) {
                return; // productNo가 없으면 저장하지 않음
            }

            // 페이지에서 상품 정보 추출 시도
            const productName = document.querySelector('h1, h2, .product-name, [data-product-name]')?.textContent?.trim() || '';
            const productPrice = document.querySelector('.price, .product-price, [data-product-price]')?.textContent?.trim() || '';
            const productImage = document.querySelector('.product-image img, .product-img img, [data-product-image]')?.src || 
                                 document.querySelector('img[alt*="상품"], img[alt*="제품"]')?.src || '';

            // 기존 최근 본 상품 목록 가져오기
            let recentProducts = getRecentProducts();

            // 이미 존재하는 상품이면 제거 (중복 방지)
            recentProducts = recentProducts.filter(p => p.productNo !== productNo);

            // 새로운 상품 정보 추가
            const productInfo = {
                productNo: productNo,
                productName: productName || `상품 ${productNo}`,
                productPrice: productPrice || '',
                productImage: productImage || '/img/no-image.jpg',
                viewDate: new Date().toISOString()
            };

            recentProducts.unshift(productInfo); // 맨 앞에 추가

            // 최대 개수 제한
            if (recentProducts.length > MAX_RECENT_PRODUCTS) {
                recentProducts = recentProducts.slice(0, MAX_RECENT_PRODUCTS);
            }

            // localStorage에 저장
            localStorage.setItem(STORAGE_KEY, JSON.stringify(recentProducts));

            // 위젯이 있으면 업데이트
            const widget = document.getElementById('recent-products-widget');
            if (widget) {
                renderRecentProducts();
            }
        } catch (error) {
            console.error('최근 본 상품 저장 오류:', error);
        }
    }

    /**
     * localStorage에서 최근 본 상품 목록 가져오기
     */
    function getRecentProducts() {
        try {
            const stored = localStorage.getItem(STORAGE_KEY);
            return stored ? JSON.parse(stored) : [];
        } catch (error) {
            console.error('최근 본 상품 불러오기 오류:', error);
            return [];
        }
    }

    /**
     * 최근 본 상품 목록 렌더링
     */
    function renderRecentProducts() {
        const listContainer = document.getElementById('recent-products-list');
        if (!listContainer) {
            return;
        }

        const recentProducts = getRecentProducts();

        if (recentProducts.length === 0) {
            listContainer.innerHTML = '<div class="recent-products-empty">최근 본 상품이 없습니다.</div>';
            return;
        }

        // 최대 3개만 표시
        const displayProducts = recentProducts.slice(0, MAX_RECENT_PRODUCTS);

        listContainer.innerHTML = displayProducts.map(product => `
            <a href="/home/product-info.do?productNo=${product.productNo}" class="recent-product-item" title="${escapeHtml(product.productName)}">
                <img src="${product.productImage}" alt="${product.productName}" class="recent-product-image" 
                     onerror="this.src='/img/no-image.jpg'">
            </a>
        `).join('');
    }

    /**
     * 최근 본 상품에서 제거
     */
    function removeProduct(productNo) {
        try {
            let recentProducts = getRecentProducts();
            recentProducts = recentProducts.filter(p => p.productNo !== productNo);
            localStorage.setItem(STORAGE_KEY, JSON.stringify(recentProducts));
            renderRecentProducts();
        } catch (error) {
            console.error('최근 본 상품 삭제 오류:', error);
        }
    }

    /**
     * HTML 이스케이프
     */
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // DOMContentLoaded 시 초기화
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initRecentProducts);
    } else {
        initRecentProducts();
    }

    // 전역 함수로 노출 (다른 스크립트에서 사용 가능)
    window.RecentProducts = {
        save: saveProductToRecent,
        render: renderRecentProducts,
        get: getRecentProducts,
        remove: removeProduct
    };
})();

