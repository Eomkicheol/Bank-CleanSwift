//
//  QuickSpec+Stubs.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick

extension QuickSpec {

    enum AnyError: Error {
        case anyError
    }
    

    func validReponse() -> URLResponse {
        return HTTPURLResponse(url: URL(string: "http://teste")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    func stubUserAccountData() -> Data{
        let jsonData = [
            "userAccount" : [
                "userId": 1,
                "name": "Jose da Silva Teste",
                "bankAccount": "2050",
                "agency": "012314564",
                "balance": 3.3445
            ],
            "error": [String: Any]()
            ] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: jsonData)
        return data
    }
    
    func stubStatementsData() -> Data {
        let jsonData = [
            "statementList" : [
                [
                    "title": "Pagamento",
                    "desc": "Conta de luz",
                    "date": "2018-08-15",
                    "value": -50
                ]
            ],
            "error": [String: Any]()
            ] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: jsonData)
        return data
    }
    
    func stubEmptyStatementsData() -> Data {
        let jsonData = [
            "statementList" : [],
            "error": [String: Any]()
            ] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: jsonData)
        return data
    }
}
