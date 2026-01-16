// Session Timeout Mixin for Vue 3 CDN
const sessionTimeoutMixin = {
    data() {
        return {
            showSessionWarning: false,
            sessionTimeoutId: null,
            sessionWarningTimeoutId: null,
            timeoutMinutes: 3,
        };
    },
    methods: {
        startSessionTimer() {
            let self = this;
            self.clearSessionTimers();
            
            const timeoutDuration = self.timeoutMinutes * 60 * 1000;
            
            let warningDuration;
            if (self.timeoutMinutes <= 2) {
                warningDuration = 0;
            } else {
                warningDuration = timeoutDuration - (2 * 60 * 1000);
            }
            
            if (warningDuration > 0) {
                self.sessionWarningTimeoutId = setTimeout(() => {
                    self.showSessionWarning = true;
                }, warningDuration);
            }
            
            self.sessionTimeoutId = setTimeout(() => {
                self.autoLogout();
            }, timeoutDuration);
            
            console.log('세션 타이머 시작:', self.timeoutMinutes + '분');
        },
        
        resetSessionTimer() {
            let self = this;
			if (self.showSessionWarning) {
                return; // Exit early if modal is visible
            }
            if (self.sessionId && self.sessionId !== '') {
                self.showSessionWarning = false;
                self.startSessionTimer();
            }
        },
        
        clearSessionTimers() {
            let self = this;
            if (self.sessionTimeoutId) {
                clearTimeout(self.sessionTimeoutId);
                self.sessionTimeoutId = null;
            }
            if (self.sessionWarningTimeoutId) {
                clearTimeout(self.sessionWarningTimeoutId);
                self.sessionWarningTimeoutId = null;
            }
        },
        
        extendSession() {
            let self = this;
            self.resetSessionTimer();
			self.showSessionWarning = false;
            console.log('세션 연장됨');
        },
        
        autoLogout() {
            let self = this;
            console.log('자동 로그아웃');
            self.fnLogout();
        },
        
        setupActivityListeners() {
            let self = this;
            const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
            events.forEach(event => {
                document.addEventListener(event, self.resetSessionTimer);
            });
        },
        
        removeActivityListeners() {
            let self = this;
            const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
            events.forEach(event => {
                document.removeEventListener(event, self.resetSessionTimer);
            });
        }
    }
};