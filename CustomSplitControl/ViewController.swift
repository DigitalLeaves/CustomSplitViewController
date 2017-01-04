//
//  ViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // outlets
    @IBOutlet weak var peopleTableView: UITableView!
    
    // data
    var selectedPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register table view nib
        peopleTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
        // set table view cell heights
        self.peopleTableView.estimatedRowHeight = 100.0
        self.peopleTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.peopleTableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mvc = segue.destination as? MainViewController {
            mvc.person = selectedPerson
        }
    }
    
    // MARK: - UITableViewDelegate/DataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.sharedInstance.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        let person = ModelManager.sharedInstance.people[indexPath.row]
        cell.configureWithPerson(person: person)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPerson = ModelManager.sharedInstance.people[indexPath.row]
        performSegue(withIdentifier: "showPerson", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}
