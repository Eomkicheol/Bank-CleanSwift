////
////  StatementTableCellSpec.swift
////  Bank-CleanSwiftTests
////
////  Created by Scott Takahashi on 02/08/20.
////  Copyright © 2020 Scott Takahashi. All rights reserved.
////
//
//import Quick
//import Nimble
//import Nimble_Snapshots
//
//@testable import Bank_CleanSwift
//
//class StatementTableCellSpec: QuickSpec {
//
//    override func spec() {
//        describe("StatementTableCell") {
//            var sut: StatementTableCell!
//            
//            beforeEach {
//                sut = StatementTableCell(frame: .zero)//(Bundle.main.loadNibNamed("StatementTableCell", owner: self, options: nil) as! StatementTableCell)
//                let window = UIWindow()
//                window.addSubview(sut)
//            }
//            
//            it("should setup correctly") {
//                let statement = Statement(title: "Pagamento", description: "Conta de luz", date: "2018-08-15", value: -50)
//                sut.setup(statement)
//                expect(sut).to(recordSnapshot())
//            }
//        }
//    }
//
//}
