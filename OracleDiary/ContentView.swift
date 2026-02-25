import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarTabView()
                .tabItem {
                    Label(L10n.tabCalendar, systemImage: "calendar")
                }

            TodoListView()
                .tabItem {
                    Label(L10n.tabTodo, systemImage: "checklist")
                }

            DiaryTabView()
                .tabItem {
                    Label(L10n.tabDiary, systemImage: "book.closed")
                }

            TarotReadingView()
                .tabItem {
                    Label(L10n.tabDrawCard, systemImage: "sparkles")
                }

            SettingsView()
                .tabItem {
                    Label(L10n.tabSettings, systemImage: "gearshape")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [
            TarotReading.self,
            TaskItem.self,
            DiaryEntry.self,
            TaskTarotReading.self
        ], inMemory: true)
}
