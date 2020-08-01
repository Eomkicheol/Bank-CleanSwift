//
//  LoginViewController.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 31/07/20.
//  Copyright (c) 2020 Scott Takahashi. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogic: class {
    
    func presentError(errorViewModel: Login.ErrorViewModel)
    
    func presentStatements(userViewModel: Login.UserViewModel)
    
    func fillUserNameTextFieldLastLoggedUser(userNameViewModel: Login.UserNameViewModel)
}

private struct LoginViewControllerConstants {
    static let userTextFieldPlaceholder = "login.userTextField.placeholder"
    static let passwordTextFieldPlaceholder = "login.passwordTextField.placeholder"
    static let loginButtonLabel = "login.loginButton.text"
    
    static let errorAlertTitle = "login.alert.error.title"
    static let errorAlertDismiss = "login.alert.error.dismissButton"
}

class LoginViewController: BaseViewController {
    
    private let loginButtonRadius: CGFloat = 4
    
    @IBOutlet private(set) weak var userTextField: UITextField!
    @IBOutlet private(set) weak var passwordTextField: UITextField!
    @IBOutlet private(set) weak var loginButton: UIButton!
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         interactor?.retrieveLastLoggedUserName()
    }
  
    @IBAction func doLogin(_ sender: Any) {
        let request = Login.Request(userName: self.userTextField.text ?? "", password: self.passwordTextField.text ?? "")
        self.showSpinner()
        interactor?.login(request: request)
       
    }
    
}

extension LoginViewController: LoginDisplayLogic {
    
    func fillUserNameTextFieldLastLoggedUser(userNameViewModel: Login.UserNameViewModel) {
        self.userTextField.text = userNameViewModel.userName
    }
    
    func presentError(errorViewModel: Login.ErrorViewModel) {
        self.stopSpinner()
        let alert = self.buildAlert(error: errorViewModel.error)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentStatements(userViewModel: Login.UserViewModel) {
        self.stopSpinner()
        router?.goToStatements()
    }
    
    
}

// MARK: private func
extension LoginViewController {
      
    private func setup()  {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
        
    private func setupView() {
        self.userTextField.placeholder = LoginViewControllerConstants.userTextFieldPlaceholder.localized()
        self.passwordTextField.placeholder = LoginViewControllerConstants.passwordTextFieldPlaceholder.localized()
        self.loginButton.setTitle(LoginViewControllerConstants.loginButtonLabel.localized(), for: .normal)
        self.loginButton.layer.cornerRadius = loginButtonRadius
       
    }

    private func buildAlert(error: LoginError) -> UIAlertController {
        let alert = UIAlertController(title: LoginViewControllerConstants.errorAlertTitle.localized(), message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: LoginViewControllerConstants.errorAlertDismiss.localized(), style: .cancel) { [weak self] (action) in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(dismissAction)
        return alert
    }
    
}
