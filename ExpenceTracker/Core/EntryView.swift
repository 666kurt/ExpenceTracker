//
//  ContentView.swift
//  ExpenceTracker
//
//  Created by Максим Шишлов on 03.11.2024.
//

import SwiftUI

struct EntryView: View {
    
    @AppStorage("isFirstTime") var isFirstTime: Bool = true
    @StateObject var coordinator = Coordinator.shared
    
    var body: some View {
        TabView(selection: $coordinator.selectedScreen) {
            
            Text("Recent")
                .tag(Screens.recents)
                .tabItem { Screens.recents.tabContent }
            
            Text("Search")
                .tag(Screens.search)
                .tabItem { Screens.search.tabContent }
            
            Text("Chart")
                .tag(Screens.charts)
                .tabItem { Screens.charts.tabContent }
            
            Text("Settings")
                .tag(Screens.settings)
                .tabItem { Screens.settings.tabContent }
            
        }
        .sheet(isPresented: $isFirstTime) {
            IntroScreen()
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    EntryView()
}
