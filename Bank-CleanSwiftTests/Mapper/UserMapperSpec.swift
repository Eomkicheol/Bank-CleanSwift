//
//  UserMapperSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class UserMapperSpec: QuickSpec {

    override func spec() {

        describe("UserMapper") {
            
            it("should throw error decode invalid data") {
                expect(try UserMapper.map(Data())).to(throwError())
            }
            
            it("should should return user account when data has defined userAccount") {
                let data = self.stubUserAccountData()
                expect(try UserMapper.map(data)).notTo(beNil())
            }
            
            it("should throw error when data has define error") {
                
                let jsonData = [
                    "userAccount" : [String: Any](),
                    "error": [
                        "code" : 123,
                        "message" : "some msg"
                    ]
                ]
                    
                let data = try! JSONSerialization.data(withJSONObject: jsonData)
                expect(try UserMapper.map(data)).to(throwError())
            }
            
            it("should throw error when data define empty user and error") {
                
                let jsonData = [
                    "userAccount" : [String: Any](),
                    "error": [String: Any]()
                ]
                    
                let data = try! JSONSerialization.data(withJSONObject: jsonData)
                expect(try UserMapper.map(data)).to(throwError())
            }
            
        }
        
    }

}
