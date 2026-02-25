import SwiftUI

struct TaskTarotResultView: View {
    let reading: TaskTarotReading

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // カード結果アイコン
                Circle()
                    .fill(reading.isUpright ? .green.opacity(0.15) : .orange.opacity(0.15))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: reading.isUpright ? "arrow.up" : "arrow.down")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(reading.isUpright ? .green : .orange)
                    )

                // カード名
                Text(reading.cardName)
                    .font(.title3)
                    .fontWeight(.bold)

                // 位置
                Text(reading.isUpright ? L10n.upright : L10n.reversed)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(reading.isUpright ? .green : .orange)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(
                                (reading.isUpright ? Color.green : Color.orange)
                                    .opacity(0.15)
                            )
                    )

                // アドバイス
                Text(reading.adviceText)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                // 占い日時
                Text(reading.date.fullDateTimeString)
                    .font(.caption)
                    .foregroundStyle(.tertiary)

                Spacer()
            }
            .padding(.top, 32)
            .navigationTitle(L10n.oracleResult)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
