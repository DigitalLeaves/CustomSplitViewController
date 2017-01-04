//
//  PersonalInformationViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class PersonalInformationViewController: CustomSplitContentViewController, UITableViewDataSource, UITableViewDelegate {
    // outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDataTableView: UITableView!
    
    // data
    var fields: [ModelFieldType] = [.email, .birthDate, .phoneNumber, .maritalStatus]
    var values: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cells
        self.userDataTableView.register(UINib(nibName: "PersonalInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonalInformationTableViewCell")
        // initialize values
        userImageView.image = person.image
        userNameLabel.text = person.name
        // appearance
        userImageView.layer.cornerRadius = userImageView.frame.width / 2.0
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = true

    }
    
    // MARK: - UITableViewDataSource/Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInformationTableViewCell", for: indexPath) as! PersonalInformationTableViewCell
        let field = fields[indexPath.row]
        cell.configureWithField(field: field, andValue: self.person.stringValueForField(field: field))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = fields[indexPath.row]
        let parameters: [String: Any] = ["field": field, "value": person.stringValueForField(field: field)]
        self.containerDelegate?.segueRequestedWithIdentifier(identifier: "editField", parameters: parameters)
    }

    
}
