//
//  LoginInteractorSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class LoginPresentationLogicSpy: LoginPresentationLogic{
    
    var presentErrorCallsCount = 0
    var lastError: LoginError?
    func presentError(errorResponse: Login.ErrorResponse) {
        presentErrorCallsCount +=  1
        lastError = errorResponse.error
    }
    
    var presentStatementsCallCount = 0
    func presentStatements(userResponse: Login.UserResponse) {
        presentStatementsCallCount += 1
    }
    
    var presentLastUserNameCallCount = 0
    func presentLastUserName(userNameResponse: Login.UserNameResponse) {
        presentLastUserNameCallCount += 1
    }
}

class LoginServiceMock: LoginService {
    static let errorMsg = "error"
    
    var loginShouldReturnSuccess = true
    func login(userName: String, password: String, callback: @escaping (LoginService.Result) -> Void) {
        if loginShouldReturnSuccess {
            let userAccount = UserAccount(userId: 1, name: "Name", bankAccount: "1234", agency: "123", balance: 100.0)
            callback(.success(userAccount))
        } else {
            callback(.failure(LoginError.apiError(message: LoginServiceMock.errorMsg)))
        }
    }
    
    var saveUserNameCallsCount = 0
    func saveUserName(username: String) {
        saveUserNameCallsCount += 1
    }
    
    var shouldReturnLoggedUser = true
    func getLastLoggedUser() -> String? {
        if shouldReturnLoggedUser {
            return "user"
        }
        return nil
    }
    
    
}

class LoginInteractorSpec: QuickSpec {

    override func spec() {
        describe("LoginInteractor") {
            var sut: LoginInteractor!
            var presenter: LoginPresentationLogicSpy!
            var worker: LoginServiceMock!
            
            beforeEach {
                presenter = LoginPresentationLogicSpy()
                worker = LoginServiceMock()
                sut = LoginInteractor()
                sut.worker = worker
                sut.presenter = presenter
            }
            
            context("login") {
                    
                it("should call presenter#presentError when userName is not an email or cpf") {
                    let loginRequest = Login.Request(userName: "12312312312", password: "aBc!2")
                    sut.login(request: loginRequest)
                    
                    expect(presenter.presentErrorCallsCount).to(equal(1))
                    expect(presenter.lastError!.errorDescription).to(equal("login.error.invalidUser".localized()))
                }
                
                it("should call presenter#presentError when password is invalid") {
                    let loginRequest = Login.Request(userName: "teste@teste.com", password: "")
                    sut.login(request: loginRequest)
                    
                    expect(presenter.presentErrorCallsCount).to(equal(1))
                    expect(presenter.lastError!.errorDescription).to(equal("login.error.invalidPassword".localized()))
                }
                
                it("should call presenter#presentError when api provider return failure") {
                    let loginRequest = Login.Request(userName: "teste@teste.com", password: "pAs1!")
                    worker.loginShouldReturnSuccess = false
                    sut.login(request: loginRequest)
                    expect(presenter.presentErrorCallsCount).toEventually(equal(1))
                    expect(presenter.lastError!.errorDescription).toEventually(equal(LoginServiceMock.errorMsg))
                    expect(worker.saveUserNameCallsCount).toEventually(equal(0))
                    expect(presenter.presentStatementsCallCount).toEventually(equal(0))
                    
                }
                
                it("should call presenter#presentStatements when api return success") {
                    let loginRequest = Login.Request(userName: "teste@teste.com", password: "pAs1!")
                    sut.login(request: loginRequest)
                    expect(presenter.presentStatementsCallCount).toEventually(equal(1))
                    expect(presenter.presentErrorCallsCount).toEventually(equal(0))
                    expect(worker.saveUserNameCallsCount).toEventually(equal(1))
                }
                
            }
            
            context("retrieveLastLoggedUserName") {
                
                it("should call presenter#presentLastUserName when work has a saved user") {
                    sut.retrieveLastLoggedUserName()
                    expect(presenter.presentLastUserNameCallCount).to(equal(1))
                }
                
                it("should not call presenter#presentLastUserName when work hasn't a saved user") {
                    worker.shouldReturnLoggedUser = false
                    sut.retrieveLastLoggedUserName()
                    expect(presenter.presentLastUserNameCallCount).to(equal(0))
                }
                
            }
        }
    }

}
