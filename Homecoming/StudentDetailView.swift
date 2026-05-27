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
        ZStack {
            
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.12, green: 0.0, blue: 0.22),
                    Color(red: 0.35, green: 0.0, blue: 0.55)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    if let student = viewModel.scannedStudent {
                        
                        VStack(spacing: 14) {
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 90, height: 90)
                                .overlay(
                                    Text(String(student.firstName.prefix(1)))
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundColor(.white)
                                )
                                .shadow(color: .purple.opacity(0.5), radius: 12)
                            
                            Text("\(student.firstName) \(student.lastName)")
                                .font(.title.bold())
                                .foregroundColor(.white)
                            
                            Text(student.studentEmail)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.75))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 28)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.ultraThinMaterial.opacity(0.7))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    LinearGradient(
                                        colors: [.white.opacity(0.35), .purple.opacity(0.5)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 15, y: 10)
                        
                        VStack(spacing: 18) {
                            
                            detailRow(
                                title: "Alt ID",
                                value: student.altID,
                                icon: "person.text.rectangle"
                            )
                            
                            detailRow(
                                title: "Status",
                                value: student.checkedInOrOut,
                                icon: "checkmark.seal.fill",
                                valueColor: statusColor(for: student.checkedInOrOut)
                            )
                            
                        }
                        .padding(22)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.white.opacity(0.08))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(.white.opacity(0.12), lineWidth: 1)
                        )
                        
                        VStack(spacing: 20) {
                            
                            if student.checkedInOrOut == "-" {
                                
                                VStack(alignment: .leading, spacing: 14) {
                                    
                                    Text("Payment Method")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Picker("Payment Method", selection: $paymentMethod) {
                                        Text("Cash").tag("Cash")
                                        Text("Card").tag("Card")
                                    }
                                    .pickerStyle(.segmented)
                                    
                                }
                                
                                Button {
                                    viewModel.toggleCheckInStatus(paymentMethod: paymentMethod)
                                    sendEmail(to: student.studentEmail)
                                } label: {
                                    HStack {
                                        Image(systemName: "ticket.fill")
                                        Text("Purchase Complete")
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.green, .mint],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(color: .green.opacity(0.45), radius: 12)
                                
                            } else if student.checkedInOrOut == "Purchased" {
                                
                                Button {
                                    viewModel.toggleCheckInStatus(paymentMethod: paymentMethod)
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.right.circle.fill")
                                        Text("Check In")
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(color: .blue.opacity(0.45), radius: 12)
                                
                            } else if student.checkedInOrOut == "Checked In" {
                                
                                Button {
                                    viewModel.toggleCheckInStatus(paymentMethod: nil)
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.left.circle.fill")
                                        Text("Check Out")
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                }
                                .background(
                                    LinearGradient(
                                        colors: [.orange, .red],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(color: .orange.opacity(0.45), radius: 12)
                                
                            } else {
                                
                                Text("Student is already checked out.")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding()
                            }
                        }
                        .padding(22)
                        .background(
                            RoundedRectangle(cornerRadius: 28)
                                .fill(.white.opacity(0.08))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(.white.opacity(0.12), lineWidth: 1)
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Ticket Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func detailRow(
        title: String,
        value: String,
        icon: String,
        valueColor: Color = .white
    ) -> some View {
        
        HStack(spacing: 14) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.65))
                
                Text(value)
                    .font(.headline)
                    .foregroundColor(valueColor)
            }
            
            Spacer()
        }
    }
    
    func statusColor(for status: String) -> Color {
        switch status {
        case "-":
            return .yellow
        case "Purchased":
            return .green
        case "Checked In":
            return .blue
        default:
            return .gray
        }
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
