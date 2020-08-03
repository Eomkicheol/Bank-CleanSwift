//
//  StatementsWorkerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble

@testable import Bank_CleanSwift

class StatementsWorkerSpec: QuickSpec {

    override func spec() {
        describe("StatementsWorker") {
            var sut: StatementsWorker!
            
            beforeEach {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [URLProtocolStub.self]
                let apiProvider = BankHttpProvider(urlSession: URLSession(configuration: configuration))
                
                sut = StatementsWorker(apiProvider: apiProvider)
            }
            
            afterEach {
                URLProtocolStub.responseStub = nil
            }
            
            context("getStatements") {
                it("should call failure when api return error") {
                    URLProtocolStub.responseStub = URLReponseStub(data: nil, error: AnyError.anyError , response: nil)
                    
                    waitUntil { done in
                        sut.getStatements(userId: 1) { (result) in
                            switch result {
                            case .success(_ ):
                                break
                            case .failure(let error):
                                expect(error).notTo(beNil())
                                done()
                            }
                        }
                    }
                    
                }
                
                it("should call failure when mapper fails to decode response data") {
                    URLProtocolStub.responseStub = URLReponseStub(data: Data(), error: nil , response: self.validReponse())
                    
                    waitUntil { done in
                        sut.getStatements(userId: 1) { (result) in
                            switch result {
                            case .success(_ ):
                                break
                            case .failure(let error):
                                expect(error).notTo(beNil())
                                done()
                            }
                        }
                    }
                }
                
                it("should return statements on success"){
                    URLProtocolStub.responseStub = URLReponseStub(data: self.stubStatementsData(), error: nil , response: self.validReponse())
                    
                    waitUntil { done in
                        sut.getStatements(userId: 1) { (result) in
                            switch result {
                            case .success(let user):
                                expect(user).notTo(beNil())
                                done()
                            case .failure(_ ):
                                break
                            }
                        }
                    }
                }
            }
            
        }
    }

}
