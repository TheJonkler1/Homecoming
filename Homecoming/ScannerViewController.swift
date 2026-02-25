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
    var previewLayer: AVCaptureVideoPreviewLayer!
    var lastScannedValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        updateVideoOrientation()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.previewLayer.frame = self.view.bounds
            self.updateVideoOrientation()
        })
    }
    
    func setupCamera() {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input) else {
            session.commitConfiguration()
            return
        }
        session.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = [.code39]
        }
        
        session.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(previewLayer, at: 0)
        
        updateVideoOrientation()
        session.startRunning()
    }
    
    func updateVideoOrientation() {
        guard let previewLayer = previewLayer else { return }
        
        let deviceOrientation = UIDevice.current.orientation
        let angle: CGFloat
        
        switch deviceOrientation {
        case .portrait:
            angle = 0
        case .portraitUpsideDown:
            angle = .pi
        case .landscapeLeft:
            angle = -.pi / 2
        case .landscapeRight:
            angle = .pi / 2
        default:
            angle = 0
        }
        previewLayer.setAffineTransform(CGAffineTransform(rotationAngle: angle))
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let value = object.stringValue else { return }
        
        guard value != lastScannedValue else { return }
        lastScannedValue = value
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        onScan?(value)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if session.isRunning {
            session.stopRunning()
        }
    }
}
