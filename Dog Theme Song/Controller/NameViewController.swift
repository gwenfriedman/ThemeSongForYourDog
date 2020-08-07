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
    
    @IBAction func femaleButton(_ sender: Any) {
        GlobalVariable.gender = "her"
        GlobalVariable.gender2 = "she's"
    }
    
    struct GlobalVariable {
        static var dogName = String()
        static var gender = String()
        static var gender2 = String()
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
