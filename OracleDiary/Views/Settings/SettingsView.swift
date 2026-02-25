import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(L10n.general) {
                    NavigationLink {
                        LanguageSettingsView()
                    } label: {
                        Label(L10n.languageSetting, systemImage: "globe")
                    }
                }

                Section {
                    HStack {
                        Text(L10n.version)
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(L10n.settingsTitle)
        }
    }
}
