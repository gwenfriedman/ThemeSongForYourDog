//
//  VideoController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/4/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit
import AVFoundation


class VideoController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
    
    @IBOutlet weak var captureButton    : SwiftyRecordButton!
    
    var ravenclaw: AVAudioPlayer = AVAudioPlayer()
    var m1: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 30.0
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
        
        let fileURL = Bundle.main.path(forResource: "R", ofType: "mp3")!
        let url = URL(fileURLWithPath: fileURL)
        
        let fileURL1 = Bundle.main.path(forResource: "meloD-1", ofType: "mp3")!
       let url1 = URL(fileURLWithPath: fileURL1)
        do {
            if(ViewController.GlobalVariable.songNumber > 4000000000) {
//            ravenclaw = try AVAudioPlayer(contentsOf: url)
//            ravenclaw.play()
//
//            m1 = try AVAudioPlayer(contentsOf: url1)
//            m1.play()
                
            var anArrayOfAVPlayerItems = [
                    AVPlayerItem(url: Bundle.main.url(forResource: "meloD-1", withExtension: "mp3")!),
                    AVPlayerItem(url: Bundle.main.url(forResource: "meloD-2", withExtension: "mp3")!),
                    AVPlayerItem(url: Bundle.main.url(forResource: "meloD-3", withExtension: "mp3")!)
            ]

                let queuePlayer = AVQueuePlayer(items: anArrayOfAVPlayerItems)
                print(anArrayOfAVPlayerItems)
                print(queuePlayer)
                queuePlayer.play()
                
            }
            
            
//            let soundsArray = ["R", "meloD-1", "meloD-2", "meloD-3", "meloD-4"]
//            var audioItems: [AVPlayerItem] = []
//            for audioName in soundsArray {
//                let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!)
//                let item = AVPlayerItem(url: url as URL)
//                audioItems.append(item)
//            }
            
//            var anArrayOfAVPlayerItems = [
//                AVPlayerItem(url: Bundle.main.url(forResource: "meloD-1", withExtension: "mp3")!),
//                AVPlayerItem(url: Bundle.main.url(forResource: "meloD-2", withExtension: "mp3")!),
//                AVPlayerItem(url: Bundle.main.url(forResource: "meloD-3", withExtension: "mp3")!)
//        ]
//
//            print(anArrayOfAVPlayerItems)
//            let queuePlayer = AVQueuePlayer(items: anArrayOfAVPlayerItems)
//            queuePlayer.play()

        } catch {
            // couldn't load file :(
        }
        print("play song")
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        captureButton.shrinkButton()
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        let newVC = VideoViewController(videoURL: url)
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
