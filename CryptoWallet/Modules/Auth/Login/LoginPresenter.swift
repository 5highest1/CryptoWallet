import Foundation


protocol LoginView: AnyObject {
    func showError(message: String)
    func showLoader()
    func hideLoader()
}

final class LoginPresenter {

    private weak var view: LoginView?
    private var router: LoginRouter?

    init(view: LoginView, router: LoginRouter) {
        self.view = view
        self.router = router
    }

    func validateLogin(username: String, password: String) {
        let correctUsername = "1234"
        let correctPassword = "1234"
        
        view?.showLoader()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if username == correctUsername && password == correctPassword {
                self.view?.hideLoader()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.router?.startMainFlow()
                }
            } else {
                self.view?.hideLoader()
                
                self.view?.showError(message: "Invalid login or password")
            }
        }
    }
}
