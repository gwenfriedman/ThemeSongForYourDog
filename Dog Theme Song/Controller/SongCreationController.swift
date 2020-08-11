//
//  SongCreationController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/10/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit
import CoreMedia
import AVFoundation

class SongCreationController: UIViewController {
    
    var bg: AVAudioPlayer?
    
    var player: AVAudioPlayer?
    
    var AVFileDone: Bool = false

    @IBOutlet weak var songReady: UIButton!

public func createSound(soundFiles: [String], outputFile: String) {
    var startTime: CMTime = CMTime.zero
    let composition: AVMutableComposition = AVMutableComposition()
        let compositionAudioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

    for n in 0...8 {
            let sound: String = Bundle.main.path(forResource: ViewController.GlobalVariable.songList[n], ofType: "mp3")!
            print(sound)
            let url: URL = URL(fileURLWithPath: sound)
            let avAsset: AVURLAsset = AVURLAsset(url: url)
        let timeRange: CMTimeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(avAsset.duration, CMTimeMake(value: -2500,timescale: 44100)))
            
            let audioTrack: AVAssetTrack = avAsset.tracks(withMediaType: AVMediaType.audio)[0]
            
            try! compositionAudioTrack.insertTimeRange(timeRange, of: audioTrack, at: startTime)
                    
            startTime = CMTimeAdd(startTime, timeRange.duration)
        }
        let exportPath: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path+"/"+outputFile+".m4a"
    
        let export: AVAssetExportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        
        export.outputURL = URL(fileURLWithPath: exportPath)
        export.outputFileType = AVFileType.m4a

        export.exportAsynchronously {
            if export.status == AVAssetExportSession.Status.completed {
                print("all done")
                self.AVFileDone = true
        }
        }
    
        while AVFileDone == false {
//            createSpinnerView()
        }
    self.songReady.isHidden = false
    
            print("new page")
//    self.performSegue(withIdentifier: "goToSong", sender: self)
//        let newPC: PlayController = PlayController()
//            newPC.modalPresentationStyle = .fullScreen
//            self.present(newPC, animated: true, completion: nil)
    
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSpinnerView()

        
        print("create sound")
        print(AVFileDone)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createSpinnerView()

        
        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
        
           print(AVFileDone)
    }
}


