<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
  <title>러너하우스 | 회사 소개</title>
  <meta name="description" content="러너하우스는 러닝 제품 쇼핑과 커뮤니티(게시판·크루 찾기·채팅·러닝코스 추천 챗봇)를 한 곳에서 즐길 수 있는 러닝 플랫폼입니다.">
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;700&display=swap" rel="stylesheet" />

  <style>
    :root{
      --primary:#0d6efd;
      --primary-600:#0b5ed7;
      --ink:#111827;
      --muted:#6b7280;
      --bg:#f7f8fb;
      --card:#ffffff;
      --ok:#16a34a;
      --warn:#f59e0b;
      --radius:16px;
      --shadow:0 10px 25px rgba(2,6,23,.08);
      --shadow-sm:0 6px 16px rgba(2,6,23,.06);
      --max:1080px;
    }
    *{box-sizing:border-box}
    html,body{margin:0;padding:0;font-family:Pretendard, system-ui, -apple-system, Segoe UI, Roboto, sans-serif;color:var(--ink);background:var(--bg);line-height:1.6}
    a{color:var(--primary);text-decoration:none}
    a:hover{color:var(--primary-600)}
    .container{max-width:var(--max);margin:0 auto;padding:0 20px}
    .btn{display:inline-flex;align-items:center;gap:8px;padding:12px 18px;border-radius:12px;background:var(--primary);color:#fff;font-weight:600;box-shadow:var(--shadow-sm);transition:.2s}
    .btn:hover{background:var(--primary-600);transform:translateY(-1px)}
    .btn.secondary{background:#fff;color:var(--primary);border:1px solid #e5e7eb}
    header.site{position:sticky;top:0;background:#fff;border-bottom:1px solid #eef0f4;z-index:50}
    header .wrap{display:flex;align-items:center;justify-content:space-between;height:64px}
    .brand{display:flex;align-items:center;gap:10px;font-weight:800}
    .brand .logo{width:28px;height:28px;border-radius:8px;background:linear-gradient(135deg,var(--primary),#60a5fa)}
    nav a{margin-left:16px;color:#374151}
    nav a:hover{color:var(--primary)}
    .hero{background:
      radial-gradient(1200px 400px at 50% -50%, rgba(13,110,253,.10), transparent 60%),
      linear-gradient(#fff,#f9fbff);
      border-bottom:1px solid #eef0f4}
    .hero .inner{display:grid;grid-template-columns:1.2fr .8fr;gap:24px;align-items:center;padding:56px 0}
    .hero h1{font-size:38px;line-height:1.2;margin:0 0 12px;font-weight:800}
    .hero p{color:var(--muted);margin:0 0 22px}
    .pill{display:inline-flex;gap:8px;align-items:center;padding:6px 10px;border-radius:999px;background:#eef4ff;color:#1d4ed8;font-weight:600;font-size:13px;border:1px solid #dbe7ff}
    .hero .card{background:var(--card);border-radius:var(--radius);padding:22px;box-shadow:var(--shadow)}
    .grid{display:grid;gap:20px}
    .grid.cols-3{grid-template-columns:repeat(3,1fr)}
    .grid.cols-4{grid-template-columns:repeat(4,1fr)}
    .section{padding:56px 0}
    .section h2{font-size:26px;margin:0 0 8px}
    .section .lead{color:var(--muted);margin:0 0 22px}
    .card{background:var(--card);border-radius:var(--radius);padding:20px;box-shadow:var(--shadow-sm);border:1px solid #eef0f4}
    .card h3{margin:6px 0 6px;font-size:18px}
    .kpis{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-top:12px}
    .kpi{background:#fff;border:1px solid #eef0f4;border-radius:14px;padding:16px;text-align:center}
    .kpi b{font-size:22px}
    .list{margin:10px 0 0;padding:0 0 0 18px;color:#4b5563}
    .badge{display:inline-flex;align-items:center;gap:8px;background:#f1f5f9;border:1px solid #e5e7eb;color:#334155;padding:6px 10px;border-radius:999px;font-size:13px}
    .feature{display:flex;gap:14px}
    .feature .icon{width:42px;height:42px;border-radius:12px;background:#eef4ff;color:#1d4ed8;display:flex;align-items:center;justify-content:center;font-weight:800}
    .cta{display:flex;gap:12px;flex-wrap:wrap;margin-top:10px}
    .foot{padding:36px 0;color:#6b7280;font-size:14px}
    .muted{color:var(--muted)}
    .divider{height:1px;background:#eef0f4;margin:28px 0}
    .chip{display:inline-flex;align-items:center;gap:8px;border:1px dashed #cbd5e1;background:#f8fafc;border-radius:999px;padding:6px 10px;font-size:12px;color:#334155}
    /* responsive */
    @media (max-width: 980px){
      .hero .inner{grid-template-columns:1fr}
      .grid.cols-3, .grid.cols-4{grid-template-columns:1fr 1fr}
      .kpis{grid-template-columns:1fr 1fr}
    }
    @media (max-width: 640px){
      .grid.cols-3, .grid.cols-4{grid-template-columns:1fr}
      .kpis{grid-template-columns:1fr 1fr}
      .hero h1{font-size:30px}
    }
  </style>
</head>
<body>
  <!-- 헤더 -->
  <header class="site">
    <div class="container wrap">
      <div class="brand">
        <div class="logo" aria-hidden="true"></div>
        <span>러너하우스</span>
      </div>
      <nav aria-label="주요 메뉴">
        <a href="/home.do">홈</a>
      </nav>
    </div>
  </header>

  <!-- 히어로 -->
  <section class="hero">
    <div class="container inner">
      <div>
        <span class="pill">러닝 × 커머스 × 커뮤니티</span>
        <h1>뛰는 순간을 더 좋게.<br/>러너를 위한 집, <span style="color:var(--primary)">러너하우스</span></h1>
        <p>러닝화·의류·가방·보호대 등 러닝 전용 제품을 한 곳에서 구매하고, 러너들과 소통하며
          <b>크루를 찾고</b>, <b>채팅</b>하고, <b>러닝코스 추천 챗봇</b>으로 루트를 받으세요.</p>
        
        <div style="margin-top:14px" class="muted">
          <span class="chip">무료 회원가입</span>
          <span class="chip">러닝 코스 추천 베타</span>
          <span class="chip">크루 매칭 지원</span>
        </div>
      </div>
      <div class="card" aria-label="플랫폼 요약">
        <div class="grid cols-3">
          <div class="kpi">
            <div class="muted">러닝 제품 카테고리</div>
            <b>120+</b>
          </div>
          <div class="kpi">
            <div class="muted">주간 게시글</div>
            <b>3,200+</b>
          </div>
          <div class="kpi">
            <div class="muted">코스 추천 데이터</div>
            <b>15K+</b>
          </div>
        </div>
        <div class="divider"></div>
        <div class="feature">
          <div class="icon">🏃‍♂️</div>
          <div>
            <b>러너 중심 설계</b>
            <div class="muted">초보부터 마라토너까지—신뢰 가능한 정보와 장비, 그리고 동료 러너들.</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 미션/비전/가치 -->
  <section class="section">
    <div class="container grid cols-3">
      <div class="card">
        <h3>우리의 미션</h3>
        <p class="muted">러너가 더 멀리, 더 건강하게 달릴 수 있도록 쇼핑·정보·사람을 연결합니다.</p>
        <ul class="list">
          <li>검증된 러닝 제품 큐레이션</li>
          <li>러닝 지식과 노하우의 커뮤니티화</li>
          <li>데이터 기반 코스 추천</li>
        </ul>
      </div>
      <div class="card">
        <h3>비전</h3>
        <p class="muted">아시아 최고의 러닝 허브—러너가 가장 먼저 찾는 플랫폼.</p>
        <ul class="list">
          <li>사용자 참여로 성장하는 생태계</li>
          <li>개인화 추천으로 장비 선택의 확신 제공</li>
          <li>러닝 문화 확산과 지역 연계</li>
        </ul>
      </div>
      <div class="card">
        <h3>핵심 가치</h3>
        <p class="muted">공정성 · 투명성 · 안전성 · 지속가능성</p>
        <ul class="list">
          <li>광고·협찬 표기와 리뷰 정책 투명 공개</li>
          <li>거래/대화 신고·차단 등 안전장치</li>
          <li>친환경 포장 확대, 반품 최소화 가이드</li>
        </ul>
      </div>
    </div>
  </section>

  <!-- 커뮤니티 기능 -->
  <section id="community" class="section" aria-labelledby="community-title">
    <div class="container">
      <h2 id="community-title">러너하우스 커뮤니티</h2>
      <p class="lead">러닝은 혼자보다 함께 할 때 더 오래 갑니다. 네 가지 축으로 연결합니다.</p>

      <div class="grid cols-4">
        <div class="card">
          <div class="feature">
            <div class="icon">📢</div>
            <div>
              <h3>게시판</h3>
              <p class="muted">장비 리뷰, 러닝팁, 대회 후기까지 주제별 게시판으로 빠르게 소통.</p>
              <span class="badge">주요 주제: 장비/훈련/영양/부상</span>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="feature">
            <div class="icon">🧭</div>
            <div>
              <h3>크루 찾기</h3>
              <p class="muted">지역·페이스·요일·성비까지 필터링해 나에게 맞는 러닝 크루 매칭.</p>
              <span class="badge">예: 서울 ⟶ 5:30 페이스 ⟶ 화/목</span>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="feature">
            <div class="icon">💬</div>
            <div>
              <h3>채팅하기</h3>
              <p class="muted">크루/그룹/1:1 채팅 지원. 공지 핀, 투표, 이미지 공유, 신고/차단 제공.</p>
              <span class="badge">실시간 STOMP WebSocket</span>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="feature">
            <div class="icon">🤖</div>
            <div>
              <h3>러닝코스 추천 챗봇</h3>
              <p class="muted">출발지·거리·고도·야간조명 조건에 맞춘 코스 추천과 보급 포인트 표시.</p>
              <span class="badge">개인화 베타</span>
            </div>
          </div>
        </div>
      </div>

      <div class="divider"></div>

      <div class="grid cols-3">
        <div class="card">
          <h3>안전 & 신뢰</h3>
          <ul class="list">
            <li>리뷰 신뢰도(사진/거리 인증 가산점)</li>
            <li>운영자 검수 배지 · 파트너 크루 인증</li>
            <li>커뮤니티 가이드라인/신고센터 운영</li>
          </ul>
        </div>
        <div class="card">
          <h3>개인화 추천</h3>
          <ul class="list">
            <li>발형/보폭/과거 구매 기반 장비 추천</li>
            <li>주간 거리·페이스 기반 훈련 코스 추천</li>
            <li>기온/미세먼지/조도 반영 코스 필터</li>
          </ul>
        </div>
        <div class="card">
          <h3>연동 & 확장</h3>
          <ul class="list">
            <li>러닝 앱(GPX) 업로드/다운로드</li>
            <li>크루 캘린더(대회/정기런) 구독</li>
            <li>오프라인 팝업·대회 부스 연계</li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <!-- 스토어 소개 -->
  <section class="section">
    <div class="container grid cols-3">
      <div class="card">
        <h3>러닝화</h3>
        <p class="muted">페이스별/용도별(인터벌·롱런·레이싱) 추천과 사이즈 핏 가이드 제공.</p>
      </div>
      <div class="card">
        <h3>의류/액세서리</h3>
        <p class="muted">계절·기온대별 레이어링, 방수/발수, 수납/반사 포인트 비교.</p>
      </div>
      <div class="card">
        <h3>보호/리커버리</h3>
        <p class="muted">테이핑·보호대·마사지건 등 부상 예방과 회복 솔루션 제안.</p>
      </div>
    </div>
  </section>

  <!-- 연락처 & 회사 정보 -->
  <section class="section">
    <div class="container grid cols-3">
      <div class="card">
        <h3>고객센터</h3>
        <p class="muted">운영시간: 평일 10:00–18:00 (점심 12:30–13:30)</p>
        <ul class="list">
          <li>이메일: support@runnershouse.kr</li>
          <li>카카오톡 채널: 러너하우스</li>
          <li>전화: 02-0000-0000</li>
        </ul>
      </div>
      <div class="card">
        <h3>사업자 정보</h3>
        <ul class="list">
          <li>상호: 러너하우스</li>
          <li>사업자등록번호: 000-00-00000</li>
          <li>주소: 서울특별시 ○○구 ○○로 00</li>
        </ul>
        <div class="muted" style="margin-top:8px;">전자상거래법 고지사항 및 개인정보 처리방침은 하단 링크 참조</div>
      </div>
      <div class="card">
        <h3>정책 바로가기</h3>
        <p class="muted">투명한 운영을 약속합니다.</p>
        <div class="cta">
          <a class="btn secondary" href="/home/terms.do">이용약관</a>
          <a class="btn secondary" href="/home/privacy.do">개인정보 처리방침</a>
        </div>
      </div>
    </div>
  </section>

  <!-- 푸터 -->
  <footer class="foot">
    <div class="container">
      © <span id="yy"></span> 러너하우스 · All rights reserved.
    </div>
  </footer>

  <script>
    // 연도 표시
    document.getElementById('yy').textContent = new Date().getFullYear();
    // 부드러운 스크롤(내부 링크)
    document.querySelectorAll('a[href^="#"]').forEach(a=>{
      a.addEventListener('click', e=>{
        const id = a.getAttribute('href');
        const tgt = document.querySelector(id);
        if(tgt){ e.preventDefault(); tgt.scrollIntoView({behavior:'smooth', block:'start'}); }
      });
    });
  </script>
</body>
</html>
