//
//  StatementsMapperSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class StatementsMapperSpec: QuickSpec {

    override func spec() {
        describe("StatementsMapper") {
            it("should throw error decode invalid data") {
                expect(try StatementsMapper.map(Data())).to(throwError())
            }
            
            it("should return statements when data has statements.count>1") {
                let data = self.stubStatementsData()
                expect(try StatementsMapper.map(data)).notTo(beNil())
            }
            
            it("should return empty when data has statements.count = 0 and no error") {
                expect(try StatementsMapper.map(self.stubEmptyStatementsData()).count).to(equal(0))
            }
            
            it("should throw error when data define error") {
                
                let jsonData = [
                    "statementList" : [],
                    "error": [
                        "code" : 123,
                        "message" : "some msg"
                    ]
                ] as [String : Any]
                    
                let data = try! JSONSerialization.data(withJSONObject: jsonData)
                expect(try StatementsMapper.map(data)).to(throwError())
            }
        }
    }

}
