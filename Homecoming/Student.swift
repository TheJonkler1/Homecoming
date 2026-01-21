//
//  Student.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/17/25.
//

import SwiftUI

struct Student: Identifiable {
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
}
