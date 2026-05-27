//
//  GuestApplication.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 12/17/25.
//

import SwiftUI

struct GuestApplication: View {
    @Environment(StudentViewModel.self) var viewModel
    
    @State var guestName: String = ""
    @State var guestPhone: String = ""
    @State var guestGrade: String = ""
    @State var guestSchool: String = ""
    @State var guestEmail: String = ""
    @State var guestAge: String = ""
    @State var paymentMethod: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.30, green: 0.16, blue: 0.10),
                        Color(red: 0.92, green: 0.48, blue: 0.12),
                        Color(red: 0.98, green: 0.95, blue: 0.92)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 18) {
                        VStack(spacing: 10) {
                            Image(systemName: "pawprint.fill")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("Guest Application")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                            
                            Text("Hersey Homecoming Guest Form")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 14) {
                            styledField(title: "Name", text: $guestName)
                            styledField(title: "Phone", text: $guestPhone, keyboardType: .phonePad)
                            styledField(title: "Grade", text: $guestGrade)
                            styledField(title: "School", text: $guestSchool)
                            styledField(title: "Email", text: $guestEmail, keyboardType: .emailAddress)
                            styledField(title: "Age", text: $guestAge, keyboardType: .numberPad)
                            styledField(title: "Payment Method", text: $paymentMethod)
                        }
                        .padding()
                        .background(.white.opacity(0.14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white.opacity(0.18), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        
                        HStack(spacing: 14) {
                            Button {
                                
                            } label: {
                                actionButton(title: "Back", systemImage: "chevron.left")
                            }
                            
                            Button {
                                saveGuestInfo()
                            } label: {
                                actionButton(title: "Save", systemImage: "checkmark.circle.fill")
                            }
                        }
                    }
                    .padding()
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
    
    func saveGuestInfo() {
        let storedGuestName = guestName
        let storedGuestAge = guestAge
        let storedGuestGrade = guestGrade
        let storedGuestSchool = guestSchool
        let storedPaymentMethod = paymentMethod
    }
    
     func styledField(title: String, text: Binding<String>, keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
            
            TextField(title, text: text)
                .keyboardType(keyboardType)
                .padding()
                .background(.white.opacity(0.92))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
     func actionButton(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
        }
        .font(.headline)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.92, green: 0.48, blue: 0.12),
                    Color(red: 0.30, green: 0.16, blue: 0.10)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 5)
    }
}
