//
//  LoginViewControllerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Bank_CleanSwift


class LoginViewControllerSpec: QuickSpec {

    override func spec() {
        
        describe("LoginViewController") {
            var sut: LoginViewController!
            
            it("should have a valid snapshot"){
                sut = LoginViewController()
                expect(sut.view).to(haveValidSnapshot())
            }
        }
    }

}
