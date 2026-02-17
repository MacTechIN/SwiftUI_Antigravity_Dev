import Foundation
import SwiftUI
import Observation

struct DashboardStat: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    let color: Color
}

struct ActivityLog: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let timestamp: String
    let icon: String
}

struct AppTask: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let status: TaskStatus
    let dueDate: String
    
    enum TaskStatus: String {
        case pending = "대기 중"
        case inProgress = "진행 중"
        case completed = "완료됨"
    }
    
    init(id: UUID = UUID(), title: String, description: String, status: TaskStatus, dueDate: String) {
        self.id = id
        self.title = title
        self.description = description
        self.status = status
        self.dueDate = dueDate
    }
}

@Observable
class DashboardViewModel {
    var stats: [DashboardStat] = []
    var activities: [ActivityLog] = []
    var appTasks: [AppTask] = []
    
    init() {
        loadData()
    }
    
    func updateTaskStatus(taskID: UUID, newStatus: AppTask.TaskStatus) {
        if let index = appTasks.firstIndex(where: { $0.id == taskID }) {
            appTasks[index] = AppTask(id: taskID, title: appTasks[index].title, description: appTasks[index].description, status: newStatus, dueDate: appTasks[index].dueDate)
            updateStats()
        }
    }
    
    private func updateStats() {
        self.stats = [
            DashboardStat(title: "전체 작업", value: "\(appTasks.count)", icon: "checklist", color: .blue),
            DashboardStat(title: "진행 중", value: "\(appTasks.filter { $0.status == .inProgress }.count)", icon: "clock.fill", color: .orange),
            DashboardStat(title: "완료", value: "\(appTasks.filter { $0.status == .completed }.count)", icon: "checkmark.circle.fill", color: .green),
            DashboardStat(title: "이력 로그", value: "4", icon: "doc.text.fill", color: .purple)
        ]
    }
    
    func loadData() {
        // Mock tasks (12 items)
        self.appTasks = [
            AppTask(title: "Xcode 프로젝트 초기화", description: "iOS 어플리케이션 프로젝트 구조 생성", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "기본 UI 레이아웃 설계", description: "SwiftUI를 이용한 기본 대시보드 레이아웃 구성", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "아이콘 애니메이션 구현", description: "Waving hand 및 피드백 애니메이션 추가", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "대시보드 뷰 모델링", description: "@Observable 기반 View 모델 구현", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "데이터 바인딩 최적화", description: "상태 관리 및 데이터 흐름 최적화", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "빌드 오류 수정", description: ".tertiaryLabel 및 프로토콜 준수 오류 수정", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "개발 이력 문서화", description: "dev_history.md 및 walkthrough 작성", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "Git 버전 관리 설정", description: "로컬 및 원격 저장소 동기화", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "전체 작업 서브페이지 기획", description: "하부 작업 12종 리스트 상세 기획", status: .completed, dueDate: "2026-02-17"),
            AppTask(title: "TaskListView UI 구현", description: "하부 작업 리스트를 위한 전용 뷰 생성", status: .inProgress, dueDate: "2026-02-18"),
            AppTask(title: "내비게이션 전환 연동", description: "대시보드 카드와 서브페이지 이동 연결", status: .pending, dueDate: "2026-02-18"),
            AppTask(title: "최종 UI 폴리싱", description: "전체적인 디자인 시스템 정합성 및 디테일 개선", status: .pending, dueDate: "2026-02-19")
        ]
        
        updateStats()
        
        self.activities = [
            ActivityLog(title: "서브페이지 작업 시작", subtitle: "12가지 하부 작업 리스트 구현 중", timestamp: "방금 전", icon: "list.bullet.rectangle.fill"),
            ActivityLog(title: "GitHub 푸시 완료", subtitle: "V0.1.0 초기 설정 업데이트", timestamp: "10분 전", icon: "arrow.up.circle.fill"),
            ActivityLog(title: "MainDashboard 구현", subtitle: "컴파일 에러 수정 및 UI 고도화", timestamp: "2시간 전", icon: "plus.circle.fill")
        ]
    }
}
