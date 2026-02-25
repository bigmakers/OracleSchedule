import SwiftUI
import PhotosUI

struct DiaryPhotoPickerView: View {
    @Binding var photos: [Data]
    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 5,
            matching: .images
        ) {
            Label(L10n.addPhotos, systemImage: "photo.badge.plus")
                .font(.caption)
                .foregroundStyle(.purple)
        }
        .onChange(of: selectedItems) { _, newItems in
            Task {
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data),
                       let compressed = uiImage.jpegData(compressionQuality: 0.7) {
                        photos.append(compressed)
                    }
                }
                selectedItems.removeAll()
            }
        }
    }
}
