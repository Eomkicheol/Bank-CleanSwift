//
//  Statement.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

struct Statement: Codable, Equatable {
    
    let title: String
    let description: String
    let date: String
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case title, date, value
        case description = "desc"
    }
}
