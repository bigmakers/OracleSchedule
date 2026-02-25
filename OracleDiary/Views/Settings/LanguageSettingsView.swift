import SwiftUI

struct LanguageSettingsView: View {
    @AppStorage("app_language") private var language = "ja"

    var body: some View {
        Form {
            Section(L10n.displayLanguage) {
                Picker(L10n.languageTitle, selection: $language) {
                    Text(L10n.japanese).tag("ja")
                    Text("English").tag("en")
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }

            Section {
                Text(L10n.languageDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(L10n.languageTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
