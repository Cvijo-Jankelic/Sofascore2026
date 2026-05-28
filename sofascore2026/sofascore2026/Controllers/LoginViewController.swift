import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let headerView = UIView()
    private let titleLabel = UILabel()

    private let usernameLabel = UILabel()
    private let usernameField = UITextField()
    private let usernameSeparator = UIView()

    private let passwordLabel = UILabel()
    private let passwordField = UITextField()
    private let passwordSeparator = UIView()

    private let errorLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }

    private func addViews() {
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameField)
        view.addSubview(usernameSeparator)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordSeparator)
        view.addSubview(errorLabel)
        view.addSubview(loginButton)
        loginButton.addSubview(activityIndicator)
    }

    private func styleViews() {
        view.backgroundColor = .white

        headerView.backgroundColor = .sofaLightBlue

        titleLabel.text = "Sofascore 2026"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        setupFieldLabel(usernameLabel, text: "Username")
        setupTextField(usernameField, placeholder: "Enter username", secure: false)
        usernameSeparator.backgroundColor = .separator

        setupFieldLabel(passwordLabel, text: "Password")
        setupTextField(passwordField, placeholder: "Enter password", secure: true)
        passwordSeparator.backgroundColor = .separator

        errorLabel.font = .matchTime
        errorLabel.textColor = .liveRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .sportSelectorTitle
        loginButton.backgroundColor = .sofaLightBlue
        loginButton.layer.cornerRadius = 4
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true

        usernameField.returnKeyType = .next
        passwordField.returnKeyType = .done
        usernameField.delegate = self
        passwordField.delegate = self
    }

    private func setupFieldLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .countryName
        label.textColor = .secondaryText
    }

    private func setupTextField(_ field: UITextField, placeholder: String, secure: Bool) {
        field.placeholder = placeholder
        field.font = .teamName
        field.textColor = .primaryText
        field.borderStyle = .none
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = secure
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        usernameField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        usernameSeparator.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(usernameSeparator.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        passwordSeparator.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordSeparator.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc private func didTapLogin() {
        let username = usernameField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = passwordField.text ?? ""
        guard !username.isEmpty, !password.isEmpty else {
            showError("Please enter username and password.")
            return
        }
        setLoading(true)
        Task {
            do {
                let response = try await apiClient.login(username: username, password: password)
                AuthService.shared.save(token: response.token, username: response.name)
                AppDelegate.showMain()
            } catch {
                setLoading(false)
                showError("Login failed. Check your credentials.")
            }
        }
    }

    private func setLoading(_ loading: Bool) {
        loginButton.setTitle(loading ? "" : "Login", for: .normal)
        loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        loginButton.isEnabled = !loading
        errorLabel.isHidden = true
    }

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapLogin()
        }
        return true
    }
}
