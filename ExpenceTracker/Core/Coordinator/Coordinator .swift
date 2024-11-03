//
//  Coordinator .swift
//  ExpenceTracker
//
//  Created by Максим Шишлов on 03.11.2024.
//

import Foundation
import SwiftUI

enum Screens: String {
    case recents = "Recents"
    case search = "Filter"
    case charts = "Chats"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    }
}

final class Coordinator: ObservableObject {
    
    static let shared = Coordinator()
    private init() {}
    
    @Published var selectedScreen: Screens = .recents
    
}
