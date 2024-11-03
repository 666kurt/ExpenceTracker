import SwiftUI

struct IntroScreen: View {
    
    @AppStorage("isFirstTime") var isFirstTime: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            Text("What's New in the\nExpence Tracker")
                .multilineTextAlignment(.center)
                .font(.largeTitle.bold())
                .padding(.top, 65)
                .padding(.bottom, 45)
            
            VStack(alignment: .leading, spacing: 25) {
                PointView(symbol: "dollarsign",
                          title: "Transition",
                          subtitle: "Keep track of your earnings and expenses")
                
                PointView(symbol: "chart.bar.fill",
                          title: "Visual Chart",
                          subtitle: "View your transactions using eye-catching graphic representations.")
                
                PointView(symbol: "magnifyingglass",
                          title: "Advance Filters",
                          subtitle: "Find the expenses you want by advance search and filtering.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            
            Spacer()
            
            Button {
                isFirstTime = false
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 14)
                    .background(.tint)
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding(15)
    }
    
    /// Points View
    @ViewBuilder
    func PointView(symbol: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.tint)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    IntroScreen()
}
