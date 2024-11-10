import SwiftUI

@main
struct ExpenceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
