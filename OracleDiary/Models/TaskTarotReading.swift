import Foundation
import SwiftData

@Model
final class TaskTarotReading {
    var id: UUID
    var date: Date
    var cardName: String
    var adviceText: String
    var isUpright: Bool

    var taskItem: TaskItem?

    init(date: Date = .now, cardName: String, adviceText: String, isUpright: Bool) {
        self.id = UUID()
        self.date = date
        self.cardName = cardName
        self.adviceText = adviceText
        self.isUpright = isUpright
    }
}
