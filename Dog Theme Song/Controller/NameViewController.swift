//
//  NameViewController.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/16/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import UIKit

class NameViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    //name entry
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func startButton(_ sender: Any) {
        if (textField.text != "") {
            
            GlobalVariable.dogName = textField.text!
            
           print(GlobalVariable.dogName)
        }
    }
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    
    struct GlobalVariable {
        static var dogName = "your dog"
        static var gender = "its"
        static var gender2 = "it's"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: maleBtn, femaleBtn)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        // Do any additional setup after loading the view.
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
    }
}

//makes the return button close the keyboard
extension NameViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
