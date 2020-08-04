//
//  MusicViewController.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/16/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AVKit
import AVFoundation


class MusicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    //MUSIC PLAYER
//    //var player:AVAudioPlayer = AVAudioPlayer()
//
//    //var player2:AVAudioPlayer = AVAudioPlayer()
//
//    var drum: AVAudioPlayer = AVAudioPlayer()
//
//    var guitar: AVAudioPlayer = AVAudioPlayer()
//
//    var songNumber2 = ViewController.GlobalVariable.songNumber
//
//    let audioSession = AVAudioSession.sharedInstance()
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    let saveFileName = "/test.mp4"
    
    // MARK: ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Record a video
    @IBAction func recordVideo(_ sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                
                imagePicker.sourceType = .camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                present(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    @IBAction func recordvideo(_ sender: UIButton) {
    }
    
    // Play the video recorded for the app
    @IBAction func playVideo(_ sender: AnyObject) {
        print("Play a video")
        
        // Find the video in the app's document directory
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
        let dataPath = documentsDirectory.appendingPathComponent(saveFileName)
        print(dataPath.absoluteString)
        let videoAsset = (AVAsset(url: dataPath))
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        // Play the video
        let player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    // Any tasks you want to perform after recording a video
    @objc func videoWasSavedSuccessfully(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("An error happened while saving the video = \(theError)")
        } else {
            DispatchQueue.main.async(execute: { () -> Void in
                // What you want to happen
            })
        }
    }
    
    // MARK: UIImagePickerControllerDelegate delegate methods
    // Finished recording a video
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Got a video")
        
        if let pickedVideo:URL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            // Save video to the main photo album
            let selectorToCall = #selector(MusicViewController.videoWasSavedSuccessfully(_:didFinishSavingWithError:context:))
            UISaveVideoAtPathToSavedPhotosAlbum(pickedVideo.relativePath, self, selectorToCall, nil)
            
            // Save the video to the app directory so we can play it later
            let videoData = try? Data(contentsOf: pickedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent(saveFileName)
            try! videoData?.write(to: dataPath, options: [])
            print("Saved to " + dataPath.absoluteString)
        }
        
        imagePicker.dismiss(animated: true, completion: {
            // Anything you want to happen when the user saves an video
        })
    }
    
    // Called when the user selects cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User canceled image")
        dismiss(animated: true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    
    // MARK: Utility methods for app
    // Utility method to display an alert to the user.
    func postAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

    
//    static var audioPlayer = AVAudioPlayer();
//    let captureSession = AVCaptureSession()
//    var currentDevice: AVCaptureDevice?
//    var videoFileOutput: AVCaptureMovieFileOutput?
//    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
//    struct GlobalVariable {
//        static var audioPlayer = AVAudioPlayer();
//        let captureSession = AVCaptureSession()
//        var currentDevice: AVCaptureDevice?
//        var videoFileOutput: AVCaptureMovieFileOutput?
//        var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
//    }
    
    
    //music buttons!
    
//    @IBAction func play(_ sender: Any) {
//
//        print(songNumber2)
//
//        //player.rate = Float(songNumber2/100)
//        drum.play()
//
//       // player2.rate = Float(songNumber2/100)
//        guitar.play()
//    }
//
//    @IBAction func pause(_ sender: Any) {
//        drum.pause()
//        guitar.pause()
//    }
//
//
//    @IBAction func restart(_ sender: Any) {
//        drum.currentTime = 0
//        guitar.currentTime = 0
//        drum.play()
//        guitar.play()
//    }
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        do
//        {
//            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
//        }
//        catch
//        {
//            print("Can't Set Audio Session Category: \(error)")
//        }
//        AVAudioSession.CategoryOptions.mixWithOthers
//        do
//        {
//            try audioSession.setMode(AVAudioSession.Mode.videoRecording)
//        }
//        catch
//        {
//            print("Can't Set Audio Session Mode: \(error)")
//        }
//        // Start Session
//        do
//        {
//            try audioSession.setActive(true)
//        }
//        catch
//        {
//            print("Can't Start Audio Session: \(error)")
//        }
//
//
//        // Preset For 720p
//        captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
//
//        // Get Available Devices Capable Of Recording Video
//        let devices = AVCaptureDevice.devices(for: AVMediaType.video) as! [AVCaptureDevice]
//
//        // Get Back Camera
//        for device in devices
//        {
//            if device.position == AVCaptureDevice.Position.back
//            {
//                currentDevice = device
//            }
//        }
//        let camera = AVCaptureDevice.default(for: AVMediaType.video)
//
//        // Audio Input
//        let audioInputDevice = AVCaptureDevice.default(for: AVMediaType.audio)
//        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
//
//        do
//        {
//            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
//
//            // Add Audio Input
//            if captureSession.canAddInput(audioInput)
//            {
//                captureSession.addInput(audioInput)
//            }
//            else
//            {
//                NSLog("Can't Add Audio Input")
//            }
//        }
//        catch let error
//        {
//            NSLog("Error Getting Input Device: \(error)")
//        }
//
//        // Video Input
//        let videoInput: AVCaptureDeviceInput
//        do
//        {
//
//            videoInput = try AVCaptureDeviceInput(device: camera ?? <#default value#>)
//
//            // Add Video Input
//            if captureSession.canAddInput(videoInput)
//            {
//                captureSession.addInput(videoInput)
//            }
//            else
//            {
//                NSLog("ERROR: Can't add video input")
//            }
//        }
//        catch let error
//        {
//            NSLog("ERROR: Getting input device: \(error)")
//        }
//
//        // Video Output
//        videoFileOutput = AVCaptureMovieFileOutput()
//        captureSession.addOutput(videoFileOutput)
//
//        // Show Camera Preview
//        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        view.layer.addSublayer(cameraPreviewLayer!)
//        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        let width = view.bounds.width
//        cameraPreviewLayer?.frame = CGRect(0, 0, width, width)
//
//        // Bring Record Button To Front & Start Session
////        view.bringSubviewToFront(recordButton)
//        captureSession.startRunning()
//        print(captureSession.inputs)
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {

//        do {
//            if let fileURL = Bundle.main.path(forResource: "drum", ofType: "mp3") {
//                drum = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
//                drum.enableRate = true
//            } else {
//                print("No file with specified name exists")
//            }
//        } catch let error {
//            print("Can't play the audio file failed with an error \(error.localizedDescription)")
//        }
//
//        do {
//            if let fileURL = Bundle.main.path(forResource: "guitar", ofType: "mp3") {
//                guitar = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
//                guitar.enableRate = true
//            } else {
//                print("No file with specified name exists")
//            }
//        } catch let error {
//            print("Can't play the audio file failed with an error \(error.localizedDescription)")
////        }
//    }
//}
