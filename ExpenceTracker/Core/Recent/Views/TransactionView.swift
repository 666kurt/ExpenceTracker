import SwiftUI

struct TransactionView: View {
    /// Enviroment props
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var editTranstacion: Transaction?
    /// View props
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    
    /// Random tint color
    @State var tint: TintColor = tints.randomElement()!
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                /// Preview transaction card view
                TransactionRowView(transaction: .init(title: title.isEmpty ? "Title" : title,
                                                      remarks: remarks.isEmpty ? "Remarks" : remarks,
                                                      amount: amount,
                                                      dateAdded: dateAdded,
                                                      category: category,
                                                      tintColor: tint))
                
                CustomSection("Title", "Magic Keyboard", value: $title)
                
                CustomSection("Remarks", "Apple product!", value: $remarks)
                
                /// Amout and category checkbox
                VStack(alignment: .leading, spacing: 10) {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        HStack {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
          
                        
                        CategoryCheckBox()
                    }
                }
                
                /// Date picker
                VStack(alignment: .leading, spacing: 10) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                }
                
        
            }
            .padding(15)
        }
        .navigationTitle("\(editTranstacion == nil ? "Add" : "Edit") Transactions")
        .background(.gray.opacity(0.15))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        }
        .onAppear {
            if let editTranstacion {
                title = editTranstacion.title
                remarks = editTranstacion.remarks
                dateAdded = editTranstacion.dateAdded
                if let category = editTranstacion.rawCategory {
                    self.category = category
                }
                amount = editTranstacion.amount
                if let tint = editTranstacion.tint {
                    self.tint = tint
                }
            }
        }
    }
    
    /// Saving data to swiftdata
    func save() {
        if editTranstacion != nil {
            editTranstacion?.title = title
            editTranstacion?.remarks = remarks
            editTranstacion?.amount = amount
            editTranstacion?.dateAdded = dateAdded
            editTranstacion?.category = category.rawValue
        } else {
            let transaction = Transaction(title: title,
                                          remarks: remarks,
                                          amount: amount,
                                          dateAdded: dateAdded,
                                          category: category,
                                          tintColor: tint)
            context.insert(transaction)
        }
        dismiss()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        }
    }
    
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(.accent)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(.accent)
                        }
                    }
                    
                    Text(category.rawValue)
                        .font(.caption)
                }
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

#Preview {
    NavigationStack {
        TransactionView()
    }
}
