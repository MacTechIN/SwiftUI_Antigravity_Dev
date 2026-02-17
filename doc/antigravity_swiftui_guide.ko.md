# Antigravity X SwiftUI: 마이크로 프로세스 개발 가이드 (초보자용)

이 문서는 초보 개발자가 **Google Antigravity(AI 어시스턴트)**를 활용하여 SwiftUI 앱을 A부터 Z까지 개발하는 과정을 아주 작은 단위(마이크로 프로세스)로 쪼개어 안내합니다. 각 단계별로 AI에게 줄 수 있는 최적의 프롬프트와 핵심 지식을 정리했습니다.

---

## 🧭 시작하기 전에: AI와 협업하는 태도
AI는 강력한 도구이지만, **정확한 로드맵**을 제시할 때 가장 좋은 결과물을 냅니다. 한 번에 "앱 만들어줘"라고 하기보다, 아래 단계에 따라 차근차근 질문하며 결과물을 검토하는 과정이 필수적입니다.

---

## 🛠️ 10단계 마이크로 개발 프로세스

### 1단계: 아이디어 구체화 및 요구사항 정의
**이유:** 무엇을 만들지 명확해야 AI가 헤매지 않습니다.
- **영어 프롬프트:** "Initialize a SwiftUI project idea: [Your Idea]. List the core features, possible screens, and user flow. Please output in Korean."
- **한글 프롬프트:** "[아이디어명] 프로젝트를 위한 필수 기능, 화면 구성, 그리고 사용자 흐름을 정리해줘."
- **중요 포인트:** 앱의 핵심 가치(MVP)에만 집중하세요.

### 2단계: 아키텍처 설계 (MVVM)
**이유:** 코드의 유지보수성을 위해 구조를 먼저 잡습니다.
- **영어 프롬프트:** "Design the project architecture using MVVM pattern with SwiftUI's Observation framework (iOS 17+). Recommend the folder structure and file list."
- **한글 프롬프트:** "SwiftUI의 Observation 프레임워크를 사용하는 MVVM 패턴으로 앱 구조를 설계해줘. 폴더 구조와 필요한 파일 리스트를 추천해줘."
- **용어 정리:** **MVVM** (Model: 데이터, View: UI, ViewModel: 로직).

### 3단계: 데이터 모델링 (Model)
**이유:** 정보가 어떤 형태로 저장될지 정의합니다.
- **영어 프롬프트:** "Create Swift data models (structs) for [Main Target]. Ensure they conform to Identifiable."
- **한글 프롬프트:** "[대상 데이터]를 위한 Swift 데이터 구조체(struct)를 만들어줘. Identifiable 프로토콜을 준수해야 해."
- **배경지식:** `Identifiable`은 리스트에서 각 데이터를 구분하기 위해 꼭 필요합니다.

### 4단계: 뷰 모델 구현 (ViewModel)
**이유:** UI에 전달할 데이터를 준비하고 가공하는 로직을 만듭니다.
- **영어 프롬프트:** "Implement a DashboardViewModel using @Observable macro. Include mock data and methods to update state."
- **한글 프롬프트:** "@Observable 매크로를 사용하여 DashboardViewModel을 만들어줘. 가상 데이터(Mock)와 상태를 업데이트하는 함수를 포함해줘."

### 5단계: 기본 UI 레이아웃 (View)
**이유:** 실제 눈에 보이는 화면을 그립니다.
- **영어 프롬프트:** "Build the [Screen Name] view using SwiftUI. Use modern, premium design with appropriate padding and spacing."
- **한글 프롬프트:** "SwiftUI를 이용해 [화면명]을 만들어줘. 현대적이고 프리미엄한 느낌이 나도록 간격과 패딩을 잘 조절해줘."
- **팁:** `VStack`, `HStack`, `ZStack` 삼총사로 거의 모든 레이아웃이 가능합니다.

### 6단계: 내비게이션 및 화면 전환
**이유:** 여러 화면을 하나로 연결합니다.
- **영어 프롬프트:** "Implement navigation using NavigationStack and NavigationLink to connect [View A] and [View B]."
- **한글 프롬프트:** "NavigationStack과 NavigationLink를 사용하여 [A화면]과 [B화면]을 연결하는 내비게이션 로직을 구현해줘."

### 7단계: 컴포넌트 리팩토링 및 재사용성
**이유:** 코드가 길어지면 읽기 힘드므로 작은 조각으로 나눕니다.
- **영어 프롬프트:** "Extract repetitive UI elements into separate small SwiftUI Views for reusability."
- **한글 프롬프트:** "반복되는 UI 요소들을 재사용할 수 있도록 별도의 작은 SwiftUI View 컴포넌트로 분리해줘."

### 8단계: 상태 관리 및 데이터 연동
**이유:** UI와 로직이 실제 데이터로 연결되게 합니다.
- **영어 프롬프트:** "Bind the View to the ViewModel using @State and ensure data updates reflect in the UI immediately."
- **한글 프롬프트:** "@State와 ViewModel을 바인딩해서 데이터가 바뀌었을 때 UI에 즉시 반영되도록 연결해줘."

### 9단계: 디버깅 및 트러블슈팅
**이유:** 에러를 해결하고 앱을 안정화합니다.
- **영어 프롬프트:** "I got a build error: [Copy Paste Error]. Analyze the cause and provide a fix."
- **한글 프롬프트:** "이런 빌드 에러가 발생했어: [에러 내용 복사]. 원인을 분석하고 해결 코드를 알려줘."
- **중요 포인트:** 에러 메시지 전체를 AI에게 주는 것이 가장 빠른 지름길입니다.

### 10단계: 최종 배포 및 문서화
**이유:** 완성된 코드를 저장하고 공유합니다.
- **영어 프롬프트:** "Write a comprehensive README.md and dev_history.md for this project. Also, guide me on how to push to GitHub."
- **한글 프롬프트:** "이 프로젝트를 위한 README.md와 개발 이력 문서를 작성해줘. 그리고 GitHub에 업로드하는 방법도 알려줘."

---

## 📚 초보자를 위한 핵심 배경지식 & 용어

### 필수 용어
1. **SwiftUI:** 애플의 최신 UI 프레임워크. "코드로 그림을 그리는 것"과 같습니다.
2. **SF Symbols:** 애플이 무료로 제공하는 수천 개의 프리미엄 아이콘 시스템. (`systemImage: "name"`)
3. **Observation (@Observable):** 데이터의 변화를 감시해서 화면을 자동으로 다시 그리게 하는 최신 기법.
4. **Xcode:** 아이폰 앱을 만들기 위해 사용하는 '공장' 같은 프로그램.
5. **Simulator:** Mac 화면에서 가상으로 아이폰을 띄워 테스트하는 도구.

### 중요한 포인트
- **Declarative (선언형):** "어떻게 그려라"가 아니라 "이건 이런 모양이다"라고 정의하는 방식입니다.
- **Modifier (수정자):** `.font(.title)` 처럼 점(.)을 찍고 속성을 바꾸는 SwiftUI의 핵심 문법입니다.
- **Order matters:** Modifier는 붙이는 순서에 따라 결과가 달라집니다. (예: 배경색을 칠하고 패딩을 줄지, 패딩을 주고 배경색을 칠할지)

---

## 🚀 Antigravity와 함께하는 팁
AI에게 질문할 때는 **"지금까지 완성된 전체 코드"**를 함께 보여주거나, **"열려 있는 파일"**을 기준으로 질문하면 훨씬 정확한 답변을 얻을 수 있습니다.

이제 이 가이드를 따라 당신의 첫 번째 아이폰 앱을 만들어보세요!
