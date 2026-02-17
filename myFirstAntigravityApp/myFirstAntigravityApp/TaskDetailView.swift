import SwiftUI

struct TaskDetailView: View {
    let taskID: UUID
    var viewModel: DashboardViewModel
    @Environment(\.dismiss) private var dismiss
    
    // Find the task from the viewmodel
    private var task: AppTask? {
        viewModel.appTasks.first(where: { $0.id == taskID })
    }
    
    var body: some View {
        Group {
            if let task = task {
                Form {
                    Section(header: Text("작업 정보")) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(task.title)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text(task.description)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                        
                        HStack {
                            Label("마감일", systemImage: "calendar")
                            Spacer()
                            Text(task.dueDate)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section(header: Text("상태 변경")) {
                        Picker("상태", selection: binding(for: task)) {
                            Text("대기 중").tag(AppTask.TaskStatus.pending)
                            Text("진행 중").tag(AppTask.TaskStatus.inProgress)
                            Text("완료됨").tag(AppTask.TaskStatus.completed)
                        }
                        .pickerStyle(.segmented)
                    }
                }
            } else {
                Text("작업을 찾을 수 없습니다.")
            }
        }
        .navigationTitle("작업 상세")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func binding(for task: AppTask) -> Binding<AppTask.TaskStatus> {
        Binding {
            task.status
        } set: { newValue in
            viewModel.updateTaskStatus(taskID: task.id, newStatus: newValue)
        }
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(taskID: UUID(), viewModel: DashboardViewModel())
    }
}
