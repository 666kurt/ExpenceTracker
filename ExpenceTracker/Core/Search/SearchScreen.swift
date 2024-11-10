import SwiftUI
import Combine

struct SearchScreen: View {
    
    /// View props
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                }
            }
            .overlay {
                ContentUnavailableView("Search transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            }
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .onChange(of: searchText) { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            }
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)) { text in
                filterText = text
            }
        }
    }
}

#Preview {
    SearchScreen()
}
