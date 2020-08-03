//
//  StatementsPresenterSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class StatementsDisplayLogicSpy: StatementsDisplayLogic {
    
    var displayErrorWasCalled = false
    func displayError(viewModel: Statements.Error.ViewModel) {
        displayErrorWasCalled = true
    }
    
    var displayStatementsWasCalled = false
    func displayStatements(viewModel: Statements.ShowStatements.ViewModel) {
        displayStatementsWasCalled = true
    }
    
    
}

class StatementsPresenterSpec: QuickSpec {

    override func spec() {
        describe("StatementsPresenter") {
            var sut: StatementsPresenter!
            var viewController: StatementsDisplayLogicSpy!
            
            beforeEach {
                sut = StatementsPresenter()
                viewController = StatementsDisplayLogicSpy()
                sut.viewController = viewController
            }
            
            it("should call present error correctly") {
                let response = Statements.Error.Reponse(error: BankError.apiError(message: "error"))
                sut.presentError(errorResponse: response)
                expect(viewController.displayErrorWasCalled).to(beTrue())
            }
            
            it("should call present error correctly") {
                let response = Statements.ShowStatements.Response(statements: [])
                sut.presetStatements(response: response)
                expect(viewController.displayStatementsWasCalled).to(beTrue())
            }
        }
    }

}
