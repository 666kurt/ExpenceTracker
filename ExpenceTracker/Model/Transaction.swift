import Foundation
import SwiftUI

struct Transaction: Identifiable {
    let id: UUID = .init()
    /// Props
    var title: String
    var remarks: String
    var amount: String
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: String, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    /// Extracting color value from tintColor string
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? Color(.tintColor)
    }
}
