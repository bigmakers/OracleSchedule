import Foundation
import SwiftData

@Model
final class DiaryEntry {
    var id: UUID
    var date: Date
    var content: String
    var photos: [Data]

    init(date: Date, content: String = "", photos: [Data] = []) {
        self.id = UUID()
        self.date = date
        self.content = content
        self.photos = photos
    }
}
