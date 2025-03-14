import UIKit
import SnapKit


final class LoginViewController: UIViewController, LoginView, UITextFieldDelegate {
    
    var presenter: LoginPresenter!
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private var activeTextField: UITextField?
    private var keyboardOffset: CGFloat = 0
    private let loaderView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let walletLogoImageView = UIImageView(image: UIImage(named: "WalletLogo"))
    private let loginButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        setupKeyboardNotifications()
        
        loaderView.frame = view.bounds
        loaderView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        loaderView.isHidden = true
        
        activityIndicator.center = loaderView.center
        loaderView.addSubview(activityIndicator)
        view.addSubview(loaderView)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupTextField(loginTextField, placeholder: "Username", iconName: "user")
        setupTextField(passwordTextField, placeholder: "Password", iconName: "passwordiconss")
        passwordTextField.isSecureTextEntry = true
        
        let stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue1
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 15)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        walletLogoImageView.contentMode = .scaleAspectFit
        
        view.addSubview(walletLogoImageView)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        
        walletLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(60)
            make.left.right.equalTo(view).inset(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.left.right.equalTo(view).inset(25)
            make.bottom.equalTo(loginButton.snp.top).offset(-25)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-133)
            make.height.equalTo(55)
            make.left.right.equalTo(view).inset(25)
        }
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String, iconName: String) {
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 25
        textField.textAlignment = .left
        textField.placeholder = placeholder
        textField.layer.borderColor = UIColor.gray1.cgColor
        textField.leftViewMode = .always
        textField.font = UIFont(name: "Poppins-Regular", size: 15)
        
        if textField == loginTextField {
            textField.returnKeyType = .next
        } else if textField == passwordTextField {
            textField.returnKeyType = .done
        }
        
        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .gray
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        let leftPaddingView = UIView()
        leftPaddingView.addSubview(iconImageView)
        leftPaddingView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(65)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        textField.leftView = leftPaddingView
        textField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        let rightPaddingView = UIView()
        rightPaddingView.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            loginTapped()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func showLoader() {
        loaderView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        loaderView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    @objc private func loginTapped() {
        guard let username = loginTextField.text, let password = passwordTextField.text else { return }
        presenter?.validateLogin(username: username, password: password)
    }
    
    
    private func setupKeyboardNotifications() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let offset = keyboardHeight / 1.6
        
        UIView.animate(withDuration: 0.3) {
            self.walletLogoImageView.transform = CGAffineTransform(translationX: 0, y: -60)
            self.loginTextField.transform = CGAffineTransform(translationX: 0, y: -offset)
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -offset)
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: -offset)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.walletLogoImageView.transform = .identity
            self.loginTextField.transform = .identity
            self.passwordTextField.transform = .identity
            self.loginButton.transform = .identity
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}
