//
//  StatementsInteractorSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class StatementsPresenterSpy: StatementsPresentationLogic {
    
    var presentErrorResponse: Statements.Error.Reponse?
    var presentErrorCallCount = 0
    func presentError(errorResponse: Statements.Error.Reponse) {
        presentErrorResponse = errorResponse
        presentErrorCallCount += 1
    }
    
    var presetStatementsReponse: Statements.ShowStatements.Response?
    var presetStatementsCallCount = 0
    func presetStatements(response: Statements.ShowStatements.Response) {
        presetStatementsReponse = response
        presetStatementsCallCount += 1
    }
    
    
}

class StatementsInteractorSpec: QuickSpec {

    override func spec() {
        describe("StatementsInteractor") {
            var sut: StatementsInteractor!
            var presenter: StatementsPresenterSpy!
            var worker: StatementsServiceMock!
            
            beforeEach {
                presenter = StatementsPresenterSpy()
                worker = StatementsServiceMock()
                sut = StatementsInteractor()
                sut.presenter = presenter
                sut.worker = worker
                sut.userAccount = UserAccount(userId: 1, name: "Name", bankAccount: "123", agency: "123", balance: 100.0)
            }
            
            context("getStatments") {
                
                it("should call presenter#presetStatements if worker return success") {
                    sut.getStatments()
                    
                    expect(presenter.presetStatementsCallCount).toEventually(equal(1))
                    let response = presenter.presetStatementsReponse
                    expect(response?.statements).toEventually(equal(worker.statements))
                }
                
                it("should call presenter#presentError if worker return success") {
                    worker.getStatementsShouldReturnSuccess = false
                    sut.getStatments()
                    expect(presenter.presentErrorCallCount).toEventually(equal(1))
                    let response = presenter.presentErrorResponse
                    expect(response?.error.localizedDescription).toEventually(equal(worker.errorMsg))
                }
                
            }
            
        }
    }

}
