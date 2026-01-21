//
//  StudentListView.swift
//  Homecoming
//
//  Created by George Koroulis on 12/17/25.
//

import SwiftUI

struct StudentListView: View {
    @State private var people: [Student] = []
    var body: some View {
        Button("Add Student") {
            people.append(Student(name: "New Student", ID: 123456, email: "new@student.com", grade: "10", parentName: "New Parent", parentName2: "New Parent 2", parentPhoneNumber: "Phone Number"))
        }
        List {
            ForEach(people) { person in
                Text(person.name)
            }
        }
    }
}

