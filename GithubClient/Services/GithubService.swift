import Foundation
import Alamofire

class GithubService {
    static let shared = GithubService()
    private let baseUrl = AppConfig.apiBaseUrl

    private init() {}

    private var headers: HTTPHeaders {
        [
            "Authorization": "Bearer \(AppConfig.apiToken)"
        ]
    }

    func getRepositories() async throws -> [Repo] {
        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .get,
            parameters: [
                "sort": "created",
                "direction": "desc",
                "per_page": 100,
                "affiliations": "owner"
            ],
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable([Repo].self)
        .value
    }

    func getUser() async throws -> UserInfo {
        return try await AF.request(
            "\(baseUrl)/user",
            method: .get,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable(UserInfo.self)
        .value
    }

    func createRepo(name: String, description: String, gitignoreTemplate: String) async throws -> Repo {
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "private": false,
            "auto_init": true,
            "gitignore_template": gitignoreTemplate
        ]

        return try await AF.request(
            "\(baseUrl)/user/repos",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .serializingDecodable(Repo.self)
        .value
    }
}
