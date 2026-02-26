import SwiftUI
import SwiftData

@main
struct calApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FoodEntry.self)
    }
}
