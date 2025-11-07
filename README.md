# 3team 프로젝트

<div align="center">
  <img  src="media/KakaoTalk_20251107_114123012.gif" alt="GwasilZero 시연 영상" width="1200" height="500">
</div>

# ⏳ 3team 개요
#### 🎠 프로젝트명 : RUNNERS' HOUSE
#### 🎐 프로젝트 목표: 러닝을 사랑하는 사람들을 위한 커뮤니티 & 쇼핑 플랫폼 구축
#### 🎃 팀명 : 3team 
#### 🕶 조원 : 정은성(팀장), 경환, 아린, 지훈, 반석

<br>

# ✨ 프로젝트 소개
**RUNNERS HOUSE**는 단순한 러닝 용품 쇼핑몰이 아닙니다.  
이곳은 러닝을 사랑하는 모든 사람들이 모여 **소통하고, 성장하며, 동기부여를 주고받는 공간**입니다.  

누구나 달릴 수 있지만, **함께 달릴 때 더 멀리 갈 수 있습니다.**  
RUNNERS HOUSE는 러너들이 자신의 이야기를 나누고, 제품을 구매하고,  
크루를 결성하며, 전문가의 조언을 들을 수 있는 진정한 **러너들의 집**을 목표로 합니다. 🏠👟 

# ⏳ 개발 기간
| 기간 | 내용 |
|------|------|
|2025년 10월 23일 ~ 2025년 10월 27일 | 기획안 및  ![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)  ![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white) 문서화작업|
|2025년 10월 28일 ~ 2025년 11월 13일 | 
## 🖥️ **기술 스택**
| 구분 | 기술 |
|------|------|
| **Backend** | ![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white), ![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E) |
| **Frontend** | ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white), ![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E), |
| **Database** | ![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white) |
| **Tools** | ![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white), ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white), ![IntelliJ IDEA](https://img.shields.io/badge/IntelliJIDEA-000000.svg?style=for-the-badge&logo=intellij-idea&logoColor=white), ![VS Code Insiders](https://img.shields.io/badge/VS%20Code%20Insiders-35b393.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) |
| **Collaboration** | ![Notion](https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white), ![KakaoTalk](https://img.shields.io/badge/kakaotalk-ffcd00.svg?style=for-the-badge&logo=kakaotalk&logoColor=000000), ![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)|













<h4>파일 흐름 간단 구조</h4>
<pre>
home.jsp
	├─login.jsp
		├─idPwdSearch.jsp
	├─signup.jsp
		├─jusoPopup.jsp
	├─mypage
		├─information.jsp(mypage default screen)
			├─information-change.jsp
		├─my-inquiry.jsp
			├─my-inquiry-detail.jsp
		├─orders.jsp
		├─review.jsp
			├─review-view.jsp
			├─review-write.jsp
		├─refund-return.jsp
	├─community
		├─board.jsp(community default screen)
			├─board-edit.jsp
			├─board-post.jsp
			├─board-view.jsp
		├─rally-board.jsp
		├─crew.jsp
			├─crew-post.jsp
		├─chat.jsp
			├─chatroom-view.jsp
	├─product.jsp
		├─product-info.jsp
			├─productInquiry-add.jsp
	├─cart.jsp	
		├─paybefore.jsp
			├─payafter.jsp
	├─policy
		├─about.jsp
		├─privacy-policy.jsp
		├─terms.jsp
</pre>
<pre>
admin
	├─admin-main.jsp(admin default screen)
   	├─banner.jsp
   	├─inquiry.jsp
    	├─inquiry-view.jsp
   	├─refund-return.jsp
  	├─product.jsp
     	├─product-info.jsp
      	├─product-add.jsp
   	├─orders.jsp
   	├─board-report.jsp
      	├─board-report-view.jsp
   	├─user-list.jsp
      	├─user-list-view.jsp
</pre>



