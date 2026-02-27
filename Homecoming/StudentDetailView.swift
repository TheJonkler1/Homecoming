//
//  StudentDetailView.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 2/23/26.
//
import SwiftUI

struct StudentDetailView: View {
    @Environment(StudentViewModel.self) var viewModel
    @State var paymentMethod: String = "Cash"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let student = viewModel.scannedStudent {
                    Text("Name: \(student.firstName) \(student.lastName)")
                    Text("Email: \(student.studentEmail)")
                    Text("Alt ID: \(student.altID)")
                    Text("Status: \(student.checkedInOrOut)")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    if student.checkedInOrOut == "Purchased" {
                        Picker("Payment Method", selection: $paymentMethod) {
                            Text("Cash").tag("Cash")
                            Text("Card").tag("Card")
                            Text("Online").tag("Online")
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Button(student.checkedInOrOut == "Purchased" ? "Mark Paid & Check In" : "Toggle Check-in Status") {
                        viewModel.toggleCheckInStatus(paymentMethod: student.checkedInOrOut == "Purchased" ? paymentMethod : nil)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(student.checkedInOrOut == "Purchased" ? .green : .blue)
                }
            }
            .padding()
        }
        .navigationTitle("Ticket Details")
    }
}
