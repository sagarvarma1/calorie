import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: AddViewModel?

    var body: some View {
        NavigationStack {
            Form {
                Section("Food") {
                    TextField("Name", text: binding(\.name))
                }

                Section("Calories") {
                    TextField("Calories", text: binding(\.calories))
                        .keyboardType(.numberPad)
                }

                Section("Macros (grams)") {
                    TextField("Protein", text: binding(\.protein))
                        .keyboardType(.decimalPad)
                    TextField("Carbs", text: binding(\.carbs))
                        .keyboardType(.decimalPad)
                    TextField("Fat", text: binding(\.fat))
                        .keyboardType(.decimalPad)
                    TextField("Fiber", text: binding(\.fiber))
                        .keyboardType(.decimalPad)
                }

                Button("Save") {
                    viewModel?.save()
                }
                .disabled(!(viewModel?.canSave ?? false))
                .frame(maxWidth: .infinity)
                .fontWeight(.semibold)
            }
            .navigationTitle("Add Food")
        }
        .onAppear {
            if viewModel == nil {
                viewModel = AddViewModel(modelContext: modelContext)
            }
        }
    }

    private func binding(_ keyPath: ReferenceWritableKeyPath<AddViewModel, String>) -> Binding<String> {
        Binding(
            get: { viewModel?[keyPath: keyPath] ?? "" },
            set: { viewModel?[keyPath: keyPath] = $0 }
        )
    }
}
