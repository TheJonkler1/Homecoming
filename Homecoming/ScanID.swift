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
    let email = "gkoroulis7201@stu.d214.org"
    var body: some View {
        Text("ScanID")
        
        Rectangle()
            .frame(width: 600, height: 600)
            .foregroundStyle(Color.gray.opacity(0.6))
            .overlay {
                Text("Camera will go here")
            }
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
