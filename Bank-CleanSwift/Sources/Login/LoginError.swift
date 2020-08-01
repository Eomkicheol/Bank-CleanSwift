//
//  LoginError.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

enum LoginError: Swift.Error {
    case invalidUserInput(message: String)
    case apiError(message: String)
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUserInput(message: let message):
            return message
        case .apiError(message: let message):
            return message
        }
    }
}

extension LoginError: Equatable {
    
}
