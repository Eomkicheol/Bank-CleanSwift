//
//  UserProviderImplSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
import SwiftKeychainWrapper
@testable import Bank_CleanSwift

class UserProviderImplSpec: QuickSpec {

    override func spec() {
        describe("UserProviderImpl") {
            var sut: UserProviderImpl!
            let userName = "user"
            
            beforeEach {
                sut = UserProviderImpl()
            }
            
            afterEach {
                KeychainWrapper.standard.removeObject(forKey: UserProviderImpl.userKey)
            }
            
            it("should save username") {
                sut.saveUserName(userName: userName)
                expect(KeychainWrapper.standard.string(forKey: UserProviderImpl.userKey)).to(equal(userName))
            }
            
            it("should return nil when user name is not saved before"){
                expect(sut.getLastLoggedUser()).to(beNil())
            }
            
            it("should return last saved userName"){
                KeychainWrapper.standard.set(userName, forKey: UserProviderImpl.userKey)
                expect(sut.getLastLoggedUser()).to(equal(userName))
            }
            
        }
    }

}
