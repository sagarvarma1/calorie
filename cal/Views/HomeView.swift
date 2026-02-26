import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: HomeViewModel?

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.90, blue: 0.78)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Calories eaten this week")
                    .font(.custom("Georgia", size: 20))
                    .foregroundStyle(.secondary)

                Text("\(viewModel?.weeklyCalories ?? 0)")
                    .font(.custom("Georgia", size: 64))
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
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
