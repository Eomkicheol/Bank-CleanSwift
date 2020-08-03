//
//  StatementsServiceMock.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation
@testable import Bank_CleanSwift

class StatementsServiceMock: StatementsService {
    
    var getStatementsShouldReturnSuccess = true
    let errorMsg = "statementsError"
    var statements = [Statement(title: "st1", description: "desc", date: "2020-08-02", value: 10.0), Statement(title: "st2", description: "desc", date: "2020-08-02", value: 10.0)]
    var shouldReturnEmpty = false
    func getStatements(userId: Int, callback: @escaping (StatementsResult) -> Void) {
        if getStatementsShouldReturnSuccess {
            if shouldReturnEmpty {
                callback(.success([]))
            } else {
                callback(.success(statements))
            }
        } else {
            callback(.failure(BankError.apiError(message: errorMsg)))
        }
    }
    
    
}
