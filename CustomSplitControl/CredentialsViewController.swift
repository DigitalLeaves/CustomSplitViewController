//
//  CredentialsViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class CredentialsViewController: CustomSplitContentViewController {
    // outlets
    @IBOutlet weak var userIdTextfield: UITextField!
    @IBOutlet weak var oldPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userIdTextfield.text = self.person.userId
    }

    @IBAction func changePassword(_ sender: UIButton) {
        guard let oldPassword = oldPasswordTextfield.text, oldPassword.characters.count > 0 else {
            messageLabel.text = "Please, enter your current password"
            return
        }
        
        guard let newPassword = newPasswordTextfield.text, newPassword.characters.count > 0 else {
            messageLabel.text = "Please, enter a new password"
            return
        }
        
        guard oldPassword == self.person.password else {
            messageLabel.text = "Incorrect current password. Please try again."
            return
        }
        
        
        self.person.password = newPassword
        self.containerDelegate?.personModified(person: self.person)
        messageLabel.text = "Password successfully changed!"
    }

}
