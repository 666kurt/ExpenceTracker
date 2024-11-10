import SwiftUI
import SwiftData

struct RecentScreen: View {
    
    /// User props
    @AppStorage("userName") private var userName: String = ""
    
    /// View props
    @State private var startOfMonth: Date = .now.startOfMonth
    @State private var endOfMonth: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .income
    @State private var showFilterView: Bool = false
    
    /// Props for animation
    @Namespace private var animation
    
    /// SwiftData props
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    
    var body: some View {
        GeometryReader {
            /// For animation
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            /// Date filter button
                            Button {
                                showFilterView = true
                            } label: {
                                Text("\(format(date: startOfMonth, format: "dd MMM yy")) - \(format(date: endOfMonth, format: "dd MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                            }
                            .hSpacing(.leading)
                            
                            /// Card View
                            RecentCardView(income: 3254, expense: 1234)
                            
                            SegmentedControl()
                            
                            ForEach(transactions) { transaction in
                                NavigationLink {
                                    NewExpenceView(editTranstacion: transaction)
                                } label: {
                                    TransactionRowView(transaction: transaction)
                                }
                                .buttonStyle(.plain)
                            }
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startOfMonth, end: endOfMonth) { start, end in
                        startOfMonth = start
                        endOfMonth = end
                        showFilterView = false
                    } onClose: {
                        showFilterView = false
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
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
                NewExpenceView()
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
    
    @ViewBuilder
    func SegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if selectedCategory == category {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
        .padding(.bottom, 10)
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
