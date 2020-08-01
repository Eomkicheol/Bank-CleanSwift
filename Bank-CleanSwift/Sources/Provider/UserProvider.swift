//
//  UserProvider.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol UserProvider {
    
    func saveUserName(userName: String)
    
    func getLastLoggedUser() -> String?

}

class UserProviderImpl: UserProvider {
    
    static let userKey = "usernameKey"
    
    func saveUserName(userName: String) {
        KeychainWrapper.standard.set(userName, forKey: UserProviderImpl.userKey)
    }
    
    func getLastLoggedUser() -> String? {
        return KeychainWrapper.standard.string(forKey: UserProviderImpl.userKey)
    }
    
    
}
