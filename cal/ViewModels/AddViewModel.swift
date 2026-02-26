import Foundation
import SwiftData

@Observable
final class AddViewModel {
    private var modelContext: ModelContext

    var name: String = ""
    var calories: String = ""
    var protein: String = ""
    var carbs: String = ""
    var fat: String = ""
    var fiber: String = ""

    var canSave: Bool {
        !name.isEmpty && Int(calories) != nil
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func save() {
        let entry = FoodEntry(
            name: name,
            calories: Int(calories) ?? 0,
            protein: Double(protein) ?? 0,
            carbs: Double(carbs) ?? 0,
            fat: Double(fat) ?? 0,
            fiber: Double(fiber) ?? 0
        )
        modelContext.insert(entry)
        clearForm()
    }

    private func clearForm() {
        name = ""
        calories = ""
        protein = ""
        carbs = ""
        fat = ""
        fiber = ""
    }
}
