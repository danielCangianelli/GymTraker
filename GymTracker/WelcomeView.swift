import SwiftUI

struct WelcomeView<Content: View>: View {
    private let content: () -> Content
    @State private var isActive = false

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Bem-vindo ao GymTracker")
                    .font(.largeTitle)
                    .padding()
                Button("Começar") { isActive = true }
                    .buttonStyle(.borderedProminent)
                NavigationLink(destination: content(), isActive: $isActive) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}
