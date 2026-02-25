import Foundation

enum L10n {
    static var isEnglish: Bool {
        UserDefaults.standard.string(forKey: "app_language") ?? "ja" == "en"
    }

    // MARK: - Tabs
    static var tabCalendar: String { isEnglish ? "Calendar" : "カレンダー" }
    static var tabTodo: String { "TODO" }
    static var tabDiary: String { isEnglish ? "Diary" : "日記" }
    static var tabDrawCard: String { isEnglish ? "Draw Card" : "カードを引く" }
    static var tabSettings: String { isEnglish ? "Settings" : "設定" }

    // MARK: - Calendar
    static var calendarTitle: String { isEnglish ? "Calendar" : "カレンダー" }
    static var today: String { isEnglish ? "Today" : "今日" }
    static var backToToday: String { isEnglish ? "Back to Today" : "今日に戻る" }
    static var weekdaySymbols: [String] {
        isEnglish ? ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                  : ["日", "月", "火", "水", "木", "金", "土"]
    }
    static var monthYearFormat: String { isEnglish ? "MMMM yyyy" : "yyyy年 M月" }
    static var shortDateFormat: String { isEnglish ? "MMM d" : "M月d日" }

    // MARK: - Day Detail
    static var oracleHistory: String { isEnglish ? "Oracle History" : "占い履歴" }
    static var noOracleResults: String { isEnglish ? "No oracle results for this day" : "この日の占い結果はありません" }
    static var addNewTask: String { isEnglish ? "Add new task..." : "新しい予定を追加..." }

    // MARK: - Tarot
    static var oneOracle: String { isEnglish ? "One Oracle" : "ワンオラクル" }
    static var calmAndDraw: String { isEnglish ? "Calm your mind\nand draw a card" : "心を落ち着けて\nカードを引いてみましょう" }
    static var upright: String { isEnglish ? "Upright" : "正位置" }
    static var reversed: String { isEnglish ? "Reversed" : "逆位置" }
    static var divine: String { isEnglish ? "Draw" : "占う" }
    static var tapToFlip: String { isEnglish ? "Tap to Flip" : "タップしてめくる" }
    static var divineAgain: String { isEnglish ? "Draw Again" : "もう一度占う" }
    static var uprightSuffix: String { isEnglish ? " (Upright)" : "（正位置）" }
    static var reversedSuffix: String { isEnglish ? " (Reversed)" : "（逆位置）" }
    static var addTodoPrompt: String { isEnglish ? "Add a TODO you remembered" : "思い出したTODOを追加しましょう" }

    // MARK: - TODO
    static var todoTitle: String { "TODO" }
    static var filterIncomplete: String { isEnglish ? "Active" : "未完了" }
    static var filterComplete: String { isEnglish ? "Done" : "完了" }
    static var filterAll: String { isEnglish ? "All" : "全て" }
    static var noIncompleteTasks: String { isEnglish ? "No active tasks" : "未完了のタスクはありません" }
    static var noCompletedTasks: String { isEnglish ? "No completed tasks" : "完了したタスクはありません" }
    static var noTasks: String { isEnglish ? "No tasks" : "タスクはありません" }
    static var divineThisTask: String { isEnglish ? "Divine this task" : "このタスクを占う" }

    // MARK: - Add TODO Sheet
    static var taskName: String { isEnglish ? "Task name" : "タスク名" }
    static var date: String { isEnglish ? "Date" : "日付" }
    static var newTodo: String { isEnglish ? "New TODO" : "新しいTODO" }
    static var cancel: String { isEnglish ? "Cancel" : "キャンセル" }
    static var add: String { isEnglish ? "Add" : "追加" }

    // MARK: - Task Tarot
    static var divineTaskFortune: String { isEnglish ? "Divine this task's fortune" : "このタスクの運勢を占います" }
    static var oracleResult: String { isEnglish ? "Oracle Result" : "占い結果" }
    static var close: String { isEnglish ? "Close" : "閉じる" }

    // MARK: - Diary
    static var diaryTitle: String { isEnglish ? "Diary" : "日記" }
    static var writeDiary: String { isEnglish ? "Write Diary" : "日記を書く" }
    static var noDiaryEntry: String { isEnglish ? "No diary entry for this day yet" : "この日の日記はまだありません" }
    static var startWriting: String { isEnglish ? "Start Writing" : "書き始める" }
    static var addPhotos: String { isEnglish ? "Add Photos" : "写真を追加" }
    // MARK: - Settings
    static var settingsTitle: String { isEnglish ? "Settings" : "設定" }
    static var general: String { isEnglish ? "General" : "一般" }
    static var languageSetting: String { isEnglish ? "Language" : "言語 / Language" }
    static var version: String { isEnglish ? "Version" : "バージョン" }

    // MARK: - Language Settings
    static var languageTitle: String { isEnglish ? "Language" : "言語設定" }
    static var displayLanguage: String { isEnglish ? "Display Language" : "表示言語 / Language" }
    static var japanese: String { isEnglish ? "Japanese" : "日本語" }
    static var english: String { "English" }
    static var languageDescription: String { isEnglish ? "Switch the app display language." : "アプリの表示言語を切り替えます。" }
}
