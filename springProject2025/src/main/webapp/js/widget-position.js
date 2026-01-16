/**
 * 위젯 위치 동적 조정 (푸터 영역 침범 방지)
 * 예산 추천 버튼과 최근 본 상품 위젯의 위치를 스크롤에 따라 자동 조정합니다.
 */
(function() {
    'use strict';
    
    // 위젯 위치 조정 함수 (전역 함수로 노출)
    window.adjustWidgetPositions = function() {
        const footer = document.querySelector('footer');
        const budgetBtn = document.querySelector('.budget-recommend-btn');
        const recentWidget = document.getElementById('recent-products-widget');
        
        if (!recentWidget) return; // 최근 본 상품 위젯이 없으면 종료
        
        const windowHeight = window.innerHeight;
        const defaultBottom = 30; // 기본 하단 여백
        const widgetHeight = recentWidget.offsetHeight || 310; // 최근 본 상품 위젯 높이
        const budgetBtnHeight = 70; // 예산 버튼 높이
        const spacing = 10; // 위젯 간 간격
        const footerPadding = 30; // 푸터 위 여백
        
        if (footer) {
            const footerRect = footer.getBoundingClientRect();
            // 푸터가 화면에 보이는지 확인
            const isFooterVisible = footerRect.top < windowHeight && footerRect.bottom > 0;
            const footerHeight = footer.offsetHeight || 200;
            
            if (isFooterVisible) {
                // 푸터가 보일 때: 푸터 위에 배치
                const footerBottomFromWindow = windowHeight - footerRect.top;
                const bottomPosition = footerBottomFromWindow + footerPadding;
                
                recentWidget.style.bottom = bottomPosition + 'px';
                if (budgetBtn) {
                    budgetBtn.style.bottom = (bottomPosition + widgetHeight + spacing) + 'px';
                }
            } else {
                // 푸터가 안 보일 때: 오른쪽 맨 아래
                recentWidget.style.bottom = defaultBottom + 'px';
                if (budgetBtn) {
                    budgetBtn.style.bottom = (defaultBottom + widgetHeight + spacing) + 'px';
                }
            }
        } else {
            // 푸터가 없을 때: 기본 위치
            recentWidget.style.bottom = defaultBottom + 'px';
            if (budgetBtn) {
                budgetBtn.style.bottom = (defaultBottom + widgetHeight + spacing) + 'px';
            }
        }
    };
    
    // 초기 위치 조정
    function initWidgetPositions() {
        setTimeout(window.adjustWidgetPositions, 500); // 위젯 로드 대기
    }
    
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initWidgetPositions);
    } else {
        initWidgetPositions();
    }
    
    // 스크롤 시 위치 조정 (throttle)
    let scrollTimeout;
    window.addEventListener('scroll', function() {
        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(window.adjustWidgetPositions, 10);
    }, { passive: true });
    
    // 리사이즈 시 위치 조정 (throttle)
    let resizeTimeout;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(window.adjustWidgetPositions, 100);
    });
})();

