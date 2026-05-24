import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let headerView = UIView()
    private let logoContainer = UIView()
    private let logoLabel = UILabel()
    private let appTitleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let formCard = UIView()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()

    private let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }

    private func addViews() {
        view.addSubview(headerView)
        headerView.addSubview(logoContainer)
        logoContainer.addSubview(logoLabel)
        headerView.addSubview(appTitleLabel)
        headerView.addSubview(subtitleLabel)

        view.addSubview(formCard)
        formCard.addSubview(usernameField)
        formCard.addSubview(passwordField)
        formCard.addSubview(loginButton)
        loginButton.addSubview(activityIndicator)
        formCard.addSubview(errorLabel)
    }

    private func styleViews() {
        view.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 250/255, alpha: 1)

        headerView.backgroundColor = .sofaLightBlue

        logoContainer.backgroundColor = .white
        logoContainer.layer.cornerRadius = 28
        logoContainer.layer.shadowColor = UIColor.black.cgColor
        logoContainer.layer.shadowOpacity = 0.15
        logoContainer.layer.shadowRadius = 8
        logoContainer.layer.shadowOffset = CGSize(width: 0, height: 4)

        logoLabel.text = "S"
        logoLabel.font = .systemFont(ofSize: 36, weight: .black)
        logoLabel.textColor = .sofaLightBlue
        logoLabel.textAlignment = .center

        appTitleLabel.text = "Sofascore 2026"
        appTitleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        appTitleLabel.textColor = .white
        appTitleLabel.textAlignment = .center

        subtitleLabel.text = "Sign in to continue"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        subtitleLabel.textAlignment = .center

        formCard.backgroundColor = .white
        formCard.layer.cornerRadius = 16
        formCard.layer.shadowColor = UIColor.black.cgColor
        formCard.layer.shadowOpacity = 0.08
        formCard.layer.shadowRadius = 12
        formCard.layer.shadowOffset = CGSize(width: 0, height: 4)

        styleTextField(usernameField, placeholder: "Username", icon: "person")
        styleTextField(passwordField, placeholder: "Password", icon: "lock")
        passwordField.isSecureTextEntry = true
        passwordField.returnKeyType = .done
        usernameField.returnKeyType = .next
        usernameField.delegate = self
        passwordField.delegate = self

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        loginButton.backgroundColor = .sofaLightBlue
        loginButton.layer.cornerRadius = 12
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true

        errorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
    }

    private func styleTextField(_ field: UITextField, placeholder: String, icon: String) {
        field.placeholder = placeholder
        field.font = .systemFont(ofSize: 15)
        field.textColor = .primaryText
        field.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 250/255, alpha: 1)
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 220/255, green: 222/255, blue: 230/255, alpha: 1).cgColor
        field.autocapitalizationType = .none
        field.autocorrectionType = .no

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .secondaryText
        iconView.contentMode = .scaleAspectFit
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        iconView.frame = CGRect(x: 12, y: 0, width: 18, height: 20)
        container.addSubview(iconView)
        field.leftView = container
        field.leftViewMode = .always
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }

        logoContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.size.equalTo(56)
        }

        logoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        appTitleLabel.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        formCard.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        usernameField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(usernameField.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }

        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(28)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc private func didTapLogin() {
        let username = usernameField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = passwordField.text ?? ""
        guard !username.isEmpty, !password.isEmpty else {
            showError("Please enter your username and password.")
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
                showError("Login failed. Please check your credentials.")
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
