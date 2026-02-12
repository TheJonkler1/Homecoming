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

    @State var alternateID: String = "Waiting for QR code…"
    @State var email = "gkoroulis7201@stu.d214.org"
    var body: some View {
        Text("ScanID")
        VStack {
            CameraScannerView { code in
                alternateID = code
                print(alternateID)
            }
            
            VStack {
                Spacer()
                
                Text(alternateID)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
    
    func sendEmail() {
        let subject = "Homecoming Ticket Receipt"
        let body = "Thank you [student name] for purchasing your [year] Homecoming ticket! \n\n This is a confirmation of your $[price] purchase, placed on [mm/dd/yyyy] at [time], however please note that this reciept is not your ticket. You must bring your ID to Homecoming in order to enter. If this was not you, please contact Ms. Monahan at laura.monahan@d214.org or visit her in the ARC in room 123. \n\n ~ John Hersey High School"
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let mailToString = "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)"
        
        if let url = URL(string: mailToString) {
            UIApplication.shared.open(url)
        }
        
    }
    
}

#Preview {
    ScanID()
}
