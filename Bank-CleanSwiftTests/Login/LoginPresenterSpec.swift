//
//  LoginPresenterSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class LoginDisplayLogicSpy: LoginDisplayLogic {
    
    var errorViewModelReceived: Login.ErrorViewModel?
    func presentError(errorViewModel: Login.ErrorViewModel) {
        errorViewModelReceived = errorViewModel
    }
    
    var userViewModelReceived: Login.UserViewModel?
    func presentStatements(userViewModel: Login.UserViewModel) {
        userViewModelReceived = userViewModel
    }
    
    var userNameViewModelReceived: Login.UserNameViewModel?
    func fillUserNameTextFieldLastLoggedUser(userNameViewModel: Login.UserNameViewModel) {
        userNameViewModelReceived = userNameViewModel
    }
    
    
}

class LoginPresenterSpec: QuickSpec {

    override func spec() {
        describe("LoginPresenter") {
            var sut: LoginPresenter!
            var displayLogic: LoginDisplayLogicSpy!
            
            beforeEach {
                sut = LoginPresenter()
                displayLogic = LoginDisplayLogicSpy()
                sut.viewController = displayLogic
            }
            
            it("should call presentError correctly") {
                let response = Login.ErrorResponse(error: BankError.apiError(message: "error"))
                sut.presentError(errorResponse: response)
                expect(displayLogic.errorViewModelReceived?.error).toEventually(equal(response.error))
            }
            
            it("should call presentStatements correctly") {
                let response = Login.UserResponse(userAccount: UserAccount(userId: 1, name: "name", bankAccount: "123", agency: "123", balance: 10.0))
                sut.presentStatements(userResponse: response)
                expect(displayLogic.userViewModelReceived?.userAccount).toEventually(equal(response.userAccount))
            }
            
            it("should call presentLastUserName correctly") {
                let response = Login.UserNameResponse(userName: "user")
                sut.presentLastUserName(userNameResponse: response)
                expect(displayLogic.userNameViewModelReceived?.userName).toEventually(equal(response.userName))
            }
            
        }
    }

}
