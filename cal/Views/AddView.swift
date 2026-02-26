import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showCamera = false
    @State private var capturedImage: UIImage?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            if let image = capturedImage {
                Text("Photo captured!")
                    .font(.custom("Georgia", size: 20))
            } else {
                Text("Tap to open camera")
                    .font(.custom("Georgia", size: 20))
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            showCamera = true
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(image: $capturedImage)
                .ignoresSafeArea()
        }
    }
}
