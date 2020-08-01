//
//  BaseViewControllerSpec.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Quick
import Nimble
@testable import Bank_CleanSwift

class BaseViewControllerSpec: QuickSpec {

    override func spec() {
        
        describe("BaseViewController") {
            var sut: BaseViewController!
            
            beforeEach {
                sut = BaseViewController()
                let _ = sut.view
            }
            
            it("showSpinner should add SpinnerViewController on top"){
                sut.showSpinner()
                expect(sut.view.subviews.count).to(equal(1))
                expect(sut.view.isUserInteractionEnabled).to(beFalse())
                expect(sut.spinnerViewController.parent).to(equal(sut))
            }
            
            it("stopSpinner should remove SpinnerViewController on top"){
                sut.stopSpinner()
                expect(sut.view.subviews.count).to(equal(0))
                expect(sut.view.isUserInteractionEnabled).to(beTrue())
                expect(sut.spinnerViewController.parent).to(beNil())
            }
        }
    }

}
