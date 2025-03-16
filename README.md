# ProjectName: GoToMars

## 목차
1. Application 소개
2. 주요 기능
3. 기술 수택
4. 기술 설명
5. 트러블 슈팅

***

## Application 소개
GotoMars는 화성을 가자는 은유적 의미로 비트코인 및 알트코인, NFT의 현재 시세 등을 조회할 수 있는 어플리케이션입니다.

***

## 프로젝트 기간
2025.03.26 ~ 2025.03.11(6일간)

***

### 주요 기능
1. 코인 현재가 조회
<img src="https://github.com/user-attachments/assets/d33b3601-617f-4269-b6f0-a98078cb81e0" width="300" />

2. 가장 있기 있는 코인 탑 14
<img src="https://github.com/user-attachments/assets/a213ebee-cf8a-493c-b9ab-aa830daa2eb4" width="300" />
     
3. 코인 검색 기능
<img src="https://github.com/user-attachments/assets/04db8130-e375-4035-a25b-a1e162c47d80" width="300" />

4. 코인 상세 정보
<img src="https://github.com/user-attachments/assets/d4ba7778-7ca2-438f-9bfb-1bb920b1f344" width="300" />

5. 최근 경제 뉴스
<img src="https://github.com/user-attachments/assets/d93bb04a-dc95-4f7f-a31b-200cbefc351f" width="300" />   
<img src="https://github.com/user-attachments/assets/c1dd2ef1-eb59-43b2-b97c-78ad6630319d" width="300" />



***
### 기술 스택
- FrameWork - UIKit  
- Library - Alamofire, Kingfisher, SnapKit, RxSwift, RxDataSource, Realm, Toast
- API - Upbit, Coingetco

***
### 기술 설명
<b>[네트워크 단절]</b>  
- 네트워크 모니터를 싱글톤 패턴으로 구현하여, 네트워크 통신이 발생할 때마다, 네트워크 상태를 체크할 수 있도록 설계했습니다.
- 네트워크 단절시에는, 네트워크 재시도를 할 수 있도록 설계했으며, 재시도 하지않더라도 네트워크가 연결되면 기존 화면으로 돌아가도록 설계했습니다.

- <b>[네트워크 매니저]</b>  
- 네트워크 매니저는 싱글톤 패턴을 적용하여, 어느 곳에서든지 인스턴스 생성 없이 호출할 수 있도록 했습니다.
- Upbit 및 Coingecko는 동일한 네트워크 매니저를 사용할 수 있도록 제네릭 타입 및 라우터 패턴으로 구현했습니다.

<b>[Compositional Layout]]</b>  
- CollectioniView Compositional Layout과 RxDataSource를 사용하여 설계했습니다.
- 섹션마다 데이터 타입이 다르기 때문에, 섹션의 타입을 enum타입으로 구분하여 각 섹션에 맞는 데이터가 들어갈 수 있도록 설계했습니다.

<b>[화면전환]</b>  
- 화면전환시, 네트워크 통신으로 인해 뷰의 Drawing이 지연될 수 있기 때문에, activityIndicator를 추가하여 사용자에게 로딩중임을 안내했습니다.

<b>[UI]</b>  
- 가능한 모든 기기에 대응할 수 있도록 텍스트 및 고정된 크기를 가진 뷰를 제외하고는 비율로 계산했습니다.

***
### 트러블 슈팅





