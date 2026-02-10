//
//  StudentListView.swift
//  Homecoming
//
//  Created by George Koroulis on 12/17/25.
//

import SwiftUI

struct StudentListView: View {
    @Environment(StudentViewModel.self) var viewModel

    @State private var people: [Student] = []
    var body: some View {
        Button("Add Student") {
            people.append(Student(altID: 123456, checkedInOrOut: false, firstName: "George", guestCheckIn: "12:00", guestName: "N/A", guestParentPhone: "000-000-0000", guestSchool: "N/A", idNumber: 123456, lastName: "Koroulis", studentEmail: "gkoroulis7201@stu.d214.org", studentParentCell: "000-000-0000", studentParentFirstName: "Dad", studentParentLastName: "Koroulis", studentParentPhone: "000-000-0000"))
        }
        List {
            ForEach(people) { person in
                Text(person.firstName + " " + person.lastName)
            }
        }
    }
}

