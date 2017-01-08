//
//  CustomSplitContentViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class CustomSplitContentViewController: UIViewController {
    var person: Person!
    weak var containerDelegate: ContainerViewControllerDelegate?
    var parameters: [String: Any]?
    
    func setPerson(person: Person, delegate: ContainerViewControllerDelegate?, andParameters parameters: [String: Any]?) {
        self.person = person
        self.containerDelegate = delegate
        self.parameters = parameters
    }
}
