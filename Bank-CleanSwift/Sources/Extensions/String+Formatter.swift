//
//  String+Formatter.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

extension String {
    
    func formatToShortDate() -> String? {
        let dateFormaterInput = DateFormatter()
        dateFormaterInput.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormaterInput.date(from:self) {
            let dateFormaterOutput = DateFormatter()
            dateFormaterOutput.dateStyle = .short
            dateFormaterOutput.timeStyle = .none
            return dateFormaterOutput.string(from: date)
        }
        return nil
    }
}
