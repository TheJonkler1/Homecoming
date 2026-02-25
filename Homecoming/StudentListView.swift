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
                .onSubmit {
                    for student in viewModel.students {
                        if search.lowercased() == student.firstName.lowercased() ||
                            search.lowercased() == student.lastName.lowercased() {
                            print(String(student.idNumber) + " " + String(student.altID))
                            ListView.append(student)
                        }
                    }
                }
            
            //            TextField("Enter Name", text: $search)
            //                .textFieldStyle(.roundedBorder)
            //                .padding()
            //
            //                        List {
            //                            ForEach(filteredStudents) { person in
            //                                Text(person.firstName + " " + person.lastName)
            //                            }
            //
            //                            List {
            //                                ForEach(filteredStudents) { person in
            //                                    Text(person.firstName + " " + person.lastName)
            //                                }
            //                            }
            //                            List {
            //                                ForEach(filteredStudents) { person in
            //                                    Text(person.firstName + " " + person.lastName)
            //                                }
            //                            }
            //                        }
        }
    }
}
