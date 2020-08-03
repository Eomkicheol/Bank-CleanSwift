//
//  StatementTableCell.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 02/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

class StatementTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupContainerView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ statement: Statement) {
        self.titleLabel.text = statement.title
        self.descriptionLabel.text = statement.description
        self.dateLabel.text = statement.date.formatToShortDate()
        self.valueLabel.text = statement.value.formatCurrency()
    }
    
    private func setupContainerView() {
        let shadowColor = UIColor(red: 0.98, green: 0.95, blue: 0.96, alpha: 1.00).cgColor
        contentViewCell.layer.cornerRadius = 5
        contentViewCell.layer.borderColor = shadowColor
        contentViewCell.layer.borderWidth = 1.0
        contentViewCell.layer.shadowColor = shadowColor
        contentViewCell.layer.shadowOpacity = 0.9
        contentViewCell.layer.shadowOffset = CGSize(width: 0, height: 10)
        contentViewCell.layer.shadowRadius = 10
        contentViewCell.layer.shadowPath = UIBezierPath(rect: contentViewCell.bounds).cgPath

    }
    
}
