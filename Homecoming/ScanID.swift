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
    @State var scannedText: String = "Waiting for QR code…"
    var body: some View {
        Text("ScanID")
        VStack {
            CameraScannerView { code in
                scannedText = code
            }
            
            VStack {
                Spacer()
                
                Text(scannedText)
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
        let body = "Thank you [student name] for purchasing your [year] Homecoming ticket! \n\n This is a confirmation of your $[price] purchase, placed on [mm/dd/yyyy] at [time]. If this was not you, please contact Ms. Monahan at laura.monahan@d214.org or visit her in the ARC in room 123. \n\n ~ John Hersey High School"
        
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
