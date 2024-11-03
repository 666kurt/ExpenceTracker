import SwiftUI

struct RecentScreen: View {
    
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        GeometryReader {
            /// For animation
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
            }
        }
        
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Welcome")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .visualEffect { content, proxy in
                content
                    .scaleEffect(headerScale(size, proxy: proxy), anchor: .topLeading)
            }
            
            Spacer()
            
            NavigationLink {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(.tint, in: .circle)

            }
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .visualEffect{ content, proxy in
                content
                    .opacity(headerOpacity(proxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
}

// Drag header animation
extension RecentScreen {
    
    /// Header scale animation
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.4
        
        return 1 + scale
    }

    /// Header opacity animation
    func headerOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
}


#Preview {
    EntryView()
}
