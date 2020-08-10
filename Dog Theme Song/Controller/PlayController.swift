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
    
    let bg = Sound(fileName: "metro.mp3")
    var player: AVAudioPlayer?
    
    @IBAction func recordBtn(_ sender: Any) {
        bg.stop()
        player!.stop()
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        bg.pause()
        player!.pause()
    }
    
    @IBAction func restartBtn(_ sender: Any) {
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        
        bg.restart()
        bg.play()
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
    
    player!.play()
    bg.play()

    }
    
func createSound(soundFiles: [String], outputFile: String) {
    var startTime: CMTime = CMTime.zero
    let composition: AVMutableComposition = AVMutableComposition()
        let compositionAudioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

        for n in 0...8 {
            let sound: String = Bundle.main.path(forResource: ViewController.GlobalVariable.songList[n], ofType: "mp3")!
            let url: URL = URL(fileURLWithPath: sound)
            let avAsset: AVURLAsset = AVURLAsset(url: url)
            let timeRange: CMTimeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(avAsset.duration, CMTimeMake(value: -3000,timescale: 44100)))
            
            let audioTrack: AVAssetTrack = avAsset.tracks(withMediaType: AVMediaType.audio)[0]
            
            try! compositionAudioTrack.insertTimeRange(timeRange, of: audioTrack, at: startTime)
                    
            startTime = CMTimeAdd(startTime, timeRange.duration)
        }
        let exportPath: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path+"/"+outputFile+".m4a"
        
        do {
        try FileManager.default.removeItem(atPath: exportPath)
        }
        catch {print("no song")}
    
        

        let export: AVAssetExportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        
        export.outputURL = URL(fileURLWithPath: exportPath)
        export.outputFileType = AVFileType.m4a

        export.exportAsynchronously {
            if export.status == AVAssetExportSession.Status.completed {
        NSLog("All done");
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsURL.appendingPathComponent("dog-theme-song.m4a")
        
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
        
                player.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
        
        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
            }
}
