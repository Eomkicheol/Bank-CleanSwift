//
//  SpinnerViewControllerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import Bank_CleanSwift

class SpinnerViewControllerSpec: QuickSpec {

    override func spec() {
        
        describe("SpinnerViewController") {
            var sut: SpinnerViewController!
            
            it("should have a valid snapshot"){
                let window = UIWindow()
                sut = SpinnerViewController()
                sut.view.frame = window.frame
                expect(sut.view).to(haveValidSnapshot())
            }
        }
    }

}
