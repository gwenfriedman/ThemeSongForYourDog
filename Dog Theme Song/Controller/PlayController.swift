//
//  PlayController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/8/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit

class PlayController: UIViewController {
    
    let bg = Sound(fileName: "metro.mp3")
    
    var songQueue = SoundsQueue(sounds: [])
    

    
    @IBAction func recordBtn(_ sender: Any) {
        bg.stop()
        songQueue.stop()
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        bg.pause()
        songQueue.pause()
    }

@IBAction func playButton(_ sender: Any) {
            
       var songs: [Sound] = []
       for n in 0...8 {
           songs.append(Sound(fileName: ViewController.GlobalVariable.songList[n]))
       }

       let songQueue = SoundsQueue(sounds: songs)
       songQueue.play()
        
       bg.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
