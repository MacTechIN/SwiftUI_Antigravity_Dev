import Foundation
import SwiftUI

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

class DashboardViewModel: ObservableObject {
    @Published var stats: [DashboardStat] = []
    @Published var activities: [ActivityLog] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        // Mock data load
        self.stats = [
            DashboardStat(title: "전체 작업", value: "12", icon: "checklist", color: .blue),
            DashboardStat(title: "진행 중", value: "3", icon: "clock.fill", color: .orange),
            DashboardStat(title: "완료", value: "9", icon: "checkmark.circle.fill", color: .green),
            DashboardStat(title: "이력 로그", value: "4", icon: "doc.text.fill", color: .purple)
        ]
        
        self.activities = [
            ActivityLog(title: "GitHub 푸시 완료", subtitle: "V0.1.0 초기 설정 업데이트", timestamp: "방금 전", icon: "arrow.up.circle.fill"),
            ActivityLog(title: "MainDashboard 구현", subtitle: "컴파일 에러 수정 및 UI 고도화", timestamp: "2시간 전", icon: "plus.circle.fill"),
            ActivityLog(title: "애니메이션 추가", subtitle: "Waving hand 로직 적용", timestamp: "어제", icon: "wand.and.stars")
        ]
    }
}
