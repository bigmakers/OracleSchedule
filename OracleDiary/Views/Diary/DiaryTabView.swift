import SwiftUI
import SwiftData

struct DiaryTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allDiaries: [DiaryEntry]

    @State private var selectedDate: Date = Date()
    @State private var diaryText: String = ""
    @State private var diaryPhotos: [Data] = []
    @State private var isDiaryEditing: Bool = false

    private var diaryEntry: DiaryEntry? {
        allDiaries.first { $0.date.isSameDay(as: selectedDate) }
    }

    /// 日記が存在する日付のセット
    private var datesWithDiary: Set<Date> {
        Set(allDiaries.map { $0.date.startOfDay })
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // 日付選択
                    dateSelector

                    // 日記コンテンツ
                    diaryContent
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(L10n.diaryTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isDiaryEditing.toggle()
                        if !isDiaryEditing {
                            saveDiary()
                        }
                    } label: {
                        Image(systemName: isDiaryEditing ? "checkmark.circle.fill" : "pencil.circle")
                            .font(.title3)
                            .foregroundStyle(.purple)
                    }
                }
            }
            .onChange(of: selectedDate) {
                reloadDiary()
            }
            .onAppear {
                reloadDiary()
            }
        }
    }

    // MARK: - Date Selector

    private var dateSelector: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    changeDate(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.purple)
                }

                Spacer()

                VStack(spacing: 2) {
                    Text(selectedDate.shortDateString)
                        .font(.title3)
                        .fontWeight(.bold)

                    if Calendar.current.isDateInToday(selectedDate) {
                        Text(L10n.today)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 1)
                            .background(Capsule().fill(.purple))
                    }
                }

                Spacer()

                Button {
                    changeDate(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundStyle(.purple)
                }
            }
            .padding(.horizontal, 8)

            // 今日に戻るボタン
            if !Calendar.current.isDateInToday(selectedDate) {
                Button {
                    withAnimation {
                        selectedDate = Date()
                    }
                } label: {
                    Text(L10n.backToToday)
                        .font(.caption)
                        .foregroundStyle(.purple)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }

    // MARK: - Diary Content

    private var diaryContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isDiaryEditing {
                editingView
            } else {
                readingView
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }

    // MARK: - Editing View

    private var editingView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.writeDiary)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)

            TextEditor(text: $diaryText)
                .font(.body)
                .frame(minHeight: 200)
                .scrollContentBackground(.hidden)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )

            // 写真
            DiaryPhotosGridView(photos: $diaryPhotos, isEditing: true)
            DiaryPhotoPickerView(photos: $diaryPhotos)
        }
    }

    // MARK: - Reading View

    private var readingView: some View {
        VStack(alignment: .leading, spacing: 12) {
            if diaryText.isEmpty && diaryPhotos.isEmpty {
                // 空の状態
                VStack(spacing: 12) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 36))
                        .foregroundStyle(.secondary.opacity(0.4))

                    Text(L10n.noDiaryEntry)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Button {
                        isDiaryEditing = true
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "pencil")
                                .font(.caption)
                            Text(L10n.startWriting)
                                .font(.subheadline)
                        }
                        .foregroundStyle(.purple)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .strokeBorder(.purple.opacity(0.4), lineWidth: 1)
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
            } else {
                // 日記あり
                if !diaryText.isEmpty {
                    Text(diaryText)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                DiaryPhotosGridView(photos: $diaryPhotos, isEditing: false)
            }
        }
    }

    // MARK: - Actions

    private func changeDate(by value: Int) {
        if isDiaryEditing {
            saveDiary()
            isDiaryEditing = false
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            if let newDate = Calendar.current.date(byAdding: .day, value: value, to: selectedDate) {
                selectedDate = newDate
            }
        }
    }

    private func reloadDiary() {
        diaryText = diaryEntry?.content ?? ""
        diaryPhotos = diaryEntry?.photos ?? []
        isDiaryEditing = false
    }

    private func saveDiary() {
        let content = diaryText.trimmingCharacters(in: .whitespacesAndNewlines)

        if let existing = diaryEntry {
            existing.content = content
            existing.photos = diaryPhotos
        } else if !content.isEmpty || !diaryPhotos.isEmpty {
            let entry = DiaryEntry(date: selectedDate, content: content, photos: diaryPhotos)
            modelContext.insert(entry)
        }
    }
}
