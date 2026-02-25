import Foundation

struct TarotCard: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
    let nameEn: String
    let symbolName: String
    let uprightMeaning: String
    let uprightMeaningEn: String
    let uprightAdvice: String
    let uprightAdviceEn: String
    let reversedMeaning: String
    let reversedMeaningEn: String
    let reversedAdvice: String
    let reversedAdviceEn: String

    var localizedName: String { L10n.isEnglish ? nameEn : name }
    var localizedUprightMeaning: String { L10n.isEnglish ? uprightMeaningEn : uprightMeaning }
    var localizedUprightAdvice: String { L10n.isEnglish ? uprightAdviceEn : uprightAdvice }
    var localizedReversedMeaning: String { L10n.isEnglish ? reversedMeaningEn : reversedMeaning }
    var localizedReversedAdvice: String { L10n.isEnglish ? reversedAdviceEn : reversedAdvice }
}

struct TarotDeck {
    static let majorArcana: [TarotCard] = [
        TarotCard(
            number: 0,
            name: "愚者", nameEn: "The Fool",
            symbolName: "figure.walk",
            uprightMeaning: "自由・冒険・無限の可能性",
            uprightMeaningEn: "Freedom, Adventure, Infinite Possibility",
            uprightAdvice: "新しい一歩を踏み出す時です。直感を信じて、未知の世界へ飛び込んでみましょう。",
            uprightAdviceEn: "It's time to take a new step. Trust your intuition and leap into the unknown.",
            reversedMeaning: "無謀・軽率・現実逃避",
            reversedMeaningEn: "Recklessness, Carelessness, Escapism",
            reversedAdvice: "勢いだけで動くのは危険です。一度立ち止まって、計画を見直してみましょう。",
            reversedAdviceEn: "Acting on impulse alone is risky. Pause and reconsider your plan."
        ),
        TarotCard(
            number: 1,
            name: "魔術師", nameEn: "The Magician",
            symbolName: "wand.and.stars",
            uprightMeaning: "創造力・才能の開花・新たな始まり",
            uprightMeaningEn: "Creativity, Talent Blooming, New Beginnings",
            uprightAdvice: "あなたには必要なものが全て揃っています。自信を持って行動しましょう。",
            uprightAdviceEn: "You have everything you need. Act with confidence.",
            reversedMeaning: "空回り・才能の浪費・詐欺",
            reversedMeaningEn: "Wasted Effort, Squandered Talent, Deception",
            reversedAdvice: "口先だけでなく、実際の行動に移すことが大切です。地に足をつけましょう。",
            reversedAdviceEn: "Actions speak louder than words. Stay grounded and follow through."
        ),
        TarotCard(
            number: 2,
            name: "女教皇", nameEn: "The High Priestess",
            symbolName: "moon.stars.fill",
            uprightMeaning: "直感・神秘・内なる声",
            uprightMeaningEn: "Intuition, Mystery, Inner Voice",
            uprightAdvice: "静かに心の声に耳を傾けてください。答えはあなたの中にあります。",
            uprightAdviceEn: "Listen quietly to your inner voice. The answer lies within you.",
            reversedMeaning: "秘密・不安・直感の無視",
            reversedMeaningEn: "Secrets, Anxiety, Ignoring Intuition",
            reversedAdvice: "頭で考えすぎていませんか？もっと自分の感覚を信じてあげましょう。",
            reversedAdviceEn: "Are you overthinking? Trust your feelings more."
        ),
        TarotCard(
            number: 3,
            name: "女帝", nameEn: "The Empress",
            symbolName: "leaf.fill",
            uprightMeaning: "豊穣・母性・創造・美",
            uprightMeaningEn: "Abundance, Nurturing, Creativity, Beauty",
            uprightAdvice: "愛情と豊かさに満ちた時期です。周囲の人を温かく包み込みましょう。",
            uprightAdviceEn: "A time filled with love and abundance. Embrace those around you warmly.",
            reversedMeaning: "過保護・依存・停滞",
            reversedMeaningEn: "Overprotection, Dependency, Stagnation",
            reversedAdvice: "与えすぎていませんか？自分自身のケアも忘れないでください。",
            reversedAdviceEn: "Are you giving too much? Don't forget to take care of yourself."
        ),
        TarotCard(
            number: 4,
            name: "皇帝", nameEn: "The Emperor",
            symbolName: "crown.fill",
            uprightMeaning: "権威・安定・リーダーシップ",
            uprightMeaningEn: "Authority, Stability, Leadership",
            uprightAdvice: "強い意志で物事を進める時です。責任を持ってリードしましょう。",
            uprightAdviceEn: "It's time to move forward with strong will. Lead with responsibility.",
            reversedMeaning: "独裁・頑固・支配欲",
            reversedMeaningEn: "Tyranny, Stubbornness, Desire for Control",
            reversedAdvice: "自分のやり方に固執していませんか？柔軟さも大切です。",
            reversedAdviceEn: "Are you clinging to your way? Flexibility matters too."
        ),
        TarotCard(
            number: 5,
            name: "教皇", nameEn: "The Hierophant",
            symbolName: "book.closed.fill",
            uprightMeaning: "教え・慈悲・伝統・精神性",
            uprightMeaningEn: "Teaching, Compassion, Tradition, Spirituality",
            uprightAdvice: "信頼できる人の助言に耳を傾けましょう。学びの時期です。",
            uprightAdviceEn: "Listen to advice from someone you trust. It's a time for learning.",
            reversedMeaning: "束縛・形式主義・独善",
            reversedMeaningEn: "Restriction, Dogma, Self-Righteousness",
            reversedAdvice: "古い価値観に縛られていませんか？自分の道を探してみましょう。",
            reversedAdviceEn: "Are you bound by old beliefs? Explore your own path."
        ),
        TarotCard(
            number: 6,
            name: "恋人", nameEn: "The Lovers",
            symbolName: "heart.fill",
            uprightMeaning: "愛・選択・調和・パートナーシップ",
            uprightMeaningEn: "Love, Choice, Harmony, Partnership",
            uprightAdvice: "心が惹かれる方を選びましょう。真実の気持ちに正直になってください。",
            uprightAdviceEn: "Choose what your heart is drawn to. Be honest with your true feelings.",
            reversedMeaning: "優柔不断・不調和・誘惑",
            reversedMeaningEn: "Indecision, Disharmony, Temptation",
            reversedAdvice: "迷いがあるなら、焦って決断する必要はありません。じっくり向き合いましょう。",
            reversedAdviceEn: "If you're unsure, there's no rush to decide. Take your time."
        ),
        TarotCard(
            number: 7,
            name: "戦車", nameEn: "The Chariot",
            symbolName: "bolt.fill",
            uprightMeaning: "勝利・前進・意志の力",
            uprightMeaningEn: "Victory, Advancement, Willpower",
            uprightAdvice: "強い決意で突き進んでください。勝利はもう目の前にあります。",
            uprightAdviceEn: "Push forward with strong resolve. Victory is within reach.",
            reversedMeaning: "暴走・挫折・方向の見失い",
            reversedMeaningEn: "Loss of Control, Setback, Losing Direction",
            reversedAdvice: "勢いだけではうまくいきません。戦略を立て直してみましょう。",
            reversedAdviceEn: "Momentum alone won't work. Rethink your strategy."
        ),
        TarotCard(
            number: 8,
            name: "力", nameEn: "Strength",
            symbolName: "hands.sparkles.fill",
            uprightMeaning: "内なる強さ・忍耐・勇気",
            uprightMeaningEn: "Inner Strength, Patience, Courage",
            uprightAdvice: "力ずくではなく、優しさと忍耐で乗り越えられます。あなたは強い人です。",
            uprightAdviceEn: "Not by force, but with gentleness and patience. You are strong.",
            reversedMeaning: "弱気・自信喪失・感情の暴走",
            reversedMeaningEn: "Self-Doubt, Lost Confidence, Emotional Turmoil",
            reversedAdvice: "自分を追い詰めないでください。弱さを認めることも強さです。",
            reversedAdviceEn: "Don't be too hard on yourself. Accepting weakness is also strength."
        ),
        TarotCard(
            number: 9,
            name: "隠者", nameEn: "The Hermit",
            symbolName: "flashlight.on.fill",
            uprightMeaning: "内省・探求・孤独な旅",
            uprightMeaningEn: "Introspection, Seeking, Solitary Journey",
            uprightAdvice: "一人の時間を大切にしましょう。静かな内省が答えを導きます。",
            uprightAdviceEn: "Value your time alone. Quiet reflection will guide you to answers.",
            reversedMeaning: "孤立・閉じこもり・頑なさ",
            reversedMeaningEn: "Isolation, Withdrawal, Stubbornness",
            reversedAdvice: "殻に閉じこもりすぎていませんか？時には人との繋がりも必要です。",
            reversedAdviceEn: "Are you shutting yourself away? Sometimes connection with others is needed."
        ),
        TarotCard(
            number: 10,
            name: "運命の輪", nameEn: "Wheel of Fortune",
            symbolName: "arrow.triangle.2.circlepath",
            uprightMeaning: "転機・運命の変化・チャンス到来",
            uprightMeaningEn: "Turning Point, Destiny's Change, Opportunity",
            uprightAdvice: "大きな変化の波が来ています。流れに身を任せ、チャンスを掴みましょう。",
            uprightAdviceEn: "A wave of change is coming. Go with the flow and seize the opportunity.",
            reversedMeaning: "停滞・悪循環・タイミングの悪さ",
            reversedMeaningEn: "Stagnation, Vicious Cycle, Bad Timing",
            reversedAdvice: "今は耐える時です。悪い流れは必ず変わります。焦らずに。",
            reversedAdviceEn: "Now is a time to endure. The tide will turn. Be patient."
        ),
        TarotCard(
            number: 11,
            name: "正義", nameEn: "Justice",
            symbolName: "scalemass.fill",
            uprightMeaning: "公正・バランス・真実",
            uprightMeaningEn: "Fairness, Balance, Truth",
            uprightAdvice: "正しいことを貫きましょう。誠実な行動が良い結果を生みます。",
            uprightAdviceEn: "Stand by what is right. Honest actions lead to good outcomes.",
            reversedMeaning: "不公平・偏り・判断ミス",
            reversedMeaningEn: "Unfairness, Bias, Poor Judgment",
            reversedAdvice: "客観的に状況を見直してみてください。バランスが崩れていませんか？",
            reversedAdviceEn: "Review the situation objectively. Is your balance off?"
        ),
        TarotCard(
            number: 12,
            name: "吊るされた男", nameEn: "The Hanged Man",
            symbolName: "arrow.down.circle.fill",
            uprightMeaning: "試練・忍耐・視点の転換",
            uprightMeaningEn: "Trial, Patience, Shift in Perspective",
            uprightAdvice: "今は動かない方が良い時です。視点を変えてみると、新しい発見があります。",
            uprightAdviceEn: "It's better not to act now. A new perspective will reveal new discoveries.",
            reversedMeaning: "無駄な犠牲・執着・停滞",
            reversedMeaningEn: "Needless Sacrifice, Attachment, Stagnation",
            reversedAdvice: "我慢し続ける必要はありません。手放す勇気も時には必要です。",
            reversedAdviceEn: "You don't need to keep enduring. Sometimes letting go takes courage."
        ),
        TarotCard(
            number: 13,
            name: "死神", nameEn: "Death",
            symbolName: "leaf.arrow.triangle.circlepath",
            uprightMeaning: "終わりと再生・変容・新たなスタート",
            uprightMeaningEn: "Ending and Rebirth, Transformation, New Start",
            uprightAdvice: "何かが終わる時は、新しい始まりのサインです。変化を恐れないで。",
            uprightAdviceEn: "When something ends, it's a sign of a new beginning. Don't fear change.",
            reversedMeaning: "変化への抵抗・停滞・執着",
            reversedMeaningEn: "Resistance to Change, Stagnation, Clinging",
            reversedAdvice: "過去にしがみついていませんか？手放すことで道が開けます。",
            reversedAdviceEn: "Are you clinging to the past? Letting go opens new paths."
        ),
        TarotCard(
            number: 14,
            name: "節制", nameEn: "Temperance",
            symbolName: "drop.halffull",
            uprightMeaning: "調和・バランス・節度・癒し",
            uprightMeaningEn: "Harmony, Balance, Moderation, Healing",
            uprightAdvice: "バランスを大切に。焦らず穏やかに進めることで、最良の結果が得られます。",
            uprightAdviceEn: "Value balance. Proceeding calmly and patiently brings the best results.",
            reversedMeaning: "不調和・過剰・アンバランス",
            reversedMeaningEn: "Disharmony, Excess, Imbalance",
            reversedAdvice: "やりすぎ、または不足していることはありませんか？中庸を心がけましょう。",
            reversedAdviceEn: "Are you overdoing or lacking something? Aim for moderation."
        ),
        TarotCard(
            number: 15,
            name: "悪魔", nameEn: "The Devil",
            symbolName: "flame.fill",
            uprightMeaning: "誘惑・束縛・執着・欲望",
            uprightMeaningEn: "Temptation, Bondage, Attachment, Desire",
            uprightAdvice: "自分を縛っているものに気づいてください。本当にそれは必要ですか？",
            uprightAdviceEn: "Notice what binds you. Do you truly need it?",
            reversedMeaning: "解放・覚醒・束縛からの脱出",
            reversedMeaningEn: "Liberation, Awakening, Breaking Free",
            reversedAdvice: "束縛から解放されるチャンスです。勇気を持って一歩を踏み出しましょう。",
            reversedAdviceEn: "A chance to break free. Take a courageous step forward."
        ),
        TarotCard(
            number: 16,
            name: "塔", nameEn: "The Tower",
            symbolName: "bolt.trianglebadge.exclamationmark.fill",
            uprightMeaning: "崩壊・衝撃・解放・真実の露見",
            uprightMeaningEn: "Collapse, Shock, Release, Truth Revealed",
            uprightAdvice: "予想外の出来事が起きても、それは再構築のチャンスです。真実を受け入れて。",
            uprightAdviceEn: "Even if the unexpected happens, it's a chance to rebuild. Accept the truth.",
            reversedMeaning: "回避・恐れ・小さな変化",
            reversedMeaningEn: "Avoidance, Fear, Small Changes",
            reversedAdvice: "変化を恐れて問題を先送りにしていませんか？小さな改善から始めましょう。",
            reversedAdviceEn: "Are you postponing problems out of fear? Start with small improvements."
        ),
        TarotCard(
            number: 17,
            name: "星", nameEn: "The Star",
            symbolName: "star.fill",
            uprightMeaning: "希望・インスピレーション・癒し",
            uprightMeaningEn: "Hope, Inspiration, Healing",
            uprightAdvice: "明るい未来が待っています。希望を持ち続けてください。夢は叶います。",
            uprightAdviceEn: "A bright future awaits. Keep your hopes alive. Dreams come true.",
            reversedMeaning: "失望・希望の喪失・不信",
            reversedMeaningEn: "Disappointment, Lost Hope, Distrust",
            reversedAdvice: "希望を見失っていませんか？小さな光を探してみてください。必ず見つかります。",
            reversedAdviceEn: "Have you lost hope? Look for a small light. You will surely find it."
        ),
        TarotCard(
            number: 18,
            name: "月", nameEn: "The Moon",
            symbolName: "moon.fill",
            uprightMeaning: "不安・幻想・潜在意識・夢",
            uprightMeaningEn: "Anxiety, Illusion, Subconscious, Dreams",
            uprightAdvice: "不安な気持ちは自然なことです。直感を信じて、霧が晴れるのを待ちましょう。",
            uprightAdviceEn: "Feeling anxious is natural. Trust your intuition and wait for the fog to clear.",
            reversedMeaning: "混乱の解消・真実の発覚・回復",
            reversedMeaningEn: "Clarity, Truth Revealed, Recovery",
            reversedAdvice: "モヤモヤが晴れ始めています。真実が見えてくるでしょう。",
            reversedAdviceEn: "The haze is beginning to clear. The truth will become visible."
        ),
        TarotCard(
            number: 19,
            name: "太陽", nameEn: "The Sun",
            symbolName: "sun.max.fill",
            uprightMeaning: "成功・喜び・活力・明快さ",
            uprightMeaningEn: "Success, Joy, Vitality, Clarity",
            uprightAdvice: "最高の運勢です！自信を持って楽しんでください。あなたは輝いています。",
            uprightAdviceEn: "The best fortune! Enjoy yourself with confidence. You are shining.",
            reversedMeaning: "自信過剰・延期・小さな成功",
            reversedMeaningEn: "Overconfidence, Delay, Small Success",
            reversedAdvice: "うまくいっていても謙虚さを忘れずに。周囲への感謝を大切にしましょう。",
            reversedAdviceEn: "Even when things go well, stay humble. Cherish gratitude for those around you."
        ),
        TarotCard(
            number: 20,
            name: "審判", nameEn: "Judgement",
            symbolName: "bell.badge.fill",
            uprightMeaning: "復活・目覚め・決断の時",
            uprightMeaningEn: "Revival, Awakening, Time for Decision",
            uprightAdvice: "過去を振り返り、新しい自分として生まれ変わる時です。大きな決断を。",
            uprightAdviceEn: "Look back on the past and be reborn as a new you. Make a big decision.",
            reversedMeaning: "後悔・優柔不断・自己否定",
            reversedMeaningEn: "Regret, Indecision, Self-Denial",
            reversedAdvice: "過去の失敗を引きずらないでください。全ては学びです。前を向いて。",
            reversedAdviceEn: "Don't dwell on past failures. Everything is a lesson. Look forward."
        ),
        TarotCard(
            number: 21,
            name: "世界", nameEn: "The World",
            symbolName: "globe.asia.australia.fill",
            uprightMeaning: "完成・達成・統合・旅の終わり",
            uprightMeaningEn: "Completion, Achievement, Integration, Journey's End",
            uprightAdvice: "一つのサイクルが完了します。達成を祝い、次のステージへ進みましょう。",
            uprightAdviceEn: "A cycle is complete. Celebrate your achievement and move to the next stage.",
            reversedMeaning: "未完成・中途半端・やり残し",
            reversedMeaningEn: "Incomplete, Half-Finished, Unfinished Business",
            reversedAdvice: "まだやり残していることはありませんか？完了させてから次に進みましょう。",
            reversedAdviceEn: "Is there something left unfinished? Complete it before moving on."
        ),
    ]

    static func drawRandomCard() -> (card: TarotCard, isUpright: Bool) {
        let card = majorArcana.randomElement()!
        let isUpright = Bool.random()
        return (card, isUpright)
    }
}
