import SwiftUI
import SwiftData

struct CalendarTabView: View {
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    MonthCalendarView(selectedDate: $selectedDate)
                        .padding(.horizontal)

                    DayDetailView(selectedDate: selectedDate)
                        .padding(.horizontal)
                }
                .padding(.vertical, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(L10n.calendarTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CalendarTabView()
        .modelContainer(for: [
            TarotReading.self,
            TaskItem.self,
            DiaryEntry.self
        ], inMemory: true)
}
