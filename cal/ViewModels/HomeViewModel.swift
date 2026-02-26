import Foundation
import SwiftData

@Observable
final class HomeViewModel {
    private var modelContext: ModelContext

    var weeklyCalories: Int = 0
    var weeklyProtein: Double = 0
    var weeklyCarbs: Double = 0
    var weeklyFat: Double = 0
    var weeklyFiber: Double = 0

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchWeeklyData()
    }

    func fetchWeeklyData() {
        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return
        }

        let descriptor = FetchDescriptor<FoodEntry>(
            predicate: #Predicate { entry in
                entry.date >= startOfWeek
            }
        )

        do {
            let entries = try modelContext.fetch(descriptor)
            weeklyCalories = entries.reduce(0) { $0 + $1.calories }
            weeklyProtein = entries.reduce(0) { $0 + $1.protein }
            weeklyCarbs = entries.reduce(0) { $0 + $1.carbs }
            weeklyFat = entries.reduce(0) { $0 + $1.fat }
            weeklyFiber = entries.reduce(0) { $0 + $1.fiber }
        } catch {
            weeklyCalories = 0
            weeklyProtein = 0
            weeklyCarbs = 0
            weeklyFat = 0
            weeklyFiber = 0
        }
    }
}
