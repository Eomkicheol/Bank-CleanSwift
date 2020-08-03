//
//  StatementTableCellHeader.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

class StatementTableCellHeader: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.white
        let recentLabel = UILabel()
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        recentLabel.text = "statement.table.header".localized()
        recentLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        recentLabel.textColor = UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1.00)
        
        
        self.addSubview(recentLabel)
        
        recentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        recentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        recentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
    }
}
