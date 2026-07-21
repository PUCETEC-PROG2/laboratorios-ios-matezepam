import SwiftUI

struct ContentView: View {
    @StateObject private var repoListController = RepoListViewController()

    var body: some View {
        TabView {
            RepoList(controller: repoListController)
                .tabItem {
                    Label("Repos", systemImage: "arrow.trianglehead.branch")
                }
            RepoForm(controller: repoListController)
                .tabItem {
                    Label("Crear Repositorio", systemImage: "plus")
                }
            Profile()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
