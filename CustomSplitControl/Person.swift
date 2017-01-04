//
//  Person.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class Person: NSObject {
    // credentials
    var userId: String
    var password: String

    // personal information
    var name: String!
    var email: String!
    var birthDate: Date!
    var phoneNumber: String!
    var image: UIImage!
    var maritalStatus: String!
    
    // location
    var address: String!
    
    init(userId: String, password: String, name: String!, email: String!, birthDate: Date!, phoneNumber: String!, image: UIImage!, maritalStatus: String!, address: String!) {
        self.userId = userId
        self.password = password
        self.name = name
        self.email = email
        self.birthDate = birthDate
        self.phoneNumber = phoneNumber
        self.image = image
        self.maritalStatus = maritalStatus
        self.address = address
    }

    func valueForField(field: ModelFieldType) -> Any {
        switch field {
        case .name: return name
        case .email: return email
        case .birthDate: return birthDate
        case .phoneNumber: return phoneNumber
        case .image: return image
        case .maritalStatus: return maritalStatus
        case .address: return address
        case .userId: return userId
        case .password: return password
        }
    }
    
    func stringValueForField(field: ModelFieldType) -> String {
        if field != .birthDate { return valueForField(field: field) as? String ?? "-" }
        else {
            guard let date = birthDate else { return "-" }
            return Person.birthDateStringFromDate(date: date)
        }
    }
    
    func setValue(value: Any, forField field: ModelFieldType) {
        switch field {
        case .name: if let name = value as? String { self.name = name }
        case .email: if let email = value as? String { self.email = email }
        case .birthDate:
            if let birthDate = value as? Date { self.birthDate = birthDate }
            else if let bdString = value as? String, let bdFromString = Person.birthDateFromString(dateString: bdString) { self.birthDate = bdFromString }
        case .phoneNumber: if let phoneNumber = value as? String { self.phoneNumber = phoneNumber }
        case .image: if let image = value as? UIImage { self.image = image }
        case .maritalStatus: if let maritalStatus = value as? String { self.maritalStatus = maritalStatus }
        case .address: if let address = value as? String { self.address = address }
        case .userId: if let userId = value as? String { self.userId = userId }
        case .password: if let password = value as? String { self.password = password }
        }
    }
    
    // MARK: - Hashable/Equatable
    override var hash: Int { return userId.hash }
    override var hashValue: Int { return userId.hashValue }
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherPerson = object as? Person else { return false }
        return otherPerson == self
    }
    
    static var _birthDateFormatter: DateFormatter?
    fileprivate static var birthDateFormatter: DateFormatter {
        if (_birthDateFormatter == nil) {
            _birthDateFormatter = DateFormatter()
            _birthDateFormatter!.locale = Locale(identifier: "en_US_POSIX")
            _birthDateFormatter!.dateFormat = "MM/dd/yyyy"
        }
        return _birthDateFormatter!
    }
    static func birthDateFromString(dateString: String) -> Date? {
        return birthDateFormatter.date(from: dateString)
    }
    static func birthDateStringFromDate(date: Date) -> String {
        return birthDateFormatter.string(from: date)
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.userId == rhs.userId
}


