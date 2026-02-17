//
//  StudentListView.swift
//  Homecoming
//
//  Created by George Koroulis on 12/17/25.
//

import SwiftUI

struct StudentListView: View {
    
    @Environment(StudentViewModel.self) var viewModel
    @State var search = ""
    
    var filteredStudents: [Student] {
        if search.isEmpty {
            return viewModel.students
        } else {
            return viewModel.students.filter {
                $0.firstName.lowercased().contains(search.lowercased()) ||
                $0.lastName.lowercased().contains(search.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            
            TextField("Enter Name", text: $search)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            List {
                ForEach(filteredStudents) { person in
                    Text(person.firstName + " " + person.lastName)
                }
            }
        }
    }
}
