//
//  PlayController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/8/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit
import CoreMedia
import AVFoundation

class PlayController: UIViewController {
    
    var bg: AVAudioPlayer?
    
    var player: AVAudioPlayer?
    
    var vSpinner: UIView?
    
    var AVFileDone: Bool = false
    
    @IBAction func recordBtn(_ sender: Any) {
        bg!.stop()
        player!.stop()
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        bg!.pause()
        player!.pause()
    }
    
    @IBAction func restartBtn(_ sender: Any) {
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        bg!.pause()
        bg!.currentTime = 0
        bg!.play()
        player!.pause()
        player!.currentTime = 0
        player!.play()
    }

@IBAction func playButton(_ sender: Any) {
    
    do {
       try AVAudioSession.sharedInstance().setCategory(.playback)
    } catch(let error) {
        print(error.localizedDescription)
    }
    
    print(ViewController.GlobalVariable.songList)
    
//    if (ViewController.GlobalVariable.songList[8] == "9a") {
//        print("speed up")
//            player!.rate = 2.0
//            bg!.rate = 2.0
//    }
    
    player!.play()
    bg!.play()

    }
    
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
        // show spinner
    }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsURL.appendingPathComponent("dog-theme-song.m4a")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                guard let player = self.player else { return }
        
                player.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
        }
        
        let lyrics = Bundle.main.path(forResource: "R2", ofType: "mp3")
            do {
                bg = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: lyrics!))
                guard let bg = bg else { return }
        
                bg.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
        
        let exportPath: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path+"/dog-theme-song.m4a"
        
//        do {
//            print("remove song")
//        try FileManager.default.removeItem(atPath: exportPath)
//        }
//        catch {print("no song")}
        
//        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
            }
}
