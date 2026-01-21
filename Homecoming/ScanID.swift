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
}

#Preview {
    ScanID()
}
