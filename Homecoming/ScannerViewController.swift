//
//  ScannerViewController.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 1/21/26.
//

import UIKit
import AVFoundation

final class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var onScan: ((String) -> Void)?
    
    let session = AVCaptureSession()
    var lastScannedValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        session.beginConfiguration()
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: .main)
            
            output.metadataObjectTypes = [
                .code128,
                .code39,
                .code39Mod43,
                .ean8,
                .ean13,
                .upce,
                .pdf417,
                .dataMatrix
            ]
        }
        
        session.commitConfiguration()
        
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        preview.frame = view.bounds
        view.layer.addSublayer(preview)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let value = object.stringValue else { return }
        
        guard value != lastScannedValue else { return }
        lastScannedValue = value
        
        onScan?(value)
    }
}
