import SwiftUI
import SwiftData

struct DailyView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: DailyViewModel?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    DatePicker("Date", selection: dateBinding, displayedComponents: .date)
                }

                Section("Summary") {
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text("\(viewModel?.totalCalories ?? 0)")
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("Protein")
                        Spacer()
                        Text("\(String(format: "%.1f", viewModel?.totalProtein ?? 0))g")
                    }
                    HStack {
                        Text("Carbs")
                        Spacer()
                        Text("\(String(format: "%.1f", viewModel?.totalCarbs ?? 0))g")
                    }
                    HStack {
                        Text("Fat")
                        Spacer()
                        Text("\(String(format: "%.1f", viewModel?.totalFat ?? 0))g")
                    }
                    HStack {
                        Text("Alcohol")
                        Spacer()
                        Text("\(String(format: "%.1f", viewModel?.totalAlcohol ?? 0))g")
                    }
                }

                Section("Entries") {
                    if let entries = viewModel?.entries, !entries.isEmpty {
                        ForEach(entries) { entry in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.name)
                                    .fontWeight(.medium)
                                Text("\(entry.calories) cal  \u{2022}  P: \(String(format: "%.1f", entry.protein))g  C: \(String(format: "%.1f", entry.carbs))g  F: \(String(format: "%.1f", entry.fat))g  A: \(String(format: "%.1f", entry.alcohol))g")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if let entry = viewModel?.entries[index] {
                                    viewModel?.delete(entry)
                                }
                            }
                        }
                    } else {
                        Text("No entries for this day")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Daily")
        }
        .onAppear {
            if viewModel == nil {
                viewModel = DailyViewModel(modelContext: modelContext)
            }
            viewModel?.fetchEntries()
        }
    }

    private var dateBinding: Binding<Date> {
        Binding(
            get: { viewModel?.selectedDate ?? .now },
            set: { viewModel?.selectedDate = $0 }
        )
    }
}
