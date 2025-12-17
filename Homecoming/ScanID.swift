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
    var body: some View {
        Text("ScanID")
        
        Rectangle()
            .frame(width: 600, height: 600)
            .foregroundStyle(Color.gray.opacity(0.6))
            .overlay {
                Text("Camera will go here")
            }
    }
}



#Preview {
    ScanID()
}
