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

                    if student.checkedInOrOut == "-" {
                        Picker("Payment Method", selection: $paymentMethod) {
                            Text("Cash").tag("Cash")
                            Text("Card").tag("Card")
                        }
                        .pickerStyle(.segmented)

                        Button("Purchase Complete") {
                            viewModel.toggleCheckInStatus(paymentMethod: paymentMethod)
                            sendEmail(to: student.studentEmail)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.green)
                        .padding(.top)

                    } else if student.checkedInOrOut == "Purchased" {
                        Button("Check In") {
                            viewModel.toggleCheckInStatus(paymentMethod: paymentMethod)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.blue)

                    } else if student.checkedInOrOut == "Checked In" {
                        Button("Check Out") {
                            viewModel.toggleCheckInStatus(paymentMethod: nil)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.orange)

                    } else {
                        Text("Student is already checked out.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Ticket Details")
    }

    func sendEmail(to studentEmail: String) {
        if let student = viewModel.scannedStudent {
            let subject = "Homecoming Ticket Receipt"
            let body = """
            Thank you \(student.firstName) \(student.lastName) for purchasing your Homecoming ticket!

            This is a confirmation of your purchase at \(student.checkInTime ?? Date()). Please bring your ID to Homecoming to enter. Note that this email is only a receipt for your ticket and cannot be used as a ticket.

            If you have any questions, comments, or concerns, please email Mrs. Monahan at laura.monahan@d214.org or visit her in the ARC.

            Happy Homecoming!
            """

            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

            let mailToString = "mailto:\(studentEmail)?subject=\(encodedSubject)&body=\(encodedBody)"

            if let url = URL(string: mailToString) {
                UIApplication.shared.open(url)
            }
        }
    }
}
