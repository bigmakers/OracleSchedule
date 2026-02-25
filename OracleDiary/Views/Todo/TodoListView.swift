import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TaskItem.date) private var allTasks: [TaskItem]
    @State private var selectedFilter: TodoFilter = .incomplete
    @State private var showAddSheet = false

    enum TodoFilter: CaseIterable, Identifiable {
        case incomplete
        case completed
        case all

        var id: String {
            switch self {
            case .incomplete: return "incomplete"
            case .completed: return "completed"
            case .all: return "all"
            }
        }

        var title: String {
            switch self {
            case .incomplete: return L10n.filterIncomplete
            case .completed: return L10n.filterComplete
            case .all: return L10n.filterAll
            }
        }
    }

    private var filteredTasks: [TaskItem] {
        switch selectedFilter {
        case .incomplete:
            return allTasks.filter { !$0.isCompleted }
        case .completed:
            return allTasks.filter { $0.isCompleted }.reversed()
        case .all:
            return allTasks
        }
    }

    // 日付ごとにグループ化
    private var groupedTasks: [(date: Date, tasks: [TaskItem])] {
        let grouped = Dictionary(grouping: filteredTasks) { $0.date.startOfDay }
        return grouped
            .sorted { $0.key < $1.key }
            .map { (date: $0.key, tasks: $0.value) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // フィルタ
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(TodoFilter.allCases) { filter in
                        Text(filter.title).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 10)

                // TODOリスト
                if filteredTasks.isEmpty {
                    emptyView
                } else {
                    List {
                        ForEach(groupedTasks, id: \.date) { group in
                            Section(group.date.shortDateString) {
                                ForEach(group.tasks) { task in
                                    TodoRowView(task: task)
                                }
                                .onDelete { offsets in
                                    deleteTasks(from: group.tasks, at: offsets)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("TODO")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddTodoSheet()
            }
        }
    }

    private var emptyView: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "checklist")
                .font(.system(size: 48))
                .foregroundStyle(.secondary.opacity(0.4))

            Text(emptyMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()
        }
    }

    private var emptyMessage: String {
        switch selectedFilter {
        case .incomplete: return L10n.noIncompleteTasks
        case .completed: return L10n.noCompletedTasks
        case .all: return L10n.noTasks
        }
    }

    private func deleteTasks(from tasks: [TaskItem], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}
