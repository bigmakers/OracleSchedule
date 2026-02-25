import SwiftUI
import SwiftData

struct TodoRowView: View {
    @Bindable var task: TaskItem
    @State private var showReadingSheet = false
    @State private var showResultSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 上段: チェック + タイトル
            HStack(spacing: 12) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        task.isCompleted.toggle()
                    }
                } label: {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(task.isCompleted ? .green : .secondary)
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 2) {
                    Text(task.title)
                        .font(.subheadline)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .secondary : .primary)

                    Text(task.date.shortDateString)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }

                Spacer()
            }

            // 下段: 占いボタン or 占い結果バッジ
            if task.tarotReading != nil {
                Button {
                    showResultSheet = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .font(.caption)
                        Text(task.tarotReading!.cardName)
                            .font(.caption)
                        Image(systemName: task.tarotReading!.isUpright ? "arrow.up" : "arrow.down")
                            .font(.caption2)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(task.tarotReading!.isUpright ? .green.opacity(0.8) : .orange.opacity(0.8))
                    )
                }
                .buttonStyle(.plain)
            } else {
                Button {
                    showReadingSheet = true
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.caption)
                        Text(L10n.divineThisTask)
                            .font(.caption)
                    }
                    .foregroundStyle(.purple)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .strokeBorder(.purple.opacity(0.4), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 4)
        // シートはビューのルートに配置（条件分岐の外）
        .sheet(isPresented: $showReadingSheet) {
            TaskTarotReadingView(task: task)
                .presentationDetents([.large])
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showResultSheet) {
            if let reading = task.tarotReading {
                TaskTarotResultView(reading: reading)
                    .presentationDetents([.medium])
            }
        }
    }
}
