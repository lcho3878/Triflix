# 🌤️ Triflix

```

  TMDB OPEN API를 활용한 영화 및 TV시리즈 검색 어플리케이션

```
---

## 📷 ScreenShot
|Trending|Search|Detail|Favorite|
|:-:|:-:|:-:|:-:|
|<img src="https://github.com/user-attachments/assets/0f10be55-1784-4f4e-a98c-60d0c1dbe973" width="150"/>|<img src="https://github.com/user-attachments/assets/20aec81f-5392-4dff-b6c7-8a6b19aa2e7c" width="150"/>|<img src="https://github.com/user-attachments/assets/833f6f7c-efd9-4532-9080-b72536a3621e" width="150"/>|<img src="https://github.com/user-attachments/assets/9806b21f-1339-4486-84ce-737fce42430c" width="150"/>|

## ⛈️ Table of Contents<br>
1. [Description](#-description)
2. [Stacks](#%EF%B8%8F-stacks)
3. [Main Feature](#-main-feature)
4. [Project Structure](#%EF%B8%8F-project-structure)
5. [Developer](#-developer)

<br>

## 🌟 Description
TEAM : 이찬호, 김예진, 김생근

Period : 24.10.08 ~ 24.10.14

Netflix 클론코딩 iOS어플리케이션 <br>

</br>

💡**기능**

- UIKit
- Rxswift
- Alamofire
- Kingfisher
- Realm
- Snapkit

<br>

## 🛠️ Stacks


- 싱글톤 패턴
    - APIManager, PhotoManager등 여러 Manager를 싱글톤 패턴을 통하여 구현
    - 싱글톤 패턴 적용을 통한 리소스 및 의존성 관리
- API 네트워크 통신
    - URLRequestConvertible 프로토콜 및 Router 패턴을 통한 네트워크 통신 로직 추상화
- MVVM패턴
    - Rxswift를 활용한 ViewModel Input, Output, transform 패턴 적용
    - ViewModelProtocol을 통한 ViewModel 추상화
- Repository패턴
    - Repository 패턴을 적용하여 Realm 데이터 소스에 대한 접근 추상화
- UIKit
- Rxswift, MVVM
    - Rxswift를 활용한 ViewModel Input, Output, transform 패턴 적용
    - ViewModelProtocol을 통한 ViewModel 추상화
- Realm을 활용한 데이터 활용
- Kingfisher

<br>
</br>

## 📱 Main Feature
### 1) Trending Page 🌦️
<table align="leading">
  <tr>
    <td align="center">Trending Page</td>
    <td align="center">Trending Page</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/3fa15918-619d-4993-b946-46192092360e"></td>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/8e322be9-e6cf-41bb-8597-343f0308bd92"></td>
  </tr>
</table>
<br>

- Trending 화면
    - Trending API 활용
    - Movie & TV 미디어 관련 포스터 이미지, 장르 표시
    - Main Poster - Movie & TV 미디어 랜덤한 값 활용
    - 내가 찜한 리스트 버튼 클릭 시, 찜 목록에 저장
    - 셀 클릭 시, Detail 화면으로 전환

</br>

### 2) Search Page 🌧️
<table align="leading">
  <tr>
    <td align="center">Search Page</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/46926476-a65e-408f-8728-e1dd088cff81"></td>
  </tr>
</table>
<br>

- Search API 활용
- 영화 제목을 검색하여 Movie 미디어 정보 확인
- 실시간 검색 기능 제공
    - 입력 후, 1초간 검색어 입력이 없다면 통신 시작
- 검색어가 존재하지 않는 경우, Trending Movie 화면 표시
- 셀 클릭 시, Detail 화면으로 전환

</br>

### 3) Detail Page 🌥️
<table align="leading">
  <tr>
    <td align="center"> Detail Page </td>
    <td align="center"> Detail Page 찜하기</td>
    <td align="center"> Detail Page 찜 중복</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/2ba99565-89bf-474b-bf94-ea634da2f25e"></td>
   <td><img width="240" alt="image" src="https://github.com/user-attachments/assets/5e17b14d-5ca7-40de-aee0-b78e96c2fde0"></td>
    <td><img width="240" alt="image" src="https://github.com/user-attachments/assets/fdd0318f-6edf-4966-b692-af4f5a3fbe3b"></td>
  </tr>
</table>
<br>

- CastAPI, SimilarAPI 활용
- 선택된 미디어의 상세정보 확인
   - 포스터 이미지, 타이틀, 평점, 출연, 크리에이터
       - 출연, 크리에이터는 최대 3명까지 제공
- 선택된 미디어 타입(Movie & TV)에 맞는 비슷한 컨텐츠 목록 표시
- 저장 버튼 클릭 시, 찜 목록에 저장


</br>

### 4) Favorite Page ⛅️
<table align="leading">
  <tr>
    <td align="center"> Favorite Page</td>
    <td align="center"> 찜하기 취소</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/a48d1387-5f20-402a-9eb4-331ac5476401"></td>
   <td><img width="250" alt="image" src="https://github.com/user-attachments/assets/4501f929-2b84-40f0-8963-8ae8eabdd333"></td>
  </tr>
</table>
<br>

- 미디어 상세 화면 저장 버튼을 통해 저장한 미디어를 표시
- 좋아요 조회 화면은 네트워크 통신이 되지 않는 환경에서도 정상 작동
- Trailing Swipe 액션을 통한 취소 기능
- 셀 클릭 시, Detail 화면으로 전환



<br>


## 🏛️ Trouble shooting

 - Movie와 TVSeries 응답 모델의 일부가 달라서 발생한 문제
    - Movie는 title, TVSeires는 name이라는 데이터를 같은 기능을 위한 데이터였기 때문에 같은 모델을 사용하여 코드를 간소화 하고자 하였다.
    - 응답 모델에 Codingkey에 title과 name 케이스를 구성한 뒤, **init**(from decoder: Decoder) 생성자를 사용하여 디코딩 시 분기처리를 통해 응답결과의 이름이 다른 결과를 하나의 프로퍼티로 디코딩할 수 있도록 구현했다.
 - TrendingView, DetailView에서 보여지는 Media의 응답모델이 달라서 발생한 문제
    - Realm을 사용하여 찜한 미디어를 저장하기 위해 구성했던 Repository의 메서드가 DetailView의 응답모델을 기반으로 작성되었기 때문에, 이를 수정하기 위해서 많은 코드의 수정이 필요해보였다.
    - Realm DB에 저장하기 위해 필요한 프로퍼티를 가진 MediaType 프로토콜을 생성하여 TrendingView, DetailView의 응답모델에 적용 및 Repository의 메서드가 MediaType을 인자로 가지도록 수정하여 해결하였다.

## 👨‍👩‍👧‍👦 Developer

## 👥 참여 인원
  |<img src="https://avatars.githubusercontent.com/u/74814587?v=4)" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/161591832?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/100755761?v=4" width="150" height="150"/>|
  |:-:|:-:|:-:|
  |ChanHo<br/>[@lcho3878](https://github.com/lcho3878)|YeJin<br/>[@yeggrrr](https://github.com/yeggrrr)|Saengle<br/>[@Saengle](https://github.com/saengle)|

### 📚 팀 회고 
> - 팀원들 모두 이번 협업 주제와 비슷한 프로젝트를 해본 경험은 있었지만, 터미널과 깃허브를 통한 협업을 진행해본 경험은 없었기에 협업에 중점을 두고 프로젝트를 진행해보았습니다.
> - 기간이 짧고 비교적 규모가 작은 프로젝트 인점을 감안하여, Github flow 전략을 채택하였고 기능별 브랜치를 merge하는 경우에는 팀원끼리 코드 리뷰를 하며 conflict를 최소화 하였습니다.
> - 짧은 기간이었지만, terminal을 활용하여 git 협업하는 방법에 익숙해지는 시간이었습니다.
>   
### 📚 개인 회고
> -  **이찬호** 
>     - 초기에 필요한 부분들을 잘 계획하고 프로젝트를 시작했다고 생각했으나, 기획에 시간을 많이 들이는 것이 필요하다고 느꼈다. extension이나 캡슐화를 통해서 기능들을 공유하기 위해서는 겹치는 기능과 그렇지 않은 기능에 대한 소통이 충분히 필요함을 느꼈다.
>     - 코드의 구조와 기능적인 부분에서는 조금 아쉬움이 남더라도, 협업을 하는 부분에서 큰 문제없이 1주일 동안 잘 진행된 것 같아서 좋은 경험이었다.
> -  **김예진** 
>     - 협업 프로젝트를 진행하면서 후반부에 갈수록 초기에 구체적인 계획의 중요성을 느꼈습니다.
초반에 생각하지 못한 기능들을 나중에 추가하려다 보니, 바꿔야하는 로직들이 많았던 것 같습니다.
초기에 코드, 커밋, 브랜치 컨벤션에 대한 회의를 하고 프로젝트를 진행했지만, 코드적인 컨벤션에 대한 충분한 소통이 부족했어서 전체적인 코드 구성이 통일감이 필요해 보였습니다.
마음 맞는 팀원들과 협업 프로젝트를 진행하면서 한 주 동안 깃 협업에 대한 이해도나 협업에 필요한 요소들을 배울 수 있었던 시간이었던 것 같습니다. 좋은 팀원들을 만나 즐거웠습니다. :D
> -  **김생근** 
>      - 초기 기획, 설계시에 구체적으로 설정이 될  수록 실제 개발단계에서의 수정이 줄어 들 것 같음을 느꼈다. 추후에는 설계단계에서 조금 더 구체적으로 계획을 세우고 진행하는것이 더 좋을 것 같다.
>      - 코딩 컨벤션을 어느정도 정하고 진행을 했음에도 불구하고, 나를 포함한 다른 사람들의 코드는 그 사람의 개성이 두드러짐이 느껴졌고, 갑자기 나의 스타일을 컨벤션에 맞추는 것이 어려웠습니다.
>      - 실력 좋은 팀원들과 별다른 이견 없이 시원시원하게 진행이 되어서 큰 불편함 없이 프로젝트가 진행이 되어서 좋은 경험이었습니다.
   
  
