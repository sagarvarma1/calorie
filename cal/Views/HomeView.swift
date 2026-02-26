import SwiftUI
import SwiftData

private let brown = Color(red: 0.40, green: 0.26, blue: 0.13)

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: HomeViewModel?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text("Weekly Macronutrients")
                    .font(.custom("Georgia", size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(brown)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                Text("Cal: \(viewModel?.weeklyCalories ?? 0)")
                    .font(.custom("Georgia", size: 36))
                    .fontWeight(.bold)
                    .foregroundStyle(brown)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.96, green: 0.90, blue: 0.78))
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                Spacer()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = HomeViewModel(modelContext: modelContext)
            }
            viewModel?.fetchWeeklyCalories()
        }
    }
}
