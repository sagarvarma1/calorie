import Foundation
import SwiftData

@Observable
final class DailyViewModel {
    private var modelContext: ModelContext

    var entries: [FoodEntry] = []
    var selectedDate: Date = .now {
        didSet { fetchEntries() }
    }

    var totalCalories: Int {
        entries.reduce(0) { $0 + $1.calories }
    }

    var totalProtein: Double {
        entries.reduce(0) { $0 + $1.protein }
    }

    var totalCarbs: Double {
        entries.reduce(0) { $0 + $1.carbs }
    }

    var totalFat: Double {
        entries.reduce(0) { $0 + $1.fat }
    }

    var totalFiber: Double {
        entries.reduce(0) { $0 + $1.fiber }
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchEntries()
    }

    func fetchEntries() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }

        let descriptor = FetchDescriptor<FoodEntry>(
            predicate: #Predicate { entry in
                entry.date >= startOfDay && entry.date < endOfDay
            },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        do {
            entries = try modelContext.fetch(descriptor)
        } catch {
            entries = []
        }
    }

    func delete(_ entry: FoodEntry) {
        modelContext.delete(entry)
        fetchEntries()
    }
}
