//
//  KSCaptureViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/25/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material
import AVFoundation

class KSCaptureViewController: UIViewController, CaptureViewDelegate, CaptureSessionDelegate {
    lazy var captureView: CaptureView = CaptureView()
    lazy var navigationBarView: NavigationBarView = NavigationBarView()
    lazy var cameraButton: FlatButton = FlatButton()
    lazy var videoButton: FlatButton = FlatButton()
    lazy var switchCamerasButton: FlatButton = FlatButton()
    //lazy var cameraCloseButton: FlatButton = FlatButton()
    lazy var flashButton: FlatButton = FlatButton()
    lazy var captureButton: FabButton = FabButton()
    
    var listingPic = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareCaptureButton()
        prepareCameraButton()
        prepareCloseButton()
        //prepareVideoButton()
        prepareSwitchCamerasButton()
        prepareFlashButton()
        prepareCaptureView()
        prepareNavigationBarView()
    }
    
    func captureViewDidPressCloseButton(captureView: CaptureView, button: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     :name:	captureSessionFailedWithError
     */
    func captureSessionFailedWithError(capture: CaptureSession, error: NSError) {
        print(error)
    }
    
    /**
     :name:	captureStillImageAsynchronously
     */
    func captureStillImageAsynchronously(capture: CaptureSession, image: UIImage) {
        print("Capture Image \(image)")
        listingPic = image
        performSegueWithIdentifier("segueToConfirmation", sender: self)
    }
    
    /**
     :name:	captureCreateMovieFileFailedWithError
     */
    func captureCreateMovieFileFailedWithError(capture: CaptureSession, error: NSError) {
        print("Capture Failed \(error)")
    }
    
    /**
     :name:	captureDidStartRecordingToOutputFileAtURL
     */
    func captureDidStartRecordingToOutputFileAtURL(capture: CaptureSession, captureOutput: AVCaptureFileOutput, fileURL: NSURL, fromConnections connections: [AnyObject]) {
        print("Capture Started Recording \(fileURL)")
        
        cameraButton.hidden = true
        videoButton.hidden = true
        switchCamerasButton.hidden = true
        flashButton.hidden = true
    }
    
    /**
     :name:	captureDidFinishRecordingToOutputFileAtURL
     */
    func captureDidFinishRecordingToOutputFileAtURL(capture: CaptureSession, captureOutput: AVCaptureFileOutput, outputFileURL: NSURL, fromConnections connections: [AnyObject], error: NSError!) {
        print("Capture Stopped Recording \(outputFileURL)")
        
        cameraButton.hidden = false
        videoButton.hidden = false
        switchCamerasButton.hidden = false
        flashButton.hidden = false
    }
    
    func captureViewDidStartRecordTimer(captureView: CaptureView) {
        navigationBarView.titleLabel!.text = "00:00:00"
        navigationBarView.titleLabel!.hidden = false
        navigationBarView.detailLabel!.hidden = false
    }
    
    /**
     :name:	captureViewDidUpdateRecordTimer
     */
    func captureViewDidUpdateRecordTimer(captureView: CaptureView, hours: Int, minutes: Int, seconds: Int) {
//        navigationBarView.titleLabel!.text = String(format: "%02i:%02i:%02i", arguments: [hours, minutes, seconds])
    }
    
    /**
     :name:	captureViewDidStopRecordTimer
     */
    func captureViewDidStopRecordTimer(captureView: CaptureView, hours: Int, minutes: Int, seconds: Int) {
        navigationBarView.titleLabel!.hidden = true
        navigationBarView.detailLabel!.hidden = true
    }
    
    /**
     :name:	captureSessionWillSwitchCameras
     */
    func captureSessionWillSwitchCameras(capture: CaptureSession, position: AVCaptureDevicePosition) {
        // ... do something
    }
    
    /**
     :name:	captureSessionDidSwitchCameras
     */
    func captureSessionDidSwitchCameras(capture: CaptureSession, position: AVCaptureDevicePosition) {
        var img: UIImage?
        if .Back == position {
            captureView.captureSession.flashMode = .Auto
            
            img = UIImage(named: "ic_flash_auto")
            flashButton.setImage(img, forState: .Normal)
            flashButton.setImage(img, forState: .Highlighted)
            
            img = UIImage(named: "ic_camera_front")
            switchCamerasButton.setImage(img, forState: .Normal)
            switchCamerasButton.setImage(img, forState: .Highlighted)
        } else {
            captureView.captureSession.flashMode = .Off
            
            img = UIImage(named: "ic_flash_off")
            flashButton.setImage(img, forState: .Normal)
            flashButton.setImage(img, forState: .Highlighted)
            
            img = UIImage(named: "ic_camera_rear")
            switchCamerasButton.setImage(img, forState: .Normal)
            switchCamerasButton.setImage(img, forState: .Highlighted)
        }
    }
    
    /**
     :name:	captureViewDidPressFlashButton
     */
    func captureViewDidPressFlashButton(captureView: CaptureView, button: UIButton) {
        if .Back == captureView.captureSession.cameraPosition {
            var img: UIImage?
            
            switch captureView.captureSession.flashMode {
            case .Off:
                img = UIImage(named: "ic_flash_on")
                captureView.captureSession.flashMode = .On
            case .On:
                img = UIImage(named: "ic_flash_auto")
                captureView.captureSession.flashMode = .Auto
            case .Auto:
                img = UIImage(named: "ic_flash_off")
                captureView.captureSession.flashMode = .Off
            }
            
            button.setImage(img, forState: .Normal)
            button.setImage(img, forState: .Highlighted)
        }
    }
    
    /**
     :name:	captureViewDidPressCameraButton
     */
    func captureViewDidPressCameraButton(captureView: CaptureView, button: UIButton) {
        //captureButton.backgroundColor = MaterialColor.blue.darken1.colorWithAlphaComponent(0.3)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     :name:	captureViewDidPressVideoButton
     */
    func captureViewDidPressVideoButton(captureView: CaptureView, button: UIButton) {
        captureButton.backgroundColor = MaterialColor.red.darken1.colorWithAlphaComponent(0.3)
    }
    
    /**
     :name:	captureViewDidPressCaptureButton
     */
    func captureViewDidPressCaptureButton(captureView: CaptureView, button: UIButton) {
        if .Photo == captureView.captureMode {
            // ... do something
        } else if .Video == captureView.captureMode {
            // ... do something
        }
    }
    
    /**
     :name:	captureViewDidPressSwitchCamerasButton
     */
    func captureViewDidPressSwitchCamerasButton(captureView: CaptureView, button: UIButton) {
        // ... do something
    }
    
    /**
     :name:	prepareView
     */
    private func prepareView() {
        view.backgroundColor = MaterialColor.black
    }
    
    /**
     :name:	prepareCaptureView
     */
    private func prepareCaptureView() {
        captureView.captureMode = .Photo
        view.addSubview(captureView)
        captureView.tapToFocusEnabled = true
        captureView.tapToExposeEnabled = true
        captureView.translatesAutoresizingMaskIntoConstraints = false
        captureView.delegate = self
        captureView.captureSession.delegate = self
        MaterialLayout.alignToParent(view, child: captureView)
    }
    
    /**
     :name:	prepareNavigationBarView
     */
    private func prepareNavigationBarView() {
        navigationBarView.backgroundColor = nil
        navigationBarView.depth = .None
        navigationBarView.statusBarStyle = .LightContent
        
        // Title label.
        let titleLabel: UILabel = UILabel()
        titleLabel.hidden = true
        titleLabel.textAlignment = .Center
        titleLabel.textColor = MaterialColor.white
        titleLabel.font = RobotoFont.regular
//        navigationBarView.titleLabel = titleLabel
        
        // Detail label.
        let detailLabel: UILabel = UILabel()
        detailLabel.hidden = true
        detailLabel.text = "Recording"
        detailLabel.textAlignment = .Center
        detailLabel.textColor = MaterialColor.red.accent1
        detailLabel.font = RobotoFont.regular
//        navigationBarView.detailLabel = detailLabel
//        
//        navigationBarView.leftControls = [switchCamerasButton]
//        navigationBarView.rightControls = [flashButton]
        
        view.addSubview(navigationBarView)
    }
    
    /**
     :name:	prepareCaptureButton
     */
    private func prepareCaptureButton() {
        captureButton.width = 72
        captureButton.height = 72
        captureButton.pulseColor = MaterialColor.white
        captureButton.backgroundColor = MaterialColor.white.colorWithAlphaComponent(0.3)
        captureButton.borderWidth =  2
        captureButton.borderColor = MaterialColor.white
        captureButton.depth = .None
        
        captureView.captureButton = captureButton
    }
    
    /**
     :name:	prepareCameraButton
     */
    private func prepareCameraButton() {
        let img4: UIImage? = UIImage(named: "ic_close_white")
        cameraButton.width = 72
        cameraButton.height = 72
        cameraButton.pulseColor = nil
        cameraButton.setImage(img4, forState: .Normal)
        cameraButton.setImage(img4, forState: .Highlighted)
        
        captureView.cameraButton = cameraButton
    }
    
    /**
     :name:	prepareVideoButton
     */
    private func prepareVideoButton() {
        let img5: UIImage? = UIImage(named: "ic_videocam_white_36pt")
        videoButton.width = 72
        videoButton.height = 72
        videoButton.pulseColor = nil
        videoButton.setImage(img5, forState: .Normal)
        videoButton.setImage(img5, forState: .Highlighted)
        
        captureView.videoButton = videoButton
    }
    
    /**
     :name:	prepareSwitchCamerasButton
     */
    private func prepareCloseButton() {
        let cameraCloseButton: FlatButton = FlatButton(frame: CGRect(x: 60, y: 30, width: 60, height: 30))
        let img: UIImage? = UIImage(named: "ic_close_white")
        cameraCloseButton.pulseColor = nil
        cameraCloseButton.setImage(img, forState: .Normal)
        cameraCloseButton.setImage(img, forState: .Highlighted)
        //cameraCloseButton.addTarget(self, action: "closeCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        captureView.addSubview(cameraCloseButton)
        
        //captureView.cameraCloseButton = cameraCloseButton
    }
    
    /**
     :name:	prepareSwitchCamerasButton
     */
    private func prepareSwitchCamerasButton() {
        let img: UIImage? = UIImage(named: "ic_camera_front")
        switchCamerasButton.pulseColor = nil
        switchCamerasButton.setImage(img, forState: .Normal)
        switchCamerasButton.setImage(img, forState: .Highlighted)
        
        captureView.switchCamerasButton = switchCamerasButton
    }
    
    /**
     :name:	prepareFlashButton
     */
    private func prepareFlashButton() {
        let img: UIImage? = UIImage(named: "ic_flash_auto")
        flashButton.pulseColor = nil
        flashButton.setImage(img, forState: .Normal)
        flashButton.setImage(img, forState: .Highlighted)
        
        captureView.captureSession.flashMode = .Auto
        captureView.flashButton = flashButton
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let capturedImage = listingPic
        
        let confirmViewController = segue.destinationViewController as! KSConfirmViewController
        confirmViewController.imageToPost = capturedImage
    }
}