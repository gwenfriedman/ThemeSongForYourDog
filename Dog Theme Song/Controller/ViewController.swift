//
//  ViewController.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/15/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionNumber: UILabel!
    
    //outlet for buttons
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    var allQuestions = QuestionBank()
    
    var questionNumber: Int = 0
    
    var selectedAnswer: Int = 0
    
    struct GlobalVariable {
        static var songList: [String] = ["0"]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Always adopt a light interface style.
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allQuestions = QuestionBank()
        updateQuestion()
    }
    
    
    //what happens when an answer is pressed
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            GlobalVariable.songList.append(String(allQuestions.list[questionNumber].val)+"a")
        }
        if sender.tag == 2 {
            GlobalVariable.songList.append(String(allQuestions.list[questionNumber].val)+"b")
        }
        if sender.tag == 3 {
            GlobalVariable.songList.append(String(allQuestions.list[questionNumber].val)+"c")
        }
        if sender.tag == 4 {
            GlobalVariable.songList.append(String(allQuestions.list[questionNumber].val)+"d")
        }
        
        questionNumber += 1
        
        //update the question after answering
        updateQuestion()
    }
    
    
    //updates the question from the question bank
    func updateQuestion() {
        
        if questionNumber <= allQuestions.list.count - 1{
            
            QuestionLabel.text = allQuestions.list[questionNumber].question
            QuestionNumber.text = String(questionNumber + 1) + "/9"
            optionA.setTitle(allQuestions.list[questionNumber].optionA , for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB , for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC , for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD , for: UIControl.State.normal)
            
        }else {
            
            self.performSegue(withIdentifier: "playSong", sender: self)
        }
    }
}

