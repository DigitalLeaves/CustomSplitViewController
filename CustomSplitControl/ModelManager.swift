//
//  ModelManager.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit
import CoreLocation

enum ModelFieldType: String {
    case name = "name"
    case email = "email"
    case birthDate = "birth date"
    case phoneNumber = "phone number"
    case image = "image"
    case maritalStatus = "marital status"
    case address = "address"
    case userId = "userId"
    case password = "password"
}

// quick singleton implementation for our ModelManager.
private let _singletonInstance = ModelManager()

class ModelManager: NSObject {
    // shared instance of ModelManager.
    class var sharedInstance: ModelManager { return _singletonInstance }

    var people: [Person] = []
    
    override init() {
        super.init()
        // initialize list of people
        let anneWhite = Person(userId: "vn38jfw3dfl934y", password: "2233", name: "Anne White", email: "anne.white24@example.com", birthDate: Person.birthDateFromString(dateString: "6/6/1981"), phoneNumber: "(561)-923-6958", image: UIImage(named: "anneWhite"), maritalStatus: "single", address: "3605 James St, Syracuse, NY 13206, USA")
        let warrenStanley = Person(userId: "sljh398ev234uvb", password: "mylife", name: "Warren Stanley", email: "warren.stanley53@example.com", birthDate: Person.birthDateFromString(dateString: "6/7/1971"), phoneNumber: "(611)-453-8251", image: UIImage(named: "warrenStanley"), maritalStatus: "married", address: "7963 Timber Wolf Trail, Plano, Texas 75093-8095, United States")
        let claireCrawford = Person(userId: "vbhf387vf8r3oand62", password: "floppy", name: "Claire Crawford", email: "claire.crawford78@example.com", birthDate: Person.birthDateFromString(dateString: "7/4/1979"), phoneNumber: "(188)-345-8879", image: UIImage(named: "claireCrawford"), maritalStatus: "divorced", address: "1499 Camp Street, Dover, Arkansas 72837-8850, United States")
    
        people = [anneWhite, warrenStanley, claireCrawford]
    }
    
    func personModified(person: Person) {
        for i in 0..<people.count {
            if people[i].userId == person.userId { people[i] = person }
        }
    }
}
