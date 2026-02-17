# 📜 iOS 프로젝트 개발 이력 (dev_history.md)

이 문서는 실시간 어시스트 모드에서 진행된 모든 작업의 **[전체 결과 텍스트]**와 **[요약]**을 기록합니다.

---

## 🗓️ 2026-02-17 (월)

### 🕙 15:11 - [기능 구현] 아이콘 애니메이션 및 화면 전환 추가

#### [전체 결과 텍스트: MainDashboardView.swift]

```swift
import SwiftUI

struct MainDashboardView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("대시보드")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("안티그래비티 프로젝트의 진행 상황입니다.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    DashboardCard(title: "전체 작업", value: "12", icon: "checklist", color: .blue)
                    DashboardCard(title: "진행 중", value: "3", icon: "clock.fill", color: .orange)
                    DashboardCard(title: "완료", value: "9", icon: "checkmark.circle.fill", color: .green)
                    DashboardCard(title: "이력 로그", value: "4", icon: "doc.text.fill", color: .purple)
                }
                
                Text("최근 활동")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                ForEach(0..<3) { _ in
                    HStack {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("GitHub 푸시 완료")
                                .font(.headline)
                            Text("V0.1.0 초기 설정 업데이트")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("방금 전")
                            .font(.caption2)
                            .foregroundColor(.tertiaryLabel)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Main")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DashboardCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}
```

#### [전체 결과 텍스트: ContentView.swift]

```swift
import SwiftUI

struct ContentView: View {
    @State private var isWaving = false
    @State private var navigateToDashboard = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Image(systemName: "hand.wave.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(isWaving ? 20 : -20))
                        .animation(
                            .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                            value: isWaving
                        )
                    
                    VStack(spacing: 12) {
                        Text("반가워요, Sam!")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        
                        Text("우리의 첫 번째 항해를 시작할 준비가 되셨나요?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToDashboard = true
                    }) {
                        HStack {
                            Text("시작하기")
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }
                .padding()
            }
            .onAppear {
                isWaving = true
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                MainDashboardView()
            }
        }
    }
}
```

#### [요약: Phase 2 구현]

- **작업 내용:** Phase 2 애니메이션 및 화면 전환 기능 구현 완료.
- **주요 변경점:**
  - `hand.wave.fill` 아이콘에 `rotationEffect` 애니메이션 적용.
  - `NavigationStack` 및 `navigationDestination`을 이용해 `MainDashboardView`로의 화면 전환 구현.
  - 대시보드 화면(`MainDashboardView.swift`) 신규 디자인 및 카드 레이아웃 적용.
- **결과:** 정적인 UI에서 동적인 UX로 업그레이드되었으며, GitHub 푸시 완료.

### 🕙 15:03 - [기록 방식 업데이트] 전체 결과 텍스트 + 요약 도입

#### [전체 결과 텍스트: ContentView.swift v1]

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 배경색 설정
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 아이콘
                Image(systemName: "hand.wave.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                // 메인 타이틀
                Text("반가워요, 대표님!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // 서브 타이틀
                Text("아론과 함께 만드는 첫 번째 앱입니다.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // 버튼
                Button(action: {
                    print("버튼이 눌렸습니다!")
                }) {
                    Text("시작하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
```

#### [요약: Git 초기화]

- **작업 내용:** 로컬 Git 저장소 초기화 및 원격 저장소 푸시 성공.
- **원격 저장소:** `https://github.com/MacTechIN/SwiftUI_Antigravity_Dev.git`
- **결과:** 첫 번째 버전(Xcode 설정 및 기본 UI)이 GitHub로 성공적으로 업로드됨.

---

### 🕙 15:08 - [문서화] README.md 작성 및 저자 정보 추가

#### [전체 결과 텍스트: README.md]

```markdown
# MyFirstAntigravityApp 🚀

AI 어시스턴트 '아론(Aaron)'과 함께 만드는 첫 번째 네이티브 iOS 애플리케이션 프로젝트입니다.

## 🎯 프로젝트 목적
이 프로젝트의 주요 목적은 AI 코딩 어시스턴트와 개발자가 실시간으로 협업하여 앱 스토어 배포까지 이르는 전체 개발 프로세스를 검증하고 학습하는 것입니다. SwiftUI를 기반으로 현대적인 iOS 앱 개발 방법론을 따릅니다.

## 👤 저자 (Author)
- **Sam LEE** ([hotnewton@kore.ac.kr](mailto:hotnewton@kore.ac.kr))

## 📊 진행 상황 및 버전별 설명

### v0.1.0 - 초기 프로젝트 설정 및 기본 UI 구현
- **상태:** 완료 ✅
- **주요 내용:**
    - Xcode 프로젝트 초기 설정 (`MyFirstAntigravityApp`)
    - `ContentView.swift`를 이용한 첫 화면 구성 (SwiftUI)
    - 실시간 개발 이력 시스템(`dev_history.md`) 도입
    - Git 저장소 초기화 및 첫 번째 원격 푸시 완료

## 🛠️ 기술 스택
- **Language:** Swift
- **UI Framework:** SwiftUI
- **Minimum iOS Version:** 17.0+
- **Version Control:** Git

## 📝 개발 이력 기록
상세한 개발 과정은 [doc/dev_history.md](doc/dev_history.md)에서 확인하실 수 있습니다.
```

#### [요약: README 작성]

- **작업 내용:** 프로젝트 목적, 진행 상황, 저자 정보(Sam LEE)를 포함한 `README.md` 파일 생성 및 Git 푸시.
- **주요 내용:** 대표님(Sam LEE)의 이메일 정보와 현 프로젝트의 V0.1.0 단계 명시.
- **결과:** GitHub 원격 저장소 메인 페이지에서 프로젝트 정보를 한눈에 확인할 수 있게 됨.

### 🕙 14:38 - [이전 단계 요약] 첫 번째 UI 구현 및 디버깅

- **요약:** `ContentView.swift` 수정 가이드 및 `Cannot find ContentView` 오류 해결.
- **결과:** 파란색 배경, 인사말, 손 흔드는 아이콘, '시작하기' 버튼이 포함된 첫 UI 구현 완료.

### 🕙 14:34 - [이전 단계 요약] Xcode 프로젝트 생성 및 초기 설정

- **요약:** `MyFirstAntigravityApp` 프로젝트 생성 가이드 (No Testing System).
- **결과:** `/Users/sl/Workspace/05.swiftui/AntigravityWorking` 경로에 프로젝트 생성 완료.

### 🕙 14:05 - [이전 단계 요약] 전문가 페르소나 설정
- **요약:** 10년 차 iOS 개발 전문가 '아론' 페르소나 설정 및 3단계 워크플로우 승인.
- **결과:** 프로젝트 기본 환경(`task.md`, `implementation_plan.md`) 구축 완료.

---

### 🕙 15:15 - [버그 수정] MainDashboardView 컴파일 에러 분석 및 해결

#### 📝 에러 종류 및 발생 원인
1. **View 프로토콜 준수 오류 (Invalid Conformance)**
   - **에러 종류:** 컴파일 에러 (Protocol Conformance Error)
   - **발생 원인:** `struct MainDashboardView: some View`와 같이 정의됨. `some View`는 반환 타입에 사용되는 키워드이며, 구조체 선언부에는 프로토콜 명칭인 `View`만 와야 합니다.
   - **해결책:** `struct MainDashboardView: View`로 수정하여 프로토콜 준수를 명확히 함.

2. **표준 외 컬러 상수 참조 (Invalid Color Reference)**
   - **에러 종류:** 심볼 참조 에러 (Reference Error)
   - **발생 원인:** `.foregroundColor(.tertiaryLabel)`을 사용함. `.tertiaryLabel`은 UIKit의 시스템 컬러이며 SwiftUI `Color` 타입의 정적 속성으로 직접 제공되지 않음.
   - **해결책:** 표준 SwiftUI 컬러인 `.secondary`로 변경하여 호환성 확보.

#### 💡 개발자가 알아야 할 사항 (Tips)
- **SwiftUI vs UIKit 명칭 구분:** UIKit의 `UIColor.tertiaryLabel`과 SwiftUI의 `Color.secondary` 등 명칭 체계가 다르므로 주의가 필요합니다.
- **Opaque Type의 위치:** `some View`는 프로퍼티나 함수의 리턴 타입 위치에만 사용해야 합니다.

---

### 🕙 15:50 - [아키텍처 개선] ObservableObject에서 @Observable 매크로로 전환

#### 📝 문제 상황 및 해결책
- **문제:** `DashboardViewModel`에 `ObservableObject` 프로토콜을 적용했을 때 `does not conform` 빌드 에러 발생.
- **원인:** iOS 17+ 환경에서는 기존의 `ObservableObject` 대신 더 현대적이고 성능이 우수한 `Observation` 프레임워크 사용이 권장됩니다.
- **해결:**
  - `DashboardViewModel`에 `@Observable` 매크로 도입.
  - `MainDashboardView`에서 `@StateObject` 대신 `@State`를 사용하여 데이터 관찰.

#### 💡 변경된 코드 스니펫

```swift
// DashboardViewModel.swift
import Observation

@Observable
class DashboardViewModel {
    var stats: [DashboardStat] = []
    // @Published 키워드 불필요
}

// MainDashboardView.swift
struct MainDashboardView: View {
    @State private var viewModel = DashboardViewModel() // @StateObject -> @State
}
```

#### [요약: 아키텍처 전환]
- **작업 내용:** 최신 SwiftUI 표준인 Observation 프레임워크 적용 완료.
- **결과:** 빌드 에러 해결 및 데이터 흐름의 효율성 증대.

### 🕙 15:52 - [빌드 오류 수정] Color.tertiaryLabel 참조 오류 해결

- **요약:** `MainDashboardView.swift`에서 `Color.tertiaryLabel`을 사용하는 코드가 빌드 에러를 유발하여 `.foregroundStyle(.tertiary)`로 수정.
- **결과:** SwiftUI의 표준 계층적 스타일을 사용하여 빌드 오류를 해결하고 가독성을 확보함.

### 🕙 16:05 - [기능 구현] 전체 작업 서브페이지 연동 완료

- **요약:** '전체 작업' 카드 클릭 시 12가지 하부 작업을 확인할 수 있는 `TaskListView` 서브페이지 구현 및 데이터 연동 완료.
- **결과:** 사용자 요청에 따른 12가지 목업 데이터 구성 및 NavigationLink를 통한 화면 전환 처리 완료.

### 🕙 16:10 - [빌드 오류 수정] TaskListView.swift 내 tertiary 스타일 오류 해결

- **요약:** `TaskListView.swift`에서 `Color` 타입에 존재하지 않는 `.tertiary` 멤버를 `.foregroundColor`로 호출하여 발생한 빌드 에러 해결.
- **해결:** `.foregroundColor(.tertiary)`를 최신 SwiftUI 스타일인 `.foregroundStyle(.tertiary)`로 수정하여 정상 빌드 확인.

---

### 🕙 16:20 - [기능 구현] 작업 상세 뷰(TaskDetailView) 및 상태 변경 연동

- **요약:** 개별 작업의 상세 내용을 확인하고 상태(대기 중/진행 중/완료됨)를 변경할 수 있는 `TaskDetailView` 구현 완료.
- **주요 내용:**
  - `@Observable` 기반의 `DashboardViewModel`을 공유하여 상태 변경 시 실시간으로 데이터 저장 및 통계 반영.
  - `TaskListView`와의 내비게이션 연결 완료.

### 🕙 16:25 - [기능 구현] 필터링 기능 및 대시보드 연동 최적화

- **요약:** 대시보드의 '진행 중', '완료' 카드를 클릭했을 때 해당 상태의 작업만 보여주는 필터링 기능 구현.
- **주요 내용:**
  - `TaskListView`에 `filterStatus` 파라미터를 추가하여 조건부 리스트 렌더링.
  - `MainDashboardView`의 모든 스탯 카드를 `NavigationLink`로 감싸 데이터 접근성 강화.

### 🕙 16:30 - [모델 수정] AppTask 구조체 이니셜라이저 수정

- **요약:** `AppTask`의 `id`가 `let`으로 선언되어 업데이트 시 초기화에 실패하던 문제 해결.
- **해결:** 명시적 이니셜라이저를 추가하여 `id`를 보존하면서 필드만 업데이트할 수 있도록 수정.

---

### 🕙 16:40 - [트러블슈팅] 실제 기기 배포 오류 해결

- **현상:** Xcode에서 "A build only device cannot be used to run this target" 오류 발생 및 아이폰 설정에 "개발자 앱" 메뉴 미표시.
- **원인:**
  - Xcode 상단 대상 기기가 실제 기기가 아닌 'Any iOS Device'로 선택되어 빌드 및 실행(Cmd+R)이 불가능한 상태.
  - 앱이 기기에 아직 설치되지 않았기 때문에 아이폰 설정의 "VPN 및 기기 관리"에 신뢰 메뉴가 나타나지 않음.
- **조치:**
  - 상단 툴바에서 실제 연결된 아이폰 이름을 선택하도록 가이드.
  - 성공적인 첫 빌드 후 신뢰 메뉴가 나타남을 안내.
- **결과:** 사용자가 실제 기기에서 앱이 정상 작동함을 확인.

---

### 🕙 16:50 - [문서화] 프로젝트 구조 분석 및 가이드 작성 (Phase 8)

- **요약:** 현재 프로젝트의 MVVM 아키텍처와 주요 컴포넌트 간 데이터 흐름을 체계적으로 분석하여 문서화 (`doc/project_analysis.ko.md`).
- **주요 내용:**
  - `Model`, `ViewModel`, `View`의 역할 및 상호작용 정리.
  - 앱 수명 주기(`App` 프로토콜)와 초기 진입점 분석.

### 🕙 16:55 - [문서화] Antigravity 전용 SwiftUI 마이크로 프로세스 가이드 작성 (Phase 9)

- **요약:** 초보 개발자가 AI(Antigravity)와 협업하여 SwiftUI 앱을 개발할 때 사용할 수 있는 10단계 마이크로 프로세스 가이드 제작.
- **주요 내용:**
  - 단계별 영문/한글 프롬프트 예시 제공.
  - MVVM 아키텍처 및 SwiftUI 기초 개념/용어 정리.
  - `doc/antigravity_swiftui_guide.ko.md` 파일 생성.

### 🕙 17:10 - [문서화] KIMI 개발 프로세스 및 UI 파이프라인 가이드 추가

- **요약:** 사용자가 추가한 KIMI 전용 iOS 개발 프로세스와 UI 시각화 파이프라인 문서를 저장소에 반영.
- **주요 내용:**
  - `doc/Ai iOS Dev Process(KIMI)`: AI 협업을 위한 보강된 12단계 프로세스.
  - `doc/UI Idea to reeal Proces (KIMI)`: 아이디어를 현실적인 UI로 구현하는 6단계 파이프라인.
- **결과:** Git 푸시 완료 및 문서 자산화.

---
**[2026-02-17] 안티그래비티 iOS 프로젝트 V1.0.0 최종 가이드 및 외부 레퍼런스 통합 완료.**
