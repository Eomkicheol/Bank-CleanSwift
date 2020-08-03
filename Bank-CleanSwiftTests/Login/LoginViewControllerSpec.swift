//
//  LoginViewControllerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import SwiftKeychainWrapper
@testable import Bank_CleanSwift

class LoginInteractorSpy: LoginBusinessLogic {
    
    var lastRequest: Login.Request?
    func login(request: Login.Request) {
        lastRequest = request
    }
    
    var retrieveLastLoggedUserNameCallCount = 0
    func retrieveLastLoggedUserName() {
        retrieveLastLoggedUserNameCallCount += 1
    }
    
    
}

class LoginRoutingLogicSpy: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    var goToStatementsCallCount = 0
    func goToStatements() {
        goToStatementsCallCount += 1
    }
    
    var dataStore: LoginDataStore?
    
    
}

class LoginViewControllerSpec: QuickSpec {

    override func spec() {
        
        describe("LoginViewController") {
            var sut: LoginViewController!
            
            beforeSuite {
                KeychainWrapper.standard.removeObject(forKey: UserProviderImpl.userKey)
            }
            
            beforeEach {
                sut = LoginViewController()
                let window = UIWindow()
                window.addSubview(sut.view)
            }
            
            it("should have a valid snapshot"){
                expect(sut.view).to(haveValidSnapshot())
            }
            
            it("should call retrieveLastLoggedUserName on view viewWillAppera") {
                let interactorSpy = LoginInteractorSpy()
                sut.interactor = interactorSpy
                
                sut.viewWillAppear(false)
                expect(interactorSpy.retrieveLastLoggedUserNameCallCount).to(equal(1))
            }
            
            it("doLogin should call interactor correctly") {
                let interactorSpy = LoginInteractorSpy()
                sut.interactor = interactorSpy
                sut.userTextField.text = "user"
                sut.passwordTextField.text = "pass"
                sut.doLogin(self)
                let request = interactorSpy.lastRequest
                expect(request).notTo(beNil())
                expect(request!.userName).to(equal(sut.userTextField.text))
                expect(request!.password).to(equal(sut.passwordTextField.text))
            }
            
            it("should fill username text field when fillUserNameTextFieldLastLoggedUser is called") {
                let viewModel = Login.UserNameViewModel(userName: "user")
                sut.fillUserNameTextFieldLastLoggedUser(userNameViewModel: viewModel)
                expect(sut.userTextField.text).to(equal(viewModel.userName))
            }
            
            it("should present an alert on presentEror") {
                let viewModel = Login.ErrorViewModel(error: BankError.apiError(message: "error"))
                sut.presentError(errorViewModel: viewModel)
                expect(sut.presentedViewController).toEventually(beAKindOf(UIAlertController.self))
            }
            
            it("should delegate call to router on presentStatements") {
                let router = LoginRoutingLogicSpy()
                sut.router = router
                sut.presentStatements(userViewModel: Login.UserViewModel(userAccount: UserAccount(userId: 1, name: "name", bankAccount: "123", agency: "1323", balance: 10.0)))
                expect(router.goToStatementsCallCount).to(equal(1))
            }
        }
    }

}
