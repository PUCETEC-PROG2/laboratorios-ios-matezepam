import Foundation

enum AppConfig {
    private static let filename = "config"

    private enum Keys {
        static let apiBaseUrl = "API_BASE_URL"
        static let apiToken = "API_TOKEN"
    }

    private static var config: [String: Any] {
        guard
            let url = Bundle.main.url(
                forResource: filename, withExtension: "plist"
            ),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
            ),
            let dict = plist as? [String: Any]
        else {
            return [:]
        }

        return dict
    }

    static var apiBaseUrl: String {
        if let environmentUrl = ProcessInfo.processInfo.environment["GITHUB_API_BASE_URL"],
           !environmentUrl.isEmpty {
            return environmentUrl
        }

        return config[Keys.apiBaseUrl] as? String ?? "https://api.github.com"
    }

    static var apiToken: String {
        if let environmentToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"],
           !environmentToken.isEmpty {
            return environmentToken
        }

        guard let token = config[Keys.apiToken] as? String, !token.isEmpty else {
            fatalError(
                "Configura GITHUB_TOKEN en el esquema de Xcode o crea config.plist "
                + "a partir de config.example.plist"
            )
        }
        return token
    }
}
