import SwiftUI

struct EntryView: View {
    
    @AppStorage("isFirstTime") var isFirstTime: Bool = true
    @StateObject var coordinator = Coordinator.shared
    
    var body: some View {
        TabView(selection: $coordinator.selectedScreen) {
            
            RecentScreen()
                .tag(Screens.recents)
                .tabItem { Screens.recents.tabContent }
            
            SearchScreen()
                .tag(Screens.search)
                .tabItem { Screens.search.tabContent }
            
            ChartScreen()
                .tag(Screens.charts)
                .tabItem { Screens.charts.tabContent }
            
            SettingsScreen()
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
