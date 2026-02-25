import SwiftUI
import SwiftData

struct DayDetailView: View {
    let selectedDate: Date

    @Environment(\.modelContext) private var modelContext
    @Query private var allReadings: [TarotReading]
    @Query private var allTasks: [TaskItem]

    @State private var newTaskTitle: String = ""
    @FocusState private var isTaskFieldFocused: Bool

    private var readings: [TarotReading] {
        allReadings.filter { $0.date.isSameDay(as: selectedDate) }
            .sorted { $0.date > $1.date }
    }

    private var tasks: [TaskItem] {
        allTasks.filter { $0.date.isSameDay(as: selectedDate) }
            .sorted { $0.date < $1.date }
    }

    var body: some View {
        VStack(spacing: 16) {
            // 日付ヘッダー
            HStack {
                Text(selectedDate.shortDateString)
                    .font(.title3)
                    .fontWeight(.bold)

                if Calendar.current.isDateInToday(selectedDate) {
                    Text(L10n.today)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(.purple))
                }

                Spacer()
            }

            readingsSection
            todoSection
        }
    }

    // MARK: - 占い履歴セクション

    private var readingsSection: some View {
        SectionContainer(
            title: L10n.oracleHistory,
            icon: "sparkles",
            isEmpty: readings.isEmpty,
            emptyMessage: L10n.noOracleResults
        ) {
            ForEach(readings) { reading in
                HStack(spacing: 12) {
                    Circle()
                        .fill(reading.isUpright ? .green.opacity(0.2) : .orange.opacity(0.2))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: reading.isUpright ? "arrow.up" : "arrow.down")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(reading.isUpright ? .green : .orange)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(reading.cardName)
                            .font(.subheadline)
                            .fontWeight(.medium)

                        Text(reading.adviceText)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }

                    Spacer()

                    Text(reading.date.timeString)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - TODOセクション

    private var todoSection: some View {
        SectionContainer(
            title: "TODO",
            icon: "checklist",
            isEmpty: false,
            emptyMessage: nil
        ) {
            ForEach(tasks) { task in
                TodoRowView(task: task)
            }

            HStack(spacing: 12) {
                Image(systemName: "plus.circle")
                    .font(.title3)
                    .foregroundStyle(.purple.opacity(0.6))

                TextField(L10n.addNewTask, text: $newTaskTitle)
                    .font(.subheadline)
                    .focused($isTaskFieldFocused)
                    .onSubmit {
                        addTask()
                    }

                if !newTaskTitle.isEmpty {
                    Button {
                        addTask()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.purple)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 2)
        }
    }

    // MARK: - Actions

    private func addTask() {
        let title = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }

        let task = TaskItem(date: selectedDate, title: title)
        modelContext.insert(task)
        newTaskTitle = ""
        isTaskFieldFocused = false
    }
}

// MARK: - Section Container

struct SectionContainer<Content: View>: View {
    let title: String
    let icon: String
    let isEmpty: Bool
    let emptyMessage: String?
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundStyle(.purple)

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            if isEmpty {
                if let emptyMessage {
                    Text(emptyMessage)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            } else {
                content()
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    DayDetailView(selectedDate: Date())
        .modelContainer(for: [
            TarotReading.self,
            TaskItem.self,
            DiaryEntry.self,
            TaskTarotReading.self
        ], inMemory: true)
}
