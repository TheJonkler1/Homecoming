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
        
        ZStack {
            
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.10, green: 0.0, blue: 0.20),
                    Color(red: 0.35, green: 0.0, blue: 0.55)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 22) {
                
                VStack(spacing: 18) {
                    
                    Text("Student Lookup")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Text("Search students for Homecoming tickets")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    
                    HStack(spacing: 14) {
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.7))
                            
                            TextField("Enter Name", text: $search)
                                .foregroundColor(.white)
                                .tint(.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(.white.opacity(0.12))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(.white.opacity(0.12), lineWidth: 1)
                        )
                        
                        Button {
                            
                            ListView.removeAll()
                            
                            viewModel.setSearchLastName(search)
                            viewModel.setSearchFirstName(search)
                            
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
                            
                        } label: {
                            
                            Image(systemName: "arrow.right")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                                .frame(width: 55, height: 55)
                                .background(
                                    LinearGradient(
                                        colors: [.purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(color: .purple.opacity(0.5), radius: 10)
                        }
                    }
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial.opacity(0.75))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.12), lineWidth: 1)
                )
                .padding(.horizontal)
                
                ScrollView {
                    
                    LazyVStack(spacing: 16) {
                        
                        ForEach(ListView) { person in
                            
                            HStack(spacing: 16) {
                                
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.purple, .pink],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 58, height: 58)
                                    .overlay(
                                        Text(String(person.firstName.prefix(1)))
                                            .font(.title3.bold())
                                            .foregroundColor(.white)
                                    )
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    Text(person.firstName + " " + person.lastName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text("Alt ID: \(person.altID)")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white.opacity(0.08))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white.opacity(0.10), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.2), radius: 10, y: 6)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 6)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top)
        }
    }
}
