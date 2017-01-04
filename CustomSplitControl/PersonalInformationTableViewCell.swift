//
//  PersonalInformationTableViewCell.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class PersonalInformationTableViewCell: UITableViewCell {
    // outlets
    @IBOutlet weak var fieldValueLabel: UILabel!
    @IBOutlet weak var fieldNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithField(field: ModelFieldType, andValue value: String) {
        self.fieldNameLabel.text = field.rawValue
        self.fieldValueLabel.text = value
    }
}
