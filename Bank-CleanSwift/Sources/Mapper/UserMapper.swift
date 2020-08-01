//
//  UserMapper.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

class UserMapper {
    
    private struct Root: Codable {
        let userAccount: UserAccount
        let error: BankError
    }
    
    private static let invalidData = "login.error.invalidData"
    
    static func map(_ data: Data) throws -> UserAccount {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw LoginError.apiError(message: invalidData)
        }

        if let _ = root.userAccount.userId {
            return root.userAccount
        } else if let error = root.error.message {
            throw LoginError.apiError(message: error)
        }
        throw LoginError.apiError(message: invalidData)
    }

}
