import Foundation
import Alamofire

@MainActor
class RepoListViewController: ObservableObject {
    @Published var repos: [Repo] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?

    private let githubService: GithubService

    init(service: GithubService = .shared) {
        self.githubService = service
    }

    func loadRepositories() async {
        guard !isLoading else { return }
        isLoading = true
        errorMsg = nil
        do {
            repos = try await githubService.getRepositories()
        } catch let error where isCancellation(error) {

        } catch {
            errorMsg = error.localizedDescription
        }
        isLoading = false
    }

    func createRepo(name: String, description: String, language: String) async -> Bool {
        isLoading = true
        errorMsg = nil
        do {
            let newRepo = try await githubService.createRepo(
                name: name,
                description: description,
                gitignoreTemplate: language
            )
            repos.insert(newRepo, at: 0)
            isLoading = false
            return true
        } catch {
            errorMsg = error.localizedDescription
            isLoading = false
            return false
        }
    }

    private func isCancellation(_ error: Error) -> Bool {
        if error is CancellationError { return true }
        if let afError = error as? AFError, afError.isExplicitlyCancelledError { return true }
        return false
    }
}
