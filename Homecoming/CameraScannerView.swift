//
//  CameraScannerView.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 1/21/26.
//

import SwiftUI
import AVFoundation

struct CameraScannerView: UIViewControllerRepresentable {
    var onScan: (String) -> Void
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let controller = ScannerViewController()
        controller.onScan = onScan
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
}
