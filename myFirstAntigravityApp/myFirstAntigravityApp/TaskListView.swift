import SwiftUI

struct TaskListView: View {
    var viewModel: DashboardViewModel
    var filterStatus: AppTask.TaskStatus? = nil
    @Environment(\.dismiss) private var dismiss
    
    private var filteredTasks: [AppTask] {
        if let filterStatus = filterStatus {
            return viewModel.appTasks.filter { $0.status == filterStatus }
        }
        return viewModel.appTasks
    }
    
    var body: some View {
        List {
            Section {
                ForEach(filteredTasks) { task in
                    NavigationLink {
                        TaskDetailView(taskID: task.id, viewModel: viewModel)
                    } label: {
                        TaskRow(task: task)
                    }
                }
            } header: {
                Text("진행 상황 (\(filteredTasks.count))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .textCase(nil)
            }
        }
        .navigationTitle(filterStatus?.rawValue ?? "전체 작업")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct TaskRow: View {
    let task: AppTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title)
                    .font(.headline)
                
                Spacer()
                
                StatusBadge(status: task.status)
            }
            
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "calendar")
                    .font(.caption2)
                Text(task.dueDate)
                    .font(.caption2)
                
                Spacer()
            }
            .foregroundStyle(.tertiary)
            .padding(.top, 2)
        }
        .padding(.vertical, 4)
    }
}

struct StatusBadge: View {
    let status: AppTask.TaskStatus
    
    var color: Color {
        switch status {
        case .pending: return .gray
        case .inProgress: return .orange
        case .completed: return .green
        }
    }
    
    var body: some View {
        Text(status.rawValue)
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .clipShape(Capsule())
    }
}

#Preview {
    NavigationStack {
        TaskListView(viewModel: DashboardViewModel())
    }
}
