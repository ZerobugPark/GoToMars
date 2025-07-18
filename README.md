# 🪐 실시간 코인 & 뉴스 플랫폼 GoToMars
![ReadMeTitle](https://github.com/user-attachments/assets/ff726042-1c98-436a-8258-635fe9a541c7)
<br><br><br>


## 프로젝트 소개
**GoToMars**는 화성을 향해 날아간다는 은유처럼, 비트코인·알트코인·NFT의 실시간 시세와 최신 뉴스를 빠르게 조회할 수 있는 애플리케이션입니다. 
좋아요, 필터, 네트워크 자동 갱신 등 다양한 기능을 통해 편리한 사용자 경험을 제공합니다.

#### 주요 기능
- 실시간 코인 / NFT 조회
- 코인 검색 및 상세보기
- 필터 기능 (현재가 / 전일대비 / 거래대금)
- 최신 뉴스 소식
- 좋아요 기능 (관심 코인 저장)
- 네트워크 단절 대응

<br><br>
## 프로젝트 정보
기획 및 개발: 2025.03.06 ~ 2025.03.11(6일간) 

### 기술 스택
- **FrameWork** - UIKit, Network, WebKit  
- **Library** - RxSwift, RxDataSource, RxGesture, DGCharts, Realm, SnapKit, KingFisher, Toast<br>
- **Architecture** - MVVM


### 기술 설명
- **최소 지원 iOS 버전**: iOS 16.0  
- **Local DB**: Realm
- **API(Rest API)**: Upbit / Coingecko / Naver


<br><br>
## 기술적 특징

### 네트워크 매니저
- 싱글톤 패턴을 적용하여 어디서든 인스턴스 생성 없이 호출할 수 있도록 구현했습니다.
- Upbit 및 Coingecko API 모두 동일한 네트워크 매니저를 사용할 수 있도록, 제네릭 타입과 라우터 패턴을 적용했습니다.

### 네트워크 단절 대응
- 앱 실행 시 AppDelegate에서 네트워크 모니터링을 시작하여, 앱 전반의 네트워크 상태를 실시간으로 감지합니다.
- NetworkMonitor는 싱글톤 패턴으로 구현되어, 각 네트워크 통신이 진행되기 전에 우선 연결 상태를 확인합니다.
- 네트워크 연결이 끊긴 상태에서는 Pop-up을 통해 사용자에게 즉시 안내하며, 5초마다 자동으로 연결 상태를 재확인합니다.
- 연결 타입(Wi-Fi / Cellular / Ethernet)도 감지할 수 있도록 NWPathMonitor 기반으로 설계되었습니다.

### Compositional Layout
- CollectionView Compositional Layout과 RxDataSource를 활용하여 설계했습니다.
- 섹션마다 데이터 타입이 다르기 때문에, enum 타입으로 섹션을 구분하여 각 섹션에 맞는 데이터가 들어가도록 처리했습니다.

### 화면 전환
- 화면 전환 시, 네트워크 통신으로 인해 뷰의 Drawing이 지연될 수 있어, ActivityIndicator를 추가하여 로딩 상태를 사용자에게 명확히 안내했습니다.

### UI
- 다양한 기기 크기에 대응할 수 있도록, 텍스트 및 고정 크기 뷰를 제외한 대부분의 레이아웃을 비율 기반으로 계산했습니다.

<br><br>
## 페이지별 기능

### [실시간 코인 조회]

- 실시간 코인 시세 조회
  - 앱 실행 시 실시간 코인 시세를 조회할 수 있습니다.
  - 시세 정보는 5초마다 자동 업데이트됩니다.
- 필터 기능
  - 기본적으로 거래대금이 많은 순으로 정렬됩니다.
  - 필터는 현재가, 전일대비, 거래대금 기준으로 선택할 수 있습니다.

| 실시간 코인 조회 |
|:--------:|
| <img src="https://github.com/user-attachments/assets/b5c1c17a-7c4d-483b-bf48-58ace8bf3ed5" width="350"/> | 

<br><br>

### [코인 검색 및 상세보기]

- 원하는 코인을 검색하고 상세 정보를 확인할 수 있습니다.
- 코인 차트는 최근 1주일 데이터를 기준으로 표시됩니다.
- 동일한 검색어가 반복 입력될 경우, distinctUntilChanged() 오퍼레이터를 사용해 불필요한 네트워크 호출을 방지합니다.
- 좋아요 기능을 통해 관심 있는 코인을 저장할 수 있습니다.


| 코인 검색 및 상세보기 |
|:--------:|
| <img src="https://github.com/user-attachments/assets/39910a6d-291f-4893-b853-e26bd77a339d" width="350"/> |



<br><br>

### [최신 뉴스]

- 경제, 주식, 코인 관련 최신 뉴스를 1분마다 자동으로 갱신합니다.
- 뉴스를 선택하면 WebKit 기반의 뷰를 통해 상세 기사를 바로 확인할 수 있습니다.

| 최신 뉴스 |
|:--------:|
| <img src="https://github.com/user-attachments/assets/1a9ce7a3-236d-4396-a7bf-f1f378bfb9ed" width="350"/> |



<br><br>

### [네트워크 단절 대응]

- 네트워크 연결이 원활하지 않을 경우, 추가 통신이 중단됩니다.
- Pop-up 형식의 안내 뷰가 표시되며, 네트워크 상태는 5초마다 자동으로 갱신됩니다.
- 다시 시도하기 버튼을 누르면, 즉시 네트워크 상태를 갱신합니다
 
| 네트워크 단절 |
|:--------:|
| <img src="https://github.com/user-attachments/assets/4402d7be-6e9b-4f44-94d4-b93f83191303" width="350"/> |


<br><br>


***





