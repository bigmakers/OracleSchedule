import SwiftUI
import SwiftData

@main
struct OracleDiaryApp: App {
    @AppStorage("app_language") private var language = "ja"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: language))
        }
        .modelContainer(for: [
            TarotReading.self,
            TaskItem.self,
            DiaryEntry.self,
            TaskTarotReading.self
        ])
    }
}
