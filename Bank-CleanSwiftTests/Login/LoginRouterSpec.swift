//
//  LoginRouterSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class LoginViewControllerSpy: LoginViewController {
    
    var viewControllerShowed: UIViewController?
    
    override func show(_ vc: UIViewController, sender: Any?) {
        viewControllerShowed = vc
    }
}

class LoginRouterSpec: QuickSpec {

    override func spec() {
        describe("LoginRouter") {
            var sut: LoginRouter!
            var loginViewController: LoginViewControllerSpy!
            beforeEach {
                sut = LoginRouter()
                loginViewController = LoginViewControllerSpy()
                sut.viewController = loginViewController
                sut.dataStore = (loginViewController.interactor as! LoginInteractor)
                sut.dataStore?.user = UserAccount(userId: 1, name: "name", bankAccount: "123", agency: "123", balance: 10.0)
            }
            
            it("should route to statments viewcontroller correctly"){
                sut.goToStatements()

                let statmentsViewController = loginViewController.viewControllerShowed as? StatementsViewController
                expect(statmentsViewController).notTo(beNil())
                expect((statmentsViewController?.interactor as! StatementsInteractor).userAccount).to(equal(sut.dataStore!.user))
            }
        }
    }

}
