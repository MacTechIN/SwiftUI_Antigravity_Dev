# 안티그래비티 iOS 프로젝트: 코드 구조 및 SwiftUI 앱 개발 A to Z 분석

이 문서는 "안티그래비티" 프로젝트의 전체 코드 구조와 SwiftUI를 이용한 현대적인 앱 개발 프로세스를 입문자부터 실무자까지 이해할 수 있도록 심층 분석하여 기록한 가이드입니다.

---

## 1. 프로젝트 아키텍처: MVVM + Observation

본 프로젝트는 SwiftUI의 최신 표준인 **MVVM (Model-View-ViewModel)** 패턴과 **Observation 프레임워크**를 채택하고 있습니다.

### 🏗️ 계층별 역할
- **Model (`AppTask`, `DashboardStat`...)**: 순수한 데이터 구조체입니다. 데이터의 형태를 정의하며 로직을 직접 포함하지 않습니다.
- **ViewModel (`DashboardViewModel`)**: 앱의 '두뇌' 역할을 합니다. 데이터를 가공하고, 비즈니스 로직(작업 업데이트, 통계 계산 등)을 수행하며, View가 관찰할 수 있는 상태를 유지합니다.
- **View (`MainDashboardView`, `TaskListView`...)**: 사용자에게 보이는 UI입니다. ViewModel의 상태를 관찰하여 화면을 그리고, 사용자의 입력을 ViewModel로 전달합니다.

### 💡 핵심 기술: @Observable 매크로
iOS 17부터 도입된 최신 기술로, 이전의 `ObservableObject`보다 훨씬 간결하고 성능이 좋습니다.
- **특징:** 데이터가 바뀔 때 화면의 필요한 부분만 똑똑하게 다시 그립니다.
- **코드 연결:** `DashboardViewModel` 클래스 상단에 `@Observable`을 붙임으로써, View가 이 객체의 프로퍼티 변화를 자동으로 감지하게 됩니다.

---

## 2. 앱 개발 프로세스 A to Z (프로젝트 흐름)

### A. 프로젝트 시작 및 진입점
- **`myFirstAntigravityAppApp.swift`**: 앱의 시작점입니다. `@main` 어노테이션이 붙어 있으며, 앱의 생명주기를 관리하고 첫 화면을 결정합니다.
- **`ContentView.swift`**: 앱 실행 시 가장 먼저 사용자에게 노출되는 '게이트웨이' 뷰입니다. 여기서는 웰컴 애니메이션과 대시보드 간의 초기 상태 전환을 관리합니다.

### B. 데이터 모델링 및 ViewModel 구성
- 데이터를 담을 그릇(`struct AppTask`)을 만듭니다.
- `DashboardViewModel`에서 가상 데이터를 생성(`loadData`)하고, 이를 관리하는 함수(`updateTaskStatus`)를 작성합니다.

### C. UI 컴포넌트 구현 (SwiftUI View)
- **선언적 UI:** "어떻게(How)"가 아닌 "무엇을(What)" 보여줄지 코드로 작성합니다.
- **컴포넌트화:** 반복되는 카드나 리스트 아이템을 `DashboardCard`, `TaskRow`와 같이 별도 구조체로 분리하여 재사용성과 가독성을 높였습니다.

### D. 화면 전환 및 내비게이션
- **`NavigationStack`**: 화면 간의 논리적 흐름을 정의합니다.
- **`NavigationLink`**: 버튼처럼 클릭했을 때 다른 페이지로 '푸시'하는 역할을 하며, 이때 필요한 데이터(ViewModel이나 특정 ID)를 다음 화면으로 넘겨줍니다.

---

## 3. 주요 파일 및 코드 상세 설명

### 📂 주요 파일 구조
- `DashboardViewModel.swift`: 데이터 로직의 핵심 (상태 관리, 통계 계산).
- `MainDashboardView.swift`: 메인 화면 (전체적인 대시보드 레이아웃).
- `TaskListView.swift`: 필터링된 작업 목록 표시.
- `TaskDetailView.swift`: 작업 상세 확인 및 상태 변경.

### 🔗 코드 간의 연결 고리 (Data Flow)
1. **대시보드 클릭:** `MainDashboardView`에서 특정 카드를 누르면 `NavigationLink`를 통해 `TaskListView`로 이동하며 필터 조건(`filterStatus`)을 전달합니다.
2. **리스트 필터링:** `TaskListView`는 전달받은 필터 조건에 따라 `viewModel.appTasks`에서 필요한 것만 골라 리스트를 만듭니다.
3. **상태 변경:** `TaskDetailView`에서 사용자가 상태를 변경하면, `Binding`을 통해 `DashboardViewModel.updateTaskStatus`가 호출됩니다.
4. **실시간 반영:** ViewModel 내의 데이터가 바뀌면, 이를 공유하고 있는 대시보드 화면의 숫자(통계)가 즉시 업데이트됩니다.

---

## 4. SwiftUI 입문을 위한 기초 배경지식

앱 개발을 지속하기 위해 반드시 알아야 할 개념들입니다.

| 개념 | 설명 | 우리 프로젝트에서의 역할 |
| :--- | :--- | :--- |
| **@State** | 뷰 내부의 로컬 상태값 관리 | 대시보드에서 ViewModel 객체를 소유할 때 사용 |
| **Binding** | 데이터를 양방향으로 연결 | 상세 페이지의 Picker가 ViewModel의 값을 직접 바꿀 때 사용 |
| **Environment** | 범용적인 환경 변수 (화면 닫기 등) | `@Environment(\.dismiss)`를 통해 현재 화면을 닫음 |
| **Closure** | 이름 없는 함수 (코드 블록) | 버튼 클릭 시 실행할 동작을 정의할 때 필수 |
| **Layout Priority** | 뷰의 크기 결정 규칙 | `Spacer()`, `padding()`, `LazyVGrid`를 이용한 반응형 레이아웃 구성 |

---

## 5. 결론 및 향후 발전 방향

현재 프로젝트는 **현대적인 SwiftUI 개발 표준**을 충실히 따르고 있습니다. 이 구조에서 더 나아가려면 다음과 같은 고도화가 가능합니다.
1. **Persistent Storage:** 현재는 메모리 기반 가상 데이터이지만, `SwiftData`나 `CoreData`를 사용하여 앱 종료 후에도 데이터가 유지되도록 할 수 있습니다.
2. **Network Layer:** 외부 API와 연동하여 실제 서버의 정보를 가져오도록 확장할 수 있습니다.
3. **Advanced Animation:** `matchedGeometryEffect` 등을 사용하여 더욱 화려한 화면 전환 애니메이션을 추가할 수 있습니다.

본 가이드가 안티그래비티 프로젝트의 코드와 흐름을 완벽히 이해하는 데 도움이 되길 바랍니다.
