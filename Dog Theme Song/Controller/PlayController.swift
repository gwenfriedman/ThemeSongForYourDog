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
    
    struct GlobalVariable {
         static var bg: AVAudioPlayer?
         static var player: AVAudioPlayer?
     }
    
    var vSpinner: UIView?
    
    var toggleState = 1
    
    var dogName2 = NameViewController.GlobalVariable.dogName
    
    var playButton: UIButton?
            
    @IBAction func recordBtn(_ sender: Any) {
        if GlobalVariable.bg != nil {
            GlobalVariable.bg!.stop()
            GlobalVariable.bg!.currentTime = 0
        }
        if GlobalVariable.player != nil {
            GlobalVariable.player!.stop()
            GlobalVariable.player!.currentTime = 0
        }
    }
    
    @IBAction func startOverBtn(_ sender: Any) {
        if GlobalVariable.bg != nil {
            GlobalVariable.bg!.stop()
        }
        if GlobalVariable.player != nil {
            GlobalVariable.player!.stop()
        }
        NameViewController.GlobalVariable.AVFileDone = false
        ViewController.GlobalVariable.songList = ["0"]
    }

public func createSound(soundFiles: [String], outputFile: String) {
    print(soundFiles)
    var startTime: CMTime = CMTime.zero
    let composition: AVMutableComposition = AVMutableComposition()
        let compositionAudioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

        for n in 0...8 {
            print(ViewController.GlobalVariable.songList[n])
            let sound: String = Bundle.main.path(forResource: ViewController.GlobalVariable.songList[n], ofType: "mp3")!
            let url: URL = URL(fileURLWithPath: sound)
            let avAsset: AVURLAsset = AVURLAsset(url: url)
            let timeRange: CMTimeRange = CMTimeRangeMake(start: CMTime.zero, duration:
                CMTimeAdd(avAsset.duration, CMTimeMake(value: -2600,timescale: 44100)))
            
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
    
    @objc func playSong(_ sender: Any, ts: Int) {
            var playBtn = sender as! UIButton
        if toggleState == 1 {
            do {
               try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            
            GlobalVariable.player!.play()
            GlobalVariable.bg!.play()
            
            toggleState = 2
            playBtn.setImage(UIImage(named:"pause-white.png"),for:UIControl.State.normal)
        } else if (toggleState == 2){
            GlobalVariable.player!.pause()
            GlobalVariable.bg!.pause()
            toggleState = 1
            playBtn.setImage(UIImage(named:"play-white.png"),for:UIControl.State.normal)
        }
        else if (toggleState == 3) {
                do {
                   try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch(let error) {
                    print(error.localizedDescription)
                }

                GlobalVariable.bg!.pause()
                GlobalVariable.bg!.currentTime = 0
                GlobalVariable.bg!.play()
                GlobalVariable.player!.pause()
                GlobalVariable.player!.currentTime = 0
                GlobalVariable.player!.play()
            playBtn.setImage(UIImage(named:"pause-white.png"),for:UIControl.State.normal)
            toggleState = 2
            }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        print(flag)
        if flag == true{
            toggleState = 3
            self.playButton?.setImage(UIImage(named:"restart-white.png"),for:UIControl.State.normal)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Screen width.
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }

        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: 210)
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor(displayP3Red: 241/255, green: 96/255, blue: 47/255, alpha: 100)
        self.view.addSubview(view)

        let label = UILabel(frame: CGRect(x: 0, y: 15, width: screenWidth, height: 115))
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        label.text = " \(dogName2)'s Theme Song"
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        let btnimg = UIImage(named: "play-white")!
        
        let centered = (screenWidth / 2) - 50
                
        playButton = UIButton(frame: CGRect(x: centered, y: 105, width: 100, height: 100))
        playButton!.setImage(btnimg, for: UIControl.State())
        playButton!.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        view.addSubview(playButton!)
        
        if(NameViewController.GlobalVariable.AVFileDone == false) {
        createSound(soundFiles: ViewController.GlobalVariable.songList, outputFile: "dog-theme-song")
        
        createSpinnerView()
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsURL.appendingPathComponent("dog-theme-song.m4a")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do {
                GlobalVariable.player = try AVAudioPlayer(contentsOf: url)
                guard let player = GlobalVariable.player else { print("no lyrics"); return }
        
                player.prepareToPlay()
                player.delegate = self
            } catch let error as NSError {
                print(error.description)
            }
        }
            var lyrics = ""
            
            if (ViewController.GlobalVariable.songList[9] == "9a") {
                lyrics = Bundle.main.path(forResource: "theme1", ofType: "mp3")!
            }
            
            if (ViewController.GlobalVariable.songList[9] == "9b") {
                lyrics = Bundle.main.path(forResource: "theme3", ofType: "mp3")!
            }
            
            if (ViewController.GlobalVariable.songList[9] == "9c") {
                lyrics = Bundle.main.path(forResource: "theme2", ofType: "mp3")!
            }
            
            if (ViewController.GlobalVariable.songList[9] == "9d") {
               lyrics = Bundle.main.path(forResource: "theme4", ofType: "mp3")!
           }
        
            do {
                GlobalVariable.bg = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: lyrics))
                guard let bg = GlobalVariable.bg else { return }
        
                bg.prepareToPlay()
            } catch let error as NSError {
                print(error.description)
            }
            }
    }
}
