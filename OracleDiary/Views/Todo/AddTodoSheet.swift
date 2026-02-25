import SwiftUI
import SwiftData

struct AddTodoSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(L10n.taskName, text: $title)
                }

                Section {
                    DatePicker(
                        L10n.date,
                        selection: $date,
                        displayedComponents: .date
                    )
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                }
            }
            .navigationTitle(L10n.newTodo)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(L10n.add) {
                        addTask()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }

    private func addTask() {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let task = TaskItem(date: date, title: trimmed)
        modelContext.insert(task)
        dismiss()
    }
}
