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
    @State var showDetail = false

    var body: some View {
        ZStack(alignment: .bottom) {
            CameraScannerView { code in
                alternateID = code.trimmingCharacters(in: .whitespacesAndNewlines)
                viewModel.setScannedAltID(alternateID)
                showDetail = true
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 14) {
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.title2.weight(.bold))
                        Text("Scan ID")
                            .font(.headline.bold())
                    }
                    .foregroundStyle(.white)
                    
                    Text("Hersey Homecoming Check-In")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.top, 14)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Scanned Alt ID")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.85))
                    
                    Text(alternateID)
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.black.opacity(0.55))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.12), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                if let student = viewModel.scannedStudent {
                    VStack(alignment: .leading, spacing: 8) {
                        infoRow(title: "Name", value: "\(student.firstName) \(student.lastName)")
                        infoRow(title: "Email", value: student.studentEmail)
                        infoRow(title: "Alt ID", value: student.altID)
                        infoRow(title: "Status", value: student.checkedInOrOut)
                        infoRow(title: "Guest Name", value: student.guestName)
                        infoRow(title: "Guest School", value: student.guestSchool)
                        infoRow(title: "Parent", value: "\(student.studentParentFirstName) \(student.studentParentLastName)")
                        infoRow(title: "Parent Phone", value: student.studentParentPhone)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white.opacity(0.92))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.92, green: 0.48, blue: 0.12).opacity(0.35), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 6)
                } else {
                    HStack(spacing: 10) {
                        ProgressView()
                            .tint(.white)
                        Text("Fetching student info…")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.55))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.30, green: 0.16, blue: 0.10).opacity(0.92),
                        Color(red: 0.92, green: 0.48, blue: 0.12).opacity(0.86)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(.white.opacity(0.16), lineWidth: 1)
            )
            .padding()
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(isPresented: $showDetail) {
                StudentDetailView()
            }
        }
    }
    
    func sendEmail(to studentEmail: String) {
        if let student = viewModel.scannedStudent {
            let subject = "Homecoming Ticket Receipt"
            let body = "Thank you \(student.firstName + " " + student.lastName) for purchasing your Homecoming ticket!\n\nThis is a confirmation of your purchase at \(student.checkInTime). Please bring your ID to Homecoming to enter. Note that this email is only a reciept for your ticket, but cannot be used as a ticket. If you have any questions, comments, or concerns, please email Mrs. Monahan at [laura.monahan@d214.org](mailto:laura.monahan@d214.org) or visit her in the ARC.\n\nHappy Homecoming!"
            
            let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let mailToString = "mailto:\(student.studentEmail)?subject=\(encodedSubject)&body=\(encodedBody)"
            
            if let url = URL(string: mailToString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color(red: 0.30, green: 0.16, blue: 0.10).opacity(0.8))
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    ScanID()
        .environment(StudentViewModel())
}
