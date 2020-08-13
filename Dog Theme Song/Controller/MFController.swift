//
//  NameViewController.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/16/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import UIKit

class MFController: UIViewController, SSRadioButtonControllerDelegate {
                
    @IBAction func startButton(_ sender: Any) {
        if(GlobalVariable.gender == "") {
            GlobalVariable.gender = "its"
        }
        if(GlobalVariable.gender2 == "") {
            GlobalVariable.gender2 = "it's"
        }
    }
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    @IBOutlet weak var maleBtn: UIButton!
    
    
    @IBOutlet weak var submitBtn: UIButton!

    
    var radioButtonController: SSRadioButtonsController?
    
    struct GlobalVariable {
        static var gender: String = ""
        static var gender2: String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitBtn.isHidden = true
        
        radioButtonController = SSRadioButtonsController(buttons: maleBtn, femaleBtn)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    }
    
    func didSelectButton(selectedButton: UIButton?) {

        if (radioButtonController!.selectedButton() == maleBtn) {
            GlobalVariable.gender = "his"
            GlobalVariable.gender2 = "he's"
        }
        if (radioButtonController!.selectedButton() == femaleBtn) {
            GlobalVariable.gender = "her"
            GlobalVariable.gender2 = "she's"
        }
            self.submitBtn.isHidden = false
    }
}
