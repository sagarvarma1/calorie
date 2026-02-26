import SwiftUI
import SwiftData

private let brown = Color(red: 0.40, green: 0.26, blue: 0.13)
private let tan = Color(red: 0.96, green: 0.90, blue: 0.78)

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
                            .fill(tan)
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    macroCard(label: "Protein", value: viewModel?.weeklyProtein ?? 0, color: Color(red: 0.85, green: 0.93, blue: 0.87))
                    macroCard(label: "Carbs", value: viewModel?.weeklyCarbs ?? 0, color: Color(red: 0.85, green: 0.90, blue: 0.95))
                    macroCard(label: "Fat", value: viewModel?.weeklyFat ?? 0, color: Color(red: 0.96, green: 0.88, blue: 0.83))
                    macroCard(label: "Alcohol", value: viewModel?.weeklyAlcohol ?? 0, color: Color(red: 0.93, green: 0.85, blue: 0.93))
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Spacer()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = HomeViewModel(modelContext: modelContext)
            }
            viewModel?.fetchWeeklyData()
        }
    }

    private func macroCard(label: String, value: Double, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("Georgia", size: 16))
                .foregroundStyle(brown.opacity(0.7))
            Text("\(String(format: "%.1f", value))g")
                .font(.custom("Georgia", size: 28))
                .fontWeight(.bold)
                .foregroundStyle(brown)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .aspectRatio(1, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        )
    }
}
