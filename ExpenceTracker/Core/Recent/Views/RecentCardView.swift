import SwiftUI

struct RecentCardView: View {
    
    /// View props
    let income: Double
    let expense: Double
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text(currencyFormatter(income - expense))
                        .font(.title.bold())
                    
                    Image(systemName: expense > income
                          ? "chart.line.downtrend.xyaxis"
                          : "chart.line.uptrend.xyaxis")
                    .font(.title3)
                    .foregroundStyle(expense > income ? .red : .green)
                }
                .padding(.bottom, 25)
                
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let tintColor = category == .income ? Color.green : Color.red
                        
                        HStack(spacing: 10) {
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                                .foregroundStyle(tintColor)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tintColor.opacity(0.25).gradient)
                                }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text(currencyFormatter(category == .income
                                                       ? income
                                                       : expense,
                                                       digits: 0))
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            }
                            
                            /// Spacer between both category (because foreach)
                            if category == .income {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }
        
    }
}

#Preview {
    ScrollView {
        RecentCardView(income: 4125, expense: 1234)
    }
}
