//
//  ChangeFieldViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class ChangeFieldViewController: CustomSplitContentViewController {
    // outlets
    @IBOutlet weak var fieldNameTextfield: UITextField!
    @IBOutlet weak var fieldValueTextfield: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    
    // data
    var field: ModelFieldType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: kDLNotificationDisablePersonMenu, object: nil)

        if let field = self.parameters?["field"] as? ModelFieldType, let value = self.parameters?["value"] as? String {
            self.field = field
            self.fieldValueTextfield.text = value
            self.changeButton.isEnabled = true
        } else { self.changeButton.isEnabled = false }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: kDLNotificationEnablePersonMenu, object: nil)
    }
    
    @IBAction func changeValue(_ sender: UIButton) {
        guard let newValueString = fieldValueTextfield.text, newValueString.characters.count > 0 else { return }
        
        let newValue: Any = (field == .birthDate) ? Person.birthDateFromString(dateString: newValueString) ?? Date() : newValueString
        self.person.setValue(value: newValue, forField: field)
        self.containerDelegate?.personModified(person: self.person)
        self.containerDelegate?.segueRequestedWithIdentifier(identifier: "information", parameters: nil)
    }
    
    @IBAction func cancelAndLeave(_ sender: UIButton) {
        self.containerDelegate?.segueRequestedWithIdentifier(identifier: "information", parameters: nil)
    }
    
}
