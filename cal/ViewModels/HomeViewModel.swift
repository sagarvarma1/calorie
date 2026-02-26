import Foundation
import SwiftData

@Observable
final class HomeViewModel {
    private var modelContext: ModelContext

    var weeklyCalories: Int = 0

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchWeeklyCalories()
    }

    func fetchWeeklyCalories() {
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
        } catch {
            weeklyCalories = 0
        }
    }
}
