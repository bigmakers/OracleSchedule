import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarTabView()
                .tabItem {
                    Label(L10n.tabCalendar, systemImage: "calendar")
                }
                .tag(0)

            TodoListView()
                .tabItem {
                    Label(L10n.tabTodo, systemImage: "checklist")
                }
                .tag(1)

            DiaryTabView()
                .tabItem {
                    Label(L10n.tabDiary, systemImage: "book.closed")
                }
                .tag(2)

            TarotReadingView()
                .tabItem {
                    Label(L10n.tabDrawCard, systemImage: "sparkles")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label(L10n.tabSettings, systemImage: "gearshape")
                }
                .tag(4)
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
