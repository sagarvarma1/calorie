import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var hasAppeared = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            if let image = capturedImage {
                Text("Photo captured!")
                    .font(.custom("Georgia", size: 20))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + (hasAppeared ? 0 : 0.3)) {
                showCamera = true
                hasAppeared = true
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(image: $capturedImage)
                .ignoresSafeArea()
        }
    }
}
