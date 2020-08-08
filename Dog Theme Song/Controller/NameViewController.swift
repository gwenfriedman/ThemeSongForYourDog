//
//  NameViewController.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/16/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    
    //name entry
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func startButton(_ sender: Any) {
        if (textField.text != "") {
            
            GlobalVariable.dogName = textField.text!
            
           print(GlobalVariable.dogName)
        }
    }
    
    @IBAction func maleButton(_ sender: Any) {
        GlobalVariable.gender = "his"
        GlobalVariable.gender2 = "he's"
    }
    
    @IBAction func femaleButton(button: UIButton) {
        GlobalVariable.gender = "her"
        GlobalVariable.gender2 = "she's"
        
        //todo: this will turn it red but will not switch it when male is clicked. Need radio button
        button.setTitleColor(UIColor(red: 241/255, green: 96/255, blue: 47/255, alpha: 1.0), for: .normal)
    }
    
    struct GlobalVariable {
        static var dogName = "your dog"
        static var gender = "its"
        static var gender2 = "it's"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

//makes the return button close the keyboard
extension NameViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
