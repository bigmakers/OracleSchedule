import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        Calendar.current.date(byAdding: .init(day: 1, second: -1), to: startOfDay)!
    }

    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: L10n.isEnglish ? "en_US" : "ja_JP")
        formatter.dateFormat = L10n.shortDateFormat
        return formatter.string(from: self)
    }

    var fullDateTimeString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: L10n.isEnglish ? "en_US" : "ja_JP")
        formatter.dateFormat = L10n.isEnglish ? "MMM d, yyyy HH:mm" : "yyyy年M月d日 HH:mm"
        return formatter.string(from: self)
    }

    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
