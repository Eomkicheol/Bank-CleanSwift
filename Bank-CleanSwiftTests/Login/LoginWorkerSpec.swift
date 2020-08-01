//
//  LoginWorkerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class UserProviderSpy: UserProvider {
    
    var saveUserNameCallsCount = 0
    func saveUserName(userName: String) {
        saveUserNameCallsCount += 1
    }
    
    var getLastLoggedUserCallsCount = 0
    func getLastLoggedUser() -> String? {
        getLastLoggedUserCallsCount += 1
        if (saveUserNameCallsCount>=1) {
            return "user"
        } else {
            return nil
        }
    }
    
    
}

class LoginWorkerSpec: QuickSpec {

    override func spec() {
        
        describe("LoginWorker") {
            var sut: LoginWorker!
            var userProvider: UserProviderSpy!
            
            beforeEach {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [URLProtocolStub.self]
                let apiProvider = BankHttpProvider(urlSession: URLSession(configuration: configuration))
                userProvider = UserProviderSpy()
                
                sut = LoginWorker(apiProvider: apiProvider, userProvider: userProvider)
                
            }
            
            afterEach {
                URLProtocolStub.responseStub = nil
            }
            
            context("login") {
                it("should call failure when api return error") {
                    URLProtocolStub.responseStub = URLReponseStub(data: nil, error: AnyError.anyError , response: nil)
                    
                    waitUntil { done in
                        sut.login(userName: "user", password: "pass") { (result) in
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
                        sut.login(userName: "user", password: "pass") { (result) in
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
                
                it("should return userAccount on success"){
                    URLProtocolStub.responseStub = URLReponseStub(data: self.stubUserAccountData(), error: nil , response: self.validReponse())
                    
                    waitUntil { done in
                        sut.login(userName: "user", password: "pass") { (result) in
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
            
            it("should call provider on saveUserName") {
                sut.saveUserName(username: "user")
                expect(userProvider.saveUserNameCallsCount).to(equal(1))
            }
            
            it("should call provider on getLastLoggedUser") {
                _ = sut.getLastLoggedUser()
                expect(userProvider.getLastLoggedUserCallsCount).to(equal(1))
            }
        }
    }

}

