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
        
        // Always adopt a light interface style.
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        // Screen width.
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: 95)
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor(displayP3Red: 241/255, green: 96/255, blue: 47/255, alpha: 100)
        self.view.addSubview(view)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 115))
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        label.text = "Howlerr"
        label.textColor = .white
        self.view.addSubview(label)
        
        let imageName = "22-22.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 15, y: 30, width: 65, height: 65)
        view.addSubview(imageView)
        
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
