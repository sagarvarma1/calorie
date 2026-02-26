import Foundation
import SwiftData

@Model
final class FoodEntry {
    var name: String
    var calories: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    var fiber: Double
    var date: Date

    init(name: String, calories: Int, protein: Double, carbs: Double, fat: Double, fiber: Double = 0, date: Date = .now) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.fiber = fiber
        self.date = date
    }
}
