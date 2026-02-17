import SwiftUI

struct MainDashboardView: View {
    @State private var viewModel = DashboardViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text("대시보드")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                    Text("안티그래비티 프로젝트의 진행 상황입니다.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Stat Cards
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.stats) { stat in
                        NavigationLink {
                            if stat.title == "전체 작업" {
                                TaskListView(viewModel: viewModel)
                            } else if stat.title == "진행 중" {
                                TaskListView(viewModel: viewModel, filterStatus: .inProgress)
                            } else if stat.title == "완료" {
                                TaskListView(viewModel: viewModel, filterStatus: .completed)
                            } else {
                                // Default or other views
                                Text("\(stat.title) 상세 뷰 준비 중")
                            }
                        } label: {
                            DashboardCard(
                                title: stat.title,
                                value: stat.value,
                                icon: stat.icon,
                                color: stat.color
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(stat.title == "이력 로그") // Disable for now if not implemented
                    }
                }
                
                // Activities Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("최근 활동")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 12) {
                        ForEach(viewModel.activities) { activity in
                            ActivityRow(activity: activity)
                        }
                    }
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
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
        VStack(alignment: .leading, spacing: 15) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct ActivityRow: View {
    let activity: ActivityLog
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: activity.icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.headline)
                Text(activity.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(activity.timestamp)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        MainDashboardView()
    }
}
