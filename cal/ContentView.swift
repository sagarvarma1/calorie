import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            AddView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }

            DailyView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily")
                }
        }
    }
}

#Preview {
    ContentView()
}
