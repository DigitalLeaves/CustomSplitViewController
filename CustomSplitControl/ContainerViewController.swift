//
//  ContainerViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

protocol ContainerViewControllerDelegate: class {
    func personModified(person: Person)
    func segueRequestedWithIdentifier(identifier: String, parameters: [String: Any]?)
}

class ContainerViewController: UIViewController, ContainerViewControllerDelegate {
    // data
    weak var containerToMenuDelegate: ContainerToMenuDelegate?
    var person: Person!
    var currentOption = kDLContainerMainOption
    var currentParameters: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

        currentOption = kDLContainerMainOption
        self.performSegue(withIdentifier: currentOption, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segue and swapping view controllers
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nil { return }
        
        // set properties for Custom Split Content View Controllers
        if let cscvc = segue.destination as? CustomSplitContentViewController {
            cscvc.setPerson(person: person, delegate: self, andParameters: currentParameters)
        }

        // prepare segue VC swapping.
        if segue.identifier! == kDLContainerMainOption {
            if self.childViewControllers.count > 0 {
                self.swapFrom(from: self.childViewControllers.first!, to: segue.destination, usingTransition: .transitionCrossDissolve)
            } else {
                self.addChildViewController(segue.destination)
                segue.destination.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(segue.destination.view)
                segue.destination.didMove(toParentViewController: self)
            }
        } else if kDLContainerSecondaryOptions.contains(segue.identifier!) {
            self.swapFrom(from: self.childViewControllers.first!, to: segue.destination, usingTransition: .transitionFlipFromRight)
        } else {
            self.swapFrom(from: self.childViewControllers.first!, to: segue.destination, usingTransition: .transitionCurlDown)
        }
        
    }
    
    func segueRequestedWithIdentifier(identifier: String, parameters: [String: Any]?) {
        self.currentParameters = parameters
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    internal func personModified(person: Person) {
        ModelManager.sharedInstance.personModified(person: person)
        self.containerToMenuDelegate?.personDataModified(person: person)
    }
    
    func setContainedViewController(option: String) {
        self.currentOption = option
        self.performSegue(withIdentifier: currentOption, sender: nil)
    }
    
    func swapFrom(from: UIViewController, to: UIViewController, usingTransition transition: UIViewAnimationOptions) {
        to.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        from.willMove(toParentViewController: nil)
        self.addChildViewController(to)
        self.transition(from: from, to: to, duration: 0.5, options: transition, animations: nil, completion: { (success) in
            from.removeFromParentViewController()
            to.didMove(toParentViewController: self)
        })
    }
}
