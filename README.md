# 필루미: 딥러닝 모델을 이용한 알약 사진 검색 서비스
#### 2023학년도 1학기 경희대학교 데이터분석캡스톤디자인 프로젝트 입니다.


## 💊 서비스 소개
약통이 사라져서 내가 가지고 있는 약이 소화제인지 소염제인지 헷갈렸던 적 있으신가요?  
인터넷에 검색을 해도 복잡하고 어려운 용어들로 구성된 알약 설명들이 읽기 힘드셨던 적은요?  

약물에 대한 전문 지식이 부족한 일반인들이 알약에 대해서 올바른 복약정보를 얻기는 쉽지 않습니다.  
따라서 저희는 일반인들이 약물오남용에 쉽게 노출되는 상황을 줄이기 위해 본 서비스를 기획하게 되었습니다.  

알약 앞/뒤 사진만으로 손쉽게 알약 복약정보를 검색해보세요!  
<img src="https://github.com/sparksub/pillumi-2023/assets/57142322/c03715ad-967b-48b0-b6c5-ddd3e3b14da1">


## 🎯 개발 목표
* 알약 장방향/타원형 200종을 대상으로 이미지 분류 모델 구축
* 스마트폰 카메라로 알약 앞, 뒷면을 촬영하여 쉬운 알약 복약 정보를 검색할 수 있는 모바일 앱 및 서버 개발


## ⚙️ 기술스택 & 개발환경

### 사용언어 및 프레임워크
+ 모바일 앱: Flutter (Dart)
+ Backend: Flask (Python)
+ 분석 모델: Pytorch (Python)


### 사용 데이터 셋 & API
+ [AIhub: 경구약제 이미지 데이터셋](https://www.aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=realm&dataSetSn=576)
+ [식품의약품안전처: 의약품 개요정보 (e약은요)](https://www.data.go.kr/data/15075057/openapi.do) 
+ [약학정보원: 복약정보 픽토그램](https://www.health.kr/mediCounsel/pictogram_print.asp)


## 👊 개발자소개
### 경희대학교 소프트웨어융합학과 박수빈
🏠 Homepage: https://dariasubin.me/  


