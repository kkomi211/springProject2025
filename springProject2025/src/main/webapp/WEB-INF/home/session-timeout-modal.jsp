<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div v-if="showSessionWarning" class="modal-overlay">
    <div class="modal-content">
        <h2>세션 만료 경고</h2>
        <p>비활동으로 인해 2분 후 세션이 만료됩니다.</p>
        <p>계속하시겠습니까?</p>
        <div style="display: flex; gap: 10px; justify-content: center; margin-top: 20px;">
            <button @click="extendSession">세션 연장</button>
            <button @click="fnLogout">로그아웃</button>
        </div>
    </div>
</div>