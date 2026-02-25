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
    @State var ListView: [Student] = []
    
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

            Button("Search") {
                viewModel.setSearchLastName(search)
                if let student = viewModel.searchedStudent {
                    for student in viewModel.students2 {
                        if search.lowercased() == student.firstName.lowercased() ||
                            search.lowercased() == student.lastName.lowercased() {
                            print(String(student.idNumber) + " " + String(student.altID))
                            ListView.append(student)
                        } else if search == " " {
                            ListView = viewModel.students2
                        }
                    }
                }
            }
            List {
                ForEach(ListView) { person in
                    Text(person.firstName + " " + person.lastName)
                }
            }
            
        }
    }
}
