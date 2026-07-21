import Foundation
import Alamofire

@MainActor
class ProfileViewController: ObservableObject {
    @Published var user: UserInfo?
    @Published var isLoading: Bool = true
    @Published var errorMsg: String?

    private let githubService: GithubService

    init(service: GithubService = .shared) {
        self.githubService = service
    }

    func loadProfile() async {
        isLoading = true
        errorMsg = nil
        do {
            user = try await githubService.getUser()
        } catch let error where isCancellation(error) {

        } catch {
            errorMsg = error.localizedDescription
        }
        isLoading = false
    }

    private func isCancellation(_ error: Error) -> Bool {
        if error is CancellationError { return true }
        if let afError = error as? AFError, afError.isExplicitlyCancelledError { return true }
        return false
    }
}
