//
//  ScanID.swift
//  Homecoming
//
//  Created by George Koroulis on 12/15/25.
//

import SwiftUI
import AVFoundation
import UIKit

struct ScanID: View {

    @Environment(StudentViewModel.self) var viewModel
    @State var alternateID: String = "Waiting for Barcode…"
    @State var email = ""

    var body: some View {
        ZStack(alignment: .bottom) {

            CameraScannerView { code in
                alternateID = code.trimmingCharacters(in: .whitespacesAndNewlines)
                viewModel.setScannedAltID(alternateID)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(spacing: 8) {
                Text("Scanned Alt ID: \(alternateID)")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)

                if let student = viewModel.scannedStudent {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Name: \(student.firstName) \(student.lastName)")
                        Text("Email: \(student.studentEmail)")
                        Text("Alt ID: \(student.altID)")
                        Text("Checked In: \(student.checkedInOrOut ? "Yes" : "No")")
                        Text("Guest Name: \(student.guestName)")
                        Text("Guest School: \(student.guestSchool)")
                        Text("Parent: \(student.studentParentFirstName) \(student.studentParentLastName)")
                        Text("Parent Phone: \(student.studentParentPhone)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.7))
                    .cornerRadius(10)
                } else {
                    Text("Fetching student info…")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black.opacity(0.7))
                }
            }
            .padding(.bottom, 24)
            .padding(.horizontal)
        }
        .ignoresSafeArea()
    }

    func sendEmail(to studentEmail: String) {
        let subject = "Homecoming Ticket Receipt"
        let body = "Thank you \(alternateID) for purchasing your Homecoming ticket!\n\nThis is a confirmation of your purchase. Please bring your ID to Homecoming to enter."

        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let mailToString = "mailto:\(studentEmail)?subject=\(encodedSubject)&body=\(encodedBody)"

        if let url = URL(string: mailToString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ScanID()
        .environment(StudentViewModel())
}
