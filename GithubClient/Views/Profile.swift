import SwiftUI

struct Profile: View {
    @StateObject private var controller = ProfileViewController()

    var body: some View {
        NavigationStack {
            Group {
                if controller.isLoading {
                    ProgressView("Cargando perfil...")
                } else if let errorMsg = controller.errorMsg {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(errorMsg)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task { await controller.loadProfile() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if let user = controller.user {
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())

                        Text(user.name ?? user.login)
                            .font(.title2.bold())

                        Text("@\(user.login)")
                            .foregroundColor(.gray)

                        if let bio = user.bio {
                            Text(bio)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Perfil del Usuario")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await controller.loadProfile()
            }
        }
    }
}

#Preview {
    Profile()
}
