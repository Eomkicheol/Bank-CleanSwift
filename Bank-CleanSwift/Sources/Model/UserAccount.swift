//
//  UserAccount.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

struct UserAccount: Codable, Equatable {
    
    let userId: Int?
    let name: String?
    let bankAccount: String?
    let agency: String?
    let balance: Double?

}
