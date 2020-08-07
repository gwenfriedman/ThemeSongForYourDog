//
//  VideoController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/4/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit
import AVFoundation
import Soundable


class VideoController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
    
    @IBOutlet weak var captureButton    : SwiftyRecordButton!
    
//    var ravenclaw: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 50.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        flashMode = .auto
        captureButton.buttonEnabled = false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did start running")
        captureButton.buttonEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did stop running")
        captureButton.buttonEnabled = false
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        captureButton.growButton()
        
//        let fileURL = Bundle.main.path(forResource: "R", ofType: "mp3")!
//        let url = URL(fileURLWithPath: fileURL)
//
//        let fileURL1 = Bundle.main.path(forResource: "meloD-1", ofType: "mp3")!
//       let url1 = URL(fileURLWithPath: fileURL1)
        do {
            
            let sound1 = Sound(fileName: "1.mp3")
            let sound2 = Sound(fileName: "2.mp3")
            let sound3 = Sound(fileName: "3.mp3")
            let sound4 = Sound(fileName: "4.mp3")
            let sound5 = Sound(fileName: "5.mp3")
            let sound6 = Sound(fileName: "6.mp3")
            let sound7 = Sound(fileName: "7.mp3")
            let sound8 = Sound(fileName: "8.mp3")
            let sound9 = Sound(fileName: "9.mp3")
            let sound10 = Sound(fileName: "10.mp3")
            let sound11 = Sound(fileName: "11.mp3")
            let sound12 = Sound(fileName: "12.mp3")
        

//            let sounds = [sound1, sound2, sound3, sound4, sound5, sound6, sound7, sound8, sound9, sound10, sound11, sound12]
//            sounds.play()
            
            let soundsQueue = SoundsQueue(sounds: [sound1, sound2, sound3, sound4, sound5, sound6, sound7, sound8, sound9, sound10, sound11, sound12])
            soundsQueue.play()
            
            
            if(ViewController.GlobalVariable.songNumber > 4000000000) {
                let ravenclaw = Sound(fileName: "bg.mp3")
                ravenclaw.play()
            }

        } catch {
            // couldn't load file :(
        }
        print("play song")
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        Soundable.stopAll()
        captureButton.shrinkButton()
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print("Zoom level did change. Level: \(zoom)")
        print(zoom)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print("Camera did change to \(camera.rawValue)")
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
}
