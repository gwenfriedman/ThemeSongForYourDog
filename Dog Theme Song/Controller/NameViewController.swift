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
        
        let exportPath: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path+"/dog-theme-song.m4a"

        do {
               print("remove song")
           try FileManager.default.removeItem(atPath: exportPath)
           }
           catch {print("no song")}
        
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
