// 관리자 알림 공통 스크립트
const AdminNotifications = {
    data: {
        notificationCounts: {
            newInquiryCount: 0,
            newOrderCount: 0,
            newBoardReportCount: 0,
            totalCount: 0
        },
        showNotificationPanel: false,
        notificationInterval: null
    },

    // 알림 개수 조회
    fetchNotifications: function(vueInstance) {
        $.ajax({
            url: '/admin/notifications.dox',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.result === 'success') {
                    vueInstance.notificationCounts = {
                        newInquiryCount: response.newInquiryCount || 0,
                        newOrderCount: response.newOrderCount || 0,
                        newBoardReportCount: response.newBoardReportCount || 0,
                        totalCount: (response.newInquiryCount || 0) + 
                                   (response.newOrderCount || 0) + 
                                   (response.newBoardReportCount || 0)
                    };
                }
            },
            error: function(xhr, status, error) {
                console.error('알림 조회 오류:', error);
            }
        });
    },

    // 알림 패널 토글
    toggleNotificationPanel: function(vueInstance) {
        vueInstance.showNotificationPanel = !vueInstance.showNotificationPanel;
    },

    // 알림 읽음 처리 및 페이지 이동
    markAsReadAndGo: function(vueInstance, type, url) {
        $.ajax({
            url: '/admin/notifications/read.dox',
            type: 'POST',
            data: { type: type },
            dataType: 'json',
            success: function(response) {
                if (response.result === 'success') {
                    // 알림 개수 즉시 업데이트
                    AdminNotifications.fetchNotifications(vueInstance);
                    // 페이지 이동
                    window.location.href = url;
                }
            },
            error: function(xhr, status, error) {
                console.error('알림 읽음 처리 오류:', error);
                // 오류가 나도 페이지는 이동
                window.location.href = url;
            }
        });
    },

    // 초기화 (Vue 인스턴스에 알림 기능 추가)
    init: function(vueInstance) {
        // Vue 인스턴스가 아직 마운트되지 않았을 수 있으므로 안전하게 처리
        try {
            // 초기 알림 조회 (약간의 지연을 두어 Vue가 완전히 마운트된 후 실행)
            setTimeout(function() {
                AdminNotifications.fetchNotifications(vueInstance);
            }, 100);
            
            // 30초마다 알림 업데이트
            vueInstance.notificationInterval = setInterval(function() {
                AdminNotifications.fetchNotifications(vueInstance);
            }, 30000);
        } catch (e) {
            console.error('알림 초기화 오류:', e);
        }
    },
    
    // 메서드들을 반환 (각 페이지의 methods에 추가)
    getMethods: function() {
        return {
            fetchNotifications: function() {
                AdminNotifications.fetchNotifications(this);
            },
            toggleNotificationPanel: function() {
                AdminNotifications.toggleNotificationPanel(this);
            },
            markAsReadAndGo: function(type, url) {
                AdminNotifications.markAsReadAndGo(this, type, url);
            }
        };
    },

    // 정리 (beforeUnmount에서 호출)
    cleanup: function(vueInstance) {
        if (vueInstance.notificationInterval) {
            clearInterval(vueInstance.notificationInterval);
        }
    }
};

