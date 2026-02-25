import SwiftUI

struct MonthCalendarView: View {
    @Binding var selectedDate: Date
    @State private var displayedMonth: Date = Date()

    private let calendar = Calendar.current
    private var weekdaySymbols: [String] { L10n.weekdaySymbols }
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    private var isDisplayingCurrentMonth: Bool {
        calendar.isDate(displayedMonth, equalTo: Date(), toGranularity: .month)
    }

    var body: some View {
        VStack(spacing: 12) {
            // 月のナビゲーション
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.purple)
                }

                Spacer()

                VStack(spacing: 2) {
                    Text(monthYearString)
                        .font(.headline)

                    if !isDisplayingCurrentMonth {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                displayedMonth = Date()
                                selectedDate = Date()
                            }
                        } label: {
                            Text(L10n.backToToday)
                                .font(.caption2)
                                .foregroundStyle(.purple)
                        }
                    }
                }

                Spacer()

                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundStyle(.purple)
                }
            }
            .padding(.horizontal, 8)

            // 曜日ヘッダー
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(Array(weekdaySymbols.enumerated()), id: \.offset) { index, symbol in
                    Text(symbol)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            index == 0 ? .red.opacity(0.8) :
                            index == 6 ? .blue.opacity(0.8) :
                            .secondary
                        )
                        .frame(maxWidth: .infinity)
                }
            }

            // 日付グリッド
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(daysInMonth(), id: \.self) { date in
                    if let date = date {
                        DayCellView(
                            date: date,
                            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                            isToday: calendar.isDateInToday(date)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedDate = date
                            }
                        }
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 42)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }

    // MARK: - Helpers

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: L10n.isEnglish ? "en_US" : "ja_JP")
        formatter.dateFormat = L10n.monthYearFormat
        return formatter.string(from: displayedMonth)
    }

    private func changeMonth(by value: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            if let newMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
                displayedMonth = newMonth
            }
        }
    }

    private func daysInMonth() -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))
        else { return [] }

        let firstWeekday = calendar.component(.weekday, from: firstDay)
        // 日曜始まり: weekday 1 = 日曜
        let leadingSpaces = firstWeekday - 1

        var days: [Date?] = Array(repeating: nil, count: leadingSpaces)

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }

        return days
    }
}

// MARK: - Day Cell

struct DayCellView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool

    private var dayNumber: Int {
        Calendar.current.component(.day, from: date)
    }

    private var weekday: Int {
        Calendar.current.component(.weekday, from: date)
    }

    var body: some View {
        VStack(spacing: 1) {
            Text("\(dayNumber)")
                .font(.subheadline)
                .fontWeight(isToday || isSelected ? .bold : .regular)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .frame(width: 34, height: 34)
                .background(
                    Circle()
                        .fill(backgroundColor)
                )
                .overlay(
                    Circle()
                        .strokeBorder(isToday && !isSelected ? .purple : .clear, lineWidth: 2)
                )

            // 今日インジケーター（小さなドット）
            Circle()
                .fill(isToday ? .purple : .clear)
                .frame(width: 4, height: 4)
        }
        .frame(height: 42)
    }

    private var textColor: Color {
        if isSelected {
            return .white
        }
        if isToday {
            return .purple
        }
        if weekday == 1 { return .red.opacity(0.8) }
        if weekday == 7 { return .blue.opacity(0.8) }
        return .primary
    }

    private var backgroundColor: Color {
        if isSelected {
            return .purple
        }
        if isToday {
            return .purple.opacity(0.12)
        }
        return .clear
    }
}

#Preview {
    MonthCalendarView(selectedDate: .constant(Date()))
}
