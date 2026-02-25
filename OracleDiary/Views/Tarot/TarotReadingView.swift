import SwiftUI
import SwiftData

struct TarotReadingView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var phase: ReadingPhase = .idle
    @State private var drawnCard: TarotCard?
    @State private var isUpright: Bool = true
    @State private var isFlipped: Bool = false
    @State private var flipDegrees: Double = 0
    @State private var showAddTodoSheet: Bool = false

    enum ReadingPhase {
        case idle       // 初期画面
        case cardReady  // カードが裏向きで出現済み
        case revealed   // カードがめくられた
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // 背景グラデーション
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.05, blue: 0.15),
                        Color(red: 0.15, green: 0.08, blue: 0.25)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    if phase == .idle || phase == .cardReady {
                        // 占う前: カード中央 + ボタン下固定
                        Spacer()

                        switch phase {
                        case .idle:
                            idleView
                        case .cardReady:
                            cardView
                        default:
                            EmptyView()
                        }

                        Spacer()

                        actionButton
                            .padding(.horizontal, 24)
                            .padding(.bottom, 24)
                    } else {
                        // 結果表示: スクロール可能
                        ScrollView {
                            VStack(spacing: 20) {
                                cardView
                                    .padding(.top, 12)

                                resultView

                                actionButton
                                    .padding(.horizontal, 24)

                                addTodoPrompt
                                    .padding(.bottom, 24)
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .navigationTitle(L10n.oneOracle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.08, green: 0.05, blue: 0.15), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Idle View

    private var idleView: some View {
        VStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundStyle(.yellow.opacity(0.8))

            Text(L10n.calmAndDraw)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Card View

    private var cardView: some View {
        ZStack {
            // カードの裏面
            CardBackView()
                .opacity(isFlipped ? 0 : 1)

            // カードの表面
            if let card = drawnCard {
                CardFrontView(card: card, isUpright: isUpright)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity(isFlipped ? 1 : 0)
            }
        }
        .frame(width: 220, height: 340)
        .rotation3DEffect(
            .degrees(flipDegrees),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
        .onTapGesture {
            if phase == .cardReady {
                flipCard()
            }
        }
        .transition(.scale.combined(with: .opacity))
    }

    // MARK: - Result View

    private var resultView: some View {
        VStack(spacing: 8) {
            if let card = drawnCard {
                Text(isUpright ? L10n.upright : L10n.reversed)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(isUpright ? .green : .orange)

                Text(isUpright ? card.localizedUprightMeaning : card.localizedReversedMeaning)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))

                Text(isUpright ? card.localizedUprightAdvice : card.localizedReversedAdvice)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
        }
        .padding(.horizontal, 16)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }

    // MARK: - TODO追加誘導

    private var addTodoPrompt: some View {
        Button {
            showAddTodoSheet = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "checklist")
                    .font(.subheadline)
                Text(L10n.addTodoPrompt)
                    .font(.subheadline)
                Image(systemName: "chevron.right")
                    .font(.caption2)
            }
            .foregroundStyle(.white.opacity(0.8))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(.white.opacity(0.1))
                    .overlay(
                        Capsule()
                            .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .sheet(isPresented: $showAddTodoSheet) {
            AddTodoSheet()
        }
    }

    // MARK: - Action Button

    private var actionButton: some View {
        Button {
            switch phase {
            case .idle:
                drawCard()
            case .cardReady:
                flipCard()
            case .revealed:
                resetReading()
            }
        } label: {
            Text(buttonTitle)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [.purple, .indigo],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
        }
    }

    private var buttonTitle: String {
        switch phase {
        case .idle: return L10n.divine
        case .cardReady: return L10n.tapToFlip
        case .revealed: return L10n.divineAgain
        }
    }

    // MARK: - Actions

    private func drawCard() {
        let result = TarotDeck.drawRandomCard()
        drawnCard = result.card
        isUpright = result.isUpright
        isFlipped = false
        flipDegrees = 0

        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            phase = .cardReady
        }

        // 軽いHaptic
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }

    private func flipCard() {
        let impact = UIImpactFeedbackGenerator(style: .light)

        // 前半: 0° → 90°
        withAnimation(.easeIn(duration: 0.3)) {
            flipDegrees = 90
        }

        // 90°の時点でコンテンツを切り替え
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isFlipped = true
            impact.impactOccurred()

            // 後半: 90° → 180°
            withAnimation(.easeOut(duration: 0.3)) {
                flipDegrees = 180
            }
        }

        // アニメーション完了後に結果表示と保存
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            withAnimation(.easeInOut(duration: 0.4)) {
                phase = .revealed
            }
            saveReading()

            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
        }
    }

    private func resetReading() {
        withAnimation(.easeInOut(duration: 0.3)) {
            phase = .idle
            isFlipped = false
            flipDegrees = 0
            drawnCard = nil
        }
    }

    private func saveReading() {
        guard let card = drawnCard else { return }

        let advice = isUpright ? card.localizedUprightAdvice : card.localizedReversedAdvice
        let positionSuffix = isUpright ? L10n.uprightSuffix : L10n.reversedSuffix

        let reading = TarotReading(
            date: .now,
            cardName: "\(card.localizedName) \(positionSuffix)",
            adviceText: advice,
            isUpright: isUpright
        )
        modelContext.insert(reading)
    }
}

// MARK: - Card Back View

struct CardBackView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.3, green: 0.1, blue: 0.5),
                        Color(red: 0.1, green: 0.05, blue: 0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        LinearGradient(
                            colors: [.yellow.opacity(0.6), .purple.opacity(0.4)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .overlay(
                VStack(spacing: 12) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.yellow.opacity(0.7))

                    Text("TAP")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(4)
                }
            )
            .shadow(color: .purple.opacity(0.4), radius: 12, x: 0, y: 4)
    }
}

// MARK: - Card Front View

struct CardFrontView: View {
    let card: TarotCard
    let isUpright: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.93, blue: 0.88),
                        Color(red: 0.88, green: 0.85, blue: 0.78)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        LinearGradient(
                            colors: [.yellow.opacity(0.8), .orange.opacity(0.4)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .overlay(
                VStack(spacing: 12) {
                    Text(romanNumeral(for: card.number))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    Image(systemName: card.symbolName)
                        .font(.system(size: 50))
                        .foregroundStyle(.purple)
                        .rotationEffect(isUpright ? .zero : .degrees(180))

                    Text(card.localizedName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)

                    Text(isUpright ? L10n.upright : L10n.reversed)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isUpright ? .green : .orange)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(
                                    (isUpright ? Color.green : Color.orange)
                                        .opacity(0.15)
                                )
                        )
                }
            )
            .shadow(color: .orange.opacity(0.3), radius: 12, x: 0, y: 4)
    }

    private func romanNumeral(for number: Int) -> String {
        let numerals = [
            "0", "I", "II", "III", "IV", "V", "VI", "VII",
            "VIII", "IX", "X", "XI", "XII", "XIII", "XIV",
            "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI"
        ]
        guard number >= 0 && number < numerals.count else { return "" }
        return numerals[number]
    }
}

#Preview {
    TarotReadingView()
        .modelContainer(for: TarotReading.self, inMemory: true)
}
