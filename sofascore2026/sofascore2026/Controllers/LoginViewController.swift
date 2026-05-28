import UIKit

final class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.onLoginTapped = { [weak self] username, password in
            self?.handleLogin(username: username, password: password)
        }
    }

    private func handleLogin(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            loginView.showError("Please enter username and password.")
            return
        }
        loginView.setLoading(true)
        Task {
            do {
                let response = try await APIClient.shared.login(username: username, password: password)
                AuthService.shared.save(token: response.token, username: response.name)
                AppDelegate.showMain()
            } catch {
                loginView.setLoading(false)
                loginView.showError("Login failed. Check your credentials.")
            }
        }
    }
}
