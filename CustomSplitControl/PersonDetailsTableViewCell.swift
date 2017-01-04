//
//  PersonDetailsTableViewCell.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class PersonDetailsTableViewCell: UITableViewCell {
    // outlets
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personImageView.layer.cornerRadius = personImageView.frame.width / 2.0
        personImageView.layer.borderColor = UIColor.lightGray.cgColor
        personImageView.layer.borderWidth = 1.0
        personImageView.layer.masksToBounds = true
    }
    
    func configureWithPerson(person: Person) {
        personImageView.image = person.image
        personNameLabel.text = person.name
        personEmailLabel.text = person.email
    }
}
