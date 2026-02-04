//
//  Student.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/17/25.
//

import SwiftUI

class Student: Identifiable {
    let id = UUID()
    var name: String
    var ID: Int
    var email: String
    var grade: String
    var parentName: String
    var parentName2: String
    var parentPhoneNumber: String
    var timeCheckedIn: Date?
    var timeCheckedOut: Date?
    
    init(name: String, ID: Int, email: String, grade: String, parentName: String, parentName2: String, parentPhoneNumber: String, timeCheckedIn: Date? = nil, timeCheckedOut: Date? = nil) {
        self.name = name
        self.ID = ID
        self.email = email
        self.grade = grade
        self.parentName = parentName
        self.parentName2 = parentName2
        self.parentPhoneNumber = parentPhoneNumber
        self.timeCheckedIn = timeCheckedIn
        self.timeCheckedOut = timeCheckedOut
    }
}
