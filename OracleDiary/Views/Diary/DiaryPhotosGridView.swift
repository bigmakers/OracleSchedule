import SwiftUI

struct DiaryPhotosGridView: View {
    @Binding var photos: [Data]
    let isEditing: Bool
    @State private var selectedPhotoIndex: Int?

    var body: some View {
        if !photos.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(photos.enumerated()), id: \.offset) { index, photoData in
                        if let uiImage = UIImage(data: photoData) {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        selectedPhotoIndex = index
                                    }

                                // 編集モード時に削除ボタン
                                if isEditing {
                                    Button {
                                        withAnimation {
                                            if index < photos.count {
                                                photos.remove(at: index)
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .background(Circle().fill(.black.opacity(0.6)))
                                    }
                                    .offset(x: 4, y: -4)
                                }
                            }
                        }
                    }
                }
            }
            .fullScreenCover(item: $selectedPhotoIndex) { index in
                PhotoFullScreenView(photoData: photos[index]) {
                    selectedPhotoIndex = nil
                }
            }
        }
    }
}

extension Int: @retroactive Identifiable {
    public var id: Int { self }
}

// MARK: - Full Screen Photo View

struct PhotoFullScreenView: View {
    let photoData: Data
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        onDismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.8))
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}
