//
//  StatementsMapper.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

class StatementsMapper {
    
    private struct Root: Codable {
        let statementList: [Statement]
        let error: ErrorModel
    }
    
    private static let invalidData = "error.invalidData"
    
    static func map(_ data: Data) throws -> [Statement] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw BankError.apiError(message: invalidData)
        }

        if !root.statementList.isEmpty {
            return root.statementList
        } else if let error = root.error.message {
            throw BankError.apiError(message: error)
        }
        return []
    }
    
}
