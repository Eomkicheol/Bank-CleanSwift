//
//  BankHttpProviderSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class BankHttpProviderSpec: QuickSpec {

    override func spec() {
        
        describe("BankHttpProvider") {
            var sut: BankHttpProvider!
            
            beforeEach {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [URLProtocolStub.self]
                sut = BankHttpProvider(urlSession: URLSession(configuration: configuration))
            }
            
            afterEach {
                URLProtocolStub.responseStub = nil
            }
            
            context("login") {
                it("should call failure when response has error") {
                    URLProtocolStub.responseStub = URLReponseStub(data: nil, error: AnyError.anyError , response: nil)
                    
                    waitUntil { done in
                        sut.login(userName: "user", password: "pass") { (result) in
                            switch result {
                            case .success( _):
                                break
                            case .failure(let error):
                                expect(error).notTo(beNil())
                                done()
                            }
                        }
                    }
                }
                
                it("should call success when response has data") {
                    URLProtocolStub.responseStub = URLReponseStub(data: Data(), error: nil , response: self.validReponse())
                    
                    waitUntil { done in
                        sut.login(userName: "user", password: "pass") { (result) in
                            switch result {
                            case .success(let data):
                                expect(data).notTo(beNil())
                                done()
                            case .failure( _):
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
