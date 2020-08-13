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
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func startButton(_ sender: Any) {
        if (textField.text != "") {
            GlobalVariable.dogName = textField.text!
            }
        if(GlobalVariable.dogName == "") {
            GlobalVariable.dogName = "your dog"
        }
    }
        
    struct GlobalVariable {
        static var dogName: String = ""
        static var AVFileDone: Bool = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Screen width.
//        var screenWidth: CGFloat {
//            return UIScreen.main.bounds.width
//        }
//
//        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: 70)
//        let view = UIView(frame: rect)
//        view.backgroundColor = UIColor(displayP3Red: 241/255, green: 96/255, blue: 47/255, alpha: 100)
//        self.view.addSubview(view)
//
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 70))
//        label.textAlignment = .center
//        label.text = "Wooof"
//        label.textColor = .white
//        self.view.addSubview(label)
//
        textField.delegate = self
        
        self.submitBtn.isHidden = true
        
        let exportPath: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path+"/dog-theme-song.m4a"

        do {
               print("remove song")
           try FileManager.default.removeItem(atPath: exportPath)
           }
           catch {print("no song")}
    }
}

//makes the return button close the keyboard
extension NameViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.submitBtn.isHidden = false
        
        self.view.endEditing(true)
        return true
    }
}
