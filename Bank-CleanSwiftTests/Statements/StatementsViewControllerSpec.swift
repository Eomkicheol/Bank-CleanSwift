//
//  StatementsViewControllerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Bank_CleanSwift

class NavigationControllerStub: UINavigationController {
    override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: false)
    }
}

class StatementsViewControllerSpec: QuickSpec {

    override func spec() {
        describe("StatementsViewController") {
            var sut: StatementsViewController!
            
            beforeEach {
                sut = StatementsViewController()
            }
            
            it("should load header with user information") {
                (sut.interactor as! StatementsInteractor).userAccount = UserAccount(userId: 1, name: "Jose da Silva Teste", bankAccount: "2050", agency: "012314564", balance: 3.3445)
                let window = UIWindow()
                window.addSubview(sut.view)
                expect(sut.view).to(haveValidSnapshot())
            }
            
            it("should pop when logout") {
                let navigationController = NavigationControllerStub(rootViewController: LoginViewController())
                navigationController.pushViewController(sut, animated: false)
                sut.logout(self)
                
                expect(navigationController.visibleViewController).notTo(equal(sut))
                
            }
        }
    }

}
