//
//  MainViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

let kDLContainerMainOption = "information"
let kDLContainerSecondaryOptions = ["location", "credentials"]

let kDLNotificationEnablePersonMenu = NSNotification.Name(rawValue: "kDLNotificationEnablePersonMenu")
let kDLNotificationDisablePersonMenu = NSNotification.Name("kDLNotificationDisablePersonMenu")

protocol ContainerToMenuDelegate: class {
    func personDataModified(person: Person)
}

class MainViewController: UIViewController, ContainerToMenuDelegate, UITableViewDelegate, UITableViewDataSource {
    // outlets
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // data
    weak var containerViewController: ContainerViewController!
    var person: Person!
    var isLoadingTable = true
    var menuEnabled = true {
        didSet {
            let targetAlpha: CGFloat
            if menuEnabled {
                targetAlpha = 1.0
                menuTableView.allowsSelection = true
            } else {
                targetAlpha = 0.5
                menuTableView.allowsSelection = false
            }
            UIView.animate(withDuration: 0.5, animations: { self.menuTableView.alpha = targetAlpha })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set table view cell heights
        self.menuTableView.estimatedRowHeight = 100.0
        self.menuTableView.rowHeight = UITableViewAutomaticDimension
        
        // table view appearance
        self.menuTableView.layer.shadowColor = UIColor.black.cgColor
        self.menuTableView.layer.shadowOffset = CGSize(width: 1, height: 0)
        self.menuTableView.layer.shadowRadius = 2.0
        self.menuTableView.layer.shadowOpacity = 0.10
        self.menuTableView.layer.masksToBounds = false
        
        // register cells
        menuTableView.register(UINib(nibName: "PersonDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonDetailsTableViewCell")
        menuTableView.register(UINib(nibName: "PersonOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonOptionTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(forName: kDLNotificationEnablePersonMenu, object: nil, queue: nil, using: { (notification) in
            self.menuEnabled = true
        })
        NotificationCenter.default.addObserver(forName: kDLNotificationDisablePersonMenu, object: nil, queue: nil, using: { (notification) in
            self.menuEnabled = false
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - In prepareForSegue, we should initialise the container, as the first segue is triggered upon loading of the container.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cvc = segue.destination as? ContainerViewController {
            self.containerViewController = cvc
            self.containerViewController.person = person
            self.containerViewController.containerToMenuDelegate = self
        }
    }

    // MARK: - ContainerToMenuDelegate methods
    
    func personDataModified(person: Person) {
        self.person = person
        menuTableView.reloadData()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kDLContainerSecondaryOptions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailsTableViewCell", for: indexPath) as! PersonDetailsTableViewCell
            cell.configureWithPerson(person: person)
            return cell
        } else {
            let optionName = kDLContainerSecondaryOptions[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonOptionTableViewCell", for: indexPath) as! PersonOptionTableViewCell
            cell.configureWithOptionName(name: optionName)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: - Table view delegate
    
    // select first row by default
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadingTable && tableView.indexPathsForVisibleRows?.last?.row == indexPath.row {
            isLoadingTable = false
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !menuEnabled { return }
        
        if indexPath.row == 0 {
            self.containerViewController.setContainedViewController(option: kDLContainerMainOption)
        } else {
            self.containerViewController.setContainedViewController(option: kDLContainerSecondaryOptions[indexPath.row - 1])
        }
    }
}
