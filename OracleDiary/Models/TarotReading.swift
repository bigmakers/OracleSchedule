import Foundation
import SwiftData

@Model
final class TarotReading {
    var id: UUID
    var date: Date
    var cardName: String
    var adviceText: String
    var isUpright: Bool

    init(date: Date = .now, cardName: String, adviceText: String, isUpright: Bool) {
        self.id = UUID()
        self.date = date
        self.cardName = cardName
        self.adviceText = adviceText
        self.isUpright = isUpright
    }
}
