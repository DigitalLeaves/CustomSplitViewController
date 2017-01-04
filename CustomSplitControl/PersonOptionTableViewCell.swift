//
//  PersonOptionTableViewCell.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class PersonOptionTableViewCell: UITableViewCell {
    // outlets
    @IBOutlet weak var optionNameLabel: UILabel!

    func configureWithOptionName(name: String) {
        optionNameLabel.text = name
    }
}
