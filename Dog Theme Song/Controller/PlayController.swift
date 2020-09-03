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

class PlayController: UIViewController,AVAudioPlayerDelegate {
    
    var bg: AVAudioPlayer?
    
    var player: AVAudioPlayer?
    
    var vSpinner: UIView?
    
    var toggleState = 1
    
    var dogName2 = NameViewController.GlobalVariable.dogName
            
    @IBAction func recordBtn(_ sender: Any) {
        if bg != nil {
            bg!.stop()
        }
        if player != nil {
            player!.stop()
        }
    }
    
//    @IBAction func restartBtn(_ sender: Any) {
//        do {
//           try AVAudioSession.sharedInstance().setCategory(.playback)
//        } catch(let error) {
//            print(error.localizedDescription)
//        }
//
//        bg!.pause()
//        bg!.currentTime = 0
//        bg!.play()
//        player!.pause()
//        player!.currentTime = 0
//        player!.play()
//    }


public func createSound(soundFiles: [String], outputFile: String) {
    var startTime: CMTime = CMTime.zero
    let composition: AVMutableComposition = AVMutableComposition()
        let compositionAudioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

        for n in 0...8 {
            let sound: String = Bundle.main.path(forResource: ViewController.GlobalVariable.songList[n], ofType: "mp3")!
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
                NameViewController.GlobalVariable.AVFileDone = true
        }
        }
    
    while NameViewController.GlobalVariable.AVFileDone == false {
            }
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
    
    @objc func playSong(_ sender: Any) {
            var playBtn = sender as! UIButton
        if toggleState == 1 {
            do {
               try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            
            player!.enableRate = true
            bg!.enableRate = true
            
            if (ViewController.GlobalVariable.songList[9] == "9a") {
                player!.rate = 1.2
                bg!.rate = 1.2
            }

            if (ViewController.GlobalVariable.songList[9] == "9c") {
                player!.rate = 0.95
                bg!.rate = 0.95
            }
            if (ViewController.GlobalVariable.songList[9] == "9d") {
                player!.rate = 0.9
                bg!.rate = 0.9
            }
            player!.play()
            bg!.play()
            
            toggleState = 2
            playBtn.setImage(UIImage(named:"pause-white.png"),for:UIControl.State.normal)
        } else if (toggleState == 2){
            player!.pause()
            bg!.pause()
            toggleState = 1
            playBtn.setImage(UIImage(named:"play-white.png"),for:UIControl.State.normal)
        } else if (toggleState == 3) {
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
            playBtn.setImage(UIImage(named:"restart-white.png"),for:UIControl.State.normal)
            toggleState = 2
            }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        print(flag)
        print("here")
        if flag == true{
            toggleState = 3
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Screen width.
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }

        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor(displayP3Red: 241/255, green: 96/255, blue: 47/255, alpha: 100)
        self.view.addSubview(view)

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 115))
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        label.text = " \(dogName2)'s Theme Song"
        label.textColor = .white
        self.view.addSubview(label)
        
        let btnimg = UIImage(named: "play-white")!
        
        let centered = (screenWidth / 2) - 50
                
        let playButton = UIButton(frame: CGRect(x: centered, y: 85, width: 100, height: 100))
        playButton.setImage(btnimg, for: UIControl.State())
        playButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        view.addSubview(playButton)
        
             
        if(NameViewController.GlobalVariable.AVFileDone == false) {
        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
        
        createSpinnerView()
        }
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsURL.appendingPathComponent("dog-theme-song.m4a")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                guard let player = self.player else { return }
        
                player.prepareToPlay()
                player.delegate = self
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
            }
}
