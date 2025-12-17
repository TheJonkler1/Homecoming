//
//  GuestApplication.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 12/17/25.
//

import SwiftUI

struct GuestApplication: View {
    @State var guestName: String = ""
    @State var guestPhone: String = ""
    @State var guestGrade: String = ""
    @State var guestSchool: String = ""
    @State var guestEmail: String = ""
    @State var guestAge: String = ""
    @State var paymentMethod: String = ""

    var body: some View {
        VStack {
            TextField("Name", text: $guestName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Phone", text: $guestPhone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Grade", text: $guestGrade)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("School", text: $guestSchool)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $guestEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Age", text: $guestAge)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
           
            TextField("Payment Method (Cash or Card)", text: $paymentMethod)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            HStack{
                Button("Back") {
                    
                }
                Button("Save") {
                    
                }
            }
        }
    }
    
    func saveGuestInfo() {
        let storedGuestName = guestName
        let storedGuestAge = guestAge
        let storedGuestGrade = guestGrade
        let storedGuestSchool = guestSchool
        let storedPaymentMethod = paymentMethod
    }
}

