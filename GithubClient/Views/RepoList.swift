import SwiftUI

struct RepoList: View {
    @ObservedObject var controller: RepoListViewController

    var body: some View {
        NavigationStack {
            Group {
                if controller.isLoading {
                    ProgressView("Cargando repositorios...")
                } else if let errorMsg = controller.errorMsg {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(errorMsg)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task {
                                await controller.loadRepositories()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List(controller.repos) { repo in
                        RepoItem(repo: repo)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await controller.loadRepositories()
                    }
                }
            }
            .navigationTitle("Repositorios")
            .task {
                if controller.repos.isEmpty {
                    await controller.loadRepositories()
                }
            }
        }
    }
}

#Preview {
    RepoList(controller: RepoListViewController())
}
