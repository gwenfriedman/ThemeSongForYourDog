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
    
    struct GlobalVariable {
        static var dogName = String();
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
