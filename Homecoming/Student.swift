//
//  Student.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/17/25.
//

import SwiftUI

class Student: Identifiable {
    let id = UUID()
    let altID: String
    var checkInTime: Date?
    var checkOutTime: Date?
    var checkedInOrOut: Bool
    let firstName: String
    let guestCheckIn: String
    let guestName: String
    let guestParentPhone: String
    let guestSchool: String
    let idNumber: Int
    let lastName: String
    let studentEmail: String
    let studentParentCell: String
    let studentParentFirstName: String
    let studentParentLastName: String
    let studentParentPhone: String
    
    init(altID: String, checkInTime: Date? = nil, checkOutTime: Date? = nil, checkedInOrOut: Bool, firstName: String, guestCheckIn: String, guestName: String, guestParentPhone: String, guestSchool: String, idNumber: Int, lastName: String, studentEmail: String, studentParentCell: String, studentParentFirstName: String, studentParentLastName: String, studentParentPhone: String) {
        self.altID = altID
        self.checkInTime = checkInTime
        self.checkOutTime = checkOutTime
        self.checkedInOrOut = checkedInOrOut
        self.firstName = firstName
        self.guestCheckIn = guestCheckIn
        self.guestName = guestName
        self.guestParentPhone = guestParentPhone
        self.guestSchool = guestSchool
        self.idNumber = idNumber
        self.lastName = lastName
        self.studentEmail = studentEmail
        self.studentParentCell = studentParentCell
        self.studentParentFirstName = studentParentFirstName
        self.studentParentLastName = studentParentLastName
        self.studentParentPhone = studentParentPhone
    }
}
