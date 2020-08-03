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
            var worker: StatementsServiceMock!
            
            beforeEach {
                sut = StatementsViewController()
                worker = StatementsServiceMock()
                
                (sut.interactor as! StatementsInteractor).userAccount = UserAccount(userId: 1, name: "Jose da Silva Teste", bankAccount: "2050", agency: "012314564", balance: 3.3445)
                (sut.interactor as! StatementsInteractor).worker = worker
                let window = UIWindow()
                window.addSubview(sut.view)
                
            
            }
            
            it("should have a valid snapshot") {
                //wait until view is rendered with statements
                waitUntil(timeout: 5) { done in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        done()
                    }
                }
                expect(sut.view).to(haveValidSnapshot())
            }
            
            it("should have a valid snapshot when have no statements") {
                worker.shouldReturnEmpty = true
                sut.interactor?.getStatments()
                waitUntil(timeout: 5) { done in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        done()
                    }
                }
                expect(sut.view).to(haveValidSnapshot())
            }
            
            
            it("should use light status bar") {
                expect(sut.preferredStatusBarStyle).to(equal(.lightContent))
            }
            
            it("should pop when logout") {
                let navigationController = NavigationControllerStub(rootViewController: LoginViewController())
                navigationController.pushViewController(sut, animated: false)
                sut.logout(self)
                
                expect(navigationController.visibleViewController).notTo(equal(sut))
            }
            
            it("should present an alert on presentEror") {
                let viewModel = Statements.Error.ViewModel(error: BankError.apiError(message: "error"))
                sut.displayError(viewModel: viewModel)
                expect(sut.presentedViewController).toEventually(beAKindOf(UIAlertController.self))
            }
            
        }
    }

}
