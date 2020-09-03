//
//  VideoViewController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/4/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var videoURL: URL
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    let saveButton = UIButton(frame: CGRect(x: 85, y: 40, width: 30.0, height: 30.0))
    var saved = false
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChild(playerController!)
        self.view.addSubview(playerController!.view)
        
        playerController!.view.frame = view.bounds
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        let btnimg = UIImage(named: "x-white")!
        let savebtn = UIImage(named: "save-white")!
                
        let cancelButton = UIButton(frame: CGRect(x: 20, y: 40, width: 30.0, height: 30.0))
        cancelButton.setImage(btnimg, for: UIControl.State())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
     
        saveButton.setImage(savebtn, for: UIControl.State())
        saveButton.addTarget(self, action: #selector(saveBtn), for: .touchUpInside)
        view.addSubview(saveButton)
        
        // Allow background audio to continue to play
        do {
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: [])
            } else {
            }
        } catch let error as NSError {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveBtn() {
        if(saved == false) {
        UISaveVideoAtPathToSavedPhotosAlbum("\(videoURL.path)", self, nil, nil)
        let saveCheck = UIImage(named: "check-white")!
            // Screen width.
            var screenWidth: CGFloat {
                return UIScreen.main.bounds.width
            }
        self.saveButton.setImage(saveCheck, for: UIControl.State())
             let rect = CGRect(x: 0, y: 100, width: screenWidth, height: 70)
            let view = UIView(frame: rect)
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 96/255, blue: 47/255, alpha: 100)
            self.view.addSubview(view)

            let label = UILabel(frame: CGRect(x: 0, y: 100, width: screenWidth, height: 70))
            label.textAlignment = .center
            label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
            label.text = "Share on social media using #WooofThemeSong."
             label.numberOfLines = 0
            label.textColor = .white
            self.view.addSubview(label)
        saved = true
        }
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: CMTime.zero)
            self.player!.play()
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}
