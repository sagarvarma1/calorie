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

                GeometryReader { geo in
                    let spacing: CGFloat = 16
                    let padding: CGFloat = 20
                    let cardSize = (geo.size.width - spacing - padding * 2) / 2

                    LazyVGrid(columns: [GridItem(.fixed(cardSize)), GridItem(.fixed(cardSize))], spacing: spacing) {
                        macroCard(label: "Protein", value: viewModel?.weeklyProtein ?? 0, color: Color(red: 0.85, green: 0.93, blue: 0.87), size: cardSize)
                        macroCard(label: "Carbs", value: viewModel?.weeklyCarbs ?? 0, color: Color(red: 0.85, green: 0.90, blue: 0.95), size: cardSize)
                        macroCard(label: "Fat", value: viewModel?.weeklyFat ?? 0, color: Color(red: 0.96, green: 0.88, blue: 0.83), size: cardSize)
                        macroCard(label: "Fiber", value: viewModel?.weeklyFiber ?? 0, color: Color(red: 0.93, green: 0.85, blue: 0.93), size: cardSize)
                    }
                    .padding(.horizontal, padding)
                }
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

    private func macroCard(label: String, value: Double, color: Color, size: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("Georgia", size: 16))
                .foregroundStyle(brown.opacity(0.7))
            Spacer()
            Text("\(String(format: "%.1f", value))g")
                .font(.custom("Georgia", size: 28))
                .fontWeight(.bold)
                .foregroundStyle(brown)
        }
        .padding(16)
        .frame(width: size, height: size, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        )
    }
}
