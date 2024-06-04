# 1ister

내 취향이 담긴 아이템들을 리스트로 만들어 한번에 볼 수 있다면? 내가 사고 싶은거, 추천하고 싶은 맛집 리스트, 공유하고 싶은 꿀팁을 리스트로 저장하여 취향을 공유할 수 있는 플랫폼 입니다.

_App Download Link:_



## 기술 스택

>Frontend

* Flutter 3.16.5

* Tools Dart 3.2.3 

* DevTools 2.28.4



## 프로젝트 기간

2023년 12월 23일 ~ 


>Week1 ~ Week3

* 회원가입 & 로그인 페이지 
* DB 연결 & 서버 통신 테스트

>Week4 ~ Week6
* Splash & 메인 페이지 UI/UX

>Week7 ~ Week12
* 각 페이지 기능개발
* API 요청 최적화
* 서브 페이지 UI/UX

>Week13 ~ Week14
* UserPage 기능개발

>Week15
* UserPage 리팩토링
* Provider 구조화 

>Week16 ~ Week17
* BookmarkPage 기능개발

>Week18
* Provider 리팩토링

>Week19
* ListDetail 수정

>Week20
* Page Navigate 리팩토링
* setting Page 추가
* follow button 기능 개발

>Week21
* 회원가입 & 로그인 페이지 리팩토링

>Week22
* README.md 작성


### 프로젝트 파일 구조

```
.
├── README.md                   #readme
├── analysis_options.yaml
├── android
├── ios
├── assets                      #에셋 이미지
│   ├── fonts
│   ├── icons
│   └── images
├── build
├── devtools_options.yaml
├── lib                         # 소스코드
│   ├── main.dart               # 메인페이지
│   ├── model                   # 데이터 저장 모델
│   │   └── provider            # Provider
│   ├── page                    # 페이지
│   │   ├── book_mark
│   │   ├── edit
│   │   ├── home
│   │   ├── join
│   │   ├── login
│   │   ├── search
│   │   ├── splash
│   │   └── user
│   │       └── follow
│   ├── services                # API 호출 클래스
│   └── components               # 컴포넌트
│       ├── custom
│       ├── list
│       ├── navigator
│       └── pop_up
├── lister.iml
├── pubspec.lock
├── pubspec.yaml                # 사용하는 패키지
└── test

```



### 시연 영상

