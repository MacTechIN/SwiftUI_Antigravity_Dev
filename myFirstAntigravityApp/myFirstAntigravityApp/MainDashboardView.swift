import SwiftUI

struct MainDashboardView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("대시보드")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("안티그래비티 프로젝트의 진행 상황입니다.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Stat Cards
                LazyVGrid(columns: columns, spacing: 16) {
                    DashboardCard(title: "전체 작업", value: "12", icon: "checklist", color: .blue)
                    DashboardCard(title: "진행 중", value: "3", icon: "clock.fill", color: .orange)
                    DashboardCard(title: "완료", value: "9", icon: "checkmark.circle.fill", color: .green)
                    DashboardCard(title: "이력 로그", value: "4", icon: "doc.text.fill", color: .purple)
                }
                
                // Upcoming Tasks Section
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
                            .foregroundColor(.secondary)
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

#Preview {
    NavigationStack {
        MainDashboardView()
    }
}
