import SwiftUI

struct TransactionRowView: View {
    
    let transaction: Transaction
    var showsCategory: Bool = false
    @Environment(\.modelContext) private var context
    
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text(transaction.title.prefix(1))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.title)
                        .foregroundStyle(.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    if showsCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient,
                                        in: .capsule)
                    }
                        
                }
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyFormatter(transaction.amount, digits: 2))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
            }
        }
    }
}

#Preview {
    TransactionRowView(transaction: sampleTransaction[0])
}
