import SwiftUI
import SwiftData

struct TaskTarotReadingView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: TaskItem

    @State private var phase: Phase = .ready
    @State private var drawnCard: TarotCard?
    @State private var isUpright: Bool = true
    @State private var isFlipped: Bool = false
    @State private var flipDegrees: Double = 0

    enum Phase {
        case ready
        case revealed
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.05, blue: 0.15),
                        Color(red: 0.15, green: 0.08, blue: 0.25)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    // タスク名表示
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 8)

                    Text(L10n.divineTaskFortune)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))

                    Spacer()

                    // カード
                    cardView

                    Spacer()

                    // 結果テキスト
                    if phase == .revealed, let card = drawnCard {
                        resultView(card: card)
                    }

                    // ボタン
                    if phase == .revealed {
                        Button {
                            dismiss()
                        } label: {
                            Text(L10n.close)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(.purple)
                                )
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.cancel) { dismiss() }
                        .foregroundStyle(.white.opacity(0.7))
                }
            }
            .onAppear {
                drawCard()
            }
        }
    }

    // MARK: - Card View

    private var cardView: some View {
        ZStack {
            CardBackView()
                .opacity(isFlipped ? 0 : 1)

            if let card = drawnCard {
                CardFrontView(card: card, isUpright: isUpright)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFlipped ? 1 : 0)
            }
        }
        .frame(width: 180, height: 280)
        .rotation3DEffect(
            .degrees(flipDegrees),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
        .onTapGesture {
            if phase == .ready {
                flipCard()
            }
        }
    }

    // MARK: - Result

    private func resultView(card: TarotCard) -> some View {
        VStack(spacing: 6) {
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
                .padding(.horizontal, 24)
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }

    // MARK: - Actions

    private func drawCard() {
        let result = TarotDeck.drawRandomCard()
        drawnCard = result.card
        isUpright = result.isUpright

        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }

    private func flipCard() {
        let impact = UIImpactFeedbackGenerator(style: .light)

        withAnimation(.easeIn(duration: 0.3)) {
            flipDegrees = 90
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isFlipped = true
            impact.impactOccurred()

            withAnimation(.easeOut(duration: 0.3)) {
                flipDegrees = 180
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            withAnimation(.easeInOut(duration: 0.4)) {
                phase = .revealed
            }
            saveReading()

            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
        }
    }

    private func saveReading() {
        guard let card = drawnCard else { return }

        let advice = isUpright ? card.localizedUprightAdvice : card.localizedReversedAdvice
        let positionSuffix = isUpright ? L10n.uprightSuffix : L10n.reversedSuffix

        let reading = TaskTarotReading(
            date: .now,
            cardName: "\(card.localizedName) \(positionSuffix)",
            adviceText: advice,
            isUpright: isUpright
        )
        task.tarotReading = reading
    }
}
