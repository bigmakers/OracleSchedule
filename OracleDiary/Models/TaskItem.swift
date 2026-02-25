import Foundation
import SwiftData

@Model
final class TaskItem {
    var id: UUID
    var date: Date
    var title: String
    var isCompleted: Bool

    @Relationship(deleteRule: .cascade, inverse: \TaskTarotReading.taskItem)
    var tarotReading: TaskTarotReading?

    init(date: Date, title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.date = date
        self.title = title
        self.isCompleted = isCompleted
        self.tarotReading = nil
    }
}
