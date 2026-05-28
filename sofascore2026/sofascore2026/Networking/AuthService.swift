import Foundation

final class AuthService {
    static let shared = AuthService()
    private init() {}

    private let tokenKey = "auth_token"
    private let usernameKey = "auth_username"

    var token: String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }

    var username: String? {
        UserDefaults.standard.string(forKey: usernameKey)
    }

    var isLoggedIn: Bool {
        token != nil
    }

    func save(token: String, username: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(username, forKey: usernameKey)
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: usernameKey)
        DatabaseManager.shared.deleteAll()
    }
}
