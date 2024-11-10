import SwiftUI

struct SettingsScreen: View {
    @AppStorage("userName") private var userName: String = ""
    var body: some View {
        NavigationStack {
            List {
                Section("User name") {
                    TextField("Enter you name", text: $userName)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
